Return-Path: <netdev+bounces-271846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNBVGMHFxGmu3QQAu9opvQ
	(envelope-from <netdev+bounces-271846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:36:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1932F6F6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A8430221C0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C7739E17D;
	Thu, 26 Mar 2026 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRbrYDQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487031B532F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774503358; cv=none; b=NTDrmudln6WKsQssk6kWiWoKm0x5xeA2HOFSNu7lMNIjAjhMunCe55xSfk+IFuvlqBrwP95IckwM5TmZzvldxYunHc2D87lg9II90GZVd92mxSHBvPywfyS1mK3F2wcNwy/cVLGeYT8YhNDBHVvBNOgxYxHMRlfDPDWqaU08I+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774503358; c=relaxed/simple;
	bh=Qr8ZdoV03XC8Y/zIkKOZ6eJPlAgDEERg45y8qVbjw7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOMJDUBPsJyhkHc8YFqbKHLCHQg2sw+Ye6sD2zlzgV2Fq3g0AwRUVMYUJEtKPZ4Y5FOTeA54Xvzfuk8vPMH8OgEKcBduomkCnnGqrVxvZuMUhAm7IfwsHcNiuQm21kJ0LltGh/c3wdZAavneXn4xmpSq+PsK2Cw4jpTuapI0ViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRbrYDQX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7412b07f22so771137a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774503357; x=1775108157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jGE1cCQwPm570qppMAHgNNyYwfNt8xMLKnlmo6j/5s=;
        b=sRbrYDQX6tXzYaRV/NjaQv/8TMEUDIG1QFHZw/LzYw9meNiX4+s5ni+I+RgHYyiigy
         WbNrpydM8hsgHkgCp6Zeiv6+bsuiiFN9sWKWlRnXCKNTtNLNPsydabe+Ql/3rypwK16y
         AWhcKXR/bPj1tRm5fxmLAHNaygAd/wuljWa2lh/NS9jvrnbyv+u9MpvV4+2tm9IPX0DH
         6wMKXIvPgTx2io13JoMsidL6DOvyZH1yqxz7AWv5EVYwpT5Vgce4H1SD3ThbBIUx8eTA
         wFYgXRyrtM3h2ao0DmAy9RUjGjOd1c8FfsXCDgBhGVPJDdBdS4zWtjQcUQjOy5P1Gw99
         jYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774503357; x=1775108157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jGE1cCQwPm570qppMAHgNNyYwfNt8xMLKnlmo6j/5s=;
        b=LmxCUV+bWaZsh61hEeawnBMw1I+qmmBJx6KCP/ifmdylm8OM9+FuTsuwh5IHxwckCz
         y3Cv69gxOWJryANVVn+ebngyEKw8P1DlZIDGvzLQvjGH6I6EMjDdadve0wVjstsF2Ktp
         C9CkW997/+GJBFT9oZie/NdAhXbAQ5EmGqBU7xUrMg9l6AGVxxyoblsz9QWE+NuzbCbo
         b0VH1RREx52qoQhAsfPt8llUJ9lFBe8wJQFNOg0w13sS+P7TxjspickvwPu4jo6aF6SR
         eE66+NFeXhYlVtD9HZybs04vRDYhaEsep3FndF0kT1jMCKnMmSVTJ2nK+bz9UKxVHEXc
         nYhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0/7VJb5e8VS2Jd5fYCa6B0sPIdV7Cm/66ITm5XGCizbWXxf3bKeyihht6VqCOCtKjcq8ggCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvnWThRxceNFna/S4IytL+GnxnU1maGYzDvYV+mmxHq6ME55c
	keIfFLjoigfKyPngxxxvxbRwMS7z/TB+PMbV8U5I9x9jmxN1Lb0wsO0qWox7WyIE
X-Gm-Gg: ATEYQzzD10HbNeDIZMcRd/pN7wDoYd5JqOo9helav9cerENOlz8DajJHOVSInyU6Ju9
	MX7QSSB50MnIUZgv5cR7YEv4yC/vbXCdvJzF0KJbYhCUONgAyy4W4ynhAZBmbnKQKaLMcgvP8Ev
	glZnrk4V6AilXq8sEzerzPE2OC8aa68QHnlT99ype9MYMCTUjfx42kACFJhoDotzk4FjT6ElaZT
	8e18im4FogctKCRaU/WPyb5NLJxp7IIipvD5fPOTV1zk02rbJGcMSNTzJAc7hC65Q7RL/436t9d
	MnC08nSStnkLPBWm6XwBGy+/z6fWObuNSZM5OVWyZVEzT8w6rZpEc4grOtcRZXPf8l3yXl5wHL8
	UGD9qgoBZ9TPsVWiT1tKYahgeCUjjkDFoHlmtoSu2Dzr9Xm2Zt9UGbiVW8Sd/KdSFhIyhIo26+1
	tGAF+M3SmBkTPQacrpYoDKYkc4BMC0fTSiQ7WNiSDUFie/N5pDrcGI4rA=
X-Received: by 2002:a05:6a21:3383:b0:39b:e3aa:df2d with SMTP id adf61e73a8af0-39c734cc786mr376742637.7.1774503356576;
        Wed, 25 Mar 2026 22:35:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c767382bcecsm1080464a12.13.2026.03.25.22.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:35:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-atm-general@lists.sourceforge.net
Cc: Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org (open list:ATM),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] atm: nicstar: simplify allocation
Date: Wed, 25 Mar 2026 22:35:39 -0700
Message-ID: <20260326053539.336831-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271846-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDF1932F6F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member with kzalloc_flex to combine allocations
into one.

Add __counted_by for extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use kzalloc_flex
 drivers/atm/nicstar.c | 17 +++++------------
 drivers/atm/nicstar.h |  4 ++--
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 24e51343df15..b01c6cfdcc87 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
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


