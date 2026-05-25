Return-Path: <netdev+bounces-291320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HrSF3RHFGrzLwcAu9opvQ
	(envelope-from <netdev+bounces-291320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E725CAD18
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72CE9304546A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33B383981;
	Mon, 25 May 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCNky5FU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358C1D5174
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713716; cv=none; b=XuCs6jJB2KHOkjLLIWV5swRuELUlVSECfsp80+SzcrMFyILIaKWGYgGvIsAKQFX76SIBuXEOyjtBZ375V4sPzV6QOniNusGJskAFf5vUsCuw+D4CvsBkRToGR9ics4BLVnywcd/6Y9cCs6z5N/UzN98Ihbo2FpHKPOwoByT2jaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713716; c=relaxed/simple;
	bh=vlJ9dIitfSRX6Hp+DV819wrr1mJ8zzq0vV3pCabgDW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVFE2AitGIYutYFryXaioIOjOd/md3QjLJPVboUC1eqB7W2ZokW0QBg8MAWiAxdePu0AlpRxfuJqsCj7tDT2N2FCl0R8Dm7wre4/lpbN8Wl39+VgUWd6D9ymw+w3Yd2oQatj+B7jeiJ6GopcvIe/eQQD/V8QkX0pZdaFYYyCnDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCNky5FU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49041e84237so25441795e9.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779713713; x=1780318513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71scQDYFoHJPNq5FjR9pPrkAnYZjxu2ZgFiCuGYl/7Q=;
        b=QCNky5FUNo2bZQWxsWHw14RUq/WvVINyzCz7J7DjEGh3FFPDmKp/hcNWKMKzBSMNn5
         JISed7XIdgjbKAJ81EgE+NeEsjRgNl/xdtp0iblN1UwA0tqUddBK8a/OBnSec8PJrSQ2
         SGlorFOVUjSKmDYogyRJxNGJpB2aiBQiY6zNDxYuBpWpS+jpqnGFXGYoICXCEEEavi95
         zPytvDEfEeRbhJxatmFfDFKx2rtZlbSFDuXunVHvDAmQeg13AWeCeroWaWPg4spw6Rkj
         ZP9ijc9hL/QyHhQVFdGf+4sSPwKwWFMCxEIFUXRjsOPRvN8+4MhIswzuJh+Eln55ljvO
         6wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713713; x=1780318513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71scQDYFoHJPNq5FjR9pPrkAnYZjxu2ZgFiCuGYl/7Q=;
        b=XsO2nPH6Vo9hQ3FqZFCb4F5B4+dEYgAqod+rfaBEVbH32Npxk68gEV3lvDOQCoIL80
         /W/J6aEOyUpCZEBL6/tXpkBHKpkKzwW20feRritxJMAnYQIs79lE0WYnSAFZxGOy16QP
         LVog6Lp/RL2RFhLuxbZQMXPkFafJd6Ycg02oQOZ5ZY2VbHAAx6FxCfp69JqwrYGDIZec
         aJt8wlZapn8AtoaHKjBk4vIj+u0L9O/HcTc+/kqP6EVLuTH035ZbXa6KVy0WnY156CO2
         4WoULiSheo2WVLtA7k6QsWeD4pZVs6QMyoMlggKXKKAQ0Qx5h0Zgn/g88d6LHvtO6H2a
         /3oA==
X-Gm-Message-State: AOJu0YygGb/IwqyStIuKn+eWkEVJwbwDV0S7zGn4uFsCjcRAfDFnKwaE
	2lVora+y7H/ekza1NBJ/94E6axxzBqkzPIKW7omPaDRXSUE/iuPmOPeA93Nadhw0
X-Gm-Gg: Acq92OHZQa6xi/Az7Ks7JojA6+ayx19yVUv42+gxTN4D+nfA5ZdDX1/7KPNIPoIRStS
	Veuumx2ES+yGDVp8i2pe+PSzbKbEtLBuzigIam4kUOw66aExnUl8vfKNnZtKX8TAkRC/7nG+NVV
	PTI414rVmLchOYmngfjLRUUmBLXoD9oVnW6PvMnMegmN+BA5nYGLxNyieuUiuHgEa3uRJmohoi+
	Y0MmMOhG7WHt246D7er+yX0oh0Fi93EjSZ6TW/fZYbvHD5OaALpYmypmNNAui2HxXUFFhR4aST4
	UWQvrcp6CJbuXEJ3aFDiGwExVTIbnk/MqLJ6IGZHNcJmESDo1Wyglm2hQyNBjQU5SrdIRIudUf+
	JW/iKMhbpblw4lzXr9N3J/lqC67kUus/99ka71h5JTuj5WlnVI8SyNldtAhLh/mXpGTlhDOXU2M
	z+fb8QM/7j2zH7KPCEwC61
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-49042480f2dmr198500135e9.10.1779713712663;
        Mon, 25 May 2026 05:55:12 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm258009565e9.12.2026.05.25.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:55:12 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and napi_gro_receive()
Date: Mon, 25 May 2026 14:54:37 +0200
Message-Id: <20260525125437.4061-3-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260525125437.4061-1-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-291320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9E725CAD18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newer and more efficient napi_alloc_skb() and napi_gro_receive()
APIs to improve RX throughput.

Also removes the manual calls to skb_reserve(NET_IP_ALIGN), since
napi_alloc_skb() already does this internally.

In my testing this resulted in up to a 25% RX throughput increase in iperf3
tests in both directions.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 drivers/net/ethernet/amd/pcnet32.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 4f3076d4ea34..06d5432bb464 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1220,13 +1220,12 @@ static void pcnet32_rx_entry(struct net_device *dev,
 		struct sk_buff *newskb;
 		dma_addr_t new_dma_addr;
 
-		newskb = netdev_alloc_skb(dev, PKT_BUF_SKB);
+		newskb = napi_alloc_skb(&lp->napi, PKT_BUF_SIZE);
 		/*
 		 * map the new buffer, if mapping fails, drop the packet and
 		 * reuse the old buffer
 		 */
 		if (newskb) {
-			skb_reserve(newskb, NET_IP_ALIGN);
 			new_dma_addr = dma_map_single(&lp->pci_dev->dev,
 						      newskb->data,
 						      PKT_BUF_SIZE,
@@ -1251,14 +1250,13 @@ static void pcnet32_rx_entry(struct net_device *dev,
 		} else
 			skb = NULL;
 	} else
-		skb = netdev_alloc_skb(dev, pkt_len + NET_IP_ALIGN);
+		skb = napi_alloc_skb(&lp->napi, pkt_len);
 
 	if (!skb) {
 		dev->stats.rx_dropped++;
 		return;
 	}
 	if (!rx_in_place) {
-		skb_reserve(skb, NET_IP_ALIGN);
 		skb_put(skb, pkt_len);	/* Make room */
 		dma_sync_single_for_cpu(&lp->pci_dev->dev,
 					lp->rx_dma_addr[entry], pkt_len,
@@ -1272,7 +1270,7 @@ static void pcnet32_rx_entry(struct net_device *dev,
 	}
 	dev->stats.rx_bytes += skb->len;
 	skb->protocol = eth_type_trans(skb, dev);
-	netif_receive_skb(skb);
+	napi_gro_receive(&lp->napi, skb);
 	dev->stats.rx_packets++;
 }
 
-- 
2.39.5


