Return-Path: <netdev+bounces-25569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1E774C5B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5469E281852
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572AD171B2;
	Tue,  8 Aug 2023 21:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E2174C1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:06:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203ED5A74
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zXQU5nftJUwqDXbgW7ERPV1vkM/LkTMl+b3TCckj99o=; b=ab84kOno4qIrJvOJPOcYfDc/FK
	nD/SaSkvV4Q4rXmX53vKCj5gNcKvaZx061z8jhMwYpCtk30eGeH1+t7MWo+pgBJQTx5I0gMjSXnMr
	L0krI/k56GMoWD+prgQ9T3AspCdH2+GbMHQ/wMpJxedObwhvyKbe1QNOlSRFkLc878/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTTsw-003WGb-Uh; Tue, 08 Aug 2023 23:04:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 4/4] leds: trig-netdev: Disable offload on deactivation of trigger
Date: Tue,  8 Aug 2023 23:04:36 +0200
Message-Id: <20230808210436.838995-5-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230808210436.838995-1-andrew@lunn.ch>
References: <20230808210436.838995-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ensure that the offloading of blinking is stopped when the trigger is
deactivated. Calling led_set_brightness() is documented as stopping
offload and setting the LED to a constant brightness.

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/leds/trigger/ledtrig-netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 3d215a556e20..42f758880ef8 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -595,6 +595,8 @@ static void netdev_trig_deactivate(struct led_classdev *led_cdev)
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
+	led_set_brightness(led_cdev, LED_OFF);
+
 	dev_put(trigger_data->net_dev);
 
 	kfree(trigger_data);
-- 
2.40.1


