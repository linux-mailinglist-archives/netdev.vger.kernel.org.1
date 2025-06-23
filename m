Return-Path: <netdev+bounces-200362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF34AE4AD8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910441B60EF4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866A2C08DB;
	Mon, 23 Jun 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PVlfvdp/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D228DF12;
	Mon, 23 Jun 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695073; cv=none; b=I9bcfeD7liV/V5cT6Pb63L1RywfIo9C4kJJzFFG87WJ2vJ4i7Tt0e/C5wK7lgdnPnrTk50RyEYI/jVv7fnFvujcgcMC6RXUxF+2EQ2tLDG0wmvqUPaD45gzHgp3ebGOP55DXsdbW/9W7uLnyIFFNI89wS3fCpokz7Nx2/eQ2TZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695073; c=relaxed/simple;
	bh=a6jDL9Ippn4qsLkMGbozjg4XIaxi0OwQw2DSwtQswR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8vpda9EmQLzlcnj2tUz2cihbbSoA07AdB2lorAKmazga1iZlEwCnKw9gmRSM2FvtKfnfsty7ngYUPkUp4dz4bTXPooA8otrehRxCBMIgIAPq1E0p3Zxh4VahPFBqV0Ccb3m7laXNiXuRtPrn9hXHEUQ9rh3IBhh24YUbEoaY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PVlfvdp/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1750695070; x=1782231070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6jDL9Ippn4qsLkMGbozjg4XIaxi0OwQw2DSwtQswR0=;
  b=PVlfvdp/amXS2ok40QbWVQ5cV/AxV67QoPBY5tFnYmb/T1qBowJKsu2X
   09Y4HT8/8DG/cYhIildYXnXHW4CznnicNJ1Lrd5WJerrI+E7X5jgt4/t8
   ZQidgU9pEC4BHOYhUGYlEhyqho/cANDBhwotrEaMZ8QKBWumwfJL9e+N0
   2+6ovVA4OFZpvucjw5OLKBPdviQVd+R7IeFcrhMYHSt1D5uMPgbcYEGZd
   gS0QlMzKigHmIwOoQQexIUVEshqgRKH63wrMi55KXG88Y50/LRfT+tsWO
   0Zof5nu/NX8HdhTppZwMWI/hQLcX2jlXTb6zBCcVkcxA5DSzUqj6QgUbR
   A==;
X-CSE-ConnectionGUID: ftF37T4vRQW9WeoW9L5rTQ==
X-CSE-MsgGUID: 0q4SYXA6Th2pskWo4ifCRA==
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="42643386"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2025 09:11:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Jun 2025 09:10:27 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 23 Jun 2025 09:10:27 -0700
From: <Ryan.Wanner@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [RESEND][PATCH 0/1] Enable FLEXCOMs and GMAC for SAMA7D65 SoC
Date: Mon, 23 Jun 2025 09:11:07 -0700
Message-ID: <cover.1750694691.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set adds all the supported FLEXCOMs for the SAMA7D65 SoC.
This also adds the GMAC interfaces and enables GMAC0 interface for the SAMA7D65 SoC.

With the FLEXCOMs added to the SoC the MCP16502 and the MAC address
EEPROM are both added to flexcom10.

The dt-binding for USART is here [1]. And the dt-binding for DMA has
been applied here [2].

The original thread for this is here [3]. The applied changes have been
removed for this resend 

1) https://lore.kernel.org/linux-arm-kernel/20250306160318.vhPzJLjl19Vq9am9RRbuv5ddmQ6GCEND-YNvPKKtAtU@z/
2) https://lore.kernel.org/linux-arm-kernel/174065806827.367410.5368210992879330466.b4-ty@kernel.org/
3) https://lore.kernel.org/all/392b078b38d15f6adf88771113043044f31e8cd6.1743523114.git.Ryan.Wanner@microchip.com/#t


Ryan Wanner (1):
  dt-bindings: net: cdns,macb: add sama7d65 ethernet interface

 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0


