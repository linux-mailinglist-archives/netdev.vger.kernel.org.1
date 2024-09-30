Return-Path: <netdev+bounces-130653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BBE98B020
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DF3B21870
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302051A2652;
	Mon, 30 Sep 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRKTaZSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0901A2561;
	Mon, 30 Sep 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736068; cv=none; b=r/XbqJ9Bqz8dXGOKALJT2jHy0e7h0RNVDmaKji2QRALodMeNoqPj44oFGG/Ai27OyiFahEdRyGl9VjvBoi0Idr/OFEl/4ih12VN1LjN792M89HABGJ23tMFzQDzivVvcq7ets3KTfWmnR1b71AcNypOZwPobIf9dZsDrST7+b+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736068; c=relaxed/simple;
	bh=lPXA040TtFtcChL0NIAfL6DNCp52wqj/Kschiuuo53M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYcJvdeWxprubI/Q+TL8MsT2oHmPGGFsnnJjoka+4AnpLVn5IHemcrtjnFSi6bRXyTfAs9JzCCYf2pil/KvQtsNcWXrIXydrLFUzxNfQXFPCfnFc3wpEv5EC3hpMtIysemxefmT2BxK7vyzAKkjTBlHcBVVrU9sy1NCpHhEjAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRKTaZSj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3252626a12.1;
        Mon, 30 Sep 2024 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736066; x=1728340866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC9YYCI7GpBan+FLHwaAVr2Bv2esNxWuipK7ENQ5lAQ=;
        b=nRKTaZSjXd7844CiF9oX1CC3UUm/Q2UhiQEL1dFV91iyugx2Aasy5cHtVB1GhxRQ57
         2+GlcxFnMO4nQB5tquYQgy0PfjnuZHN2KM6OnL8ttrH4/Es63fJSgdStqxrlNVqy9qsK
         v66v7Tt3nln8csZP/wFVJ+X6WDSps1CSLc8d9zrAH7pTG7UGvDEkSiXaf+MZSYI0Uq0d
         beN6ILeizB9c5qfvU2dNUAVEnjzPjiv0mR+FRRHR5cuZBbgdJkayxXxDY6rfF6qdW4T1
         u0WB07CIZt+tu3R50Gi8uFf5pfdLcu6b3Aoy4lcc2MFuquHQSXP89J3p79Rk0JRjgmAF
         cRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736066; x=1728340866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZC9YYCI7GpBan+FLHwaAVr2Bv2esNxWuipK7ENQ5lAQ=;
        b=HOkpdSS3yLjF6dxRx9mALNv6iP/Cqts0d8+Dds8GmjOEdGZQrinjzEdBdt8i3Q9lRE
         CDODw5w0A42sWnIHfSwJ6wHIFayC2QLs2lMdeIR+wkI9cFARwGN9y1JoG2kXbtQd7lVp
         K1Zyc9HLH2m1SMxxAQJXKV4py19qNu5PqrF2g3m2ylKqi6Svjb9Kb0Q78u2BBmBB0W6m
         V1tvR3v9YW7H8+PGSZ1JXCfXtLWZQ03NZR8gye7B9+JzBc/ifSdp6c+7BsLAi/LsDCGf
         P7EHxDG8OszDujtC5/+8nUoJl7vgSKEIcKeQKGVfRSaV3m8pFCgyYejqFxYGlaxITIaM
         6y+A==
X-Forwarded-Encrypted: i=1; AJvYcCV+Dh2lY5S2+NuOnDPiax7vQ9NgK7Yi/L+MawBA93hs48JbZ8PVNHafTpwRiA4XVie+duHvc6KrzYiCCTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGNDkVz8cYy5YekWPH2ZGCwaWjpDCEhf3gO4RtLP+eywJ/NVk
	B5m4wj3w7uq4dNZ/pIeicr2IzEZZDLT+FCvr2w5qkNOZ/WgayjorPav311Eo
X-Google-Smtp-Source: AGHT+IEFMBMY5pPA7J+uHeHiaA+Zi90TyFUs4A3JcThSakrH+/hcYRBVJll7JSS8vr4Nxji9nT1BEA==
X-Received: by 2002:a05:6a21:174b:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1d4fa7ae379mr16392570637.39.1727736066041;
        Mon, 30 Sep 2024 15:41:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 5/8] net: smsc911x: use devm for register_netdev
Date: Mon, 30 Sep 2024 15:40:53 -0700
Message-ID: <20240930224056.354349-6-rosenp@gmail.com>
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

No need to call in _remove.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 843e3606c2ea..4e0a277a5ee3 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2246,8 +2246,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 
 	SMSC_TRACE(pdata, ifdown, "Stopping driver");
 
-	unregister_netdev(dev);
-
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -2390,7 +2388,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_init_fail;
 	}
 
-	retval = register_netdev(dev);
+	retval = devm_register_netdev(&pdev->dev, dev);
 	if (retval) {
 		SMSC_WARN(pdata, probe, "Error %i registering device", retval);
 		goto out_init_fail;
-- 
2.46.2


