Return-Path: <netdev+bounces-248566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F45D0BC00
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F90A30E7317
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868FF368272;
	Fri,  9 Jan 2026 17:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F935CB79
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980538; cv=none; b=O3RUDYu6CZ6PA2dZJID8F+bG2I2qc+Uv8Rip7ELUcQSMI87QNuvHLTo9uObFCFk6V+el7xgfNkBeT+UOmJs8drH8OkneZpRO9aDK67ZWXbce+mqb1mt8iMfxyLxEqxXX8BRiU1GDE5/fz5SZLbymAOT480BWaoK/fAeHbx2UldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980538; c=relaxed/simple;
	bh=NwEAQJcWkyJW4qDQ88U4X0DJVlPj19fNX0H4+k52RXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XrBZWf8YSFWcbhhbW0UJ0kDClNJJQjzfGVwolfTXaWjc77JJq1v4+Uke0urL8BJubR4+iz4bv3CXBV+DCBiSnR6suOnZC5aSQVcEPeAuQR37vUJ4Zr6IAkvgouAhXSJ4+K2yjNyMGPnBR1LiMEIGuWpgB9Jb8tS7yEJQPWTXWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so3293830a34.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980535; x=1768585335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HWjIDWJUNaanJUAgQBmNnGhxSv8UlX4YaBxPMnEA0t0=;
        b=JQg5pjIFe+Vvul3WTA/g/mvhO6BFf6jlxvjd/zHCN1T8L1tDBJgJ30XQi1KdBEA/ro
         J83huAQXpw+qSCJ8KTxsWWEpcIOv7ANkTMl1ndZxg02SYw1IWM72pGEyg2zCZaJXYOkC
         /b+WsmOrDmpXtxygDVk0rZPYVzmZc/jEnqOdikh/tpvQpUXP584MA2JkYUIlwOTn10iI
         iHP79v556Gw2TudzCdXgcuzFtBg4wZnDYdw1d9Hd8GteNF88w41u/7sW9AhgUGIWqYu6
         zSW+gzDiGJm79rMouWto25zFVPkDvGMBRxdgmx1cdjKUE/b6p8yTexXCV23+HF0eUYtq
         O3hQ==
X-Gm-Message-State: AOJu0Yz46gIEcniosqQURZ5PqPf/RBn9omg508XMpHx5ascSvVC3MXAs
	uw1IQ+Naz0s75Jpv10o0MBk+nMyb5BEOhtwsVkfcUYSt/6k+Ct3BJYOo
X-Gm-Gg: AY/fxX4X8AO62piLwS5uTny8UAtLeLw12qR65gsH/1CRUICOHHeP/CP0qwyNrMDyr9H
	0b4dk1g8GVrkTUUsMxwz4KElSuconnJ5slPpirMmxrduq/ojC9j1ARDex2o7K0HZgM/PbKBzQ/g
	rZK1+335TPDnweFTOPRUrNUE9EDRHzY54tIunm9oB/tt+6k9gBUPwKHj8efEYB9QRIp+96ii/lc
	XPsXvDAcefmY5CUnuQklhn2aXO9l6cC/Q9IobG6NttKRCHgp29JGNzf+BxE/Cuk1v1EHf0SnJwb
	GsuNxcpI448G/rtw/qi58hEw+42pNcIY4LOetJTOprlhysayiXD6lTBxeilhGhzPKwbN4P9Uvc1
	dkGqoOSVYKEHkyhmANI1Tsa+fL30RIQOhLtaIu7oiKxzENv+lU4guUBLeXojgBbcjXTbXos0NxP
	ku
X-Google-Smtp-Source: AGHT+IGaqjRFJpSDasXnML8R59MQ0MpL/WRlDumZ6uerEbIHt3xQqrojN5zaIWL/R1Vl8HB4tAl5fg==
X-Received: by 2002:a05:6830:314b:b0:7c7:59a1:48d7 with SMTP id 46e09a7af769-7ce5089ba54mr6767349a34.2.1767980534743;
        Fri, 09 Jan 2026 09:42:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c286sm8168665a34.8.2026.01.09.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:55 -0800
Subject: [PATCH net-next 4/8] net: funeth: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-4-a0f77f732006@debian.org>
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
In-Reply-To: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Cai Huoqing <cai.huoqing@linux.dev>, Christian Benvenuti <benve@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, 
 Dimitris Michailidis <dmichail@fungible.com>, 
 Manish Chopra <manishc@marvell.com>, Jian Shen <shenjian15@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=leitao@debian.org;
 h=from:subject:message-id; bh=NwEAQJcWkyJW4qDQ88U4X0DJVlPj19fNX0H4+k52RXE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3xeosS5k/MaQsTjxHVS3p9JfgUIqb0QvAjf
 aobZITgM+KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98QAKCRA1o5Of/Hh3
 bWCdD/9j+M0r9Mi4slfacJL1ikudlVEf6YibKZYpumN38Yxk3lDLaWA6WMksruTGqDGQwvubNm2
 xg+K8+/fzHVBCo+ikbrYNMkRIMK9c0GDvlBdg9BLdUR1U0Ok3aGIqVboNnlEGlvQEs6izGmqtT7
 U+2DtIsj3uqqs6dDrbIzGM49vWTRqAqmKzAJ1VQMf3ZvYPyGVeZEYlUecw0UQwK1M9LWzOiO8tQ
 n2dqQa48oPSnTawrMK1thkLs5coJ2f5xsXlqJh5N+EcAdI98cJJTG8W2sH2XANMNT2MOI+B9qRP
 GG5VKcZ1wptSVoH+U3Sztd/Px2ZIyhwzj/14NUENG4klC4fS0S1bCy1bjKXTHMRI8yxiak50Vgl
 DoBhknDeCAymCjhuOe0KWIeHEyg/WyU2vYvI61Fn63FQrE7dui9n/7lEYXHLkuzoiEGSz6DI93b
 q4rtFAB58NaI+JWmxiOnhazXo2NDn/Lu7dusvuHOT0szkTPRvk/JBJelh6neypPRDkAhE+iqjMM
 5m2gvk9WQv62UIRbu2nkrx/PeawOC2tNoaj4zXzjbSTp8HzM50u3NNE/Ijmidbb7Pxg+I7ucOG4
 r/RTnKVz5+tnPLnk9kclM0IR7+IOYSu8A45aak/hLpdkHWC5dqwCJMXGMzQpVYJtwDwlh5z7p+R
 r1JBytBw2mvsIbQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/fungible/funeth/funeth_ethtool.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
index 1966dba512f8..106adf7a870f 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -946,17 +946,9 @@ static void fun_get_fec_stats(struct net_device *netdev,
 #undef TX_STAT
 #undef FEC_STAT
 
-static int fun_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
-			 u32 *rule_locs)
+static u32 fun_get_rx_ring_count(struct net_device *netdev)
 {
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = netdev->real_num_rx_queues;
-		return 0;
-	default:
-		break;
-	}
-	return -EOPNOTSUPP;
+	return netdev->real_num_rx_queues;
 }
 
 static int fun_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info)
@@ -1169,8 +1161,8 @@ static const struct ethtool_ops fun_ethtool_ops = {
 	.get_sset_count      = fun_get_sset_count,
 	.get_strings         = fun_get_strings,
 	.get_ethtool_stats   = fun_get_ethtool_stats,
-	.get_rxnfc	     = fun_get_rxnfc,
 	.set_rxnfc           = fun_set_rxnfc,
+	.get_rx_ring_count   = fun_get_rx_ring_count,
 	.get_rxfh_indir_size = fun_get_rxfh_indir_size,
 	.get_rxfh_key_size   = fun_get_rxfh_key_size,
 	.get_rxfh            = fun_get_rxfh,

-- 
2.47.3


