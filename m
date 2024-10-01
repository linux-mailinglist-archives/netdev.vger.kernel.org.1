Return-Path: <netdev+bounces-131056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B198C729
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB78285BA1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580B1D0487;
	Tue,  1 Oct 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX8UZAn+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB431D0419;
	Tue,  1 Oct 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816346; cv=none; b=Y/AFyZfnTCCdds0KewwCnlvOszrfPZptRhrjPI7jexaguc9kx9F0nHKP/P8FIMtkp6XDkjvlmAerDq9rgGG0L8T3+Z+YrXqM6mLHTHbwGivNwGvvnqrLNvfSqUjfuV4ATVpELKqR3ks+3Ywu7wm0nptRkwhtXTT02znydJCFoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816346; c=relaxed/simple;
	bh=/JFQ1f+yHsjb5Zt6+gt8OydljzAA9ds8/yUsrr7/NQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/oi9mvSk+QeC48UJQm8WE2szUxJbkVzNjmZYRowdFCdQN+wj03GhTgtOWHjd65N/tTnmloTY8hCnVrWqMbNT2Zz2sLIB3fDo0Jl67Me6RVgS5qXt4W0IiyQsHxzMzcQOUwyOsnDIYVYODQfNwNz0qX4n/YiTgRiJCXqK9EY0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX8UZAn+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d606726cso4292438b3a.3;
        Tue, 01 Oct 2024 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816344; x=1728421144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLSo4Y+RlvJE8rHN+xUYDaCM/v2W+3AtNr9b9F2/l8E=;
        b=gX8UZAn+JIE7EKi4orSs93tOETvLn8Wrlcrm4NApsZgTwkr7RLQJwME/2RKtg5No/J
         hkkbNXTwKoyRGrxsX0oH6GinbnxCOgaoGNxvAwN5CKaxkuAHu71wFU0f19rod7IIgyC5
         clYtHsYXFmR5TDNZUjkPzWTJxER+Eh8msQqzISHvG2RoZjt1lrfVmIPMiN1rcvvOwXXP
         PddxD2PbUZSbwgsK+FZioWLRWip5/CsKgspnHdZ12JMVlT5j1dX/VRv0AoMuZv+8kDfB
         EJoIPO3I/G9JcmV5lDYaT4BCBUUhC+0/WL0R+IH7UsY4HBro4C7CaJ8XAqujYuiBNDiu
         blwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816344; x=1728421144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLSo4Y+RlvJE8rHN+xUYDaCM/v2W+3AtNr9b9F2/l8E=;
        b=glq8qDvIBe7sQJ+qDhezmHoEoEZVP2d+POiHV+E/FhnnsIojQ7uA3lmk7X7GP0+J3v
         oJRt6dFKOwBLoklRwYFg5lObLq/bR4oHlpIjRYQmKgDx45XpvNoScy+ljsD1xCpUjaST
         kHcd7sJ958mS2s1+k97AMd/pBT+GEaCjLFfjpg6f6JzXwZOST6xcSa4Fu7llYuIW5Oyr
         56a4phhnGhQUhsVKoeUBneKgOakaDdfSu/PsjhjH86ejcobIq7uPsEUB7lZ3UuKu10fM
         demX/8keVpnTb2SzHgHPoc9kkqfX4Bk1mo2676jf1nfdjrwy1VMur960DFFriA4G72Hh
         K+BA==
X-Forwarded-Encrypted: i=1; AJvYcCUDjXkXeBhJNkv/GzADxXUPXT8VBvd4Rg3p0plAq3eJZHUT7a6Aby2+NBOovnW09s5pIDimV6XS6rCv6dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC0/a18DAa0MvgPnTMa04d5By2it2fK0osAMrty2GK40I9+YY7
	SFJeFOXWNHpFEjA8T2QrgsrLKs7Zdhj4fDQIQ0/QiDejwKrjdQcbUqvgjfqu
X-Google-Smtp-Source: AGHT+IFEBRLobt6TFhfSwc1KaG2FVTkG+GoIH6LlYyDbTeZR1H7TIWh9jwc0S2SrCduHb3V6noJyOg==
X-Received: by 2002:a05:6a00:4f8f:b0:70e:a524:6490 with SMTP id d2e1a72fcca58-71dc5c42a8dmr1575449b3a.1.1727816343907;
        Tue, 01 Oct 2024 13:59:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 12/18] net: ibm: emac: zmii: devm_platform_get_resource
Date: Tue,  1 Oct 2024 13:58:38 -0700
Message-ID: <20241001205844.306821-13-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index c38eb6b3173e..abe14f4a8ea6 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -232,9 +232,7 @@ void *zmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int zmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
 			   GFP_KERNEL);
@@ -245,16 +243,10 @@ static int zmii_probe(struct platform_device *ofdev)
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
-						sizeof(struct zmii_regs));
-	if (!dev->base) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* We may need FER value for autodetection later */
@@ -270,15 +262,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void zmii_remove(struct platform_device *ofdev)
-{
-	struct zmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id zmii_match[] =
 {
 	{
@@ -297,7 +280,6 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove_new = zmii_remove,
 };
 
 module_platform_driver(zmii_driver);
-- 
2.46.2


