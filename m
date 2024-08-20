Return-Path: <netdev+bounces-120226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DBC9589CB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A335B22465
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE998196D81;
	Tue, 20 Aug 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="abjCqBhN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C084194A63
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164591; cv=none; b=Bt7eHwrbD0tyO8qKEEXfLxSZzLOOXbKgUOc3y6lpObpqWlY8ePDAIxNRwCUITfAFJ8SuVYPaM9BoXMlW65bIVyqFnTV6HnK1/Zc8p5iLDy/4UiGJhkLcfiUp4Tg3wj+Ko7nyxHcVVihBXj72jxHhJ7oEEJTohDJQCzGOeNp4F98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164591; c=relaxed/simple;
	bh=Q6R9U2wwjRGJjT5siTyo6sy0eGbv+3Ifx3BfFPK57EU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4ZnJHJCJC9AxbelQqxDsRBJGbaeXbn+8VCjZDDctAGQ/FdzUzS/tWYd1pmieV/+NFm5rJdmNj/cv6J6Q8r96Mqx+sJ96Vw3p9Sz83XGbgoa1opTborUvlCbfpJUAeKOyc9aiRePpudS3DyzUarWvB0m95x/SQ20YttAoITHjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=abjCqBhN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso673530666b.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164582; x=1724769382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3sdpe2m8go7s6MzsbiOy00prukC9EPV/V3TgS4L+Zk=;
        b=abjCqBhN9JcV3aAp/4kBz519k9HmAKKBhS6su8HM9Ts439P3g1ktCQZbVKs4p7RVjo
         0yvGsX/whrdo1IEyRsjUklg0rw2RWL8Jm5KdVj5fRmisirBlt1J3sM4NI7JgWseL7msT
         ZLooCSWNCDpw+Lk6ILwAd6ykdv2u8MnhzBkoQ7+RJJPvOOzf9qDh46bVyYskc7zLtZbX
         cZcX+TqxVjQvAaFM/U2ApltikF4hsngyvU2GdoQI35tgCbwuK+JPokgWw5EPoq+pCQCd
         I22aCm1e3Q4gOksHNzeLN138CGkJrTAJxr7d89PloWMkhMv3uFGtG/1mNYxVj3crlZdb
         T36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164582; x=1724769382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3sdpe2m8go7s6MzsbiOy00prukC9EPV/V3TgS4L+Zk=;
        b=CpFgRJIZicp7yDgA9GV+CfugmHTs3DAVfHUC4GqgoIC3yTlpAzi9gtWdTWJy+tSVjo
         Mwbj51otayxZxT1y5RoUvcOeV1vYR8iDYHbyv5/H1NTjF0FlHGH7/W0UvYNhAGXIJ4l1
         s7v4I9AMWNsQDRKrU9i2pqrWObohrJuiFEXhuKQ4T24sQEDTHQ/qbQ9l9iDu1d6fCCID
         HrI/pjc/TP7MgYe6Gf1uXL8jfWB6OtlgVa9fgnHplvYZ28cb0Hmvi8Br6tdyj+OC91S9
         UuvlNYlSntIpbJ2//5/yy3OLcpL4bJj55Cbe2qw+KgZvSCCXZVAQaphjIJyy6m3bXB5j
         Rrlw==
X-Forwarded-Encrypted: i=1; AJvYcCX7/3/Ey5L+lGr7Q5uLGha/vbv+97cn/hzYQmr/DRlVbdcFWejEsUYbbcWY0YJ8Ij+I7j0ycdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2DfeIE1rt4iZ8S4qWZOleFhT2ZGq+hrrVe87p8eBjdIgiyl3
	7UUblsBvCsO8NX8buZRjfF5iOuOUfRgqj7caXjHucAAup8XiD/xm9GvmGbB+j3k=
X-Google-Smtp-Source: AGHT+IG9Vpky2GjCOVlioKfXhshYz52MMh4ZHZ8WHnYAFH9VH4UyOZxDKK3tHaYNMdW7W7wK8SqLMg==
X-Received: by 2002:a17:907:e258:b0:a7a:9954:1fc1 with SMTP id a640c23a62f3a-a8392930b83mr1048045766b.24.1724164581785;
        Tue, 20 Aug 2024 07:36:21 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839472afsm776558166b.175.2024.08.20.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:20 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 09/11] arm64: defconfig: Enable RP1 misc/clock/gpio drivers as built-in
Date: Tue, 20 Aug 2024 16:36:11 +0200
Message-ID: <7ec76ec9b10ef1d840a566dab35497bf2d40b437.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select the RP1 drivers needed to operate the PCI endpoint containing
several peripherals such as Ethernet and USB Controller. This chip is
present on RaspberryPi 5.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca64996..e7615c464680 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -606,6 +606,7 @@ CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=y
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -685,6 +686,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=y
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1259,6 +1261,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=y
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


