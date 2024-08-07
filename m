Return-Path: <netdev+bounces-116360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020F94A20D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE4CB21120
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106891B86DC;
	Wed,  7 Aug 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8MipSkl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F078F77;
	Wed,  7 Aug 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017302; cv=none; b=UR8KOwFbWuT2X3loUZ7q4XXq+++fKbKR+ANWvQjSfgZi5YAXrGb/m9Pb5V7cMSGOyOt0EjPy/H1eKHLkD1ID/uBFQjzbIyxuPgDPZJo2cNTS+w67ErtMGF+AfdRipwW7paY7b8Vbk0wtW1ncmzDVwFbZpGQL/FXgdfKwTcTGRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017302; c=relaxed/simple;
	bh=tbSVvBJrKpKZYHMMO3k9qkkDhVu+yFSA902cq6e8cuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIvOE4qYc/HRopYzqeQMFySVeF6D7Q/Q3CBMLnMseYLx4ietQpwT+QXBgMl+AYqiCK2ZX7sjd8+LJ9DqLw7xHvpmY7hvD7SfzmALbLAkWou8w6T0AlY0NItiSjE4fM0lvUHszdFxM4957BfqJOgcfmVWe0oHEWNOKnbjfwFhm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8MipSkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDA3C32782;
	Wed,  7 Aug 2024 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723017301;
	bh=tbSVvBJrKpKZYHMMO3k9qkkDhVu+yFSA902cq6e8cuA=;
	h=From:To:Cc:Subject:Date:From;
	b=r8MipSklzXdqHEJmosIKpVi7oI0cQaqmTpkqsGa2JduhLM1aqV1Esspf0MHeRzFAt
	 Dyl+mufOx8j19bhXcKAVe7vjACW1fYDidRR7ZbHB8ddoeCuHlP5I4T/5g6zIlKPJuG
	 NsXCozjZKtH9fpV15u9unHsXrPA9iT9ZAy9kFNQqwTuYuCMYXPi9lvXD1gUOHq6fJF
	 TBgs1E7w9YwcmQpHKEP7DrKhmZxgM2W5GzULStQx1n/rLVuUC01S3evYhxR4KRQKom
	 X3eGy/DwOnLwNy75F5Of50CSWxdMrBK8pVThWMmk3ZdJ6W8ad4ZyxP+qdhN99rNt3k
	 rbnPYYppqWoqQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: pse-pd: tps23881: include missing bitfield.h header
Date: Wed,  7 Aug 2024 09:54:22 +0200
Message-Id: <20240807075455.2055224-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using FIELD_GET() fails in configurations that don't already include
the header file indirectly:

drivers/net/pse-pd/tps23881.c: In function 'tps23881_i2c_probe':
drivers/net/pse-pd/tps23881.c:755:13: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
  755 |         if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) != TPS23881_DEVICE_ID) {
      |             ^~~~~~~~~

Fixes: 89108cb5c285 ("net: pse-pd: tps23881: Fix the device ID check")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/pse-pd/tps23881.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index f90db758554b..2ea75686a319 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2023 Bootlin, Kory Maincent <kory.maincent@bootlin.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
-- 
2.39.2


