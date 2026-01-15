Return-Path: <netdev+bounces-250199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFFD24FC2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04E0330096B3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498F3815FE;
	Thu, 15 Jan 2026 14:38:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0637C0E4
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487901; cv=none; b=ExASLD/IjP/b9rI/HEOfqv+4s/+Wa8ap1xoWZ6Qopof/gj5xn/pgYHRDXJeKDC953SHjFfEluUbnyaMOYpJEkqG2olwg3v3n24DnLl2vXF0MIyM3kWcUgS/CWI6Kv7X+59EpmjwOtxr1/ko+sTklo/764f+SeaOedYW46JhQLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487901; c=relaxed/simple;
	bh=ho090fN91gnMOR0nUR4Y+EcFIXlQvnkEfyY6PgYidL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECW8eKBtOjiIfre2j6iLyx01/OpPk1C0bBY2UyvkCy130AI/iXx3DMnOS/KboDuJnKIIO/4j3pQOfVkorE2tfjN2boNK5xoNWcPomIVK7Vzfa27cCT8UGb1LQVVujrwh8qPrjl4jU06CGpet4b4hYzOskpNVwgw9Q1DXTpKcQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4042f55de3aso640064fac.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487894; x=1769092694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxQOvp3FO/FV+ivIiwVToR8TzMNrudoK/UpMDqV1B+s=;
        b=ChUXW86/bIlPW33W+wBRUI6GPZuiAQ45XAo1sObTQuXfo4lCEyjFiO1xcbX+JQwS+o
         yEwTxdhV0FDwvWX/8K01BnlRDe0QoXDK3gMPt0Tb56RF18WjXMt6+/Wg72I8ctqzuNwf
         e8casopoEI8ERMZYyMX4QOzMiKk7H51Fjze75rqOU9TlC/5YXQZbke7NTmf2ouzVmFWQ
         KaPPJz0/JOgh9mojI3h0Qbf0sMO7MkRHi9TS46ESf8cc2ev+eRWFsnZuwjaFo/aUvWl+
         2OJpELFENTkrix2ifxqZ+3t+kzSGoJWPf0KTAZXfCQKiqRgUeVdsr1o6ZtaZDsN0IqWT
         BXUQ==
X-Gm-Message-State: AOJu0YyI+lAa9DWRn0szQ1P757NUTpRk1rui/hC43zgySoTrTtl9yCRQ
	jFN2b+17fDGqOkag2eKOrw+0c+kaz6GsN851IRMGaQPlde5JW7AxMxnd
X-Gm-Gg: AY/fxX6yWY7bgqd/DRDLYPxVNejZ+HHZ3DytQqceG2cq7ykPPLIpN7cwHudP6tsQXE5
	cgzGMHJcQ/YfcTKaNel3J8tkJBVB81XRRlG91MFxwipf0ISxnSOdiRXuR1G95QrQyJgNHM+atOT
	T8QHpfkOGOuWVM5Is/MmX9ZtZfgZXKzFySBmBhFXVtF42vFZ9HGdC5HGEDhVdr5MYqDUM024n4l
	gFxZT1R4/X79qZesl8DMH33GJz/fGKVIligHT9x+UmM9h49T9OGNqEDWlgsIy6pSYwCi8tMFl/D
	Sdb3Bfaf1XqQVEIwuRfHnU2tuFzDAVnJfbmZEM/sf37e54iFfnzBYK/GUx+EqzMWJmLyVdrmLcI
	tYbZ7tlAcoP1Us+HxpNHGQJKJ6jxz5xLDNQ8W87Dt9RZjPlti3fRAhxHSq7FWHS00sPwJ7Oa0Mb
	pX7A==
X-Received: by 2002:a05:6870:f10c:b0:3f6:1e6:d0dc with SMTP id 586e51a60fabf-404291e9118mr2182430fac.16.1768487893377;
        Thu, 15 Jan 2026 06:38:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40414c5d332sm3357458fac.20.2026.01.15.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:48 -0800
Subject: [PATCH net-next 1/9] net: benet: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-1-b3e1b58bced5@debian.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=leitao@debian.org;
 h=from:subject:message-id; bh=ho090fN91gnMOR0nUR4Y+EcFIXlQvnkEfyY6PgYidL0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvREfl1vVTFd9VCzNZLXGv4qdGXI1B9s775w
 CRZVlDxz92JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70QAKCRA1o5Of/Hh3
 bRjCEACa04xXzzhEph5wulMAMymz5V6/MzKrLa6K9yiJeFzArG7sXYRape5HeOReDq/e1HtKQOD
 U5MlsKbmvFNXwZ0RU3HbBarbRX/r71YAnp2Zi+LoQVbMmifAyizczt9GzkEnWCVMKtvrd4M0Gpz
 NKSJQVdwgwAXY7LucPNj7NgoP7eOpYo7uL5iWWlDWb5ZueFIkU3eNQhPUmQFm9hdke9eGtZBif0
 qRND+fwHDtZt/96hhvbByIcXEuK54DdcIa2UsGU45hQYBSfSauFX0dOuwkI4PIwpVpfIsA73ZF3
 QHj2c1fD5a1B+Op7EEgmkUkBOnr2VXcB3nupJr42Q0lF0hQ2Kb/+V0o8ZqUstXEHhOFL8/cXHtc
 l1s36gb4ruqXR4UVMgHIY2/YvCJ1kVBwmU4n0Y7iPkPH2AuYACRrH4sveEATGszfob5/Yj8DFxJ
 QbRzhTDaXCMTCPcgBLOwTpJOXmqwPRvI3Ml2OwpHl+xxw8YEM/HrGy3+7Rgc5n7HERJp4knxX6u
 lr5QlKFLr1F11yTZdvdTrfamoTW1d/xJnZ2lu+74x70tKhKzv/6WycPoiG0RPm8BL0Wvi7ylid1
 AaM5Q7zzsvcp88wLuZ7mZvtsX6k8Mtou08w2vVmA1wxAFiNysONe64i/DYxl9+AS98kdSD/LFv9
 7Ro847D2vuFjy1w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by be_get_rxnfc(),
remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/emulex/benet/be_ethtool.c | 31 +++++++-------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f9216326bdfe..4717a1dacbe2 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -1073,6 +1073,13 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
 	adapter->msg_enable = level;
 }
 
+static u32 be_get_rx_ring_count(struct net_device *netdev)
+{
+	struct be_adapter *adapter = netdev_priv(netdev);
+
+	return adapter->num_rx_qs;
+}
+
 static int be_get_rxfh_fields(struct net_device *netdev,
 			      struct ethtool_rxfh_fields *cmd)
 {
@@ -1117,28 +1124,6 @@ static int be_get_rxfh_fields(struct net_device *netdev,
 	return 0;
 }
 
-static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
-			u32 *rule_locs)
-{
-	struct be_adapter *adapter = netdev_priv(netdev);
-
-	if (!be_multi_rxq(adapter)) {
-		dev_info(&adapter->pdev->dev,
-			 "ethtool::get_rxnfc: RX flow hashing is disabled\n");
-		return -EINVAL;
-	}
-
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_qs;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int be_set_rxfh_fields(struct net_device *netdev,
 			      const struct ethtool_rxfh_fields *cmd,
 			      struct netlink_ext_ack *extack)
@@ -1441,7 +1426,7 @@ const struct ethtool_ops be_ethtool_ops = {
 	.get_ethtool_stats = be_get_ethtool_stats,
 	.flash_device = be_do_flash,
 	.self_test = be_self_test,
-	.get_rxnfc = be_get_rxnfc,
+	.get_rx_ring_count = be_get_rx_ring_count,
 	.get_rxfh_fields = be_get_rxfh_fields,
 	.set_rxfh_fields = be_set_rxfh_fields,
 	.get_rxfh_indir_size = be_get_rxfh_indir_size,

-- 
2.47.3


