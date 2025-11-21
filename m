Return-Path: <netdev+bounces-240830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03854C7AFEC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF1D4E9A51
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B58350D6E;
	Fri, 21 Nov 2025 17:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0634FF50
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744568; cv=none; b=ZUh5ylZqXRRXm8qRQnoeieERiDeaSalq9Fv4koRd5vsLqZkR337btPqfHnBES5kNmfODk3SDvZ9LqNG6UzgKMKcaqFn8i3QIpxwytIRIZyUarUyJSdMUlqrZsS0mfihT04nU2JfGofM+L0rW766WRGLq2BDyYlk4ESrMxGqzCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744568; c=relaxed/simple;
	bh=IqUF/HK4gJVFYzoYLBDPHccIpNGfcelRNDLIw+w0xjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJlfvib74wriEfjYqDQ8g8Ioc/D0tXt1ebnXgspjXeMvF/gicp3kQv4J9Eov4qDV/iXAillkv1AH4gqB9yuNBAp3fjEsIMea7L2CLrwkKSX03JZOfIkTY0RVCrrZD6ksUIWZK8A0TEeASe7Wng2J4U21KMbq8vXYvXXxVKWpPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-450063be247so767923b6e.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744565; x=1764349365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylAg57J0SB0BI+dqga55AJuGSMAFF65rjQsIaxnfJQI=;
        b=pBBHMCqGPaI9SrgNFaLx29cDdf+kA0B7c/ovS5+87vk8KPRrZh6okfhO+duFJotXEH
         ojaT44QrBDIoVKBipCf7X9wWIwVKnv9tUFgy0c4h3skY0W0joNykLHuaChnJx1bXQsSG
         OfBn3SHCDaj1zmcYlLlgH1We4y+OUG792YVPlafDNXrTm+KoMoPIcxW5yBqcNsuF0cgk
         0Z2NxzXwZO+obu8VcxrFC8x0pySij1bd6ivpR8/XJ6Bla5ar9PC8D5sYXDADL+J8sHXE
         CucVrm7pW7ZZhkbjJmScMrtdgkGWVW0a8ZbKChPgshwx/1WwHCEmaRL8Ti+T9+I3alKT
         U/iA==
X-Gm-Message-State: AOJu0Yytf/Zhdu9FrrpFugEN2iVOE+R+hkrXrrQl1DkoEsZOiELwkRe+
	7yYDn5WKAMdGT3XhbNRcQfG2lcmjfWILANeuBUOwCw1PHt3vt5jiLoMh0w9czw==
X-Gm-Gg: ASbGncsPTKh3B3cgtLdWIdabw07A43ipa9kk26X0+zmxYFz15MrM7qL6AQ3YnhqnnPc
	52aRmtuvQUhfnq3z2xAdWiIEU/7OrxAbRRtW2FXtn16J9B/glIxF5X43KmLZX8OQxiTpRi1RGLT
	PtrODaPhKKovqGCdaGc6e2ONr/KurHPHxX1wSDTfJrFp+ccfT1es6ci28HvpyhV6FlY8HnWoOZc
	glSJ1a6dVc7VjgOKwyewk1FguidqdO4ly5L2gQ/O0dWz+70xpnZdZ9l2mdyljAQlhizps56pXM6
	Y1rvIjrJqOxZpCpIBgSGX7jgv5D/t/pnXEbcq4noANGwNXwtJSpqyZ/V2RuNCQIA9+SGsnY5Qpa
	/96ynLRYeDKDjOZ1zh6RUUh/BQFMYwMvtYeEACfrSWesi1CFOsR87JVTJx4M5HKN9UGGnli2amE
	5k4jEjdtIgX5Lhwg==
X-Google-Smtp-Source: AGHT+IGHJhaBZAA3RiJ3OTGOaqmZaZzkmeK+A6Jqkbi79Gy+E0o6gK/s+ktcChXA1mRxLCd5upC8oA==
X-Received: by 2002:a05:6808:1b13:b0:442:5fa:290d with SMTP id 5614622812f47-45112cdc1f8mr1195122b6e.43.1763744564640;
        Fri, 21 Nov 2025 09:02:44 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fff8bd43sm1759174b6e.14.2025.11.21.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:02:44 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Nov 2025 09:02:35 -0800
Subject: [PATCH net-next 1/2] net: mvneta: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-marvell-v1-1-8338f3e55a4c@debian.org>
References: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
In-Reply-To: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=leitao@debian.org;
 h=from:subject:message-id; bh=IqUF/HK4gJVFYzoYLBDPHccIpNGfcelRNDLIw+w0xjs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIJsyV48FTHnw7ROAS7cIzyC0Dr2/aWookYsTV
 Xlk4J47Vd+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSCbMgAKCRA1o5Of/Hh3
 bRQdD/9tPgvXc85PkeatqMeTv/zS8V0NPPXsQ72P8OeXqssdoQATezGyDL6kFt48pW3h+fLX44N
 OAGowu3wgIgXicZNVFgrw+ShL7FMqHGcptNTCObkofhuIiu6wLoMBeJcn/7LoX7W/FmIMU7VdIq
 MtgBgY6dG2uew/G3rKH/vvrYqo7UrPcEDrvGGLPIj33TAjq72qfxZ5fVkLSAgmkR8EGobaYidwX
 /RVeCbGbzTzNkYP5mjJJWW07Bp/68r7heoggzhmy0IsjoxpTgWZ7NayzvAOUjJyMoKAcO7/5jRT
 cZUYn87DKD+qbjs3WpQ2iZNu1M8sarwhzG+tEnGTHjTJbxxpp7083Nss89NiJwEMwXsYskB91lv
 yEnm3sh7E3rdQHgSbkbaRF0BUlIv4P09IT7udRx0O+v7sIokk1x+YjMQZKv5tVr3FEqH2TbnUpo
 i7QKLdMHYrDv0Du5kGdhUEQkGvg+nkj9RwKuokgvCyQXoGhYe1pNAWD8QPs2SZaMWIj2waMu81N
 phelPHsYw5VMgCof9CWtzKmePiHyBJlzHiEQpohFCaa0NjmCOw1mlxM3+2ykf088cmZFKfknPSk
 DeCUvkKAH+IfYrfXH/uqWRNBcPDxyK3iy+WrHyp7dAgmeNzz3ImKOgeTInN16fV5VhtUgui6FX6
 m/YCkfn376DOofQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the mvneta driver to use the new .get_rx_ring_count ethtool
operation instead of implementing .get_rxnfc solely for handling
ETHTOOL_GRXRINGS command. This simplifies the code by removing the
switch statement and replacing it with a direct return of the queue
count.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 89ccb8eb82c7..7af44f858fa3 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5012,17 +5012,9 @@ static u32 mvneta_ethtool_get_rxfh_indir_size(struct net_device *dev)
 	return MVNETA_RSS_LU_TABLE_SIZE;
 }
 
-static int mvneta_ethtool_get_rxnfc(struct net_device *dev,
-				    struct ethtool_rxnfc *info,
-				    u32 *rules __always_unused)
+static u32 mvneta_ethtool_get_rx_ring_count(struct net_device *dev)
 {
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data =  rxq_number;
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
+	return rxq_number;
 }
 
 static int  mvneta_config_rss(struct mvneta_port *pp)
@@ -5356,7 +5348,7 @@ static const struct ethtool_ops mvneta_eth_tool_ops = {
 	.get_ethtool_stats = mvneta_ethtool_get_stats,
 	.get_sset_count	= mvneta_ethtool_get_sset_count,
 	.get_rxfh_indir_size = mvneta_ethtool_get_rxfh_indir_size,
-	.get_rxnfc	= mvneta_ethtool_get_rxnfc,
+	.get_rx_ring_count = mvneta_ethtool_get_rx_ring_count,
 	.get_rxfh	= mvneta_ethtool_get_rxfh,
 	.set_rxfh	= mvneta_ethtool_set_rxfh,
 	.get_link_ksettings = mvneta_ethtool_get_link_ksettings,

-- 
2.47.3


