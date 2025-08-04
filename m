Return-Path: <netdev+bounces-211631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A14B1AB8D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 01:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE30A189D970
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806C22E3FA;
	Mon,  4 Aug 2025 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXCd7ISh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E663143C69;
	Mon,  4 Aug 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754351518; cv=none; b=WlmwqmnbRE7P3eRwEFnNyaHmciZHTAYNP/zo4j/BtcTlX+8P0doqfRC91LpuG1OMLCSFzh/oQBv5ru3qdBJp/GoG45TPjvpcYXLSJeJNEuEQPN6uCe2w6fiPg1tSQqm2Bz4j5vFmi06HSWu4dEgf67RLa354kHrUsRtvSqEmXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754351518; c=relaxed/simple;
	bh=+Qd7Fdt/l1rSR28D0sLlYxSACJKkxlhjTi7Fv9O2uFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1VC+0QMRfwz4e/BcvXoevE12AgEdYJ1peZY5OKgjYDlJXpahn0rJzxZoFyJNdnuD+BqGQXxc4jhLpfghrswcTb0rCMJKTxvw3/kLAR/mQzG25TPqTDg8B5i56V5ZSrb4nApHsiI4555oATz+g1PQHk2rYX3EHVljuewi1A7TuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXCd7ISh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE45C4CEE7;
	Mon,  4 Aug 2025 23:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754351516;
	bh=+Qd7Fdt/l1rSR28D0sLlYxSACJKkxlhjTi7Fv9O2uFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KXCd7IShem+Z24ebKf2Zs0iF+XjNzIhkIh2/UXVNmGWt4nYTrOYq+vqHmLp6neMq6
	 kmfpnljs4grcGGefs1B06Z9UJ/CCBSEtdnj7U0U7FhrU4u0w69qQxa+gxqBOLmOUwJ
	 c9SyxIrbtT9bdMMZTw0Pg2VFwXkm7UuYobUgdA3RTMSLlL80O98N4musJgQakhgB6N
	 d0YpA+HBHBFGfcuazROyP9/fIJ/hPz3wAEASvJSuzLjhkvG0ImIbmByqjGA5/tu97I
	 PO58SmmmvdhGm+jPdVsvDYOgtHIFoi/QqG3NqwaHvy2S4GuXq2T98h4Y7OKqtMgs0x
	 ekQ4E4Im/6RKA==
Date: Mon, 4 Aug 2025 16:51:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, Tom Herbert
 <tom@herbertland.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] kcm: Fix splice support
Message-ID: <20250804165155.44a32242@kernel.org>
In-Reply-To: <b6a2219b-32dd-4bb6-b848-45325e4e4ab9@rbox.co>
References: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
	<20250730180215.2ad7df72@kernel.org>
	<b6a2219b-32dd-4bb6-b848-45325e4e4ab9@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Aug 2025 12:00:38 +0200 Michal Luczaj wrote:
> On 7/31/25 03:02, Jakub Kicinski wrote:
> > On Fri, 25 Jul 2025 12:33:04 +0200 Michal Luczaj wrote:  
> >> Flags passed in for splice() syscall should not end up in
> >> skb_recv_datagram(). As SPLICE_F_NONBLOCK == MSG_PEEK, kernel gets
> >> confused: skb isn't unlinked from a receive queue, while strp_msg::offset
> >> and strp_msg::full_len are updated.
> >>
> >> Unbreak the logic a bit more by mapping both O_NONBLOCK and
> >> SPLICE_F_NONBLOCK to MSG_DONTWAIT. This way we align with man splice(2) in
> >> regard to errno EAGAIN:
> >>
> >>    SPLICE_F_NONBLOCK was specified in flags or one of the file descriptors
> >>    had been marked as nonblocking (O_NONBLOCK), and the operation would
> >>    block.  
> > 
> > Coincidentally looks like we're not honoring
> > 
> > 	sock->file->f_flags & O_NONBLOCK 
> > 
> > in TLS..  
> 
> I'm a bit confused.
> 
> Comparing AF_UNIX and pure (non-TLS) TCP, I see two non-blocking-splice
> interpretations. Unix socket doesn't block on `f_flags & O_NONBLOCK ||
> flags & SPLICE_F_NONBLOCK` (which this patch follows), while TCP, after
> commit 42324c627043 ("net: splice() from tcp to pipe should take into
> account O_NONBLOCK"), honours O_NONBLOCK and ignores SPLICE_F_NONBLOCK.
> 
> Should KCM (and TLS) follow TCP behaviour instead?

I didn't look closely, but FWIW - yes, in principle KCM and TLS should
copy TCP.

