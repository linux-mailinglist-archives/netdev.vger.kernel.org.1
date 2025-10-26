Return-Path: <netdev+bounces-233007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A07C0AE15
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3B23B4C72
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554F2877E7;
	Sun, 26 Oct 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxAXl5sQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987124E4A8
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497021; cv=none; b=jAi8sU7sM2yAYHuBud5fEhJ8W9es922OZRiHz/WKvjSPWTooLZG2ElSRdff5612ZOVs4oWK6CogOj+uqfZT7zuTL06II1e9bL+NFfexHQYdl3KxVaGs/l7+wymh8+Q5qIfNb4yuGB254FbjD2hfF1REm3BLC1aniV97oEbFxK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497021; c=relaxed/simple;
	bh=2blCvwW/JNfSePtiQhOpyFAVkiDR84ySlcLJfmQoOvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1h9I64IbMDr8k8b7hw9szJVoH0/XxSVZ8l298Hcz5oj1fZwOS+imNtkOWNjhYyjN/R5wWYwpZFCxb6lgJFe0DR8AVSkz//DLMbW0/xkK4uTwTRoND3K5FXMN5qmxVDGYVyPbRvbnWPq6WNeP2FTERQ4vvB5UejbTJHt/ngOI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxAXl5sQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so3799414a91.2
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761497018; x=1762101818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCF061NAS8FhFP3hNpS05moHDGkV+h3U/U3CN5+nY3Y=;
        b=DxAXl5sQtELRP1vcSZKU/GpY9atRPG/tlMzgWNQqc6HLf0hkZWybnzK7UbPByM98hn
         Za0+1LO4s9ryppsa1kUqDjYSOxw0yMVtUAQwNo80OkcPKVh6Xmz55KvA0704fhyd4edn
         dgqFKS4Dj1l/wHvZJqaeMPE054Yc+NqKGL5aefM5iba2iVEbzsUqvxcAthlx76k+ri7f
         uE1RdSVkJvk8Kq0zgLEnp/rjyBNQQvp7UMmqjYE+LOo6aoIgRpohGWilR9XYq81sy0QS
         F1WEzUBKhEVM5LCJqcrOD26IWhmOtvRU7/GGDzf28RQV2diUrJrX9ABeMt9rOYSPNL2E
         wkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761497018; x=1762101818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCF061NAS8FhFP3hNpS05moHDGkV+h3U/U3CN5+nY3Y=;
        b=N5gF3A5y4WpmMw4hcO9RELh/vNFBYS4yhhHabwE+ciyfnowceQcfYPHb+CUNcNld6r
         ZOxmQgbpwMZXfTIx5WqkQaPFrKUUWcllTMqORkLxP7SAbvfux6ZaBsU580DaePumiJJH
         FAJM7wAHjexWNRzGb0I854uGFfSCxkJlPsPgGSQFe3dK1eCuStVIhYib3q7NzqdZEMgc
         rySnIjd5y2QtVjCUeuksa1AqR1nXAAr9/JLR3dQnqCyog3dQAUhpDWVINsG/3d6kti1g
         U7qVO9B3Ow7bpt6n2v5+gU9hp4KkWF9wdZyU/0trDIOmISG36nj43VdgNZdbaeDE31l6
         +Kow==
X-Forwarded-Encrypted: i=1; AJvYcCW8L5YNbIhQ+k67ibZsCBdRjEUIUtuyaM6k2phtWPX1NBOUCMt+5ujcZnmeRxiKMunduQ8weXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiezCgZQHjjg9pbUGG6s2Hq9Sy6mJK67utCPn6nO6jqE1blkhQ
	qRm1s0mzMDPUybuPUfmVI1DMHVpK7yMjVYP+8FF9GtjrSlQbsj6RZ8rI
X-Gm-Gg: ASbGncu/2zaO28ggjNf6FUIpVSsBCTygs8ei2yfY/JjBn4ziNZ3OeuQGA/JH/sPUroe
	3TwKsSfd13eII1kngVBsN0vp+m7qxNTbK62aq6KQSsjPkYQF6kFsKIwJK7mfMgI+B2WfSVWDnL8
	my5Bywy74vG9fqFhEFac/YRzZ89GdS25rtlPy+DLtPlErCpGpQuwPDs8bwOLrOPdZ7Bo9DJ73kx
	HQKnYjTKBqowf0XRIGmL7UWyfQWy5cak21wWCr1OwRkkXuO9eLnjpUG/A8kXQfnu/9zt6xZKY7b
	qsDJW+83/FId5gLJygSOqeZV5rNXiQOvd7ZA6+jL7AJjcoT91eLjT1LNGhRu9p2VolaIB255oa0
	QQnJdoxciEiK5HyhFLCP0P6ceUfcM/nls/ADA0o2a03s7f+SQCzpw7NYigEVLvBglowR+ikvP/A
	N8VLOEvIG4Hactx20HE3QUzBjKziSIJzeFn4Rr8pyqJE8=
X-Google-Smtp-Source: AGHT+IFf+qjeyS6hjsC0nfYxfHIiI+ppqXHvuLXgsxBumfjvvdYcGEtHm3eqB+rkAU1cSh6c7pSxUA==
X-Received: by 2002:a17:903:2446:b0:290:6b30:fb3 with SMTP id d9443c01a7336-2948b97658bmr102681155ad.16.1761497017589;
        Sun, 26 Oct 2025 09:43:37 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2961731a91.0.2025.10.26.09.43.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 09:43:37 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Xu Yang <xu.yang_2@nxp.com>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Max Schulze <max.schulze@online.de>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	David Hollis <dhollis@davehollis.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <david-b@pacbell.net>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] net: usb: asix_devices: Check return value of usbnet_get_endpoints
Date: Mon, 27 Oct 2025 00:43:16 +0800
Message-Id: <20251026164318.57624-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code did not check the return value of usbnet_get_endpoints.
Add checks and return the error if it fails to transfer the error.

Found via static anlaysis and this is similar to
commit 07161b2416f7 ("sr9800: Add check for usbnet_get_endpoints").

Fixes: 933a27d39e0e ("USB: asix - Add AX88178 support and many other changes")
Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
- v1:http://lore.kernel.org/all/20250830103743.2118777-1-linmq006@gmail.com
changes in v2:
- fix the blank line.
- update message to clarify how this is detected
- add Cc: stable
---
 drivers/net/usb/asix_devices.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 85bd5d845409..232bbd79a4de 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
 	int i;
 	unsigned long gpio_bits = dev->driver_info->data;
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* Toggle the GPIOs in a manufacturer/model specific way */
 	for (i = 2; i >= 0; i--) {
@@ -848,7 +850,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Maybe the boot loader passed the MAC address via device tree */
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
@@ -1281,7 +1285,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
 	int ret;
 	u8 buf[ETH_ALEN] = {0};
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-- 
2.39.5 (Apple Git-154)


