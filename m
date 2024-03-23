Return-Path: <netdev+bounces-81368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3D88773B
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 07:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F9B2181B
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 06:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61D4A06;
	Sat, 23 Mar 2024 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="XgigSNG0"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41971C05
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711175953; cv=none; b=uNT9eeNMTWfOBqP483JLtpY5M9q1FJtM9G27Pae11TER4zvmhaRmGdnKUQRLx1WNxgRJKBan/YkGNgpXHfIqBB495EfBluECXGRIFhNlHy+XMYSj8lR1O6XRj0f5Vm61lw5SnuJogSyBbJ/YCKKY1x2Wn+iRiv2+VzU9eh6bWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711175953; c=relaxed/simple;
	bh=x6jysyZ5oZimszC/+KWYqfqt9dmO+sPqmSEiLu28WpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a80ShgRFPQRXeKdgHD4LI3uDCmGgMjKrrBgE/c5TlBtQxGhkoc1eb7+KCZPXHmfnocrd+/mEEB7Qd+ofKeWLzcQ3mPjKNPBsiLn9dElUtoQI7ih5D6ZVDeij4vDztZVCbMUXri32jjn4asisRiajgS5PyKtyZrZg4Ju3nWNUalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=XgigSNG0; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 0D36C1C144F
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 09:39:05 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1711175944; x=
	1712039945; bh=x6jysyZ5oZimszC/+KWYqfqt9dmO+sPqmSEiLu28WpI=; b=X
	gigSNG0ZKBCrO4NHweiU5rvEX3Uiyfp568itIKXAprXgYWNXex3TL+shzZ3VwF85
	+gKXa2adX2h+30jxhcbYLhqEhmUhAelnMHDChnRYsZqaKS3nNfxbqsCZXDX7K0MS
	8pNhWuucOXhAjTxPSYwYLkNGnalDf1TzqyjAa3Kpwk=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lUAE2CgRGus8 for <netdev@vger.kernel.org>;
	Sat, 23 Mar 2024 09:39:04 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 18C7C1C1401;
	Sat, 23 Mar 2024 09:39:03 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: 3chas3@gmail.com
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH] iphase: Adding a null pointer check
Date: Sat, 23 Mar 2024 09:38:52 +0300
Message-Id: <20240323063852.665639-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
Further in the code, it is checked for null on line 204.
It is proposed to add a check before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/atm/iphase.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 324148686953..596422fbfacc 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -192,6 +192,11 @@ static u16 get_desc (IADEV *dev, struct ia_vcc *iavcc) {
            i++;
            continue;
         }
+       if (!(iavcc_r = dev->desc_tbl[i].iavcc)) {
+	   printk("Fatal err, desc table vcc or skb is NULL\n");
+	   i++;
+	   continue;
+	}
         ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
         delta = jiffies - dev->desc_tbl[i].timestamp;
         if (delta >= ltimeout) {
-- 
2.30.2


