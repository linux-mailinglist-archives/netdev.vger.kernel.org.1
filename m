Return-Path: <netdev+bounces-53272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE75801DEC
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E0F2810D1
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94271C29E;
	Sat,  2 Dec 2023 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN6ES8a4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5497493
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 17:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF781C433C9;
	Sat,  2 Dec 2023 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701537377;
	bh=53gQ5QPBeQ1+h1gAjauNWXZ/KuI17gL+1YoqsW1KWKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jN6ES8a4zqtEydvdGod1EVRG1C3ScEKJp/IsOzbHWP0SBqotp79X9MMxrYd7gC6fg
	 Fd9Vc6vdRLKd7mSwB7BCIJISaTlD9i3ExUF4QUCLuVDh39jnFN2aZmarB9MybBydWK
	 2FLLUZskyd+DSceIs2VdcX1cUIs6Io4ts4GVOpXMR6VmvIypBCl4pwMdrP6Jznp6pJ
	 k2lW2Mqt+o9CtAwG/JZUQtoVYQ53CCjtUDKMoclNfaanASzuWYgJdq1eWcspdm7pdT
	 BFAJl2KldMZfzxekSW6JEIaGZzdzbEZi6RFdQmn+IMyzI4xoAOYubgdHvI7kF8jART
	 1NXT0Q4YFHjsA==
Date: Sat, 2 Dec 2023 17:16:12 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Message-ID: <20231202171612.GC50400@kernel.org>
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129165721.337302-7-dima@arista.com>

On Wed, Nov 29, 2023 at 04:57:20PM +0000, Dmitry Safonov wrote:
> RFC 5925 (6.2):
> > TCP-AO emulates a 64-bit sequence number space by inferring when to
> > increment the high-order 32-bit portion (the SNE) based on
> > transitions in the low-order portion (the TCP sequence number).
> 
> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> Unfortunately, reading two 4-bytes pointers can't be performed
> atomically (without synchronization).
> 
> In order to avoid locks on TCP fastpath, let's just double-account for
> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
> 
> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

...

> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 647781080613..b8ef25d4b632 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -121,8 +121,8 @@ struct tcp_ao_info {
>  	 * - for time-wait sockets the basis is tw_rcv_nxt/tw_snd_nxt.
>  	 *   tw_snd_nxt is not expected to change, while tw_rcv_nxt may.
>  	 */
> -	u32			snd_sne;
> -	u32			rcv_sne;
> +	u64			snd_sne;
> +	u64			rcv_sne;
>  	refcount_t		refcnt;		/* Protects twsk destruction */
>  	struct rcu_head		rcu;
>  };

Hi Dmitry,

In tcp_ao.c:tcp_ao_connect_init() there is a local
variable:

        struct tcp_ao_info *ao_info;

And the following assignment occurs:

                ao_info->snd_sne = htonl(tp->write_seq);

Is this still correct in light of the change of the type of snd_sne?

Flagged by Sparse.

...

