Return-Path: <netdev+bounces-194494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044ADAC9A6F
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C580616B9D2
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831A239E95;
	Sat, 31 May 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFnEGWlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D5EAF9;
	Sat, 31 May 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686400; cv=none; b=TGhqS+5LsXgdkIJK5RNE1VqtMr85SBfvpnH7za/Lvm4CYWrYzAv173WW1mXZM259kN20TAyXAItM88hxCE8QyWXbXcuNZWHYM/hmvKpP/anoaeYjP0tipIUFJgMon6KqfhEBeO1o7qBvPDvgh5IkUnu1XzKIbUZpJsF2bn5Crig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686400; c=relaxed/simple;
	bh=+TCwMqM29MSzJsKIOwnIu90KDcktq7NRHGr/qWUAZvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCuhrkRYdinL1wrMqvWRYe2uXZaHFIrDld7amlPUpm00iG0rVSKarNo1hsxZ6lV3FtxzTm3gsEEJ1lX8SFU5MESY6wbPCGj/8F4Y+fWobDGuDAua8SWBNtMPaDcKDFANa/yi/SSmG/ca7Kci+B0Yl/XIfaM4kc9IXRAkp/KwWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFnEGWlE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so16757495e9.0;
        Sat, 31 May 2025 03:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686395; x=1749291195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6mdyCUnYClMxKpkumuq3qco0eqhBFAoCt9GF5tCKDQ=;
        b=CFnEGWlECJs+6u3G10Cs+kIIN/r3HyeYbyca/EoFyjnxr6BTxpVAivYKcfos2EhJcv
         X/D3oxqoPjKKe+RAyWKjWYGoof0wKmYaj/xWKvv2iVL5EEZa24qbHT6/jkdNJVUG4w0q
         GFtp3xwrCvMFe+AcEdl9Q2XTEMjjMtzPCqVEgHptSOcjgnttkyjRW5JKzaDodKi2rsw5
         T1/RTHtyELQ/HfzojIGT6dWPIzBG8+URYvIJO9P5BoWr9csUWitnyQyE7sxW2wb4rIr1
         gQBcFnpsTC43OQVv0jN2pkH/W/MTkHPHVVaqmBYhPj/6adYuIVB3VElyDBw8W1hwJGJi
         WGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686395; x=1749291195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6mdyCUnYClMxKpkumuq3qco0eqhBFAoCt9GF5tCKDQ=;
        b=lLhohFZ8XVtCbSY+BpVqUP+v5ZsJg7k1E0/D0ZFy/rFWShjaA7e0cYTVE7wsVIsRMG
         pI+y+ljVH5W9lD9+qrElhaNTxHDBdesQGG7g1GClTSKnRiiV2sufoLMwMQdlzmFjw7Pp
         k7JnJw01IQCcVKQ6mxY46Uh1bX0svILf2CCh8XlbkSv7mWoV35LC/oSIkPZe0+1BALyo
         R41o5p2OcPbe8fA8cH8/lb/odE0NVGwj9IJxJStZLQSfYguD48D32+44i8RECG23F1UX
         dk4dyeE6mpj0ZNk1Mx1cvdQjcmLt/uoS+hz3YU26qv7RkJxNr93XC25ThhEURnZh3bwn
         x4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVPDFrxloCyFIxlmmHDwBkGdBlgZaDj0NFCMfL0ZnBAzkW3bze+Oi0cRrM6995r/g5cJfSU4HMxy7pWUiU=@vger.kernel.org, AJvYcCVwcC8oZ5qQ4mQaY2DhjU7TaqXj0xYikaH4eyw0uXcjs9y/TNWEdtIACli3m9D9H94sRvaotlXK@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVtlY21yFs7mQEtGqIQNcZG/w5sk+Rs2KbtPYVHknv/ViKEtY
	yLXo0y/Rqe8KbIErzuA3C+cxO6FCk//TnfJfLqWv6MGENL4DpXi3X9kK
X-Gm-Gg: ASbGncvtYDllQoPt20zt0JZNCrqCSsMyo3UGvKSQ5xnjbUPGlLQrFGds3C2cQXFhTZJ
	OnNropkHO1WB4k9cVHWgk0HLSkkmEp/+QjMuxBmtA8ngI6CGMAG9IlOdQ0nhq8xizA+UQTd0cgl
	v8BXS+T8j7q8+MXvy7ZgV50+GT7pGMlxs1hkSBgNX9CkBKW9nwmoUJZyzJa4tt909gNYI7hu3/R
	sqoqHeL3I905a4RwaBECgoUKjy6rTtYtAGqjGssvVayq5ZwtzBM8FGcolurgjbthVFcSVfxKfSo
	XVOYazgeJT3uahzxoXwLkepTLehlIPDzvLnyrn+nFD+DqksjS/tZIYV8CBfXahQ9scpkThAt3n2
	zarNDAkLum0+fGhME9vN198wHW5KsvyWLq/4yO5OAKqssOIA2XAKozJlo8KP/W20=
X-Google-Smtp-Source: AGHT+IEZO+tlyV0y5T3wPmejydYVu6b/z0NuYm+mLVa8S0sl+RrEV/XF03DQ4nSzYlV6FPXlIcB4Xw==
X-Received: by 2002:a05:600c:4f46:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-450d6bd2efbmr48720975e9.16.1748686394491;
        Sat, 31 May 2025 03:13:14 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:13 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 02/10] net: dsa: b53: prevent FAST_AGE access on BCM5325
Date: Sat, 31 May 2025 12:13:00 +0200
Message-Id: <20250531101308.155757-3-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
writing them.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 03c1e2e75061..d1249aac6136 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -486,6 +486,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 {
 	unsigned int i;
 
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_CTRL,
 		   FAST_AGE_DONE | FAST_AGE_DYNAMIC | mask);
 
@@ -510,6 +513,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 
 static int b53_fast_age_port(struct b53_device *dev, int port)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_PORT_CTRL, port);
 
 	return b53_flush_arl(dev, FAST_AGE_PORT);
@@ -517,6 +523,9 @@ static int b53_fast_age_port(struct b53_device *dev, int port)
 
 static int b53_fast_age_vlan(struct b53_device *dev, u16 vid)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write16(dev, B53_CTRL_PAGE, B53_FAST_AGE_VID_CTRL, vid);
 
 	return b53_flush_arl(dev, FAST_AGE_VLAN);
-- 
2.39.5


