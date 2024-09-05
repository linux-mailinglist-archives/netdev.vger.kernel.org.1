Return-Path: <netdev+bounces-125673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD196E382
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9351281B1D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80D1AF4CC;
	Thu,  5 Sep 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBwEk+YC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C421A76AF;
	Thu,  5 Sep 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565789; cv=none; b=sagyYWtYp3QA196vDcWnntk82pVc3FqOWEJ7QZpTalIDlvdwWffxZzfwOlbb56FS490o4QPq3Eexh/GwUZY03e4sTxofDD9AyIErUvEHKEeA7laP5Fur46D6F2Q5RxYNzFQmLboP14Etrny8IdxHI3gwCNGVubxzxEDGdj6DgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565789; c=relaxed/simple;
	bh=e4LMAghAK6jo5o+X1LD08BhfgGQOz6zRc1nTh8q/nQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9weK5W8J7WC3QZqMhoLANs5RQ4FN8FhnruzKIlmhQ0lHzQZjwXdu2KPJ2WDSJJBLfVsaC7IEzhWtjUW6PYI5tGwEEXi/RwYLGZSuygNIcRRwTqEpbHDc4sYWVOOSql7UtRg5e0C6pJQXKHtFcqqnH1tOFc6mYKco1FhaUiU9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBwEk+YC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so866045b3a.1;
        Thu, 05 Sep 2024 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565787; x=1726170587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL1pfpncPHaRZcWn98mFEfkaPIbamaj0hcsUBZfNekI=;
        b=lBwEk+YC/9FxexOk/rRlNq7tjZYemcT70gXV4skSvBmoITVNI6jw6BOSlnsddKHwPW
         IepQcVBUeEIwZc4Rx43e7iovLfcI27pGi7dBZ4wh5mZRCGgUQJznX4Mqt8qODEDb3OfL
         gZWJwQKaL+C2hAhLpzexR1EbJ2eONThD5nBeSHrOsLndV1LvLENuNXtU/Mcu4/lIIbtm
         7KkL+DBK0tiPd48iVueDtzul6BsFzVX4eAgq8aedi34rgEyUYdTyaU+E42bYP3/B25s5
         EAc9NLAm5RhYrkrSKYJBCJ59LZELf8ZYG9DwK22o1jX6F+15HRtl2wxtiX/DEVIICECN
         Zhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565787; x=1726170587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL1pfpncPHaRZcWn98mFEfkaPIbamaj0hcsUBZfNekI=;
        b=azv6DbP4HZWpJE8K8+lz2bM+osW0gS6+vTCtCHAkVlgTgoRV+8cC8MOzVF5V1OZJjx
         Gm0CnJBvW9NQMUx8thWlUsfnUtDTYtQx3He5MaJl9on+91YV3CEPSMEraxCNl9PdOmq9
         W0B35DQ1LduqQUXLZyBvUWL+xczDZ1DH0X4KfFOhLfKNXCSvG5HB4bTyGbqPc9/fvK5w
         fzfMdohYqWTvfq02YJ8+BLYeJsHFmA9BaMv+6W5oTFabjnRwetvUZFiHDuYjhLffAJ/e
         Cv5RITTqsrQQWQEinaCdwSdCQVxG3PTvjkMSJqzy49LQ8G+J4kDNf0VbTQSVWTggDk0T
         IE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzPBfbTbTxrXKLicmIh+1LJYaX5FjZnjgik1E+Hc6yyCH1sAH2OWOaIriR/C5d1LhCyNBl+Ls67zt8DFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyC9pxv3+a+nlBLOWU7XywBnZayk3Oz5J5BE3CYZhmucdtvTag
	peJA9UXGgkWLL2d+3C07I9FwU56d1VOtPWBD1QKaEkKte6PoTzWZYNEvqaFr
X-Google-Smtp-Source: AGHT+IG9IDvsFgmdmoSaweIVmZZDA9BTh83Iv6B1a5andu+0H+OFFrl10Ae7PCVqrOxNmlItLJ+37g==
X-Received: by 2002:a05:6a21:3987:b0:1ce:e080:185c with SMTP id adf61e73a8af0-1cee0801caemr17859602637.41.1725565786921;
        Thu, 05 Sep 2024 12:49:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv2 net-next 5/7] net: ag71xx: get reset control using devm api
Date: Thu,  5 Sep 2024 12:49:36 -0700
Message-ID: <20240905194938.8453-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the of variant is missing reset_control_put in error paths.
The devm variant does not require it.

Allows removing mdio_reset from the struct as it is not used outside the
function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 v2: move variable up to maintain reverse tree.
 drivers/net/ethernet/atheros/ag71xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 35db6912e845..a32a72fa4179 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -379,7 +379,6 @@ struct ag71xx {
 	u32 fifodata[3];
 	int mac_idx;
 
-	struct reset_control *mdio_reset;
 	struct clk *clk_mdio;
 };
 
@@ -689,6 +688,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 {
 	struct device *dev = &ag->pdev->dev;
 	struct net_device *ndev = ag->ndev;
+	struct reset_control *mdio_reset;
 	static struct mii_bus *mii_bus;
 	struct device_node *np, *mnp;
 	int err;
@@ -705,10 +705,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	if (!mii_bus)
 		return -ENOMEM;
 
-	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");
-	if (IS_ERR(ag->mdio_reset)) {
+	mdio_reset = devm_reset_control_get_exclusive(dev, "mdio");
+	if (IS_ERR(mdio_reset)) {
 		netif_err(ag, probe, ndev, "Failed to get reset mdio.\n");
-		return PTR_ERR(ag->mdio_reset);
+		return PTR_ERR(mdio_reset);
 	}
 
 	mii_bus->name = "ag71xx_mdio";
@@ -719,10 +719,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	mii_bus->parent = dev;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
 
-	if (!IS_ERR(ag->mdio_reset)) {
-		reset_control_assert(ag->mdio_reset);
+	if (!IS_ERR(mdio_reset)) {
+		reset_control_assert(mdio_reset);
 		msleep(100);
-		reset_control_deassert(ag->mdio_reset);
+		reset_control_deassert(mdio_reset);
 		msleep(200);
 	}
 
-- 
2.46.0


