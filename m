Return-Path: <netdev+bounces-130655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07698B025
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD24C1C214E8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A11A38C6;
	Mon, 30 Sep 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R63iPdU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803B1A304F;
	Mon, 30 Sep 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736072; cv=none; b=rH35qG3URFhO09Z8ybKOwqwnrI7us0HWK97c77ESRmtcyKPQyDx+3GLM+TNZTf+iKDIRFLCDA6wA6u92lqkFFS+MhCuXEsRZP1yb4T9FhJ+3RfFhVas7zr32r9Xioup1AH4xMyqWAr8BGQkf2+en/cRG36YxjcTwZ9bZnXh36iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736072; c=relaxed/simple;
	bh=kloClghRgz+Yqeil0HFI/EHrorEwG4+kDSUa4p4zY/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdaRDKTu8I4iIpoX/4s4/PAPLY1qLQuXCGlFgx9usMI/TU2kvSG30EQX6Ed3obvY/gm5s2gcnvLeFMkaQGKPROZX/ItBoM+Kk51GzKJxHej31SSs/5sjhdp1VUQskZ1Ym4w8AszVW/eR/z3f2/PuQG5jHbQVWbsV4R17kVWaPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R63iPdU4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-719b17b2da1so3517674b3a.0;
        Mon, 30 Sep 2024 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736071; x=1728340871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpOdTbaCej9dLM1JEzTBAYpYctEsql9gZez+rqFBwS0=;
        b=R63iPdU4KV4f4dKfQcSmxSOLfbDD47EAM0XxdqHbp8G8qa2mxx7CSqFgqLsATAXVIA
         RHcjC0VGoImzruTgr6bGXN4jw4m0UtZHIr6dr2UJCeXnPbrN0pkU2CnGlN1+5gnm1FFz
         F5jkZXxTzIa+10IyS/VedXh7ACqhWyqzwFsP9hC0ZqzDEy6nE6BsOchlk+pHXJnviihm
         Bhb2N/kgFO3jjADP95SBfK8dBoQjtbEKfaAtlCzeAuAiOp2KT+hhhQGwaQV24mUog2JZ
         twKvbQdSlLGHGLdDygvUYtioX6SRvJ1Cd7348q8zcbFEom75RIhzWsZnddwshEFrSLMo
         e0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736071; x=1728340871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpOdTbaCej9dLM1JEzTBAYpYctEsql9gZez+rqFBwS0=;
        b=e85OTSJO/J1CJ5LQtzkTIsVNuXDMwvdGvjO+pgFeU3INIf0Ih71eAPAkANkF+23MRe
         BnOPv3A+Oo9a45pGT0N15+B+YyoMo9wiUIvYU6leAkiAIWVHB+q1nXBu0NJhRuJBOXcg
         jIpy19omphSEx0hovm6BadydKHAXwNHXD+1HQq4vskwkAlG2wo7jVsz6Btv/9T4uc01r
         kTyqu+vv8LMdZZbm+FckUdURCCtQ5OCkW5r0u1DEXQrswf/s+Es9/oGubU5M6alICeyJ
         97HWk2EYcspaal6vcHzm+62jql0xGMR2mcEqvja3yi6uAgMYUxCqgFMN4yEkrdYwqSVu
         YUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZgwWxqQZW44raU7u8ouGzOx/GewP+WaTrfZ1ehMode1gz7lfSHsDb/52rOg1T/xciPFq4Mb0/7GbMRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ecRDS8URwVrvK/pKclKg5ZKO58OMfnFzIY3lGbFKgb/EFo2D
	C3xOr1+7uQIcnXH/hdUa/APiQ/xsjpJd7eJbU+GMemhfc/QC5j8JXgyLYfh7
X-Google-Smtp-Source: AGHT+IGDNsseyz1NhKJkcvNgjuZUoTKGam+hAXNLhx84epEyi19FBd+9ylY3cTL9JejjC2Q2M9WKug==
X-Received: by 2002:a05:6a00:2191:b0:717:88eb:824d with SMTP id d2e1a72fcca58-71b25f356a3mr21158304b3a.7.1727736070534;
        Mon, 30 Sep 2024 15:41:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 8/8] net: smsc911x: remove pointless NULL checks
Date: Mon, 30 Sep 2024 15:40:56 -0700
Message-ID: <20240930224056.354349-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930224056.354349-1-rosenp@gmail.com>
References: <20240930224056.354349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioaddr can never be NULL. Probe aborts in such a case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 5eea873db853..a74c3f9f7110 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2105,11 +2105,6 @@ static int smsc911x_init(struct net_device *dev)
 	spin_lock_init(&pdata->dev_lock);
 	spin_lock_init(&pdata->mac_lock);
 
-	if (pdata->ioaddr == NULL) {
-		SMSC_WARN(pdata, probe, "pdata->ioaddr: 0x00000000");
-		return -ENODEV;
-	}
-
 	/*
 	 * poll the READY bit in PMT_CTRL. Any other access to the device is
 	 * forbidden while this bit isn't set. Try for 100ms
@@ -2334,11 +2329,6 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	if (retval)
 		return retval;
 
-	if (pdata->ioaddr == NULL) {
-		SMSC_WARN(pdata, probe, "Error smsc911x base address invalid");
-		return -ENOMEM;
-	}
-
 	retval = smsc911x_probe_config(&pdata->config, &pdev->dev);
 	if (retval && config) {
 		/* copy config parameters across to pdata */
-- 
2.46.2


