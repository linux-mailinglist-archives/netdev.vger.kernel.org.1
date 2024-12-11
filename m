Return-Path: <netdev+bounces-151116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6359ECDD5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FAB2863EF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0806236926;
	Wed, 11 Dec 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CPSEcCXw"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950B229125;
	Wed, 11 Dec 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925619; cv=none; b=M1et3hzW6k/mIywbbCsc3/uKLHyhg7HeLZjfIgNK9x4TlM57d4K0wk0iEO1WJHkaM+qoPwy7z+mvO+HF7bgKHwoDe9iDs41nMBg6f36HN+Tyk0wTvoOi1CgNu2TfuF/DfA6DnDmd6fPdnjXrXos15rjqDFFpcrVw/46o+WGXVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925619; c=relaxed/simple;
	bh=6Piu2wQhL5yvkMmE7SVErZiKRoBcAn/XSSNoj7g5a2s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i3TI9sXY10Rprsr5PTkQjJ0/9Olg9LpE5Daalfy3oE3TYd/o60c/sDb7veyZpEGN78d5z4rIvLcUnomVWWhei6V8INnSQftzytycvF3Nphy87SWtJqjuLtb/uzWADRvrVBxp1/3u50tQLuqxl/XjsziFRBN6C+Qw+B2rqQXotA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CPSEcCXw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BBDxjSF106862;
	Wed, 11 Dec 2024 07:59:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733925585;
	bh=4XcTbpcGauMKxbs/Ay2DbwbTbwP1rhksRd5dIJE9SlY=;
	h=From:To:CC:Subject:Date;
	b=CPSEcCXwxCg6O6so7Sd+k4006tZ9fRJOe4zhNmx0zu7s/tmsMHpNbyM6Bo+Ela/Av
	 WnJjQ+JDXfBRTn4utba9Au5iQkW9iDWKLN5EhL7wyce89WdY/BpZlmtFO39whlX7oa
	 P1ELeOSFtnlg2c1oD5wgtSPaFjGjOpLs88a0GANo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BBDxjlo129051;
	Wed, 11 Dec 2024 07:59:45 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Dec 2024 07:59:45 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Dec 2024 07:59:45 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BBDxjeL024826;
	Wed, 11 Dec 2024 07:59:45 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BBDxi7Q023882;
	Wed, 11 Dec 2024 07:59:45 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <matthias.schiffer@ew.tq-group.com>, <robh@kernel.org>,
        <u.kleine-koenig@baylibre.com>, <dan.carpenter@linaro.org>,
        <javier.carrasco.cruz@gmail.com>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v4 0/2] IEP clock module bug fixes
Date: Wed, 11 Dec 2024 19:29:39 +0530
Message-ID: <20241211135941.1800240-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi All,
This series has some bug fixes for IEP module needed by PPS and
timesync operations.

Patch 1/2 fixes firmware load sequence to run all the firmwares
when either of the ethernet interfaces is up. Move all the code
common for firmware bringup under common functions.

Patch 2/2 fixes distorted PPS signal when the ethernet interfaces
are brough down and up. This patch also fixes enabling PPS signal
after bringing the interface up, without disabling PPS.

MD Danish Anwar (1):
  net: ti: icssg-prueth: Fix firmware load sequence.

Meghana Malladi (1):
  net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during
    iep_init

 drivers/net/ethernet/ti/icssg/icss_iep.c      |   9 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   1 -
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  41 ++--
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 200 ++++++++++++------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   1 -
 7 files changed, 179 insertions(+), 80 deletions(-)


base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
-- 
2.25.1


