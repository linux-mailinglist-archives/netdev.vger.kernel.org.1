Return-Path: <netdev+bounces-221395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C6B506FF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1032D3B68DB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34636934C;
	Tue,  9 Sep 2025 20:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8E3629BD
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449467; cv=none; b=usowToEcdQSZViN1Em0mhAjx94fh4TdY9vjV/PqALYGcjMHrd/27g4U7RK8//zdwGv+ZzGTrI1p7gM1c/6oA7EFucYPlaRNP0LpCdDQDDXjrf0/rB/aKePKi+AOHVbPhHbMSmuwSeyRIpulZMz9/3suSiUHLQ+zkaAZJQkXCJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449467; c=relaxed/simple;
	bh=HinHwRyIkL/bUH0IHaSksm26uojiJmGw89oGqZe5KEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R871A2yAkF/aPLwn9mI6HX4lMWThKhdBWQRDorQgNwyrtL/IstXGtw24Mwc6gdZx6C1x8Gkxjp0MZ6vGkSAxiJG23Nljenkn4n609aMvc779cxwB2TRUY+w8mAlUX15rvbU9/yBTWRSUXEn5c8FwpMSvE/M+NdZt4EF1nYm8Shc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0472bd218bso935927266b.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 13:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449464; x=1758054264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlgNd34WwD8szRp45UOqwQH50pjYmEpv55onwpKoXk0=;
        b=jfc+nA2ERE2VB81JLHcYd1Q/fSaC04wvgM+BqrfVwv/2j/ZZh6jsH4T81O4tR+FP8V
         eNYOmuXoB5ncYJaoSPoyM6qkNEVMx6iHkbCKzQuaoxfjw+gukMZPC8ZlY/u+k5lU2y4I
         Bhd/b5oFq8T5+6J89mpC0hG2wYQYI8zt8e8VdDL7CZDAtdxyX8V+ttBSAwGRt+gNWp0Y
         V9zwIjxSlEgSm9MI9S+CBIWpYH2pEo3RHaHiIRnvJdApfAvsgma2PX/vmnceNNzzwsd7
         imYVn/7xXcIMPzhICiPCgdP+s3jOclhZsnhSqUH1zSE1Tqjq0X3MdxlfW+xUnLjmfnWn
         S+VQ==
X-Gm-Message-State: AOJu0YxnQJS4jam8R6ttn8n00k+T6euz4lzHQOArnYUGojUDaX0eoXPM
	wrkLKrKDp/DnQtsPXPzQ0iRqFLup7SBXHO+P44Q7vNPgweMuo7MCWpSA
X-Gm-Gg: ASbGncsN255nlsSx9npiQs64K0aAZ+U7S0F0t+GJlhqbEL6/91Dj/Psw5KdEQ+wnrZu
	aCjBwaeNLzgqIbWHGEgb65Sw785Je1qOIGL57BBiQ9c0OOgtuSYqRt3skE1AAUhKj/+WXpxRp63
	HvXOLrAvVUHLkZHTskK8pHhVrGJG8nHvpJGQoyUq42JNPJPVBbc87O1a5t5QnjFgnREA6n4Hh/1
	lN5NBOT7SzkGeTLwtJ7j/w3HawFJpBvafn1NwPvIsvv18UEdRPDCFlh2NvaNjgyrAlPG5p0Y0gS
	sDpjgJA7loXL/hij/d+BNqAVBj+gBHprzWuNQ4cmRS+i8H3Qm8Z4j8YK5wdmnJPjPqNlme2Op2O
	JAb/o9HOukEF+UwB3V7eDgvYw7WWaPwE8lg==
X-Google-Smtp-Source: AGHT+IH3pF8Vy4sZg4snh8qN46xVYLqJzaGCcuhqSAUuKPwU+XxCWEAlk24h6RhAFoFpj/Q4RwQVWQ==
X-Received: by 2002:a17:907:94c4:b0:b04:3c00:b934 with SMTP id a640c23a62f3a-b04b140d070mr1259321166b.21.1757449463813;
        Tue, 09 Sep 2025 13:24:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830a7598sm47463266b.24.2025.09.09.13.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:03 -0700
Subject: [PATCH net-next 5/7] net: ethtool: update set_rxfh to use
 get_num_rxrings helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-5-634282f06a54@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=leitao@debian.org;
 h=from:subject:message-id; bh=HinHwRyIkL/bUH0IHaSksm26uojiJmGw89oGqZe5KEs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzu4z5A3Tso/HmRI6tV2dYxlJ6F912wdfJBW
 XjI5tvzsOSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bcMED/wMPeFm06J55xDZwYBTpb+Ozu+iLQKa/RieuFubAifpjD/f1ZISIoAA9xPPdUpIl2vLXOv
 Jrb27DU2QKU4KUWNGIqaMZ84Y7FKE7wRHjqNPJnhohkjO0ed13bCw2joBNLXDakSjJnUXQz0AfO
 DgNfZ0VCl9MueIMFkRmV/v8gJe8Z0mN8VmrQiQ2LbbGGvYyQ7vLvCIkYhr5XITXucle2EqJysmw
 RncNAKzflTMsk5KvRQIw3REZKy+8Ld1TD7GzxsPHP8bX9y37OcStXfxSMqvKGB0Be6n4O9xo4d6
 KHjiI0DMiulKSGyuIwIXRg0Slf5UgG944fnvgVKHTA/hI8CajRBc2u/QQhmSLiK+9izJRIzdv3u
 7DHtvCgpN6lBwZZtTZMsBxuiGAwFYNzepcmFDrZ8LOlnNB6CM/DUqIJCd54lWkuWo9gSFOY0Av1
 btGc0xNheD5fGMSZTWc/ytMJAZPjdU0dFnEfHze/qIT0q2E95otGjh59shA+kdHzEeQYU61BYRe
 fT/SaKSr9P9mJALPZmexsPfl4podLA9O7N+ok7OhNrpm/xiwU2DDDG9QIgT//27BNhnHZDea6jA
 OqEMSIuVqH1J5DtMNy3oPBtxPYPAR+f2aANeu1pA5cA+UDbl9AAZ0OSL7qBTNFreGKorOilTIkL
 NAotZRPeZm4dhrg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new get_num_rxrings() helper function
for retrieving the number of RX rings instead of directly calling
get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index aba483bc9fd85..227083a8ab860 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1545,9 +1545,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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
@@ -1608,10 +1608,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rss_config)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = get_num_rxrings(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out_free;
+	}
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1624,7 +1625,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1636,7 +1637,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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


