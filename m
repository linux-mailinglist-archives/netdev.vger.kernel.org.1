Return-Path: <netdev+bounces-272663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACtZK/rbxmkoPQUAu9opvQ
	(envelope-from <netdev+bounces-272663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:35:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBCF34A39A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4979230860D8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370B37B3E1;
	Fri, 27 Mar 2026 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZz3y3zG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27829ACDB
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639467; cv=none; b=P7At/jfvk8EGIlTZZmmfxO9Fja9AfU/+wMGHa58wtEsliRFBw1pzoOBsJ3x6n2DARNoWGmFo9DAmdr/JNGGhvpbYMbDHcbyrrL2nFitwrya5IZWHavZ49V0aw4jH20VE/hdcbZgAF9Ubg0K3FHYaUA0l4KfhP1m0Cg1sBGy2fPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639467; c=relaxed/simple;
	bh=L23tTLiBe2b7sgdSRGfvZfLh7KNUbOvlds6WSVyPQYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+E58jF50k0lkhvTppOKYE5NzXFY214xWRQAfWixO5maiFYynEaHmq6igI0nR7TwuWM7BXoVH7l2jBJdHC1iYRCuBaF4R7VvJGyggzbgMf4SAqJe8a2L/17OT92QpfYRyLhuzQkgNUZHW08zg1RLfRSNyozigoWpDqAJnhyLZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZz3y3zG; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c1632faeb9so4237941eec.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639466; x=1775244266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHdbMRwuqWnRYgbmqY+SsmGUlT6k9iE5mPMFEtpe0wE=;
        b=DZz3y3zGvoc+cRtoD1znqO8c/RsrwGuf9IkrGONYB/Jn9AlUPNDnGqHzJXno17r519
         xiQmZPn2cpxpr3Vdk9S4a/ssLRLIHoGhqxiFffUHyU+lJyRqEv5eNsg8SZtIhEfRSO/u
         L+JrYPXjIUiQZ1uXOX2RfcjYs7FHAvaY9rsewD1TbscScdyDIMhWcrfOg48r4c5GKaVr
         J1m523EFBoogvAYgO85mRwAKlqkSgKUOy+80ai2ehO4jNDDOeYVxRcGK9DLJqDpFmmNf
         GcS+W3BCVKbk7J6/sChcdlLkmrHdg9VWbrw9BDUcDmkA/0PFDFoFDaek1r83EIGjNNyS
         z5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639466; x=1775244266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHdbMRwuqWnRYgbmqY+SsmGUlT6k9iE5mPMFEtpe0wE=;
        b=aAojbEvqCKSgOqf+dwrZDXsI7BAabqn1se3OFF2PnFBPvBjTNZ4w0AU7hTx0nq8VuR
         QrHs5kVayChveiiBfznXdfX0sGyavY4YWaWmpU1Hxb0EWRGYBiNfleP8475x4NWQQcGG
         pGAzVW0g+fSklzJooUf2Dtq6T+YGLIZfwxuJmy3Vw5kTGb6+eoP9xTRJGioH43O/pi/4
         sBbBppIN0Uh6szgZJdGK3VS0kWuiEYYA0rigS9yopnb8irrTMsGNLtYxKKLNG+lTkSZu
         03yBFTX9fLWtgS0RbM2Yp/Qz9Fv21F8l6FsvPSKwKROX2SEmfq9XEP6R1o7KFsT7kr+T
         8FwA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/uhyUmWKQ/eOOLzcEeG8RYRDoKxx8obv7OYyYsF+symayhgUU/IJZshUqNphsaPR9R/byns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2aYau+LlIh8O/VHOTVmMQ7fV2E0Wy3tQ6lXYvT61yzz/E0n+
	TJPFA+m8MK3rzKvYnx3rpRL2DhZ2KxyN7yBn/lbd4aOuSlt7OWnsKJIM
X-Gm-Gg: ATEYQzx17GZqGtknePmi5pbMKuysViTri0x+sU4XI7wWlZBtmG3cQaRGZxfONNxFtPP
	Nu9G+nUGM/NOGd0xFUm/BecX/NluqhDPluTRaoJ1btkiqxS/LIzszjP5NdoOBK6t9mT/T6LUHY2
	AmALjMz+PfbRQ600c5aAVfxkkiKOCjXRfQaG53I4vWEks5gJVQZFArINb7Sk9Qs2d5RCy6gTizg
	AcAcUEyCEeie64sHfXRC3e/Mi2YryDhnUN8jC4CFSwK3pplWyZRAvLCvVqZ05SJwKYhgQQ3ngqL
	XJSLiQT82iNXb8eLinTOUytOeK4Kqx4dxjSSIW9ateTtPh11ptwpwf1gIJ1FCMjhHcAeTp9ZdvR
	YXbO4J+rouWxUEQH9URxLyzu8TrGlvaUVt9Xr2INAWNKuLOhuQt5RgV3arMFZm7/9XcYMhu8Uss
	SczDZ/3ZGhQ4TzoHhiW6rKGybUGNyrWp1LXOM5h1+YOB/HVDMBAXQbdHFthcpZA6OhnQ==
X-Received: by 2002:a05:7301:6781:b0:2c0:f814:5885 with SMTP id 5a478bee46e88-2c185dfe365mr2188934eec.18.1774639465478;
        Fri, 27 Mar 2026 12:24:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c79722e0sm187279eec.31.2026.03.27.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-atm-general@lists.sourceforge.net
Cc: Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org (open list:ATM),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] atm: nicstar: simplify allocation
Date: Fri, 27 Mar 2026 12:24:07 -0700
Message-ID: <20260327192407.365369-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272663-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CEBCF34A39A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member with kzalloc_flex to combine allocations
into one.

Add __counted_by for extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: reduce to 80 columns
 v2: use kzalloc_flex
 drivers/atm/nicstar.c | 18 ++++++------------
 drivers/atm/nicstar.h |  5 +++--
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 24e51343df15..c0bed85daf96 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -867,23 +867,18 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
 	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
 		return NULL;

-	scq = kmalloc_obj(*scq);
+	scq = kzalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
 	if (!scq)
 		return NULL;
-        scq->org = dma_alloc_coherent(&card->pcidev->dev,
-				      2 * size,  &scq->dma, GFP_KERNEL);
+
+	scq->num_entries = size / NS_SCQE_SIZE;
+
+	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma,
+				      GFP_KERNEL);
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
@@ -928,7 +923,6 @@ static void free_scq(ns_dev *card, scq_info *scq, struct atm_vcc *vcc)
 				}
 			}
 	}
-	kfree(scq->skb);
 	dma_free_coherent(&card->pcidev->dev,
 			  2 * (scq->num_entries == VBR_SCQ_NUM_ENTRIES ?
 			       VBR_SCQSIZE : CBR_SCQSIZE),
diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
index 1b7f1dfc1735..76635d46016e 100644
--- a/drivers/atm/nicstar.h
+++ b/drivers/atm/nicstar.h
@@ -667,14 +667,15 @@ typedef struct scq_info {
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
+	struct sk_buff *skb[] __counted_by(num_entries);
+	/* Pointer to an array of pointers
+	   to the sk_buffs used for tx */
 } scq_info;

 typedef struct rsq_info {
--
2.53.0


