Return-Path: <netdev+bounces-157466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AFA0A600
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083853A879C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6661B87CC;
	Sat, 11 Jan 2025 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaAypScZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5E1B6CEF
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736628624; cv=none; b=awlmJ8h5eLEda2SaA7LCI9ywWysGKeBj7pjOUwvG3lyjjOPdWJZl7KF5vTaj+9nYye7/kXjzOCdyT3WaHD54Y/TSk0BfPVyuQyGyLcRmVSn3zr9eyFOlXrlW4LQ43BM3bq9EB0ZWX51pMt6Zg+Xhc0qIo6dwHokHkPX+8dT3fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736628624; c=relaxed/simple;
	bh=edpmv2FwTztCD1oIPx8saHsUEOhYhdIvpw5OWKKzrqc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tIu9P4XlWu6ad7dWEIe3/sKZYIyILrZln8BK6dRvGVrvdpFUWqOQsSG8QJa6bB99yx275wV89/6gQHB+L1qdtico+xyxweT0n7nYJZD7cFVjWDBV00jlVCsLzHnQjrT+GEHBSSAc+tRiXOFJg/3tK3HqNYU9ILaiUE4gx233wso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaAypScZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e06af753so1675931f8f.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736628621; x=1737233421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WCw+wb/aBZTJa4PZYVAPx4v9UQv1Is9cJGEhTYrF3YM=;
        b=eaAypScZ9tpm+R75X1bVQNLQOBfmnAQX/v6+ZiiYmIy+SvL/r7nMdyCWvkLUwGlA2J
         W17JXg5xhhDKR3lLMoYIZSJtlRyL4HRQxr9CHEmbTN9iZPPoE6fMneQx0qgg3Vx5xyn7
         O0LIbdNq3AtQFqOjtLXlMH96IfhbVXMFwbOeRz3KXEfhewXXfvOBenQ/1ad+DlHMgSAX
         tXxcA21mh02IDZT3GESg8w9rKflwGWveK9hLuD+yEnqmsLe+bEUR++jWsfwvNz7XlOfh
         h17fcSMKegDdDKvi6WQ/nxfmkALZ2S94HE4pa6nL81oPXTBSHbREUZUdmP42gRKOO78k
         jI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736628621; x=1737233421;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCw+wb/aBZTJa4PZYVAPx4v9UQv1Is9cJGEhTYrF3YM=;
        b=WIp4Dq/hopy1vgUjXRRmieqB+ktLtkAjwffiWSDkWPnhq+Vve14QKNmMsRS3v3CAVT
         VvZqwPlSrT55N3LaaLHoOHXJzAvxdIFCmoqmjGkZy5LWy5iQp5erprVFPU4pti4b539B
         gD9VJ6gVgE7kU044Cl2rDeh0kfyIPVoSdOTL6mkRDPlEKpdHcTFnH+vJ6UJukXm07vwc
         Iv/dRVLEcIRPltB3dtmWnjB3JjIx/Fgi4vFWEwXre5YN7u3Xsgh4CodiKOsG5uzRppC6
         jlBlISmSz05ht9gXamJahx1AOXD3Jn32KXE6p/OI2T4KN0MJ0MAuNci4qa2jwv3SLX8Y
         FqVw==
X-Gm-Message-State: AOJu0YyT7nLl/Sp01Fhzc/MhmjCyQZEg+5xlbesQ6JQjzwcM3UebPZhr
	BIoML4qFLb6PePJ/lRtBlqZ7HezSbbahEBDZFc9hYFwlnPAOjaI9
X-Gm-Gg: ASbGncu+87XxQamniP4DB6ukojBsYeqixNHjrsMugPIiF4RXG5Lx47zknzgvgJGWaUq
	1fxNY/jp6PEPV/cL5eK1Sg5IZv5PHhTLxIkfHPfcU0rZOHMGvo+GrWDPvVujKJSzJn92wOMC+DO
	fMBcRBNa/dqXc59iV879SOq6xrGxV4l4m4EOhJmLQ0bGh0VwTD617xMMGkMhyIUsqnk/6aHTsjo
	RGVzaoTtTzKG9hc3TRr52pVbapSSkTq1uhC87qP4pjN/b0u5+wxFvb3fBbgVzWNo1+e4XApS6pr
	BaSJDHyiGwZgBcl10byU08dYYx4AeeOHbNjK5XuELCD6YVWSprJnqQZW8toA3HMp1m4ibuWV3gD
	b1Ro0gXk6suykLkgz4u4JqDTIiM7po7NmPcdX1zHI5vVCp52m
X-Google-Smtp-Source: AGHT+IF4rmsM6QExNMO/BiyBrvn7TJGX6algQIlJJF68pR1CVBAHX1w4c0FGcp9tBn/o/rrsFGA13w==
X-Received: by 2002:a5d:6d8a:0:b0:386:4034:f9a8 with SMTP id ffacd0b85a97d-38a8733693fmr15330457f8f.38.1736628620784;
        Sat, 11 Jan 2025 12:50:20 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1f2esm8065589f8f.98.2025.01.11.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:50:20 -0800 (PST)
Message-ID: <c566551b-c915-4e34-9b33-129a6ddd6e4c@gmail.com>
Date: Sat, 11 Jan 2025 21:50:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/3] net: phy: move realtek PHY driver to its own
 subdirectory
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In preparation of adding a source file with hwmon support, move the
Realtek PHY driver to its own subdirectory and rename realtek.c to
realtek_main.c.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Kconfig                               | 5 +----
 drivers/net/phy/Makefile                              | 2 +-
 drivers/net/phy/realtek/Kconfig                       | 5 +++++
 drivers/net/phy/realtek/Makefile                      | 3 +++
 drivers/net/phy/{realtek.c => realtek/realtek_main.c} | 0
 5 files changed, 10 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/phy/realtek/Kconfig
 create mode 100644 drivers/net/phy/realtek/Makefile
 rename drivers/net/phy/{realtek.c => realtek/realtek_main.c} (100%)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index dc625f2b3..e043d3ef1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -350,10 +350,7 @@ config QSEMI_PHY
 	help
 	  Currently supports the qs6612
 
-config REALTEK_PHY
-	tristate "Realtek PHYs"
-	help
-	  Supports the Realtek 821x PHY.
+source "drivers/net/phy/realtek/Kconfig"
 
 config RENESAS_PHY
 	tristate "Renesas PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 39b72b464..c8dac6e92 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-y				+= qcom/
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
-obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
+obj-$(CONFIG_REALTEK_PHY)	+= realtek/
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
 obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip.o
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
new file mode 100644
index 000000000..5b9e6e6db
--- /dev/null
+++ b/drivers/net/phy/realtek/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config REALTEK_PHY
+	tristate "Realtek PHYs"
+	help
+	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
diff --git a/drivers/net/phy/realtek/Makefile b/drivers/net/phy/realtek/Makefile
new file mode 100644
index 000000000..996a80642
--- /dev/null
+++ b/drivers/net/phy/realtek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+realtek-y			+= realtek_main.o
+obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek/realtek_main.c
similarity index 100%
rename from drivers/net/phy/realtek.c
rename to drivers/net/phy/realtek/realtek_main.c
-- 
2.47.1



