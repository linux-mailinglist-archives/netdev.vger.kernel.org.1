Return-Path: <netdev+bounces-131887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6898FE03
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE721C21C68
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DC136E30;
	Fri,  4 Oct 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y932Q8Wc"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5B1BDC8;
	Fri,  4 Oct 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028058; cv=none; b=q0rOWmZWp0WHmc+wNOdjb7KjvnXDcnr75Vmk6bfuafLM/CSbEnBgv3Se9ybdj2FFCpq9tPQdBe1pQlh6NsPq2GBRcb4ZTCB/yQnAfArxQ6QTc7vfeTBIN8N0UkfVPkNQnQ1VpK9FiI+/VzbUSaZAe5y5BmjsqRS3orxu6YKG7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028058; c=relaxed/simple;
	bh=++/KKWzs7prm4yllVHBOfXPL6NRiEkY/fuSjlIooHF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5J1PUJ+kziTEINFjIbd+mEmRVY0fLQT7NVXAPDGe+G9tGqBixslnRr4ur1jAxR4j6eaJtdtsvYBp331TyMmBk924IO20lw/BUR8z0dnxrBaq+uovy4RXqmyeATUbJHEzaRtSR3Mkpwy3vWN2WHxOuHbJ6WIHJ+PyZ95sOTudu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y932Q8Wc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4947lIPi094496;
	Fri, 4 Oct 2024 02:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728028038;
	bh=QzkOuFZig08kdm9e97Q1gLZzLJHtWQJG6ARYQos6Ntg=;
	h=From:To:CC:Subject:Date;
	b=Y932Q8Wcugj0PAU9s+NEiL+9467Agncq1qj6XHoUMa/rs14wN0sdi2MsQULOr6S4+
	 WrdGf2JJ8AIxq7uTT3on/QAr890/Y/91It4VjagyNOt8TzCLMFQBCJvttKvR3y6Yi7
	 I00tHOTAZ6QST3wwsFcfXZsf4Mozs457+NW6LmO4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4947lIG4005511
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 02:47:18 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 02:47:17 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 02:47:17 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4947lHQC031559;
	Fri, 4 Oct 2024 02:47:17 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4947lGMa025130;
	Fri, 4 Oct 2024 02:47:16 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <jiri@resnulli.us>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <horms@kernel.org>, <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <diogo.ivo@siemens.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next 0/3] Introduce VLAN support in HSR
Date: Fri, 4 Oct 2024 13:17:12 +0530
Message-ID: <20241004074715.791191-1-danishanwar@ti.com>
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

This series adds VLAN support to HSR framework.
This series also adds VLAN support to HSR mode of ICSSG Ethernet driver.

Murali Karicheri (1):
  net: hsr: Add VLAN CTAG filter support

Ravi Gunasekaran (1):
  net: ti: icssg-prueth: Add VLAN support for HSR mode

WingMan Kwok (1):
  net: hsr: Add VLAN support

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 +++++++++++-
 net/hsr/hsr_device.c                         | 76 ++++++++++++++++++--
 net/hsr/hsr_forward.c                        | 19 +++--
 3 files changed, 128 insertions(+), 12 deletions(-)


base-commit: 6b67e098c9c95bdccb6b0cd2d63d4db9f5b64fbd
-- 
2.34.1


