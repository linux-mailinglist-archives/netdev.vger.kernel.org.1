Return-Path: <netdev+bounces-77149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86878704F0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1BE1C21E51
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D04DA14;
	Mon,  4 Mar 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MmXvA6He"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED54D9FD
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564970; cv=none; b=JwGqCnkjDz9K26ULvGQoJGVy/ScMlcRfFxkt1snoLIU7Vs+rp7LKGCoThMYurMO2kAwnE8ApO5k4gxZmDMm1ZKgvmwCRbRBz84F2lF+dAdJ9LLNF8+EFSelBztjf3WJHy9wOvE7L7VYPpG7c2Xiq3A0eCHCrpchy6Q1N5tWoLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564970; c=relaxed/simple;
	bh=WmY5c0JAeq9MaIxMGpeGLhjpsd8Y4/c/swBIykKkd88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQIupYHKtOkPUjTuleC2fJ6Tpy77Fe/JWXQZyF4Qvpin0nE+HLwSymK+ICfaQ1+J8k7b7lHaQfcLRc5FUCn53jYDWPCg6OsMZBn1exwmlyMwYiubchxVsdH4+u9w0uFv9H9n/6QpUuqiQWOKnK/1Aapnxaykbg8RT98/yATjQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MmXvA6He; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so752583366b.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564967; x=1710169767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7GWjEvF3ka4PjyG2YOpl5TtYveZDQ/4qEeJOIti3g4=;
        b=MmXvA6HeaHNLdP3LUpz2dJrxOE/roC1a/HupjlSgraDnpbVRy8CAm/d3bqKACkudvc
         HFQvommVtVIZPww1XEPl7pzSnw+pGY897Mg4LU77YPxfMEL1+ATMF2ySdFh+DSpbiK1i
         NU5lR+VTcBFx9yTPxjw+AltKGxILF0aiO84xKclfoeKWKZrxm1lhanwnzn4crCF1rRTc
         xokWIitSp1KJrRmRniEvYZNrqtDQRTthH9+TX+c4KQcsR+A0HCPWGasGFIC6U6G/n2bu
         bSVunC5/Fd7qDiB4VGArL7ely4pRE8+K5qO0gETNOiFUvSJsFLsZRpCxpjrm5Sls+/LZ
         REMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564967; x=1710169767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7GWjEvF3ka4PjyG2YOpl5TtYveZDQ/4qEeJOIti3g4=;
        b=QArWPXxFfAWR9U1meo4S+rEMS6rKG+Pyb1v2+GM+FAC94+XlYYbRfJn2O6vAasvgTi
         EfUEu+Hk+uHPRlv3PsYEt21IyDNOxalU9oqoZcw8pWH+OUL33yk1r2Slxb33p4Zbk14y
         mWGqY1dkQPqaAA2vlpwEYqYGKpzS2zgp8VEcGvYVC+tpITp55jhpqjX6nKWsb7HZNW+4
         WbG5npzMvgaog/tIwmWSfLP46M3zTocsyraIU/+j8gHOJD+3bXe5g+0SxLgsQqtitTcM
         gLtjU2IvqMpebj4HEhbUoFvfJcGn6p9NK4sVGF08/O1WSO6uTH/UfZhUcHqTqxkd972/
         CjQg==
X-Gm-Message-State: AOJu0YyCR8lD+dC5imdL7mZqDqzFb0bixGohYjqRYIBD9GWsVOmJ1+ul
	88qv6xPpEkq3bjNyX1IRBlNfUNIIlIrISoTRSREMNd9rAGQ++ASKFC9Rg+H0NIWfKATm21HqfD7
	E
X-Google-Smtp-Source: AGHT+IFYE8QDJ98wj+d7nbBDZAXa1NSYEpiCDayxq/3S9GX5l0DPWH+gMr/92hZJ8jFMt7Dg25dzBw==
X-Received: by 2002:a17:906:2cc5:b0:a45:87d0:9010 with SMTP id r5-20020a1709062cc500b00a4587d09010mr505578ejr.76.1709564967362;
        Mon, 04 Mar 2024 07:09:27 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:27 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 22/22] ovpn: add basic ethtool support
Date: Mon,  4 Mar 2024 16:09:13 +0100
Message-ID: <20240304150914.11444-23-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 95a94ccc99c1..9dfcf2580659 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -13,6 +13,7 @@
 #include "ovpnstruct.h"
 #include "packet.h"
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -83,6 +84,36 @@ static const struct net_device_ops ovpn_netdev_ops = {
 	.ndo_get_stats64        = dev_get_tstats64,
 };
 
+static int ovpn_get_link_ksettings(struct net_device *dev,
+				   struct ethtool_link_ksettings *cmd)
+{
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, 0);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, 0);
+	cmd->base.speed	= SPEED_1000;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.port = PORT_TP;
+	cmd->base.phy_address = 0;
+	cmd->base.transceiver = XCVR_INTERNAL;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+
+	return 0;
+}
+
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->version, DRV_VERSION, sizeof(info->version));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_link_ksettings	= ovpn_get_link_ksettings,
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	/* compute the overhead considering AEAD encryption */
@@ -95,6 +126,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->needs_free_netdev = true;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_struct_free;
-- 
2.43.0


