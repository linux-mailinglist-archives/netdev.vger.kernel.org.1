Return-Path: <netdev+bounces-248565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADBD0BB94
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E70923010578
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E433AD89;
	Fri,  9 Jan 2026 17:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0735CB79
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980535; cv=none; b=Pvqv1zCgLviVrC/IZakHrwncuTfVcnBsqrKKXY8dWT5YvmcSCZW0VE+kr36nqS/BXQKpsE8Za/Tumsh+ui7C6Hfq4eN9yeCS/3DS6mCrSEWtWrfJWhzvXKb3zrxoqlX6THvJEYFekLvhLLtXVWqxWEA1nP0O/eMCOar8oi0ID70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980535; c=relaxed/simple;
	bh=/W39sZu5PiC94Dg94iQF+SfXW/RFread4SOmLjCKJqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKdckkar3tbRmcf7NU/GbkeWzxPzDOR6ZVDFaorfpSPD5KKemXP7+V26p6NpedZdrIK08ev4mvB0ZXX0iss54ODLG+aXygFxjVGg/kBNksAmwYkPzxvyUlQfWrfNWB+asPaino1w1uuZ8lKre0H3+GU1Og9UKwoHdGZPfjkJGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6d3676455so2306911a34.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980532; x=1768585332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fec7V7gjGWK3dIHKk+zJHhv5pDHSDQ9jRQW30nfAS24=;
        b=qKEzyghYmIOnLAuL/Lt+4K++JN80jgOtaJKYUnz5mQZXEo83kVSqUz1482tE7de61o
         oFIdBXVbSZSMHN5xOKQKQoqQg+1asxJKY+esPn3Yo7qDjqpXmtGYVbq1UPY/KFp3BHXR
         vIwEY08ESh98FS/QlHMIseN8WodDcBPvzqjccBEUgbnVTau+QOksSBeQMNezUY9hueoQ
         XMDAJPEfzhAU3lodN3vI/gzqpeUiMKAvQ4v52QFzhqbTTGWDrH0CxN/7uFrU6xvc2H2n
         klgWML+hD8yPqjAKaVjx6z3huQRGytrDtPepoqhw88WlmmNb7RwS3DTyNaoBIJFuvFKK
         pWKA==
X-Gm-Message-State: AOJu0Yykc5azRUlFWDDiq8jG4WGPyXfE+WKDB07kFlTnUjN2wKxf3Whx
	JQKdA3+39wLTmuZTay8PcMg52hYD16UJcYRBTx7Q1/Chmwv7LN/pM9VJ
X-Gm-Gg: AY/fxX7LsCtb5mJztUU4iacZYazWP9XVLaqqsHgTr90HGasuW02Q25vOF+UyFUAbqQA
	I4lXDbkqMyO9swAC3W2WZ7R7S72MGwHOSvMdnNyvYgGScGl5Qov853OF7PvykUX+eUM5w3U06cY
	JrIGvHa8wJmAFHAuXHtgphOPnDxzLzcobqMwmvkJWNsEqfPjunHxMsVGVfQ/laBke6J0iexBPb6
	TspGWdCnks5mYyStlPt2A9QtmJPoYo1STXJslM/Z5Vglzg3b8ZM5Lnbmv2dxAkqkW2PxunXMIoH
	LKLZNr3vKym+4QNjoI8T9SaJWOHI5Tur8ZjMrbZEThxqb3aiiPvT5Jnm1LslTiMlBu2XY9GZpOQ
	5rWpESmDeH847NMORI6d6RXyqCQaMLOwI3kyLIMiQuQ4/o9jbV2SyU8ejfxoNu6Zf0kPmuKeJtW
	5jVg==
X-Google-Smtp-Source: AGHT+IGHbQ8hY9Cq8uo1LPnUd4l/0H2L3ZuFt15Z28tehbZIR3IPzgLBrPxe6dvbNhgMNlEbj1w9jA==
X-Received: by 2002:a05:6820:229e:b0:659:9a49:8e01 with SMTP id 006d021491bc7-65f55073d4emr5851768eaf.67.1767980532566;
        Fri, 09 Jan 2026 09:42:12 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48bbb218sm4397689eaf.1.2026.01.09.09.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:53 -0800
Subject: [PATCH net-next 2/8] net: hinic: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-2-a0f77f732006@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=leitao@debian.org;
 h=from:subject:message-id; bh=/W39sZu5PiC94Dg94iQF+SfXW/RFread4SOmLjCKJqc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3wFFWdJqRk9EYrWhwgzwAc665QmRIbC5YEA
 r51cf1WZBuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98AAKCRA1o5Of/Hh3
 bRmHD/sFc2pQWGYlagF6WZjau/Bzyp8poV9OtJniZw8bl0zDIdX2Aqarp11DZNy9AEGUA8FkxWO
 MT942ZN/1Hib3tip8Cl0kB2rC0LqhucuQnlx9SXmLTjU8OwNAr/EVwATVwfPl/ZtmUW9vGAtIvR
 GvnnHlIreV2lm6iyquu8S+nTf/qVHCFMHI0EGCanyGqbvayn3PpUXU5NHvRnlt6HoLDfoqrnFlO
 e72hfTztXH4Mh1C4bhU+6CVzabVuDhV3QD9+wxzlzSJD/5hscfnKkXeScASsjphBRpaYpkcZn2w
 lFAE9d7tpTOnEcMMrh/6QHJCqcYOTF4qgUX+1TjLwMdUM74aNCYTuNKhgyb49zrvWOjtVRvH9yo
 mS+DKaTNeEMwhh6zM6PfOysZQKkO5iN9kyHSeVFjjq5m34pT2+G2kRVHoovFsdnzG/04FxmIVNy
 qTPrBaQJqHxfq2WDOmHSp9oR3rt0pnexwusxjCYPYNiCW3FzdVLQeEZXMQKn3vnnDGpGBg1XAok
 BLW5/dkMY1uDsdM85ruzbr+EzA2e/KsLl0jJWODD4sm+9YWDBNvQPXTYw/XbffMJrKjzzfNnDKB
 dzegCeh+0xHKoGbqueqV8TZpr5HcII44bRRzfzGWZIdljIFpgONKrNFCW7qXH64hztVJrmDV60U
 GGwYcf7VGhG+lgw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
index e9f338e9dbe7..f28528df5aac 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
@@ -1101,22 +1101,11 @@ static int __set_rss_rxfh(struct net_device *netdev,
 	return 0;
 }
 
-static int hinic_get_rxnfc(struct net_device *netdev,
-			   struct ethtool_rxnfc *cmd, u32 *rule_locs)
+static u32 hinic_get_rx_ring_count(struct net_device *netdev)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	int err = 0;
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = nic_dev->num_qps;
-		break;
-	default:
-		err = -EOPNOTSUPP;
-		break;
-	}
-
-	return err;
+	return nic_dev->num_qps;
 }
 
 static int hinic_get_rxfh(struct net_device *netdev,
@@ -1779,7 +1768,7 @@ static const struct ethtool_ops hinic_ethtool_ops = {
 	.set_pauseparam = hinic_set_pauseparam,
 	.get_channels = hinic_get_channels,
 	.set_channels = hinic_set_channels,
-	.get_rxnfc = hinic_get_rxnfc,
+	.get_rx_ring_count = hinic_get_rx_ring_count,
 	.get_rxfh_key_size = hinic_get_rxfh_key_size,
 	.get_rxfh_indir_size = hinic_get_rxfh_indir_size,
 	.get_rxfh = hinic_get_rxfh,
@@ -1812,7 +1801,7 @@ static const struct ethtool_ops hinicvf_ethtool_ops = {
 	.set_per_queue_coalesce = hinic_set_per_queue_coalesce,
 	.get_channels = hinic_get_channels,
 	.set_channels = hinic_set_channels,
-	.get_rxnfc = hinic_get_rxnfc,
+	.get_rx_ring_count = hinic_get_rx_ring_count,
 	.get_rxfh_key_size = hinic_get_rxfh_key_size,
 	.get_rxfh_indir_size = hinic_get_rxfh_indir_size,
 	.get_rxfh = hinic_get_rxfh,

-- 
2.47.3


