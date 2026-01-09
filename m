Return-Path: <netdev+bounces-248571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14DD0BBAF
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 167003036374
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBC368282;
	Fri,  9 Jan 2026 17:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD9369218
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980541; cv=none; b=SMpTdn27W32bgvb/xZjpmvZELOyepdljqi6VD0IdyNpA7Zicz4xnxQiaT0lLgXaEbmOhmcVwopPLBwYGZPQm+0BCevvthqOIwp5GTbKgqxUzwrnOXcFkNadEIq/himYSFMzIHBw3dL5Mqe4ZEm9Lv+MrybvXzltxnyC2TlW1/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980541; c=relaxed/simple;
	bh=pNpielNjMhd74hZKoSYzHHdchC/UdPQ9Ft/+ZnIo4as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKLdar86iluBSKFQJMgXREV8XyE+dxxobRt0Yc0zHqS6YE3uDcItwH5jtoSpu1+sGPmq8MHjEADDOX2YS/p7qo1jXhbS23J1xgYLTPkYc5lsqMXWg2xMWp9LoPrBHLkJQIR9PHbcWZnw0DKz5iBqGm31wX51YklWNN91gmna+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ce229972f1so3951450a34.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980539; x=1768585339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9mx1ncVlJ9DMAaNVHOicgdaZOIZ9LebJ73tCAuCoaRA=;
        b=dqY4BZ6ZMuLNBBjB4iJZF+LSvTEkv5Z2fQSiSqj3H4jI15ra5dH0csLUNfyS14qj+U
         zc+OYGeprgUh9gC3GvKnd4sfxlWKnYCMGmnSexSx2x3eaMd2i+vTIQq1LLZsu7ba+QYw
         OxuQXL4OWaXi4MWLgmSuiW+tCOeJb9Ly0kQqsruVpqRWKZ4F1Dj4hMA9HjZhshwQx8ZU
         lGbWd+pTIq51KBma1gXSjC0gXUrb/sx1tkEn/Z5VnszGgYGRgxnMzAOaMDmBbmtCSQqh
         aX3j9VfLi8DRtZM8JOocXrLh4sDcsWRhfOXaLOtOtekqH6ds6X/4HFwcG0WpexHUN+CI
         LPEw==
X-Gm-Message-State: AOJu0YyzWjIwyp3PBo3J0842HYMYQBL9hyaH+rs+fR5dMShZP8YPq9bU
	lhNilaclb6t9rXtzFKMzIkeebfZUlJOVAYUmtvLWbAa4ajrOJp7DR6LBoquWWA==
X-Gm-Gg: AY/fxX5rDQ5N6pl/eCsvkEJsmjOOIr0htJq+wBaMdJu+7l4bGY4KqDpZmN3C36Za+aK
	Y87WdM6o6dqHlNbmEJGTk/DfaulljZ3UwpPY+fFvRGvPH931stDgd61dzVBWUtd2InJr1QZt+qu
	z6cWnwlbkBg5jdBPeuMuznHv8DXLcSC0IrWQNMOlPLAIloE6CijG2lyHVtEqcUanJsVKgmnqyqx
	fYMN1WfyobArQbe+5Ly1hJxS6hr4C6T+MU+JZTiijDVG+lECMr8aHNxOlOm9K592O56GP/HgXOo
	42UmfnNnjZhz0VulKvmhNlSsu3A4Hf2hP1Ce8BFgei0QetrymKlWZdmOoQ0sOLLAwvKGWRI4Uxl
	jZCaeYTyg9k0EqEUwyanQ+buryUQz6gB/MsK5g3W6FBvv7J20AZfLCXU/6ck1LD9uc7x8HkOcnh
	fhowxPMkogXt4L
X-Google-Smtp-Source: AGHT+IFfhtlNrYGEQky932RH+vr2YReloHwdYRWa+rFvabshEsWsOCC+5HYYeLHXeyFlPn2XzqKIHQ==
X-Received: by 2002:a05:6820:2217:b0:65f:6b62:1b77 with SMTP id 006d021491bc7-65f6b621f80mr1270830eaf.72.1767980538633;
        Fri, 09 Jan 2026 09:42:18 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48cb131asm4400251eaf.9.2026.01.09.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:18 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:59 -0800
Subject: [PATCH net-next 8/8] net: hns3: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-8-a0f77f732006@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=leitao@debian.org;
 h=from:subject:message-id; bh=pNpielNjMhd74hZKoSYzHHdchC/UdPQ9Ft/+ZnIo4as=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3xhMoEJZPZHROGe/PpBvqj6pZJD7YoVXFir
 HVMOgo0uMKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98QAKCRA1o5Of/Hh3
 bfcfD/0Q6q2XrUZWfqeOD09l3CYsZ8igUUTC0+IOiWBL6hbTkoT/ZGYxCNWHZqzHjSuNGfa1sFZ
 S0i+v/hxdOggrXoE1zYVugdkTSJxj83Eyod2+ZgR//lTp8MzUHJJBABU9Hadhnhot5JwUl/2Cci
 U8yGERGZjQFiXU8tbltip2uVxXUY43BFsaSykWOywu2oVKkJUxErqBImx0vG2IecAriDXz1m1ug
 sf/IZsSdoDRt3K7R9cKZdXI1+wOMs87RVQf072vr3874ETVmYk0TAoaNVR16wo+d+QcgKWv5zm0
 EJiHlmpeBZgYgBMdn6Mq/9pKc6I95m5fa6gJ1Decz0xG9nj1TtG5JHUjX4mhHaQCmUN9uG6K858
 L86OZcQYewsNBrn2JCmarhAiKjVFSwHIHto6RgOaQ0q+RUE9KpIXgSiBuxL64dy7yB2YmLAw1S6
 obQp49+tmPjpD1peOoq+QnL0XIWqm3IPYM7gSHs4QmOvdyMhfoUp3e8O9bpzCYZ+YEyO1mY2/L7
 a+BIHZRBUcShsQL5qnPEfVSJKxtnsa3kUXXiVXJgGo5AtoB2iLp/qh7BkYEuvpTUKffzlUB+JUm
 MkTzjo5eP9rzj1znEFJ2XAXQW5aVRj8o/fZNk84144qzU3FI5EYYYY23nWQCqSmNB91UsEb1j1R
 IS2w+DndwLaFm/Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index a5eefa28454c..6d746a9fb687 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -988,6 +988,13 @@ static int hns3_get_rxfh_fields(struct net_device *netdev,
 	return -EOPNOTSUPP;
 }
 
+static u32 hns3_get_rx_ring_count(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	return h->kinfo.num_tqps;
+}
+
 static int hns3_get_rxnfc(struct net_device *netdev,
 			  struct ethtool_rxnfc *cmd,
 			  u32 *rule_locs)
@@ -995,9 +1002,6 @@ static int hns3_get_rxnfc(struct net_device *netdev,
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = h->kinfo.num_tqps;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (h->ae_algo->ops->get_fd_rule_cnt)
 			return h->ae_algo->ops->get_fd_rule_cnt(h, cmd);
@@ -2148,6 +2152,7 @@ static const struct ethtool_ops hns3vf_ethtool_ops = {
 	.get_sset_count = hns3_get_sset_count,
 	.get_rxnfc = hns3_get_rxnfc,
 	.set_rxnfc = hns3_set_rxnfc,
+	.get_rx_ring_count = hns3_get_rx_ring_count,
 	.get_rxfh_key_size = hns3_get_rss_key_size,
 	.get_rxfh_indir_size = hns3_get_rss_indir_size,
 	.get_rxfh = hns3_get_rss,
@@ -2187,6 +2192,7 @@ static const struct ethtool_ops hns3_ethtool_ops = {
 	.get_sset_count = hns3_get_sset_count,
 	.get_rxnfc = hns3_get_rxnfc,
 	.set_rxnfc = hns3_set_rxnfc,
+	.get_rx_ring_count = hns3_get_rx_ring_count,
 	.get_rxfh_key_size = hns3_get_rss_key_size,
 	.get_rxfh_indir_size = hns3_get_rss_indir_size,
 	.get_rxfh = hns3_get_rss,

-- 
2.47.3


