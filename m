Return-Path: <netdev+bounces-182767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC37A89DF5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86A73B87B5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA0297A65;
	Tue, 15 Apr 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uuKAAANr"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7B2973BE;
	Tue, 15 Apr 2025 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719756; cv=none; b=XRCuPXidFAGBJ+nJwp2e6epj7Y3lswwQ8eAs6qXIOsKEpk9JFmEnrRTu4UdWs69BcVrgaOIwSelL5m1ZWssGA6cfdzKyNo2IdzZ1pNTJSBjImeGrDebDkaiFHkTUQv/LxMwg/WZJ+qBO3rYPySXo+R+OnkQu6eOJib5DiIOq6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719756; c=relaxed/simple;
	bh=DoEEJAGy5AoYSGe5AvELfoahMUlyejm0QnJ1IyMgB+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYl8tunL7up9+AQ6PhUmZGiKGPnyJtARfTbBA5pkee8q1ARHUkjj52Tz9+69yVFXVbeQFE8x+zVoNLGchzB7KI9/xuJ0gJ5XtZZ2vYJ2geWOncY/vjoE4x8Q5IxCEJXBQjah2XQ4uuV1qqz9DIMzxt65/uBER0qZ2DYDkQX2BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uuKAAANr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53FCM4SE01309596, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744719724; bh=DoEEJAGy5AoYSGe5AvELfoahMUlyejm0QnJ1IyMgB+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=uuKAAANrORTkcO3xhG9SNTFBxVkX9pbV5+kjfK60X4NoS6ekfuPaL6fMEVWSpi/DQ
	 d/UmIpCXRRe9QLwoQBjy/9REh+X0a6/vNPpJrEg85HLrUja695h0TfrerQPjbPbBVh
	 NLn+8zlfPHeppeybxA58F+NgTuhi6+sO/5ak45CARwXdDsw90FQXSbFdTrzE/YLBQU
	 AuTsWrHdS+flE1H1mcApeMFHBL+v7ugdZKiUNrRY1Ey7s+HoQwWIA/+8pmvKgqDVZ5
	 mnr/bW83QWoR05CVpyLijXzCZKTwMjLd96WffQC2y4IjcSExHeDrjx0hr7kepNPEPR
	 IFdkXqPwMYqrw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53FCM4SE01309596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 20:22:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 20:22:05 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Apr
 2025 20:21:55 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net 0/3] Fix kernel test robot issue and type error in min_t
Date: Tue, 15 Apr 2025 20:21:41 +0800
Message-ID: <20250415122144.8830-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch set mainly involves fixing the kernel test robot issue and
the type error in min_t.
Details are as follows:
1. Fix the compile error reported by the kernel test robot
2. Fix the compile warning reported by the kernel test robot
3. Fix a type error in min_t

Justin Lai (3):
  rtase: Fix the compile error reported by the kernel test robot
  rtase: Fix the compile warning reported by the kernel test robot
  rtase: Fix a type error in min_t

 drivers/net/ethernet/realtek/rtase/rtase.h      | 2 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


