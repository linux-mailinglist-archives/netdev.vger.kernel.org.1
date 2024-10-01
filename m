Return-Path: <netdev+bounces-131044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B998C711
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3191F249DC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A21CCEEC;
	Tue,  1 Oct 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIlRqlJ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98E14F9F1;
	Tue,  1 Oct 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816329; cv=none; b=jKRKFzVn6NBPRCzHz1o1b9cYE4urhlVxtspCpwLXXsMJ0JbOeoJ/fjvQTNt6VhUhZ+rqedZXkoJTJNECSvArEAl3uGuYmM5wdmIOC5LpItD2UEFUO/YD5JVLoeM9Hjrdi/rBiJPUG4/cGwnxTYBXlTB2LjJUT4PtI9toQqWhyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816329; c=relaxed/simple;
	bh=ncPRvHN48Uu5k+48+asgjzJmv72Y1PqSg/qY5ouvHJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbbHPHUdU4pyp88kZkZZhcUpXePvJCd1W4euCrboXR61aJs+FZsOWS5gYKgT9C8h7OUNslndPaLJKTwlA1/ePFL4YDEoBXpT5IrsSwoX65062G7N8hvOuyDesrlvSc6kQV59kzMfJEM9bscJZ45kjb5dWNDGccR5h/9qP2BYUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIlRqlJ4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71957eb256bso5428408b3a.3;
        Tue, 01 Oct 2024 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816327; x=1728421127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeKWKt2bpiIHq7T6szXkVDIrHT9awv3Xp3odCesEbWs=;
        b=gIlRqlJ42gCpRF6G1oj7tAmDZ1gb/oAsn1077+ZW1GpSIiVcn93gl8Mi4weafP4fli
         JBcK9iIXGxAZBhoXT89RWyulcAOVU9Z0MGSSYspUdjuRQLSLmsWAQZK30aoD1t2NSB6W
         GMGnCZ2x/PKhrMhT6xHw680nPNVR02MCMVr/63T0PS+aMx15LqdMaOHS9izVaUFZpxVE
         R0jSPcs2u7JB3Tql+N64UBkmF/yJ5zHZka7vDn0WR9X53Ohv5coAIXanqUfdGxHRNqO4
         ww6HewQdoTt+zEyzeB754iyV279QUBaGIS1ZCfG0Xn9+BR/3TG985NHzxHFmhEnbQX38
         2M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816327; x=1728421127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeKWKt2bpiIHq7T6szXkVDIrHT9awv3Xp3odCesEbWs=;
        b=TWRCJ4TmE9D2A3qihuhlZ0tnzl7xEITJ0VSkxu2RSQsU2vbrC5oIBYtKnc+u1QPZNC
         /MtnIuo7kBKh1edYuonvlat1iXBtInycMFL5/krtSxsSZjho49Q2l/GxuPfoXg3jhZcU
         GbHSZCTU8RvyjkHUQ8rVrv0EZ/qisslQTlPIjcySadeKsHcThze1mIA7aOuUKBcmAdol
         DSSibcK3xbJP3QlF8mNJMKO2rsCthelBELg56Y3j/YiesjlDrDOuQxhTsDTvKl1a5TNr
         KHvtxwpya4RTYjDLqajs10raNSRhxKXE+iLkznnQkqhToFEAoWWReA5P9iC166zO2Img
         KogA==
X-Forwarded-Encrypted: i=1; AJvYcCXDwb7650mlWoteuO4MnDFzRTwgTMF3uWHqO4e/EU9CKgg67f89ax5HUPOPxp147ejZ3g2W3ntP3PRWycA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLcwFY7J2A2gwBpeYZ50vCjdj5L7ria6vVD/Y4+X+8y6cQMTZ
	SWkUmgFzgS3WF4hKK3BrB4EvFB+JOr2SBU2LhAN+twjgx3cpovQp8VH9rqZa
X-Google-Smtp-Source: AGHT+IEH6Madu6We6K2A2bv+LRblE16FAY6PjadrOY4pF/XCF9AC91KlP9+4MAoCr1TnKxA9ALB2sw==
X-Received: by 2002:a05:6a00:188f:b0:70d:14d1:1bb7 with SMTP id d2e1a72fcca58-71dc5d744a6mr1589224b3a.28.1727816327008;
        Tue, 01 Oct 2024 13:58:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 00/18] ibm: emac: more cleanups
Date: Tue,  1 Oct 2024 13:58:26 -0700
Message-ID: <20241001205844.306821-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added devm for the submodules and removed custom init/exit functions as
EPROBE_DEFER is handled now.

v2: fixed build errors. Also added extra commits to clean the driver up
further.

Rosen Penev (18):
  net: ibm: emac: use netif_receive_skb_list
  net: ibm: emac: remove custom init/exit functions
  net: ibm: emac: use module_platform_driver for modules
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: remove bootlist support
  net: ibm: emac: tah: use devm for kzalloc
  net: ibm: emac: tah: devm_platform_get_resources
  net: ibm: emac: rgmii: use devm for kzalloc
  net: ibm: emac: rgmii: devm_platform_get_resource
  net: ibm: emac: zmii: use devm for kzalloc
  net: ibm: emac: zmii: devm_platform_get_resource
  net: ibm: emac: mal: use devm for kzalloc
  net: ibm: emac: mal: use devm for request_irq
  net: ibm: emac: mal: move irq maps down
  net: ibm: emac: mal: move alloc_netdev_dummy down
  net: ibm: emac: add dcr_unmap to _remove
  net: ibm: emac: mal: move dcr map down

 drivers/net/ethernet/ibm/emac/core.c  | 175 +++-----------------------
 drivers/net/ethernet/ibm/emac/mal.c   | 139 ++++++++------------
 drivers/net/ethernet/ibm/emac/mal.h   |   4 -
 drivers/net/ethernet/ibm/emac/rgmii.c |  53 ++------
 drivers/net/ethernet/ibm/emac/rgmii.h |   4 -
 drivers/net/ethernet/ibm/emac/tah.c   |  53 ++------
 drivers/net/ethernet/ibm/emac/tah.h   |   4 -
 drivers/net/ethernet/ibm/emac/zmii.c  |  53 ++------
 drivers/net/ethernet/ibm/emac/zmii.h  |   4 -
 9 files changed, 94 insertions(+), 395 deletions(-)

-- 
2.46.2


