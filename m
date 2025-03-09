Return-Path: <netdev+bounces-173378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC84A588B1
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35BD3A555F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4256214218;
	Sun,  9 Mar 2025 21:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E718184F;
	Sun,  9 Mar 2025 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557535; cv=none; b=lkEKQLhMyz324W2TiBnUR0yWnnAZ7ZYl6CKf2Jls7Fw/ib7a8WU77gCWavruMBAErrowwaps1PZvY+HD6QeL8w2c5sGOIJuKNoxsrjUpUeSe/zXSkxoleU/uEmOXfbVSg0gSzD9fGyaKTqTzRfBVnexT0vF/SZNwt9O/pYIy83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557535; c=relaxed/simple;
	bh=4X/7zgS7ELg+HZ3HeMP8NM2MJngTXfSPwy5i4ADSnrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXycVhvizK6P9DTspA138wR/adsHFe/IsmU+WZUszP5MgNoPPOrXjW2CpVEE0hnH5Uy1VRShydt0KWA4q9YycXFkeHpYhPgBv6YWdMaVgTucsG8Ov5e94MhtqA+RaFKM+OsV6O8i78EvSCZaECVGyJkUFyYlUGbDvMjU+T5KCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22423adf751so47350785ad.2;
        Sun, 09 Mar 2025 14:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557533; x=1742162333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2a7SmoeHEGl5Onz+EkPEONR/nzaHnY5dSapcOuXjhI=;
        b=SEuW/r67Ejgl/PZ97Bl8itGME3DAvzwH3l4pZ+xW8+H4MJo3wU+JiUugcp6BXPXUQl
         vpVFTwCHdfMDToy1V3MP415qOJY8h7gq/HMggS+z33Xkcm4cgPMiwPhK6vxWIS5nPgAZ
         OaaJII1PIAPEc6bt0JKhr5yJ2ESTVW0iWzGnmA0n5v7JzRR2r99O1WGkCjiuNTRKBkM3
         +N8t0BpqKEIeY1rLh7p0hZguON1alS0E6V4k4ynvwPRlKVwFWURRLHHEGWTfnMTzRG1i
         DkXIXYteFn5AMGXQX+JhZmeqUCsb44XU51Fp51uLTVGoGGWqXWAoaQTdtwibrkzluzNK
         hgLg==
X-Forwarded-Encrypted: i=1; AJvYcCXK5w2Eh8qlS6Nc2MG/Wx7t8yxtNRvGOLhd5o9GZ0434P56iWDLUN4brVxJpmxJNUKiawEz+33m8MUxNsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjyzoirfpfFs2d0JHcbTVr4PPJy6u/O01MadboeIuUGMSPU0ZE
	wmAn0Uz0rqjLjPqKzyalPXkIBT8Ohj1yJL9P8P50fsB1CRETkzosumQ7BZ2pmQ==
X-Gm-Gg: ASbGncvYSzjmJCEUanODbpc0IPUPBcA7qfIAQm+dFLwU+Oaqi7B+F/y5VNCj+stkJWf
	4sfeS++ggSZmx4PucvoAZo3UT9N5hxmTvqRn9EnZbqQ2xRwoV7yPPqjODHBAUdnhCfCZLjqBmsu
	DUkq9m1hJTU2TPIUmh7Zm6sW6eNPmm1mBs0qtQyMjhCseR6e6E1IpilHEim4Bt43Lgl2VB79LCu
	WTw+w7slE2jIiTtvzgO8EKtM5RBhCYgOhlE7LTAZ0TLiU789qpLYq5xSxFHVhoog+38h9eoxM9x
	EITyTkKtnFAQVk4Ty/ccdG6W2AwwYKdqhDDUiWNG7MC0
X-Google-Smtp-Source: AGHT+IEIG8or6GL0eh1I/QPMKJErwzbv6I3ycNlqGgoU6gz3cV/s86x613AlIQ8V/6WeUGXMDfXSVg==
X-Received: by 2002:a05:6a00:1703:b0:736:57cb:f2aa with SMTP id d2e1a72fcca58-736aa9fdbbamr16512880b3a.13.1741557533175;
        Sun, 09 Mar 2025 14:58:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af28126d69bsm6340302a12.51.2025.03.09.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:58:52 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me
Subject: [PATCH net-next v2 1/3] eth: bnxt: switch to netif_close
Date: Sun,  9 Mar 2025 14:58:49 -0700
Message-ID: <20250309215851.2003708-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All (error) paths that call dev_close are already holding instance lock,
so switch to netif_close to avoid the deadlock.

v2:
- add missing EXPORT_MODULE for netif_close

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 12 ++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c |  4 ++--
 net/core/dev.c                                    |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b09171110ec4..66dfaf7e3776 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12802,7 +12802,7 @@ int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		rc = __bnxt_open_nic(bp, irq_re_init, link_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "nic open fail (rc: %x)\n", rc);
-		dev_close(bp->dev);
+		netif_close(bp->dev);
 	}
 	return rc;
 }
@@ -12840,7 +12840,7 @@ int bnxt_half_open_nic(struct bnxt *bp)
 half_open_err:
 	bnxt_free_skbs(bp);
 	bnxt_free_mem(bp, true);
-	dev_close(bp->dev);
+	netif_close(bp->dev);
 	return rc;
 }
 
@@ -14195,7 +14195,7 @@ void bnxt_fw_reset(struct bnxt *bp)
 			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
 				   n);
 			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			dev_close(bp->dev);
+			netif_close(bp->dev);
 			goto fw_reset_exit;
 		} else if (n > 0) {
 			u16 vf_tmo_dsecs = n * 10;
@@ -14810,7 +14810,7 @@ static void bnxt_fw_reset_abort(struct bnxt *bp, int rc)
 	if (bp->fw_reset_state != BNXT_FW_RESET_STATE_POLL_VF)
 		bnxt_dl_health_fw_status_update(bp, false);
 	bp->fw_reset_state = 0;
-	dev_close(bp->dev);
+	netif_close(bp->dev);
 }
 
 static void bnxt_fw_reset_task(struct work_struct *work)
@@ -16276,7 +16276,7 @@ int bnxt_restore_pf_fw_resources(struct bnxt *bp)
 
 	if (netif_running(bp->dev)) {
 		if (rc)
-			dev_close(bp->dev);
+			netif_close(bp->dev);
 		else
 			rc = bnxt_open_nic(bp, true, false);
 	}
@@ -16669,7 +16669,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 		goto shutdown_exit;
 
 	if (netif_running(dev))
-		dev_close(dev);
+		netif_close(dev);
 
 	bnxt_ptp_clear(bp);
 	bnxt_clear_int_mode(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index b06fcddfc81c..b6d6fcd105d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -461,7 +461,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 		if (rc) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to deregister");
 			if (netif_running(bp->dev))
-				dev_close(bp->dev);
+				netif_close(bp->dev);
 			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			break;
@@ -576,7 +576,7 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		*actions_performed |= BIT(action);
 	} else if (netif_running(bp->dev)) {
 		netdev_lock(bp->dev);
-		dev_close(bp->dev);
+		netif_close(bp->dev);
 		netdev_unlock(bp->dev);
 	}
 	rtnl_unlock();
diff --git a/net/core/dev.c b/net/core/dev.c
index 1cb134ff7327..a9f2dc31ed2c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1760,6 +1760,7 @@ void netif_close(struct net_device *dev)
 		list_del(&single);
 	}
 }
+EXPORT_SYMBOL(netif_close);
 
 int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		 void *type_data)
-- 
2.48.1


