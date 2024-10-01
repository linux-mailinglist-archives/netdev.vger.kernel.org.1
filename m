Return-Path: <netdev+bounces-130995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085C498C594
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0DE284EE8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC471CDFBC;
	Tue,  1 Oct 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnribtqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797B1CCEF6;
	Tue,  1 Oct 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808375; cv=none; b=dCxvLUH2HBTqxk0p867sMwcx2qEUwN9EGlj5x97apU7d3Vt8+XV0uIbBKRasynqT2kUxflgQK/b1sIboxoLY3k5cJTyM0nfzzr8SEUOrOjVbrdixQpl8FAPsFy/F6yKMsx5BBy4aWQ5X5fWye3c8fEQzbDqOXrrNhTL6exqX2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808375; c=relaxed/simple;
	bh=xPkDsZx43SOseO+qGnRGkEPm8IkNs6rkJVu/adMp1pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0rQtDpBkTdVcGLn1oXVHXY1ePzG860UFhUhk2FTWfqD8n/9IlVT3aDdRRsF+H9ChXdr8RPbNiYDehni7oLfTo2lHtHo7ftHwT3VdApnC6k9Gf2wUn5l+hH+Yh7ysVvjUBYuKymA+C7RJ9xAyv600sA8WyPtXFAgMZkuvygRCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnribtqk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bc2970df5so4127955ad.3;
        Tue, 01 Oct 2024 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808373; x=1728413173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T8zhMK7/QXeXyb1KNjPbwVsH0PK485frWAFai936ew=;
        b=CnribtqkH/bkGEujD0qswUuin+PZSBf/a1ZhW3T/+HO2kfbtkt7yJpUvknbS4iHE+u
         yFlyddLc3Ua7G2KpfVhTnExt9RmIr2dTdJUS5lPzRZ1pqqyszYBrBBPYMHwFtypSsYYP
         saATGuULMY8NHgwuHsClVU9D2EsxAuBq8Z8EJUGhCFOdmOp3P3PcYjd6z/udOoLUSrl3
         7zIsIyFi0CFP7jHvMWpTJb3kvSJBM4EBAJDiMao+wkwTKKvAnuiQkHeus9gQMBTRsPSL
         qu8eIgWmffcmR1nkUhipj/EvG55QN01QuDnUsmJ5SPT1hSK1hZBTRbak9mQsFem+R3kl
         Yv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808373; x=1728413173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T8zhMK7/QXeXyb1KNjPbwVsH0PK485frWAFai936ew=;
        b=JVEEjlJyEK8qTcQZJL0GjONd5171XkpYDGDqOI+KWN8nDj8JAMNLWetGpZJzyE6Sb6
         hPE6hKj2n4GbbFBczTyAsvQax6NthDNrDnKRQTHL6keDZ4Q+3qOcLLT4OqSMEHxJyJBK
         03PGYe9JYxHzXntb2rskwXTA/D5u86v62VdQnn2zFYE+ZGEcK4VpfnuzoHTc9k74aZAh
         1xmUE6hf3KsAFen0Q2o5SZZEi2M7kN/TUFA3aqzZB+G62if/7yFN8/Zpjk0Z3hOauvaQ
         6X+CLVWisSmkJdi3fEYr+WzkekPREsJBT/8tkiEeAHXxEd/RVRtHgWu/fvbowKAObQts
         8Qww==
X-Forwarded-Encrypted: i=1; AJvYcCWgf/c7lpSqY2+zI7BZXNcsQDHyMW97Sy2kfPr9TSfwP2Ia1pf+l34jaQnVUOtAGkBkcgFUJ92mVOiWkfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DKRj34itJGFwhSfI0CPsplfJIolmRu1MKUMWET+QS0+NNdUK
	RMUVJw+hlMT7VrrB4SI5Esh7CWgOudX7HEzvmlVPs1XoREOLISNZ2cTqfTeb
X-Google-Smtp-Source: AGHT+IFM9x9loC5Fj/CvSYm9pFjjbJTgU96yAV4x2ekZnol57QZNNk6dlPuQ+jPkxllXYjltw46CaQ==
X-Received: by 2002:a17:903:41cc:b0:20b:532d:bb17 with SMTP id d9443c01a7336-20bc5a6b3acmr6716735ad.54.1727808373234;
        Tue, 01 Oct 2024 11:46:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:12 -0700 (PDT)
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
Subject: [PATCHv2 net-next 03/10] net: lantiq_etop: use devm for register_netdev
Date: Tue,  1 Oct 2024 11:46:00 -0700
Message-ID: <20241001184607.193461-4-rosenp@gmail.com>
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

This is the last to be created and so must be the first to be freed.
Simpler to avoid by using devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index de4f75ce8d9d..988f204fd89c 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -587,7 +587,7 @@ ltq_etop_init(struct net_device *dev)
 
 	err = ltq_etop_set_mac_address(dev, &mac);
 	if (err)
-		goto err_netdev;
+		goto err_hw;
 
 	/* Set addr_assign_type here, ltq_etop_set_mac_address would reset it. */
 	if (random_mac)
@@ -596,11 +596,9 @@ ltq_etop_init(struct net_device *dev)
 	ltq_etop_set_multicast_list(dev);
 	err = ltq_etop_mdio_init(dev);
 	if (err)
-		goto err_netdev;
+		goto err_hw;
 	return 0;
 
-err_netdev:
-	unregister_netdev(dev);
 err_hw:
 	ltq_etop_hw_exit(dev);
 	return err;
@@ -709,7 +707,7 @@ ltq_etop_probe(struct platform_device *pdev)
 		priv->ch[i].netdev = dev;
 	}
 
-	err = register_netdev(dev);
+	err = devm_register_netdev(&pdev->dev, dev);
 	if (err)
 		goto err_out;
 
@@ -728,7 +726,6 @@ static void ltq_etop_remove(struct platform_device *pdev)
 		netif_tx_stop_all_queues(dev);
 		ltq_etop_hw_exit(dev);
 		ltq_etop_mdio_cleanup(dev);
-		unregister_netdev(dev);
 	}
 }
 
-- 
2.46.2


