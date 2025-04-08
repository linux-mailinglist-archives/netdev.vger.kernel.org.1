Return-Path: <netdev+bounces-180515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE20A81960
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D95F444263
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A7E2561D9;
	Tue,  8 Apr 2025 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So1cHblZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86986256C7A
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155088; cv=none; b=KKCK4vHRjpQkZwRB4BQS0KHcxssKyRHGwAEqjbQ3gA19lCENw0aKBJzEUzvHIwvy+E4+QhYTHJuX4MQQggb0UaQelGlD/pD3VmughtTsBoByVyXf9BKOEferlxa4lM6EV2f8PvKqGdB/38kyz+g7teaP5XS3hZi+6jY1d/Hz7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155088; c=relaxed/simple;
	bh=JyUlpVWGTepUIICsKwWPYiXibApeR5e+NDhtYRPQGW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItjrL9BijSoHBXB+EMewcrJpcQlVCZCbUOEno35kd60nd3bhsxpQEQ3WnBtoI3SUXuYBaoinH1EkDhS8ZeBdljGktPZo4PiYgoEfrzkxbwdgIcrLL7mPpMv0DdYmpHfNR5ZKshFTm4iIKXjfkIPOXXP3OnLMldIbXuF+bwOp4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So1cHblZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so55559205e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 16:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155085; x=1744759885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OisFLgh5vEU5DklT0qSuWyMPHuNzsGmCGO5Vq6L6MWU=;
        b=So1cHblZSxZEhBwIpAAaA2UbYbXg7xvrYRjEiQ3RNg0HF+wb42CIA8BmIKXZpF9FjT
         AxaLWUQ5JAAj48/MsHFrvctW8myPcsnzwF/B/mN4Uq14SR/d/2ifym+QxuE2Ey6NexFJ
         pubcRXKeAcThfcbC92ETbU3MHCVnh68w4EDFXX3cGN33stGM6uJFroeRbNphvuYdv8+g
         fqGLdSqUCFMKyFla7mMqQNkDBVTP6Caqnd9KA1QKNKfOuNvM9dQYirfns+8fMOrU3xJ5
         BAuhmT6M7n45T3bzbBSl8epXGEgoYBSn+wzo8WYQqN7TSniGN2eygw744BSGBwBUJpsy
         1kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155085; x=1744759885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OisFLgh5vEU5DklT0qSuWyMPHuNzsGmCGO5Vq6L6MWU=;
        b=dqXFDT1+JwH4raBa5/MzXE05MKPfY+dTqMc+NelUx+TEINh6HYr+zigg4ePTiHECGo
         AwLlqoC1xOwn/Tj+bImziugFVsVW9HwZPT+ZCqlZ5gZZ1e0ZA1Jmx13uD871rfoUpWJK
         EbmOB2QS9zFAp/VKyW8BX1Foazph/quE5fYZ4JqVSDPIgqsaC0Zws6nyk8WenceboWsF
         eKKkZRjVRkukpR6ERbuXoYjyTfggfHYFzih3/0yH8BlKlF+Keo4SyaWAtkGyMK2JcfsF
         laAyYTUEAEiAxFo40lKX9XZDsrH4pDyYYtpMVRIzoSqk5l9afmOTRMEgdqOhuo6MfYbb
         Brmg==
X-Forwarded-Encrypted: i=1; AJvYcCUTRGcKpCv4qnsLfgdMeSk40L8d154yccODC33jk1sevHVGqDi6awtBCgvgU5SE8OHlcpBl+5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89vFn+ziNQAzYzx/EDZza1W5J+nz5DfmDXyz6Wt7gOGyoAqCf
	9AKDMVTIFqD8F2zLAgffl5hFm5yDDg52EiI7QuEiBrNmZychl7f7
X-Gm-Gg: ASbGncuY+UIl/9Nav/nMGiVR9X3Wlgpe08FtwMVpQ1gAI1VVGaCG76aeLkM4TTWPtxs
	39y6eweZV9uRZoFfVJz/Bf3DoJ7843umA/lM9OSC35Cgaz2BeVJWL8J98LdwqtjOHaLWodkfM3G
	wlNnU18FEgIyFzTXhlL5/sbIb50Dj85cScqzTMaA+HdbbZjLEiKIzf6heXnIEDv9fenbe4AdvVz
	NMto3SY02V9pztZDmME7oWuR9mpzvv5K4yqzqBiIdUCADLdAfk4jSD3yXs9kzSH4yIb0c8FeGd1
	hgfLL2/zb3M3OxTSh7lkH914ELYvxOG8git/HoOfyHuUubp1oEiV65vhO77Xd7JxvZAEhQ==
X-Google-Smtp-Source: AGHT+IGkNr3o+H0JUe4kjJO7vD1t1UqoLNzYYAlCHg8UBxMtFumsUL63vKdi3EcE+Oz8JBFKZ+8CbQ==
X-Received: by 2002:a05:600c:19ca:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-43f1fe16c95mr2714125e9.11.1744155084653;
        Tue, 08 Apr 2025 16:31:24 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm9934565f8f.14.2025.04.08.16.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:31:24 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH 3/6] net: wwan: core: split port unregister and stop
Date: Wed,  9 Apr 2025 02:31:15 +0300
Message-ID: <20250408233118.21452-4-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upcoming GNSS (NMEA) port type support requires exporting it via the
GNSS subsystem. On another hand, we still need to do basic WWAN core
work: call the port stop operation, purge queues, release the parent
WWAN device, etc. To reuse as much code as possible, split the port
unregistering function into the deregistration of a regular WWAN port
device, and the common port tearing down code.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 045246d7cd50..439a57bc2b9c 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -486,6 +486,18 @@ static int wwan_port_register_wwan(struct wwan_port *port)
 	return 0;
 }
 
+/* Unregister regular WWAN port (e.g. AT, MBIM, etc) */
+static void wwan_port_unregister_wwan(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+
+	dev_set_drvdata(&port->dev, NULL);
+
+	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
+
+	device_unregister(&port->dev);
+}
+
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
 				   const struct wwan_port_ops *ops,
@@ -542,18 +554,17 @@ void wwan_remove_port(struct wwan_port *port)
 	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
 
 	mutex_lock(&port->ops_lock);
-	if (port->start_count)
+	if (port->start_count) {
 		port->ops->stop(port);
+		port->start_count = 0;
+	}
 	port->ops = NULL; /* Prevent any new port operations (e.g. from fops) */
 	mutex_unlock(&port->ops_lock);
 
 	wake_up_interruptible(&port->waitqueue);
-
 	skb_queue_purge(&port->rxq);
-	dev_set_drvdata(&port->dev, NULL);
 
-	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
-	device_unregister(&port->dev);
+	wwan_port_unregister_wwan(port);
 
 	/* Release related wwan device */
 	wwan_remove_dev(wwandev);
-- 
2.45.3


