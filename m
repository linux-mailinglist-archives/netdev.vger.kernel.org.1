Return-Path: <netdev+bounces-131442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3998E841
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C961F2590A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF163C463;
	Thu,  3 Oct 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmIpzWKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BD2110E;
	Thu,  3 Oct 2024 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921504; cv=none; b=ZOuXv/nd1DWw49ltcsRWnjApvmjipH03HtaccdIOuS9Yd61/v3t38ANwOaPmH3/imwPEbakuT+j68vSgzEaCUaGMoSGAheMPlIizw9dEMxXQnMs4HjqcpLrRo+C5zEehvSkmPGyX5a6G0NanscHC9NcYiBj5HJj4fQZPjT65zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921504; c=relaxed/simple;
	bh=E2lpnkQkB6alWziSY4dY/baMJyxnTAm4Bw4gm3jpZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q93zGJysegEzCLPL+k8kmEcADyRTAcNoCNaRcwl8Y7uMidTj+6RVB/GIf6Iq7Jt8VW0m+/ZjD+uppNsBSc4GD3GgwuZxJa1mBQXe4cu86rWIXcZew/kXOiSeZoO6CjqkhN0oxGuE63eKMmIWXgo1A75Jj6vQxDXkCV/6Pjn4f6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmIpzWKD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso316863b3a.1;
        Wed, 02 Oct 2024 19:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921502; x=1728526302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u5EqNnoRftoG2NG+EU6QGUJmaRNtnq9ufFREhiUF4c=;
        b=OmIpzWKDEcfHTuRm7emi/CvfAumVRUYXgUAsm0XqlSLkyqqK1KcH9NLNKro6oeQ76r
         arSYPjV7RKLz3MMLS2Y4MJ8MK9RklSnwcEYbnaF396gSe6GPLg2mlrmUvcfvpoEuD73s
         k/ktTzNftnY5t+S/ZR6SlyQkuELVJ8bW4rFOyjPmWMSO+Hbi/B2hFtHNv+HmWMhAGoDg
         B/Kgg9ZokJfSglN+H7Mbx5I06skaU8ddQTWNS2cK2Wc5m3jYR5c0E41Dr39NK05KW/uf
         WrKbvgjZPk1G6Y69OD4JvMp6yC3EnD3i6Hf9IR5/9ec1vzT0i2hW4JvM9h+LfvnGXIiK
         Xe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921502; x=1728526302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u5EqNnoRftoG2NG+EU6QGUJmaRNtnq9ufFREhiUF4c=;
        b=vRAb7uD0fh+/m77ysIBSF+qgHdWRsSB4VFh/TY04+HfAc1W05gE7ngafocZNSN2pKM
         Gx0nNugl1IB75wtH+ODueErqgNRjunBb5kez6G39N3Uz+1rNoTtIYLM1iy9NiSAvakQP
         weerLYuAZH7aZcRZ8PAM7SiZmMNgVS0aPNy5zXDBTSUwZOeHLdsYe4qPIL58+eeJCAvq
         44WZcJap8sT9tCSLmQrGAJ17AbzQVF5T9OzspJs2a7q+rJeyYYe5P/x7H5oLF0a5pcSu
         SjhaX5kHT7duk4lwj3sD+KzIGbnZIkAJTeC8pcvhQWegsrguu9dBS0G/jz4wFWXKjzMu
         J6eA==
X-Forwarded-Encrypted: i=1; AJvYcCVGLzgdVZWIrgz2WIHWWL5D7ujtzWre/TR//Se30g+prb7m4cqhz/mVYKJmkimm+ZHwb7wyQs7dODeS9QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzkHlOprni9l063leX1EulzRHQ6WRA5LBdCszcpfn6+SwRSkC
	I3lg79uKKRMVsfS38zy+Ux1vjSesIpoQwucoAgjr7LO/nPICoIh5OPksAJv5
X-Google-Smtp-Source: AGHT+IFTVND3heBNMaHST81acB5w+HKZ/SyyyrDiZYgelESbh6V2H6dKli9j8r1wqkKiu3k+2LA6ZA==
X-Received: by 2002:aa7:8881:0:b0:718:ebdc:6c81 with SMTP id d2e1a72fcca58-71dc5d6e8demr7611701b3a.26.1727921502261;
        Wed, 02 Oct 2024 19:11:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:41 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/17] net: ibm: emac: use module_platform_driver for modules
Date: Wed,  2 Oct 2024 19:11:21 -0700
Message-ID: <20241003021135.1952928-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These init and exit functions don't do anything special. Just macro it
away.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c   | 10 +---------
 drivers/net/ethernet/ibm/emac/rgmii.c | 10 +---------
 drivers/net/ethernet/ibm/emac/tah.c   | 10 +---------
 drivers/net/ethernet/ibm/emac/zmii.c  | 10 +---------
 4 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index d92dd9c83031..a632d3a207d3 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -779,12 +779,4 @@ static struct platform_driver mal_of_driver = {
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
index e1712fdc3c31..52f080661f87 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -303,12 +303,4 @@ static struct platform_driver rgmii_driver = {
 	.remove_new = rgmii_remove,
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
index fa3488258ca2..8407ff83b1d3 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -161,12 +161,4 @@ static struct platform_driver tah_driver = {
 	.remove_new = tah_remove,
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
index 26e86cdee2f6..97cea64abe55 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -309,12 +309,4 @@ static struct platform_driver zmii_driver = {
 	.remove_new = zmii_remove,
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


