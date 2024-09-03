Return-Path: <netdev+bounces-124702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC196A7A6
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ED81C23E8E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F091D9D95;
	Tue,  3 Sep 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvqBqjx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B551D9D64;
	Tue,  3 Sep 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392604; cv=none; b=GqmNB1nl5BLnZp7iyJImr9EsnRhauwH1Fmt1jI3z2yk+VdI8I3zsAXQk42v0hmjhU2zqiWfKOTuA/yE4zFHoMOCoZhWecn0DHieskyEzZdr2rhfTfU8reptdy43X1Qa9q935VTf9L/inz4+GHhcgl74+FGKISC/5atPynakBHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392604; c=relaxed/simple;
	bh=+A93/qmhNUSFsa8xsnIjJsQwYteNUx+cGXbIS5ZQyxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI+lkbUe+gT1dfSQZj1Txv7xXAPmOhIgYL1wZBRst+ChyL640iTH20uUvuRdTrZtXu4mi2Cra2mhGgwU2xGfPNB3v2gvKpWdma62I77Ah1qpK3jUV7bYJjcfCQKmUlMn2vy6ukebZ4q6wawXNyAkm9R06zjzfbUwKDBHZhImNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvqBqjx1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2057917c493so27055ad.0;
        Tue, 03 Sep 2024 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392602; x=1725997402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4baQNPCRjIgAE/zZ8RJzkEeZj4xVTveUnxI2HObIxY=;
        b=RvqBqjx1uzdiuWvc5I/XyNUn7Dn9JCNT5B7fHbchOMYwLB3GGiRcCdlAhM/RNrLAST
         ydI+1cGm+iSBwHh4IRDQfIZAL7gDoATfuIf/CJ1kGd996OYRYS4jmMjXDFkhYrD7T4+Z
         ahSwgNxfspcYPx1h3NZ20nowqV7VB1XtTuB2SJNH0tI6F4f/IYDiR+WUxP3IBo6VVSJk
         /UeKzkdgqiyj+d5HVYXW4O+X8DsleptBOmt4ic604xE84TLQy+vgVU4jg6k1qyM6F3sU
         DbmjzTPmNpHXXHMwDU60X15htgTltffveyiB8nTTpPVh+ZDQCH4kYhGnwfzlhKVBDFUE
         M74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392602; x=1725997402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4baQNPCRjIgAE/zZ8RJzkEeZj4xVTveUnxI2HObIxY=;
        b=C2E5ID5l+i5kEjCqGYA30Fan2qs19t4BRcUcLc0mIztf/NGOMtEsSGm2B6PLsEMBXE
         LxnHjT5myWp3VhFEKERQrd9GeSJP/Vbi2NF8IA82TfKaEh9qk9zGx5n4e84zf1KmELGb
         lkEWoTrDKHWuVGkiGAcldg2U/vzYrB5VnV8m/UvYN4wNZWIE/KzD7D/npdmjhYWopzma
         Cxf6rK3bkEY7xs+GJ2kGL0QDbPNM624SIIuaC2HVvBWp9yqUh7G3oueHktASRNhhvRWQ
         mWjE6RAVGGP7Jybg2Yr1NZGpow56XvuAgZGmq9Z6yU8iR2liN5b0d+pqvOGYpYn0oNyM
         zZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVmociRxsnnH1zxQk940gDZ5O0uHsdzV2je+b55HD2cEj52KM6djVsxWOkqr85a5MEhr831T591N8GT8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ASsVpa0U6MYU+H1XIOWk4qu9G/o7Yn6dV3103KO6Yhr8L18K
	11cXvMYcFhYatt65rORhA5uv7Vv951Q/N5xtyli2ygsRuF6LPORlsXFER6ER
X-Google-Smtp-Source: AGHT+IHvdrZ+xsRlRtnl3Loac/06AcShNTFQ2IUDQhXpfl2FmgUBTopBk2OPcKfBGfuWGcG2rNuT+g==
X-Received: by 2002:a17:902:ccc1:b0:205:76c1:3742 with SMTP id d9443c01a7336-20576c137a0mr159063195ad.3.1725392601663;
        Tue, 03 Sep 2024 12:43:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 5/8] net: ibm: emac: use devm for register_netdev
Date: Tue,  3 Sep 2024 12:42:41 -0700
Message-ID: <20240903194312.12718-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleans it up automatically. No need to handle manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 4cf8af9052bf..45984e420488 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3179,7 +3179,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	netif_carrier_off(ndev);
 
-	err = register_netdev(ndev);
+	err = devm_register_netdev(&ofdev->dev, ndev);
 	if (err) {
 		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
 		       np, err);
@@ -3245,8 +3245,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	DBG(dev, "remove" NL);
 
-	unregister_netdev(dev->ndev);
-
 	cancel_work_sync(&dev->reset_work);
 
 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
-- 
2.46.0


