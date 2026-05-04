Return-Path: <netdev+bounces-284073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBhvAaAj+WkN6AIAu9opvQ
	(envelope-from <netdev+bounces-284073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:54:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF74C4993
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A7B30210DA
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DA38734A;
	Mon,  4 May 2026 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acy/vJ70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAB38B14E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935213; cv=none; b=gq9qeNfZyGHmf80c6TOOL8J5sjaHHVmWjaOCKsNEeqg0P03o7uw6FlmezSQAJMAV6+DnRckDUkoD77Fu6j/8LL9XXbXU1fUwZViiFhIbVR6PSrX7oWv0Hg8W1lAJHTzt0J336RZ0zFz88hfdaPW7VNEfXP4ytIfiSEmgJ0u4HDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935213; c=relaxed/simple;
	bh=SAsZJAe9WydKRLRZ02ebzE8gLRF83SfTmUajjfObGZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WagKJm1ysMbY2I031m+tfdwsoLHtGFd09hut/lhPMt7yxXQUan2qg3iDAZFtQ4x6o7byEK0jvWMUK2URZh4U6Elsc+D2yp+e709ydlEb2Pr2NLxPtccrQtuqA3L1lF+SEBMxx4rEsRkU+9vf5isHfci0By1vfui+vQesc0g3QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acy/vJ70; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3937014be0cso26569241fa.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935210; x=1778540010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOS6hbrW/VaDmmlN5BjcPm+kEsDqlTIoRXQ23SyQ2gE=;
        b=Acy/vJ70OPLLYMZK39axxmNd4rbur9FARbvzuNAffDvkSK4CW327reZs8yu5f2zoU1
         zbuwZ+o+heQFtWa2dS9Bx9M5ksJUaSTvoEj6oBaQadCASOFSRw2bSL0Hyf3kPNMkRWnD
         achfI80lLLS9xyHJS8O6p19kla2DIIhnvjWxFQfXY3iN6JkihSkFq9Ckb2s5NCL46A8J
         yY5jQVqTG7WblRvLe9//Nf3HcB0R57bf80MuX5nvMDITxbKIh++BHoPhFhqWeFfv3VJ/
         M9JNDrqG9KOoKHcqNIcZNE8BpiQ/RUKWlB5wovx5g+tsVcvI8zCk3GuwCbz31NwAgzD4
         f6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935210; x=1778540010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xOS6hbrW/VaDmmlN5BjcPm+kEsDqlTIoRXQ23SyQ2gE=;
        b=gi9sVh/XKXUbj8iQdwpIkuuukNAmqckqRIIale3WrbztiVl5NwgQ6VY1NvXPIP2DsM
         X5gQg/bMUvOwR1w3boSanBiqmpcWWaXpDIHi0fLkIK+2CoKTwJqcB9QtTwjS3CUBQ+5l
         sTRkj0g3xAb0LP5nypz5oMRBA8UMzXAdTRtPjyDMJ/Xs29/I8q03wUgmcHcvGT+1xxd3
         nbtsw7ecND4a1GvTqISTa1yICfK8xm0F0PI3Gq4w6LNr4SDkbK2+s0D5B5kQT3ZEGv0V
         alc58soeTwRnNxBhXlAvPdrTxnvSeV0XnZjOUGIcaFsAHFdJThUXFHa68bktmwIXMTeO
         SZvQ==
X-Gm-Message-State: AOJu0Yyb2FkBiR0yHgruchgWyTTUSSuYN8AH+8+qvA8NqkZeSSjKn68n
	95/MFzLQELg7527+n+Co8bhV76iVF47bUdW2v1E08jiufw5aNREiXBzyxtxiX30qKyY=
X-Gm-Gg: AeBDieszl+5zRih0uUCoNFdjW5bTu4WD2wxk5RrpWJyNhF1g7uDN2N7SpavOCfD044o
	G30hZF6O4MHh2YfF+Nc6H7MKQ0R2M0rDcEO0GbZjiIqU0tJpIVKvX5yvkMz3B1EW/rjg8XCEY5j
	8SKWw+AaAlz+sYRogBWxTLmRn/CnHBdChu3cDdOABXvcyO7Kgku6kMkZ/l2AHhCvdg9nK8jH7oZ
	pL7vi0IihZtfrtTMwVFWDjdu673ELNIVCxDfM3mvZV3EQx0P9h87HtfO+VHTHneXYu5MwpUcXIJ
	abvJgICQZnobPvLvUar9ZjwMywjN7FVmz1tKQMRYqZEGR2MU+P1nUv2lDdkx4u5FuSyV6ueVbal
	LDaQoWoE+rXlDeAAisgrt5JUSy925GtMo9KF2zS48BFjS7pZ5Z2MfHZeqG8Pk16ZKXZEP0XF19m
	wquJKVh9cG4EAo1+oAIF3zohOw7mLTRQF1l+kqToIg9sSIh1IH9lXUpksOBD9r9fXfy/fNINCZ9
	7/ojwZSOaXruuw/XYcJQ41NBqbBzAdozss=
X-Received: by 2002:a2e:9646:0:b0:38f:e351:1e7b with SMTP id 38308e7fff4ca-393784b08aamr31226961fa.17.1777935210122;
        Mon, 04 May 2026 15:53:30 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([46.246.34.10])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3939b43a795sm15774901fa.35.2026.05.04.15.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:53:29 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next v3 1/2] udp: fix encapsulation packet resubmit in multicast deliver
Date: Tue,  5 May 2026 01:53:09 +0300
Message-ID: <a66ed4176b14227ba4793d3fa495a611cd69db23.1777934869.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777934869.git.littlesmilingcloud@gmail.com>
References: <ad_dal164gVmImWl@dau-home-pc> <cover.1777934869.git.littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 99DF74C4993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-284073-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index e9e2ce9522ef..84a98631b556 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2467,6 +2467,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -2511,8 +2512,9 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
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


