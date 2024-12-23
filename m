Return-Path: <netdev+bounces-154065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E319FB0A2
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B00118824B3
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D01B3939;
	Mon, 23 Dec 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oYWHFEge"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872A13774D;
	Mon, 23 Dec 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734966989; cv=none; b=gR7+TqTQlsNGJxgp/IvzeMjev0zQBrTtNW4Y32/dge5ocuuSTMh6AptvV+std8TyAbGHv/2mXpBnPLGrK0CE6eKIYLtulPKxd9wlW/UOVeinR7DTwTtMGvtblW0fcAM5XrXJ7cfPb65v0vmv2+KlNTIiXDl3Ftl8gNPeXZRiOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734966989; c=relaxed/simple;
	bh=MW45FBhLVmwRPmMRIL0HW17AQHDKkyJR47XdxpsB428=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CsVwR+yo9NNCxKGMekTy9lLqwxVo2+0J0Zq1SecZrIJRzutJ/I25+BIVOOwk8d6CrpsPrYRZwwlYte+6kAa2joPWtO/C9AJQfgDdOM1wqe2z9R9MYLm3xHsK5eag7USjIp77HRQySEqLxQSgw3MVNhydSWhKG1R/ttTTNA61wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oYWHFEge; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BNFFtE0029151;
	Mon, 23 Dec 2024 09:15:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734966955;
	bh=RZ3bqr04nq0KvhOIS+gUumh58sDmf7juaqfkgmz1GfI=;
	h=From:To:CC:Subject:Date;
	b=oYWHFEgeCFg8nTAlFpNfHpZNsL4pI6Mh0BfB+MC9in7UySczmzRmeU2qDeAHNU+qu
	 juKfTzeDA2DTHe9mCmOpH2A9f8mjyoiF5UJPzj75Lo4kvA1Y/XZiRmVTNIEj3ktB5o
	 ZPTMqUewu4ImCcUYzPnXSix+CvY9+M7y7A2pr3i8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BNFFtJH083429;
	Mon, 23 Dec 2024 09:15:55 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 09:15:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 09:15:54 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BNFFsIp116891;
	Mon, 23 Dec 2024 09:15:54 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BNFFrHn007379;
	Mon, 23 Dec 2024 09:15:54 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <u.kleine-koenig@baylibre.com>, <robh@kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v5 0/2] IEP clock module bug fixes
Date: Mon, 23 Dec 2024 20:45:48 +0530
Message-ID: <20241223151550.237680-1-m-malladi@ti.com>
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

 drivers/net/ethernet/ti/icssg/icss_iep.c      |   8 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  25 --
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  41 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 261 ++++++++++++------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   5 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  24 +-
 7 files changed, 244 insertions(+), 121 deletions(-)


base-commit: 92c932b9946c1e082406aa0515916adb3e662e24
-- 
2.25.1


