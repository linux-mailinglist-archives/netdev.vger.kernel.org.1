Return-Path: <netdev+bounces-132438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD1991BF5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B4A1F222B5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CD16EBE8;
	Sun,  6 Oct 2024 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq3KncfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B11EB3D;
	Sun,  6 Oct 2024 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180386; cv=none; b=KITs8dpPPTYmxqSN0RZzbDn1MoKPmrHBW9Cau/7+Lf1swQ60VvPx3WAQs98WaeUt16ULvfq31xFk++y16Ly7KX6foClgqO3rIlP9wyeNahlcxvFSsCJfIqOcHWDlGf2QNJq9fvMUSv/WYNM4FOb5OTsFb9YSJ9xkJ0lrYhTDnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180386; c=relaxed/simple;
	bh=d7G7xDlXNdUXfohj1+x3twk/5hqwlSMTAj+w5XeGHMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThPH1oT5o4wA2NAIcF6u/hl+2FRm8lX1kqfsV+Wa3WEYOv/exX/hLkp99UUExDSAF3njBWh9mcUkYf3GYmpGmxDKj5Jn9xP7wZ7tGAVc+EgXi5UFeGclqUK93oVgb3BU5sRShdK0YTe5knym3cDYgQICbcDDWgtx7yy7FJHf2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq3KncfR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71def8abc2fso1126616b3a.1;
        Sat, 05 Oct 2024 19:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180384; x=1728785184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHwdxpLFsmkFWIWIZKleRWek06HcsjEkdbhkqXrCUps=;
        b=gq3KncfRZ9I/0fJM8DaFP46RxA1JZv+KP+V4p3j6UcgIYUFLgmMiECmcRoUyoYopd+
         +W48n1L7tZER15txvqJHHhMIUbqvrNZFSv+ndNYMnhqgQui9xxYMfS7Q458AoM7lAiOS
         wbc61R7PLbD0sPgZenNr7YudPuVE6ALC4/ZL6dFZ/pXwTrpEF18aiarfcJzkKhlz2QIA
         ituEU911YiMs3gBDl3P6Q/7agvGFzVP8ARxg41tm5xGHaMJPLUb8ys/iZtIbH2SMuG0F
         aHjpRjTPRLPqiw5glKZHzq2esrt3gxrJz2XKhtvs0s2vMGngLs7lTWobVhfXjbev9UbW
         37NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180384; x=1728785184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHwdxpLFsmkFWIWIZKleRWek06HcsjEkdbhkqXrCUps=;
        b=dKeqVyLrNO2sEVPxOvoVVH1X9mjc48JhsU1xdaDqcbA6W36frmdEueqou3JQUDsv4d
         KefQ1IuWPiNO+A6Ri07DyurJB545oW+iFA2xz4lemT3Vv36gByS4uCon1OPlzpNUf0gq
         IAZ9esJEwSee/s/sz0CHdDGbB+THMLiCsmUcKp+p5X1lE7vdv4Bi0H1KfpXSujB2+6qx
         LoeG0gWUrOVpJZwSBqDbg9yl/0M1ZaG56AHha+NhSWwVD1IhpKH0t3a+SQLwGPwuPEYL
         iOJpr3oOorstwd3nstZrhc+XAmuMocQMSrgEt05vRcoDZW9La5B54+FGgYe4m7gQcHL+
         E9qA==
X-Forwarded-Encrypted: i=1; AJvYcCXOyB4YgEN0yfabI80m4zg9pbQi1+KCSPrJmg2Mfdkz7WqA3H7hER9f4nNZVDDUPNpWDIeLNM6xnCuHjw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxuLmNdZsPibdrbUMFjMCXSeldKkZKJ1VjvF5vJ/pldLfEbl6
	JZEYLMR2lyQ1Zy0mr1njQ73IV5KgzMy8wgBtvxROOzPNuiyH/6X6XgqUzg==
X-Google-Smtp-Source: AGHT+IF80gU/S2SHEvoZ8qAxWjR6LoUr1gRWpHtxdZKqi7ZyffYiZnA2iEi+89TEnJd36TwNH3OkSg==
X-Received: by 2002:a05:6a20:cc0a:b0:1d5:10c1:4939 with SMTP id adf61e73a8af0-1d6dfa27eeamr9157204637.8.1728180383713;
        Sat, 05 Oct 2024 19:06:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:23 -0700 (PDT)
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
Subject: [PATCHv4 net-next 3/8] net: ibm: emac: use module_platform_driver for modules
Date: Sat,  5 Oct 2024 19:06:11 -0700
Message-ID: <20241006020616.951543-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a consequence of removing explicit module initialization and
deferring probe until everything is ready, there's no need for custom
init and exit functions.

There are now module_init and module_exit calls but no real change in
functionality as these init and exit functions are no longer directly
called by core.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c   | 10 +---------
 drivers/net/ethernet/ibm/emac/rgmii.c | 10 +---------
 drivers/net/ethernet/ibm/emac/tah.c   | 10 +---------
 drivers/net/ethernet/ibm/emac/zmii.c  | 10 +---------
 4 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index c6c5d417b227..e6354843d856 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -752,12 +752,4 @@ static struct platform_driver mal_of_driver = {
 	.remove_new = mal_remove,
 };
 
-int __init mal_init(void)
-{
-	return platform_driver_register(&mal_of_driver);
-}
-
-void mal_exit(void)
-{
-	platform_driver_unregister(&mal_of_driver);
-}
+module_platform_driver(mal_of_driver);
diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index b544dd8633b7..6b61c49aa1f4 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -280,12 +280,4 @@ static struct platform_driver rgmii_driver = {
 	.probe = rgmii_probe,
 };
 
-int __init rgmii_init(void)
-{
-	return platform_driver_register(&rgmii_driver);
-}
-
-void rgmii_exit(void)
-{
-	platform_driver_unregister(&rgmii_driver);
-}
+module_platform_driver(rgmii_driver);
diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 09f6373ed2f9..9e7d79e76a12 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -138,12 +138,4 @@ static struct platform_driver tah_driver = {
 	.probe = tah_probe,
 };
 
-int __init tah_init(void)
-{
-	return platform_driver_register(&tah_driver);
-}
-
-void tah_exit(void)
-{
-	platform_driver_unregister(&tah_driver);
-}
+module_platform_driver(tah_driver);
diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 69ca6065de1c..40744733fd02 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -286,12 +286,4 @@ static struct platform_driver zmii_driver = {
 	.probe = zmii_probe,
 };
 
-int __init zmii_init(void)
-{
-	return platform_driver_register(&zmii_driver);
-}
-
-void zmii_exit(void)
-{
-	platform_driver_unregister(&zmii_driver);
-}
+module_platform_driver(zmii_driver);
-- 
2.46.2


