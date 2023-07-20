Return-Path: <netdev+bounces-19397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27975A965
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F7B281D87
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04819BA2;
	Thu, 20 Jul 2023 08:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69F1774C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72910C4AF6A;
	Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841798;
	bh=uJJGrLInovzzXUd3VI0hpNZckJsauxx8iSDbPseYllU=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:Reply-To:
	 From;
	b=FQjplkSXI4rYDH/o89EgQWCh1w2hD+CFr3kaFZL9LbyZ6H6ZoV7LShCfj88Zl54un
	 GvAlyC7WCQKxzMmNKkb+P7B0o4NAWhx6DIuYUXkA9RTe4N8jgIW537NeURKzEcIsHr
	 iBb9MGfDnEC1J5Rkv+fR7d4Sr5cEyfNxlv88bdmSLcajj6Ktjkc432FHI61b2RhTpg
	 2o+vlMe31trs3LEKt0xLOAJAVEDSrA4a7t/q0ambP5MbPvz0upV9iRtwvt177WzEUY
	 oLBXuQLjOQn7lkOWl6LOqROGtSctXl7ODPoUfPJd9ONHIu32429EFpPBWD1OstD2A0
	 Qhr9l04QVwYeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60513C3DA40;
	Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 20 Jul 2023 14:29:30 +0300
Subject: [PATCH v3 30/42] rtc: m48t86: add DT support for m48t86
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-ep93xx-v3-30-3d63a5f1103e@maquefel.me>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
In-Reply-To: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
List-Id: <soc.lore.kernel.org>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Lennert Buytenhek <kernel@wantstofly.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Olof Johansson <olof@lixom.net>, soc@kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy@kernel.org>, 
 Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-input@vger.kernel.org, alsa-devel@alsa-project.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689852591; l=1084;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=ehFfMUFPSDk+3aqtlEGp6k1Cn9nX+Zuoc/v7Lg62J6w=; =?utf-8?q?b=3DQ238e2fSIiIG?=
 =?utf-8?q?4LxbRXPl9BVz0A7fMIFNSLQhjud/iwbjRvKKrpwpjnng97SWbloCe6t6MpeoXXkn?=
 jjZc3wP8DMKx8SCCQlCyET5yYeXmGD2ZrnAkJxVsc3NuIPs7VAev
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/rtc/rtc-m48t86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 481c9525b1dd..dd4a62e2d39c 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/bcd.h>
@@ -269,9 +270,16 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id m48t86_rtc_of_ids[] = {
+	{ .compatible = "st,m48t86" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, m48t86_rtc_of_ids);
+
 static struct platform_driver m48t86_rtc_platform_driver = {
 	.driver		= {
 		.name	= "rtc-m48t86",
+		.of_match_table = m48t86_rtc_of_ids,
 	},
 	.probe		= m48t86_rtc_probe,
 };

-- 
2.39.2


