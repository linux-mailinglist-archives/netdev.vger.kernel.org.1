Return-Path: <netdev+bounces-130518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A2F98AB81
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B6B22D78
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6435199FA7;
	Mon, 30 Sep 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfIrdLQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C5199E9A;
	Mon, 30 Sep 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719248; cv=none; b=XcAgBdhIUvJVRQK5srvSKvhrdR0l9+0crQTFtsfPiObM54jxJJH16TX2v6kgoy7gxXybl+WzY7vrDPhkfqpsleyzcJYW37/pOrb/VxOqBYpr7a6WDbtRXltSZN+gtkmjAvWfNoLopnE8EH1u4G41TV+EAXsyHlYmmm572uBI6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719248; c=relaxed/simple;
	bh=E2lpnkQkB6alWziSY4dY/baMJyxnTAm4Bw4gm3jpZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZuZqoY4nbGtmnFuCZHAf/6iEcnUAeUEpxk8bnUoScOnBveKpJgCinwkozN2boWtnEct9UKLckbxihcyCQ+M2tlEpvk06UVHCE3QCLofbV8HUFVRwoElvjmIoPkLVDvL6bx0EilSwWwgwxR5YW8bPBoRUi356OVAabzTF0aR+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfIrdLQc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d6ad6050so3901424b3a.0;
        Mon, 30 Sep 2024 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719246; x=1728324046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u5EqNnoRftoG2NG+EU6QGUJmaRNtnq9ufFREhiUF4c=;
        b=UfIrdLQccnayNPDotL3++64el/8RhECGT8zOARX8t3ccBveeCbzCWLvc07uEtX0dBM
         hj3o+xkWVZYHpDULTtcghMW8PEZMQOYkuGXdsLErdgAJf3LxjOfq5n9smLfa0ioj4JYW
         013ehdVPO13QqGdVJip68622fZoSMyzAT6IcxNW7swVRXbz1KnydGqiadDUzV+mZrWl3
         7g5Dk29Lp+t8goYI7QYecS3iDTxTYwH1d6Zg8EY5mR2wgOTXewwQ2pDL10T9OKZYdpk9
         dTUQB4obtOQwrzCV8K80TNcEH9P47D+oDF2D7p/Y4JaDTHuytm0VSIzQjWTJeAfQJo7O
         IfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719246; x=1728324046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u5EqNnoRftoG2NG+EU6QGUJmaRNtnq9ufFREhiUF4c=;
        b=kh2AOsxLYT88DorLLTAXY/rOcuzTuzPqThhH83i9hbYJUdit5h5EsIXNdzP5+h9EbB
         QW1iF1gXFHeCxpeagt9G3bZsc4QzfYyNjDpMbzkRirWvpeDQjRlui2XYxP5qhzdYp5N6
         pJ8/oTsDqQyWxN47q1Shl9CHG2U/CPbPx/OZONk5APEH3J2uCximb8qg+CmCSK+mVE80
         eRCqj/mtTXNws76bniYYc0bPIrzMUkI7H3uHRPSO6uwqmj2Vmagru5b18snLOft4Gm6X
         WJbINQ3sGPuBJ7NhscUdyZ9EpySZl+Jmvb0i633dYhWWEvvVT1hTcI1vrvMCtf5voWmi
         1qeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXviCOTxM1pO9z669dJJgx4ShEdnf7mk8u++KEn8jicR7Jpwx/WGY78RAbK9o0BiwFBeOBALqvVVKuur8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrDC0xOs5rLZObIGI51daFT4UEhthqvmJF1GEQBOdBqPhLrS0
	MSdqWq5QyOBSwT6qXU4WBAKJ7TQWsk2QplVauIBMHXNC/W1L95HdvHUaQ1uC
X-Google-Smtp-Source: AGHT+IG/rbJ5oVwpsw8XZlptLGvPQBAAH04LnEZIpaWqcQjA8QJwbqDb357nPoa8cFrCnVGemRSbJA==
X-Received: by 2002:a05:6a00:c95:b0:718:532f:5a3 with SMTP id d2e1a72fcca58-71b25f37976mr20626768b3a.7.1727719242265;
        Mon, 30 Sep 2024 11:00:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:41 -0700 (PDT)
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
Subject: [PATCH net-next 02/13] net: ibm: emac: use module_platform_driver for modules
Date: Mon, 30 Sep 2024 11:00:25 -0700
Message-ID: <20240930180036.87598-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
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


