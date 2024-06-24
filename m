Return-Path: <netdev+bounces-106094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A909148C2
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259131C22282
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300EE13D508;
	Mon, 24 Jun 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="c7Tc+vCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300B13D282
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228621; cv=none; b=sfH9swysLAFZyd7gzRhJ9IWzBw9FHY4MHp3X05u21T2g+dLH83QL0MgoyZM6t8Wb3EUqukQhTEMcHr+rlS+snRe4xqUiYMJ1vgBd3IohtJaxEIrjHV0Yx5XYtejxvnUo3jG4aRyK3CprFkJJyWRAoKP9qyWEEGwUq8Rz91IJkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228621; c=relaxed/simple;
	bh=RVMYNbdN51kkjJnss2TueF1vuo8kFwKiti72srdqkOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dorL4ZfrhdEH0XM7rqipxsZ5+IaPQ/8/P4gTJ3/DW2Iq7JVyX+e/6ceP/LAv7tZ8VZaV6FuLk2OcYic1RJwZoZAQXiihcqUaInXGjGCFL3DdM88sAxgy51iaK23v02y4NPFC8rR+Lk6q0KP3XZgemFV0SVjXzNo4SwPDt6DscNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=c7Tc+vCH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so3133354f8f.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228617; x=1719833417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjKKswhYZfNAJG0X3IKY/rvV4CESAee1DJsp2gbMC8I=;
        b=c7Tc+vCHVz3pRSWLgL6tGADKRb7O8urSZb04kvpg64cKMt2AqjrNxWi40nwtfw3U1N
         IMjyPDrSGqd2eIwiL9fKn/jNvOEwAeIB16cp4N3Q3N4aqYkQviEmr+uC64Nde94kmkP2
         4N7fkw1uOrosWasu3R77BEtts2SsS75ajh7Qpa/621O0yzXARftNR2MbnOfPUHgOHnbm
         R4xb8YbexlpnoONU9T0JzXYUV6l3FkokYLW9DDggH7rYfUEOILRLTdHyMqddq9nljUL/
         s2/s6EEVm2DDXbkE4YXzKxzwTL+4N7xRGEuOECkEcOI4xvNUKStIHNumx0kwsFoB5WFF
         OhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228617; x=1719833417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjKKswhYZfNAJG0X3IKY/rvV4CESAee1DJsp2gbMC8I=;
        b=fW5jQeQMfPXaM4DJnZ7xBUZst509DwJ9S9axLReOzovkpRlxC2HyBRTdbgxrINj/iG
         hkWm4SU4BBfhr6kfMJvUi4mDsZPXW/208lnaHa1qKs92GqvkrXhHkb/UrsT1LR6YPWah
         F+dZPPvxfCKGUFUm7bS0SoEQIPEzrZHKoODfDvQFDvm0041yVhBdSTY0CKSSLbq9erc9
         L3OARiJmoOBcByzTIkoq0bQJ/BWmZsWyh+RDks99g8wA2xrwu3x30mpUCI9hrNET6uuF
         IzjYu2GU1manXcBx60LAc/pTHn1LeAJMhFfQKW6XJGReHVfp9TiurItnFqnGnu+hlDUs
         9kFg==
X-Gm-Message-State: AOJu0YzoqGhMTUwlkrn0yhwn1QHAtVBncpahx3XJiW7C32Io7NVHaZ1y
	MAbTkHgTpkGfeuYTltPI47dlygPoLXoR743cdAU9en3iQoqdH4DHFCJ7gOrhcDUr7rFDvkr3J/T
	d
X-Google-Smtp-Source: AGHT+IEONaUEVZ8dvcHs1AXMkH+SxBEcEhrp5rF7IcsuuQSgWEuN+Xnw88VvPTKsA0xaAa9x6OO9cw==
X-Received: by 2002:a5d:59a8:0:b0:365:aad:2f5f with SMTP id ffacd0b85a97d-366e9569f3fmr4195717f8f.29.1719228617134;
        Mon, 24 Jun 2024 04:30:17 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:16 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 24/25] ovpn: add basic ethtool support
Date: Mon, 24 Jun 2024 13:31:21 +0200
Message-ID: <20240624113122.12732-25-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index cefd7010ab37..985dfcf1744c 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -132,6 +133,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, OVPN_FAMILY_NAME, sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 /* we register with rtnl to let core know that ovpn is a virtual driver and
  * therefore ifaces should be destroyed when exiting a netns
  */
@@ -155,6 +169,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 	dev->rtnl_link_ops = &ovpn_link_ops;
 
-- 
2.44.2


