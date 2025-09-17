Return-Path: <netdev+bounces-223931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B1B7D6B7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101E81BC0116
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7235209E;
	Wed, 17 Sep 2025 09:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127A350D49
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103104; cv=none; b=HcFckZEuFgaipU41sSJEQxbxqIiJBa7KDgCMOeaD8BeTpPYH89TVK+PceNbyWGNGARuvkgmEKKnoSEbs2NarSBVCVvf9wukPiV9unQWjIyS2l8TcXyOrn2XfwK3JwUE4ZHp0w0xUJrzgeFD3R2nMb2Nr5ekPcFoifasOKtO6tW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103104; c=relaxed/simple;
	bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYpYxmHZDbbMrdtWu9q+MqX/b9p0xpQiLmNC8PzPbiYRyFF+AH5VgDOD8bAc/1ppTqmmJD75eWOTAgIXylBG+dAGLdFZDUI6e3OTFXrdU34LueOSQTwmHTS5oG3DBoRE33KQaEnHTgq7NA1s3JLCiy/cb6CpLAd8UQ0+BhWI8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44aso5786836a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103101; x=1758707901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNdbybFK0ieLurW9tGv2v5Ky8Nf9YctW4a1t2pmLOlc=;
        b=nksupR9EZX7T87nUgA5M/i7e+0zVfX7igK0Du7QELZyaBr5xyGy775paFfi+80g/uV
         bGaZJjaee9VejnAc8ybWEzcEhxRM73Ph7d1cFCnpv1a/g1Qqv8tfidipcaEbj3Rh/mWa
         MUUqCEK40KnonQmaZg4BngHDutgmZaYmEDG5dylDH1uTK0UROtIbiLq4B26ibVxRgJAJ
         USqceR3NAoVpatVi07vdBazkVCRcJlsY0b8tj7CvwSnbg/rD6m2VKTvxdx9AlddXCjqW
         jKnFtLEqYgD0N5U9aMRmVkLBoSGM1LTarizBEvZGIotGMWxrGrCr5460ltJ91PfhO2jx
         Gnrg==
X-Gm-Message-State: AOJu0YzVBHkGV3gtD2cFl4NjCG+BkVvTrRoJ6RXU4OQgUxw5C9xaLbaH
	lRYjnqci9GU3XyOA7jlfvhptIAUAQbFC07/X+dpnmvgT42pBcUFCrelI
X-Gm-Gg: ASbGncsNZZ6x6Dp3LekjLqJEdPvx8QqWWjB10bAfzmiwF9mD5kJ4T7akN4kayxo5oC+
	W6PBnJisjsABmw6N6nZ5WbeIcCK9D/ONouGgrXAtubwFZyUcgySI4VD0NNNU41ji3M2VM523Oih
	pA5tVArQEJoU0RG/6VI9+bqDBmWyekwzInIgWBlqOAxUDJMdVX01zxqmX4L1fOai90ViOaYf7CK
	dptpmN1AxRmCGOI4mnhoXzhY6J425KJVWxYwNVLotUOnL86WBd81VChFGbdcKFUSrf7GmMZ/0im
	/ZauqwRpgdFS7OQH+EGQ6+JNopRgQInlIMEFj6WObGcWxmX+BY2qCHO6vxM6cfOPT6QqD7ETgxW
	mnVaJ0T0Dakxuew==
X-Google-Smtp-Source: AGHT+IF9gsv9B/3Aw1b6/l4dkXEsvW7pOqKmAQvqfxUdHAIvZfVq35PFKiJfuHhddGDPZJBvWjF2VA==
X-Received: by 2002:a05:6402:21d3:b0:62f:26cb:8072 with SMTP id 4fb4d7f45d1cf-62f83c2db1emr1820018a12.13.1758103100907;
        Wed, 17 Sep 2025 02:58:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f86ecf183sm948650a12.12.2025.09.17.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:10 -0700
Subject: [PATCH net-next v4 3/8] net: ethtool: remove the duplicated
 handling from ethtool_get_rxrings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-3-dae520e2e1cb@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=leitao@debian.org;
 h=from:subject:message-id; bh=g5R+KO0zDOkxIkWQNfeVkn9e14oSE0vPMCqx5KVoKUc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2NykJuwtDfO+7ts1cC7uzwJBFwIMlPW4jm
 PiXHqlFAseJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bTEiEACP/jgQA6Z2w3J5keCqjrA25kFufCckFxklkt0IibInyySwrZRb9Wecu3LAA6KJQKPRrjS
 PikTENRkF4T7PpF/0Ue6Gnu3ng4ao+WIec1MfWoS2qMlEr7gnNuvDRkPDpRlq2RJECJAsq03bKr
 xeCo3cif7l4Wq6KbYmH+6CFlcEULzPb7lalr5nBcvL24UedfPdidkZoqpbiTWYDWe9BKDtxPxJ/
 ZBa7dqAzaAsqFBo7pe8PASZ37Ij6InKNDIBroMW+xSfczLGCPlqxdkYVWvQMCElR7/opXQOavtF
 KcWeuJUCagNyiqMjXKEmz6VB9QU/PXp1U2I7YHbykFWUlP1OZa82xtgcjclEkPXj7vZkqas+HfO
 m1/aHDDGFCrtETam1GytzfFCeLSOVEHKyH5jUZwO2wl/tvbx7EE7mAHOahgYQ0plo1cG2thaL9d
 URO/JDy+VNm23sSQ121kuH9KS7qSTbCnK/pBpgJ+3mzPvcsNarMGnoh6IX343QdR1qVvDSJJnR6
 8uGxJL6D8jD4pAmnQS1m5Ni2QDl5XGEc4YzUwx4/73s8beybfs/zzHAJuojGw94ThlmyhZosS1m
 zobe3dnkrzM9m1s0smXKerzjqXhE6PmiarndwYA23MbVJqhxmxFdxz4H8/duNhxpml4eQayO/Ny
 LN8vq/ocCKgc8SA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

ethtool_get_rxrings() was a copy of ethtool_get_rxnfc(). Clean the code
that will never be executed for GRXRINGS specifically.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4214ab33c3c81..a0f3de76cea03 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1212,52 +1212,39 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc info;
+	size_t info_size;
 	int ret;
-	void *rule_buf = NULL;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;
 
-	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
-		if (info.rule_cnt > 0) {
-			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
-						   GFP_USER);
-			if (!rule_buf)
-				return -ENOMEM;
-		}
-	}
-
-	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	ret = ops->get_rxnfc(dev, &info, NULL);
 	if (ret < 0)
-		goto err_out;
-
-	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
-err_out:
-	kfree(rule_buf);
+		return ret;
 
-	return ret;
+	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
-	struct ethtool_rxnfc info;
-	size_t info_size = sizeof(info);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	int ret;
+	struct ethtool_rxnfc info;
 	void *rule_buf = NULL;
+	size_t info_size;
+	int ret;
 
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
+	info_size = sizeof(info);
 	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (ret)
 		return ret;

-- 
2.47.3


