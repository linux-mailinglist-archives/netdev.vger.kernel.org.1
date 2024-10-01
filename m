Return-Path: <netdev+bounces-131001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C798C5A1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB4B1C20295
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CE71CF5E5;
	Tue,  1 Oct 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ98lMKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF71CF2B6;
	Tue,  1 Oct 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808384; cv=none; b=XBTPKiBXRDCPSAwXAzP7bWKot9hF6jrb1cJo8UjzngWHzE1JaKx/MWatf0C2aagvnKyC+7tscsZ9/IJ+EuAiXt7nhTOT2UXbsfvg8QpPVD33ee/CV5KbZ4zjHBMJrzjqIHC6nE1GUl8DrUzdBEwlacbXr9dHFLIABOCwMPNn2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808384; c=relaxed/simple;
	bh=5qmG+wajx0WCsvKwWcs7IoBgHfua90wDFBVXa2Sha4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUOv/Ej8d/KahXBHfGAWmH1in6rdtJDdVJUd7nwGA0CkqtGttiGsULJULVwECgN9IQQSw69j7/3fjz71mpfplmUm4sngRfqnXMvSXqGSHen00Sz8WFjTuCf/vG3maAV89+f/9b9uG7XhksKcuF/pMsXtZ6APzsGrdjeuNqClFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ98lMKJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20bc2970df5so4129065ad.3;
        Tue, 01 Oct 2024 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808382; x=1728413182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMaWOdiRSC2aO/xql7aYnf01wKeeiE3+pOq1iTVYN04=;
        b=UQ98lMKJxX4Wu60h4fIW5OrMWC/QJ9e1G7gkOMZS3SNpNcOUWyqhcoj2wiM6B56qSB
         3YaPYvPx7jl7ej8kcQL50uSLlcVjAMANSy4qKFIoe17Jn12nf3TJ/MF3IljrSGvgx0Hb
         EM8Fo18CAHlx+pGa/fBYhRuyw11UUOWoC8FBEtjU2eXJJxfA95WLNagbCJxUgUDjps89
         8Anftp0aw7QnFQ6zaSAANc6nQxe+zd9q/8kqZofU/p4MFvuQTzqdcoq7DHai18D63Nw3
         xxCsytW8C6Q8aac7wpxDU/E4rcj2PD0EfUzEnFaIWvbv6crZpNyJRIJpJ3uQ0kAE5vqL
         hE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808382; x=1728413182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMaWOdiRSC2aO/xql7aYnf01wKeeiE3+pOq1iTVYN04=;
        b=Ju58Zc+1LoOSK2fRERTEneo8MINJ8pcJSTapcay0+VGlnwGXcu2emaOCgSnbAxyQBd
         ZYioiG4u30YaTQTeGDq9OiR2gKWuzD5Y+JEbqMFUHtXWxDamAk4hPpSdG9TE2Imhabgv
         FwIMOsWWwIAxEmzBf4Txbs3b7L/jRF6B5JQcr/2reRuJJczQqEBsiP2A3xryQ28jqnVj
         4y3cc8CeKqtgM2jw4Vjct36aYYtn8K5K6cm7idt+HIGSOceYUQ90hM35YsWd24/bQTNM
         kBZnd6RXF76cp7B0YGvi9oAlKewEr5YMs/+CaeeJmCPYa/CKQEq1Vj8xAZ4Pa4UZDsEx
         8xhg==
X-Forwarded-Encrypted: i=1; AJvYcCUoMjnUSK8qj4/G3CG/Cewge5zxdzQDK6s71cL7PwBvCODiIt2qmOLXTTb4EmK0kz1nduN+DJ2aPk2HQgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EGiQdHJY5AyDBYySqPO8FHhx81ZyTGjQV65IlYSIG418ikQf
	CBxHVa4R/v983MSWLl65nLIvzF0f6cKb0cCMSvfhsZRsbY0TOxN5Di5vNntA
X-Google-Smtp-Source: AGHT+IGn7NyougIRsCMb7tGqFLABL8vHTnqBvJg1QaU1cIgSW1SBziUzjeew/p2R3drMH12emBeCJg==
X-Received: by 2002:a17:902:fc8f:b0:20b:8c13:5331 with SMTP id d9443c01a7336-20bc5a4e9ecmr7804205ad.43.1727808381750;
        Tue, 01 Oct 2024 11:46:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 09/10] net: lantiq_etop: no queue stop in remove
Date: Tue,  1 Oct 2024 11:46:06 -0700
Message-ID: <20241001184607.193461-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is already called in stop. No need to call a second time.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 1458796c4e30..355b96ecc5ec 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -673,10 +673,8 @@ static void ltq_etop_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
-	if (dev) {
-		netif_tx_stop_all_queues(dev);
+	if (dev)
 		ltq_etop_hw_exit(dev);
-	}
 }
 
 static struct platform_driver ltq_mii_driver = {
-- 
2.46.2


