Return-Path: <netdev+bounces-175187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35678A641B8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368423A4A0A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331721506D;
	Mon, 17 Mar 2025 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5lwLj8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347D4A35;
	Mon, 17 Mar 2025 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193443; cv=none; b=cP9zvQ8zQjW97Blrwj86WAMuP8O62QNhIqHmc4fswVsc20s4xP4u3V8xTWKIiiZOfsmhUs6znC6pvXPKxhx3nBM4VfsiqslCUd+OHbPjyKQZcgSW/y3GMdcDKgRj2Jj0222aRC5JwcovGJXoLgb1kVUuNeRqj/UdBKNA/J2EQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193443; c=relaxed/simple;
	bh=1SmQdaDCcVZUFeKegyosslUZh74voPuVwRMkA6hJ3yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fApWYqNiIxEs3sPRq0RcXexR81IFsHDJB1Y6m/QHwDDF+PCOlhiJl5F6Nxt0EfL7fS+DFK1Rr7574q7ZakIQuGZtpoKzWBFCr+TF6DTYEY8vb4rBDN1kgqjoz2g0v8bHTV7+A62cVPyc852qjR0mo/l8g54CNcGM6U6KZP+Dhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5lwLj8v; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so2484408a91.1;
        Sun, 16 Mar 2025 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742193441; x=1742798241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsmcEAxz1CSjVtD/4Y7lNEkmcTe30atWfNzAvXoAg/4=;
        b=a5lwLj8vEa2Rv//axj9S1Is+hjBHQbBU6rJEh9VD6Hj+/ex5vkVnSYOLDQ9v3qLrqr
         12r5x6kkAbjLaER3nH8ZQGaeBjA/G0LHBQAwGNyVuJsPdB1NVXMasvvbOrNssw570Wqi
         0CCSpHBoWiUmwFeoig7X/vQ5EAbeM2EyMl3gCvaSRzS8AwZa593Wzaef5JMxLtpHIOEV
         ZLA14dJlWJckaCbzI19b6pO6nQ7muWlJoySXYyGDbFZfGoiSj9kg3ZSeLySU/vo0Srej
         yTw6tnUQulinrRlmVxlDYJ9HcVowsIZBi85t9OzifohOlKB8Ukk47LDVDaLyvl+JEUsN
         vApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193441; x=1742798241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsmcEAxz1CSjVtD/4Y7lNEkmcTe30atWfNzAvXoAg/4=;
        b=azIN6I4j3fUV432m4QjpQKf+NZmZ1s3Qbuz0F7MwAsPB3ZqbbI1F+ODOAWISa46Pp5
         go7TnD3q9DjtVz9caAGu/MXZMJdTfIYSvScPy4Sey0ooCfd/HtvOp9QP1JedWsbPcvSj
         FX7w9wClC9MFgqj8bVq0zsON/moocosylXcCo8c/qhUWoOOt676iWGk3s1Yz+ZtxtSOz
         XY42Yvk3wLKvK2eSXqKo8FSSuPE0XDmgaCEqodgvSuceuHhIwNue+8XaUrPc//VFMRu4
         +EGLA8lDpZoxqfX5ToF18givatRAzXohnFe/G+VcxsOMx/2Fs0yoV5yhsD8rf1+YltB0
         5RRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/4aqj/uYA0a9E1LTLFFxNoSbVvkZTVuYV1ExLEp0lm4X948uW53UBTAXvjDHpp6nEI7ZEW9run/Ye2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHN61PQlMNbibj9eq/DCNPso8v1GpBJJuZwZ4asnziubuimajx
	GaNgSKYskxrJNMdN5hDR1L7GdOnuCldhIEkjegNftSJ5xYRC/Lj8
X-Gm-Gg: ASbGncsi9h5bvjEh5bjU1ujT7d2e7VDsXKnrd3tFPrYkG1xpvHtMCyI5wT1DcLX9Wx9
	rfzQkV187OaQ8ePgsAJtBJejklJ1K/WJhakXAFms+Ln5k+4mb6TDkgx67b0pYx0cFVGn6yJlwYU
	bhiF6bGRPGhcjUNtdkvnAUjMEALk2VFn1aXPY/G32Bvu2gwkFFSccjclB1wvXjLt2oRz4lnWwai
	yHwjyOiq2aDht4MTUcaUmsmo5XPxZ5mupMxsLVImzzMiYxFtj23PJx3Ou4a6c7cb1ZvVxjWf8Bd
	uSYFo6WAac8G/mEyDovAppTmKInahAGyIwG2tte1A6t5MVcTX0zl+S67tIHSaoUqSn8=
X-Google-Smtp-Source: AGHT+IFgv3PFg/FgN0t+tN4c2fWnOWJoUKBZ0u7g03PjoFpf+Q3WnHMU06Y/aiomLUhr4UveVbsydg==
X-Received: by 2002:a17:90b:3804:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-30135f4cf2bmr20033700a91.13.1742193441112;
        Sun, 16 Mar 2025 23:37:21 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:df04:8817:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301534d3e52sm5822101a91.1.2025.03.16.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:37:20 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	giulio.benetti+tekvox@benettiengineering.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model detection failure
Date: Mon, 17 Mar 2025 14:34:52 +0800
Message-Id: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.

Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
v2: 
   - add target tree
   - add maintainer in mail thread
   - modify checkpatch warning
---
 drivers/net/phy/broadcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 22edb7e4c1a1..3529289e9d13 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -859,7 +859,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return reg;
 
 	/* Unmask events we are interested in and mask interrupts globally. */
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
 		reg = MII_BRCM_FET_IR_ENABLE |
 		      MII_BRCM_FET_IR_MASK;
 	else
@@ -888,7 +888,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id != PHY_ID_BCM5221) {
+	if (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM5221) {
 		/* Set the LED mode */
 		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
 		if (reg < 0) {
@@ -1009,7 +1009,7 @@ static int brcm_fet_suspend(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
 		/* Force Low Power Mode with clock enabled */
 		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
 	else
-- 
2.34.1


