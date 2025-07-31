Return-Path: <netdev+bounces-211177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B3B1704B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E97F3BE7C3
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39F2C08A0;
	Thu, 31 Jul 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdYoZ1A/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E92248AC;
	Thu, 31 Jul 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960948; cv=none; b=Ftm9gmhCl81sGUucJemkdYUPiiLC3ZSBg1hhx0Z0Saen864hudbX1Pbh56dtRGFOf8Gk+qcOZ60B8XpzREIRSeZ9Si5vnvSqY/zqzHeZtm/WKe5EzIpO6piVOQqAVFyrm97G7Is7hmIiXbMAJyU29h//nrGyAbwTTWNPbp+b6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960948; c=relaxed/simple;
	bh=WvRtQA9ZxxxbZQRyydbsPd8vCk/ZKz3GnBrOXB+2pn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRkLwZbOEGA8vn/Iq6jCMu0OIW9VAR2BDPT7wtN2jWHrYczrGc2V/Uv/w9Fs5qykzHc0Cf0bi4TVqZjeF+teEFuNKlJ2fP9yrN46hOVOx0dpKSj2h4tkOBxc6ycy/+B3enrqH76+7lLXmnlHIH8VrIdw0UTnCYXmc3JbkLk8eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdYoZ1A/; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso392226a12.3;
        Thu, 31 Jul 2025 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753960946; x=1754565746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qx7n4CRHDkkYFnz021yXqLqPPJ6FUayo+PssJIK5SZQ=;
        b=OdYoZ1A/TQOoLWk0iLzseJWpJh06BaQNoiqNUJDnkG4YsxfEqToaaGelNRyu4BpVPy
         GXjGPksoNBwJGZqEQ5vnf4jK8pzOCkK4jSPd8fwDH4qiYQl9Q7alR0qQAQacGWITgE9T
         BEFKxveRtLognBNW+HP3YDMOStJhHxVVLMHESrYOywBnsudPM8Ps2HIZ/kDLT+oh9bzk
         SXs/Inao7IABsNACiGuryVjOuG073P7HlnHOpxrgubWFBCCH6JN+bpaI8LwcD0f3ebu8
         MrHs7xkvhYIyzqNVJPVT/9SOLNGIryEj3TQdgzql9AndMxhKlBNSPxiB4miSCgOm7KHg
         ub0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753960946; x=1754565746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qx7n4CRHDkkYFnz021yXqLqPPJ6FUayo+PssJIK5SZQ=;
        b=FcYliAHQjPmpPT745lRrYsKE83XqER8w0TEKtccLYlInlqnftBm/xJFEM0lV0OEp99
         tEgRyMHAMh2Z7Tv47GWnxkIqdbXBHIuxgqClApvTjVL3KtCdLPm86rdnijbmlE95+Awc
         y8c4IHDHSknY1HEt5xxTF/U0JhalwDEMfW3OWkUXHcQkQvdoczs+mXXChiW5V7MjOtxE
         SxMQKP3FJ4I6MjY5groQpd94ijFeLbmBpSNAqGvo8VmSM04FnwNZpjzdMO0RT1FbBZSV
         ZMwFFCgcA6UjQ+kKSiQOLD9wQ/i04EtbGKATBjmdHVHzO3qJEQ60Q7SYb5YPQhDI8NWW
         e6JA==
X-Forwarded-Encrypted: i=1; AJvYcCU5PV+4EqwRKYbNTlgDP2CBNj0RFxUXAxsdAE/uKjKDSWZPGtwybQ0e4QuymeliG68O2oQbFMqw@vger.kernel.org, AJvYcCVSugap1epqnz/P0wuLagUVRPINAsWZP4gHOnLw2JsVlXq1FDJOlFeYMNlIoAGWGzTq7ySk1AS0gmSXXpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6gbnKePeYE6K669PPohrW4CRXT9c/2rBLkaQ/NJcKQrNjqRe
	wQaDSoAF94EDfEHMyHvQQj7JO2uFClwucFANWg3ppM4XvNIXKIpRS4/0Iu6rM4YaDko=
X-Gm-Gg: ASbGncsdh3ntJnYoBLoraBeOz+RbFvkj406uizf3OHouLxXIyvCa2u7tA1nnCngpC2D
	2QloEAh5Loj2zQwcpGQkNpVrrIagSw+0/6oXLJ3qsQXY/ed4Bq5/QJNH5LO4Nm5bDRvudSG7XbG
	tIHkkWmWREUgAOOG3flbwpPmGH3zyUUdMq4Y1Ev2r98CdUxPzDE161UoDuQLhRmBA8gFqUYmAty
	c/f5m0MIcpQ94xdyufo0tiypHEdUdpxUgZhbSgYMxiN5U63/SHuVrqyPN7so3n01glD9ldG5/Sa
	9lISlTVuKBY73KYQum4jjxPAk0kem4IV7InF2JB7PpBKh9QsuAFXBCSWUKKyuZt31ZwJoPTnm0j
	c0+RnzLtdSJxk4iGZwTFmiKaaoV7U4A==
X-Google-Smtp-Source: AGHT+IFp2FFhWBzPgj/8hThSVgk5ganKeeRgJZ7pPj9KrQVGx+T1Zex7R8wNhKbWHfELviIrxmNYTQ==
X-Received: by 2002:a17:90b:3951:b0:313:1769:eb49 with SMTP id 98e67ed59e1d1-31f5de2f470mr11218009a91.8.1753960945847;
        Thu, 31 Jul 2025 04:22:25 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3208c170d2esm1746723a91.32.2025.07.31.04.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:22:25 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: dsahern@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: vrf: don't down netif when add slave
Date: Thu, 31 Jul 2025 19:22:19 +0800
Message-ID: <20250731112219.121778-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, cycle_netdev() will be called to flush the neighbor cache when
add slave by downing and upping the slave netdev. When the slave has
vlan devices, the data transmission can interrupted.

Optimize it by notifying the NETDEV_CHANGEADDR instead, which will also
flush the neighbor cache. It's a little ugly, and maybe we can introduce
a new event to do such flush :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vrf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3ccd649913b5..d90bdf1fe747 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1042,17 +1042,15 @@ static int vrf_rtable_create(struct net_device *dev)
 static void cycle_netdev(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
-	unsigned int flags = dev->flags;
 	int ret;
 
 	if (!netif_running(dev))
 		return;
 
-	ret = dev_change_flags(dev, flags & ~IFF_UP, extack);
-	if (ret >= 0)
-		ret = dev_change_flags(dev, flags, extack);
+	ret = call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
+	ret = notifier_to_errno(ret);
 
-	if (ret < 0) {
+	if (ret) {
 		netdev_err(dev,
 			   "Failed to cycle device %s; route tables might be wrong!\n",
 			   dev->name);
-- 
2.50.1


