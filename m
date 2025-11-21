Return-Path: <netdev+bounces-240653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ECCC773CF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 13E5B2A997
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCB21B192;
	Fri, 21 Nov 2025 04:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AC18027;
	Fri, 21 Nov 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763698826; cv=none; b=s52V896X+DG490URIU+RQiPrbFslywkx/orIqcYLyXa5Gt9zJb/mbPaz4N04IKd2PL/y+dDIFha+//c7X/1EFBNnWFTC79MXIiUI5MVwmK4Ab79mMBps/9+6bZ89VJFuTVHbyuED62CKvQR/UqvqXyQO/oBPYTrM+Lsodkqbd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763698826; c=relaxed/simple;
	bh=ze+Col1kzZsA06s1KfL4MGKROI5287e0adjn27c6gSY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uEcCgIrnM/6SJGq5cwmdh5mRwyv9+Xk0G/01VsHp4niUe23cQzLokLF/I+HLh0YXvP1EPCmHMwu2QkxDlyouQMkvcmqM8D/aafCWL20EOkOouXuKgCql7EI9gS76yYrcpEdR0ToXWaLBTzrLs/ikpa2UjBiwAcqZ5MraNmklsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowABn79Fx6B9pMQKAAQ--.11720S2;
	Fri, 21 Nov 2025 12:20:10 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	o.rempel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: microchip: fix mdio parent bus reference leak
Date: Fri, 21 Nov 2025 12:20:00 +0800
Message-Id: <20251121042000.20119-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowABn79Fx6B9pMQKAAQ--.11720S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUKw1rXF15Aw48AF1rXrb_yoW8XrW3pa
	1UuF98KF4UGryUuan7ZF18ZFyYgr45t3y3GFWIka9ayrn5Jryjya4fta42gF15GFW3A342
	vrs5ta18uF98ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnyxRUUUU
	U
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

In ksz_mdio_register(), when of_mdio_find_bus() is called to get the
parent MDIO bus, it increments the reference count of the underlying
device. However, the reference are not released in error paths or
during switch teardown, causing a reference leak.

Add put_device() in the error path of ksz_mdio_register() and
ksz_teardown() to release the parent bus.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 933ae8dc6337..49c0420a6df8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2795,6 +2795,11 @@ static int ksz_mdio_register(struct ksz_device *dev)
 	}
 
 put_mdio_node:
+	if (ret && dev->parent_mdio_bus) {
+		put_device(&dev->parent_mdio_bus->dev);
+		dev->parent_mdio_bus = NULL;
+	}
+
 	of_node_put(mdio_np);
 	of_node_put(parent_bus_node);
 
@@ -3110,6 +3115,11 @@ static void ksz_teardown(struct dsa_switch *ds)
 		ksz_irq_free(&dev->girq);
 	}
 
+	if (dev->parent_mdio_bus) {
+		put_device(&dev->parent_mdio_bus->dev);
+		dev->parent_mdio_bus = NULL;
+	}
+
 	if (dev->dev_ops->teardown)
 		dev->dev_ops->teardown(ds);
 }
-- 
2.17.1


