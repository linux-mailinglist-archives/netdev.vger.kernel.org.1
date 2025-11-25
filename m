Return-Path: <netdev+bounces-241486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB745C846ED
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7BB34E868F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE92EF66A;
	Tue, 25 Nov 2025 10:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C4231836
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065997; cv=none; b=brr0kvheruOQmt1m3vdEB4wN4TnkcLHhl2MnowK3WgM+GGtimsvzdcUMh/etbRxyE0FcMON7RygMmXL87GOaq/rW82lcQKbSLG8UXvKFS0fbRiPoc3TXvu2rfsOELrLlzE+RXX/J2RDopT5t7Hh8wS7t3NyTNxtRBaLFpbERBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065997; c=relaxed/simple;
	bh=3RiXWowk55zr2p2eq73rkAXHd/aJ3SITLXEDdD0tOSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1oz3O3FcRI2aqu4AtEA3LL0oix3MPg0Ni0pYCeUF2KTlvveuSL8HGe1D1/zphhiLz3ItrhnQY+ijL5kVY15igalbxmW1OJ44rF+nnBDosaynN2DHPFLMSKC04KGptRTVmoGJwo0dha2VeMl54C4J+eqlkReCxVE58oA55r1OzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6cc366884so1431372a34.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065995; x=1764670795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c+Zhhyc2V4qfWtECl+wYUVLsRnhgxQqkr3SEOLVVqz8=;
        b=V4Hid0r21w6np3VjaZZyMQ5qCIVGZqTmt0WBVm3qM/vMsARgaDR1H91oiOjHOkLczW
         389L8nLEyhqNAVwOOLPg8vmLbvveMkeT79Jj4j3C8/9xCJoNB+ulBP4ZZbh3/zbTS1zc
         ZmLaf7+f/8Ga1LXGErDioqNsuM1vL5Et9CXC6WXNKAPf+e6zW3BXHTR1Qxm83fLaq0Mw
         kCHb/NEmEcetXhzKqgqkKpIv9Fh6ISLuduH9lB2YKjC7AnaEkqE4KGpkQ3nruKw3i+ql
         xrfPj0ViIrutHA1439NY+eBOnu74qMEYbRVJhQB8OtMwLpEz7/19JZksnjGPbCUEkm/V
         Ri8w==
X-Forwarded-Encrypted: i=1; AJvYcCXrudu7dLbpNkhczCfqouixZeeoRBNTs46bsoa+2rsRpvkE/Idq17xX+9xryFx2EGr7Ju3RUpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFM7Qo8yxj9TxPYSCcm2bqIfz2SObO+cxmTpw3bJcoh1EtrX6o
	4HEhLwAVZEg2+tsszDYrmtBL/efm8aLA/IDvGXhhkJ0ZeWe0n51D/qfc
X-Gm-Gg: ASbGncst97GFwVtO6BW+xJhv8D46Uh52SAXhHSNkS0/fVlhySBIlU1dHNyI8aZKPdKQ
	ohNy7os+SmeTIPEAsbgg4SIiaY4NrGfMCCVfShAT1czSmvZnC0HGPyzLuy3z6mCh2VclSZqfAH+
	FZjldLll7uBIAMF2+Oeo5Q5pUgiDNcZfmppiCc1FmDjzBZIBTqAtbV3flkFkZ/49wJXdeCoF9a5
	gb74EOvYNOJQoA0eXTJGZRaDAkIMO2+j38NuCQWA0ujEebJ7LN+dVzxdFrT45kd99GOnXeMKWc2
	J/wnq9DTn1RbJufbDcyjkQnRCDorBBTFVjmJqudwd5XUut7WRInzhbQkiefwD7W7t23HVB1W9i1
	G4DWVItIWu6VOh2jGCotoVlp14AJPvynNs8v+O2qA5LUN1P26jyEqrinNYf07fQjikjNH3RoOKF
	2yWyS6YA5Qhvn1gkxxRmpJKtek
X-Google-Smtp-Source: AGHT+IHY2sraLYhAXeIuXGFaHS2dicYqNJk8AZF0BKKSEQfRkb5QPHQDH0CLxRmEirGOyUOizH91eg==
X-Received: by 2002:a05:6830:440c:b0:79f:19f:7f2 with SMTP id 46e09a7af769-7c798e1b962mr6667023a34.0.1764065994932;
        Tue, 25 Nov 2025 02:19:54 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d3e3bc6sm6100636a34.16.2025.11.25.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:19:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:44 -0800
Subject: [PATCH net-next v2 1/8] i40e: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-1-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=leitao@debian.org;
 h=from:subject:message-id; bh=3RiXWowk55zr2p2eq73rkAXHd/aJ3SITLXEDdD0tOSg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIAU6lJ+/Blj33Z6a3CA8B1/dBpOFhEJRoL
 qFHON0zu1aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bSgLEACwtbnfZB0O1PkzazJaBBXouuvxXqVM7xOm2fXUKPsgJT3WrEVMxBermV1OM7rbH4n8CW2
 YAsBC1adOB6X+3buIMPx8AdpoG7lqkair93iAUrkM7RuUUHb1bCRs7I1ZTq0KXCdNO3jiynsu8O
 IX5vkZF73kPvJnPDuhy0ep6cQ4ByZGztrQV5Xtvaq5DQSn3+cfJqig7CF8RS4d/Tr9D0d8tcCEw
 g03QABmoxvNHNnZDoyzKQ5oqVwxccxgKtcrRh5v8FjI6Yg9Ctu1t38NUQC0ulG37KF3mc2ejz8k
 f6SRBHD3Hz5jDYk8qntl7QDuRGs388eX2C8d82p/hWH7Ql3tKSDCS2yqHm/38l+C5RaOlWBTK9J
 wdXlc+fPfFuiEcLFFBgKuXmbN+P1nw6J0A+DOBvCdItlNBdCNkVL1eaxHD8dBnTdaPEDcsCj4FB
 bC7BKbzWkyMrsXvKuRtEh3ICic63p+YwmOlMnAKNOJnFJMcxHaYOdu2Mk4FemV3NesP6bX/gPiN
 drr1m++i7vpo2ndheAvSiI2qkUCg69O96mAYx88d8wNuLh+rZ2+SN7UsjnyXxe3okKKrYibe2/a
 CWagKluxznqFNbVLanMyH+4o8AiWESE7Ejp4bVOUCQMnSrmOUX3OtwlT+YlBxa2QFxx6QiRPdcY
 yykclTksMqRBg/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns i40e with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 86c72596617a..f2c2646ea298 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3521,6 +3521,20 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 	return 0;
 }
 
+/**
+ * i40e_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Return: number of RX rings.
+ **/
+static u32 i40e_get_rx_ring_count(struct net_device *netdev)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+
+	return vsi->rss_size;
+}
+
 /**
  * i40e_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
@@ -3538,10 +3552,6 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = vsi->rss_size;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = pf->fdir_pf_active_filters;
 		/* report total rule count */
@@ -5819,6 +5829,7 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_msglevel		= i40e_set_msglevel,
 	.get_rxnfc		= i40e_get_rxnfc,
 	.set_rxnfc		= i40e_set_rxnfc,
+	.get_rx_ring_count	= i40e_get_rx_ring_count,
 	.self_test		= i40e_diag_test,
 	.get_strings		= i40e_get_strings,
 	.get_eee		= i40e_get_eee,

-- 
2.47.3


