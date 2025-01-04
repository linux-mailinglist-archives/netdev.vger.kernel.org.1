Return-Path: <netdev+bounces-155177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CEA015D1
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4389163572
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B4145B0B;
	Sat,  4 Jan 2025 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="kH6H+/zJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0A12B73
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736008705; cv=none; b=qrW2Jr2DIhSHF+rKVzvcC6spJbqqcbZNY3NBfDEZTOQN1AaS2p0SHiaOpOuZTCu6Neps0GSTe7z4DwGGO37gYsiMGcbAtPUcuEqs2dlRmtYFSesSb9BJzCyBUM/H2ZM0iDXG6HGlsKh/dxXPPQlOOhnvA5cfiT+GO6NbpaKopxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736008705; c=relaxed/simple;
	bh=IeCtvr5yZJ137A7eMYZIqpToJA/SeJK2K71/I5TTedc=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=c2v/xnPG3gjyEanwyEThllUBARU7ENrlpJ+O8b2n8ZUVhPT8kQEEz/8SntJxPQd32g/eiVuY1uNDjhuYlPywid91bu4fqIy7pEfQ/FUHKUJeFooxDm9iOZ9suRHDQkj5hUMqSZX8EudMJnyJ12Zn1hmsAvgWa8J/Mx/OJq3sV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=kH6H+/zJ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-216728b1836so165914565ad.0
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 08:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1736008703; x=1736613503; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:reply-to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA1vKVJVPUOPHadZbzfpY1WvRQlqltwXDQCOJpeNLJA=;
        b=kH6H+/zJf9KYBYZGmYFDNGV2BQyxhW7bdtyyb5RrOcKuMUh5WkQ3FzfNaBhtP2hid5
         yRMQyzhKG+ssIpsUlEFw8vjcljbtNuZ8GHz4A4P42jV/fQOE9PMLGM9d50+l5WQLM4Di
         5VEyxxcCyhD/QpvWb4XL2PaXNfjHjSfblli1CB1vTJF8MkUwsqBtaWC6nPK1WiSEcqTc
         P1DoOqknm4G1ESV0VZeAVBh5BTzO8ZCusOMEoKJExVBH6VoP38TtJaWZea77dD/aj6vr
         2ob8I9eor8b45VafNH4cUeBsB0BQSk2LKLUY4gxj5xBTruRqPgOJ21BVF+3w6Vqkht2B
         Spcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736008703; x=1736613503;
        h=mime-version:message-id:cc:to:subject:reply-to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JA1vKVJVPUOPHadZbzfpY1WvRQlqltwXDQCOJpeNLJA=;
        b=iBKbvSSq4+E5ml5S7q+/LnXJwd2xvvmk9jBOIoNdXYA2B7vHKc71QE8ELdhHSvMU+C
         bpyvf6m+Ntee7oDSaU5C4OyEO4zuYTSVTtsuUqB64sMuS7GRblPP7SOq1ee96wDZOgka
         3jUjAGd4jwXeKeLXeZxY+lqZ105TjFLAaKI0mNOjLPbOPfzj032QiaZAWB719Vuj3Jq7
         OpMNMZPVUY7DU86PsYqfhoZv+f9hpGoxS/Uv6gvMGlD4cOhgMzAkFuBNRHfTz7+bJnk9
         CX9xk4f973Xg5VuRpE+MHMUbHuGGekEkuyFY13vfwvrwtql0d/PRjPzNarjfRzaUDqPA
         7wxw==
X-Forwarded-Encrypted: i=1; AJvYcCVlru9M+Rk5DKaYpEaXGawFlYcAw/aqbg0hSHfu8TsPAo07OSICYEwHhQdpF0oYoPwzod1cHqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwgDnGFklVXLy5SWZa8hmV0kDkgDrBA3lARdAWkcRpIj45JAh
	TrYqMRkW4143FJkys+NQbAbbgN4Ob7v9NgAVJe8drPde7sRLe8AozBZnCIe9HO8=
X-Gm-Gg: ASbGnctnxnKHQAwq+jIkyyyTBDjxU84BRRYbhz4b/ZwKn61UglnJZBJQWWEK2ikHypd
	aR5AZxlZkYjMLAyoFcZdL1oKwuWbC2HAz0gVYb9ONsr/cCuBwm+L7a+0F9hxr2t8duYM01Oh300
	F/aaYN6bPFzDwzFBLG+ehAfA5g+42r1eH7wl68lg9ihn1lKaUve8bMSyao92x+enrn1/XjIJzC7
	xPsb9Hawrp47vQK3Ygr8MBspmzjyq+RHjpu2Jlv0Xy221mBA82v2ziSfj5D2L3HQzjb
X-Google-Smtp-Source: AGHT+IE684TxFAThsNpuFvTQimfgc+LQg0MpsEyXn+GLpMBE1zaH7uNxU1NOqgosccKpysur/6huow==
X-Received: by 2002:a05:6a00:1889:b0:725:e721:1a41 with SMTP id d2e1a72fcca58-72abded65b5mr71748881b3a.26.1736008703324;
        Sat, 04 Jan 2025 08:38:23 -0800 (PST)
Received: from muhammads-ThinkPad ([2001:e68:5473:b14:56f:2b9e:4cce:63ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1b1sm29189502b3a.185.2025.01.04.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:38:22 -0800 (PST)
Date: Sun, 05 Jan 2025 00:38:13 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Reply-To: zaihan@unrealasia.net
Subject: [PATCH net-next v3] dev: Add NMEA port for MHI WWAN device.
 (mhi0_NMEA)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Loic Poulain
	<loic.poulain@linaro.org>, netdev@vger.kernel.org
Message-Id: <PVOKPS.9BTDD92U5KK72@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Based on the earlier v2 and v1 patches. This patch is a cleanup from v2.

Removed unnecessary code added to "iosm" and "AT IOCTL" which is not 
relevant.

Tested this change on a new kernel and module built and now device NMEA 
(mhi0_NMEA) statements are available through /dev/wwan0nmea0 port on 
bootup.

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
<zaihan@unrealasia.net>
---
v3:
- Rebased to net-next main branch
- Removed earlier patches that added unnecessary iosm (unrelated) and 
AT IOCTL code.
v2: https://lore.kernel.org/netdev/5LHFPS.G3DNPFBCDKCL2@unrealasia.net/
v1: https://lore.kernel.org/netdev/R8AFPS.THYVK2DKSEE83@unrealasia.net/
---

 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 drivers/net/wwan/wwan_core.c | 4 ++++
 include/linux/wwan.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c 
b/drivers/net/wwan/mhi_wwan_ctrl.c
index e9f979d2d851..e13c0b078175 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id 
mhi_wwan_ctrl_match_table[] = {
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

 static ssize_t type_show(struct device *dev, struct device_attribute 
*attr,
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




