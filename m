Return-Path: <netdev+bounces-142246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9569BDF95
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19401C22F90
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AA1D2F42;
	Wed,  6 Nov 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uaJaysG9"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA541D278C;
	Wed,  6 Nov 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878868; cv=none; b=D272VjTsFwxtmzqigmwhuTC8kPzWWtWA4Ds54hRO007fvI5f75+W8k+lA3IFWt76sK5Ie9EKu8IrzwdsfqCNGMlkYwtCZnokpRJlNF8U5DIilnOO4j+kmynIJk3WwcDQPtyDblPtr8FVtEaBEM5Ja5tORwulSaBE1sB4qewkUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878868; c=relaxed/simple;
	bh=TFda4sI5uMZRqUDsR0dAWVgvzcedGeHYwrugMLEeeaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRqHO6A1Mynf/Uln45DepLIyTg+Z322NemryN6+l5m8zhgc9fjwwp5GLVHxqxd6aQAJqn3BpDCYbxbGVDE1Ydnk5EOmqMm8XTj8XwmNGTfQYgLjT1SOoPVT3YNYEGYMrSl0dYdtHjS8HRSLziYfIwXW4ZK+TYCq5Emtv8thS4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uaJaysG9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A67elLw017749;
	Wed, 6 Nov 2024 01:40:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730878847;
	bh=dkLZdfHad0BvKfYRCTi1v7nlEmkz9+TB8S+Kq67QAis=;
	h=From:To:CC:Subject:Date;
	b=uaJaysG9L3CXJigKp/2PPoUI4evbSyGirFRIIw2EJ0pMpM8LD+x5J3Y/vzFlhdFbp
	 +ZlEE5TtRPC+RXSq0WCvfeH0twaMD2+lMmRKTAI/5nCaEhlToVleWyPZxFLioPlEaG
	 RwsUgQy/jgEWP120DXuWz+TM1r4o3rO+dqBMOMIA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A67elYO054237
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 01:40:47 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 01:40:46 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 01:40:46 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67ekts010485;
	Wed, 6 Nov 2024 01:40:46 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A67ejXK014385;
	Wed, 6 Nov 2024 01:40:46 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <m-karicheri2@ti.com>, <m-malladi@ti.com>,
        <jan.kiszka@siemens.com>, <javier.carrasco.cruz@gmail.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 0/2] IEP clock module bug fixes
Date: Wed, 6 Nov 2024 13:10:38 +0530
Message-ID: <20241106074040.3361730-1-m-malladi@ti.com>
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

Patch 1/2 fixes firmware load sequence to ensure IEP module
is always running when either of the ethernet interfaces is up.

Patch 2/2 fixes distorted PPS signal when the ethernet interfaces
are brough down and up. This patch also fixes enabling PPS signal
after bringing the interface up, without disabling PPS.

MD Danish Anwar (1):
  net: ti: icssg-prueth: Fix firmware load sequence.

Meghana Malladi (1):
  net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during
    iep_init

 drivers/net/ethernet/ti/icssg/icss_iep.c     | 10 ++++
 drivers/net/ethernet/ti/icssg/icssg_config.c | 28 ++++++++++
 drivers/net/ethernet/ti/icssg/icssg_config.h |  1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 58 ++++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
 5 files changed, 87 insertions(+), 11 deletions(-)


base-commit: 73840ca5ef361f143b89edd5368a1aa8c2979241
-- 
2.25.1


