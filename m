Return-Path: <netdev+bounces-288680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IvfA8w3CWohOQQAu9opvQ
	(envelope-from <netdev+bounces-288680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 05:36:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74655F1FE
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 05:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13590300D173
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 03:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822AD280037;
	Sun, 17 May 2026 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlDspdIL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26B405C55
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778989001; cv=none; b=pav4R5fCA8U9BGZsJfNzwaWrK7eQPrRYoIrxTiymwmuBooBJBXDAxiU3Z0lxB8DGLGlQW5VGsUzP6+ahQdda5iUBSEUrx3kIefeq0L5A1tXOqs9MveQ3NAfq89+TrTK0sQ5mrR0MUrqD3f3UXfPL4Ch33Tes57rL0V6L82tPk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778989001; c=relaxed/simple;
	bh=whH7887zyQvZA11L50ur5qZC+bE5FTEbc1kM9w0jpA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzsJCp+4QlGowl4Dfb4NEJV0BE4dGQBwjoqwKBwvd9rQrniHGlO8+WY4gAuPedhlSsERo9CvYS/ueLZPISwah0ATmHkS7TiCcB450zkHN1sCp7sbgr4OZm8GAkkqUUZ9obTpL0JDsPcqSk6PwKMbf4BbE4QRwEpM9Na9KV5E33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlDspdIL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so466408a12.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778989000; x=1779593800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+qhnPe16QutqxQXlzcsyVZTSBMTfqcLNuKVINp5gDU=;
        b=ZlDspdILyR3kihlV4kcu9KEnbdLBUEPrVvvoelPHIKUesT2OD5l0bNNugkZnVcbjFC
         bEEeTmVNayhXoxYQKt56k50KnaDBL0DldKGW7a8m3Ak+1CHg5CWwIb3T8hOVbRsjkBPb
         0htWgILvKZhIuW5b1mSZBo4KOy/rnewIcuMDR6+Hws0purVv+HyPlbayEGe4XQs7OTlW
         Rv7t9nE0q2LMIGbjwg6Aa9uuHTyhs5K8QfIZpxOvAOTN2llQDjI6T4DuJnOBpTYopMbH
         JS/9g9NqRg/HjIubIAmj1UlXFPiofAQNq4AcCjMjit8MZMmAlIOd5z/VChRL5XDHR80l
         Njsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778989000; x=1779593800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+qhnPe16QutqxQXlzcsyVZTSBMTfqcLNuKVINp5gDU=;
        b=OI5hYojnUTm6CORKOV8QfKGcizWVtCIzLV0mEYOVLHXLrLkmrAOCb0vSbFoLiCkWLt
         +s2uTs603yUPw7+Mcapm32zpMSy+GcnBmihYWe3sGWXCCk9nznfolCuw6NXhLkc2aSj1
         8YFL1WkTlU5byHoGmR8poUf300gaP4dniuoIVdeCCbzyNoTXP/Fxpkm4UfZw/1fa/q/P
         LhoSePC449CID738UnWMNv1BfGWOrIo3ap/7Zohty1Pt87oWLpR/Z5nCTlknhAOVZXqv
         rbT7E9kQisx5r8pUhB75IzrJ7nMpigy9+oYMdarDVt6CRejbUFnIK7SDDDogB/IT3YT7
         3/Yg==
X-Gm-Message-State: AOJu0YzGeEl2WAb90UegcvaNbsFwy2d6UAKbABkp0bRGIz3Y5SoKaETZ
	AzWw2HEiLxlp4Ivycsow8eMksOZZwaP5GKkLRxgZ/RzvGC0tRy0IU0Xdl2PfLw==
X-Gm-Gg: Acq92OHfoYywcjLzrEVvBRKaEJYkXsk7x7Plk4xwI1+kmnGbqokNBzPP4DOob1iGrJt
	fRlHrInU74JqCQd6T8G4BjwFkIoa8bom4jYwwNrqm8KNcrHPoWYcofopJY3QpLe8PdkF9qqOuFK
	MECUp8+tGY8HQV6MGf4nXJu7LSaQ/a1x7b62OQrQd5AeQztHabaA/d4IQku2CrQ0ReFwk4it8g3
	H6VR/7YtN0fGt+LqpC49H4oy5yQMrMJHCe7OXZfqWTcWDrE+RjsiOGqEjd5LJWuJb6aH4pMucSv
	ZXjjCmZbHUeKS+gyQu8VMePxMXiBHxyI5NO212jjyaNw/f3HZw7FZoFVAVpNmI4N2ATop36HIiL
	En8aAh4Ui5rqLxV2JXi5Rmoy+aAwz1auZG91wECkrISFYqAH6wg8LltAjC88EuCELg3ihzc367Y
	KE4ISQD6NdZ4lggnZ4X859QEL+rHvHZlOsUCXYaaBmP5rlqW7TSpQ1UIdzF8U1ZrfXsJYwUyA+3
	pTvtrE5XrQYk4biqv/S7O2FUpT5rW65ITo=
X-Received: by 2002:a05:6a00:3925:b0:838:29b3:9ed1 with SMTP id d2e1a72fcca58-83f33df85ecmr10195406b3a.41.1778988999295;
        Sat, 16 May 2026 20:36:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196647aasm9794224b3a.5.2026.05.16.20.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 20:36:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ibm: emac: Clear MAL descriptors without memset
Date: Sat, 16 May 2026 20:36:21 -0700
Message-ID: <20260517033621.1839397-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A74655F1FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Clear MAL descriptor rings with explicit field stores instead of
memset().  The descriptor rings are carved from MAL coherent DMA memory,
which may be mapped uncached on 32-bit powerpc.  The optimized memset()
path can use dcbz there and trigger an alignment warning.

The skb tracking arrays remain ordinary CPU memory and still use memset().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 1fd7cb50c568..7ab5c944f5de 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1161,6 +1161,17 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
 	}
 }
 
+static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		desc[i].ctrl = 0;
+		desc[i].data_len = 0;
+		desc[i].data_ptr = 0;
+	}
+}
+
 static int
 __emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
 {
@@ -3121,8 +3132,8 @@ static int emac_probe(struct platform_device *ofdev)
 	DBG(dev, "rx_desc %p" NL, dev->rx_desc);
 
 	/* Clean rings */
-	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
-	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
+	emac_clear_mal_desc(dev->tx_desc, NUM_TX_BUFF);
+	emac_clear_mal_desc(dev->rx_desc, NUM_RX_BUFF);
 	memset(dev->tx_skb, 0, NUM_TX_BUFF * sizeof(struct sk_buff *));
 	memset(dev->rx_skb, 0, NUM_RX_BUFF * sizeof(struct sk_buff *));
 
-- 
2.54.0


