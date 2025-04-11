Return-Path: <netdev+bounces-181502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5AA853ED
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C76441642
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247D27CB2A;
	Fri, 11 Apr 2025 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rzfjm3gK"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6923A9;
	Fri, 11 Apr 2025 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351778; cv=none; b=EqBC/MW0X9JRGZRa8wQdwpSZhBe5GvoSS+bwxXgTlRXHRRp0QsNmf04XkWeczDk/R+mU+4DV5Hx5u4U97BUAbNZkTIABBZ1+ObIiVKDTHJXpiwZL6J1OkYxsdBqLGWgPXclOXiJPgZqs6XjUkHmUYjTRKtayVdbCu1E0EmlseGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351778; c=relaxed/simple;
	bh=t0HYUXLB2DaPJtMpf06vUrKOtSAvVcdv/VPIrYPXwgQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6J+5XvD7O9LivxIIlJNRHxqLMpeSTMdyaCg268PlqsKwfhpdfibIrS0IiR51uk+JbiKaE844YVwOvU6MgLDBCoAZ3riHL5nPzPTgO3JTczoyUyHyYTWvc4kKYq8eczSod5dJAg0ofWv3L7Pj67u5ghjyEZJv5gfrowY4ss3geE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rzfjm3gK; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53B69NGE2027079
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 01:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744351763;
	bh=p6L9ox8QbZEfucXdJkpzXmXO81CguHbCQdxOp/2KlFk=;
	h=From:To:CC:Subject:Date;
	b=Rzfjm3gK/5E1dv7/TMK2yt4uSnlJ5SSq+1nIrJ7HSl1eY6LEuzYT2mJc5aGdCxfp1
	 2j3VW5FVNWpasODqmkC+KhynaPcOxrVqum48vXjg17d0GvJ0rofOMG6LQd/V1+CW93
	 +P57LGVlIAUk1bFicEBd2CMGx8xyDTDGsUMHv/NM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53B69NXZ049796
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 01:09:23 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 01:09:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 01:09:22 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53B69I9x065579;
	Fri, 11 Apr 2025 01:09:18 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net-next 0/2] CPSW Bindings for 5000M Fixed-Link
Date: Fri, 11 Apr 2025 11:39:15 +0530
Message-ID: <20250411060917.633769-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series adds 5000M as a valid speed for fixed-link mode of operation
and also updates the CPSW bindings to evaluate fixed-link property. This
series is in the context of the following device-tree overlay which
enables USXGMII 5000M Fixed-link mode of operation with CPSW on TI's
J784S4 SoC:
https://github.com/torvalds/linux/blob/v6.15-rc1/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

Series is based on commit
0c49baf099ba r8169: add helper rtl8125_phy_param
of the main branch of net-next tree.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  dt-bindings: net: ethernet-controller: add 5000M speed to fixed-link
  dt-bindings: net: ti: k3-am654-cpsw-nuss: evaluate fixed-link property

 Documentation/devicetree/bindings/net/ethernet-controller.yaml  | 2 +-
 .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1


