Return-Path: <netdev+bounces-241270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B63C8213A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C83AFB3E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C513731E0F7;
	Mon, 24 Nov 2025 18:19:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF731BC9E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008361; cv=none; b=tVWfdKAlXXbQHkkxhus1BoQ28SyxhUFMoukwNJZ0hiDUPCizrWzBMydyLMTHbTntAoJZPneZTTZvNjyNrwPlSwsJzvPcG8sR1L3AAbsXH/YCQX/2fMKzS+QXPiTkYvjK/sm5L5wytLHjORbVhPaqZuPZqxTxpX8KLW//UH8C0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008361; c=relaxed/simple;
	bh=v3FELT954aTfsjXFGCQjBmaqRQsN/PNh4kyuahjVzFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWLaz2/U3LSyXPqV14f+Uuiy3mGwHp8ji8UGG3GTG3tONmcJwBt8hJNUNn11WEjbVRT9GpGgFM8RUc2PGOxRA5flVm2yA/yYkduLaIWXGglxmCcvLJc2YkgnHG8bnufMbH8Ml/YXX2thJ0MJnGSZFFCvI7WkK9opUikmELXMzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c7533dbd87so3304559a34.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008359; x=1764613159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpuv5uBb34S2sKQbL15mp3kM5Ctt2dd8AM4k33sXpoA=;
        b=m48dJSW4CLyV/X11cTL5xQmf8Yb0qfm4q4i+Tj2XNQ3MnyylM0ByrRyWhzvTQMqrku
         B/smlpMN0A65z57+OjaPbyC+vUCQHQFS0hvGPkxnzwuOFT27teaK7uPj+9ynyAlh/GY0
         7JzeabHrrVXNakjaCdLCvZ/YXDSTJJr9gKdkM44VZqgpP/kaEaBI/GodMKoXRg7D0PfT
         ZNQBbxsnirFDy0KdZ4UWHVeE6cPS5+jp05qPyBpeYWvUZxUkqxK2STDdTfr5/37fjbI2
         HILoAnjnsrYj4Chexu/OS6LhTEyIn+pAop8meU2tSwcUK2TtpkC9lClm3tIfyq7btLKq
         46XA==
X-Forwarded-Encrypted: i=1; AJvYcCVmtPux2IMPh/W+arEINDRj3WxECJgYBolWS2lUpf38uuaq+m+UZjUxuCkLCx1ybvi9AB2HBeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oAQOMw7ECi+xI7Qn9Mn2pt8dHQpDk69Uglmb5ZvUB1QiywCv
	t33mIhXFIau+FMr7BylfuJo3GTzatUI8MsYmZw6GVb/XmaOOgHTKlftI
X-Gm-Gg: ASbGncvnmwcKf2IBxVvydlZ/1iRAIK6hjnFVfdU6XCTP59xqEIIDZdSBKHzmdtYDwH9
	w5MBQjqKLr8ifMDSiet+C9Hao5MY5pUZ4IAe3DbHPAsRjXF9BNcnd5DGeJZyxxpK9E0C93Ycsfd
	xTWZ348e4DxGqbEjlNMB/+kSAc82STHQC/0eC5vsCguHA0kBqHHwNFeURfRLYa4lp81giGcjRQB
	vzgAAcPb35BVXeQTErdTt5XTrVjCgrTzeE7MP4VssQ01YoF+TNp21d1pHvwKoRR2kARsLTVLMDg
	1fwVi1gKkqxpQhtXSUZTfimBgPu0MDJ/JVGws+/Wf76LqA5dSM308OL3WFAGjXFKsdMIM7QaIdq
	pEvjVEja0S8kJKjdSA+GZwCtm00Lc33N1V/9h3a/GoYa50VnqXj2XkkOM1AFn2S4EUWetSn8ryP
	9O5t7q8HYG9hYMNQ==
X-Google-Smtp-Source: AGHT+IGLyTlOGAFidnFnYcwBbuXw23XYxP3MgOKH7xbrMv0wbPQmYh/J64HtXsWHCv78nNaDS0I0GA==
X-Received: by 2002:a05:6830:71a9:b0:7c7:6626:b595 with SMTP id 46e09a7af769-7c798b57595mr7147761a34.3.1764008358888;
        Mon, 24 Nov 2025 10:19:18 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d32f601sm5513512a34.12.2025.11.24.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:18 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:11 -0800
Subject: [PATCH net-next 7/8] ixgbevf: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-7-89be18d2a744@debian.org>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=leitao@debian.org;
 h=from:subject:message-id; bh=v3FELT954aTfsjXFGCQjBmaqRQsN/PNh4kyuahjVzFw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdS6QcA3NViqOUrQv3y1/oRQL8hlQDzAOWm
 PfRac3kV4qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bYeGD/9Qc0SPn9JXbdTvMKmq46s4CjUHTti9396l4b4GyFTAlxrjl/N11ZXZRU9VRLExRJL8DF5
 SYO8qrjrZ8dFz1Vfxz/HoGCky2YLmVpT9KLWNCygZbkKzUuY6ndPFdTDpL9AtRFQrp1CXx2sYub
 2mqQWn3WTL5kVGOOVVs4diQZg/PNG4C/Ad8NQkkzI7abHxxzIqh9TBz0Y4HcoGPPiH2kVFkglq2
 hNNAN0Fj4NdHZ9iee7abuKVslhJcakSCH3HwtmbDfHYuVn7q+mJAirZPBOU56zYxDeXHoK7WksU
 jznJ6x0AOnxrq9q38SZutudQmmwTPVPR9GrSA6/eECKViLGDkAP3TMpk7WRX0930/ZmVW9xhu6U
 e7aQKYK9SQbFMj4f4mM4VTU13P4TqA0HW8geLupV5+XieysIoftsneh4znma+wuyEDPlpKtPC/X
 oK3i27eKmqpxpflNMbnrL+VdcZOuV2IJ8i0NbC/Hi8AsFWTP6zv3zW7hRP/zRO/SUoFzqA1R1iV
 2Rm5igOcZyIwp9zNiysOPLAkodu3nvKLCqTfGQI57oZ6HTc3Capln2RLn3NVSbiirYUiyashH+f
 zFafDBfvP35pPTkIs4r/fRkYLrmqV1DV1i1GUGJ+p0QM6O0LoHO2te/8LOO9ANJ4nD3O9nxr9MW
 2y1VmnoSHYF1rVA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns ixgbevf with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index bebad564188e..537a60d5276f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -867,19 +867,11 @@ static int ixgbevf_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
-static int ixgbevf_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-			     u32 *rules __always_unused)
+static u32 ixgbevf_get_rx_ring_count(struct net_device *dev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(dev);
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = adapter->num_rx_queues;
-		return 0;
-	default:
-		hw_dbg(&adapter->hw, "Command parameters not supported\n");
-		return -EOPNOTSUPP;
-	}
+	return adapter->num_rx_queues;
 }
 
 static u32 ixgbevf_get_rxfh_indir_size(struct net_device *netdev)
@@ -987,7 +979,7 @@ static const struct ethtool_ops ixgbevf_ethtool_ops = {
 	.get_ethtool_stats	= ixgbevf_get_ethtool_stats,
 	.get_coalesce		= ixgbevf_get_coalesce,
 	.set_coalesce		= ixgbevf_set_coalesce,
-	.get_rxnfc		= ixgbevf_get_rxnfc,
+	.get_rx_ring_count	= ixgbevf_get_rx_ring_count,
 	.get_rxfh_indir_size	= ixgbevf_get_rxfh_indir_size,
 	.get_rxfh_key_size	= ixgbevf_get_rxfh_key_size,
 	.get_rxfh		= ixgbevf_get_rxfh,

-- 
2.47.3


