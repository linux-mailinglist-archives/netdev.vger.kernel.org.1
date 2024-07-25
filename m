Return-Path: <netdev+bounces-113043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E70593C782
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F3C1F230F4
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69719D891;
	Thu, 25 Jul 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b="aPfwoEpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3CA199EA5
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927124; cv=none; b=KhmCjGeuvP7848hrFrxBYllj2cDUtuT+fwLylOgD8QRm9tfJDDRR45yO1uZxMuhoCvOCmrAIxp+FOWIY4w0iWTc7kfNKyb1PzRa/Lt3J4DO4pndnkGGkJMwHx51S6zZyaUYYEGfhSTNa3v1zVMcNHKPte8oMu43yOTnxot24HNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927124; c=relaxed/simple;
	bh=0qvlF0z+W69f0VM9zRlqTHHhCzgFSjLYfgyhx97A8xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5aVINIux1arYMEizPtheCkgk2Tbd6ZDJk+6LTVt24IDwmc5z6AycY2mZjBakwNnZkzzzfSJbYkoaSWvzPjg6cKBTkAvroeMCw/ur9zbeqs3rwI++uanXukZ7WqYAW/aMIEe2jNj7gPx5cQk57d0v9mhy2OfANzc1cSsMZ8YxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com; spf=pass smtp.mailfrom=mentovai.com; dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b=aPfwoEpD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentovai.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1dd2004e1so7068085a.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mentovai.com; s=google; t=1721927121; x=1722531921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iL/4KMSZN6XD67fqJQklqdxeiI1GyJnNUyuo727b0Ns=;
        b=aPfwoEpDnR4PJeVdnOIppaNakg9lCZL/6mNbPFIP8llB/G5/YIGcyaW44dSPm88S4x
         bo5Vcma1fon9iJekrn1TuylU8vGwqdGtOnb00QjVbDVWKxixDtfhLLAkvsQ0oAJfrWQS
         7o2cNsZGLkxJWZO6WUB7nAyB2tOzGzpRL/FbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927121; x=1722531921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iL/4KMSZN6XD67fqJQklqdxeiI1GyJnNUyuo727b0Ns=;
        b=Q1g2xGCrDpQm7r3D3EbySXrsWB9qA8otgFuCkYVqSItj2Ca+cECk2FppXoAnfMIzsA
         /vCNFutZZzliI7gjvNoLtnSBjePcyyIorGtJZ0oca5cucz4smdvpGVbDEOJiimAH/K17
         unH/LSs+xuzmZN+0Y5Z/1vv4FAyFwFKvQ9gRKP5v7bZfGEOjy3DijcvN6Ek35JPs2Jqh
         gG+auZASZwB2+Ca+NChnIWetIf6Eq/Shb1egVXsylhYzcVdB5egcsnXS7PDGaF3S0c15
         UPVi2PCxoLfhBMJjIV2sybfLqRbWESzguS26LKqpeZYcoPVQANBQchL3Gwcsinii55S2
         9OWA==
X-Gm-Message-State: AOJu0Yww1595LwXeoN7kmQJ+UvvUOkvDPO36gA6Y63HPKM1HzT5aOccw
	dvC4FGiXi80JpSi5UvSkH+h3nKAWV1vLPqSsVbJ3ee1Zbth262xU+WEsmOPVPiuZx/+muuLEnUk
	iUrM=
X-Google-Smtp-Source: AGHT+IGYMJlb4MeNRB6hGkW8I8J20GB1qlmNlfQ9itynIkAZ6t0HMzIxxZcjAEQ+Mhx42wXpbEKuPA==
X-Received: by 2002:a05:620a:318a:b0:7a1:d9a1:b9b with SMTP id af79cd13be357-7a1d9a10fb9mr265021085a.60.1721927121104;
        Thu, 25 Jul 2024 10:05:21 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:b9f3:7389:4965:5876])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7444bfesm100705985a.118.2024.07.25.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:05:20 -0700 (PDT)
From: Mark Mentovai <mark@mentovai.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Russell Senior <russell@personaltelco.net>,
	=?UTF-8?q?L=C3=B3r=C3=A1nd=20Horv=C3=A1th?= <lorand.horvath82@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] net: phy: realtek: add support for RTL8366S Gigabit PHY
Date: Thu, 25 Jul 2024 13:05:19 -0400
Message-ID: <20240725170519.43401-1-mark@mentovai.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PHY built in to the Realtek RTL8366S switch controller was
previously supported by genphy_driver. This PHY does not implement MMD
operations. Since 9b01c885be36 (2023-02-13, in 6.3), MMD register reads
have been made during phy_probe to determine EEE support. For
genphy_driver, these reads are transformed into 802.3 annex 22D clause
45-over-clause 22 mmd_phy_indirect operations that perform MII register
writes to MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII
registers, which on this PHY are reserved and have another function,
rendering the PHY unusable while so configured.

Proper support for this PHY is restored by providing a phy_driver that
declares MMD operations as unsupported by using the helper functions
provided for that purpose, while remaining otherwise identical to
genphy_driver.

Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
Fixes: https://github.com/openwrt/openwrt/issues/15981
Link: https://github.com/openwrt/openwrt/issues/15739
Reported-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Mark Mentovai <mark@mentovai.com>
---
 drivers/net/phy/realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index bed839237fb5..87865918dab6 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1465,6 +1465,13 @@ static struct phy_driver realtek_drvs[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(0x001cc960),
+		.name		= "RTL8366S Gigabit Ethernet",
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_mmd	= genphy_read_mmd_unsupported,
+		.write_mmd	= genphy_write_mmd_unsupported,
 	},
 };
 
-- 
2.45.2


