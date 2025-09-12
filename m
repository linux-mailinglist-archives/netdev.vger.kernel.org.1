Return-Path: <netdev+bounces-222657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87FB5544F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AFA7A8914
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894530E83D;
	Fri, 12 Sep 2025 15:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B103203B7
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692780; cv=none; b=sZQZoP3pcqIftknTiYKDYq9E5ov4pAyhXh7SVZ7EhB49AZIU+TzbELmNbeeGZbn+I6udIsJqIszjNyygMAiaV3uxrhshzqci0McoQ6RhN9tjcc+pF0dOyk/nsf0+ejbNjujbJUblfyRa00/wuUNgKbvKZV9DKOEs3pYKTQghres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692780; c=relaxed/simple;
	bh=+Cyg8fYez6TSqkQqySfOA53/MjPLqa4vHVdBzTfcQyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBlyhtQyq+nrdRv1rwEVxOKRFC/JyY0Ovip3+5sSvq3oM35kTcfmYqHb7DXOiOieSA5j65epYnjxUstL2kJuikJ10xpQvoW+Rg69XFtpC3+SPZJYT52geAVE+kniFvlVKs9XSqc9denCTEMIoXNASYcQyri3rhD1VWopYsj+uUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so326372566b.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692777; x=1758297577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDEVJdYmXjRIZdNwmkm1CN0B9UrWr+aTfgx+0lOTdy8=;
        b=fsdgw+wG31ag6n8cZpmg17GQ3XTxwiJ0aIJ876+31DRKt0Y4g/FyvUmkvGOjKVmmG8
         Hqz3aaoMAm3nvYVkc6fWmx4dRCbRcD9+WOJb/0H9jHNiBMp5yAEbkn7VgZcxRVMBvFnp
         mSv3ia+eUgA/8ikDTwGBgyxEPSJUHVXhLpzUCs8BjyzCzPHExvX5uQWtUH8MEICya7qE
         tOZFZJpWl93dBK6N1TJRByM1B41Eaz19+GwG6TF+94eT9QOp+eICUGRdfEeMIs9afjfQ
         q9rxatvTb4mOkL7sUwglkalnVgghqLdRtTUJHcpNDW6qitHtZ4mnmVOnvUPecRqyckRc
         Plgg==
X-Gm-Message-State: AOJu0YyX4Um3erVdseM0HF6u8/3q1BpSzteeDyv4LdyJvpWJ91xdBo0R
	Em9aiTAWZsgiD5PDEogDCyyJzraL+7B/tR68YS1mQj0OvX5Y07VXC9vu
X-Gm-Gg: ASbGncuQXy1D1d+Yt+HXsaIKsNHfbQWtpH9uQKAXpEvOWr1EG/TkuHhavUaT6WBSFBT
	z7MES/mnGkuyT18BfJZyBsHUtjXHVJ7eAVNwAfLC986+g0lsnRO5atEe2jSvh2SY+MFfOIGwZGG
	L4neQ0RJ4gixi9k7X+KldZtp+n6fRHK+CmUWBaw7D5+ioVGOwGDoc8E734aPFscRSfhvyLjX22A
	gikvQoCgd7IqqKa65tVRwmXnuPaaR687YZIf0g73RsuQB6F6ijiafKFUgEpm62LBBIWx47jHnHA
	2zwuuxCc9vkDpmsLZ4GiCe1EhxgkOWYR8pJajUifQMMzwNrIfALoaKg2hDoPIfkgg7oRZnco9Q+
	OKF06dSS9uNcFLQ==
X-Google-Smtp-Source: AGHT+IGeZOJfA4BYuVq5HIBmnSMrSvhAZUV+17uTbGUeRylSUyMC8Q9l/3TI3WqxzCCNRy6BdNSpCg==
X-Received: by 2002:a17:907:970b:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b07c37fb563mr287410466b.36.1757692777007;
        Fri, 12 Sep 2025 08:59:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334eb65sm396246166b.97.2025.09.12.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:15 -0700
Subject: [PATCH net-next v2 6/7] net: ethtool: update set_rxfh_indir to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-6-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=leitao@debian.org;
 h=from:subject:message-id; bh=+Cyg8fYez6TSqkQqySfOA53/MjPLqa4vHVdBzTfcQyQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeV/U+AoSVBvH29w1x5dgjHI+lQxwjy7J9E
 oLedliMp2WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 baEJD/0XwL02qnUe6HDYNlGQqcQRWFgZHUKCbBy3LsFsKxavtRdpdQqqU6gwdgBSWl6krL0hWDK
 0dsvkqpzcReVpsyA7LZAr4TW5aKao8XHxs2wBO+LA1pAmr9qSjpJDhcwgmLBSMZlHpleZFYLcPr
 FRkMPSYglEJWGV9+rE4IpJ8hdKgvHDlTtohIa9r6YqpGvc3Qgq2Usbf80AWHJEUIhjavNbPIJJ/
 Iqz4wYohMKlNB4wpYc+3kV4+lX4PNzGOrvt71PkttsY+IZ2t0FCghEjlnlCVpl2wLihJFPJcg/8
 ajI4FSPvrO6qluUJyLY52z4v7muRi2h1YdIOzPleNmWid8DlyzT+7konNntacaoodEplEhoZypp
 J13opvchnsmb9T0yFUPoyj8zNL5ZA7XEsmmH/jgsZ/m5uWFbl0W9l8ZLf5faMGEaal10qM13lTT
 vGcHnzSlf+RwrXQzJdgSqpXHsUcEJExwUtoeZKBocGxEEiTtQBVcKnlJ684pNg+89Z9OdiJLjYv
 e2BV1XeATyu3vdTQkvvX0/YmYQAvlpSyh8GDI4qDKNE7hzFXZy1q69N5VsEXa9jfQQL6c5s8OI1
 2hpJ9Hf3YVeHu7QPdkLKcs+Dv41dn9/LAgCbSFvgZJdzoBvVVCQ0+3Ff67TpQvq544GBle5MOEG
 7v7ZXGc4YB+Qk9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 01db50ba85e71..c95edb228c3b5 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1367,7 +1367,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1393,20 +1393,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	if (!rxfh_dev.indir)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
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


