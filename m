Return-Path: <netdev+bounces-303890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HsNYIpyeRWocDAsAu9opvQ
	(envelope-from <netdev+bounces-303890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9506F23A4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 01:11:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZtbMKy5a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303890-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303890-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EA3303798A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF83C345A;
	Wed,  1 Jul 2026 23:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272134DB52
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 23:11:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947462; cv=none; b=T9ZYwCG5aNbjC6sGStQNH6QAEuGy+UrevlqcnLR0hU+77ZMKfjWJqWZud06vbXNjRHDxTr7W16A3LMgjXNDKIozqog1CJW984w6G2Vk1btRH89BaybpXkhOvWVJKtDydZ7LkSoNbGd1FcYM8rqcg8XAc56xgbiUCixCOdNQagcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947462; c=relaxed/simple;
	bh=RNftdiDjwqzdh+NAMe9OxTG27PbgiCUbdaHBnBAZPrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOr+0vEJSZobtxoGfiNtYu6MLcO2ae3tV3/EjwW4+bJwyExvfOROHln+gRw3g64di6uyKpvxzOAlsuOq+StZKrQ2KbmCx5IegqxzDlGWtpjEruQY304quSk/Rhm+EV4x64czjpf9kR5xontuI/YGzQqhr9Ts2d1MGK1IDfRwBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtbMKy5a; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697df404e32so2345570a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947460; x=1783552260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeezDZnqwxLLrYeZKbc2Tddo56pKPGHDghVq8T+N11M=;
        b=ZtbMKy5aLkTJ496RVJvnCCeeQgA90R7v0weJYy3JzEusCAIzfPlXX0xNxBdcE1sb+p
         0zEYRJlz93b3sCug0cy15lLWE4YSf/0STdu60Jf8aUsH3Vqb0/d9OGNpFompVvU7bIFr
         L0OQT4d87VdV4bAbaf7SjFaU/+z2pe6oLF8SO8gpCtYMRglm3MyPvixn9dDrlNlTd6KS
         Sg9DX9oT7NkGaQwDzMuPw1aIleVIjgiEyOlbWfxw83pYV5Q+NXVyH3iVlYnr0zghstOJ
         E7DIEO4weri+QzhalM8ParBkHpEBFPuLJK2I0LKvT+ikeMFteJNxtR+qIOmXUEoDrqC3
         EAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947460; x=1783552260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeezDZnqwxLLrYeZKbc2Tddo56pKPGHDghVq8T+N11M=;
        b=IptEA2QoRe2b1dnfxr+Q+iY+wVkxurUZ7ezJi/9f4v5xpt5iqD/tQ4LAicZUZe8SCz
         MFKDfL6qtfwJBumdTFeR6ctzfi2QGB2vCJQIkRRynD3rjx2wNNY5R3rW513eQXFO/dO5
         CBvI/2uDBNOCp+Add6ka32qd7GMnP2am8KJ6JbmJmYdopkl30BWGAzpmnEMRAhTX1Nbv
         ExP6/Ip7JtEdRa/dfh2MVlePvojHQI7g/6fhmkHMe786eumqqZTjv3dxHngoW86wKgK1
         ooO6Nm6nsi1caEFl1EX+FNNtxjO2C95LmJZImGV+DBLgCb3cQiJPCsz0JnsjeMXm6RgX
         te6w==
X-Gm-Message-State: AOJu0Yw+NjzBWxgL7kIa2lM4ERUuRwJ8QI83nKZhZWode6wzFoOb35NM
	IXdSscu3zhLAcqxVMcET6Djui+VuKxRfh0p8KupWiBn8sBfsC070zuIwJzWJmOgD0eQ=
X-Gm-Gg: AfdE7clfNPETEddfl22gNOCR/OvGzlOmBefDTSJH/Zeq+Ybfh73pNRsRbdHGilnxJgj
	cIiK9xLCifk2+0Jqu0PYQXPxUddRmC8NGkeAyXt3Kn7AxX//2ekvFfV6dO44EpkCuq65HT366Cw
	ruEyz+R4NoFuuZAZxbRf3Jg0vEbuQxst9ePLTU3k5gp1jSrsq1wYDodYzh6628jZ8l3U9YK6MnN
	Hton1Epj/zfX55u/InPeh+2e73+lEWY9AScj1MxHGJ0YFbeBwPGehEaS6tUQrBJ/msy88TFme7T
	1xh3xB3oZFrzdteFeYkdr58z7VXdIL4c6uikCdgYsxCu8/kZ3WUbnF0CTinqcwv3C/K25z+s6pJ
	HhMIz5wKAo7ShS6BhvsKjuB2S5tgWwPAF0okoK9yb6Xtifs71Fw3AoQov98pxf5dIczhyEAq/wL
	dUbUpZZsR08P8/fmz7Wu5Mzxtp+7eAVOryai2UJbN4J7l1Dk5NhGkEQun7T3xsRKbVg7YVDHVdN
	uwKOg==
X-Received: by 2002:a17:907:984e:b0:c12:4e0a:4587 with SMTP id a640c23a62f3a-c12aa176761mr137407066b.49.1782947459414;
        Wed, 01 Jul 2026 16:10:59 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b629a1d4sm30663466b.39.2026.07.01.16.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:10:57 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 1/2] udp: fix encapsulation packet resubmit in multicast deliver
Date: Thu,  2 Jul 2026 02:10:36 +0300
Message-ID: <47dc3d5fe519dc3e0aafa934020a343d8306af1f.1782945956.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782945956.git.littlesmilingcloud@gmail.com>
References: <cover.1782945956.git.littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303890-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B9506F23A4

When a UDP encapsulation socket (e.g., FOU) receives a multicast
packet, __udp4_lib_mcast_deliver() and __udp6_lib_mcast_deliver()
call consume_skb() when udp_queue_rcv_skb() returns a positive value.
A positive return value from udp_queue_rcv_skb() indicates that the
encap_rcv handler (e.g., fou_udp_recv) has consumed the UDP header
and wants the packet to be resubmitted to the IP protocol handler
for further processing (e.g., as a GRE packet).

The unicast path in udp_unicast_rcv_skb() handles this correctly by
returning -ret, which propagates up to ip_protocol_deliver_rcu() for
resubmission. However, the multicast path destroys the packet via
consume_skb() instead of resubmitting it, causing silent packet loss.

This affects any UDP encapsulation (FOU, GUE) combined with multicast
destination addresses.

Fix this by returning -ret instead of calling consume_skb() when the
return value is positive, matching the behavior of the unicast path.
This avoids growing the call stack compared to calling
ip_protocol_deliver_rcu() directly.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 net/ipv4/udp.c | 6 ++++--
 net/ipv6/udp.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 70f6cbd4ef73..b0910659391e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2475,6 +2475,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -2519,8 +2520,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udp_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udp_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			return -ret;
 	} else {
 		kfree_skb(skb);
 		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..ff2e389e286b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -949,6 +949,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -998,8 +999,9 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udpv6_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udpv6_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			return -ret;
 	} else {
 		kfree_skb(skb);
 		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
-- 
2.47.3


