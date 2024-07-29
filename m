Return-Path: <netdev+bounces-113516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26293ED6F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2B1F2274D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433884052;
	Mon, 29 Jul 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vxv7qqY5"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53590328B6;
	Mon, 29 Jul 2024 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234469; cv=none; b=eHlIhllug0fouiSK36m0wJCI2e5gQOBgh7shYLy5ky2YA75oIo9kQmRNY9pCHr9RrEk373A+gDeDnb2JUdWMkO4jUnzWvsE1Q89tMBZBaFAUGIyUKAczp8URKA2ZsYoRrqjbKp1LkEL/cwc5c1zBiWyStOAuGrOPe5LaNNsNLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234469; c=relaxed/simple;
	bh=pol3fu6WOU1lCWe4vLKk0hT+mGmXKf8CX9PFa/RJa3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcKoic78iBNGKpax7YeJGL/JoP7xsXoaf6mwdRQMJw7cpjKiEwroZf8qmXJfAXmvF3uz2vI8cEUGt8HcJRf6EPFtsKRPTZIcBZlPxHHwPSNxgGs9cCBS9n6fHDSH9VDrqlj9H9boc/BgzpKay7QNw4FAqo77ofGhpXsLkFKF3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vxv7qqY5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46T6RQzD43601639, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722234446; bh=pol3fu6WOU1lCWe4vLKk0hT+mGmXKf8CX9PFa/RJa3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vxv7qqY5c8Ri5hFSJSo26h5mFpjczwHO22yvlSembX0dP85ef0GYT9FxA3ieFoXmu
	 fguO7SIdCVm9bfJfvRvKVDLLfDSiEJ6hSs7V0jckJ0t5abHc2I+rY5o5PcqcDhZSVe
	 NsMA9PDyV+a2+6c5pInTXrQARo+KIUQF3sRRa2qyGh5uRisjDpe4QjWTDLPMmlL12a
	 dt9ll/UplHKPM7h75F0yq6XXI7hAJsg2h+cibLe0OrKCJjYxdeDOlL0juIN3wcVL6F
	 NRgTMNNfkqyddNQQnr0bihfyhpa6/5glzF0/sWFXVcPyy0oZJ4ZHcORgmsnbeGHpWY
	 G8O7+tISV5amA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46T6RQzD43601639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:27:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 14:27:27 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Jul
 2024 14:27:25 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v25 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Mon, 29 Jul 2024 14:21:21 +0800
Message-ID: <20240729062121.335080-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729062121.335080-1-justinlai0215@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
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

Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..08f59737e69a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19842,6 +19842,13 @@ L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/rpmsg_tty.c
 
+RTASE ETHERNET DRIVER
+M:	Justin Lai <justinlai0215@realtek.com>
+M:	Larry Chiu <larry.chiu@realtek.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/realtek/rtase/
+
 RTL2830 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.34.1


