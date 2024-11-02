Return-Path: <netdev+bounces-141215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7FD9BA102
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0181C1F216BA
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2F2149C42;
	Sat,  2 Nov 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6gcYGx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100968468;
	Sat,  2 Nov 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560571; cv=none; b=CInreXhKW3v2GMG1gEiZGYh5Io5yD+DJV9YzKYDadLxP5y0C9zFoVd2h1RrFYTcayJkXtyXHG9pXJOtIGvMDZaNcWmhcJcXiSnkPmAJSMdMfteaUoJMCMB12XuYuTQYP2fhlui+qIgn/HYjCcOn28abRaT8Ad5hsvppxvEWtCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560571; c=relaxed/simple;
	bh=60qNh1s1DT6BT+CcujQXN/sBAM4Wdmnw+ZYgXLo3o8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d0ixM9pTwYtlgSMZ8jagao8XmyZZcIkI3s9nJgYbCflUPiqBOLrCIatihisLw9VRPfOlRb3OEPmkethdviYhl5pvv5FbNgPgJWxr+u/qLPdBF3y1Q4g5ymszzW2ycZNPCGk0Ky4hFbckNzsbAxb5JykGPWW/fqNYDCK9zZDN4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6gcYGx8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso24435035e9.3;
        Sat, 02 Nov 2024 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730560568; x=1731165368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo8TrLqoGJ9KwSkI6gDDvx/tRuk8ttZiui8cxcCuOwg=;
        b=V6gcYGx8m/fR55cSikdQUQc/IZ1GMgHWIZZqPvoMol/OAewDS87QJVql8IeU6IX2mE
         LhrxhMZYFJ5+6/KwODTIeLj/Ize/BjRgU9drsb/c57xCvCorn8iQ8iQ64/SzfFOCG3qI
         F+gIJG1q2nGQLPh4vvprjJqAlpnCnTq0U9czXicZdI09tovDPDZNIAXjtKVs5e9+gb2q
         B21AjNkNFF60Lok+kR3PeKO3ctH46Lz8/Dp0vZjzbrq4uf5p6mDUgHMm6sGJS6fhU/9j
         xp2CAAcBNgHMWjw5dhEsJ7ZpT6nfEqbEiThpj8y2x4Ahb68qkYQmuYlPJR+KjrdEBCEE
         nOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730560568; x=1731165368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo8TrLqoGJ9KwSkI6gDDvx/tRuk8ttZiui8cxcCuOwg=;
        b=hppIgKhf2Fk1zUT/D/WxI28AiPqTJFqg+6NnxrDfcbGxMhKiNn/RBwO+Ov2JjAkVny
         4QwReFMmtiHX3g+IXtT+lHfKJqCnVlnRbQy/YdAjb4DkjAaj8YrrDA7vXdFJNhVIX24g
         jsir74EV2NWnJsXqkYvUQ9xAXLjrZv4ADN+Nk8gk0MzD8wOgJP2+rV9hBbUHq/W/3Ihp
         MrfnrBcFVGe0Zq8OHvlJA/dYIRoluHppVNlyvcPhALExfagoUZs/aCI+A7N/VQffquw0
         jH6p+L/tOB99SMP4xz9c6Zqsffrx0aSin9I5fpxBIE+W/4yd11YN2QLSM22oqHp39lSG
         wfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW03cUktvJCy7Hrgz0Qo1IhMQwPhpa/w821izIl5DHt2yKJYbdMpID0yp4Jtr3q1sWoo/GgyfjESJ04My0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVjE/g6U2c/1Xc/of/iowLDrG8RdrPcFg9NdZI6KFL/XW7bin
	vwlp0Ko5jCnQOgH6mnefeuhTM4Pjw6BVjXHGxNYNYFAZ4xy+Lcpo
X-Google-Smtp-Source: AGHT+IEGWXR8eIAqAfJzmFuDnQTqn2Fs1e5G6imzHZA0WXNL0GBonbA2RVN/WK22zsw0/M0f+C5eaw==
X-Received: by 2002:a05:600c:a41:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-4327b6f94e2mr86649635e9.10.1730560568072;
        Sat, 02 Nov 2024 08:16:08 -0700 (PDT)
Received: from ld-100007.ds1.internal (77.119.166.96.wireless.dyn.drei.com. [77.119.166.96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4327d5e94cdsm97172765e9.28.2024.11.02.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 08:16:07 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
X-Google-Original-From: Diogo Silva <paissilva@ld-100007.ds1.internal>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	tolvupostur@gmail.com,
	Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH] net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
Date: Sat,  2 Nov 2024 16:15:05 +0100
Message-Id: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diogo Silva <diogompaissilva@gmail.com>

DP83848	datasheet (section 4.7.2) indicates that the reset pin should be
toggled after the clocks are running. Add the PHY_RST_AFTER_CLK_EN to
make sure that this indication is respected.

In my experience not having this flag enabled would lead to, on some
boots, the wrong MII mode being selected if the PHY was initialized on
the bootloader and was receiving data during Linux boot.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/net/phy/dp83848.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index 937061acfc61..351411f0aa6f 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -147,6 +147,8 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
 		/* IRQ related */				\
 		.config_intr	= dp83848_config_intr,		\
 		.handle_interrupt = dp83848_handle_interrupt,	\
+								\
+		.flags		= PHY_RST_AFTER_CLK_EN,		\
 	}
 
 static struct phy_driver dp83848_driver[] = {
-- 
2.46.0


