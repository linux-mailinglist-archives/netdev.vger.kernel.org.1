Return-Path: <netdev+bounces-168403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E3A3ED35
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 08:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C77ABB44
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC171FF611;
	Fri, 21 Feb 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wKJ3Gw7Q"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FB1FC105;
	Fri, 21 Feb 2025 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122365; cv=none; b=pOrAAiADgNCI6/psFQVcqsZjMtWkLYD8+01t6AIhhiEYX1tHLRZEcsTIM29Vn22/A3oa7NI4YmFFpqguQASTGpuz1qt7YVNk8XVeOflukJ2KqCG/jA9ZYtKrvnpeJWutLHEOPgXmHy2G3dvNO33/NgnQu+A12hc4gtu9J56wvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122365; c=relaxed/simple;
	bh=dbQdWxZxsTr+Nx2X4TwJYiQXfNVm1sTEPV5Mt4aec44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GuKoUSnxYb4BT5VCX+2fxlfmWrCzpJUXBU/goVGwe+4WPsuhaWx/3GfmmAUuCSX7LTSSIJMKkzkb6X09vnY2i6wV8h69VsDFQWdVRhk1zSch34satkUa3uMz7j/viLsth8/7ekQlArfxUsWoiAabBO6kH/6cCs/fqfEW1r07T98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wKJ3Gw7Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51L7IbezE1489814, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740122317; bh=dbQdWxZxsTr+Nx2X4TwJYiQXfNVm1sTEPV5Mt4aec44=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=wKJ3Gw7QcxYtCOUIZLcZGE/sQl28T3bfySQUcTLxSeDoAHHnw3WBdvZwrZXsCLQwl
	 bENat0ZLoKUNSICzhRrWne1HJL4HIz4GZaUXFuGeU4To434uMAG3CUj3owbH+ldtSn
	 8CBndITxlZs2HQNUpFtFLMPSwV9UBBwzargvGRL41Ly1VCTOQb1SxB5Yzhg9IefxHE
	 McR9W7x2GdtV2ZcxiG5WRpH3bz5eTycvJWLBLBBkoTEoC6jDmd0Aw/cWyJbK2F/jGs
	 7VY7+aJuMVGjhXsd9cqsXpcwP0M2e+8TjD6h+biLMIcApEpXKwMFCcQHZ96QXZlh/H
	 0VxcKp+YomnUA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51L7IbezE1489814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:18:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Feb 2025 15:18:38 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Feb 2025 15:18:37 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by RTEXH36505.realtek.com.tw
 (172.21.6.25) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 15:18:37 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 0/3] r8169: enable more devices ASPM and LTR support
Date: Fri, 21 Feb 2025 15:18:25 +0800
Message-ID: <20250221071828.12323-439-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

This series of patches will enable more devices ASPM and LTR support.
It also fix a RTL8126 cannot enter L1 substate issue when ASPM is
enabled.

ChunHao Lin (3):
  r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
  r8169: enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
  r8169: disable RTL8126 ZRX-DC timeout

 drivers/net/ethernet/realtek/r8169_main.c | 126 +++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

-- 
2.43.0


