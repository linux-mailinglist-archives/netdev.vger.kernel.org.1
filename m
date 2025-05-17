Return-Path: <netdev+bounces-191237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1928ABA745
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861731C01CD9
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92F15748F;
	Sat, 17 May 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPOLRgdR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383F4B1E79
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440694; cv=none; b=J5gceW8P6QBqX8mSD6sxTiQDOd3xe14PoN/ASKJZZF9bED9+cON9EqEj4lFVe4kgakMM2+QVKnAczAE4TU1Rwso2P4MiquJfbfK2/8Ec4tW7q+i2D5BQOeYnms97vJDAn9fGb+s0NwhSXCTlHrHwcLIlBgOtvguYBHc5WVUHDIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440694; c=relaxed/simple;
	bh=S/iv0GbiuRni+Nolcj2bw+f/wWk19KQJAIutNB+SyIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UlrYnoofwhggNR/lyS6Ft3v/2hGk643JYvWdTIr9cfpm2F1hJ+ZSRKgFW5TJB0lFqLarbsbOXvP0suTSLQz839MpNRujRQD+EVYw8WwL9D1m4UGriASDZEo7kZRiiBK5GHztJj0EN6rOvs1ziLqnYPUH90CUBLsDrLFZy90UK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPOLRgdR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso1676152a12.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747440692; x=1748045492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cr07PiM+lZeHxmiRK0zagShTWrhpMKb6x5MbT1urZAE=;
        b=tPOLRgdRVBIU8Bcztit/njc31a8MnrMtuipn7iFO9MpSKAwMo7SpAlsT7Wc036kv6j
         sOQWRpyvSsASYf3I+EX4i4XUCaLswLQdtdcRz4lSdaFknrNiVmOn8K5nZ464hh8GeWDD
         WQPLs2LK1OPaBqUiCpiUcKgXm2Y3wilL838tZgCF00AbvBGhl6wXUTq0yEwSZukj3HoC
         +VM7bk3ZGKkXnOYi5L8PCQvO6GXaVNte8sO4O8hj3vCwoYZ5fDWsBURsGV9P89yNSfjO
         Z7KOyM/QY49RePOVmRbxOEfMmot9tg7hh1T9VgpHemzfEAZUpVBn86H1YCoPggDxlhmm
         2Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440692; x=1748045492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr07PiM+lZeHxmiRK0zagShTWrhpMKb6x5MbT1urZAE=;
        b=YzTR6SIisPUIw8miMHNPRu1pOjPKK1od4GHwPlWPimbkxjXQRGV1p9wQEeyayYqG5G
         K7uw+1nFWQwPiFctSNUi+MZetIu/W6xJLSd/ASN2g5SNZSTjF00NrV3RzTZtn9pdEwJG
         NFLaqK9WMZSE4btRdtCPrF6Re+JNuuUi4TJoGWQ+8UAv+ZU7ab6+cOqx77GoaP1TNIUc
         nCg24JUClLKo+pV8QTNa6quTKQEVYqXnrOJFoC/UZ6WvbLAAHo4Q+nH3/ei0LVEGvsXh
         DFGOZoK1Qj5U5P118JpGyBvl7tRQpqJoYOcu9i+qaG4xPhPskN9S/IRkhmMi2UFUyFIj
         e8MQ==
X-Gm-Message-State: AOJu0Yz6yawJHbouq2em5foSyA3rRdvDmyr8NegTSOjC/enj7jjgo472
	Xaovl0lF15Aza/D/5OwX69bLA6Rw1CtmXY8TwOk8vVqqtCnf1JBjZwOEadImnb771+pKA2kVAbh
	CZUuN4SR4Ux85mHkq4uFiynJ9+fyizPow5zMGez2vXTokwodOflIFZgzen5EQdsb/jm15u6vGyZ
	Rk/CeWhc2G8Hcwqid9ji25GmAQkvWLdQ7wKc+WmMIy0qBYHz6zvzvtm+PMp2+0m58=
X-Google-Smtp-Source: AGHT+IE1AOpts6byPsyCEwN2aepM9ordZf/5sIwXYW6qwusQM0XbdD1U0V9/r7EWUMNGOs4AkPlvasYx00VQ0MCCUA==
X-Received: from pjm6.prod.google.com ([2002:a17:90b:2fc6:b0:301:b354:8d63])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a45:b0:1f5:8dea:bb93 with SMTP id adf61e73a8af0-2170cb07df4mr7684248637.7.1747440691899;
 Fri, 16 May 2025 17:11:31 -0700 (PDT)
Date: Sat, 17 May 2025 00:11:10 +0000
In-Reply-To: <20250517001110.183077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517001110.183077-9-hramamurthy@google.com>
Subject: [PATCH net-next v2 8/8] gve: Advertise support for rx hardware timestamping
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
 drivers/net/ethernet/google/gve/gve_ethtool.c | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index d0628e25a82d..043d1959fb9d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -929,6 +929,24 @@ static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rx
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
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -957,5 +975,5 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_priv_flags = gve_get_priv_flags,
 	.set_priv_flags = gve_set_priv_flags,
 	.get_link_ksettings = gve_get_link_ksettings,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = gve_get_ts_info,
 };
-- 
2.49.0.1112.g889b7c5bd8-goog


