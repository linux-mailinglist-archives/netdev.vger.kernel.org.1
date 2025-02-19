Return-Path: <netdev+bounces-167626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34EFA3B19E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66417A4F45
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A931BD9D5;
	Wed, 19 Feb 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f2SEqBwm"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445C1AE01B;
	Wed, 19 Feb 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946455; cv=none; b=VlgqyWCGpDdRcaBZI5XIFKQ1TBD82RLXRSQl4Fe6YPpq61/R6AAc9XqP2F27gptYI7mA/Pqo4miNh23loMHsLdo435mBK/YxDjyDhkFilGeqG2B1ggQNL3s0SXFZU9HYRtItfdupZCqctiM5Yxqn+b5pt98sl3Kzv24u+23NXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946455; c=relaxed/simple;
	bh=ch91csYqldJAAFJXY0iGyEIskueLGR4UkxCERiY/Pvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U3pSbBa+DbzfdPc2gY3NDSLfEopq9NdcrMMSc8tPCOP6vcHudxxpKM8bZQglWDtvxD02wC8wiSWRTpTwJ/vc+ej0et2kIhb1MWSLjTo1Ai+vQULdQmg3N5nDZW/1usoYhY8ucLJb5OV1upC9tNC+7XObAD2hAUDyG6c42cku3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f2SEqBwm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6R9Ad186657
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 19 Feb 2025 00:27:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739946429;
	bh=h17FbokfSERqNK3i9fAiWbwKGfwvwhKNe949xpUZ578=;
	h=From:To:CC:Subject:Date;
	b=f2SEqBwmhI+BDWAyCq+M7oJz6idx+3QRfKBuCGHbnMm7p2e/85iSOdEUQuzw/vYiP
	 Lz/BwHbTBNuSVWzWci3cpIIPaGXHUmf3QxkaZxBJzEJFykwfIqU0DFsSUV65JCdlQn
	 amBgJNLACy9FyzeDYnnWQnoAou4JYFxGQt+rcNwE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51J6R9BU109076;
	Wed, 19 Feb 2025 00:27:09 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 00:27:08 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 00:27:08 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51J6R88e019383;
	Wed, 19 Feb 2025 00:27:08 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51J6R7g7009522;
	Wed, 19 Feb 2025 00:27:08 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <lokeshvutla@ti.com>, <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <m-malladi@ti.com>, <horms@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2 0/2] Fixes for perout configuration in IEP driver
Date: Wed, 19 Feb 2025 11:56:59 +0530
Message-ID: <20250219062701.995955-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

IEP driver supports both pps and perout signal generation using testptp
application. Currently the driver is missing to incorporate the perout
signal configuration. This series introduces fixes in the driver to
configure perout signal based on the arguments passed by the perout
request.

v1: https://lore.kernel.org/all/20250211103527.923849-1-m-malladi@ti.com/

Meghana Malladi (2):
  net: ti: icss-iep: Fix pwidth configuration for perout signal
  net: ti: icss-iep: Fix phase offset configuration for perout signal

 drivers/net/ethernet/ti/icssg/icss_iep.c | 44 ++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)


base-commit: 071ed42cff4fcdd89025d966d48eabef59913bf2
-- 
2.43.0


