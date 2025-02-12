Return-Path: <netdev+bounces-165490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27908A3250F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF3D18887EA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655720A5C9;
	Wed, 12 Feb 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/1wsRpW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBF2080F4;
	Wed, 12 Feb 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360059; cv=none; b=uq+q90qFXhiB+QD9J2SYVDFrwJ2c6b+9J0s/rcZlIZ/U7uqE2eUPBbSm93IwC+6esv/k1OX6ygNEdEI46LSOckunE6C5/FFNfBRpV498928aNpnIj+659NXF64D4yJOu0mEhqlU6GwDzNDdiPEka4/H1cOOUFj7NhMbihG/3v4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360059; c=relaxed/simple;
	bh=jZjHZKZTK7fKc5GjpG+xIemr/MItrOAzPizGKwAJztE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oa4mqOVXsAuZ7RZMezOiATe9dkY+GNySIjaQcvSgySmo0SQIKyTLjN/E6Lf7JVe0va8a//BZ+9Rhc76LVccNsPMmxzJ7a7PwhD57iw4HON9sWS8z6G8H6S6es0xR6cZezw8TZiBSuYxId08DRvsSpldbcwXUHzrJGh9wCDV5xRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/1wsRpW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so233938f8f.1;
        Wed, 12 Feb 2025 03:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739360055; x=1739964855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxYXr4CIt9/N3PViI2FAcH2d8Gj6tYN9ZRZ0yRJgtpc=;
        b=Z/1wsRpW4smICWyOKngQm45Ete0OKDgtUZrCfPwMEVMaK53wnnI84gp9U3KzvMQCwW
         UtI4JlEu0XDJ13qHTR+rK7seXFRN7r3t50shVvOAv58CCqHVc2KetKmRPT3md7O6WZYd
         YfF3cRvWTzDBLWHeB72TNQ2V0oqii6bXBK2XUqiceRPayl0s1gxKJgAU4L8GfV2COmMQ
         IP3bXHGC3/Np+dOiIa96gX8HpiO9nFk4UklwbtlHKlJwJ9xg1Uc4fTP8YGKLOFgFobzi
         HQ9fmrC6fk8YlDuWZRRjYLXnBl+YFbcw64J1nx2y5FSJHgFTOoaq3AGHxYYX/418OA7C
         Z7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360055; x=1739964855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxYXr4CIt9/N3PViI2FAcH2d8Gj6tYN9ZRZ0yRJgtpc=;
        b=LQ0yoQoQZeZi92VYCDV5v9yuSpEMokVjH3ngKBTwtHOQTk+++2/7GUOxL7hvmJeVcE
         kkfFnoaHhurq7VRG0WXUCaLngESydr7SxTirqLQDSbm3K0SJfY5NEzMMMcgH/nJWCcYN
         gBywpIKvSQFlLIKMi+7I2Si9I8Pejg51Br+SM0mvxcxGWFxqwS0sCrrnOEUaDXUwoFkZ
         gXKa/YaZmmRVFWPLo2VAKw6rWzN04MhGTzbi6KFDmnNtFmCKlbhSocGQAuaWdgaIv7W0
         jmjyWefCByAS+4qb3NI2b5aiiqfPwn9cujhuCaM25oYyrbrv++ikDfEdibMSEtQ3AG/v
         F9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4B9n7cydOGGdwWaaZ21Vkps4kH+ClGEwZsO1E3xg4M131urcfSk2ouIXgNFbQ/RIxeTOJYu7tn0/92xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmt9EaIeSLnPXg2Kp9hwxOrp5qPU3golsQgSvPTrZCOMncflX
	ZPEkXNrgZ9W4e5NiKfU24tWTY5GTEdp8ZdQZqwadrPTsMJsM7H2+kOPoc1sSUl0=
X-Gm-Gg: ASbGncuz1rlVaDWI/pA+TXCJ+GLn31mD1wH3Hlpfxqgr1uoKrYNf6NkFgsFC8/KqDhr
	TXhv/vTYoMFQokw3b8zmA9kIPK7L2lSvrw1bJi2oyXAceplDETz83Aquwfk2hMLQfDjg/GQ17vV
	XBKidW1KGtZuKHKjBgTCT8b6o7thFV6GNAM/SkF0cJAjAlccIf8aJmeAZiwWNzLW+QNa8v0ciOs
	TEjbrW1hShFS9WERjwBWx8nmxazNI3bkGRjfEL7VcMKIpMkSzLWUkZ6Ayj8jF8GMrumrEJUU3G2
	AyjhZaokMJxiNuLboMiUSVHScxv/
X-Google-Smtp-Source: AGHT+IEP2BdLBmTBCC0FpgjDnmPfSyM/uqgfom5XHjxbqTv/prkrItuAVfjhja04p7hdHtH069NJ0Q==
X-Received: by 2002:a5d:6311:0:b0:38d:badf:9dec with SMTP id ffacd0b85a97d-38dea5f7077mr2329087f8f.38.1739360054420;
        Wed, 12 Feb 2025 03:34:14 -0800 (PST)
Received: from localhost.localdomain ([45.128.133.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd21fe18sm14124441f8f.91.2025.02.12.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:34:13 -0800 (PST)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	viro@zeniv.linux.org.uk,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Oscar Maes <oscmaes92@gmail.com>,
	syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Subject: [PATCH net] net: 802: enforce underlying device type for GARP and MRP
Date: Wed, 12 Feb 2025 12:32:18 +0100
Message-Id: <20250212113218.9859-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a VLAN device, we initialize GARP (garp_init_applicant)
and MRP (mrp_init_applicant) for the underlying device.

As part of the initialization process, we add the multicast address of
each applicant to the underlying device, by calling dev_mc_add.

__dev_mc_add uses dev->addr_len to determine the length of the new
multicast address.

This causes an out-of-bounds read if dev->addr_len is greater than 6,
since the multicast addresses provided by GARP and MRP are only 6 bytes
long.

This behaviour can be reproduced using the following commands:

ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
ip l set up dev gretest
ip link add link gretest name vlantest type vlan id 100

Then, the following command will display the address of garp_pdu_rcv:

ip maddr show | grep 01:80:c2:00:00:21

Fix this by enforcing the type and address length of
the underlying device during GARP and MRP initialization.

Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/802/garp.c | 5 +++++
 net/802/mrp.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/802/garp.c b/net/802/garp.c
index 27f0ab146..2f383ee73 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/llc.h>
 #include <linux/slab.h>
@@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
 
 	ASSERT_RTNL();
 
+	err = -EINVAL;
+	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
+		goto err1;
+
 	if (!rtnl_dereference(dev->garp_port)) {
 		err = garp_init_port(dev);
 		if (err < 0)
diff --git a/net/802/mrp.c b/net/802/mrp.c
index e0c96d0da..1efee0b39 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -859,6 +860,10 @@ int mrp_init_applicant(struct net_device *dev, struct mrp_application *appl)
 
 	ASSERT_RTNL();
 
+	err = -EINVAL;
+	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
+		goto err1;
+
 	if (!rtnl_dereference(dev->mrp_port)) {
 		err = mrp_init_port(dev);
 		if (err < 0)
-- 
2.39.5


