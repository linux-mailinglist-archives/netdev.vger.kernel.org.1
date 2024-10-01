Return-Path: <netdev+bounces-130984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060098C558
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE28F1F22203
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E81CCEF6;
	Tue,  1 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml+0mxA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4E1CCB58;
	Tue,  1 Oct 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807363; cv=none; b=hEP7uqfArg6LyIamjC7yE+YMIEwFGV9PrR8kiFDLk8uZdw6nzVuvFNqQgRhZauWN4SkczperaBt/t9N/NLetAFLL7WlWxWjPWC9K8lBddifP7f1Sj40+bebfEPmwwclHirNmH8BLmb+0bOEj7Z+ZTZgDrmEgRedECqN/d0MD+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807363; c=relaxed/simple;
	bh=iqj9a7iIpUjrYd15WVWnWZFhqqFG10G6AO3gHegYl1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9ZcptmaPcUrJSQbjA28PhdSQV49SgNGkJ90SlmbXFeZVNv0Wv2L4exOD3y3PIO+mHvRkFFNNJzqyAxlM3ydpkF8yIWYlFa+PrebbIL3KGiKlux/8Huci4INjasys9qSwhXUezrn37XeG6a2JU/3rNfVVLdwx7lyJ3PULEqKr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml+0mxA2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71788bfe60eso4361825b3a.1;
        Tue, 01 Oct 2024 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807362; x=1728412162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZaALxrETLenGQam95OTWhwOfcaIjjMmX+34RjWfT3c=;
        b=ml+0mxA2xXPemyiIzrJ1L/k7Saodw1BbNS8FNDwRJvqI6C1Qfyvm63K5RO0ZRQ4oem
         MSaxY5gr2oQxONyLhpH2kb8buMFeA1M8yDgGZp0Xd4aLEScVzdZjpgiHG5xBZww61rPw
         8cLTM/xVd3I3jhW5BJOrs1YqtXXbOoslauO0Q/h5kO25sOhSMPvkdKr+G1g0vV8gQe+5
         My69WF0inRVJnXcXeMMWQbk8OKTzBTnodoGzAG1MBU6biHfsswH6QmLw9B93QUh6toJV
         6pstvEG5NG/np7U0o2DlMeFCXOVpq1FdH3myWWSWxCNxIr4+DBDVnUfyPyG1gwgOn+oY
         D/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807362; x=1728412162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZaALxrETLenGQam95OTWhwOfcaIjjMmX+34RjWfT3c=;
        b=U8IHzlUSRHYoBMw56VeH2tnqNxnzb9XkHhgIK4hoFSIzg8OYfqzHEef/gKMr8Op9JT
         dez+pvQ9kVoTeBVXPpSXPW9pdx6/SqxuYTtlqVygJvaL55fRi9Hh4TB54nJDzWKeHPef
         UUMM3+1JRaeVbYD0j7ebaGk0OSlH+YixWV8t7GEAaYVAF4rkFmEUeQeSmtvySvstsIiN
         0VGsoV+L/jJ2RwgjlcfMRuicWWvwZiXV0VoYjxVPBlfDPcYbMHXq8DIthD5l+k+Kp+1N
         ByD91bbq6Ga1vd0J/FRQJ/J0B8oX1SvJQkJXEA/TCyY9KvOXkDgYzXXAlHOnjCXoc6oB
         2WXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaI7j8CscHYkZGUuSU3q8b3hBklwf3hrptF0RiLX1BhGNjJpY1tFR8XTRUk0XX45VVH0/UkIzjl9CeA2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbrow7a41s8tQciKNUx6EoHd12io8j/z3WRlv5lb9Tpns+yXgM
	sCCvAQOUMwrUoQ6zHxpGWD1bZerRwi1EzjKtmsKLks3XME1izOW1CAK6L9kn
X-Google-Smtp-Source: AGHT+IFbvefUJ3ZT2GV9XYzxcdx4Wvw92a/DClDY6dkxpfyHzBQWS68K7zEhFlN3Cauk6Nu60wIIzw==
X-Received: by 2002:aa7:8882:0:b0:706:700c:7864 with SMTP id d2e1a72fcca58-71dc5c43fe2mr839969b3a.4.1727807361684;
        Tue, 01 Oct 2024 11:29:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 2/9] net: smsc911x: use devm_alloc_etherdev
Date: Tue,  1 Oct 2024 11:29:09 -0700
Message-ID: <20241001182916.122259-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removal of various gotos and manual frees.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 3d4356df0070..3b3295b4e9e5 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2336,8 +2336,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 	(void)smsc911x_disable_resources(pdev);
 	smsc911x_free_resources(pdev);
 
-	free_netdev(dev);
-
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -2417,7 +2415,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_0;
 	}
 
-	dev = alloc_etherdev(sizeof(struct smsc911x_data));
+	dev = devm_alloc_etherdev(&pdev->dev, sizeof(struct smsc911x_data));
 	if (!dev)
 		return -ENOMEM;
 
@@ -2426,10 +2424,8 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	pdata = netdev_priv(dev);
 	dev->irq = irq;
 	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pdata->ioaddr)) {
-		retval = PTR_ERR(pdata->ioaddr);
-		goto out_ioremap_fail;
-	}
+	if (IS_ERR(pdata->ioaddr))
+		return PTR_ERR(pdata->ioaddr);
 
 	pdata->dev = dev;
 	pdata->msg_enable = ((1 << debug) - 1);
@@ -2438,7 +2434,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 	retval = smsc911x_request_resources(pdev);
 	if (retval)
-		goto out_ioremap_fail;
+		return retval;
 
 	retval = smsc911x_enable_resources(pdev);
 	if (retval)
@@ -2535,8 +2531,6 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	(void)smsc911x_disable_resources(pdev);
 out_enable_resources_fail:
 	smsc911x_free_resources(pdev);
-out_ioremap_fail:
-	free_netdev(dev);
 out_0:
 	return retval;
 }
-- 
2.46.2


