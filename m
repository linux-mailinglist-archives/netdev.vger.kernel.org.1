Return-Path: <netdev+bounces-248301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71287D06B17
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79BED304484D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958CF22068D;
	Fri,  9 Jan 2026 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki7V73Sg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF31A9B24
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920959; cv=none; b=m4t5rADMdtcQYatrhSpcyrbxcYEZ9I+wH14On/25dNtZAbRQFpwbA0A0/H/95YH4iI0sS0+aDCENHvR+5YpRmAvpxKSzZT9vSJCBbbuZ8kL+pXsr+SX2pQ4PPzCoX9yrQu3FRR+sUTLMEa5tE9fZI+960C9j6fwbfrGyHmudbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920959; c=relaxed/simple;
	bh=4LH3y50s6Eh8w3oKGvNRFEIM/w5OTQ0OgzhdhJLG8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeUpZ2WijcEGmLwk4T2v2U9evHPTiNtSG8zIS6tLcJ4VYopQH+ZQplDeS2bXfEX9K7GeU6L78/H4U3mZLRGWOJkER1+9FCrTMVhj/vcEEzs7PDqEMLGRzN8nja+UDB5mLgNh2a17x3MwS6M/uLaLP62TqDoG/xMeh++3KRgv4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki7V73Sg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43260a5a096so2589612f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920956; x=1768525756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGb/aUezmfqKEBlC82nLsbR3YNRul9qsX7CyKYfiPjY=;
        b=ki7V73SgjtK9wUJsbBeO/icbfUkbGDFkwc0TkHE+7ZG5CP7vcg0LmSibgPPXjOY65+
         nAuaBUUq/yBojeP6F9Xs/mzSJILOQEhSTM0N4OFGytwomqgHDsnofxGZpGwV1PeR3IgZ
         x8TN4JYN2+NfNh9HOhf438OfSY0gbxljQkGITW3SQiuWaKgPEhZPWeESp6KwLYqXVdWz
         /7eSapBwkc4SA06g73wpKZCZy7IHyjyiCbfygAVmEiRo0BkAp+yw0807Mc0FbjMBC9Pm
         /R89YvBTF+JUEMIHIkj8VrcXZIlkmRV5H3ZBD1eG965i9jYten7BcWRZWs2R3oOtdy+T
         JMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920956; x=1768525756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGb/aUezmfqKEBlC82nLsbR3YNRul9qsX7CyKYfiPjY=;
        b=WYduTmQL6nGKauEvR4n7jg5f8wxxro8FuAGmZq9IT+eNW65QlRZGEbMWy/OXTukWPa
         WLYo8dDo4Ia1KSP+6fndwMqiZelWSqDzw+ds7hSHByUXsY0kNHEzCdQbo3hEt11IGL7m
         G/eY7In0qV1UFWTM1mx0SlKiFca4jpbZ7WDfBg5tXfG2PYduk1PK3J8PpOZ3RZGEJdOB
         +2SW7bhg3sDrSwgbgxX58mR5cN8wjiJBcGwqn74Tlsx+DH+jaId6nodb9XGYZY0KEsqz
         t4QfuA4/g5xA+U2A6fYFc5Y7t/wQmzhtAbE1ZK3ICK4AM46BN60xUIkXhDb2FxkbWopq
         lTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWraAXoSG+vNx1E98NzDh8124YxeV7zTRKToeknXiAdlDFCyJLJJAbZdpRuJWf4sSnSrsCwBzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTpPj1CLsPQXgqqce1m/bL/U7WVA2vHHgffsohlT3+fK2m7ot
	Vlo84M3Cs3DRkYkfFx2ht95CWy/zNY5YwoI0pB1I8t7gZCJvk2+brZk6
X-Gm-Gg: AY/fxX5olOBcVOsDWnHxkbcB2BDLqBP8iOveGPLpkaLjVreQvvGWfyXGAnNjxmVySvn
	tjyjCb9QCXEIlbItyp64NwiUegBH4OCQgH6Fdknd5r6lw50jgiFEr4N6URLNkWu3smZ46NZIX8M
	7QuLqxE+do6BANReXZql5Jr8yIO7A1odUek5Ga/u0KC6ksYBqAzIwhs7AgHra6qjlT2lSD3AwEG
	NVkxoZkQtu1cUjMlLXhs9tP2dFejJpAR7pgPh3n5fpIR2fcyXpXV++5Vsxb5EafS9UO3L3eDf/R
	8KRl0MtZ0dKH9vNNPsAwRYECoZ1ZmAMnl2kHsI5mGJHj0PnSQteyb3NajQ+wXAalI/vca+Xs+dm
	vyboh27R/8P9Tz/cQmEMLGLv+fN7QLGotyg6+E0eclAWpBGgeFMs4bhjlW2DxX265keDXMhE3Gq
	Zqg6wzQtIIbA==
X-Google-Smtp-Source: AGHT+IE8bCGJMf5RrqYj6H9tYbkDwiAOViFVflCBC6wRBl9/WPadiUcybP1zgz5cpbV3K2A53CXQSw==
X-Received: by 2002:a05:6000:2681:b0:42f:bc61:d1bd with SMTP id ffacd0b85a97d-432c37d2edcmr9741962f8f.45.1767920955990;
        Thu, 08 Jan 2026 17:09:15 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:15 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v5 4/7] net: wwan: core: split port unregister and stop
Date: Fri,  9 Jan 2026 03:09:06 +0200
Message-ID: <20260109010909.4216-5-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
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
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes:
* RFCv1->RFCv2: break device_unregister() into device_del() and
  put_device() to use later uniformly.
* RFCv2->RFCv5: became 4/7 (was 3/6)
---
 drivers/net/wwan/wwan_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 4c6d315f4847..798b7ef0549e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -477,6 +477,18 @@ static int wwan_port_register_wwan(struct wwan_port *port)
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
@@ -537,18 +549,19 @@ void wwan_remove_port(struct wwan_port *port)
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
2.52.0


