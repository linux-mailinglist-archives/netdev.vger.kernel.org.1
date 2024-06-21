Return-Path: <netdev+bounces-105782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F727912D50
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F07B22789
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0580217A934;
	Fri, 21 Jun 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVfFIBou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373116631C
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995211; cv=none; b=FhLxNxz6QE8KzTDSXg7/k4cyMznJMw/DGofZu186sWh8jQdMSUpME0Ll6T+8raMarZ3lW/ieUb4CSBLLflfkB1pgN2GROpt4gd5IaJVCe3OQaVvecP4mgFLOhvNXzWqYIvA/VvtX4oUTTPik/Oy2KoNRzqYBpQJQNeFzxeDXgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995211; c=relaxed/simple;
	bh=rApctIhVi7cdAOhEyqi+uhU0WgA1lcXErGhYm2mePr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTefD9E3kJs0dq4d5c9ChC3csGYvWRlMznc3MNEpmp2wbArSRfMwtTecwG4j6ADIKq3SUd7wI1LeGDt/KkXy7O4VVcZme9c0YQ2TbIDOuz6exRrjmeYJpgX9YWRQhU4JSJRGAKU8h6T2wMLIFBK7Ih4pyrgXI9C9oqZ/gbfRtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVfFIBou; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c1b27e0a34so1097252eaf.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995205; x=1719600005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/GH/FDXuyfNhUERuFE3PVy696MmJwbOJjjtZC6JyQ0=;
        b=NVfFIBoujkKO2EbkaPQqI4F/pueRhYHwfQ1czyuV6Kop0JVfPGyNG8cLKmx7kXj2As
         EK47Nq8s8fcOWhHNymqeu5h++dVi5s6IYMRLQLgDnohuFkaOLOQPT256swtEBWF5OTeq
         FB0Ses58Ns1R516MUrg3UeHGcT0j8CtdXuZACoZ0tII3nxPJVM9bRLaO3akOBizRIgaE
         TGvCRcmOhFpA5QQNSbHGsiERvSbClxytgDOmWDB46FGUHZhcrm71L/Eq5eOloNzFB15J
         TD6BlHAzx7o28Zx/so6/HuiZXPrAW2zMxj6JPEkfYENbENTP7bsBvjXjp23bHvng3fd7
         dDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995205; x=1719600005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/GH/FDXuyfNhUERuFE3PVy696MmJwbOJjjtZC6JyQ0=;
        b=AcXUsgXybJLKr4Pr7gnhnIWZ7GOjEMxnUz4Bs+Mr23UdSKBQRDSIXmhgiLp9ytf/S1
         X/REakWxV20vGSwIOir6Q/dC8kih4EKboQ3L47hoYzc2zcGzRHM0Xr+6ETIAIevTobbW
         9ypJS8d9HhOE73w3iXL7HscTTyh0bpriOX0/UfOabFCtS/iclvVPOp2SsT4Mrrq6B4ZF
         3d67ndSOKjll17CaCXFgQ0e+rpmjkEQxwq1+Xea3KDXf4bVV4nfcjIJExytC2oDmvlGB
         bJ4CXCUIVo5ILVWFK/3Dk6jSU/3RYGiYHUCD71+31mruwV+h0BxdSA0EhV3Ada84IDu4
         EywA==
X-Gm-Message-State: AOJu0YzLx/4iptT/zD2DXRDAcJ3IT2eEgz7U9UBNXF28NAFwEnQut1pF
	Q6mZ1pXZ0/xzqkGIeu/zmaWTiEPq4pN9ztCSskY9hBzVYaDqsf+2QkyfCw==
X-Google-Smtp-Source: AGHT+IEz1SBhnLCXZVt1JbJLummokJyDTqmrS5cJ7fn7kY03Xac8ItvSw2aNuZFoiiObc4BtX+f/Tw==
X-Received: by 2002:a05:6358:6f19:b0:19f:3ee1:d1b1 with SMTP id e5c5f4694b2df-1a1fd60ba91mr1003914655d.31.1718995204588;
        Fri, 21 Jun 2024 11:40:04 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:03 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 00/15] ethernet: Convert from tasklet to BH workqueue
Date: Fri, 21 Jun 2024 11:39:32 -0700
Message-Id: <20240621183947.4105278-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts a few drivers in drivers/ethernet/* from tasklet
to BH workqueue. The next set will be sent out after the next -rc is
out.

This series is based on 
commit a6ec08beec9e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

First version converting all the drivers can be found at:
https://lore.kernel.org/all/20240507190111.16710
-2-apais@linux.microsoft.com/


Allen Pais (15):
  net: alteon: Convert tasklet API to new bottom half workqueue
    mechanism
  net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
  net: cnic: Convert tasklet API to new bottom half workqueue mechanism
  net: macb: Convert tasklet API to new bottom half workqueue mechanism
  net: cavium/liquidio: Convert tasklet API to new bottom half workqueue
    mechanism
  net: octeon: Convert tasklet API to new bottom half workqueue
    mechanism
  net: thunderx: Convert tasklet API to new bottom half workqueue
    mechanism
  net: chelsio: Convert tasklet API to new bottom half workqueue
    mechanism
  net: sundance: Convert tasklet API to new bottom half workqueue
    mechanism
  net: hinic: Convert tasklet API to new bottom half workqueue mechanism
  net: ehea: Convert tasklet API to new bottom half workqueue mechanism
  net: ibmvnic: Convert tasklet API to new bottom half workqueue
    mechanism
  net: jme: Convert tasklet API to new bottom half workqueue mechanism
  net: marvell: Convert tasklet API to new bottom half workqueue
    mechanism
  net: mtk-wed: Convert tasklet API to new bottom half workqueue
    mechanism

 drivers/net/ethernet/alteon/acenic.c          | 26 +++----
 drivers/net/ethernet/alteon/acenic.h          |  8 +--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 30 ++++----
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 16 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 16 ++---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 10 +--
 drivers/net/ethernet/broadcom/cnic.c          | 19 ++---
 drivers/net/ethernet/broadcom/cnic.h          |  2 +-
 drivers/net/ethernet/cadence/macb.h           |  3 +-
 drivers/net/ethernet/cadence/macb_main.c      | 10 +--
 .../net/ethernet/cavium/liquidio/lio_core.c   |  4 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++----
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 +--
 .../ethernet/cavium/liquidio/octeon_droq.c    |  4 +-
 .../ethernet/cavium/liquidio/octeon_main.h    |  4 +-
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 13 ++--
 drivers/net/ethernet/cavium/thunder/nic.h     |  5 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++----
 .../ethernet/cavium/thunder/nicvf_queues.c    |  4 +-
 .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
 drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 40 +++++------
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +-
 drivers/net/ethernet/dlink/sundance.c         | 41 +++++------
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 17 +++--
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |  2 +-
 drivers/net/ethernet/ibm/ehea/ehea.h          |  3 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     | 14 ++--
 drivers/net/ethernet/ibm/ibmvnic.c            | 24 +++----
 drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
 drivers/net/ethernet/jme.c                    | 72 +++++++++----------
 drivers/net/ethernet/jme.h                    |  8 +--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 +-
 drivers/net/ethernet/marvell/skge.c           | 12 ++--
 drivers/net/ethernet/marvell/skge.h           |  3 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c    | 12 ++--
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |  3 +-
 43 files changed, 273 insertions(+), 266 deletions(-)

-- 
2.34.1


