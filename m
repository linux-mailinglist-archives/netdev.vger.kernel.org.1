Return-Path: <netdev+bounces-188870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEB3AAF1BD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC779C39D3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84A20298C;
	Thu,  8 May 2025 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfMiW/9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D571F462C
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675241; cv=none; b=HwD0MHbMl+4YtT1oK+GGYlbco4eaT8k5Q5W89b44cUXipHC6xuFIXWBm+XkQgkb330FezOdhdisIkk50I5AkIBKaWYLdn0acCF1UZye011I0lj+Yau3xQc+GKp3NKjOVm9sCyKbCopP+iYZqdVM3AMS+1JZZ9YueoD4XShA8WZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675241; c=relaxed/simple;
	bh=LSmPhVGBDL68gKUL8fPnvrAdiAHjAcuJR93nnAFkgWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXFZ42zZbeLKFpVGjgOEs6jk7YwvqVGYGeP15qlNfZIkU97jMHPkk8ezTDJ4UwkzUxKDkUEoI7QPZXP4oc7jlLX/ypaY8u1z5tAs05P4AjKTK3g+doAOfy3LqoDqhkUfQtSvm9sEBob6PmT2e7GxZef6sMjxHIO/X0w5+/UU1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfMiW/9P; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so454425b3a.3
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746675239; x=1747280039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STwC2IS6exLI0zzWU7M54ip6dOGrQ7MtK7OABGaeWUU=;
        b=lfMiW/9PPZHvRD5VeKWrGi8+3bymoMjPVOV9Ni5U/yboFlE/1kpqIzBT8NBxspV3PP
         C5TT+UNZ8w54MDReiI19vVB72MakPL3mM097wFhBjEnF8+XDeHwqw7GEfHlxP6kgoC4E
         RufR9Elj5VvWXtTolgX9BM8zsuQKIGUT6Wn8FOS2hyViWYGvIcl9lr78n+NLJ83hTUu0
         kf73nj3qHKM5gynhgsDUze0V5XPmchATyRnfyU27LWq81371M0UPuzkC3pChWjK/KLJE
         e5F8jbS0FJvOnuCDpN68QYFqVvynCSAw0lbz14/DDwp5upssLacMstDd2yXt4coe3Ztn
         5JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746675239; x=1747280039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STwC2IS6exLI0zzWU7M54ip6dOGrQ7MtK7OABGaeWUU=;
        b=GnUA9C0jJ4eHbfADZ1i6D/Is0V7WQiAHty81hQPi0fX8bqXkO753pr1Whcud9rgpEl
         A9CxqfV1uaqav8tE7Dfra8tGmplj6w4hJ2r/0N4mC8YLBnDf/kpFLBVrPlmRGZVDyH3Y
         OVlchmBWDSwd4x4wCSoc9WSVzlfrJKX37VwFD21WGd7YSbcHDPyle+qK+KRxjMSH92Qb
         ZjNfTX1ME7XXT1RoYrFuIC+2bddxXZB1GQ1lSlj/BmFKhNI0rTDzBRNY5Bo7P+WdEKF7
         tx5xWqHD+vg0rNdo8whC3dLLDkwkdg30TqihxciNgHw4nQzuhmqPvKNdSksxeUYOROcw
         3YLw==
X-Forwarded-Encrypted: i=1; AJvYcCWi16b1l0dd/jJlE1XmRJYsnMht7iDDqWFLdbAhKKix4v72LgkbsCXoFs43/i1uzUrLdRnxM+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hKKCOgXqQiuM2ES1nl9qDNJtCZFzae/Uj/8HkR979Okc1f+y
	EYpWLuqz8lEqiyzNp5Y9SnFiKhbuZe9WX0b95RPlx3cd0o2ogJim
X-Gm-Gg: ASbGncsjZ7Hy+pVgU3vQ5izltw/+CLNvlREwpre336B+2EI85HJmpY1iKEfFL65m8mD
	GYQJjuQTywbg69ATarEFQIea1H1bO85oDhBHIteLEAT/6EnT2Czt7RuaQcKHeOASaoET2mIKM0b
	SqSSwoNzYwew/D34SiH5SspiKNc2Oz0JBPUXRuD2p6uQMGcJL4iNDLgTrLJ3KgNFj/UgpinVjBF
	lfD/BC8csFZGc3xvDM3L521X905XivzyBWzNTCsceN38zyc7ntVW5RpJv9wLb00lgeJ3AWsG/9+
	pHFwFQlbarmocdlmR39RFbmPl+LRLtE5ZCfJXixDF2WmJMYZHxVuHeKF8JqweDkhGOSLFZxnD88
	htfYpDise7Mql
X-Google-Smtp-Source: AGHT+IFNBu+spPs6hHuGIkVh1YINLq4WHn7KOys95hSNq9ZK93KPikPLdTAtOZWgFL0dDvNhanikHA==
X-Received: by 2002:a17:902:ecc6:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22e5ea3b7c4mr96108705ad.19.1746675239438;
        Wed, 07 May 2025 20:33:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ffdsm101685265ad.179.2025.05.07.20.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:33:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: irusskikh@marvell.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sgoutham@marvell.com,
	willemb@google.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v1 3/4] net: stmmac: generate software timestamp just before the doorbell
Date: Thu,  8 May 2025 11:33:27 +0800
Message-Id: <20250508033328.12507-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250508033328.12507-1-kerneljasonxing@gmail.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp as close to the doorbell.

In stmmac_tso_xmit(), adjust the order of setting SKBTX_IN_PROGRESS and
generating software timestamp so that without SOF_TIMESTAMPING_OPT_TX_SWHW
being set the software and hardware timestamps will not appear at the
same time (Please see __skb_tstamp_tx()).

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 28b62bd73e23..e7266e517edb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4497,8 +4497,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
 
-	skb_tx_timestamp(skb);
-
 	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 		     priv->hwts_tx_en)) {
 		/* declare that device is doing timestamping */
@@ -4531,6 +4529,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
+	skb_tx_timestamp(skb);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4774,8 +4773,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
 
-	skb_tx_timestamp(skb);
-
 	/* Ready to fill the first descriptor and set the OWN bit w/o any
 	 * problems because all the descriptors are actually ready to be
 	 * passed to the DMA engine.
@@ -4820,6 +4817,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	stmmac_set_tx_owner(priv, first);
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
+	skb_tx_timestamp(skb);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-- 
2.43.5


