Return-Path: <netdev+bounces-207185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F99B061F9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E0F7A1FC2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1C71FC7E7;
	Tue, 15 Jul 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpekveAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939711E1E16
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591282; cv=none; b=PHpu8ZWajag1Qxv6jhno3CBCGEjpDzyg7HXkURAfAFLOuQC90CQrMR5fzRewLXQlGZX2cOQqvrc/hHwZJaJla6TylJwdC/aqPiItbLHm5WrB47/oehivMF0D6ZfoBu8wX6m0TwfEeWBWm+T5qfRR5JGqyEvrpaaD/irmMBb0kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591282; c=relaxed/simple;
	bh=sEwCa9VGuDr46ftDRA2jmoIlVkQ6LDQi2GB4XPpdqec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV9UwvR/A6TwgQ3CWondSEuaqH+TuO7hIMSKugSPjzj3GSnykzbi8eLrGR99IenV1Mg9xjIgqS27LmW83qitEAGSGFYHaP3QmaNJ9dZnqxoUyF3EuXGnuXvIXwon73VliXfgZjdOKdyALVivp6Zyszisxq5GfRjTlPMUqHUQU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpekveAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D753C4CEE3;
	Tue, 15 Jul 2025 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591282;
	bh=sEwCa9VGuDr46ftDRA2jmoIlVkQ6LDQi2GB4XPpdqec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MpekveAvYT/RidK96ui2ylPPDOZOGUm4TTMhnyXGb/szNTeR+OZivWbovOhxpSsgu
	 C24Cd0qnc0V2bLpQfNnEBdQoiu/bR4kIMjvNokLXlk0jlHA6cjoI+IHy3cpSPs3cKT
	 K8HHLLSDqf0CljxhZCNWot9+hIKQzl4Vxc02B8ym1glmhC9S+xwGPGX12FYMwFdxsq
	 NRtm+czgZ9wbW2FCfFVHW/20zt7GRXvOeU5bDXUr4j+ZJdW84nhr2sKjedfaSthS7e
	 144LK3kdwP9G4/kI8txEJI+UEPF/mVMTkyEEQmzHtsUcuxvMVsd/fsM9yD/DueIJL7
	 bGKGo06L0pnPQ==
Date: Tue, 15 Jul 2025 07:54:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Matthieu Baerts
 <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
Message-ID: <20250715075440.49a35d7c@kernel.org>
In-Reply-To: <9fb159c3-0151-49ac-91bf-1be8301bdf18@redhat.com>
References: <20250711114006.480026-1-edumazet@google.com>
	<a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
	<d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
	<6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
	<20250715062829.0408857d@kernel.org>
	<20250715063314.43a993f9@kernel.org>
	<9fb159c3-0151-49ac-91bf-1be8301bdf18@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 15:52:33 +0200 Paolo Abeni wrote:
> On 7/15/25 3:33 PM, Jakub Kicinski wrote:
> > On Tue, 15 Jul 2025 06:28:29 -0700 Jakub Kicinski wrote:  
> >> # (null):17: error handling packet: timing error: expected outbound packet at 0.074144 sec but happened at -1752585909.757339 sec; tolerance 0.004000 sec
> >> # script packet:  0.074144 S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
> >> # actual packet: -1752585909.757339 S.0 0:0(0) ack 1 <mss 1460,nop,wscale 0>  
> > 
> > This is definitely compiler related, I rebuilt with clang and the build
> > error goes away. Now I get a more sane failure:
> > 
> > # tcp_rcv_big_endseq.pkt:41: error handling packet: timing error: expected outbound packet at 1.230105 sec but happened at 1.190101 sec; tolerance 0.005046 sec
> > # script packet:  1.230105 . 1:1(0) ack 54001 win 0 
> > # actual packet:  1.190101 . 1:1(0) ack 54001 win 0 
> > 
> > $ gcc --version
> > gcc (GCC) 15.1.1 20250521 (Red Hat 15.1.1-2)
> > 
> > I don't understand why the ack is supposed to be delayed, should we
> > just do this? (I think Eric is OOO, FWIW)
> > 
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> > index 7e170b94fd36..3848b419e68c 100644
> > --- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> > @@ -38,7 +38,7 @@
> >  
> >  // If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
> >    +0 < P. 4001:54001(50000) ack 1 win 257
> > -  +.040 > .  1:1(0) ack 54001 win 0
> > +  +0 > .  1:1(0) ack 54001 win 0
> >  
> >  // Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
> >  +0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`  
> 
> The above looks sane to me, but I Neal or Willem ack would be appreciated.

Posted officially here to get it queued to the CI already:
https://lore.kernel.org/all/20250715142849.959444-1-kuba@kernel.org/

