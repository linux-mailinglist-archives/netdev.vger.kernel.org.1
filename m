Return-Path: <netdev+bounces-128769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5140597B968
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C7A282C9F
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53D91509AB;
	Wed, 18 Sep 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQmsdA8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322778276;
	Wed, 18 Sep 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648542; cv=none; b=KF9ZxBCEhsGW2wtp5HFaYaxfyx+zDHmtykhkpSPoOEzaC9jWwrrjckoz1yipjhO30P66XJfwoaVl5rueajkRjq9ZfrPsE+fZcfBodPrb9/7JQTw+1aeE+ts/GOVOJrsKAZd6F/w5M2oMp/fr6AmBWzwxq5wx38Mz7uGBZVzlEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648542; c=relaxed/simple;
	bh=+zwGnH7NPgZSd2ADLAKt9KL3kMmt/snNitsu/Zn6vOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY4sQI6fEX+KEJs/tk+mJPXgQ804cNw8Y2XjBkDwflFd5ozseZ5S0b0kPDjGB/LSY7qZyUgiSUomuhR7+c2Qhz5FjLApfzhKp1JyA6dANWVQ1ib9DGJ/EOFS9lOGKrPueuL9Tx+TeeiHpCqZp3SNi5cg2S6cTKgoWjeiOk7hMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQmsdA8C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206bd1c6ccdso50055635ad.3;
        Wed, 18 Sep 2024 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726648540; x=1727253340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38bBL2qWduGTl2q4OcKtcbKfc0KBKAtuvg8lV/SztFk=;
        b=bQmsdA8CSLgz0F6HJw56R7i9EnsNKWf9xUTmnhMBmsX36KiGL28aEPThXvzzl49mCx
         3CTy+y66g8ULw0SOjdsIbN9ql8sBsOmixNzw//xjFGfRzUdDFJOqW7t0Z8galmVM1fU5
         x457tjHQvUo2WIpDHN5N32iLBL0/vvXEGPKcTzAqVYOLq1Zt07Tyi9cgHS51U5ixAA+a
         O5UrUj+eLUFvVNlPmOQmkgvBZ4cMrgXVJ/A7aa14OMLrSbKS/JamdDdsV0LEOPm2uijj
         qQFZYpIY0+txxbcecIMx3mUuc7xkPrtUQmmS6tydxlf5yABsPVAvw0apzQFwfXJiyTrM
         P1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726648540; x=1727253340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38bBL2qWduGTl2q4OcKtcbKfc0KBKAtuvg8lV/SztFk=;
        b=dNRjE52KFKbYWn1Jm5BHqDSZL8Q5GKgb0WHKKzCZH0YYyUwXY5qwKB82Scp9nbTaAA
         MV4XZ/5EhgjHdC/BnKVw5s4b71sJEQVfNjcKWLG1TNJ9hk1GHiTOqKqqj3+amabUssFC
         kTOvnf00durBH3qXS+Pb4PvDsH1Sqv8DYL5SUCrg0LaxgeX73ipe2ifyh9ovXdtcgnqO
         l7NkXRsxW01kQVlaooWRDRjOIW9R/mnyP3m/ROH964wWF5cTOESckJZc3WgQSYeqkqPg
         BC0riM1MkNdNDCKcGfJCHKxNBOH7PBxfUYyDq/JDthDVABGQfTFEHBNiOF4y8MP8y58a
         aG5g==
X-Forwarded-Encrypted: i=1; AJvYcCWItCrcw3wo74f9oAlKDOwhNwBtWRBTiEEG96ACV/Bh34vncCdxpxiMJwJkHU5HG0jwO87p210/zxJhspU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXZSSzGPofFprwsT6uy4fXsZ2kDNDNW7laRPrRIGqo77n4SE7
	PTDIloacP7/zeVrlwaEGbG0Gv703OcZv0AosrRk4lZ7DIxrdk5Dxd6FOSySnzx0FLQ==
X-Google-Smtp-Source: AGHT+IEnBf9QpHxSZLlMs0s6XzxC6bdRERseuBzgRbbSJYyck/C7rdMYaRHGt7Yfv7RcR6dZVxRl8Q==
X-Received: by 2002:a17:903:2452:b0:200:869c:95e3 with SMTP id d9443c01a7336-20781b42cfcmr286210445ad.4.1726648540187;
        Wed, 18 Sep 2024 01:35:40 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd60919644sm963272a91.42.2024.09.18.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:35:39 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jarod Wilson <jarod@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] Bonding: update bond device XFRM features based on current active slave
Date: Wed, 18 Sep 2024 08:35:33 +0000
Message-ID: <20240918083533.21093-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XFRM offload is supported in active-backup mode. However, if the current
active slave does not support it, we should disable it on bond device.
Otherwise, ESP traffic may fail due to the downlink not supporting the
feature.

Reproducer:
  # ip link add bond0 type bond
  # ip link add type veth
  # ip link set bond0 type bond mode 1 miimon 100
  # ip link set veth0 master bond0
  # ethtool -k veth0 | grep esp
  tx-esp-segmentation: off [fixed]
  esp-hw-offload: off [fixed]
  esp-tx-csum-hw-offload: off [fixed]
  # ethtool -k bond0 | grep esp
  tx-esp-segmentation: on
  esp-hw-offload: on
  esp-tx-csum-hw-offload: on

After fix:
  # ethtool -k bond0 | grep esp
  tx-esp-segmentation: off [requested on]
  esp-hw-offload: off [requested on]
  esp-tx-csum-hw-offload: off [requested on]

Fixes: a3b658cfb664 ("bonding: allow xfrm offload setup post-module-load")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b560644ee1b1..33f7fde15c65 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1353,6 +1353,10 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 							 bond->dev);
 			}
+
+#ifdef CONFIG_XFRM_OFFLOAD
+			netdev_update_features(bond->dev);
+#endif /* CONFIG_XFRM_OFFLOAD */
 		}
 	}
 
@@ -1524,6 +1528,11 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 		features = netdev_increment_features(features,
 						     slave->dev->features,
 						     mask);
+#ifdef CONFIG_XFRM_OFFLOAD
+		if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+		    slave == rtnl_dereference(bond->curr_active_slave))
+			features &= slave->dev->features & BOND_XFRM_FEATURES;
+#endif /* CONFIG_XFRM_OFFLOAD */
 	}
 	features = netdev_add_tso_features(features, mask);
 
-- 
2.39.3 (Apple Git-146)


