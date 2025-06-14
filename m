Return-Path: <netdev+bounces-197681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57DAD98F3
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EBC1887CC9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8E189B80;
	Sat, 14 Jun 2025 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVoOJpV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEED16F8E9
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859700; cv=none; b=FJCqqyeyk9Iy53WxUC3+0iDgNpe3zQ4aKbrzRFBmkGu9dIjeyGbTwQ4DXxSFzjyk3cDse1nYK52kSySxIRx+rXMnzyFxH0y3IoB2v+V4QlSt1r04RpR+Qr4dHVuXzz/T/yyXqDzOHt6vpcSi9m0JnRx/yWjQdwuNsfJbtTbL3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859700; c=relaxed/simple;
	bh=i2SJsezjKdHz4pBfByEDzI7aUH+K4JDCxAJyXh6TjAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i9yUa8azACMWZ+iEo3FQ/QgNCe1BQ536zI99cHavfPSVh10McsRXurj3uUVtGMpI6lWk988BBqBAla7PDrvPEKMqpULvwYPMnnLB2JbETOxPVbg3mXYslPn+NWxIte1s7FbKrB/GVnnjGeiJxOjJX6b9ZYY1xJG1YuiCAb14Q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVoOJpV1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74858256d38so1978924b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859696; x=1750464496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EljVQcnicnDvv/Y8OcFkMX/KVGrQBJDuCPNl1ok3h0U=;
        b=dVoOJpV1o/c5aTmM4Mq6F3aS5Tpv0LqpNVTtY0WstjjdUQg08Vk5bkWqEthhdJ1gBP
         O4yAoMGsnH6WRD9r0Y1Cum0zWLmELDfUy4ptp6Jc1KhsDrn472k8S/ufU0rILbnHRobT
         I5K/jGG+P6jDY81WbDOdWnEy9ozYSz9O+SmBa1i+jzVGdm/qY+rcIPY4lEsZol+0aN8w
         34QWvjppXvIfOhHLdmtFIH+2X3m2doUUIu6SMFiyXtabEUzRzzI9LBZDhy4xPeil+Ru2
         XBe/qTDvvRxvbVXd0IAOz/Sf86DG//qJbHsZEX2R6OYdTHy0d7cYvM1RV6EGoU6uCOn+
         9uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859696; x=1750464496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EljVQcnicnDvv/Y8OcFkMX/KVGrQBJDuCPNl1ok3h0U=;
        b=jJM13PLUqIbBf70Ag6v53VOPq9O1cYH3dVZqO0kHJurIYEIGaGaCYhCSTxIZdcq6Qw
         o/4VEVITjm6rws9uQGfX+91+zfQUU7Vf1O4t8xCksO2MskFXFd0q50e3k5LjG3QyhCoU
         aARrg1I++GiiDQXKsvghV0AoPVJL9+tYOsq9bZ1FzNKtvXuLGF5k6oGmSeV/0gE+04UL
         f7h7l+gR/okZMEDO23P10WgUB8QCtJfSfB2Shy7GEJRXJTat+bn6ITHFWfvWFGKaf4mJ
         jIPzHVi7xcNEQ4INqVxi6u1vHewtnud5Adjfru2dc+qmcwgZpOtoBTok2ftzcyqk4x13
         7dBw==
X-Gm-Message-State: AOJu0YwMSbzykC995E3SKk+f+aoeEiBiw2wsEBV3if6ZsMOvML2Wcbxe
	gDL6shV6GWLqTwnUoCifwgGbjfFvugaM4mge3oQHn8rsz9gmh57hcqhq2px2/q1tIjiB5M+qxSd
	wa/H6Qg2mQF58rN9BMhd9P2bgicHS7ouAolH/E24qaG+j5e5Zm8FOJ42ppZMwgg0A2H2ZhE2zaN
	npB6ZT5Nn0TBCup/XVNivhojBG93eQuvo9dXfWHz176WVsCLkO9mhD3nwvbmplQ8Y=
X-Google-Smtp-Source: AGHT+IGOv9d0N2cxkzxw1Yk+b3n0JGD4cBZckAigaeJg40gGm0MI2Gbz+6hCoB7tlaT9S+kpG8wgAlLMjDMbhztBzQ==
X-Received: from pgar5.prod.google.com ([2002:a05:6a02:2e85:b0:b2c:4702:db0e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:512:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-21fbd686cfemr1635658637.20.1749859695780;
 Fri, 13 Jun 2025 17:08:15 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:54 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-9-hramamurthy@google.com>
Subject: [PATCH net-next v5 8/8] gve: Advertise support for rx hardware timestamping
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Expand the get_ts_info ethtool handler with the new gve_get_ts_info
which advertises support for rx hardware timestamping.

With this patch, the driver now fully supports rx hardware timestamping.

Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v5:
  - Add the phc_index info into the gve_get_ts_info. (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 6ecbcee4ec13..8dbd7639e115 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -923,6 +923,27 @@ static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rx
 	return 0;
 }
 
+static int gve_get_ts_info(struct net_device *netdev,
+			   struct kernel_ethtool_ts_info *info)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	ethtool_op_get_ts_info(netdev, info);
+
+	if (priv->nic_timestamp_supported) {
+		info->so_timestamping |= SOF_TIMESTAMPING_RX_HARDWARE |
+					 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+		info->rx_filters |= BIT(HWTSTAMP_FILTER_NONE) |
+				    BIT(HWTSTAMP_FILTER_ALL);
+
+		if (priv->ptp)
+			info->phc_index = ptp_clock_index(priv->ptp->clock);
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -951,5 +972,5 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_priv_flags = gve_get_priv_flags,
 	.set_priv_flags = gve_set_priv_flags,
 	.get_link_ksettings = gve_get_link_ksettings,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = gve_get_ts_info,
 };
-- 
2.50.0.rc1.591.g9c95f17f64-goog


