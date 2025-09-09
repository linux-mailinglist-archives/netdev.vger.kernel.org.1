Return-Path: <netdev+bounces-221396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE9B50700
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F0A1892349
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD436C067;
	Tue,  9 Sep 2025 20:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA533680BB;
	Tue,  9 Sep 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449468; cv=none; b=JCT1zbi9D4NmPPA8aRQSmyokR3DpzqZST4VZh0s1wCsvp2uitMkouWMJxzanAOhvg1mo2qfnnO2F+5sq1kVtFReOQ/yyzTm63YuRZXxr2V7uAWVnaVjFXRwJiSYCj4MgLgQ/e8HTaztmuyRqBbHN/D6+11DJ5wu41NxLGbI9ZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449468; c=relaxed/simple;
	bh=ENDvyCmUouEMWnICcAv+9Wpzcckm7yI6QkORwP1oaSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOxpKY6DuHIzlmyPftC4qwFjMHoanGlTdPXrDESuridvWO8b204OLxYNoXgPo3YciTyru95ZekrUJGgtTBm8m5xa7sjb5oh9g5WKVC/od+dqCBgRm2rjyWON2CTEWORxr7ocDc+/62vm4OuMYrn9bMnSCeitRHXVcRKYKIT9tPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso6793844a12.1;
        Tue, 09 Sep 2025 13:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449465; x=1758054265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7JcA68BWflQorl8L4XghXGtMkRf6pndxKlj7EAZeO0=;
        b=n4DyQnbiLVEpPhMMmP7d3TpTeTgkgIavW0/SkhB1JC3D/IN/YxJjcWfGMSrH1xEfsX
         xxJN9B984g0HmAJKvzxasx1KLV2wWa4aM5XOU0YlXOq2mkFj1JeDM1m5hnXA2Qo/GWAQ
         YJ2rVMVKGWOdMKpTM5pZKP0/NKvJUdnXiTHXCoD6r9TVYKXJTxQ9wQQDYvEQTethXyEI
         ca2XpLOQOIWBsjJapTLW4PLf8QwOc3e2lwxRUFmRvZD1RLVRlf+xepf0DxLRXEJx0zB0
         Q6QOq85psqQUvxJ6Wry4t2cTukWiOvng2amKd7roCeir7REIH73lsKZCxQp/0nrUUcXd
         P29g==
X-Forwarded-Encrypted: i=1; AJvYcCVSXoD7qUpmqtWwTTA/cgcX9ldrNf/k8jhnOT9oC8bEx3AwwtTKQjHy3OlKzAdZSqjfhOK/FHVhnQs49eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/DHVCxwEmlfmvjrPSwG8MuyfP0reKNLoRpAAEpmUEEfcQbHd
	jYgc3B1zJcGlLKyDvtqD8SgvTvEMlUWOKuXccf95FS8hkfYSZNy9I6Hv
X-Gm-Gg: ASbGncujdB4K+oIgcC3D7QEwTaMtz5mus2usSU3UzRNP2Ta+xZaWtj7LNEn0Vdo1N73
	1hPI1C9oNZF8KYnIvOpi7TbwapL89Uks765ijcxT5Z/l8dBXdWsfZZMYP2ymFPv3qFE/J0DIZqh
	bpRyYaLTJVk1+xqsClYDmBzOuAIZjbc5bZJhn1ksNUJ1yEUlEhD1zqPljc5BNELiTJh0kEaMuHu
	FpLB+VM8bCO1d7Y6LhgxH02RDfb8JX7BewQoYbsbDpBZ8VHMrk3kV0Aj7dysI3foO+Gzg5NmV/0
	WNRAvenDJFqrWfqBYWI8volwufrMrPKWZwcXM7eDm9RAcZhxpo+lKp2JDPQnFA5k5mK83SfOQQV
	FujGwY560ZR9C
X-Google-Smtp-Source: AGHT+IHIw3iPKDV1vWderLLpj7uaVewGmDnXc6kNSwmivEEBZBMQGgXhlB+h8hbRz+EiHpgTlyf1MQ==
X-Received: by 2002:a05:6402:a0c1:b0:622:dccd:5bc4 with SMTP id 4fb4d7f45d1cf-6237b874019mr10592451a12.11.1757449465197;
        Tue, 09 Sep 2025 13:24:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62d4dc1eeebsm28202a12.44.2025.09.09.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:04 -0700
Subject: [PATCH net-next 6/7] net: ethtool: update set_rxfh_indir to use
 get_num_rxrings helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-6-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=leitao@debian.org;
 h=from:subject:message-id; bh=ENDvyCmUouEMWnICcAv+9Wpzcckm7yI6QkORwP1oaSs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzug3YaluYZkKF3NPcSGVE9em9x8qbiTColk
 fhKtXemXDmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bXKbD/9tNekNDHm9beR7j0Fv1+YjyqCdq++2IeYemh42nNxcQkJN4njUvqu+Yqe/u9+N0LY+eZb
 c3aB9+UdyD2v6InGMWwk8KSqcdSovRJ12Sk3egJfs9cwtEnUtNqYMfx59omp5wRHWZ5mNFj7ZAw
 3FDnDFTgkUQg3kBpbDlOunouS2B0CKcCfHGBUj+N+H3MzUZ3PgAcQXNny2QRiZVhYSnUo/SBTJC
 ogJYoaiWiL9TZMIJWTdhN489YGb8bTy4q5cyEQPKMFnx9sIcj+OZTrWNivbPtTpH4mz1hOdkh+q
 ToEduQlgHAjaaraRCg0I8a/p7fCZlrpiGKN/dcKxC+K7YjMnr1MXIj92pxIFaNrBZbSddkt7DIO
 mZ8pVdcXvssUlYMGOyh+E7Wz2yuuiUVx0lM2Fz1g+c36ry9v6r+4CJrNiREjHvh/XpmCpArujvl
 gnPbrACmYv7PSAAheSZcEM0tkZn0csZfQZAzDIJBGRSvDQveiW2P1Ckm1O/mhsbgoB3Z+GITvmI
 sFnmjUCfV5tGfJVV8cFTdBr7E7UOhY1fB2kRr6sDejgrL8//wF7cLcgaYTUqxLsozUNNN1H39mX
 G13I9GYPo9AuZUme5taent+0jEtmH8PA217vTn6VYzdK/jgB4NFEOPattk4G4r5hwiwDVsHzD33
 AxHXvjeUOriAl/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new get_num_rxrings() helper function
for retrieving the number of RX rings instead of directly calling
get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 227083a8ab860..752f185d2d7ea 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1364,7 +1364,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1390,20 +1390,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	if (!rxfh_dev.indir)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = get_num_rxrings(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out;
+	}
 
 	if (user_size == 0) {
 		u32 *indir = rxfh_dev.indir;
 
 		for (i = 0; i < rxfh_dev.indir_size; i++)
-			indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+			indir[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;

-- 
2.47.3


