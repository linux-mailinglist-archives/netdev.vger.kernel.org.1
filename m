Return-Path: <netdev+bounces-123064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714296391B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25BF28740B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24566132103;
	Thu, 29 Aug 2024 03:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IjaAHKRF"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AF5C8EF;
	Thu, 29 Aug 2024 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903721; cv=none; b=RM65AzDyozORzkFV7iDqDEYH/yl/fgbFTtxuBDI//UhoqTrmQzkA3kvRdRGvDsK3jTp8KaHAGYf29J1XT5AUH9dbusGGZc8tuZS+5TuyG5WgoYQzO4Lcyh+0/Mxh0dyrXeVVzNJmr+4AJFagCtb+MIXRe7d07ALy1xL0cup+MAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903721; c=relaxed/simple;
	bh=jENzHeYdtccM25KoipgMK1lxxNIHueh+eiWvX0rmqQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GE6Voil4ztBePgXzakG6DJQzl4vZQBake2MFSGv7wBOOoUzqBfSbv9NjyYAnar8tsSH2mSGE2W+kC9WDI/z2U55BSt6zE4pT6TzLEAGv8lf637PokhKGg4Mh5KRvNhXUgJd73kDBcAQDO/KelrlswJ2r0MIi2Qsl345jpOHyYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IjaAHKRF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47T3srfnF3109139, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724903693; bh=jENzHeYdtccM25KoipgMK1lxxNIHueh+eiWvX0rmqQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IjaAHKRFKzGTu3EWFemPhyoBy+FiQTbWGoD5DiQKjLqSKo8GYIoQBjcJlopol1ukr
	 Jm1ngX6J7Pt7th/JGgxlQgYT79C/AHL34Tj9HkyTjvI2W+s2bQO6PCXyAn+UCKKnoB
	 PbW8P/HtqGYjZBoS7uB0yL0psvwQIv4Jtk/SnNsc1blWfe2m6VajP10COXMhsWIXb6
	 ZvbEiT4eURcnp6VX9ZNlSTyT8enkR5/Lqe/Qa1VtpQlhcuW28+UYh1IsVusLGxZhQ7
	 0HhxpyCZyAgbNRzZPIUnZ27+hDx3U/VzaxGUKQoKE6C94ox5le3853OaI7Uos09dH9
	 P1t+svXp99VXg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47T3srfnF3109139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:54:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 11:54:54 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Aug
 2024 11:54:53 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v29 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Thu, 29 Aug 2024 11:48:32 +0800
Message-ID: <20240829034832.139345-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829034832.139345-1-justinlai0215@realtek.com>
References: <20240829034832.139345-1-justinlai0215@realtek.com>
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

Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30a9b9450e11..fa1db9c50039 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19870,6 +19870,13 @@ L:	linux-remoteproc@vger.kernel.org
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


