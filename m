Return-Path: <netdev+bounces-176090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB298A68B8F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD51188D3C3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231EF2571DC;
	Wed, 19 Mar 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Gsi4bg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D22571B3;
	Wed, 19 Mar 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383363; cv=none; b=qbRAQ2M3pE5WUIFifCmXXBInUuhbMabC7mRDF72q17v6wfqoVA/tj7CYXS4UpI0TWZFFe5GyuF20yIuiWKrcEKM9G+4GslybK+SdoUfWVE9qBKsPJMT05CEvaHXVwOfNitbuYEV2VwDowqvZMeFrqFREEPIgtmbfZdAHQYM5vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383363; c=relaxed/simple;
	bh=OircmpDGdmxw5CMXq7XknY6CRaTkq0shBEgdN8YmMxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieo3NoTkVrXhjIcKs6XfPS0ylqMYLSo43xEEUKwTU5tyo/hmuaj8oQUD/jtfQxtFDzSzJX1EhSwDUTuI6QspUt8TIaPdnu6ZklJErkl6UOFQPZq+ulkJ8qTr/zuOqFvGinqGXe/sYh/wOyz0rEp8cCUxB4os8lTfwmFiTIzdy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Gsi4bg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso20569375e9.3;
        Wed, 19 Mar 2025 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383358; x=1742988158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUwxD5jrSlU2QA0dVdywVoLJpdQCeU5/vf36fdL18Xw=;
        b=A9Gsi4bgrkQehvGZi/13TlqTbRmSJf5BbdQfwXxTv+1M2os1XSBJFAe9OLDu4u4thi
         gzs4yUqZAp0Z5LlMKxbcuK4wkOeTiecl+Ake6bisF4yJMXVxBndh4rLHwynvgso8gQjJ
         F0ZVSjOiZIMPZe696VLxZMoxZ6Z744HSofo7/NJ7etC6wX+ba64Cv7LfqwfYHOROx8F8
         fxU31AgkBJxvOcL0wLimG/SJDMwd/3A33wNv0Nsu8sAuCvoycUBdduO9Y8Lx8L7W5pLT
         obybLNy9XWjgPKxeqs8lPfcSTDgc0jzypJFOCSAsyzNjOz+a1qOBXe6Cr5oXBydKetUb
         v2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383358; x=1742988158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUwxD5jrSlU2QA0dVdywVoLJpdQCeU5/vf36fdL18Xw=;
        b=Lin2nkqPdiCgP1enZEXstuLzlOd6H4uf9LAfRE6WTjPBLqHmL2WO4sqfMYJpgC7Tdt
         vRn76E5HdlCsxzKGWfZ4VPfdO18qJa3Ip+/jk4vzG+gH/Q3s44633V8AerRnsT52P9qi
         N1CYr8DQf/XWexopM7+41ftWKwWTql5swDSEI+ieM3UiwdtNRqdL3sCpN4VpaHdKajra
         B9QOGyTA54TMXXFZXSAuWrotJ3ipV1YwJaDFCkh3/gVFr04YUcgtO+5GHWY+s6mPHp76
         Kes/YwvPcrh7NMZaRZKZb4v/Ghmz3cml85oxJJXv/wBGtSF3ZqlUvrTQuUKztheb/9Qi
         FihQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7sbv1crRTpJ/cdsYOZxzX4j5nJ2VKOa50mMmXFcinPe5c3cK6TKxVlqcogN2EXR/sDq1klf4sTKekhME=@vger.kernel.org, AJvYcCUxujZHItBza9+H6uBSsk6m3z3gWQuGdD8nuGINtfq5kpKMleSpdxNLeWSUhRBxHpzizB6EUCMd@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEMJ2SX1yBqeWNy6R0TojQbMmhexanOijmcLEElr8ePgcM4Wf
	JAQEoisbsj3NSSdqF2XWkPb/zf47sUr/p5HpNBlXxXsmUskY8Vdj
X-Gm-Gg: ASbGncvx0JN42fj1U2OjZdhPiFoXIpirbTXPva7TWRDyBWVrg+HfPlAKQl8rbq0EPMg
	DIQbdusYJmQTWEGF4JJhHd7cNttQApZGRi0hU1+8SJwATtsilqPuiJKDco0G6HJ2A2EJf79c+1u
	G2cFAUHi42pNEd3+cYikIcc0xqzBF45ZebaGLaZwfr8wkBt+Eqs32s3/HYD79oSxsXqc6D7nWfc
	wPKaEwTykLEpKDDex4xhfO5/Bt8GgZRHWVS9LoFELfsUBOStfLOsS7PQpNxEE1HL9fvzs0VdFLZ
	bau1CkorZxMUGuBXiXoUwsH/yehYJYJRlgtemJTnjUTj
X-Google-Smtp-Source: AGHT+IHrxnA3liebLtQhqb06QfOjuFh2roeWDQ4FiS24+gpcLm0r2HfgE+C5btgQDzNHwYSVdvuRhQ==
X-Received: by 2002:a05:600c:3b2a:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-43d4389a281mr17512725e9.30.1742383358163;
        Wed, 19 Mar 2025 04:22:38 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f331dasm16129995e9.8.2025.03.19.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:22:37 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 4/4] net: ch9200: add error handling in ch9200_bind()
Date: Wed, 19 Mar 2025 11:21:56 +0000
Message-Id: <20250319112156.48312-5-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319112156.48312-1-qasdev00@gmail.com>
References: <20250319112156.48312-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ch9200_bind() function has no error handling for any
control_write() calls.

Fix this by checking if any control_write() call fails and 
propagate the error to the caller.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index a910aea0febe..01ed37e9f725 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -338,12 +338,12 @@ static int get_mac_address(struct usbnet *dev, unsigned char *data)
 
 static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	int retval = 0;
+	int retval;
 	unsigned char data[2];
 	u8 addr[ETH_ALEN];
 
 	retval = usbnet_get_endpoints(dev, intf);
-	if (retval)
+	if (retval < 0)
 		return retval;
 
 	dev->mii.dev = dev->net;
@@ -361,32 +361,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	data[1] = 0x0F;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0xA0;
 	data[1] = 0x90;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x30;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_PAUSE, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x17;
 	data[1] = 0xD8;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FLOW_CONTROL,
 			       data, 0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	/* Undocumented register */
 	data[0] = 0x01;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, 254, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x5F;
 	data[1] = 0x0D;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	retval = get_mac_address(dev, addr);
 	if (retval < 0)
@@ -394,7 +406,7 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	eth_hw_addr_set(dev->net, addr);
 
-	return retval;
+	return 0;
 }
 
 static const struct driver_info ch9200_info = {
-- 
2.39.5


