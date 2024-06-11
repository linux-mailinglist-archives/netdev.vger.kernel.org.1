Return-Path: <netdev+bounces-102700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F089904555
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534D01F22823
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5215746D;
	Tue, 11 Jun 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKLQYjoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C3156F5D;
	Tue, 11 Jun 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135496; cv=none; b=oSyhwsW1YNjq6b1MMx5klGeiF3k2TAVv5JUOz1EG7goo3gCP8ZkvsXMXcVYykhFqKfuD8MAfOW1ImK2jx0plBVNP2f9qFEKhSysQCmVvF2a18FdfwWKx4nd3zDWNpWkCVenJQ6SOB2U0eWBFXhAPy7Ab1qN6DP/Ry1SpKVypado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135496; c=relaxed/simple;
	bh=x4lM3sSavOZxrGkFF34xxMmDYW2tZsIScz98YOwR+Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zy/6sTeKlOH4DvVigUwte38hA9B4f3TINVc2v59nw3rCMXeczMCit5UtQrRjYl9ZbgmhwL1+sjccZ9jbxeP5oO16ajwGRBMx+chqq96qV70i4Df/WgukxBQ9oEd0j5MLDt/FKZj/vo9ZrBQ7kAVIfZ0Hf/zWMW4AQoeapKSmv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKLQYjoA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso66268511fa.2;
        Tue, 11 Jun 2024 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135492; x=1718740292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVXbCTkw3GJGcrXuQk5Rjkj3e+1RnM2j78ztInUT5TM=;
        b=RKLQYjoANCAFfpngL+RHaXHLBr7lHqRu8TCXReWU7xCH2jRqeXHx4w4y04ntBVZD/g
         6w+3PjQevr7WqhK2P3t9KOyMxb8yyBHuQ37MfsSadKnqblH1rfjS+h4z+L4cWDPj0MJX
         Y0JFk+G8bWBmPJzvBF4jBkLjhIiDs8s0sg12GWIQuSFrTfNLuD0VD6GHMxZoLLzwXfee
         XjxmNZyvxy9SmP39JSTeVT5gORCW5u2Hqhp8vqWXMOyWwL78lg6OGaSmMSRUez3L76TU
         U5c+YOY/G984YW6simdCyov/LO1+DDzYJLaA4VhqwGRdJVkgtLoEo6HUebXieKrFWW1G
         b94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135492; x=1718740292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVXbCTkw3GJGcrXuQk5Rjkj3e+1RnM2j78ztInUT5TM=;
        b=sQ8kRIYEguL6UXNTFcGeoAG8JJMsCN5I+7y6SktgxtNKDpQwntmX7OqjwKS+/71zpG
         hbI5BMdoEplptF2r7rQDNw9uj145XNR4DE5hHfg3itGlBIZy2RkZKnbDxnI2wMmYmi6a
         /DvLXQVNaz21LQYU++D4MXeLmoSjS+SLn3FfjC6oSLUlrl087mhiINZBsCuES/Sux8IY
         Wj53uBSqK61+pcBBGeiKxrd0VjbhU0qBsoOSQGDy72RbmcACuz8jJsVyjvMi3uXqy3EC
         5SHDVLw/X68khWduDOeFyPeBTGLtN/mJRIDYrNwZ9UGzbJD7M+gPSMIxy8Q11Jhx579U
         UDsA==
X-Forwarded-Encrypted: i=1; AJvYcCX4s2BZuaxc4QAFKZtp9g8sJgqz3CNlzkgZVbRKT6ycYAuW89jdkHgiTIM7feuh8X9lEMpdwUHpgOlfmDwDPDcSli609VQxZiApkR2l
X-Gm-Message-State: AOJu0Yxgzok7o5T5epTQ4D5UR9wKaSyRzGh5tf7bd2S+miPeLQ1GSDZg
	QFX7eHpqIou82cMKUmfpvJVmTGIPXejwhrZOkhzIJZSqV3z/6AiPjDvMABhhAfs=
X-Google-Smtp-Source: AGHT+IHXkJkUNKCuiSZ6Q5DQyPFyoC/V/XM2KKxrEac7bSQGwvvp9Ktw+xhF51POMJJA22To3NIrxg==
X-Received: by 2002:a2e:9592:0:b0:2eb:fb68:38ce with SMTP id 38308e7fff4ca-2ebfb683928mr1689311fa.28.1718135492575;
        Tue, 11 Jun 2024 12:51:32 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:32 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/12] net: dsa: vsc73xx: Add bridge support
Date: Tue, 11 Jun 2024 21:50:03 +0200
Message-Id: <20240611195007.486919-12-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds bridge support for vsc73xx driver.

Vsc73xx require minimal operations and generic
dsa_tag_8021q_bridge_* api is sufficient.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v1:
  - Use generic functions instead unnecessary intermediary shims
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - remove forward configuration after stp patch refactoring
  - implement new define with max num of bridges for tag8021q devices
v3:
  - All vlan commits was reworked
  - move VLAN_AWR and VLAN_DBLAWR to port setup in other commit
  - drop vlan table upgrade
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 86b88743890b..7d5522e146f5 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -691,6 +691,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
+	ds->untag_bridge_pvid = true;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
+
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_MASTER_RESET);
@@ -1651,6 +1654,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = dsa_tag_8021q_bridge_join,
+	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


