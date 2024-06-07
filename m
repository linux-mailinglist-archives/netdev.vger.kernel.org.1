Return-Path: <netdev+bounces-101889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5590071B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A87284376
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3F19CD10;
	Fri,  7 Jun 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jKorOlBb"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1019B3C1
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771248; cv=none; b=Cc+CR9psHaucx3fZRhs8K5o01xEx4fV8t5bYDBNkscak7ClNqlByR26S7ZK4o7Q5F5l//m7ZnTre3UBBMeTAN0+2Y9l4S+jrCWOUGw4ueCQPdT/Qtint62Nf8AdsWHLDHPU8Abzu+hikMJxpYqHROIjT791JQuQf7dlpvU5TwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771248; c=relaxed/simple;
	bh=tMvx32liBAsbo3BHdxrAOT8YS16GICXyrVqXaTWCSP8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBCCDjH3sC+4ewiBkBTZjiJMsNNHrmmpV+eN6Qlg/6JdicQNVq5uh1Rze+ULDNxG+fF4XthIFQChM3Q7oGCSnOKfEUeM5UE3dKL6jYfKpwja6AReyOnmJaZdKCj45PtOMArfpYvcnwmAOBFtK7x6XnaZOl023ldUHtRGHC6GLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jKorOlBb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gENin/3ZcOVzeoBr/HK0BMTbeKFj4c8kV/7zRxRu7EE=;
	t=1717771246; x=1718980846; b=jKorOlBbEu3YRN68sD7wbBlgIsZY6scjxZeGIiUZGKsA8hl
	TeFU/FRbkWkaN28cOWCh7Mor/MIHjBwWdGYW/hot0t7dvCXMkFWYIdcjxMbOSV3HH/J4PUmX+Fc42
	3CZ8AHYEOTNPHEDvdKYAtqj101FFd19Gz2XHfeS+C3Fp8VgMyRQQvP4P1X03CF0KSxhvbBG/hpVc7
	mh/QL0oodljN2D2WsB+mbkFtJyuAhbD0RPsV4Y2J+KtdZB1Tefa1QeZkuyObsTMbgBAkle43KGOIb
	/M/DhzwLYRq8IRq3Gz+CZBq79gO2eCwO8ugfCYp9mhtcWemTeGyuA6Dy0mfU9O2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFali-00000001DVl-2SCJ;
	Fri, 07 Jun 2024 16:40:38 +0200
Message-ID: <127148e766b177a470a397d9c1615fae19934141.camel@sipsolutions.net>
Subject: Re: [PATCH net] net/sched: Fix mirred deadlock on device recursion
From: Johannes Berg <johannes@sipsolutions.net>
To: Victor Nogueira <victor@mojatatu.com>, edumazet@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, renmingshuai@huawei.com, pctammela@mojatatu.com
Date: Fri, 07 Jun 2024 16:40:36 +0200
In-Reply-To: <20240415210728.36949-1-victor@mojatatu.com>
References: <20240415210728.36949-1-victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi all,

I noticed today that this causes a userspace visible change in behaviour
(and a regression in some of our tests) for transmitting to a device
when it has no carrier, when noop_qdisc is assigned to it. Instead of
silently dropping the packets, -ENOBUFS will be returned if the socket
opted in to RECVERR.

The reason for this is that the static noop_qdisc:

struct Qdisc noop_qdisc =3D {
        .enqueue        =3D       noop_enqueue,
        .dequeue        =3D       noop_dequeue,
        .flags          =3D       TCQ_F_BUILTIN,
        .ops            =3D       &noop_qdisc_ops,
        .q.lock         =3D       __SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock),
        .dev_queue      =3D       &noop_netdev_queue,
        .busylock       =3D       __SPIN_LOCK_UNLOCKED(noop_qdisc.busylock)=
,
        .gso_skb =3D {
                .next =3D (struct sk_buff *)&noop_qdisc.gso_skb,
                .prev =3D (struct sk_buff *)&noop_qdisc.gso_skb,
                .qlen =3D 0,
                .lock =3D __SPIN_LOCK_UNLOCKED(noop_qdisc.gso_skb.lock),
        },
        .skb_bad_txq =3D {
                .next =3D (struct sk_buff *)&noop_qdisc.skb_bad_txq,
                .prev =3D (struct sk_buff *)&noop_qdisc.skb_bad_txq,
                .qlen =3D 0,
                .lock =3D __SPIN_LOCK_UNLOCKED(noop_qdisc.skb_bad_txq.lock)=
,
        },
};

doesn't have an owner set, and it's obviously not allocated via
qdisc_alloc(). Thus, it defaults to 0, so if you get to it on CPU 0 (I
was using ARCH=3Dum which isn't even SMP) then it will just always run
into the=20

> +	if (unlikely(READ_ONCE(q->owner) =3D=3D smp_processor_id())) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
> +		return NET_XMIT_DROP;
> +	}

case.

I'm not sure I understand the busylock logic well enough, so almost
seems to me we shouldn't do this whole thing on the noop_qdisc at all,
e.g. via tagging owner with -2 to say don't do it:

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3865,9 +3865,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb=
, struct Qdisc *q,
 		qdisc_run_end(q);
 		rc =3D NET_XMIT_SUCCESS;
 	} else {
-		WRITE_ONCE(q->owner, smp_processor_id());
+		if (q->owner !=3D -2)
+			WRITE_ONCE(q->owner, smp_processor_id());
 		rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
-		WRITE_ONCE(q->owner, -1);
+		if (q->owner !=3D -2)
+			WRITE_ONCE(q->owner, -1);
 		if (qdisc_run_begin(q)) {
 			if (unlikely(contended)) {
 				spin_unlock(&q->busylock);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 2a637a17061b..e857e4638671 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -657,6 +657,7 @@ static struct netdev_queue noop_netdev_queue =3D {
 };
=20
 struct Qdisc noop_qdisc =3D {
+	.owner		=3D	-2,
 	.enqueue	=3D	noop_enqueue,
 	.dequeue	=3D	noop_dequeue,
 	.flags		=3D	TCQ_F_BUILTIN,


(and yes, I believe it doesn't need to be READ_ONCE for the check
against -2 since that's mutually exclusive with all other values)

Or maybe simply ignoring the value for the noop_qdisc:

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3822,7 +3822,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb,=
 struct Qdisc *q,
 		return rc;
 	}
=20
-	if (unlikely(READ_ONCE(q->owner) =3D=3D smp_processor_id())) {
+	if (unlikely(q !=3D &noop_qdisc && READ_ONCE(q->owner) =3D=3D smp_process=
or_id())) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
 		return NET_XMIT_DROP;
 	}

That's shorter, but I'm not sure if there might be other special
cases...

Or maybe someone can think of an even better fix?

Thanks,
johannes

