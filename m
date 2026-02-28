Return-Path: <netdev+bounces-262133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI0lM+z3omnk8QQAu9opvQ
	(envelope-from <netdev+bounces-262133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:13:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D04E1C375D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79AA03016B9E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E1392834;
	Sat, 28 Feb 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fCbFevV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E53019B0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287976; cv=none; b=fPxEysEh83eE9FBA1TjcT730iMELMcJO/BFCXkZ/C0EdgUDVmNOx1vMbprT7BYPVY85DpO6Fk9cyeAYhTl0B5fTlB7JCOt/ESYDV3yv1QY0crw4w4XTlNq5VuE78QD+93/c7Lv7sgrKc/dhADgHPNYE6Hwrr2T/+sR2Ce2uYrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287976; c=relaxed/simple;
	bh=QBLdIEEnHpSiWyj65PwX0yZyN3lZmmDAc5D7n7PH7ms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bQdsVW1ea65UPMOPmidIPi2vNod2W6vmyL4kcf0lDAYsGLk6NSygX1OfKh+z8hOuufUfnn8JgR+tsdYxb3I4dw1BvzqMOEGvm9y++j9aeCkiaTxLedxPTs3X4jV3ZVbghWLKnrr1QyTi7vnAYDxFSRawsZKhQqVozUMvU4ToabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fCbFevV; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb3a129cd2so3061029585a.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772287974; x=1772892774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5xfpeDrS28+GJWagtJ5tbfozq/tKlFdhequt2eFMJJQ=;
        b=3fCbFevVpnhuyhF2D1f4sBCHdrexa2/43HSQKv1DSSuiU/n/TKHUe7TJ0h4/BzXvoW
         fb7NcpOO7Szw0UjnVxaLnA+70jkt9e7c1vTp5qMGvo2d0ZBqx3gtVqqU5ePEDOBX0NOx
         qzYzBfNG8V0BqbWzixaPeAh2L1JeCdPQKh2UhyMUij6VPpj8HsXhtCs0bGE/wDnpJKmA
         vKot/je5lJs89ALGuyorh85sfOW1PRZdowzRyZUw+rmb+LNmM+nCIR2RPvPnLQrx3TSf
         rvcyU3qIXzXApVRnYf4kGuwTOyFTBBBDohW+iCyKOylmT9Y2aeC/4emj7HfkORGyAk+v
         HYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772287974; x=1772892774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xfpeDrS28+GJWagtJ5tbfozq/tKlFdhequt2eFMJJQ=;
        b=NMSKyL7kcbyCye8i17wa72vcZ2gdkh5xelmti51rfWqe+MThAZkpkgPlMX1TSzhNbG
         3/S/oyjFDgxRz6jDVoWBR6C4rQWh1SrPSVIR5Bc3vjoHTGxVwn/DGGLUa/Lth194MU5a
         bBLV2J9fx4gT/7sUHJWAUgNelt4rbdKG0egORJiK2GZqd2PNKy0UExilph50U/zLD2Zi
         TMSgBzrKts6U6qf3MxRNIUCztc/HzDc5Us4mtCyTo3/HdqpN2aGEFxo+mm1f1myeNi/l
         R7DeLqI8fiER/eZ8RY0rIZCAPBn1aE5rvgle+IRKJxvjEJvodA1k/zwsMbX/ws5P6OcF
         UYIA==
X-Forwarded-Encrypted: i=1; AJvYcCUjLgSDlPn5oo3A6T+ZaglduXfAXLjF2fZSbBarmCQ66WFEvDd48oxDn9ZIO+yw0nZ71Wp0sGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5EnHEE0c7XPKNa41ok8xZ6D03AUWMDdncZ1z1ImXTGBrJmBk
	4b9hrxCi1w4pBaREvRbqSIffC4JiHHBxWeffZBKNeQXG4Dso+HVoElDOF+AUVWLwOXPixNJst3c
	FGqrrY/aLfOwjyA==
X-Received: from qknsk6.prod.google.com ([2002:a05:620a:3a46:b0:8cb:4038:5d20])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:318b:b0:8a6:92d1:2dae with SMTP id af79cd13be357-8cbc8c47908mr755691885a.5.1772287973734;
 Sat, 28 Feb 2026 06:12:53 -0800 (PST)
Date: Sat, 28 Feb 2026 14:12:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228141252.435509-1-edumazet@google.com>
Subject: [PATCH net-next] net: adopt SLUB sheaves for skbuff_small_head
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,suse.cz,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262133-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 2D04E1C375D
X-Rspamd-Action: no action

skbuff_small_head is used both on receive and send paths,
serving potentially 80 million allocations and frees per second.

Tuning it on large servers has been problematic, especially
on AMD Turins platforms, where "lock cmpxch16b" latency can
be over 30,000 cycles.

Switching to SLUB sheaves fixes the issue nicely.

tcp_rr benchmark with 10,000 flows goes from 25 Mpps to 40 Mpps
on AMD Turin.

Other platforms show benefits with tcp_rr with more than 30,000
flows.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
---
 net/core/skbuff.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 513cbfed19bc34bbb6767cdd7a50dad68be430fb..79eb7eb6eea9aa4a76c555e6ddd33bf0bc84c921 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5174,6 +5174,19 @@ static void skb_extensions_init(void) {}
 
 void __init skb_init(void)
 {
+	struct kmem_cache_args kmem_args_small_head = {
+		.align		= 0,
+		.ctor		= NULL,
+		/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM
+		 * bytes.
+		 * struct skb_shared_info is located at the end of skb->head,
+		 * and should not be copied to/from user.
+		 */
+		.useroffset	= 0,
+		.usersize	= SKB_SMALL_HEAD_HEADROOM,
+		.sheaf_capacity = 32,
+	};
+
 	net_hotdata.skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
 					      sizeof(struct sk_buff),
 					      0,
@@ -5189,17 +5202,13 @@ void __init skb_init(void)
 						0,
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 						NULL);
-	/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
-	 * struct skb_shared_info is located at the end of skb->head,
-	 * and should not be copied to/from user.
-	 */
-	net_hotdata.skb_small_head_cache = kmem_cache_create_usercopy("skbuff_small_head",
-						SKB_SMALL_HEAD_CACHE_SIZE,
-						0,
-						SLAB_HWCACHE_ALIGN | SLAB_PANIC,
-						0,
-						SKB_SMALL_HEAD_HEADROOM,
-						NULL);
+
+	net_hotdata.skb_small_head_cache = kmem_cache_create(
+			"skbuff_small_head",
+			SKB_SMALL_HEAD_CACHE_SIZE,
+			&kmem_args_small_head,
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+
 	skb_extensions_init();
 }
 
-- 
2.53.0.473.g4a7958ca14-goog


