Return-Path: <netdev+bounces-142749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7129C039A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32538B23C44
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0731F4FCE;
	Thu,  7 Nov 2024 11:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A41E2601;
	Thu,  7 Nov 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978111; cv=none; b=HLPR7HDc+TdvyLm2RYywfG1dSkk52zG3zDB7353ckUmy0s/esERe8e8Rx38iBp08I6SEwVqqvKmyyTR/gh1ZVqTs9MVt4Nd3yut0OVuf4nlmj6ZBMn7lFyVGzbcKMBuNWV6bL0mj0O5OHTVEJLDgLtDmiuzVBGZrKrnUx07OxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978111; c=relaxed/simple;
	bh=2LlS07VGD01giKtgjCL9ae2DBifBD2gvXNjiUbKjUmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8vYWE9GtsSsbj7ZyHNkq1uMz+cBtsbEMkw9mAcZs2Iwg2hKL71qJCRlh0Qjfag6egfiB51jGAXv1dOH/hBq75isFoTrqHLoRbPb5lI1xovIilj9ShOAnlOr5H2z5chaf5TUgTU9htRalTGRN4kBhHOOozWqVRN6DB1TMovLv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 7 Nov
 2024 19:15:00 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 7 Nov 2024 19:15:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next 0/3] Add Aspeed G7 FTGMAC100 support
Date: Thu, 7 Nov 2024 19:14:57 +0800
Message-ID: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Aspeed 7th generation SoC features features three FTGMAC100.
The main difference from the previous generation is that the 
FTGMAC100 adds support for 64-bit DMA capability. Another change
is that the RMII/RGMII pin strap configuration is changed to be set 
in the bit 20 fo register 0x50.

Jacky Chou (3):
  dt-bindings: net: ftgmac100: support for AST2700
  net: faraday: Add ARM64 in FTGMAC100 for AST2700
  net: ftgmac100: Support for AST2700

 .../bindings/net/faraday,ftgmac100.yaml       |  3 +-
 drivers/net/ethernet/faraday/Kconfig          |  5 +-
 drivers/net/ethernet/faraday/ftgmac100.c      | 62 ++++++++++++++-----
 drivers/net/ethernet/faraday/ftgmac100.h      | 10 +++
 4 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.25.1


