Return-Path: <netdev+bounces-248567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FEED0BB97
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC309302AB98
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC7368276;
	Fri,  9 Jan 2026 17:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9D368267
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980538; cv=none; b=SwRnZ86EuVBey9VUrdtSXQj0iV8qsPzuHtvGEImLrGmMidKgv/FaFKc4/huFEHCt9pExHy/qH5Vc4m8c3C+EnRpHPQryUwSlFZugrBV3hc2smQ2SmMddJQudNFMXeyOPA+GfVCdbJMNbdxrpnH3IPkRqnXG1fDsD3tIfQQy/31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980538; c=relaxed/simple;
	bh=jMza/r3EvKf50z8/tcO6sHnGSe78CwAvNmAS4XWR4Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbIcyptQ3qeXymCsUWpEk/DCmJhrxorOsRbe92rKf7qVJwJ4UosJZr1KqelV9WwJvOPULhTqEqZvStSbgfgK/Tn2n0PdL8Edvra/owvWP5SQVV5pYY56RBS7UKlnrMrSh8QhbGWRGMyVPJnzMf+6MyEPTbqdwu4cU1qHF+MYoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ce0ef9d4eeso1936531a34.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980534; x=1768585334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uu2wFVKAgPkThyAIJMzLLfAz/XvxjD6o0/STOeVSXIg=;
        b=xNUpQD0KutJhqaY5bLIKoZ/WAhdrTcLqNDxkamK6nNl/k4/1sHMaAVb+PDy/7QptAe
         2+lCTdc9oqTzqrTxtZA6aw+xcqDJ8mDi3nvqbPUoUFZma6GeyH/Rj3Ji2XiIRT+3PNVQ
         eIVr0k5jRVpk3eMqA+xgflC6vOT+Zx7BEMlrLyg0HheEf1E57DrSZoFDB2F1T8j9zPRT
         vVfh2lfupzmZtl61kYkXdZPSzzEle/bgnmq4sYC4ASOeGcusifCa1VqjFOpvms7cga9Y
         tTBT5WPrsP8qbJ6taSpewut2PYhQRYrB5ejHluc4JZFqjk5KFcFVrW1wlRneKttEOdf0
         HU4A==
X-Gm-Message-State: AOJu0YwCe1qVfCFmY8CEBH61IzKPLvNSJ/HjnqCnHqdYrxKBtSbws14K
	Yt58FAME4GFZHKgbYs6ml/edpEjEjyruhUvqt6iYc/RGAQ9eC2W5Ryv6
X-Gm-Gg: AY/fxX6f/iXgilkavmrDyxETXYcGkl1BS82a5cJqOWGhC7Lv8ZV63mWhZv/ecPSUdWU
	k3ocjLJWkHMMKP3791L29+TrClrB4aYZg74LGg4d0CPqJb4juUH3Wa95Qgs8cFNBucOZpns5duP
	QfPsHO8CtKrsc/gHUObZAQMRo9gfCF+Dc2XaWS44PBEtga9WvIttzMlnEekX6E1/OpZ+ZeXwVI1
	cCAUk9J+hbMlK3/EApbrlyEIEXz80k7Zu7SOpBGNHyScItRje7HxWqtvYBB7cdmLqGR61PT8BV7
	mmjt+nBiikTWxLBfuZY5b5+UMlD9GkVfK+fja5z0LxpHL7Iun1no97qZh5OOiwrHz74oY3G4GqC
	OXYnf3J7gih5jqKJ41XbQGJA9yANegRy+1+kAUcdTCHVHoQXlnNGbxtSuOXhBpZuLQjRuWvtF+7
	UYgQ==
X-Google-Smtp-Source: AGHT+IF6nk4ZAg3DcXwJ37L/Rb8Xo4H5ujozgvKbA892I3x9uVUx6WOdqOrphoRwZJNcoyR3f6a93Q==
X-Received: by 2002:a9d:4791:0:b0:7c7:68d8:f711 with SMTP id 46e09a7af769-7ce50bcba3dmr6628704a34.18.1767980533617;
        Fri, 09 Jan 2026 09:42:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47835588sm7636882a34.13.2026.01.09.09.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:54 -0800
Subject: [PATCH net-next 3/8] net: enic: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-3-a0f77f732006@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=leitao@debian.org;
 h=from:subject:message-id; bh=jMza/r3EvKf50z8/tcO6sHnGSe78CwAvNmAS4XWR4Lo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3wt1Cc6uJDREiG//Dw0GMEt7bsa08fIalnw
 2/UlgN3DNqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98AAKCRA1o5Of/Hh3
 bZuzEACMHzJVnozTbV2Q9CVaGLDAjFnABTcJ98IlgbXW4VCuRS56p9RvMGwKImq2MJxUwE/la9z
 kYCTFin/jn953/oQ3a+b9lQi86MzjvgPdMwjrppZ2IlODOyuCZXSve1rPDv0xV5OSKSwwYbQjGZ
 ko0BLimuPpTSbPeU+JX2wfA37VIF/fk1PrgN7Iap99iAuZAYNZivMYjPFGAGVw6X43Hc26NrJFH
 HL40fSjkYAUeu50OUML9TQZ2/budKrCMT7KCNrdxhWQ7OUdTqKtLzxiQUwgqO7Tc+P2syb6sVzY
 XL0l45KvLkiNcjBwCZaDozMBUIoLZbgzlTEvimCSkdfvyueO6NGdWooM4qNl4O2eVsNmX4PvdE4
 eGuM2ku/sfK8p4dJMqo2zYyQZRlxX0Xxko7KukaDsZzzj9XubePSEl09pNmTpgVM6phw07uADW1
 Ez99+wW8CvcbkY6ihNIV3sAo8Tlc8Yhj8JjHQWN2F8vWzCCWDkCjq2VNQ0G4zZzCo9DswUw/VEB
 JkOWl6Z1AmOSv+p+tooFJ0uoN3/pJdj2eFA+D8WMZU1y6FBd7jppH/85hWUcfeJwCwvCaF0Ymlo
 D1rV22+q7gUiC69/WASuTxHJAAeOqHMVxKyBCfrUhEGcHF9PHWlRJqNJ76oBB1xg7qD5e/aU87t
 Z4/dE80kNA197ow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index a50f5dad34d5..471613899ec0 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -573,6 +573,13 @@ static int enic_get_rx_flow_hash(struct net_device *dev,
 	return 0;
 }
 
+static u32 enic_get_rx_ring_count(struct net_device *dev)
+{
+	struct enic *enic = netdev_priv(dev);
+
+	return enic->rq_count;
+}
+
 static int enic_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			  u32 *rule_locs)
 {
@@ -580,9 +587,6 @@ static int enic_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = enic->rq_count;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		spin_lock_bh(&enic->rfs_h.lock);
 		cmd->rule_cnt = enic->rfs_h.max - enic->rfs_h.free;
@@ -689,6 +693,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.get_coalesce = enic_get_coalesce,
 	.set_coalesce = enic_set_coalesce,
 	.get_rxnfc = enic_get_rxnfc,
+	.get_rx_ring_count = enic_get_rx_ring_count,
 	.get_rxfh_key_size = enic_get_rxfh_key_size,
 	.get_rxfh = enic_get_rxfh,
 	.set_rxfh = enic_set_rxfh,

-- 
2.47.3


