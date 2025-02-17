Return-Path: <netdev+bounces-166859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B3A37978
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 02:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CC53AE949
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FED528;
	Mon, 17 Feb 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Z7sUvIgT"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CF847B;
	Mon, 17 Feb 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739756088; cv=none; b=q+y/DGfZoLhcfJJZmbYte1fCSjAJpVoim83Eg7Fy7w8lD5WgCnFBXZiW6tlPlEZMETQoITfqTDf3oFhLur44FWgguFY8zB+ARVhgjZTYxM7KScUOxweszXTuxH4YgBdfb0bZN7L5tBYGnwHjHUoEobWBYaAmSvmu1H6PrbMWKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739756088; c=relaxed/simple;
	bh=e4/AAbisHJachlaK+66eVdcu+K5OGrjNBbTmBBovcOQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pSWFIM/ILbnYaYXhNbGLUE9ONxhFvTI19QfshTUsroHa+ROIPKLbxgvw95+9ndMUGTEJlP1rKbf4O0G4pR3vIuMFV8YKG2O1nhciqCRePAC4ciePSAN0MgCucqaBQkzY9IbhAwb35ZN9Om73mkJYpgA28oz9+TWEHrMItGEAtyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Z7sUvIgT; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739755773;
	bh=pP07imU1yRZo5VJuVB+0B4Te8JSt7A3ydHeyAZRXe2k=;
	h=From:To:Cc:Subject:Date;
	b=Z7sUvIgT4e3HJIYcHrL6/0jBGEFDVgmv/+mHAeGKSyryBNUQ2jMh8AyPAxWV8NQaV
	 S1iFe1z/2jJaTUg2zPg2hzFLwG9ruWCe6NE+0GMHeKSqJNWgxt9ZGUZc65RREljTDA
	 WfdUrI2QYmoszWvnD8iuP+hoQHi99H9NWA+FIcO4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 75F9AABE; Mon, 17 Feb 2025 09:29:31 +0800
X-QQ-mid: xmsmtpt1739755771trd9me21x
Message-ID: <tencent_30122FBA93E93911578208176E68AA00C807@qq.com>
X-QQ-XMAILINFO: M0yQCYO1Pk4BQK9MwsPiXqLGdYYZSCLOPPfcpbnW81QswNSiwoPu1fQRPn7F4g
	 Mydr584M1QsAx8p9vJW2dNlaGgSs9qjxzUQoqGMgEXOKNDptenroPhnIdT7wOUzWwiCRjhyfexyk
	 TfYjGCNFByNDY6+DQ68CGxbWvmgRgPbVmxef1Yh3jlTSixjrFchIAGSh6SaHI14zkLLM3m5I+/Kh
	 ZQbL6/7GqFUrphyQwokQVvJkqsh1oRCKJz6klboLy/nEMeQhd7Q4icPHtOy4bXoMvMHrq6pfGkWg
	 ImYQA7TkTp+/IVwx8k7vJLN2yRL6HAj/DXjzr3oao5WcMkc12OFmm8OY4fIffYrNtNpl6Yg5WLzz
	 yk6y0BkDvpFi7hN2FllxQ2WHuWFl1fi29fC2vi2XKycICaR17lRkskAhDBE3F9Mk0wglksHagyU6
	 FB8NjSuJzycDlj2INNuygQBkdFTwRj9ApcHaLMyasP1Iqd0hGrKRd9OUTodpMSAlZkF1NBEXH1Nv
	 ymbMLU2prsmupp2Rq3wqCkA9aupjiejnS7QaUy5VO0grngJJoZfWJyeSRJMC8WLVHE1vigZ91ez2
	 GYHGccGvDCW5WpLW2fIPGSX+7Uoc4NMhNZqCUXfFbvAAgNmdsc3EuyphnzemUi6UrI7BDRxUSZ++
	 lOPyhTidGDJ5IrDdHWly5ByE4VPXNT7coAzK9926lFvsy8MqYS0sRTdCaC4MyYUxzH7zmYDcf+99
	 qMVY3fT7gcmgRUEqxaoKA0k/oGVrQwB1dessQJ4A34X93QMKQNxPZZxwyHNNtOG8GCxOD7kxnQAZ
	 CxwEIzKlVS5C/c6TRERMAQ6SK1XRdzsEmR1Fgy8XwJ1vp9gFSZscNiZeUNHdDtVK30/1s14ouo4J
	 p8EheVKqazUI0RO3xJHOSNook+sCdapEXcuTDEjTslQlXx1l866VpYw4r9KxpXXx9ty88vwRblqw
	 S3aqY4Miq4Snich5DAvT97+HhukaXt526TtBBLBgJIAq9yfTIGlw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: xiaopeitux@foxmail.com
To: andrew+netdev@lunn.ch,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH V2] net: freescale: ucc_geth: make ugeth_mac_ops be static const
Date: Mon, 17 Feb 2025 09:29:30 +0800
X-OQ-MSGID: <05ccd0ec9dda47a7bb26b78ef41fea2f2ce675c8.1739755552.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

sparse warning:
    sparse: symbol 'ugeth_mac_ops' was not declared. Should it be
static.

Add static to fix sparse warnings and add const. phylink_create() will
accept a const struct.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502141128.9HfxcdIE-lkp@intel.com/
Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

changlog:
V2:change to add 'const' suggestion from Andrew Lunn's review.
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index f47f8177a93b..ed4f57701485 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3408,7 +3408,7 @@ static int ucc_geth_parse_clock(struct device_node *np, const char *which,
 	return 0;
 }
 
-struct phylink_mac_ops ugeth_mac_ops = {
+static const struct phylink_mac_ops ugeth_mac_ops = {
 	.mac_link_up = ugeth_mac_link_up,
 	.mac_link_down = ugeth_mac_link_down,
 	.mac_config = ugeth_mac_config,
-- 
2.25.1


