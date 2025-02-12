Return-Path: <netdev+bounces-165500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9293A325F1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8848D188C344
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E93F4FA;
	Wed, 12 Feb 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mraPSZkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKK9GTif"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FB20D4E4
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363903; cv=none; b=YLpDXZ811kXERnuRkBDBtj62phvYdro3+nWyA7EI8gpUg5bOkjLYAgPOdH9YpN59QQh/p7/yDB6Jt3pvTLZ1AeyNvRagawJu+GFxa0nWZ41Hl0uCvuobiSujF3+PwSYn+MDAzCZUIyYcOrpn2v8+7///YcIrRHypL5s6VWiObkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363903; c=relaxed/simple;
	bh=AHns9jRQls2mSUkoacTQIkM0B3aeW5k32S3RJihJUEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLRx97WO+gbxtCGH7Scy+LEIK7xqTAfdVFG15tbkEqK2SLtXJoFWYL7d4M8kOR+p0VHJ18Xf2/oqEd+BX+FFUKH+flGwhup6zqs8QmXZXMDi5qiOGoNRYGGyr/kFid/ztxj+PGrxG/wzBrcBcOwQX1iuSJ9m+46wfYqWd6H7cSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mraPSZkN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pKK9GTif; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AAB21140324;
	Wed, 12 Feb 2025 07:38:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 12 Feb 2025 07:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739363899; x=1739450299; bh=q1RRFpj8sNWIPvEDYZcWZdsS7K41JWwk
	udNz+A4er6E=; b=mraPSZkN+MnVDqg1iP5XZzPcI86rIcuLbo8V2rfwxc/KBi1r
	bTQ6q5BxTHiJZ54TXiyxsr6xhaBxs++oLync2+282zXCjtmarB0n/2DyKgDCa2c6
	anM43fzqwe9dJJxPBxwSeO6kU1WNrltJlnnMRhqi6BpSyYCDWv5F8A8KOJfY/tVI
	N/c5BuknkFHtDnnU1U341L4/CZVScF8YQJqTpQcgTa9fhmfj7aE2gJMxT4DkoUJR
	edzvdsOljKOI4gHJOnJnG6V+5eG6cq/aZr1mrPdqxI1T3hYe0nzNoJ+ZrrxlzWQc
	KqoJ/F6FUc1o6/GgTYwoHrdRRmZC0cVivC7rdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739363899; x=
	1739450299; bh=q1RRFpj8sNWIPvEDYZcWZdsS7K41JWwkudNz+A4er6E=; b=p
	KK9GTif9XeOiLgUifffZ11KTaTUAmRol51acgssoJAFa4krD7J5Skb+8sOIwK4Qc
	8YlAyxkBtzl/ceaxZoDMj0VTXxiridQ0OYYezrfAZvjyROubifqbGHxR+UyjQdgU
	qkvKPA3wWWUehkkRgMwM5nDGCbMMZs7NPbIgx0Xn9Thkfi+P7T+uW6SzFdcsffxS
	9onxu2YZI3pv5a5rbdy0/F07yUK5CdRazu3IG4t4e6+DSdxa7kImdSEZr7A2KFQY
	MnDAWfIHpzYfDRZxvH+HlaZT5/Z+5gbiCE/NNFebWJx9j6dgCPnusvFocrE7245W
	bzvUzj64XpM5+KHO5QmLQ==
X-ME-Sender: <xms:OpasZ9GAioHqSWumeW2ZOaEBh0CssBiMCDaKobgcwVeJO2woBd33tA>
    <xme:OpasZyW7Vt4RtfPN7CSscQ6K_ctEKihvPj0-aGhMC2MMChoa7NezV5Uqn56h4rXcm
    2wfMKUtbBoXaN9qbkg>
X-ME-Received: <xmr:OpasZ_JEjSr_Eae2CnzCf2ECjaWSn3IZYjgk01tvDCMcrL8mqc6k2hDRZB5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutdelgeei
    hfegueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehntggrrhgufigvlhhlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepgihmuhesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomh
X-ME-Proxy: <xmx:OpasZzEzE7q0m5dXzVRd9VlWH-yL1MUuKxirzq7tMLWxnKi-PiBPSw>
    <xmx:OpasZzWWmmUA8j8phVSObbB0wsyHw0k92bJuuN1In1qcC-s1lAaBNw>
    <xmx:OpasZ-MuiBUz7LxjRa5-iJDZJhuR6--uAkzDaJePLEtpeMUFKYZUvQ>
    <xmx:OpasZy16_QoVgcBa3Or46SZ5zJh_sJVBej5yWu-lsmXriP0flBG4FA>
    <xmx:O5asZ_pNvx3AF_ufNzbJ5lDR6frB9QP9zGiZA5W81-ovhd7fov6-Achv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 07:38:18 -0500 (EST)
Date: Wed, 12 Feb 2025 13:38:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>, Xiumei Mu <xmu@redhat.com>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH net] tcp: drop skb extensions before
 skb_attempt_defer_free
Message-ID: <Z6yWOCAeKqaj2BfP@hog>
References: <879a4592e4e4bd0c30dbe29ca189e224ec1739a5.1739201151.git.sd@queasysnail.net>
 <CANn89iJbzed1HnW7QHSRWno92hLAbQH+iaitAutqRh=CK9koaw@mail.gmail.com>
 <Z6ucMj5FukT_lecR@hog>
 <CANn89iJ=qUt=tgPUMUcAjeNunuYByMNCOcTzqABe_qLu-BiAPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ=qUt=tgPUMUcAjeNunuYByMNCOcTzqABe_qLu-BiAPQ@mail.gmail.com>

2025-02-11, 20:17:17 +0100, Eric Dumazet wrote:
> On Tue, Feb 11, 2025 at 7:51 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > An additional patch could maybe add DEBUG_NET_WARN_ON_ONCE at the time
> > we add skbs to sk_receive_queue, to check we didn't miss (or remove in
> > the future) places where the dst or secpath should have been dropped?
> 
> Sure, adding the  DEBUG_NET_WARN_ON_ONCE() is absolutely fine.

Something like this would be ok?
(on top of the previous diff)

The main drawback is that we can't just look for "sk_receive_queue" in
net/ipv4/tcp*.

-------- 8< --------
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4d106d13db22..930cda5b5eb9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -690,6 +690,13 @@ static inline void tcp_cleanup_skb(struct sk_buff *skb)
 	secpath_reset(skb);
 }
 
+static inline void tcp_add_receive_queue(struct sock *sk, struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+	DEBUG_NET_WARN_ON_ONCE(secpath_exists(skb));
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+}
+
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index b815b9fc604c..32b28fc21b63 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -195,7 +195,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
 
 	/* u64_stats_update_begin(&tp->syncp) not needed here,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bb0811c38908..6821e5540a53 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4970,7 +4970,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 		if (!eaten)
-			__skb_queue_tail(&sk->sk_receive_queue, skb);
+			tcp_add_receive_queue(sk, skb);
 		else
 			kfree_skb_partial(skb, fragstolen);
 
@@ -5162,7 +5162,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 				  skb, fragstolen)) ? 1 : 0;
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		tcp_add_receive_queue(sk, skb);
 		skb_set_owner_r(skb, sk);
 	}
 	return eaten;

