Return-Path: <netdev+bounces-222997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E63B57738
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DABE3AD306
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F83043C3;
	Mon, 15 Sep 2025 10:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A1302CD8
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933272; cv=none; b=qDp7nHlNDOPxkT5q96J65ZWD/kJ/LfBGgdJuEil2FDg6Too1Z1ZN2DgTa+GwEUTxmmixPyuJd+qoMvtZoLWSCGRC2bqHTpFekHP56WY8Yvv1fET7OWdWvq+Rz3YzvheGXnegHf6a+8L5ifUPQfuuTfjxDeFkD/isEHKxWbAkbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933272; c=relaxed/simple;
	bh=Eu//yE4c+uDioPyDYhhWP0u0k0aovyGvDUK14dk6hs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQBMWqsoVfQs86bOIJxU+NneW1MsRVOKAXbk77tdKe5RIXW7pHkz+N58pHNwGeEXQ/me5LKAhn22nbCnW6Gug+F2E9iNG7nxbbtFYE8TeFdZNMXJvBRVkD8RAfnFRFvYGYj82FR3fvdxaSUwIlaTV7GzvhJQvXBWwsrssgoGz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f125e5303so2368206a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933269; x=1758538069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/aC7Rw2Q/TRqJF9J43UBQHIqeXm4GXqxm40ob1/fn8=;
        b=NYwXQSgK8Wja4lushCLxHXFQUmysAcsBDu6JtdsD2LLY3KR8YKGbBFfkDu8P3jWHiC
         n8xpoNvkE9kgBP01LUjb5ijhJpzCRgSSU2TYIbyayck7hOm/PN7SuZBMDyKCmirFJzmn
         KUCx0zly92Q420IsUuggWkIQRAT0F7SSyhKQfP/ORhN2FBIjZ+NURACrM/GvSOn3QiGC
         tkUs5ApxAEl4ibRy8A8x5MoQp8yEwGLDap6M8KVmczm/nir+kc0p+iRlkEbJgd/0bFRG
         mDrL5L6Q0mVPr/aZVcAo7md33qRzoTkC02MTgk0nsLebmr7ZYdfn8rpQIWvmdlptvf2i
         XiRA==
X-Gm-Message-State: AOJu0Yw065qhcpvnHzYYr8kV1tOA9e6Yzoz8nVUvSfknUwT2RMomsgUX
	7K+/r0FoksSAMypTQS/ugiUKe3JDBtRSH3C9mWjIMF1/tKqarsVbnmOs
X-Gm-Gg: ASbGncuqkTYdogcyZr1S2fiMDIHl/YLfDV4F7QGdq1CiGcnVj+ar879iaoQSV6uWL7d
	GB3oMWbQjT/OV1VZGHAcZhUVO6TxG53tnuC+t1fnmT9VjgpqpWYiZUXFIyUrGKjyAAECayofNoy
	sIZZtS4kRvPGVN1fsVfSJJV9qWy7vzfzJAyMazgQv17QEbPXPky5FgiAijlhSvveCRavO1VJpst
	RqVH0j3uZWAD/9bdtGOhIVpphqMhDH/KGbJYMliDuKG1+ISzZzGVi/CkuAMXtsqZEb68SQe3yoi
	lxmGVQ/PjAko7FHHsIh6U0BZS4ckllEiOFhVn8GrEPIkU/zlmZ5SoLONR4c5Vkz3DOGUn/WDhWR
	DgYXsslAXUjHv
X-Google-Smtp-Source: AGHT+IEwH+gY2LJbNRhErpOEfDFHnDCncEuToIY9IAIehR8mc/uxvCTxJ2xnSL6UynV4TNodSRjd4A==
X-Received: by 2002:a17:907:2d9e:b0:b09:6ff1:e65d with SMTP id a640c23a62f3a-b0970012972mr751793266b.61.1757933269248;
        Mon, 15 Sep 2025 03:47:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e602sm918832766b.105.2025.09.15.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:32 -0700
Subject: [PATCH net-next v3 7/8] net: ethtool: use the new helper in
 rss_set_prep_indir()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-7-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HT3sixUggMAjXwTClt9JSZAR5d3rNmRsoX
 Lv7/Wpb2ViJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bUltD/9wAl+e9m4yn8qMCqpqsVl26+O+hsxAmnI+nM6SzM4bP7yDwIfFAYQZIHZQQe9etCynlF2
 /yYnLX2JEVbpiXY1b+fnMv9GIMOwqPV9m5Cru3eHEND69o9z8I1Vtb1vw8WYOvhOMcvfaKWxmRB
 T4hlSuSCad86h1teec3jczxqw3C62yHiYk8nzK6+AiEnbR8jTJ/YVTlCNNz7srSSVq1iNwBV/P7
 tMNMDJdybt38Y4nMc9zBGf68hCNCq1NjA2dcQW7q3y9OrAr2cUAf0x3TvZBuWUWF6XnY3bErpnO
 WH2g4DMPGHaUfk9cBvzrLgNRHqoCVVEljmpw73oWhbhu4YF5CZQkOSAEaOs8KBPKyj+NGPa+lVJ
 ibZJepaEx4VK6GKGqfHrLhw3hxACHZ2VHtO/epWL+cFtqDYYQcicPeqqIEk1MkuSAjm2Fw8GxJM
 YJl6LkL1x6m6t1KplTQTiAmpKweLCxenE0Vhx3rXTwma0EsJZlHIzsZ8pmi5BvA3kqHb73jVnG0
 S6ziZRmZfV5oQOejX2Ngup5SWpKwy1sEVGCyRUDxAXsPRHR/NtUWgkigvio85M2gwdFqyJYRNlc
 Ml9+U49tHtCkSEUSZPPm0QZ0Ty52PZoAYZtJNz0rvxsTEgNyxeEwL3y2AfqCRO3wDMyIGZmsvc0
 bS2+Cdbm5JHophg==
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


