Return-Path: <netdev+bounces-140821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7799B85C2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C32D1C219B6
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C11CBE97;
	Thu, 31 Oct 2024 21:52:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E041B86E4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411572; cv=none; b=NA3AgsFqbLnbHiWXlIATUKqvL4DjGi4nt3+adTuK6jU4cydnPe0A+OIKNynWfAcODfyezTDiGu1jkacqp15M1mBo+StNf7ZwGEPfu3gf986x3MnY28nxV05Pf9o1XiCMmE9nStAL235WEJ6QYKeIm5vsfokx047r2DhygurvqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411572; c=relaxed/simple;
	bh=DIF5yMFIuUVzaWgiyduIS166EZzF5/AL8mzGWDH0hgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4LfrDhv0bB4uXC2qxp0Nf2uY6UBJl1aXa0gM3XAuDANpKQaR5vpTecGOUbZd33ouGTIrk3E7FIeE1bRfQmS3oHU8cl1Rsh09d2ulkZd7LrXK2AVtVDzvKy1COt6iEV6bAQsHSwNuHcZWEtqAS639r16FLMVAnuuCZn/UmtpqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t6d5v-0001Ip-51; Thu, 31 Oct 2024 22:52:43 +0100
Date: Thu, 31 Oct 2024 22:52:43 +0100
From: Florian Westphal <fw@strlen.de>
To: Austin Hendrix <namniart@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Duplicate invocation of NF_INET_POST_ROUTING rule for outbound
 multicast?
Message-ID: <20241031215243.GA4460@breakpoint.cc>
References: <CAL5mK8wsgqQCVt0jG7YjJz4E6YoPPs3tq7rrhhbsr=BDeJMVMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL5mK8wsgqQCVt0jG7YjJz4E6YoPPs3tq7rrhhbsr=BDeJMVMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Austin Hendrix <namniart@gmail.com> wrote:
> I've been staring at the linux source code for a while, and I think
> this part of ip_mc_output explains it.
> 
> if (sk_mc_loop(sk)
> #ifdef CONFIG_IP_MROUTE
> /* Small optimization: do not loopback not local frames,
>    which returned after forwarding; they will be  dropped
>    by ip_mr_input in any case.
>    Note, that local frames are looped back to be delivered
>    to local recipients.
> 
>    This check is duplicated in ip_mr_input at the moment.
> */
>     &&
>     ((rt->rt_flags & RTCF_LOCAL) ||
>      !(IPCB(skb)->flags & IPSKB_FORWARDED))
> #endif
>    ) {
> struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
> if (newskb)
> NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> net, sk, newskb, NULL, newskb->dev,
> ip_mc_finish_output);
> }
> 
> It looks like ip_mc_output duplicates outgoing multicast, sends the
> copy through POSTROUTING first (remember how the first copy didn't
> have UID and GID?), and then loops that copy back for local multicast
> listeners.
> 
> I haven't followed all of the details yet, but it looks like the copy
> that is looped back lacks the sk_buff attributes which identify the
> UID, GID and cgroup of the sender.

Yes, skb_clone'd skbs are not owned by any socket.

> Is my understanding of this correct? Is the netdev team willing to
> discuss possible solutions to this, or is this behavior "by design?"

Its for historic reasons, this is very old and predates cgroups.

You could try this (untested) patch, ipv6 would need similar treatment.
We'd probably also want to extend this to RTCF_BROADCAST, i.e. add
skb_clone_sk() or similar helper and then use that for these clones.

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -396,10 +396,16 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 #endif
 		   ) {
 			struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
-			if (newskb)
+			if (newskb) {
+				struct sock *skb_sk = skb->sk;
+
+				if (skb_sk)
+					skb_set_owner_edemux(newskb, skb_sk);
+
 				NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING,
 					net, sk, newskb, NULL, newskb->dev,
 					ip_mc_finish_output);
+			}
 		}
 
 		/* Multicasts with ttl 0 must not go beyond the host */

