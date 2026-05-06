Return-Path: <netdev+bounces-284819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK5tKVk4+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:47:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C14DA760
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BF23041875
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BE44D033;
	Wed,  6 May 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzuRiT4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A744CF5F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071419; cv=none; b=WnkTPyfJUXZFOsg1NI77+CEQAHOk19GN83ZglUMjwSPNZPcuolO8SOlquWRxsrfRUFYQvnrjAsQ+u9nRmBJZfXdZWmi1kCWNPVb4Kji67D1U2ML30TTKKOolC/kYZs2Bnpm7HwW2kL3VV3ImdcBjcHg3BvZj8KBQi5ewj1DWtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071419; c=relaxed/simple;
	bh=mGOYEqfn586cSv4mV7+ZkGjx2bX/Zy9gk3rZ2ZmOLzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c598FWZCSAwLUiMwhH28bA/6JzRQdqi3xhMnxHW4tf0xA0F90a00Usl/kh/BOi0E/z3y3hwHCZu/jKV/xajI0QSojWwxPlB5aoVTLXZJxp2DEEw3ie4LklsmeoWPWEspkhian8P7yN5LGHETGe37XHqxLigiPhhTINpY+Gpd0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzuRiT4O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba0714574fso19734545ad.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071418; x=1778676218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjgFoHcWtK3L/DYpi08j6irqA8vaezo7mFY7YSCvdu8=;
        b=pzuRiT4OWOqH/tHakt9I6dQEE8+DO+ZjYPdO5y5sL/Gd/00CncmnwXFJewKXFQnenR
         iRicSfEPIvDvkDEVxo7vOh4sYQGi8ml1NRran4ieRhC6cBImG7obK3RIPc0t0kBI7pMu
         eC/g669SHYoGKMtUmmgVh6y16MEKN/hMAtI0Be44ahheEPo3Xqfr2QRUS86cxHuPKKK8
         8CRoZmecq3AQb/Km/y5o9unKiOFau+KKnU9oQU+Bo/SvoMJYUnA36xUnicFIzSBHa0EG
         niBwc+Zx7WA23Fw7Lt7qmjt8X6iKOiJSoAaSVfeF7jkNvmU4BC0ZmU/lkuZMclcXpxM3
         vFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071418; x=1778676218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjgFoHcWtK3L/DYpi08j6irqA8vaezo7mFY7YSCvdu8=;
        b=AVDpzMVL5nBO5O1FSU/dRVvwS/87jZtNEgI141aXVVfCYinlvTkQ7QpSLsLsWHP69+
         sWg662LAoGxpd3F5sm6wVNURRFte/iHNp8b2w9l/wkvwGwVtLiNDaQM3kIUW/ScpgB6n
         loPbNLrhHT6YeSbkOmDSK2nriJ+ZzVO8LKKwdW5iF24EftRosnykwBDJOeNaOfGoNEgk
         fxT8KtoFGJOSeDaGZ+qxoT3puU2BBVTfvuePIBDcsc3TBvnkGOJFI1i5+b1ooSJ0QOp0
         XTtc8NzAm8LqcsFdXFYRF9kVnc9T8sszT99TLk2ErJfQKkULUbpfeA4kF1nb6D9YT7/G
         7w1w==
X-Forwarded-Encrypted: i=1; AFNElJ+pvdoXIdTVZBaV3wtWej7u6r0I2jJZAMeVIz4akr6RGI20yphu5y7HImF1JhVyes0ayTKFr88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Euh2bERI6Lab7OU2hOgMLcBFUWdqWjxjrsr0X9zubeU/LzHd
	zorX/La6yzU5IaLpHttFQAdIRnK3AjbWEYwYLjTCNE6o2jIPwbv6BrU=
X-Gm-Gg: AeBDiev519BkOkW7vuoQ4AQxmGM4rbWE1r0esTg1WaHyO0DMq2G+4zkc5A2xGbdl2Xa
	5MnFatHaSBBuQy0zoMH3WgE7aNNB9B7VUHIFqlpRwKt3jPyLmwSgTg+aH715L0JEZbDoSrSGobs
	8Dbrxhl4m05B7ZYuK8/Vb8FgbS+B3rQRdWup7dRwD1iAtMDzFv249JfeICgDBuC5qanTPMf+q3I
	61V3YjKZqHENpV4z0UbKEHuR9q7hsvWR8obnE03aKjOyRrxq35G3PYWlmJ0tz5Uvk269oWTh6HX
	57LzL8iAfPJwwc1evRFPQXceYS8ZI3/Qvst1mXpGTxnYZNlaGvoOYFr1k8eW1NFMZ7JU5j5CGFk
	oa0dKDq2nwz8vjbxwU7CW/7cSOp+Edwm+mcBPXriYYo7OpOq6bMjIwBfKNaizhME5jF1tRNlq8v
	ia3o6KcybfPr8yxI1EXXFdwTJeWxlNJeV+FLBVWjieEVN00mAbG/W0HL/t+Hom0pPkxD/JOG9Ys
	QYd3bUN3Q==
X-Received: by 2002:a17:903:90e:b0:2b0:b016:773f with SMTP id d9443c01a7336-2ba7908443cmr33626045ad.11.1778071418029;
        Wed, 06 May 2026 05:43:38 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e16f2sm25584615ad.45.2026.05.06.05.43.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 May 2026 05:43:37 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: lan966x: avoid unregistering netdev on register failure
Date: Wed,  6 May 2026 21:43:11 +0900
Message-ID: <20260506124331.31945-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3A6C14DA760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284819-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

lan966x_probe_port() stores the newly allocated net_device in the
port before calling register_netdev(). If register_netdev() fails,
the probe error path calls lan966x_cleanup_ports(), which sees
port->dev and calls unregister_netdev() for a device that was never
registered.

Destroy the phylink instance created for this port and clear port->dev
before returning the registration error. The common cleanup path now skips
ports without port->dev before reaching the registered netdev cleanup, so
it only handles ports that reached the registered-netdev lifetime.

This also avoids treating an uninitialized FDMA netdev and the failed port
as a NULL == NULL match in the common cleanup path.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Make lan966x_cleanup_ports() skip ports without port->dev, so the
  common cleanup path does not run registered-netdev, XDP, FDMA, or
  phylink cleanup for a port whose netdev registration failed.
- Keep the register_netdev() failure path responsible for destroying the
  newly created phylink and clearing port->dev before returning.

Changes in v2:
- Require port->dev to be non-NULL before calling the FDMA netdev cleanup
  path, avoiding a NULL == NULL match when register_netdev() fails before
  FDMA NAPI has been initialized.

 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 47752d3fde..1179a6e127 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -749,11 +749,10 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 
 	for (p = 0; p < lan966x->num_phys_ports; p++) {
 		port = lan966x->ports[p];
-		if (!port)
+		if (!port || !port->dev)
 			continue;
 
-		if (port->dev)
-			unregister_netdev(port->dev);
+		unregister_netdev(port->dev);
 
 		lan966x_xdp_port_deinit(port);
 		if (lan966x->fdma && lan966x->fdma_ndev == port->dev)
@@ -873,6 +872,9 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	err = register_netdev(dev);
 	if (err) {
 		dev_err(lan966x->dev, "register_netdev failed\n");
+		phylink_destroy(phylink);
+		port->phylink = NULL;
+		port->dev = NULL;
 		return err;
 	}
 

