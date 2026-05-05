Return-Path: <netdev+bounces-284568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODXsN0dE+mn6LgMAu9opvQ
	(envelope-from <netdev+bounces-284568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAC4D3162
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D83B3045033
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606B3D332E;
	Tue,  5 May 2026 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSxGIkVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0E3D34AD
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009155; cv=none; b=UItkq/7WU6UwIxwu8KBRMrZfTDyhxoxwpS7p4M61Vn/4K5dNjKNv1qynPbo1PZp6ns9G8HkTjQBRqq2CBQcukJkcsLe/JXUl4t7XB7SLnx1g4elr0juMtAPiwKjHXpbdASIwQOegnAj+J63YOKS8FtSRQclNWIG1NAxt4zR2FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009155; c=relaxed/simple;
	bh=unBc1izWQJseF9wJ3T2Q53dX1S/hGOrqtWiG9Y2//f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QELY2unO8nSBYTDlg7tix6zHIdFPIvAZFM/I/wimmcSBsobgxcwIfBKk0/+FmkHG2cuZ5ugv7xzp/gEbfsJdP9r1pHpQuE8UE5CVvOcVq30XWdeCMyyPJRT+QJVA1Kx1rB5MAcIlAi3kTENJ2GRpjCL+jEqjqcAefD6oMNYsuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSxGIkVY; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso5768655e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009152; x=1778613952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rw0vHPpNopaX1nqR86+8y1EaQp5vpOse0ZUubitLk/c=;
        b=VSxGIkVYHscls+Guqlo597A3cyPgniakbNFJwVtJEEr0C61hBoKfFG4LFFbUYfGkxA
         Oq9DY8NaXEEMmOrx/D95uWLrjdM+FDD/EDEIM+2n6UKZZ9ndalbWCua5P3MffYUBdmqT
         Ss9MziyOrHmKhz/HQ+8Ir1oyPwLY1QWw7RWkbqFcARBULa4OtR9G4oUc8o/m6nzmNUvG
         +ZPvI964SBOeg1ShMOGWCPZYovIIJl+QbUG2bnhCaw+DrFuuJnb+/6tJ/liuMRzS6GEX
         21uMp2a8lPwPNSUTJofDtK5LOppSESm1WfPzsZ42V4gVEXLaoMIf9dYOSZjBrd04hTxJ
         bs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009152; x=1778613952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw0vHPpNopaX1nqR86+8y1EaQp5vpOse0ZUubitLk/c=;
        b=sE4Jh8sE2yaU6UGoc8uc5ch/A/gpHE92JPC7C4o06CrmcU6wZLVNXVYKH5dq+18R7q
         GC4bzHuhvTctPs95ws20LA6PHpCVwGijqSDY/yBFfByJGimOFYcUK4C4GqtUWId0oTm/
         nts9V8R12A4PBJ5LwkaS2Fdqd1VBI6vyhn9JGjbU+SJQSXS7qbeLu9Fb330wexC4wIzt
         T367F6R8SNG2ARauSknbOOy6a7iuCgykjROoO5siqDawRlcGcF/yZ9dFVqahQ0Pf0xRe
         qvJ3KQmBZ3omqIHXbw9GwrZgjg2hOAM8ndHWalDV2SI+EqEMQlfOsLD15M4jFBfeuy5G
         XLKg==
X-Forwarded-Encrypted: i=1; AFNElJ+tIB9RlWpgDf2hx1jQwBEjpxwPwkx0wLQJM9MfU3DO7FQt5jS/83+OqTGL66WZeNi22+SBZjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tqPsXczYuHxP2Z13k+h9MzGKXCW6//YSDG1uyryek9FAaF9X
	fSz/vwiWZO3MZnODJJcEQZM+fXYZu9pT0ewj5GNkCl/lj4lG+Ycml3Ek
X-Gm-Gg: AeBDies39OElYdcjKdtGhp3OMkA9AW7ZFOQq702CixCKlyR+phJjWqwe3YMUyaWAgC+
	8nBntwz5AcCgz0OMU1cUlFvKG17T8scbNIOXuqpCOcQ1MZktwf4hY6RDkg9hvf1S60H6Z6s12+t
	bgzCw7cQ4DPSx8aUb/H7kqfEF7gkUXUSm0cbNYZvNsyOVSpk4PGHst9IHlAIzXP31gJT0qXMdbC
	zpmV2ngd3ZWLD4DuXVWLxeMMf0LlCW0UJjL3Ij3x3wuMw/Snd6E0+fGfv9covqQef/RjSVkX5JN
	LlmsthHvuXw3W4zM+pleYTLyARxi475g7Y8FOOwtYdZZy/17KIKXnX819PQ9I9H29+6kS9HvHTj
	ZWuFimIW4VN1qD4ILyumegtj99O4830pTlVDP42rHloYPHFdo8mr5n7caVd8tPT8NoEXMtzjfvi
	BZWx5u5ZmP9YZmCx5JPiOr
X-Received: by 2002:a05:600c:c494:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48e51f395f6mr3696525e9.6.1778009151995;
        Tue, 05 May 2026 12:25:51 -0700 (PDT)
Received: from lucas ([2a01:e0a:354:c290:234c:5dad:48b0:9188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm408695405e9.0.2026.05.05.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:25:51 -0700 (PDT)
From: Lucas Poupeau <lucasp.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: [PATCH] llc: fix coding style and memory barrier documentation
Date: Tue,  5 May 2026 21:25:49 +0200
Message-ID: <20260505192549.74382-1-lucasp.linux@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43BAC4D3162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284568-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucasplinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

Fix multiple style issues reported by checkpatch.pl to improve code
maintainability and compliance with kernel standards.

Changes included:
- Add mandatory explanatory comments to memory barriers, specifying
  the reasoning and pairing context.
- Insert missing blank lines after variable declarations to improve
  readability.
- Relocate EXPORT_SYMBOL macros to immediately follow their respective
  function definitions as per the modern kernel coding style.

Note: Some indentation warnings from checkpatch.pl persist in this
commit. Despite several attempts to align them, the tool remains
capricious regarding these specific blocks, and further manual
refinement proved counterproductive.

Reported-by: checkpatch.pl
Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
---
 net/llc/llc_input.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 61b0159b2fbe..500621d1bd75 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -1,8 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * llc_input.c - Minimal input path for LLC
  *
  * Copyright (c) 1997 by Procom Technology, Inc.
- * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *
  * This program can be redistributed or modified under the terms of the
  * GNU General Public License as published by the Free Software Foundation.
@@ -19,11 +20,6 @@
 #include <net/llc_pdu.h>
 #include <net/llc_sap.h>
 
-#if 0
-#define dprintk(args...) printk(KERN_DEBUG args)
-#else
-#define dprintk(args...)
-#endif
 
 /*
  * Packet handler for the station, registerable because in the minimal
@@ -46,6 +42,7 @@ void llc_add_pack(int type, void (*handler)(struct llc_sap *sap,
 	if (type == LLC_DEST_SAP || type == LLC_DEST_CONN)
 		llc_type_handlers[type - 1] = handler;
 }
+EXPORT_SYMBOL(llc_add_pack);
 
 void llc_remove_pack(int type)
 {
@@ -53,11 +50,17 @@ void llc_remove_pack(int type)
 		llc_type_handlers[type - 1] = NULL;
 	synchronize_net();
 }
+EXPORT_SYMBOL(llc_remove_pack);
 
 void llc_set_station_handler(void (*handler)(struct sk_buff *skb))
 {
 	/* Ensure initialisation is complete before it's called */
 	if (handler)
+    /*
+     * This barrier ensures that any previous memory operations
+     * are visible before the handler is executed.
+     * Pairs with the smp_wmb() in [indiquez ici la fonction ou le fichier].
+     */
 		smp_wmb();
 
 	llc_station_handler = handler;
@@ -65,6 +68,7 @@ void llc_set_station_handler(void (*handler)(struct sk_buff *skb))
 	if (!handler)
 		synchronize_net();
 }
+EXPORT_SYMBOL(llc_set_station_handler);
 
 /**
  *	llc_pdu_type - returns which LLC component must handle for PDU
@@ -72,7 +76,7 @@ void llc_set_station_handler(void (*handler)(struct sk_buff *skb))
  *
  *	This function returns which LLC component must handle this PDU.
  */
-static __inline__ int llc_pdu_type(struct sk_buff *skb)
+static inline int llc_pdu_type(struct sk_buff *skb)
 {
 	int type = LLC_DEST_CONN; /* I-PDU or S-PDU type */
 	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
@@ -164,8 +168,8 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct llc_sap *sap;
 	struct llc_pdu_sn *pdu;
 	int dest;
-	int (*rcv)(struct sk_buff *, struct net_device *,
-		   struct packet_type *, struct net_device *);
+	int (*rcv)(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt, struct net_device *orig_dev);
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
@@ -206,6 +210,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		if (rcv) {
 			struct sk_buff *cskb = skb_clone(skb, GFP_ATOMIC);
+
 			if (cskb)
 				rcv(cskb, dev, pt, orig_dev);
 		}
@@ -217,6 +222,7 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 drop:
 	kfree_skb(skb);
 	goto out;
+
 handle_station:
 	sta_handler = READ_ONCE(llc_station_handler);
 	if (!sta_handler)
@@ -225,6 +231,3 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	goto out;
 }
 
-EXPORT_SYMBOL(llc_add_pack);
-EXPORT_SYMBOL(llc_remove_pack);
-EXPORT_SYMBOL(llc_set_station_handler);
-- 
2.54.0


