Return-Path: <netdev+bounces-70014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD584D584
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918211C216E9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B7131E40;
	Wed,  7 Feb 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C59P9A4P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E21292E2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342210; cv=none; b=mtBwlWuBgfTripiQbUxFn01/QZqhNmUIfQZTbFP+RTipaVZmq+/ZMKnMXDS0ddJsQ48kIgNXzPU410+Re6FL2YiVApN+gb428zZIAq99bggrVZbTTgQxB1bsV+N9ibTPmyFDztf6HtN2AiLBk+xmoIQ+v9O1SA054ARrQ0el4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342210; c=relaxed/simple;
	bh=4eLx8CygwINcoVnKPk315lLZnM/015PiFeYCTKFw8JA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CF14suoToaZUqwOTX3I1ZJTM5UbwmLj4WkbO02s+6PFSlRTNULPGtkU57wn5iLBZvpaI9bp+qkAGyRhJyQk+Ewl2LnB+jyjkFUw59osutW/g/ldcrtCTGx5JvziWXFOnrFKaj5zjtlBmd6BMtIsDKkMm1ETdq/2nyARXIY6ARTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C59P9A4P; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51124db6cf0so331063e87.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707342207; x=1707947007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOwtpqTTt3OSl517az5Jyd0o1/DtkkFJnxhdCujepQQ=;
        b=C59P9A4PwU7Ryjn8B8DA5Cvtk8dfuY3EhSHeniG3L/mR+xCikU9UYBOjEeEKmAzaed
         Mxt80tfFKqO/VeLSXyQNUwWZ9/OdhiFaOJy9ktiAILqArfx4ZPyUs413a98MYimGhzwv
         wlI7oodwu2j5yVfziMS2KFRZqFL62zHqZcxqr4odnLWH+P8qbQG9UsQjfhrkY0MVgd2h
         vW7iEELQEJPhggVOef9U7oYC3EXP1Gn42/jJ0u+j4Y5DlxH9BSDu0tkUK+oQqqvnrjwC
         YO/ykAHgolr42EjaeY5YUlFzICvo7hc8YVQbCyW7lqCxpmFVhR1sKZ2516qlGJNfycoS
         ptWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342207; x=1707947007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOwtpqTTt3OSl517az5Jyd0o1/DtkkFJnxhdCujepQQ=;
        b=FT2tXB7Ft7kF76UMTnwC4md/pY1CLXHN3mMYGLDc9wiCuwPSRUn3Nfl1DysMc4OOYC
         RVu1mLANRI5jdPv1rHdoolnNiAThiiOiPKn4Qk3jmS7JsrS5Pkw/X19yPrMpgzh04rh2
         OkCO1UZx5jslL65jOKhbjvxDwIoMOvkibgbyXNC8f9Xk+IrX58nbQh9fVgd5dzrhNGo2
         MqvfOz/6xggCUN4FcUeINsEJVqeEI9myxWFJNEIuv26yi+PnJxYjVQgTps6xp27womTr
         OHQnfNR6YANfA/gM7cPLuipyQxQbDii3mfJMYJjZ0dgtHXVY2duWQfmtCd9QApwCH18X
         15pA==
X-Forwarded-Encrypted: i=1; AJvYcCWPwqpoj2LDT5GklYVeRilsoZuUsJUT/IRxVLGX+AunOajyvCU2B+t5cxbh1+pg8OXOp+hgKaa+7aZ5+T9y5DkVMjP7yOH2
X-Gm-Message-State: AOJu0YxXrGchFs8OOqxJ0yVqX/LaarV9G8mETyomyxNi0B2t3yiTC50L
	j1clZMs7nXHDUEDusbnZMdKHKaFmzl2S4oTskxtr7JQ6V24brCI6
X-Google-Smtp-Source: AGHT+IG7yVCsSyoo0hrZHfRYpbR48hz8NB8qXhdoH8vFO4T6Rp2V+dIzyuUXIphw/RMevdXuwCqzkg==
X-Received: by 2002:a05:6512:3e20:b0:511:6c4f:f4bf with SMTP id i32-20020a0565123e2000b005116c4ff4bfmr139813lfv.32.1707342206751;
        Wed, 07 Feb 2024 13:43:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoZEVt8g0xATzkX6vKoXFzQYpwVkLY9esCooteQOWOPiOGdMe7qaf2ApFO2/2n99HqiHHW4vxQ5SB83JJudTYj5TOqDTOK
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id d15-20020a0565123d0f00b005115ea2c301sm327118lfv.49.2024.02.07.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:43:26 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] m_ematch: Fix descriptor leak in get_ematch_kind()
Date: Thu,  8 Feb 2024 00:42:32 +0300
Message-Id: <20240207214232.19204-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/m_ematch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tc/m_ematch.c b/tc/m_ematch.c
index fefc7860..eef6b05d 100644
--- a/tc/m_ematch.c
+++ b/tc/m_ematch.c
@@ -149,6 +149,9 @@ static struct ematch_util *get_ematch_kind(char *kind)
 
 	snprintf(buf, sizeof(buf), "%s_ematch_util", kind);
 	e = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (e == NULL)
 		return NULL;
 
-- 
2.30.2


