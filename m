Return-Path: <netdev+bounces-223933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E798AB7D66F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B42774E1806
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7635A28A;
	Wed, 17 Sep 2025 09:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE054353368
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103107; cv=none; b=rk13ZxILZhYZkScUUWA+rJBdIVr6sd5c4JvuXJnQorM2zr3gbaqlmfeticwdXs+xI/eGJQn9jJWEMT1t846G91ecwIu63sXC2C/b99z+HNSR50LRXdhWtzpkkn1L6mY4p22PbGIWatrBMHONStnLD8kKHjzlAPRVNAZRbXY6rA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103107; c=relaxed/simple;
	bh=QXXieBKf/qDPoEgfClxj3gr2F5IdggJS5IlfjK3ieA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Erh4PXde3WGLa/R9ph3RU/sy9myMb/iZbBfMr5p2ohPcDUraZKfBer7s72zBOIcuvcvISefsIe77/9+Fqs8i6umcDlSsN4fsCLmPoI8mgvTCt9BH8BJThVCU/GdEYEAsrOE3pop1dqiy+0gkgHbYRFr+RfmGYUa8QpFLVDToOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f2b27a751so4828561a12.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103104; x=1758707904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOgozD00A4hNFRi8AgAmWi2KKHVWlXL+R7SPq6Vi9eU=;
        b=gDhapslEHilldlia4uodZrSg0fXNliAbwZOMUyuL3YzZZmQPwEmYh7C8OBc//M9R2z
         X8+VnYtGDQzDDf0dIgViTg+VfzBkD8m/+DzQGRJWc8N3HH35UFHwuldC8rQw1YG1I8dL
         L8fpnFaEcawbACci8lZ2hrRXlSv2AAZa83vjh0B1vUNBAhkdxgPdM3kgKX48SSVEqZGw
         ws6tcEy5WzCWgpm76Znv25tIObKCu0HNuoSJ+Cmyv75VDxKqf5vCqk3q399mR3YCkRLg
         JinS/i6zJCg8VsOsgIWqeKrFSziWJgae6vVMCnv0C0JkiH8f8nCla6VTbZrdxlZIPTqN
         XM9A==
X-Gm-Message-State: AOJu0YxwgYeru+N7xp+IgMssUig3Ft70sqQ2Yt1IWGAMZpm2NrATCWqY
	knO3rUQVBl7o9N9x3w+j0WY+3b9w2sgl12cGgDJqNfgFLfHBi3elGuIx3CPQiw==
X-Gm-Gg: ASbGncvoKjUKvgZ8XKJvhHjrplEvexjQeuxzr6RvlQHuLUmJUDQF3fRjsOq6/wPANyp
	LCMUhLMjj9qANCiiwSH4k3hZvhl4GD2uzTATmfLfbrch2cfxlrCb3bKoJcwEuCajUreftVHG170
	mQwDESNJCkDOOJNP3tyNKyeByXV7t1FWKvddGegjPbKqbK9CI7EFTzs/yq1A0ZQM82sWLLoQtje
	Qnfb7W84SLz2bCYJHST+EmxfEcQSL/61g1HTng1fPWrztILAHmo0467DC5rlQhQVn+2GZHPjMCN
	YKPrOstF1pJzr9rWawLFoVNoKD6QJVJ9hE6y1oJpoTSN1+9fFhmW7mgR77wTsIzZI18yTgMC64t
	Q6EljdM59Mv+b
X-Google-Smtp-Source: AGHT+IHWhNLaSj4GaBET29vGLJOZQzKQJUIhJjiuxTD58qfCtQouRqIuAShsRH1fyV82nqGogZX5PQ==
X-Received: by 2002:a17:907:94c3:b0:b07:c5a0:fcaa with SMTP id a640c23a62f3a-b1bb6ed624emr165473366b.26.1758103103766;
        Wed, 17 Sep 2025 02:58:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f49d30d41sm4969284a12.15.2025.09.17.02.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:12 -0700
Subject: [PATCH net-next v4 5/8] net: ethtool: update set_rxfh to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-5-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=leitao@debian.org;
 h=from:subject:message-id; bh=QXXieBKf/qDPoEgfClxj3gr2F5IdggJS5IlfjK3ieA0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY25eFsVy8R4NXrf+9RD+lXdDdWZIOeQrhQ+
 mOxxJ5vCeGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bYoLD/92b1Xe/T/RSALr69nvsx9sWtm5Wy3XIYTHPln+VmBNVEHVTIO9O17fDkYkY7FRplWcqQy
 0NWlSnLYVeWYyPmKEersEqULKSvKe3quLbXapfHiW6cW7SmratrEdt4PqdiH8HgTANiYxV00m/a
 JDYM5aW4gi5TGX8ktwKZ3C2d4BRX7xSfUYS3+PslPmFkESkkxko5kAI4S9kI/y+4fz8XLHdR+U9
 rAOEdYD4woePExV/lvMUEsubiXbcbccbxWD1vRucB0k1NbY1bKcMKHn9TH7NqYPM4iRFwo+ma3X
 GOnkTNw1RAkRiXJ3BRjYbJs5IeT0DlPnoSb5IsbOzxGoJhBpatbCxm9Ik/EGyedqgt44wxRlvAn
 cc78e9rOeKuZUsd1T2gi+IFBdiBnWCCSjPq+bTaAMvfxnqqgQSiieigZH4tY7InXvBebZ5Yh3Fh
 n8pO97F1lbgR59Rae4bcJYcVgB7mrQnBAHoUyHZcO8cHN6eLBd98+gviXoI30bph530ybj7+RsP
 hiu+bGX16tSOwb1LwcuIJzQ0se/TGy/7xJZC70L7lsYpws0SD470IBCrwGkGY6tqXAAuV88p6TT
 uUfH0hvBtpKa+B+VTCJHcLHN8mKYa/5eA2rzIuqnGIgQSYyYNuc0vqX3Wv16Oc6+aBzEDCeeXjr
 X96zrOO4jy+pXJQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8493ee200601e..d61e34751adc8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1531,14 +1531,14 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool create = false;
+	int num_rx_rings;
 	u8 *rss_config;
 	int ntf = 0;
 	int ret;
 
-	if (!ops->get_rxnfc || !ops->set_rxfh)
+	if (!ops->set_rxfh)
 		return -EOPNOTSUPP;
 
 	if (ops->get_rxfh_indir_size)
@@ -1594,10 +1594,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rss_config)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out_free;
+	}
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1610,7 +1611,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1622,7 +1623,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			rxfh_dev.indir_size = dev_indir_size;
 			indir = rxfh_dev.indir;
 			for (i = 0; i < dev_indir_size; i++)
-				indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+				indir[i] =
+					ethtool_rxfh_indir_default(i, num_rx_rings);
 		} else {
 			rxfh_dev.rss_delete = true;
 		}

-- 
2.47.3


