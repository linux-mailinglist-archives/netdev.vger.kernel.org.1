Return-Path: <netdev+bounces-232651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13970C07ACE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59FB34E96ED
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53624BBEC;
	Fri, 24 Oct 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Jh90TF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79996C2E0
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329761; cv=none; b=AV8rcagxT0LFkbR5VVCexfyDLB/qXE2hDeoKerP78v31rcwSWFi01IjHsVE1QYQg3lhUNiSnSrpggE9yK/poMpx6xg6lJA76wSkVGacVjZVjaiec+znyzF5iDbTQqreyxNRr3VWpKfjoaL20ApMJrF78cp0mG2zmXI5Hy7d/Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329761; c=relaxed/simple;
	bh=P76X8fvD2MPpFKEqZ6KTULh/PtWaUcgqMGqGoPlTXhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Js8M8ZNnd8GNvOZtKHvHCWcZqSqWdIN5P3C7zlm5759Qu/1cXDfEymxctYDBaUWxWECuY0BITcg6+kclYDBWYKlw1wYpQ7zKwPyVMi4XPJE5aDOkBGwpo9zAekgMNbX+u2YdV/my7tj27Uaayzkur7YedP5g61l3TytVmzCPR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Jh90TF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a265a02477so1862202b3a.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329759; x=1761934559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bw6e/G1JuUENm9jQKnlNnUfVAgZw6BFTm2ZBl0ARA9Y=;
        b=D7Jh90TFvDqg1AA23ORLhBAmMvEg//iivjvuBuPZayv/CVbq6jxeL3ejKI1QO5oMpH
         fFDF6yanpjRvHSqBDO83+h8bQVXqlM59kLe/eenQTluwBurj581RA9MirUWguvyINYKx
         N4seQmeu2RwxPEHDp6HCY3Zp2oDVZNzypuzk3M69VlZO2jTGxNrAMyVDghNaELM8G436
         6SIgWn7IZlBcImEdF7EZmeXA4tpRQ9vPgpxD35Yr1SysMok9/SPDdQWs9JJOzuE+kvRY
         qbbv7IGrAU9o/1HHBm11d+GVOl2LJ5z+fz/RzWcwL0xs2mFBKi0SqVBbhu4OBOLmwlxt
         F2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329759; x=1761934559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw6e/G1JuUENm9jQKnlNnUfVAgZw6BFTm2ZBl0ARA9Y=;
        b=jrK+kEOlETXrhwPUo34n+Eg2kVGLk7j/TLtao6MV9vEAP22RWpV+TMlTc+mdQQ82Ff
         bd9hm2v2PiLHK3Cfi4Ak3VgjPmHQZOEAjrPCrRk3TOLtUUTFXHS0PwaSeo47guKHFeX9
         bF4w0W9DF9DMARNDXJFOdHoYpT1AJ0nSD/wtL1C8y2cucafWeIxUm8PfOp3NPshMObnd
         +oaa84qU8Sy6WUpd5dY4QluXaBPHY89jfXt9kckiFg0+Ryv4dW675DxiBbIBPLW1jGBx
         gp95zs1EgHTe+WpRgZdPIoWKv9SL8gjOnRGHN2w47OQjjtuRNyHWaO8qJo2xUfw4Z5EW
         kCNg==
X-Gm-Message-State: AOJu0YxjkSuSP2OpJrD7aLkwA7/jOtPrxlwX3bJyPx2Qm+aI8uxTOmUt
	vy+MWZaIcXvg+yk2a9j05eSdCt3vE84BiZOjRdaWjNZKJLsKZh/VNXkk
X-Gm-Gg: ASbGncvlJmlh1XFroGzfUc4wxR0jHz9GlWEDjTTOIsRzxV3CMpU9D586LmjhclR0Rw7
	s1dqJf2WxCMQSzSUpVDqehPkTYxvHnLhFU8QqXorTXhn7Kim06+/+sEsgzdYiEtiosB0IvFiJQs
	Vf9/aDVrz4WxQpjHotQK+swRwo+JBTdLR2CNlCIbLiCub/Nlvb8hy402NdDNlhOhkMShtOzH2lU
	i0zZQh/EV3XeA6ClrZ49FXtl8Gwn6TO4tJOWCyA297Kw1JLLYdVbyrADuuHYSx/iLIH2HZc6GGR
	9mMsaA5isUecBcwi/qsXEshMeM9utoMuZ6vHx0h6Uom+QxYEsuxwyWbXUi1GXtcH0XC46rLQZwE
	1O3cWwWpqc5eXRVOSc1g/gTS7pt7Nezo1QyUyFKo/N2zTMZK22O7YbnNJ5etTkj057URJULQEbR
	lbCo6qWw==
X-Google-Smtp-Source: AGHT+IERA4tLz/ey+sqksaDd8O95SOQ+ftiTfmWz64Iw16YMS2qgAAmuUfqe+GtaoobHM8lLLXWy9w==
X-Received: by 2002:a05:6a00:cd4:b0:7a2:8343:1ac with SMTP id d2e1a72fcca58-7a286765c7bmr3304816b3a.2.1761329758753;
        Fri, 24 Oct 2025 11:15:58 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b822sm6724210b3a.40.2025.10.24.11.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:15:58 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH v3] net: ethernet: emulex: benet: fix adapter->fw_on_flash truncation warning
Date: Fri, 24 Oct 2025 23:45:41 +0530
Message-ID: <20251024181541.5532-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The benet driver copies both fw_ver (32 bytes) and fw_on_flash (32 bytes)
into ethtool_drvinfo->fw_version (32 bytes), leading to a potential
string truncation warning when built with W=1.

Store fw_on_flash in ethtool_drvinfo->erom_version instead, which some
drivers use to report secondary firmware information.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 drivers/net/ethernet/emulex/benet/be_ethtool.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f9216326bdfe..752f838f1abf 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -221,12 +221,20 @@ static void be_get_drvinfo(struct net_device *netdev,
 	struct be_adapter *adapter = netdev_priv(netdev);
 
 	strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
-	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN))
+	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN)) {
 		strscpy(drvinfo->fw_version, adapter->fw_ver,
 			sizeof(drvinfo->fw_version));
-	else
-		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-			 "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
+
+	} else {
+		strscpy(drvinfo->fw_version, adapter->fw_ver,
+			sizeof(drvinfo->fw_version));
+
+		/*
+		 * Report fw_on_flash in ethtool's erom_version field.
+		 */
+		strscpy(drvinfo->erom_version, adapter->fw_on_flash,
+			sizeof(drvinfo->erom_version));
+	}
 
 	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
-- 
2.51.1


