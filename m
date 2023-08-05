Return-Path: <netdev+bounces-24605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67964770CCD
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 02:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EDD1C215C1
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195517E2;
	Sat,  5 Aug 2023 00:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C4622
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 00:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B7DC433C7;
	Sat,  5 Aug 2023 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691197022;
	bh=R11BsqXSVi4wUiZMEOD+B5oPYL6Hoa/QtR76MRpQdPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNyPckaj6Xfs59VP9W+BxQt8XDvbRSHL1DA/MM+IzkQ4Y7gWtOOEx8pO81ml3VE8h
	 LpCQUXtROEGRadxtrvLLVRiB4Fm+ypTvysCA/AHkV0E+TUDQ4Htbv7IHpVRHDWnAQI
	 EjQ9V4r32ddBXRXIcyAkVmbZNoREIHET0m+psPUudGZMv2cM/ZkHUyRIhBBptIsWxk
	 nLB+5Ir0N2EN0Eq/uHsl0VWorzAHb3ymBtnK3SyPvwmRUX/zQUAHzNKemUmcKbXJoI
	 QwKQsHMyqBTMMHRy4xx1+s9G9VojQNpwH21ycRv+MsFIxXZoKvTf1MetNG/5xXUJPV
	 HzseGUOu5gR3w==
Date: Fri, 4 Aug 2023 17:57:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net/tls: avoid TCP window full during ->read_sock()
Message-ID: <20230804175700.1f88604b@kernel.org>
In-Reply-To: <20230803100809.29864-1-hare@suse.de>
References: <20230803100809.29864-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Aug 2023 12:08:09 +0200 Hannes Reinecke wrote:
> When flushing the backlog after decoding each record in ->read_sock()
> we may end up with really long records, causing a TCP window full as
> the TCP window would only be increased again after we process the
> record. So we should rather process the record first to allow the
> TCP window to be increased again before flushing the backlog.

> -			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
> -							  decrypted, &flushed_at);
>  			skb = darg.skb;
> +			/* TLS 1.3 may have updated the length by more than overhead */

> +			rxm = strp_msg(skb);
> +			tlm = tls_msg(skb);
>  			decrypted += rxm->full_len;
>  
>  			tls_rx_rec_done(ctx);
> @@ -2280,6 +2275,12 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			goto read_sock_requeue;
>  		}
>  		copied += used;
> +		/*
> +		 * flush backlog after processing the TLS record, otherwise we might
> +		 * end up with really large records and triggering a TCP window full.
> +		 */
> +		released = tls_read_flush_backlog(sk, prot, decrypted - copied, decrypted,
> +						  copied, &flushed_at);

I'm surprised moving the flushing out makes a difference.
rx_list should generally hold at most 1 skb (16kB) unless something 
is PEEKing the data.

Looking at it closer I think the problem may be calling args to
tls_read_flush_backlog(). Since we don't know how much data
reader wants we can't sensibly evaluate the first condition,
so how would it work if instead of this patch we did:

-			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
+			released = tls_read_flush_backlog(sk, prot, INT_MAX, 0,
							  decrypted, &flushed_at);

That would give us a flush every 128k of data (or every record if
inq is shorter than 16kB).

side note - I still prefer 80 char max lines, please. It seems to result
in prettier code ovarall as it forces people to think more about code
structure.

>  		if (used < rxm->full_len) {
>  			rxm->offset += used;
>  			rxm->full_len -= used;
-- 
pw-bot: cr

