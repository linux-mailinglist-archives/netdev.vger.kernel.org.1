Return-Path: <netdev+bounces-134580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9C99A416
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9231F22C89
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56520C470;
	Fri, 11 Oct 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN7kDlm/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B051BE857
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650463; cv=none; b=PoruadiHQWhW1bIWxWtGMaufMz9RSDwnTYSsBvFHNkTDx1W1SpwybZA3bebXBhYhu02w6CXZ/pS/Ss7WAyQ4DLv6hLkKgI6+k7hgNDhoEiM5IAGzPDwl4aSsytonkR9c9tVeY2g1c/VS2fXHU3QD4O2fjJxX2GXJ5PSIJTGpKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650463; c=relaxed/simple;
	bh=03qUdkV7dQjNZlV4Qwk4y2Hey13QcB/7p5Lmnsm8hl0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WyJvAcIPNJ+4PGzZTN5k55d1GbyLQPvgKmUDtpKCAFBsvgazOSNmPMQhHLzXTxGPrA3dZxTslvvoetz7FNv/FdijJvM3/qBPQABNbwWG6KcanBMoD9CQBhtfolVcsvudwtzmC6RSa4LTxHZIowifNZ09ShVruWSuVECTHTp7xzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN7kDlm/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9977360f9fso268624266b.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728650460; x=1729255260; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzkMRpIEVAFDCaGxuwOV0xI2CkUbjyWzRopUv1q7gB0=;
        b=eN7kDlm/AhyejEtu5xJVNXZ9QGbfFOZYenqBpGhc2ugi3fW80KgPo6/tFwRk03J6Fd
         UC9UgAlNEnAZ2y9G88nZ0BGcKxTuKYz9NTFZ+tOX/YDKohlW/GKVY01KjwEP8r1LPXBw
         2CQH0g8GNrWqA/TPWu2gZZ1z78GK/+SUifO1O2QlkYqbX4JW1wHsF202UZIux43ZUMyA
         Rs1xrxe6PPNf/UDa/sXsSuOSVrgoASEZGLEY13sfU1XuKsD8RjvxpgvfRtvLw/wM4xnf
         OyEF1xrnGSAmr9e5CQqIgwvsSW2UdZcbAPVdpJwq7y8WOFvBpH80PWVWaYZ4b/WB5MQP
         B1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728650460; x=1729255260;
        h=content-transfer-encoding:subject:cc:to:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzkMRpIEVAFDCaGxuwOV0xI2CkUbjyWzRopUv1q7gB0=;
        b=KMoRdXaIqFBLvWw8VMEMeJgMyDq7cJ0oMNg5aHkULclBK6pgusObEkANYQJgWG5WNK
         hvKnKPztp0rQtsgosRupo12aGZ8UnJ6Kof6i7UEovotBuYNI8sdmCs1T1AP5H0kChX6D
         ws52DBD5+YBwVvPsQ4Q0zNav/XPx9kSSQU/Dr0a53HN88rcFEB0pZdYWvo+jiXcjN70Z
         UHAXWVvF8PvNtmjWzDDLd/qJfcF2Z8tib2UfvdYcO5CTU9DnP5kAnv+C5RgiRrywukc1
         Z1dAMZl5BPtr9ebpp45hAClcMz7C48VFTad8Kpf8aGXgGAGfoo1W+t/QR7pBWuAP3nJR
         0Gzg==
X-Gm-Message-State: AOJu0Ywcb9Q6kMtfmSEHgCQo3mIBYd9jcLydDSNdz8tX9A0kK068X4bb
	Tg/k7kDf20ALs/nr71j3eFukqA40WNsFtVjqAJBm/Kr017IUPkUT
X-Google-Smtp-Source: AGHT+IEg1HjY+Tap+MkrK8JKRkLvaHcOLhLsBV30435rp7apR1h2VC64sQooS84EoKy4UT/dVqVepQ==
X-Received: by 2002:a17:907:efde:b0:a99:3f4e:6de8 with SMTP id a640c23a62f3a-a99b966bddbmr204721066b.64.1728650459646;
        Fri, 11 Oct 2024 05:40:59 -0700 (PDT)
Received: from ?IPV6:2a02:3100:afd7:9a00:c812:cea1:cecd:d47e? (dynamic-2a02-3100-afd7-9a00-c812-cea1-cecd-d47e.310.pool.telefonica.de. [2a02:3100:afd7:9a00:c812:cea1:cecd:d47e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99ccb76c26sm20527566b.45.2024.10.11.05.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 05:40:59 -0700 (PDT)
Message-ID: <a3b9d8d5-55e3-4881-ac47-aa98d1a86532@gmail.com>
Date: Fri, 11 Oct 2024 14:40:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next v3] r8169: use the extended tally counter available
 from RTL8125
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The new hw stat fields partially duplicate existing fields, but with a
larger field size now. Use these new fields to reduce the risk of
overflows. In addition add support for relevant new fields which are
available from RTL8125 only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- added code for enabling the extended tally counter
- included relevant new fields 
v3:
- fixed a clang compiler warning
---
 drivers/net/ethernet/realtek/r8169_main.c | 40 ++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 1a2322824..8d869f757 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1777,11 +1777,26 @@ static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
 	"tx_underrun",
 };
 
+static const char rtl8125_gstrings[][ETH_GSTRING_LEN] = {
+	"tx_bytes",
+	"rx_bytes",
+	"tx_pause_on",
+	"tx_pause_off",
+	"rx_pause_on",
+	"rx_pause_off",
+};
+
 static int rtl8169_get_sset_count(struct net_device *dev, int sset)
 {
+	struct rtl8169_private *tp = netdev_priv(dev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return ARRAY_SIZE(rtl8169_gstrings);
+		if (rtl_is_8125(tp))
+			return ARRAY_SIZE(rtl8169_gstrings) +
+			       ARRAY_SIZE(rtl8125_gstrings);
+		else
+			return ARRAY_SIZE(rtl8169_gstrings);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1873,13 +1888,33 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
 	data[10] = le32_to_cpu(counters->rx_multicast);
 	data[11] = le16_to_cpu(counters->tx_aborted);
 	data[12] = le16_to_cpu(counters->tx_underrun);
+
+	if (rtl_is_8125(tp)) {
+		data[5] = le32_to_cpu(counters->align_errors32);
+		data[10] = le64_to_cpu(counters->rx_multicast64);
+		data[11] = le32_to_cpu(counters->tx_aborted32);
+		data[12] = le32_to_cpu(counters->tx_underrun32);
+
+		data[13] = le64_to_cpu(counters->tx_octets);
+		data[14] = le64_to_cpu(counters->rx_octets);
+		data[15] = le32_to_cpu(counters->tx_pause_on);
+		data[16] = le32_to_cpu(counters->tx_pause_off);
+		data[17] = le32_to_cpu(counters->rx_pause_on);
+		data[18] = le32_to_cpu(counters->rx_pause_off);
+	}
 }
 
 static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
+	struct rtl8169_private *tp = netdev_priv(dev);
+
 	switch(stringset) {
 	case ETH_SS_STATS:
 		memcpy(data, rtl8169_gstrings, sizeof(rtl8169_gstrings));
+		if (rtl_is_8125(tp)) {
+			data += sizeof(rtl8169_gstrings);
+			memcpy(data, rtl8125_gstrings, sizeof(rtl8125_gstrings));
+		}
 		break;
 	}
 }
@@ -3894,6 +3929,9 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 		break;
 	}
 
+	/* enable extended tally counter */
+	r8168_mac_ocp_modify(tp, 0xea84, 0, BIT(1) | BIT(0));
+
 	rtl_hw_config(tp);
 }
 
-- 
2.47.0



