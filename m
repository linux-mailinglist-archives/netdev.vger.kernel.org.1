Return-Path: <netdev+bounces-104531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF590D14B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F1B26D43
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D41990C5;
	Tue, 18 Jun 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="O3yR47ZZ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCC157493;
	Tue, 18 Jun 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715892; cv=none; b=frKt/DbSjXgALjzMKd6QzczYVfbFVzR2ea2NN+gl9wXgW9CiNIUhGbe5TCfZqC/3MOqUrpbr+4Ml32QY6jVGl2GtqQvCV8PdeIsfgMyAbQdqe1sptQ6PcYyP9dJuoQUsIEtmsNHzsKEYJo4uVPxS8jVORmNjphNGAAxX01UARUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715892; c=relaxed/simple;
	bh=pTRWcYeQ/Qjey8SyqFLEGBXI9pzeAqd5f6ZDqSfVn9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mcc4qXhitiS1WoZWpll0PINb/+jr1JGI5pXl5sBJ7At2kOgJQW2WiSSz8t0IsRaNL7yJA3AD+Q+dbwUA4yeWAKZa0ZcbiVocGi6XyGOsfUEYgtyCUY9QyfL5r+cKtCWm/nt++7wi9Tehc3qqYMVSGi2qohRHDcaUWq+GK37UEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=O3yR47ZZ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 579398824C;
	Tue, 18 Jun 2024 15:04:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718715888;
	bh=t69zzJZDwGELaNEhVEfGmfOE2SSJ5q6M6ley+H5/T4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=O3yR47ZZ9lD+CROtump1UE863UaS5I97USo1udbjgPqVIKp2kgErXUdjb7UiYZ+zu
	 K0W6fqCVAmoyli8hkjUIJpCQFBmDzDt0siyb7qqtvAnOoiYBcbVPn69th1cYJk5wVo
	 igsWGGtOTDuSwNxhqzZH7RbKcJuu1zi/9ZDY+jeXBEwSdvHy6GaBqLCBNT1DYZhlHs
	 7mVa80EHqLPL4Kb4AIiPmgLUyijQ6F/KLDcmR1Fxz3EiChELpXhKWmYRS3tV4Ftj8t
	 FuuuV9eH67VoB3Ne9AjTbmcpc/IF8LWsthi11SnLJwk2Gee6i2LDVR1DoN7BWiIdC0
	 U3eO6OtY0EkIQ==
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW offloaded ports for KSZ9477
Date: Tue, 18 Jun 2024 15:04:33 +0200
Message-Id: <20240618130433.1111485-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The KSZ9477 allows HSR in-HW offloading for any of two selected ports.
This patch adds check if one tries to use more than two ports with
HSR offloading enabled.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2818e24e2a51..0d68f0a5bf19 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3913,6 +3913,9 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
 	if (ret)
 		return ret;
 
+	if (dev->chip_id == KSZ9477_CHIP_ID && hweight8(dev->hsr_ports) > 1)
+		return -EOPNOTSUPP;
+
 	ksz9477_hsr_join(ds, port, hsr);
 	dev->hsr_dev = hsr;
 	dev->hsr_ports |= BIT(port);
-- 
2.20.1


