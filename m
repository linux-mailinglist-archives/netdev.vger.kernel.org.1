Return-Path: <netdev+bounces-108190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7891E479
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3F5B20DB7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DD16CD2E;
	Mon,  1 Jul 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqwB0xnf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF43236;
	Mon,  1 Jul 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848742; cv=none; b=eWMZo+PDxnJ63Nvz4iU2RmihSQtqzkLDmwAcIa2m9DELnio5IXrjJY4+A+ZshbC9uA27X2bKyaG/S7Fns38Yb/kRGNomeFsJaei8jKaKqWPoOT7M77BTw52wvc3WUXhLnDzxU1Ip5QNQDUKQ8DpP0HYZREOeXVF2xSCiymwaido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848742; c=relaxed/simple;
	bh=BJpuF+qN2H4D94Lbn1oafgSP8JlPrN6rF7Z5AJ15Y2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJaymk7YtaoTHcCZKoxXa73wIGbyh/gWzrqL7EVouL2jeSo+m3GNrybnTub5a3Flfs1mwYuhgW9pCNxdyqTKHTKp0VxD1yorhCx2YGTBW5hjStlP0lHj6zxOqpoYTUkTSJPszEqt9S8ClTu3Tjultru5uz+vMgzjlIckbwRMeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqwB0xnf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f65a3abd01so22809805ad.3;
        Mon, 01 Jul 2024 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719848740; x=1720453540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lio9CZj2DNKDmTsJ4lv8p6+SlBWYp6xlhdzI8/xHICA=;
        b=VqwB0xnf7whWAs7HI2CRUwTUEY0AQVw4LC8PllFZ48wEdZxDmuSmlvMVaYlZFkCyPf
         vRU38Ls0WIvyFm75cyyJzrELwptR2Gqb9HnAQuqYWBn39z7pLXvwqYNbPi7vWy6WyZIf
         8hlO2APJWFes2L3ePxsNc1CJz+ow0PyrgW0RwmqRPEVLcxVdoTUN2UF9YoCBL7T71Y/M
         Ft1RhQJW+9fYArqasF0zOlosdvpKKbqocTGj3c/Zw6Qs07X7gg2jKIiO8wWxmTDZLCSD
         G8gwl1Lr55AFcHlxK146I53ML9I0pj/jRwrnw09ujBQO52E1hrnpSOfVDtfunWylycw5
         xCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848740; x=1720453540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lio9CZj2DNKDmTsJ4lv8p6+SlBWYp6xlhdzI8/xHICA=;
        b=X7m6HrY8726e7BNh6zrFAqJfKTlADZLkL6F9jn6UIPUankk98FjDE66b7ZQAiWRog5
         VprwqNvWqFJbmwW9A1Nuw1XGLJJnAWGeQlJY3y8gOhodGoFEIYbjQNe4Q4ccLYNS3/qk
         1W5KsC1uByKE63bMuzuJCh1lKyKLLiolpvR/6xYB2cscRGPHboL7ZEReRxTpvRBwRh53
         WzWmNk7XbBG2cP1m+tkus4GBijeBrSHZumSzhLqrAedwmGPzMYRsTfaT6OedLsD1DzKZ
         zQAmLAfvV+2DPXTGzPp6m5asIHoq4Xxh51WL60qf6UQb2tZDA1W/ED8aDK7MnL9bQ/3W
         uRbw==
X-Forwarded-Encrypted: i=1; AJvYcCVI8MnutgySLXfJ51ukuTB+k+yasNXqM4UYI+3x634g0pZCqFusiLM9Wu2KhwEhx00879ZtQaodEmuzsgD1vZ2Yj3omfzdFzjCW3wxVlS5M6Uo480+ZH+m5TntHM3o2SzObeiGs
X-Gm-Message-State: AOJu0YzykpgoS2znhuYqov3R5x1jtA+MWZIGOpLIAnQ1WiXw9ZSlvqCe
	wET1VM59Ur0tPwNpCnpij6ushP5KAurhQX8rTfpdbF5/Np+rI+xF
X-Google-Smtp-Source: AGHT+IFYA8L69xtE66AmoGnWuf+uQ1nNG56C9lr5DaOcRK4zk3BwYIAH3sUuuKnt54HFH2juPFCubA==
X-Received: by 2002:a17:902:d50c:b0:1f8:64e2:73e4 with SMTP id d9443c01a7336-1fadbc74991mr51183845ad.21.1719848740067;
        Mon, 01 Jul 2024 08:45:40 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15694ecsm66393055ad.226.2024.07.01.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:45:39 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cosmo.chou@quantatw.com
Subject: [PATCH v1 1/1] net/ncsi: specify maximum package to probe
Date: Mon,  1 Jul 2024 23:43:36 +0800
Message-Id: <20240701154336.3536924-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most NICs have a single package. For OCP3.0 NICs, the package ID is
determined by the slot ID. Probing all 8 package IDs is usually
unnecessary. To reduce probe time, add properties to specify the
maximum number of packages.

Signed-off-by: Cosmo Chou <cosmo.chou@quantatw.com>
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 net/ncsi/internal.h    |  1 +
 net/ncsi/ncsi-manage.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ef0f8f73826f..bd7ad0bf803f 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -341,6 +341,7 @@ struct ncsi_dev_priv {
 #define NCSI_MAX_VLAN_VIDS	15
 	struct list_head    vlan_vids;       /* List of active VLAN IDs */
 
+	unsigned int        max_package;     /* Num of packages to probe   */
 	bool                multi_package;   /* Enable multiple packages   */
 	bool                mlx_multi_host;  /* Enable multi host Mellanox */
 	u32                 package_whitelist; /* Packages to configure    */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5ecf611c8820..159943ee1317 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1358,12 +1358,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		nd->state = ncsi_dev_state_probe_deselect;
 		fallthrough;
 	case ncsi_dev_state_probe_deselect:
-		ndp->pending_req_num = 8;
+		ndp->pending_req_num = ndp->max_package;
 
 		/* Deselect all possible packages */
 		nca.type = NCSI_PKT_CMD_DP;
 		nca.channel = NCSI_RESERVED_CHANNEL;
-		for (index = 0; index < 8; index++) {
+		for (index = 0; index < ndp->max_package; index++) {
 			nca.package = index;
 			ret = ncsi_xmit_cmd(&nca);
 			if (ret)
@@ -1491,7 +1491,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		/* Probe next package */
 		ndp->package_probe_id++;
-		if (ndp->package_probe_id >= 8) {
+		if (ndp->package_probe_id >= ndp->max_package) {
 			/* Probe finished */
 			ndp->flags |= NCSI_DEV_PROBED;
 			break;
@@ -1746,7 +1746,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	struct platform_device *pdev;
 	struct device_node *np;
 	unsigned long flags;
-	int i;
+	int i, ret;
 
 	/* Check if the device has been registered or not */
 	nd = ncsi_find_dev(dev);
@@ -1795,6 +1795,14 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 		if (np && (of_property_read_bool(np, "mellanox,multi-host") ||
 			   of_property_read_bool(np, "mlx,multi-host")))
 			ndp->mlx_multi_host = true;
+
+		if (np) {
+			ret = of_property_read_u32(np, "ncsi-package",
+						   &ndp->max_package);
+			if (ret || !ndp->max_package ||
+			    ndp->max_package > NCSI_MAX_PACKAGE)
+				ndp->max_package = NCSI_MAX_PACKAGE;
+		}
 	}
 
 	return nd;
-- 
2.25.1


