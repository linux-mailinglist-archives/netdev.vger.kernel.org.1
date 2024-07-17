Return-Path: <netdev+bounces-111931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C89342A9
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B56B21121
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA171184115;
	Wed, 17 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2kCctvN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07318412D;
	Wed, 17 Jul 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245079; cv=none; b=hMWZYbMhnEmlkW05kdscIVA2SIsnWQgVM/a/gTdUhDdXyoTFtDV/+gucS1tjFMqAb9PonSdYugykj2zyBOufR9IkT/P+vgbwhlRWvQDfbfpauVnP5Rk7bGfFLZUgoKX2Won6lTQ8CIw23RoZbOWMN07ac1/4TXJmKk108b0EZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245079; c=relaxed/simple;
	bh=yz0EKOsTz7mrobhF9M6zIhqCKDK6j40HP66tkUPF65I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaMQMh6MgFk++RYlX+mA2t6bFtNyVaOwCuG33AXs6aJ0sSzV2yOb8Obhw4U85PlEvmp6A41mRkXbMDI1VJMFwOwEA8FXqRHENBoHM9p/f6Xe47+J8FbUt/+J0biTHxFQDoUtB6H0zNyZpf/L1MdUPYfrqAimvpJ9R9ZvY9N1SRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2kCctvN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea5765e75so35967e87.0;
        Wed, 17 Jul 2024 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245076; x=1721849876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juG5Mh/paW+cHKYcZvK56fxFqxRK7RpmIx5RQO4lGUU=;
        b=K2kCctvNsBcge5irXXagq7BmS4dCYmXx/+DOLt+puBNTMExAiMjXJfSmqRszUhqhpt
         6MK7nypfkIhyW679bL7UMtOyAN5eK6j2l+Ch1r4cY/tA0DB3mmp+ra6rBWergpwcgbgz
         TF7pIJFY0h2XdtTK9O2co55VKtGPhPyWNaiSM6YqxxqqmiNptfU/fJeyBoHhjyllEUHz
         rmpO7/Hm0DELEfJFgZlIRKikRczV0C0V53Cu42Uv9nfwq6b2ZGLym9JDDOJR4jImFbNT
         ye3qA6Os4H6Sl6z1hQLqKLqdLINeReZlo70fqAorR7CSTFc9WWp7+Luncw14c3TcZRKs
         muaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245076; x=1721849876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juG5Mh/paW+cHKYcZvK56fxFqxRK7RpmIx5RQO4lGUU=;
        b=VoQMh88mubFeW4MSvgQKYDSKkuUJESTvE1NaLef5IgrCRECPWWRggy2qQC7LBFK8wk
         xJhDV95dNMEvABQLb1K+HoeYohf2flh+gioQXK08qGVgUg2o1E+LkAFnxzdlksm8Tk7z
         8TkPUcsbNOAh3dUkId4u4htUDVmmagSsnMakMjTTPQHIP5UsC5SMKNtk9fFm/WvcsG/3
         oF/+w0L9/7DRY1LMMd0LaoBi7e+f19aSEUOEnqPRII0fAWhgBqsD1IoVH9DQgz+23sfs
         gaup7iYP0fIuUA9LWm6iOaQcT2n3sf6mwq7CnzXOJFAuYgjmtBcZfSzlAl1SjXD5DnL+
         g2eg==
X-Forwarded-Encrypted: i=1; AJvYcCWHTq+uBVFXf4BmqMXPwXZEhbYAXs1NkVn1j87QbijG1iDDHzIgMWu0tTu/4sHggXvyZ02ZXIn62NEdpp8Y0T4yhYmsgTWh
X-Gm-Message-State: AOJu0Yw+psj59lTQWU2euLjwx5ul/2iEDld437fezLEJPP34B+LGbtPO
	zaG9A2aAjW80FOtwnwhNu5X3XTvXf0cYudQIOzWaA3KNglZCq7aO0HHva383
X-Google-Smtp-Source: AGHT+IHRuRxsah0gtgVX8+GeS1TA+YAkloirHXNwSXR4YvFjrGekWuSoPsZ/Fzbv7FAvhXl91IEVkA==
X-Received: by 2002:a05:6512:1306:b0:52c:82fa:ef7b with SMTP id 2adb3069b0e04-52ee54112a3mr1839554e87.44.1721245076405;
        Wed, 17 Jul 2024 12:37:56 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::101:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm3080535a12.68.2024.07.17.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:37:56 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH 4/4] net: dsa: microchip: ksz9477: correct description of WoL functions
Date: Wed, 17 Jul 2024 21:37:25 +0200
Message-ID: <20240717193725.469192-5-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717193725.469192-4-vtpieter@gmail.com>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com>
 <20240717193725.469192-4-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Correct KSZ9477 WoL function description, found when evaluating it for
usage at KSZ8795 family of switches.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz9477.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 425e20daf1e9..1344b60ee2c3 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -95,9 +95,9 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
  * @port: The port number.
  * @wol: Pointer to ethtool Wake-on-LAN settings structure.
  *
- * This function checks the PME Pin Control Register to see if  PME Pin Output
- * Enable is set, indicating PME is enabled. If enabled, it sets the supported
- * and active WoL flags.
+ * This function checks the PME 'wakeup-source' property from the
+ * device tree. If enabled, it sets the supported and active WoL
+ * flags.
  */
 void ksz9477_get_wol(struct ksz_device *dev, int port,
 		     struct ethtool_wolinfo *wol)
@@ -135,7 +135,7 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
  *
  * This function configures Wake-on-LAN (WoL) settings for a specified port.
  * It validates the provided WoL options, checks if PME is enabled via the
- * switch's PME Pin Control Register, clears any previous wake reasons,
+ * switch's device tree property, clears any previous wake reasons,
  * and sets the Magic Packet flag in the port's PME control register if
  * specified.
  *
-- 
2.43.0


