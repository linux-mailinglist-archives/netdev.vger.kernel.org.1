Return-Path: <netdev+bounces-107070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F683919AE3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 01:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA151F22A05
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE457190664;
	Wed, 26 Jun 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGoNidHw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BC7345E;
	Wed, 26 Jun 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442962; cv=none; b=kCsooPy6MznHfFvr0QFxGt9VKZfwAXOnG9np+43v3k0658pXhjEqE5i541c8mkyE++HMLD858W2d634r/5cL9sQb1SKBUCziLQBgmQ04rxoslzyIioJwogjza2uPfHoggyomQ+H2z6cPGtqhtur8ureOwfcBBBxPlEoeGz11Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442962; c=relaxed/simple;
	bh=HGbhoQODnG84tVTQb65ZNSvMr1rGqZ00qLSEQT2Y3Ys=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GgUaY6yDNOuCV+hChCD9SoC1caxvHC5q9WEiTsXA2wv7XlhKL/irx886Js0tpxiu4V7oQbHq6P5MyuJ16ETzAWAsdPYqnhpQUnVppPNvB3wdKHn/lin257vSJJ8Bkvc6lFfyrztzsjnFzEQZJZzMs3RSiJtq+ZTtt5uj3kT1ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGoNidHw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso45654591fa.0;
        Wed, 26 Jun 2024 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719442959; x=1720047759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gx3shKCDZpO3U+ymX9aY1BO2muNI8Stc78ZlJ/5t1FI=;
        b=LGoNidHwFefy7IosAoF+gFlxJCF4yEVM10L4A7wo+fp79t0yv0MQuptgxa6sqCNhPl
         KPl5vo7+owcylATenzQueNErVxVSLL74nQQgcIJd26/713Uk2WmDyUy62snN4H6D9m4e
         J5fc+GMbeHFC7KOFVz/416mWlFexqCJQQ0jrEQeLoBJHvvs1bRurlTzbmerQiMJr68x9
         JJXpJrUX52XX2xa1PV6OygGzyJk+LAxmkNnrqRH3BV200omXvsivsgLEcm8NtUMZU8mi
         bcYkwQxbkkNMrKI6jD1+3V4iCrj0s67pc3Yn6uG3fSQicJj9eE6naf0U+Cf5k3FGEofK
         Wikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719442959; x=1720047759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gx3shKCDZpO3U+ymX9aY1BO2muNI8Stc78ZlJ/5t1FI=;
        b=chEP8DVIuVR1bf09+dKpwdyjTQJaF4wbj5gEFVYINrVMBnYwOsdzWJ4GOEDnh6fxDy
         c74o9WdnXfIkMcyzQMjeKakkHWjasqdacEsrmcWq7+FMo91CzXzGmzR9hNa4mRbPFS8t
         pdYxjQQDhBNL17oTFFfcGh0xXagoMWM/Kb1cG6FH/VdUbEI9u0GmoKgFJEJZfoK8NIMA
         5Hp/s+j5ImH64/HFsaMjE8XDHbSmrtoJ1dChEU0Ver5iFXAish8f1oeM6aGEF65Z1Pfx
         zf4LRlV2h7SsXqHNFysxmHBkfXbLAh0VaoAP7rJ+MqX4BNlKDgjdekT7bPVGFMXEBud3
         dYDg==
X-Forwarded-Encrypted: i=1; AJvYcCWjJrEFFguJWgG/976cPTW6XEZAeL/3SS0m0wBI8wOnvI6KVEUeRZ8D1XiXU7l6Y56PUv2KEBip8TZ6hSaaNye6UVcbnsQ5gabmTd+B250Bp7Nif0gsiA2plpQxXqljIf8ToQ/5
X-Gm-Message-State: AOJu0YwOXTB08FficwLIMggZ4HbvxAAl7OaH9zn+SDWZmsIAus/nZv3e
	WXm1VLX0EJjL/a+jFjv2zyEe5VIplVjK2e8yzS9EaIsAXXEX9IoP
X-Google-Smtp-Source: AGHT+IHWD1um2BUowidlofDpSxZfj8xYKp+CRjGeDqgTbblwe9Ky6W90AeAkY1dNe8jMve+kBHUVbA==
X-Received: by 2002:ac2:528c:0:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-52ce18350e0mr6588568e87.16.1719442958856;
        Wed, 26 Jun 2024 16:02:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3674357c1c8sm114843f8f.9.2024.06.26.16.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:02:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"justinstitt@google.com" <justinstitt@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 1/2] net: mdio: implement mdio_mutex_nested guard() variant
Date: Thu, 27 Jun 2024 01:02:31 +0200
Message-ID: <20240626230241.6765-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement mdio_mutex_nested guard() variant.

guard() compes from the cleanup.h API that define handy class to
define the lifecycle of a critical section.

Many driver makes use of the mutex_lock_nested()/mutex_unlock() hence it
might be sensible to provide a variant of the generic guard(mutex),
guard(mdio_mutex_nested) to also support drivers that use
mutex_lock_nested with MDIO_MUTEX_NESTED.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/mdio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 68f8d2e970d4..f13a02d05eb2 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -8,6 +8,8 @@
 
 #include <uapi/linux/mdio.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/mutex.h>
 #include <linux/mod_devicetable.h>
 
 struct gpio_desc;
@@ -25,6 +27,9 @@ enum mdio_mutex_lock_class {
 	MDIO_MUTEX_NESTED,
 };
 
+DEFINE_GUARD(mdio_mutex_nested, struct mutex *,
+	     mutex_lock_nested(_T, MDIO_MUTEX_NESTED), mutex_unlock(_T))
+
 struct mdio_device {
 	struct device dev;
 
-- 
2.45.1


