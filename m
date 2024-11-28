Return-Path: <netdev+bounces-147742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7699DB7A7
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 13:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA32D1635C3
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC56C19D09C;
	Thu, 28 Nov 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RoNn7aZw"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FB19C54C;
	Thu, 28 Nov 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797014; cv=none; b=kQZLCtVHxjgoL70p+x5bHXoU5mvD0qhJXChq7sUqhdUrdolxAHeB6/ZzfPD7RR2068eaiUUQdwe5SkbTsn6U/ChaTe7xFudO+Dtwz5uifUkb/l5DzxLZLeoj6t03DHNjwqTzCNIXZXNzM2wqFse4l39s/NX+rg4FvfhhDq9XUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797014; c=relaxed/simple;
	bh=HyeQglZOudROU9yJJbfOQSXVMLAgWs9JGAnbZ3wh/jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pABU+joqLwxKXO1jmCTVPdflQ1uxljzuQ2489zhm4fSWJzNNcj9pMuIcCcYlRlVs4rnZJTOYGXbBCj3K+d59jLvqEfIGk6hrZDDKcr63H9oQNWuGZC0edyiYq0dNu8RYVY1+I28qoZCGjMhUt0adpGoyrgJFqzaiVOPmkRoLnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RoNn7aZw; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASCTh2Y1097675
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 Nov 2024 06:29:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732796983;
	bh=noavx6PZ/oVwRRxrHaJIk2XW7aikczxx+lo0NYI5Ov4=;
	h=From:To:CC:Subject:Date;
	b=RoNn7aZw5ab9cUJTmftgh0FvcVUTVfghtjty+pInJMH28Kf7r0kOXvfUXEhmQmHXz
	 CQp6HLQItthpc7NHrBeLCIQrjnN7jVab1A+KZ6HOr1MmtNFaflH0ey8+PfKNrMjAC+
	 rkmIZClLkAo9RGyvMQ0jIn4I3+NNa4/f5UrdrX2o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ASCThHi107006;
	Thu, 28 Nov 2024 06:29:43 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 06:29:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 06:29:42 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ASCTgVM042252;
	Thu, 28 Nov 2024 06:29:42 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4ASCTfA3028118;
	Thu, 28 Nov 2024 06:29:42 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <lokeshvutla@ti.com>, <vigneshr@ti.com>, <m-malladi@ti.com>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2 0/2] IEP clock module bug fixes
Date: Thu, 28 Nov 2024 17:59:29 +0530
Message-ID: <20241128122931.2494446-1-m-malladi@ti.com>
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

 drivers/net/ethernet/ti/icssg/icss_iep.c     |   9 ++
 drivers/net/ethernet/ti/icssg/icssg_config.c |  45 ++++--
 drivers/net/ethernet/ti/icssg/icssg_config.h |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 150 ++++++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   3 +
 5 files changed, 142 insertions(+), 66 deletions(-)


base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
-- 
2.25.1


