Return-Path: <netdev+bounces-155274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810ACA0197A
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247663A2C7D
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78414A4D6;
	Sun,  5 Jan 2025 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="x1c1XZN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C91369BB
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081593; cv=none; b=VFAxAweD42t+2yrgeCeGg83bxSsKOHGOLl5SLFhqwnjmvvL+gQqh1sexKHAIEm8TMW298T7U2vInAB3bonCDUDmClKc/nO4TKEH9Mo4cE+vH9KqbsIGr4/qEkM7yXL6WZFdM/+vYd/W5vPma+StAev+gBUawwklHKf/Y0UIyXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081593; c=relaxed/simple;
	bh=0w/Rp8iuQnU3gl3LtmBHOJLoromXvFCh76qcN0TaIO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roJEqBi0tQT2IZGWPGXWMeeaZLas5q4HNGv6nuULGOSv4RMcUMevH3Vb9QXqx577BCADP8p3eeatTDGFZM1Ukv331BUraZj4LvDed1LArwFaiFzSmg1nt45XzQlpytA6gK8CeaSYCXc3tX9IEyifyG1XUURMxcMJ12RyiTqm1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=x1c1XZN+; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2166651f752so224229435ad.3
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 04:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1736081591; x=1736686391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQxfNFmrbZ6zPc6Ddyxn0r6CTSC3iPknM7hVXixbMno=;
        b=x1c1XZN+YMiSmiH8zihn5MaQwVOk4Buubgd/mHhdkA2RVgA0EDhDb5INAGy+VW3s4G
         awyAqdmJNGKyHghNArZKrrdyIRA6JRL/DbgvIYwhig1cL1TwfDVvf803121izIARamUB
         5W/BFe9nB4ejNoS9aGKHDnfgqG7vI4b+J9E1b5Rh+2xyGo4XDo7uFFgKObTkuXaGAkCs
         /glXHdN4gOmEFFmNhH1Op+eeO0Z6FkeISQJ/NSVuwnFdWiqNJ4VrXcuU90jhcqMaM2GC
         DNKffWbOjeurHmx4SyQsh9LCqvkKtaMVkWYQ9jbxzymtmZeMj5lHWvfFOIvFc6galhXT
         G6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081591; x=1736686391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQxfNFmrbZ6zPc6Ddyxn0r6CTSC3iPknM7hVXixbMno=;
        b=TSnU3lOVIJirH4hW04q/7u9VOJzA1moDHS4CpnZ10eUTap5yW/Y6M7oo/us+Muk7go
         XjeViYLl0oF2fsoVwlpeZR3OtVT/LfGGP3u9AVkEH3J51gNi+VueFIcxxcmnjUyXOT08
         RtCx5TIX550OM/UkDqA54CpjLARHWZn6EdX3rDw2IMGkpaELxVN8Vl0/pXaA/r9u/OqK
         zZjfqsPwInW7v3IE4GGMzmsWoRrZF//ZiQSBxt1r53SbLVLp4VuCmS1pY5c23ZxVILy4
         M4objL6W6pisR2YsOc4Qhl+NrzlvoL2kY7hOktXld1cn88ZCOrdYMlTgDQm36xA20pGk
         YAPw==
X-Forwarded-Encrypted: i=1; AJvYcCVyv0lRv3rWUYH9YVYa4Be3rc+1m5depT/bHu2DsKe5YO9weiX+cbSulw6y00jWyzix8y/+mZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRcowfGXZEGkILNXTCeGr6C2/IHszGe5bTjte+vSSdWIXACJ0
	XSG41Wxd7RzEkGB0na7VZnQ5QmJCH0FpDWpZpG0jKKG03S8mRmHKkPbwKCACNa7vbYOL0Ki9dO4
	cOpjQcmL0EEY=
X-Gm-Gg: ASbGnctPqWi3rhDbo0F1SME0bP+mcFwQEeBLeYgkgsajZxtJdDVP85pOj8Sq2ZoG3Zx
	SLcyi24VP1KR1hQHzw43FVh9ptniGU3pjKZ06ySQcMFiJpdhtpQ651ZwK84f5XQsrCTlUZwlLKF
	iUMBtMahiZDXNOkivSSnaaYRcrbb4bEgXstKaPwCZ5s5n8l9a5O36jmY3TEP34QezKexJY42Kfg
	0ZDR66sKBTOdyPVXbKtC6GBecAO5+oFShz/W5lbSkXawczmWdDxV7tGsMnYmj3fnbpQsA6s1qJE
	RmN7dwq2Xm9yRZGH
X-Google-Smtp-Source: AGHT+IHYDHIk7UJU0RWKyCcaknT3poUeEwwbVHtjEHkXSwC26MztKne823XopO1eYAZ/scL+zgs4XQ==
X-Received: by 2002:a17:902:d48b:b0:216:5af7:5a6a with SMTP id d9443c01a7336-219e6ebb6d7mr785946725ad.32.1736081591668;
        Sun, 05 Jan 2025 04:53:11 -0800 (PST)
Received: from muhammads-ThinkPad.unrealasia.local ([2001:e68:5473:b14:aa04:150c:3eb7:7c11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d448asm275987405ad.146.2025.01.05.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 04:53:11 -0800 (PST)
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
To: Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Muhammad Nuzaihan <zaihan@unrealasia.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] wwan dev: Add port for NMEA channel for WWAN devices
Date: Sun,  5 Jan 2025 20:48:20 +0800
Message-Id: <20250105124819.6950-1-zaihan@unrealasia.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the code: drivers/bus/mhi/host/pci_generic.c
which already has NMEA channel (mhi_quectel_em1xx_channels)
support in recent kernels but it is never exposed
as a port.

This commit exposes that NMEA channel to a port
to allow tty/gpsd programs to read through
the /dev/wwan0nmea0 port.

Tested this change on a new kernel and module
built and now NMEA (mhi0_NMEA) statements are
available (attached) through /dev/wwan0nmea0 port on bootup.

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin <zaihan@unrealasia.net>
---
v4:
- use git send-mail because of mangled tabs in sent v3 patch
v3:
- Removed unnecessary code added to "iosm" and "AT IOCTL" which is not relevant.
- https://lore.kernel.org/netdev/PVOKPS.9BTDD92U5KK72@unrealasia.net/
v2:
- https://lore.kernel.org/netdev/5LHFPS.G3DNPFBCDKCL2@unrealasia.net/
v1:
- https://lore.kernel.org/netdev/R8AFPS.THYVK2DKSEE83@unrealasia.net/
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 drivers/net/wwan/wwan_core.c     | 4 ++++
 include/linux/wwan.h             | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e9f979d2d851..e13c0b078175 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "QMI", .driver_data = WWAN_PORT_QMI },
 	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
 	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
+	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
 	{},
 };
 MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index a51e2755991a..ebf574f2b126 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -342,6 +342,10 @@ static const struct {
 		.name = "MIPC",
 		.devsuf = "mipc",
 	},
+	[WWAN_PORT_NMEA] = {
+		.name = "NMEA",
+		.devsuf = "nmea",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index a4d6cc0c9f68..ca38a2fe0987 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -19,6 +19,7 @@
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  * @WWAN_PORT_ADB: ADB protocol control
  * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
+ * @WWAN_PORT_NMEA: NMEA GPS statements interface
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -34,6 +35,7 @@ enum wwan_port_type {
 	WWAN_PORT_FASTBOOT,
 	WWAN_PORT_ADB,
 	WWAN_PORT_MIPC,
+	WWAN_PORT_NMEA,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


