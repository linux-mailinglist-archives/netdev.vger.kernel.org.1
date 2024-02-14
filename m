Return-Path: <netdev+bounces-71582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647C98540D6
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 01:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2157D282888
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EBD191;
	Wed, 14 Feb 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6StatEA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105C7F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870466; cv=none; b=nveoBpYdPFN+DPmwUlbrsZmQnHXfvWexR0DqalbMzhsTdjmi/NNLA2kVeZM2eeNYgAH1PmdqTZqqfy6gbfkE2gojFlsflUJJfCkAiCMTzyPqvmGoGgkaEv6J5kXeIBGHbsGP9WWPgk5CpAYRcLmltYmmXGhmCwA+PvmxYpOTQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870466; c=relaxed/simple;
	bh=CSvUtuXMdRkdBk+XSx824yAzBgIv3ZFpXvHqgw0dvH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDVhLuzjL2GX8uKORhXgEAFnPjJJSyRWQI3CZ43o2tH37Q3AZQsR5y05BJV2UdqHI21Sjf8nV2cT8QdABp4zj5yRfQoucsWtkkXHzU3UTOleFLk4YT+qCzv+jEqGHjlgBMMsV6tthT5P2EGU//eBWdq5YJSSNzx5I8sZ9ZL9aPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6StatEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B40AC433C7;
	Wed, 14 Feb 2024 00:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707870465;
	bh=CSvUtuXMdRkdBk+XSx824yAzBgIv3ZFpXvHqgw0dvH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6StatEAs6oVSFIHF13ta/O5fgTnNa+ZV9bgqSB6qyMk8ALHb1nRWyZ+JJXKUdKmJ
	 syvNHT27Ca3D1cZe88/0ht+CffPTjJUO/aFLPGTDD9XDiCNWZlRdwLxvVglIe/lhAB
	 xSYrZsaolN/Axhsdx/Ay0axqMCQBXiOciTlow4wFuawCvw5MdMPCz7jVI3VvVYOVuH
	 /zh0Pie8OG7pDF2vzBmT2gcLuHeGq9sizMEppf7V+iNaOlfiFN0g3+i45QrZv0X8nb
	 7nn2EjtovXB7+gWqRkFvNkjstZDZ1ACxVgFDyeCzXPXaxbctA2gdDfJZTWIwwSbBD1
	 oAaTILek6D6pg==
Date: Tue, 13 Feb 2024 16:27:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Davide Caratti <dcaratti@redhat.com>,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, shmulik.ladkani@gmail.com,
 victor@mojatatu.com
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred
 ingress
Message-ID: <20240213162744.6dcd6667@kernel.org>
In-Reply-To: <93a346087193c57f4df807c478d0f7fc8e7db6aa.camel@redhat.com>
References: <20240209235413.3717039-1-kuba@kernel.org>
	<CAM0EoM=kcqwC1fYhHcPoLgNMrM_7tnjucNvri8f4U7ymaRXmEQ@mail.gmail.com>
	<CAM0EoMnYyyf7Zpa9eUFBU1vzx5QrUhFfXSFH4_utXOPU4+YFxQ@mail.gmail.com>
	<93a346087193c57f4df807c478d0f7fc8e7db6aa.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 12:06:04 +0100 Paolo Abeni wrote:
> > Something broke.
> > Create a ns. Put one half of veth into the namespace. Create a filter
> > inside the net ns.
> > at_ns$ tc qdisc add dev port0 ingress_block 21 clsact
> > at_ns$ tc filter add block 21 egress protocol ip prio 10 matchall
> > action mirred ingress redirect dev port0
> > 
> > Send a ping from host:
> > at_host@ ping 10.0.0.2 -c 1 -I <vethportonhostside>
> > 
> > And.. hits uaf.... see attached.  
> 
> It looks like:
> 
> netif_receive_skb
> run_tc()
> 	act_mirred	
> 		netif_receive_skb
> 			sch_handle_ingress
> 				act_mirred // nesting limit hit
> 			// free skb
> 		// netif_receive_skb returns NET_RX_DROP
> 	// act_mirred returns TC_ACT_SHOT
> // UaF while de-referencing the (freed) skb
> 
> 
> No idea how to solve it on top of my mind :(

If I'm looking right the bug seems fairly straightforward but tricky 
to cleanly fix :( I also haven't dug deep enough in the history to
be provide a real Fixes tag...

--->8-------------
net/sched: act_mirred: don't override retval if we already lost the skb

If we're redirecting the skb, and haven't called tcf_mirred_forward(),
yet, we need to tell the core to drop the skb by setting the retcode
to SHOT. If we have called tcf_mirred_forward(), however, the skb
is out of our hands and returning SHOT will lead to UaF.

Move the overrides up to the error paths which actually need them.
Note that the err variable is only used to store return code from
tcf_mirred_forward() and we don't have to set it.

Fixes: 16085e48cb48 ("net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/act_mirred.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 93a96e9d8d90..922a018329cd 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -270,7 +270,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
-		err = -ENODEV;
+		if (is_redirect)
+			retval = TC_ACT_SHOT;
 		goto out;
 	}
 
@@ -284,7 +285,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	if (!dont_clone) {
 		skb_to_send = skb_clone(skb, GFP_ATOMIC);
 		if (!skb_to_send) {
-			err =  -ENOMEM;
+			if (is_redirect)
+				retval = TC_ACT_SHOT;
 			goto out;
 		}
 	}
@@ -327,8 +329,6 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	if (err) {
 out:
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (is_redirect)
-			retval = TC_ACT_SHOT;
 	}
 
 	return retval;
-- 
2.43.0


