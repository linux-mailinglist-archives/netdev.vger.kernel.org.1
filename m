Return-Path: <netdev+bounces-151982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975B9F2377
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 12:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5028D1641EE
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965A126BF7;
	Sun, 15 Dec 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="S1nwFvO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6881B815
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734261867; cv=none; b=j+D3av0vwsIUFLFl/WVU0qiYZPQX0KoCRfGlPLaf9ZNOclhNXtjlvNvlUGMwoQwv+2HYQSf/b++Z6lttN/t83OWBunUW7rW5gGRihqqtylYMCrOSmLH5csQ6gjXDldVq4RNaBLXmLIkBN/LH9xYfnCGvyoc7F4CC+7mWHrQp+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734261867; c=relaxed/simple;
	bh=9Eff5nCmZ7bC8bE7vx8nEY69+ESxpzLeLSr/byNEeqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ouBnNN2dBk8bhCsutJGorHY+Pxe6pDsuCjZHruTovzLsXlIowFf+y/1KXYqQoBOMwXedoOHf0l2yJ4VqzaJ066tHjoe7n0F+NRCziRTKhJmbdLyhc0w2GWFqacp1grgLcx2SeUbGktUCHgDVwOQf3PiG0dqx91wNzm3TgRH1iZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=S1nwFvO0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-801c081a652so1995280a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 03:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734261865; x=1734866665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAkeqs/vFKD5ziEwTa6o1xayUJtKMoME8cHO05iCsWI=;
        b=S1nwFvO0OyD7AI03DERmq1PGKFtHyKv+mrVFzoFcaMcSUibBN8IbPEfEMRSnMmilTH
         +gE4rjgxuB+XsPDT1HPWW4tOvzNPPfIH0d+bCM9gizeM7B41liSSvYzPq5sVDvm9sCoT
         FL/jWe2wVJUl1G/F2q8BY6gDYBsNq9kzmvqdSaB2e0ZOkT66XzvgcmIjdL4kQrLsw9tJ
         BgXKXnKz+w2GyGaMic/S4yS0fO1AW9weR4g387Ji9F2jgOhnpM2YHp067LVE0zVqPpqb
         l9ekhEe5d1GwPyxxnyCi/YJqYTD7d75iGwVf4s7tiMy6ND9ndGnRl27kP3EqCiVQdGWj
         GEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734261865; x=1734866665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAkeqs/vFKD5ziEwTa6o1xayUJtKMoME8cHO05iCsWI=;
        b=Dt4jxfaJN3gGU1SNOuNpaT9d9lJaQw/0HktkIqBdsVj3xXXDCybvnO0TFO+m3gVwMk
         G6SI9YinRrrx2yrRslJltyunUJYMPiGaYFN9Q9WaqIEs2mCeFanj9+R/iNqj1TiLxa3/
         9NsrlDPst1G5jj+MvflKZI56+7tEK2DPmblwV9hsNaDfUmWTFEj/+C4V22LFF23CHd3s
         fIEat25nuOsrm4A3T9xa6kXwHhF91YWUIi1yMLsXC4uBQHPdnjnGHzTX1OJx7U182Hjr
         Olk7Q3mUzk0VEyWuU7v5vdH0A8BXXnpnOmDOQS0nWgg6Pz41sJiKi5PQ9k46cQEbN8w/
         lDHA==
X-Gm-Message-State: AOJu0YzeZQcgebK6i90u4Ojnqu4tcyfeGOwy/ol6C6n2KBeVviuzjjz2
	COxpXhQcaCRnfZ9OhuOvxGE70/5AWGGMZ29x65mhIoVPvgJuNalYc3L/yZQKvFs=
X-Gm-Gg: ASbGncveXgPhOQPZVp7pVyPAseoIddXXj+K3TMxoC6DWDBeuQ21DwIoJwsoVoLaL+u3
	S1s8lxJ9ceevjJ+Nbfx5mNkjJzfGpyqamUffOwFAYk9aN4AMs5powJZfKkOh7gbNTseVkjk0NHw
	S8NA0VxWcTq3EloZypdTee4ob5GZxtPeHeko/hY7ngZn8nf9aDXcWUTc3vWd8mOa/eejXWcz8jr
	0xiKEyHW0cQvlXeqzo6cVZwBB+RCBj+Wwhh3WMtSt5P23PYnLwIEx3PMWvb+hHhUaddTLoJ7Qkv
	/QNZ
X-Google-Smtp-Source: AGHT+IEk85anFEJPHIJO3qRjNybjRR8PzTYLHkzJk7SOLRyogkGAvEHx2AoQbv4dsOTpJLhCzXatJg==
X-Received: by 2002:a17:90b:3d03:b0:2ee:94a0:255c with SMTP id 98e67ed59e1d1-2f2919b9ed0mr13152657a91.13.1734261864877;
        Sun, 15 Dec 2024 03:24:24 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:39e1:57de:eaa2:a1ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc4e3sm24919375ad.69.2024.12.15.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 03:24:24 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] net: mdiobus: fix an OF node reference leak
Date: Sun, 15 Dec 2024 20:24:17 +0900
Message-Id: <20241215112417.2854371-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
but does not decrement the refcount of the obtained OF node. Add an
of_node_put() call before returning from the function.

This bug was detected by an experimental static analysis tool that I am
developing.

Fixes: bc1bee3b87ee ("net: mdiobus: Introduce fwnode_mdiobus_register_phy()")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Call of_node_put() after calling register_mii_timestamper() to avoid
  UAF.
---
 drivers/net/mdio/fwnode_mdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index b156493d7084..456f829e4d6d 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -41,6 +41,7 @@ static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
 	struct of_phandle_args arg;
+	struct mii_timestamper *mii_ts;
 	int err;
 
 	if (is_acpi_node(fwnode))
@@ -56,7 +57,9 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 	if (arg.args_count != 1)
 		return ERR_PTR(-EINVAL);
 
-	return register_mii_timestamper(arg.np, arg.args[0]);
+	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
+	of_node_put(arg.np);
+	return mii_ts;
 }
 
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
-- 
2.34.1


