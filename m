Return-Path: <netdev+bounces-144844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F59C88CB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECB0B22A7D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2B1F8EE1;
	Thu, 14 Nov 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="i2KEE3+8"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10318BBBD;
	Thu, 14 Nov 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582921; cv=none; b=BuUot6gYVkyISFXOyWDlycwiYK7Le4NDVBl5W7Jc7qu9tv6tYdfSW/x4KiU7G2VpC24ZBUCfM1yfuzNbNzbGMCTzTMme9YM0Mg73ebfOrndqTq1mTxH4ijprkM9Hzp+YNQHCqDhFR+x5hzBbrzLzdg0yLWLHP/dWtk4FefgqTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582921; c=relaxed/simple;
	bh=LJyia1GC6owIBA+nt+R/EcuDd2a3EyVgS+cuvHdY9dE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3xOpFIEf/J3vaXQDKqTwuaAcwR1WLOLoLz7PSyR+idr4tUS2k40JtPwOIcCGxeOHmZUbjWr1L1x/usdHZrCrfsd3JUjHTUEs9jL0+pRWV1Dt3ajSxWByAPLQLirH4zmftGWW2EyOIQJzrKnyBeYoXmnlgh82IQTS7LmZfEIzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=i2KEE3+8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBEpRI22903521, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731582891; bh=LJyia1GC6owIBA+nt+R/EcuDd2a3EyVgS+cuvHdY9dE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=i2KEE3+8PPcP8NX8d/xPeHHFbJhhlH1HJ43L1RmsCflRZAzuMhmCeaguTVaxqhZr+
	 mqx/jto8cKRqTWm61ZMXFgwvlQGT4mQm/UMNo7h3qisSXj5jza+Bi6gUlr+od5XJbh
	 arbGmrA84wMTtY8qP9voDfk45saCcquDiu8oqggxOL/GzN4eypUDQrzoepfa4VhnZw
	 LSnbT4XCw2XyjCUL54+ZugaydSo6YaT/dM1F6+n+eusoj9Wa9jAVs1AzPdwMnDnIEY
	 LkTk1WBb6Z2/FZ+ZNBmJqfcbe6fyjZSTyZ2ASLWwVAhfuJuizhNhq8vn2O7MA05/tV
	 AMsvvFhI1jH9Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBEpRI22903521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:14:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:14:51 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:14:50 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net 0/4] Updating and correcting switch hardware versions and reported speeds
Date: Thu, 14 Nov 2024 19:14:39 +0800
Message-ID: <20241114111443.375649-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch set mainly involves updating and correcting switch hardware
versions and reported speeds.
Details are as follows:
1. Refactor the rtase_check_mac_version_valid() function.
2. Correct the speed for RTL907XD-V1
3. Add support for RTL907XD-VA PCIe port
4. Corrects error handling of the rtase_check_mac_version_valid()

Justin Lai (4):
  rtase: Refactor the rtase_check_mac_version_valid() function
  rtase: Correct the speed for RTL907XD-V1
  rtase: Add support for RTL907XD-VA PCIe port
  rtase: Corrects error handling of the rtase_check_mac_version_valid()

 drivers/net/ethernet/realtek/rtase/rtase.h    |  2 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 38 ++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.34.1


