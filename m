Return-Path: <netdev+bounces-111430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53A930EAB
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8931B2096F
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 07:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC61836E8;
	Mon, 15 Jul 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tc9ZKHYD"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCE1836EA;
	Mon, 15 Jul 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028112; cv=none; b=aH4lZiOGWfHzdrsm4ow+hGpGGTIEqBzKpfhusACbjjT9QzQ+8mfiiF5BIntNqlbT/j6vd9PKo+zpVL9mD9ai4ofDnCv8dEoJjuO48xxIDhjAk+JyZI7ctyDOaQcLrz2NgcKcEnviHnWkYkTCwRltDh1iF5CCBqgKNq393gUoUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028112; c=relaxed/simple;
	bh=jEuungdkkH+5bpsBfsP/YEPNHnkwpnjgZR0k1ozSpZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPCGO1T4lFineg0Ev7V978Hu3OaLxFSOmDrsZ+JQlrP4wkw3xtaYlBpvj3H8/pvSflKlhAGxFWr2axaxSiiaFfteOs1QBh1NX/YCreAKCajsUourJbNIuI3Deoi47d8rnLqvXQjGh5BvYoZvXgxhOdLSTMGnseLj14ce42UsMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tc9ZKHYD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46F7LTDx83490659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721028089; bh=jEuungdkkH+5bpsBfsP/YEPNHnkwpnjgZR0k1ozSpZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tc9ZKHYDb2df2eucC4GnQbWp9mWARYQbJ0Hpr6MNynswWcUIBo66QQTBmvFMtS0kv
	 AdXFnLIVYIMAVwZkky1q/n3WRns7HXsnPoZ1WEwA5YWI0/x7pXjbGr0MIRbdvQrCtp
	 4xFAtU9emZrugI085OrgZcBVi0+whGL/RL8h8WoKFCifOb7wse/kihYxnjlf2DuW7u
	 MEPg/RXvZGnseXgkOYKMLzeL8ur+K7L3W6K/PBYBVFREOgx2q8+Pw9MJSUVKEl8K7V
	 5O3mEkOJ4rpd/94S64dZYH2gtqtjg1SMYuJlK8ePm6j/6494hSeiD8L7SSFQEDgOwl
	 n2QI+SR9TztqA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46F7LTDx83490659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:21:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 15:21:29 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jul
 2024 15:21:28 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v24 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Mon, 15 Jul 2024 15:11:58 +0800
Message-ID: <20240715071158.110384-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715071158.110384-1-justinlai0215@realtek.com>
References: <20240715071158.110384-1-justinlai0215@realtek.com>
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
index e138c90b1adf..8c9af11c7359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19508,6 +19508,13 @@ L:	linux-remoteproc@vger.kernel.org
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


