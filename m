Return-Path: <netdev+bounces-245630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9FCD3CF8
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC33730057DD
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97582259CBF;
	Sun, 21 Dec 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrDeP1Nh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DA258CDF
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766305461; cv=none; b=Y0tIyonA7036TG2mEZVSdKp88kzCZGaq+BoxQQBnLLwq2NbCeG0CDQW4YvyP2uceGNYDlvQGLcutTzusX0sKA+08V0o1y9HM0sL8KR2c3Slmd0vpM6mCI24JqgE0xoevqrrtwRXDvVhIEFmja3oQNVKCLdJKJH5l88okiEum1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766305461; c=relaxed/simple;
	bh=aRLaB3KuMxXhmDs9PQpW42dlh/BhCSSc1295RbPjwPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ur16deaQT34tfOPCgH21UUvbrPtb3XvoJiKYSk3iMUMJz4Qhf5sUUyPpS7tq0gkFvFlwmedrpLh8hfNA3c8GJ+L6RLdVdQdwkWkkueOTpCQcxYj+mtwTqVUmIUvIpCf3sZY/bcLOVz8cbVqlvgn5Vr5ucYZLWIokBOW5lp0rpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrDeP1Nh; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0833b5aeeso41996655ad.1
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 00:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766305459; x=1766910259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppyiSi+wYHHJO04DxY+5AJW+uBJ8Dan1LsY9lw9svb4=;
        b=DrDeP1NhRqJGuaCK06LHNaiHhDPSGTFkOWT/vFMNJuMMRCV+TSN7MvzmF0pnCo1bhF
         JIg9bgTEcQJpHJaK7yb4ise3rZHN9BKmqM2J2wo/uTMO8/lkSkdFaVwHjP5CjDFAGtg6
         k9FJ9mbG1SDJGJv+Ul+8gOGYvoX92oKXOJbh0WXcXMhzoRnvpD542ElUd191RtsgO8dO
         9LfiFrRIIDMO8iEvAorIE+91PAn3xl8uMvVhw/9l/08LEnHFIGiuCivPVgsXDvRJWcXA
         K8iPlJNxANa4oUGk+y/1wJlO5rwJwPO3Y4hhuVAuNIIPYC16038Jdq17C1LK4t8nOyY7
         cERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766305459; x=1766910259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppyiSi+wYHHJO04DxY+5AJW+uBJ8Dan1LsY9lw9svb4=;
        b=VktxNG2jEDFCV1cTdw5nKggwFOxus3nByCBLsNoGxFtdXzvyEjamOctNOu5Yz4TnVR
         biBiXWqHseSlCmzti7eaxcSLkDiCQ2E42ukZ58QGccH1t/P/7EqfCAH9kF9mGE+wvdba
         X1Dqvo3fXhLyei2u31RhxB/1EIS8YBR8gnaTmJXtvtllNGmF19uDBzBEtRdj1OzQggyB
         jvMdjqmbQSZ9TDX40nfEh/hD+rp4Md9AmG06B8FbZeeTZug08mLjTKBKXPolYlK37kZw
         wD6lIXXoqwqGD2z9nTO+oMjcXm6P3US/4CoI0ZYSUxHgVcdORYJwaVk6WuJmAuAPlPLG
         T5IQ==
X-Gm-Message-State: AOJu0YznDdi8/sYutSRfEwKy29y0eQc0E0SHUIbbCClopzX5cGlp9GFu
	rBm9gswPon6YeBgyzcFRsNwS6meiSFUqMeqo78l2mSBqeduVWkoJo45Bqru7rETY9yk=
X-Gm-Gg: AY/fxX5Bha3iwtN7rYqpas3SMcxO9ZvWZy4V6OcAtOYeCm4cAJKhyJUPv/OW3if4Ooh
	yim9DJ+1x+DQ9sxxZqYb2McCLcyN82Ydr0gK+FvKxYAQCAWQp47mbAaTTztvT8tShCkvlPO5Qfq
	dzcxDhMy/05tpZsZv6qzO9JWhL6OUTFjnAlSP/L3FSXo9PNdJ+Q+cbkOQwKmV3wrBXJf3REPUTw
	Y+p960sCJuJ+SvGtgY6waPGl1gpQdVKSVhlP196qdf8j9jykeNLz2n/x2FCQXCbXa00Ae5PsP/f
	c/3lKogSI1kiY7MU47tM8uTqsLMxH1sp0kGdNDBq6A5VkzXteigPgf1FG2A2NXg2fT/KMevxoYY
	qUszICxRFXw/wvO2ZouVrkf8uRayFe7nfDvpjzUMr5pqnCCb4yrHnQpYjFeX/XF22BoKbAWkzQC
	lO1pbRQ53rNFOGTqLRlfg54Hjl87IxWh7OeidLOqj31nv6Sfp7+e7v5ohliiA/0vi8dmhPIQ+do
	hqzEpTM5IIMTDcgma2ZKpCtW54N8wpNAx1bFTQaLmjos+8LZLu9R2E4A/j8wU9fvY/vEvzvC6F+
	3lyQ
X-Google-Smtp-Source: AGHT+IHz+nWY6N4A0JUS4wDUAGuKAHpm5umfcPtGIoz1kTOK7eloiKKpcEvU9y28U6EykqpFQ37inA==
X-Received: by 2002:a05:7022:7e8e:b0:11a:c387:1357 with SMTP id a92af1059eb24-121722ac203mr7819522c88.16.1766305459236;
        Sun, 21 Dec 2025 00:24:19 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254cd77sm30368015c88.14.2025.12.21.00.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 00:24:18 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2] net: usb: sr9700: fix incorrect command used to write single register
Date: Sun, 21 Dec 2025 00:24:00 -0800
Message-ID: <20251221082400.50688-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the device failing to initialize with "error reading MAC
address" for me, probably because the incorrect write of NCR_RST to
SR_NCR is not actually resetting the device.

Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 091bc2aca7e8..5d97e95a17b0 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -52,7 +52,7 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8 *value)
 
 static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
 {
-	return usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
 				value, reg, NULL, 0);
 }
 
@@ -65,7 +65,7 @@ static void sr_write_async(struct usbnet *dev, u8 reg, u16 length,
 
 static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
 {
-	usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
 			       value, reg, NULL, 0);
 }
 
-- 
2.43.0


