Return-Path: <netdev+bounces-143742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACC9C3F0A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB61C22676
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C336C19E7F8;
	Mon, 11 Nov 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JkHaimX5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA319CD0E;
	Mon, 11 Nov 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329956; cv=none; b=V6A6OM3cyy45taH/iDIrjKsR3kI19+Hti/j/aVt00afaaD8OUAIdpA4WJhUO3qelea8ZxCvnF4AGhOP8dUY/JOoaiwgFRngn+BFl7kA3WUg+bcNXxAGJIJExbE50VRIL1zZVqAfYxyfMwhqWhn3+5xrw/DDGse6mhNeUqEzQyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329956; c=relaxed/simple;
	bh=0WBtHqJpcKYKgQyCWLjfinIAAVDEtD/lYNf3aIBMDvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dunkx1lXhS2GxGkViJd+jhmeaN+c78IYXbAXZ5DrZE0EKhzVv9054wnqYc+H52jTUuJMyHF/ELc+FTEofv7nPa4PxqVDO+k+CrI0m30PP5kaJllgz0mkzNH8B7nY8Oalmy1UuC27AJv0mKyEKLsFN07jIOyGRmtXz7P23cni9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JkHaimX5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731329955; x=1762865955;
  h=from:to:subject:date:message-id:mime-version;
  bh=0WBtHqJpcKYKgQyCWLjfinIAAVDEtD/lYNf3aIBMDvE=;
  b=JkHaimX5X93hXqwBSybM/lZVRbvvm0t5UFofNPrLSp5dxvIaiwoZg6vD
   k5P8MtWi9pfR8c54twSkBi0t+ArsYjRJ32ZQNj6HorvBSt0xKxH3y+ubr
   5tyBEvTychw4eAxsR3+J17mu94+Vd/tJclnlr2fxyCCZRbwg+3HEQrV6X
   MNuqi9b3CIggs70jfdW4J9We/jpRM3L9qs9ysLRmpabzKcy2B9OSiB89H
   BRiUJ2AZGwn4XLXxgXoWuqNLMbCVjCeHIAlzBvqPiV+tLIQfIR8BLtVtZ
   UAtg5fp31Vy3T/7w+GvGLYPdwdp9omGLzTbDy5kjaQpDDeUBd8WgM7b+8
   w==;
X-CSE-ConnectionGUID: dZFC6vp0Q/6hLNqL+TdxVg==
X-CSE-MsgGUID: I67Ga0CDQ7Sq9vDrZLlvhA==
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="37646824"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2024 05:59:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Nov 2024 05:58:43 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 11 Nov 2024 05:58:38 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next v2 0/5] Add ptp library for Microchip phys
Date: Mon, 11 Nov 2024 18:28:28 +0530
Message-ID: <20241111125833.13143-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support of ptp library in Microchip phys

Divya Koppera (5):
  net: phy: microchip_ptp : Add header file for Microchip ptp library
  net: phy: microchip_ptp : Add ptp library for Microchip phys
  net: phy: Kconfig: Add ptp library support and 1588 optional flag in
    Microchip phys
  net: phy: Makefile: Add makefile support for ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig         |   9 +-
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/microchip_ptp.c | 998 ++++++++++++++++++++++++++++++++
 drivers/net/phy/microchip_ptp.h | 217 +++++++
 drivers/net/phy/microchip_t1.c  |  40 +-
 5 files changed, 1261 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_ptp.c
 create mode 100644 drivers/net/phy/microchip_ptp.h

-- 
2.17.1


