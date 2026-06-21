Return-Path: <netdev+bounces-300896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PxiwKOc1OGo+ZwcAu9opvQ
	(envelope-from <netdev+bounces-300896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:05:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E06AB7A1
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:05:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fYLlikqG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300896-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300896-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADE63014BD3
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15F370D56;
	Sun, 21 Jun 2026 19:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770219046E
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 19:04:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068693; cv=none; b=FHExTsxPpfydF5MOWXg/cO49h5NFQEMBYFy3gDxmTHugqX/SUfWyvgdqmjQjP5HSEqKDYoK+0o0Iaa5XyD+eN1dIa5VmEEzaYaoghBnDHFSWdToCuFMgEK6cnUtuViGZRl/VPs3V2TfgRrD7fce2IO8kDSBUsuays1m59nTYCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068693; c=relaxed/simple;
	bh=RNftdiDjwqzdh+NAMe9OxTG27PbgiCUbdaHBnBAZPrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBs5ZMVEOB/yfAF4W9WkI8HzeWnqzRDLxqQpR+QqRzrS8KbpJDMhJ7goIJfjr4Db5E4OUN5STTn4bLxVbU4+7DWzaQikGWGgPcLBGobLg5MNtcZPYX/th1DigIyW+czTbJDrzPOCAmEnHrgWsmznSPQT7chCuWc8TS2IoLOhFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYLlikqG; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c07680fdd12so405789766b.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782068691; x=1782673491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeezDZnqwxLLrYeZKbc2Tddo56pKPGHDghVq8T+N11M=;
        b=fYLlikqGcBY37kjTv31EGjwORdhZKgrhRLa8lNpKCklWpcUlHF75UpVk1VWClGsNbO
         IsX9+2WgP7W3uO1CN9ukSXcLxAw1Nm6sU0vTKIWtgqdIn33fRPAFoFSxsBxbjq1I/SV8
         3NW6Iapn4mwhH5/HZTzL2gqMgBj6v0QJPRoVMgjH+c7fPAD9WReT4vG+sFNnivtJq//+
         LnR6s2bKgMJo6R1VXgDUNjM5t2U/obqM9eIXc61BV6ZsqOk8/mgkFQhpGI687n8Z5Pn7
         CDqUdZyCzbmXGgksOpvKgG11E025Qogzjs44fwALO1CEIaCzoFOIdWKAiumbeygH2P46
         oXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782068691; x=1782673491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeezDZnqwxLLrYeZKbc2Tddo56pKPGHDghVq8T+N11M=;
        b=Fz4O28IQYVgzOyI5UEMC0k0BvzPYp9rbGgUuEnaPTlhpngoDR9sAim2AC6ohMCBRzG
         dc+ciHUdGNA102IHiGRJKcq32q0um+F+sDcwTIFr8tPHf8nyDtWxbQb9AmfR+TfwKfIe
         D2Z3y08SmGm4aB2f74tbpFjfeQ+RaZyghoE3FxSEh2Fj/4mZCoaWoJm9gG/vbFy9MG3g
         IvK4P6Za+NS1D2KJEbe7/OvB9yJTTK+wetwHefo2YpaHgSgE/TQlRZP5mpY7UpBFu1Rz
         +COj5yKBpKenjN3gk3nrUieyDO8WVQ/cwwTlJt0730aeyfB0L2udb3RSn3FN0ivGysG6
         RLeA==
X-Gm-Message-State: AOJu0YyF/ifWTvbVOdO/XtRR104aUlfKA2PEAUAokSg3zgifVzp0JD9J
	9DFuXtjRqjzypl/3rLdUZUwA/+QlmtUF7+CCc5PdrXFTX5YI+OMkkiwBrLBIb451
X-Gm-Gg: AfdE7cmrIld4fffnyZAZD690Bz/jlausb/ooXrjCDwRGfyf6DHgmLPzmAjK++apXP68
	XoKgC+awD6eb8+bDzVG/bVqn0qNeXFKk/U4wE+Ekhkb3sODk5lgEXK5g8vRb2VwsTOBiGj7kLJN
	55Hh4+c/wBKljQAFhCg86O8N0rJdwMcMFNqR2MAIW64/5EiuvUbcjpX6WBBZuOtFOk9B5TrhmI3
	nhT2/EuIq0/K8wkoE12M9xa26JYNbtWB6zBFCuqaaSoC0r8UP2C5VVy3gWcKIquVZojvaEsMTWl
	y8f4hrjJgqFKPVQXSkxWRUticovbmD8xC/bS8NidJKCxF43WiCtwx+Xw3zKKmhDCLjAFsRdMcOM
	lUOplDFN7nGjaf4ZKnvJIsDggHL6tqQ+EqCUF58f9gVE3PPcYuNc8Y6SKrdmbd7nAR79E8Aa4ci
	SmMADXg4V5sWshHjJ6eAovp/bxCOo3rMvLQ5LB+35AEnK4BeKgKBEnzZm6I4/kwPTiWLQye+FCm
	7HyXA==
X-Received: by 2002:a17:907:3f89:b0:c05:a926:c2aa with SMTP id a640c23a62f3a-c0b74c782dfmr486206466b.37.1782068690765;
        Sun, 21 Jun 2026 12:04:50 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99977fsm230558266b.20.2026.06.21.12.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 12:04:50 -0700 (PDT)
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
Subject: [PATCH net-next RESEND v3 1/2] udp: fix encapsulation packet resubmit in multicast deliver
Date: Sun, 21 Jun 2026 22:04:11 +0300
Message-ID: <8c6961b0e8e394669963fab9edf61bd019fcdc88.1782067871.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782067871.git.littlesmilingcloud@gmail.com>
References: <cover.1782067871.git.littlesmilingcloud@gmail.com> <cover.1777934869.git.littlesmilingcloud@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-300896-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 007E06AB7A1

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


