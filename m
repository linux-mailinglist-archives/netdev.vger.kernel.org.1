Return-Path: <netdev+bounces-270862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i8+8MJ4DwmmsYwQAu9opvQ
	(envelope-from <netdev+bounces-270862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:23:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C062A301A81
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3ADF3010836
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050E3947AD;
	Tue, 24 Mar 2026 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDmk03qa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B813239E7F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322584; cv=none; b=R61tUL1H8Ryqwa86rfHam+duLIgEyR1dvqbpL3bcS9Fc9IRlCIlBuL2cSy56D6WqMu7bhiHFSuGRTF+ag8PrZ9kgm4Hzj2OY4UZ/FcIAXUUHKaJEcXj3iWnMEmrNEBMpmrBeasWgtJo+aiyH87d2K4TwpzQ9NKFjkc6wALhUTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322584; c=relaxed/simple;
	bh=TxbddlDvwj0H0a5cRauMLce46ArVR1XYLpaJvIoiL3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxFt/oOb4rnNOSPyfXIDfOyrVuB02eLB1jiPSLl27ZsAG3loueGuLDN6SXlkhLXooyjqSXt4qrBZGjDP71ePSv0qwc16h10dskG8cALvaP0gvSkUabfqpw3eShJmJfqlxqhCJDMc9N0c2350sHBwQTR+47F1lJT6Q5mnogpiBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDmk03qa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1861233a12.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774322581; x=1774927381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUpcZJ/GX5bIeN9b+qRlxwn1Qz4eci6IXB2Cnwx3YIg=;
        b=tDmk03qa5hoimTRhj6UjNZC4fKzXv3mc00JEMrxtg9+WZX5d3bAmeDcYNuNriNYuFa
         rbS29T3J9Qwt6wRyxZZEl8kNEzI+Yg5/Spuy4K6a4O9zQ8Ms+FETWagNnYv1BfwUJNF4
         uB6tmpG285N1FU/KtavFpQvdtkuAArB2LLZLBdAxkfxIY6W+m7GXWKun8Iae8SJ9zPqh
         UGWQiYoJ0vsfSMTqvnuIiu70XawFY/bqUMFqSYAuUfUHJiVIxdVcG9sG8jPcT1pALXjp
         dXi34PfFV29ml0K9dZ6AzRq/YRmEP+ZjI+5FiVGqfdpucVOeJ611yYU4nnXrHKNOjVzf
         4W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774322581; x=1774927381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUpcZJ/GX5bIeN9b+qRlxwn1Qz4eci6IXB2Cnwx3YIg=;
        b=qD/tl/nJZ+/GZSd7UQGLPUmfLWaYlozdESEwBCH4i2a2ffb2lqv81mKlTjoxs72iyE
         c3+tTK7svL7h365ssshFUFGfWLR4FfMhoTakaP2zbjXA2ULuqMvSM5SURgKWsvNH/KZc
         i3hiiOynjxKauYvnoSFgxiDeCJKUu6vTn2ZLrGkceqSzTnFNqk1D0sXVEsnNdTeLFSWd
         Jk+3lSzw91g0hC2UEdeqTzaSU+SmtCrfFOHIa4kw27E1X03UqpryDmbOSH7y9cdsPN3M
         8A6fDa17b2hNZKisJ1tcAfXoXXcjMMreqvol42ljTpoiVQXvUZMbQR7V9wAcG5qfuN5y
         sN6w==
X-Forwarded-Encrypted: i=1; AJvYcCWsVH41CK7t6qphmOrXTc2Wlj99eYXXsoyEoLuyh5uDtMNxuf4glmqhi7kPOG7glVcggp27A1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0IvL9GSD4vdPNw4qqSEqivnzknq/Dim3o+eQFWsr+HsSPpu4
	jGR5uxPSOeTUGL22ZgmCp1gk/a+JAFIhOQRFk5eQehsKxo+K41A0Kv18
X-Gm-Gg: ATEYQzzdNWlaI3XdzyD+e8uTkN9yfkP7H3i8pjqIaSiamokspq91cx0SNqV+pYgRBvm
	0GPK9jJ4RDqhBEfDwSuaDdw8O6ix5jwbBL45IbsZlBlWnakrhJoJ9TU7MGDZeuFtkxAUh6oH/7W
	5ZDhI1l9zEqtC2uyC/bgC8917egLmqF8EZfUQqp9Kp8kEwpwwctaJqCOlzdx6nlbE355GPUZ3HJ
	H7GBKtGjl+iV0DF39Z3lqhdnQCPRflrIgwsRhZB+CTlaXHlxYUqyqkN0D1aytFU7Fp8YClBiZKB
	YS59nEU0LqiPzuzaA2ol5HwkvwlCeDATGJLMQ6AHLaz880a1j5rXjrLUo/w+gSoZgjBUCCXr9HO
	gHslSWBu3P465MdFfHDG9KPtwBVy+KQMYIAzN7gyYTTaWBnI4auDfDe/L8cBcE3ou5TWHINA3GX
	+aGiRjvHKjmWWlqngW2d5nerNbPmdSnLZW3Eo0wkDGHwbxBNk0miY3OPk=
X-Received: by 2002:a17:903:32c8:b0:2b0:501e:d751 with SMTP id d9443c01a7336-2b0a4e1ac96mr16623755ad.20.1774322581514;
        Mon, 23 Mar 2026 20:23:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835298acsm131223335ad.22.2026.03.23.20.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 20:23:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-atm-general@lists.sourceforge.net (moderated list:ATM),
	netdev@vger.kernel.org (open list:ATM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] atm: nicstar: simplify allocation
Date: Mon, 23 Mar 2026 20:22:43 -0700
Message-ID: <20260324032243.26387-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.sourceforge.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270862-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C062A301A81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member with kzalloc_flex to combine allocations
into one.

Add __counted_by for extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/atm/nicstar.c | 17 +++++------------
 drivers/atm/nicstar.h |  4 ++--
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 24e51343df15..2f6a3637aeab 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
 	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
 		return NULL;
 
-	scq = kmalloc_obj(*scq);
+	scq = kmalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
 	if (!scq)
 		return NULL;
-        scq->org = dma_alloc_coherent(&card->pcidev->dev,
-				      2 * size,  &scq->dma, GFP_KERNEL);
+
+	scq->num_entries = size / NS_SCQE_SIZE;
+
+	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma, GFP_KERNEL);
 	if (!scq->org) {
 		kfree(scq);
 		return NULL;
 	}
-	scq->skb = kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
-	if (!scq->skb) {
-		dma_free_coherent(&card->pcidev->dev,
-				  2 * size, scq->org, scq->dma);
-		kfree(scq);
-		return NULL;
-	}
-	scq->num_entries = size / NS_SCQE_SIZE;
 	scq->base = PTR_ALIGN(scq->org, size);
 	scq->next = scq->base;
 	scq->last = scq->base + (scq->num_entries - 1);
@@ -928,7 +922,6 @@ static void free_scq(ns_dev *card, scq_info *scq, struct atm_vcc *vcc)
 				}
 			}
 	}
-	kfree(scq->skb);
 	dma_free_coherent(&card->pcidev->dev,
 			  2 * (scq->num_entries == VBR_SCQ_NUM_ENTRIES ?
 			       VBR_SCQSIZE : CBR_SCQSIZE),
diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
index 1b7f1dfc1735..ba45be53d40e 100644
--- a/drivers/atm/nicstar.h
+++ b/drivers/atm/nicstar.h
@@ -667,14 +667,14 @@ typedef struct scq_info {
 	ns_scqe *next;
 	volatile ns_scqe *tail;	/* Not related to the nicstar register */
 	unsigned num_entries;
-	struct sk_buff **skb;	/* Pointer to an array of pointers
-				   to the sk_buffs used for tx */
 	u32 scd;		/* SRAM address of the corresponding
 				   SCD */
 	int tbd_count;		/* Only meaningful on variable rate */
 	wait_queue_head_t scqfull_waitq;
 	volatile char full;	/* SCQ full indicator */
 	spinlock_t lock;	/* SCQ spinlock */
+	struct sk_buff *skb[] __counted_by(num_entries);	/* Pointer to an array of pointers
+								   to the sk_buffs used for tx */
 } scq_info;
 
 typedef struct rsq_info {
-- 
2.53.0


