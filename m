Return-Path: <netdev+bounces-131047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2998C717
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0210C1F24F7C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1F1CEEBD;
	Tue,  1 Oct 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaUhoYsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CF1CEE85;
	Tue,  1 Oct 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816333; cv=none; b=iZ0G5gV/aArY79ytR0792c1QbTlb0m0PjqV5Lfrn7IIKNAg9JtCtpy1kAXKfb2DyV2rU3AA7N4mBU5YSuBwhjxzCqAwViS8ZasapnMfYy5u9j94sN4TutMmyzf2Ovd24yLPbz410Z9Q1eCsw3tKISa5b2JbDPrH/aLEQ7ZXYmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816333; c=relaxed/simple;
	bh=E2lpnkQkB6alWziSY4dY/baMJyxnTAm4Bw4gm3jpZVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IShKZE2lGIJgwRR9stxcMDb8Q2CSqiVni4sk55TAj3DzlvH+PmarUAmX8QBgioDoe4gUWzeHImKQnaet1fp+hVWyE/xcjXLJJAv3KxkGFMCSrCeMil868vxz4cfLMwUTcPuisrsX6XJwm2PQ5tRKu3MzKDBCMxeuavRh3RdHwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaUhoYsH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71dc4451fffso582057b3a.2;
        Tue, 01 Oct 2024 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816331; x=1728421131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u5EqNnoRftoG2NG+EU6QGUJmaRNtnq9ufFREhiUF4c=;
        b=LaUhoYsHT18kaD4q/NeD2KUlVNz4W5fk4/J4LzLMZx+S0zEyoVZWaVUiBTGnA2sUbu
         G4+aNnqpRzIxr5OIokz57hp1LF4mvUzcpXgBd5BDquYmSqd1OjkRNasIDwoAhbY+1q8u
         nEHK1HmRUB7zOsjovyGYFbV6GAFHE7MQJPuJ+018HYsj23h6jnObf5FmrZ2AH/ktE02x
         iT3aXTjyQFf+YgPU7MwdiH8fwfHNocYTRsaoXRcJ/Q6fBGf+8J2AfG5FWYYeC0X2bXm0
         FRI4ksAhMNaKwXXgkZKYjeoPrzlOt2udPjnsL5eSRxGYNVzo6UHC4icrMy4brs6mF4Zn
         MbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816331; x=1728421131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u5EqNnoRftoG2NG+EU6QGUJmaRNtnq9ufFREhiUF4c=;
        b=VsJ3VFEo24r1o9NgjXMzbbgW2H36wViE/7nmI5QsDaZj9jZ1aikGha26prTtcHyQe0
         DiQUOzT43DoRTUCWVLnnsIPsdVN2/deasG8iUgDquqRg/iim9pEmmQXoZma1DDF6nIid
         3zOiKiQZ2AmRNXTbSGfO53dr4alPJVs5E+Xevyw6ETM7Oz+NGMduNBMm11nWEtCaLS9W
         idlM0vAetJMp43BKJHNr7PRyvoog+1YW7+BUbOxcLBh0R0h2W8fn+UM5GADEYEX/4sPQ
         r0NFXjLUQS70LDqiRD+OhjwKbBmOqtUuPjIFGvLOMkCKTkhY9S5FY82lsUNekdAlr0R5
         4VYw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkV2jOXgFQrBbe4MovB018T9Z/2W70cie9inPqeySgsmG4j0YunaeWODmAtS5JVBUO+/Mm4xWC82vMKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrLHJJWnsOG7qNDBGC8a7X+i/97zIdBX3ZuqjVK1xii8J9MOY
	5/iNDHPijmVdbP0SFnzrYtsNMwbk4/G5Tr1euF+4o9Z+TqillNRsEZD/6xx+
X-Google-Smtp-Source: AGHT+IGIBz+BCy19vbRJIQndwYAXWyaXZpjiAqVPJhueT2p/meXUdb003OCEsDyZ0pbVsutbLFpeUA==
X-Received: by 2002:a05:6a00:889:b0:714:2198:26bd with SMTP id d2e1a72fcca58-71dc5c67060mr1684347b3a.11.1727816331154;
        Tue, 01 Oct 2024 13:58:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:50 -0700 (PDT)
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
Subject: [PATCHv2 net-next 03/18] net: ibm: emac: use module_platform_driver for modules
Date: Tue,  1 Oct 2024 13:58:29 -0700
Message-ID: <20241001205844.306821-4-rosenp@gmail.com>
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


