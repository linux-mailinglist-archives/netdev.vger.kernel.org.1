Return-Path: <netdev+bounces-294945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +1DDAi6oIGp96QAAu9opvQ
	(envelope-from <netdev+bounces-294945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:18:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7A63B87E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:18:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="sAlV/yy4";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294945-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294945-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FBD63010DED
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2044418F0;
	Wed,  3 Jun 2026 22:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17543D518
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:18:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525097; cv=none; b=REzCs5UPUuRMoxrWsH/noZygNu6+QhzoCMZ+5HS2YZM734SvUAszC/Hm62w6cJqOkHZQxdqKcDtxFTBBMKKLjSz99KDNYW9Tq+MwI6M9qBfdiSnKOzXEjwivUZqogmOWU5GeF/dAJA00bhPnpZb1BpOQLMEiEELOytBmWsGTAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525097; c=relaxed/simple;
	bh=DZJR7JiHnIxr/d/xhHstClpwxcMYObV5dZ1CAJ/DFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOwZIaskMsHxx6UzKmdQt/x2HvFkkDqNHQUBmtltZ4i8UYydqDJEs07aNLqzjDw9pSxycanRIeYWOi53PnWJf4XW+uuW19DIeNs4RBMVtJo4BJ+Vz6mvIDiaZLAuoN1aP6NoHuBwul7QGu1ftu7FcUURMPZ6W0SAyq5ZhRL9fZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAlV/yy4; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842358aaf36so12673b3a.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780525095; x=1781129895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ad37qvFp+RqpJv8WaZQLl/jkZ9QxP+cypLV1t8jzXk0=;
        b=sAlV/yy4C4b7vzoiN2g4g+hT/lk2oNCoDpuZ5lKIoDnmBnP6xnp3d9/hBQq98nDZsE
         NtOMapCL4lQPv/I/WdyEKtGGwhsoY6OUwsbEw5BMMJEyq4ztPdxB+WVjStw5FJF7lSd/
         AglrMMNDZFQGQf+7P8xPUd24CXVZLKwX8LpqGo0lvm70qVdzBptFBzYQyrNE60KhwiH/
         PRCg5TYETWGo+DWAkOzid6BSCafI9vb/tBlGKoYc0MtmhDV6f8vICHIh2KL3gE/VyhKQ
         ZRBJ4+G8CxlhL4uCTay5SLn5ECRSWgInrG5aXNkV9jU6PWzANVik032IIi9IK4hSXVV9
         V2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780525095; x=1781129895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad37qvFp+RqpJv8WaZQLl/jkZ9QxP+cypLV1t8jzXk0=;
        b=QtJNfDmvFBpKGN1xrek8bKwI4rnzZPSP5vdUNWEdlgV7/GkAF0dZN48ZSJdpeqFI0k
         hTihzT1KSz1tq4BgUxljw3ZF+Lbf7nTGMxhw+SK36jGQMgMvzhIGl0s82LqmqdDpF8qa
         SK9l7hHl6OdkHxHfZOZUNPlE5x2FQLde0Jc9HS8LeReOXU/IWBAa06WXOZblg9R6tbrn
         wLkZGQ/PvYHgMqonkOOpPybdPjQqDDJplZSwr+aaEct5KwiBAbgsSgN+I7gjvF1Tn7N9
         /s6cGTMK39JfN2Na64DmoUgYizj1SotgtJ/M1270sIa64OYzOsHPl31RA1TqG7w0R1qe
         KCnA==
X-Gm-Message-State: AOJu0Yzydm8vTsjQsykopq3Abz6ERFLRL/XjbdsGqH11XR4wgZuLzoka
	svRRFG2MlsSMnvqHNd4LD+McG9hdKIbPn2l3jtN5BF+Dg55lFl2DA/F6TsjHd1v3
X-Gm-Gg: Acq92OEsRj6h8Yf5wkib/AFk6oKD9qMsZ3vI7tmBytCAcoq/JXlTpCt7rYuS9Zdh2df
	LT3TMzRlo2ajY6W+621ZymHapDvgy9v7kBCrOQpm7W+v2R9qCAOhE68k/LGw0iEQoOorMggJ+lN
	E0OV7B9N0B/gtkM6yruDDiYBnXSKbLNl219RpjGPhoTx4kMN6joeBJBnVWVEqQKebx4JY7+m9y+
	52EShnXhLqFMp88BrmweKYT82VPe8viSUWTUeBvwVpF5dQB/p1oiW2x5ir0gWxSOeZRtc1rl63w
	Fcn1iRPIdiEhjolYkK3nOr1Kh+f+3rHZd0o/LbZjCYErmacbxTsUFxb1P+zPA7SZ8H64VkEBebF
	pdaEbimKndmi6TUCqLKGGxCk/3n40r4U6a+G7IMy9m0V6LPopRicdEo2c1ntdp6oBOOFLr5J/Ks
	y9iVing4ZsNtJJ1afq1qWlW9U+SrGbCDUA0k2cJjeVRIYEwlc56H0g0LfDVZulC2CcoE7i73aTl
	5+qnPnyMr4fLV93eY/HUtZnBFxNgME+1OEbdJIHX8i5RQ==
X-Received: by 2002:a05:6a00:14cf:b0:842:4327:6cfd with SMTP id d2e1a72fcca58-8428501684emr5311737b3a.49.1780525094963;
        Wed, 03 Jun 2026 15:18:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm4186747b3a.42.2026.06.03.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:18:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: ibm: emac: Clear MAL descriptors without memset
Date: Wed,  3 Jun 2026 15:17:56 -0700
Message-ID: <20260603221756.56203-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294945-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2B7A63B87E

Clear MAL descriptor rings with explicit field stores instead of
memset().  The descriptor rings are carved from MAL coherent DMA memory,
which may be mapped uncached on 32-bit powerpc.  The optimized memset()
path can use dcbz there and trigger an alignment warning.

Use WRITE_ONCE() for each field to prevent the compiler from merging
the stores back into a memset() call.

The skb tracking arrays remain ordinary CPU memory and still use memset().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Use WRITE_ONCE
 drivers/net/ethernet/ibm/emac/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index d2194b406c9e..b7568d96aa47 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1162,6 +1162,17 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
 	}
 }

+static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		WRITE_ONCE(desc[i].ctrl, 0);
+		WRITE_ONCE(desc[i].data_len, 0);
+		WRITE_ONCE(desc[i].data_ptr, 0);
+	}
+}
+
 static int
 __emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
 {
@@ -3089,8 +3100,8 @@ static int emac_probe(struct platform_device *ofdev)
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


