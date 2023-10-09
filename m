Return-Path: <netdev+bounces-39255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E247BE813
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD7328194D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524F38BD6;
	Mon,  9 Oct 2023 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkDhsBMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994EBA53
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C22C433C7;
	Mon,  9 Oct 2023 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696872688;
	bh=PakgZLNGLzXC+87Hq9LZSbho3Y+2lz8rmGoxLVl+4GE=;
	h=From:To:Cc:Subject:Date:From;
	b=KkDhsBMFnsoUmGCrn712KXCDmMDgE1hE5B3lbUE2Fsen4OipNHv/pqBfvM5Fq06lx
	 Dhj1NFjAtuEYg3IjINbIMpp+663FtqHbjdljWnQ01a+ESBpVvmYxtDhDz78GXjBwqq
	 f7uvb9WWeVW/ga1laT9sqSsNAvAMCEyzpS9LB+pR8K6lgjMM5kmTybdr1YMw3x1+mt
	 oYExEqK/pTmng0ahA/9o0QT//A24NcvGWfyjJ9QksjB5dvu/CMb+/wgc+2K0oH5f1h
	 55d0XL2J27RozOgmnKsjOD+tpO9QmiOBy3MuwmojhhVFl2ofuGJHySvTTvyyH6p5aD
	 1pNIhjZ7DAOYw==
Received: (nullmailer pid 2504790 invoked by uid 1000);
	Mon, 09 Oct 2023 17:31:26 -0000
From: Rob Herring <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: wiznet: Use spi_get_device_match_data()
Date: Mon,  9 Oct 2023 12:29:00 -0500
Message-ID: <20231009172923.2457844-5-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use preferred spi_get_device_match_data() instead of of_match_device() and
spi_get_device_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/ethernet/wiznet/w5100-spi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100-spi.c b/drivers/net/ethernet/wiznet/w5100-spi.c
index 7c52796273a4..990a3cce8c0f 100644
--- a/drivers/net/ethernet/wiznet/w5100-spi.c
+++ b/drivers/net/ethernet/wiznet/w5100-spi.c
@@ -14,8 +14,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/of_net.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 #include "w5100.h"
@@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(of, w5100_of_match);
 
 static int w5100_spi_probe(struct spi_device *spi)
 {
-	const struct of_device_id *of_id;
 	const struct w5100_ops *ops;
 	kernel_ulong_t driver_data;
 	const void *mac = NULL;
@@ -432,14 +431,7 @@ static int w5100_spi_probe(struct spi_device *spi)
 	if (!ret)
 		mac = tmpmac;
 
-	if (spi->dev.of_node) {
-		of_id = of_match_device(w5100_of_match, &spi->dev);
-		if (!of_id)
-			return -ENODEV;
-		driver_data = (kernel_ulong_t)of_id->data;
-	} else {
-		driver_data = spi_get_device_id(spi)->driver_data;
-	}
+	driver_data = (uintptr_t)spi_get_device_match_data(spi);
 
 	switch (driver_data) {
 	case W5100:
-- 
2.42.0


