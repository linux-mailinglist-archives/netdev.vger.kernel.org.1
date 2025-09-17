Return-Path: <netdev+bounces-223935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997BDB7E0A6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56193A592A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90535FC21;
	Wed, 17 Sep 2025 09:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFA35AAB7
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103110; cv=none; b=VNNlkh3iO4JDM6cF0thz8B1N5E5IzdWRVYgwWJVU1i2lL6P3gdTkDUDWAywmiyuy/EBRnIsJvB9/KBV7sVA65uIYtbUU5OiyisYuNVCekdf8L4QWIlUAlt/pXP+6YQoFSSlifZY5OGFYC59q1QXAaoue56kjKBBIJVMBVa+ftWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103110; c=relaxed/simple;
	bh=Eu//yE4c+uDioPyDYhhWP0u0k0aovyGvDUK14dk6hs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lhm2Z6MC0Hick3SB1CgdBx59o9fqzEvD7bHpRyssE2JCBo7mOH8X+fQFp7hr2yPhwAtzyvyzkjEx97nVpRlUbwbVlfPFKkUZ46K72eHLTiu5l+YnsMDbQu5kNxONYIUDemI6r6G+w6ZNTQfuvst9QbRNqiJr+/j2M/xxy+2nveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso1109241166b.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103107; x=1758707907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/aC7Rw2Q/TRqJF9J43UBQHIqeXm4GXqxm40ob1/fn8=;
        b=cnDzKQ9v6U4B+bpaVUo9/9utmrK/zgimszIWPAnYQhrAzGnxEhj7EcTjHiYtBDQuUy
         pI5iN8rQDZe5jph9ziqw3MTIXT+O6wZ/r1Ifs8w1wkGqZCG5LcfbTlFokVtPXE5R2NEb
         p35FCzbrualBT+GyQ2UkfRspkjtKNcZeiReI8uoNWM+yxrQ32YTIOxpKh1iw+ClttEKS
         CwWyHsKRZ7UZ13gFcv/CQloKKZpc/RP40+OFHCzOgwHbKvu7qWQArHzP8q26/g4J0jcS
         fI+Yae9uk6KyOfyaoCkiB5QJAeFphsJXbX8ouzaaLzxd3MMafzT10IOdMPNkCDlYXtA3
         2ttQ==
X-Gm-Message-State: AOJu0YyfseUcFgZMomq2mo1gvbj4VS2BN8Gsv+l/8fqnhqmgUp2N2tC5
	tQRTzqS2bhovMXprywS0eB2aG4Xr025gz/eAqWk0RgQQIn2cPj7c2EO/
X-Gm-Gg: ASbGncsDeeU1A+w9Fe0waNkgzloQ5m2j3CKe2Dieucg5v9oPgICt/rY2fKNqnDkjpsx
	d4d5m/nMOMiaYtra1+jrBFWCUsDYnz/nJsD5Yw2wDn4rv5200+vOW/kNkML/8wK0NV+y+ddPNsN
	w7H7DxjtBTTEjOkC4gc5y2LcrO9jj57NVLl4Nr2Ej2AVWiHjAP2AIpuN6hTsiCERH2NN1O24UxS
	26A9aqxF2Y1Pqe/k10f6vm75vF92zrfccNww3hKPU/y2FEhIGyeiA2nI60ZGV0Cy9wscN5zKoMx
	Eg0ZFHTZZsoL1ItyMPht+WDpzsZdjywLI1gKTuZHj679YRCNESuqekezlnidt3b2ClNeT6cLHR4
	iG9yzoUIzPtotIQ==
X-Google-Smtp-Source: AGHT+IFj6DMREGMXsSvDFa/csIOwP5DwuveP3f5kUNa993jX5oSzuBltRcVkgzKCeQgFyexn7pJ7kA==
X-Received: by 2002:a17:907:7b8c:b0:b04:7232:3e97 with SMTP id a640c23a62f3a-b1bb9d0f224mr170452866b.21.1758103106603;
        Wed, 17 Sep 2025 02:58:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1348076966b.86.2025.09.17.02.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:14 -0700
Subject: [PATCH net-next v4 7/8] net: ethtool: use the new helper in
 rss_set_prep_indir()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-7-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=leitao@debian.org;
 h=from:subject:message-id; bh=Eu//yE4c+uDioPyDYhhWP0u0k0aovyGvDUK14dk6hs8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2Tt4wLCwETTgcStetKA/Q6F44CCbtf2hWi
 cLtDjU+FJSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bS7+D/9SHuIXwZ310hb9JQXyJvLpC5awA9jKk58JusaDzMYU89odd39ehy+fs3bdIsrHMnI4zQn
 R8lp7d4VixExlPP+6AObZKyqY7740eRqMf8l25omf4bfhRZ9UnJQFLNTBWZdtOQezSprMynYRBD
 QB6gTIz0fFUgtaCdqQu/mQrZ9zgHI88rKE45z6pRFMgQiPYDt5NzH3Y9zy5XwCaa9kHqVrV/tzn
 7GS2KG37glBAWyjlriPrlJthbnd0mMImTrResKazp46Lx29CvAmpboff2jqUJ1oCD/Eex20axk8
 NwNJfiNyPzYkeG8hI1p+6jq5BRGS+svs14j3o29jYueSUUR9chkUcfPQ6YE606gW90IMUOwjSyd
 X6bWCyTl7ovTKt0XenErMZw7sqQmV2jjRHHfgx/nwgBKS9vuhNz0snUgaAc9ODQPvni8OTmsMCF
 BM7DR5C7c49n5pbBXCQR5PjP6VY7Im1PicMU8nvJdh2z/YAGQhfmbUgGky3niSdEVEP3qomBB/V
 qpNH3v0FqlQAlyk1IRP1BH91RKB0Qc/4DkF8AEQQmS1sooEriSPTNDV344H+scUtKFAVIav1Ywl
 o7A0nsYXzy10OvB223Kx0sfvY4m3sOLL67KffQ3lHOrm5lDMAPk7rmPVDTWRQmuPVSmeqoSFtr6
 kp8JlGa1LR5v36A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Refactor rss_set_prep_indir() to utilize the new
ethtool_get_rx_ring_count() helper for determining the number of RX
rings, replacing the direct use of get_rxnfc with ETHTOOL_GRXRINGS.

This ensures compatibility with both legacy and new ethtool_ops
interfaces by transparently multiplexing between them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/rss.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 202d95e8bf3e1..4dced53be4b3b 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -620,23 +620,22 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
 		   bool *reset, bool *mod)
 {
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **tb = info->attrs;
-	struct ethtool_rxnfc rx_rings;
 	size_t alloc_size;
+	int num_rx_rings;
 	u32 user_size;
 	int i, err;
 
 	if (!tb[ETHTOOL_A_RSS_INDIR])
 		return 0;
-	if (!data->indir_size || !ops->get_rxnfc)
+	if (!data->indir_size)
 		return -EOPNOTSUPP;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	err = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (err)
+	err = ethtool_get_rx_ring_count(dev);
+	if (err < 0)
 		return err;
+	num_rx_rings = err;
 
 	if (nla_len(tb[ETHTOOL_A_RSS_INDIR]) % 4) {
 		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_INDIR]);
@@ -665,7 +664,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 
 	nla_memcpy(rxfh->indir, tb[ETHTOOL_A_RSS_INDIR], alloc_size);
 	for (i = 0; i < user_size; i++) {
-		if (rxfh->indir[i] < rx_rings.data)
+		if (rxfh->indir[i] < num_rx_rings)
 			continue;
 
 		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
@@ -682,7 +681,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 	} else {
 		for (i = 0; i < data->indir_size; i++)
 			rxfh->indir[i] =
-				ethtool_rxfh_indir_default(i, rx_rings.data);
+				ethtool_rxfh_indir_default(i, num_rx_rings);
 	}
 
 	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);

-- 
2.47.3


