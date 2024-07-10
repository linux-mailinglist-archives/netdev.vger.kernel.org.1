Return-Path: <netdev+bounces-110492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078692C95E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4091F241BA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1D383AE;
	Wed, 10 Jul 2024 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FrgcZHwo"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B241C92;
	Wed, 10 Jul 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582882; cv=none; b=Tp+GPPyE/65AZ+gqDTJRpAapeuFtYFGaSGKtgtmzKgcBCJT9VZ5rxfVPX5t22sP4ZqZnkXYUCyI1/LkU+OK6S0iyRBc5vEoNLt2y9JUB+2l0ckTkkAlfw9PKW5BK0Ua0u9glYWfdR5on1z81ZuEyBx2BjSHOYATxZTPDLlIF+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582882; c=relaxed/simple;
	bh=gg9quY78nmialQjcz3/JYfkyMKp1VuYLp3UKUmhRoK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcFY/fM9iM5f6TeAAEGmh2vYE8JzWv/tMZxQE/GIKclNE+DLj78cqrcAm1c5xGml3ZlFbqXo/0mTuBOn3xxG0RGtcVeEEIbJ0pyRqdamCIlD4DeatUnP5Ovqci2m9g57sNBawdWhqrgRNLddAZe6j93Q6hjY2K2G6/kiAgcSpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FrgcZHwo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46A3esiP71591466, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720582854; bh=gg9quY78nmialQjcz3/JYfkyMKp1VuYLp3UKUmhRoK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FrgcZHwoHjouYvEw757/CdfxBlwhCZ9rDxCaLciX0fjl/uwADC+BczFKhX1Av3EBK
	 L19NI/uRflgSU/4HiFFdmxbJuIdS7V50BY0ZUfVWaSgxNnhEQjs/mrkR/3t0ju+bgp
	 m+sPmf6hGzQWVFRJO/RhuAKmcGLeG7/Zt2zseA2mvGDIhJc/Jn4u18ir2mZou8RUwu
	 vIMPesu9FT/qsaUAjXSoZYKSGFRKEQf6NUnZojSfMAIpbmn/AlO6L+S7cv1PB+Xd/I
	 f4Yjfl1A3HClsA7VntszdPXrHlXQTaRVU3XVKIZ66SVVo6o5RhpvNBR2i35XeAG2qG
	 rZB5nKkz6RbGQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46A3esiP71591466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 11:40:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 11:40:55 +0800
Received: from RTDOMAIN (172.21.210.68) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Jul
 2024 11:40:54 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v23 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Date: Wed, 10 Jul 2024 11:32:34 +0800
Message-ID: <20240710033234.26868-14-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710033234.26868-1-justinlai0215@realtek.com>
References: <20240710033234.26868-1-justinlai0215@realtek.com>
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
index e0f28278e504..bd49c895339e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19490,6 +19490,13 @@ L:	linux-remoteproc@vger.kernel.org
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


