Return-Path: <netdev+bounces-200854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90594AE71AA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4706189FBD9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460525B678;
	Tue, 24 Jun 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC1g8+V6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07C25A34B
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801148; cv=none; b=ql2DVbHO3eMF0Q9dg3LnKiOwaPoKm+s5JqLW2m2IxQsvSaV2r1dMFOdjhhcydE7p9I6vdeyY2rC4r86ZslyvfAoXXfvfiVp3LrGgg6z/FEIhjr9iH8cof6nipKTfJgH4BH0ZPJsGTPGugE3o5o7zZ7tU7sCUTiYQfyID5sCUJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801148; c=relaxed/simple;
	bh=l5gJvZPbLtpgOH5RkKKdAD51Wlz3lsNhl7xOCDWXLog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGt2/VBxSBIcUssOJ2uV+RQh2xPhb4uJ99cmjlQ2Jx83oUzIrUXhggRMvx9eDR6pnXHGy74dsokg6A5k6iwi6uJVBgJ5FdwVZ+aecV4HNQzgHXhUSx7okCRWTWec52giVWm0Mv6FyOvwSIBl7P6OtbJ8QcfG176r1CkUXPffMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC1g8+V6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453643020bdso8325555e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801145; x=1751405945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7f1LKiOM3qg/8XlCiqEumsbKFHXlisNAxRGIeVDT6Y=;
        b=dC1g8+V6/BqgIFH0s9GPJR43+wAo77+SA6ROiUTF4tfYe7UKfNkSsQ6WN07+CwyaKu
         b0J20Or40l+HNlOsQZLnvSZPSTzUehiZJgTs+B+GdMy+U2Z8vonHD9ZXkmPmWa91/POQ
         9S1cS7md0yYKukb0VXgw2nB4j4SvNIhkjxl/ECb9NYHBNDVjWpfG6hx5nF4J6oeK1O4/
         ENlpEBqiD17OnxKA8G+KY5NR/MKg+QyzcgqPPWA+IAlrf0K4pn+pE3exwhyauMd7P+iG
         cS/SR/lT6ghKnjgDbiW9o2f02tAoPXg+jXJwXGjussC24TTOodA/AxcUP0jYJdCVGvkI
         TdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801145; x=1751405945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7f1LKiOM3qg/8XlCiqEumsbKFHXlisNAxRGIeVDT6Y=;
        b=EpDLOWdginqz8CPQMuZQorV9pLrwmdTX0YHQw7gaGD5Y6lHAP5Fs1BV3I8vhp26pUv
         DLqCe3qVfMLLQxijQ5fZiY+am046eD7d2yFVS53Oj39RVc4ZKWslKJS5mHYlED7MnNc1
         ZMwMVdSt/v3Ir5g9C/0b2Wigd/0jsNx0zi7K+CwcJ9B2jFvHhfYOcHjoZ27j4A1FNUwb
         NJsq2zQ2TUI7aKJzx07njUkaVEAxW9WUTG3DcicnMWIPvF7J06k1zgd24C01+HZNWGdX
         DCeZTONbgG9RNRXzj7Cy0LK8B27JXLsP4BSc9WMgfbbxOMeUjg2bh8ukw/BEBx3YUyww
         QHlg==
X-Forwarded-Encrypted: i=1; AJvYcCV4yVA5Fguyv4k873WnZDtRZbgQLw4fBZIZPpwg1KYBy10S+lmRyEuQPY4H745Mx26o5qQzq4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDhabGb8Wd4nDw0hXQ24mJ+JNq9tnALehEFyrw2tRByo40VGO
	Hmx3WPKwOv/aya3UluHFZlkvGSlhAq6Ks1Wjfr7s8czhmVU+JCf6CCLY
X-Gm-Gg: ASbGncsS1fCp60GqZMOK9BDaHLCGFKAeAMYfx0IxZVC8m2WcEMA6CEeo5i30SdzhWB3
	+CKDmcgI/Rr1cjNY4iTlskzkaF2mShLgN37r02nFS5M7PLgckq/6KSF0rR5yexgyIU4o4iJ+Xhf
	S3MnSjORuuyv23ZV/kok/qQylryy4m9bPrwnxwhH0mTiRNS2BYVdtru8zRd6lzX8jfhFwT9jgF+
	59kQK96aO/Ny+wM6dcIvvZwl6MiVmOMV5RqlCoVrCzYEFkV2tyVm/lBb/obJCdT6jh1GAAJM+lu
	0wxxVrOZm/d3JctxNbYIa+KYnspLzmHedylgZ7kU7avwSzMr9mqZhGqhbyFM1cCS4vcKorL+Trx
	C
X-Google-Smtp-Source: AGHT+IGXEGYWNzJzJ2L+7Eg+tVGGG+rnxpDkK1SFzMuANC32jSvxsughmQU/DlRILdWTREPWZ4MEoQ==
X-Received: by 2002:a05:600c:34d5:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-45381aa4c03mr4740385e9.5.1750801144540;
        Tue, 24 Jun 2025 14:39:04 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:39:04 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 3/6] net: wwan: core: split port unregister and stop
Date: Wed, 25 Jun 2025 00:37:58 +0300
Message-ID: <20250624213801.31702-4-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
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

In order to keep more code generic, break the device_unregister() call
into device_del() and put_device(), which release the port memory
uniformly.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
Changes:
 RFCv1->RFCv2: break device_unregister() into device_del() and
 put_device() to use later uniformly.
---
 drivers/net/wwan/wwan_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index edee5ff48f28..c735b9830e6e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -476,6 +476,18 @@ static int wwan_port_register_wwan(struct wwan_port *port)
 	return 0;
 }
 
+/* Unregister a regular WWAN port (e.g. AT, MBIM, etc) */
+static void wwan_port_unregister_wwan(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+
+	dev_set_drvdata(&port->dev, NULL);
+
+	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
+
+	device_del(&port->dev);
+}
+
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
 				   const struct wwan_port_ops *ops,
@@ -536,18 +548,19 @@ void wwan_remove_port(struct wwan_port *port)
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
+
+	put_device(&port->dev);
 
 	/* Release related wwan device */
 	wwan_remove_dev(wwandev);
-- 
2.49.0


