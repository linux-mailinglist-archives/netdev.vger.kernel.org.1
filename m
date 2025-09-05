Return-Path: <netdev+bounces-220430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B2B45FA4
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE12A42393
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48A35E4F0;
	Fri,  5 Sep 2025 17:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF54313287;
	Fri,  5 Sep 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092063; cv=none; b=VhFqJtigIYILN6cgQq0ob1UEEgplKh2dUtZSzhumyol9WJOG8DIuaRre8+6DPLcXzAUWnV29YFpl/7YwEQzsyVFZWFeHR7h1OsmUWjVAYb20dSKt2IHCmbcPu+Pdc6GnwxxbFWxc1Dcv/KPnc4CXByTR/VD9C/nd70EajlIp+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092063; c=relaxed/simple;
	bh=EVX3rLFghruPiq1XL2IrD4i1q86cWmPVrWJL5Cu3vjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRc6hETZZlbqpWj+CxSM2YNKkO5TyGftXbC8ggV7iEpaN3UFoZA3vMThlvHycnHEMw1VSBSxYIc5nwLSabCxm8pDeFIX0aYNpZb6+GV2yH2ek1EpVHIG1oPF6nSK71eSiCe0jHZ3AsahRrNxb10J18liP344qrK+HmXndb1UgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so2514231a12.1;
        Fri, 05 Sep 2025 10:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092060; x=1757696860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enK2RLL3LGNwUswiRLlXEekGpfyfpNr8qEb0IuggtGA=;
        b=BHoqdsdUAn3QEHCXcghMA4gyLBHdsSarzZShxjBM9DIFsF01DoRAHcHbcA3rltlBaF
         uih4X/+Ib5N0X7cjXg8gOkLrdD79fPDFBpQAMjO/0Dw/s6px6VpeVUFSNR3Y8OG6M4Na
         Cjw0KNfXbLzCPPi4Hu4f3r6RJ7RZyELFuVk8LZdKG++HDJr9kndQcflLfw9y0eNSA9nS
         myh+S8SltRDuOEyMpb5Wgi0j7ReQbc+6gl4QxZn4vxXbcxu+l9ef28xmyferTSidXUb8
         qzz6YaNOY+nRT/dqHpqPT7o9rkSZ78si91HJJEcE8uWyulqb9M8SJ8SQHNLx2wZdMxfe
         1aew==
X-Forwarded-Encrypted: i=1; AJvYcCVqnG4kOQTkI0jSmaUACw+Teq2cg7HFtEZdD8Fm9nIDFF8ICr5eq10qsy7G7J497z0J3MxAbJs47JxnuFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHp6rMNNWjCwrjVkYkOfq82VlKxOsTJd9pkcFNBkTZxlM32Lia
	GfzpFslBHeHjeISl9NolnSwMWwaS2ODrMRFID0h6oo4qK5M0EGcEr8iu
X-Gm-Gg: ASbGncsDl6WnUxmSCw2sRJ+qpAb/n7Vx6B2a9SKqVzY6is1t5lu3AgYzbmZzuZ4Y+5l
	/TL/wOiiWljLNlktOMyZwb6KHMX/xWgkdta1ltnCmXE64kU1V7IJGOtQxvo4mSNUBKDz3IDe1XH
	tdm+gAKXPT38wbUd7PpENcXdAXhy6ADIdij6wwt1VPbOwzsMf++Wpac8mjcpw25LMlh1J2FZWhX
	zlU79C0ICv5qlDO7UXU7UgMBiyKqY4j4Blxx0kHLajcUTrNO9xuv4H1aFzyiYW2zn6S40kR6+Gc
	+d0kkinmf7ewQhOUAMb01Djf+8DPPqwGYaUWvCJ7ddio0tTvjuJ+8w3ajWceVFZ/dF+F+KXOzip
	Om+qpbLib1cN4sCd43CLb5KXffCLGayOH5K0=
X-Google-Smtp-Source: AGHT+IHxxIKU/QIpfoYKZ0n3uAme+aXwYNKL+iOjBsrL24sOi0np0inqG53vPvgoepOoAiJuoI8BRw==
X-Received: by 2002:a05:6402:5252:b0:61d:12df:75c7 with SMTP id 4fb4d7f45d1cf-61d26ec99d9mr22274475a12.35.1757092059851;
        Fri, 05 Sep 2025 10:07:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52a886sm16601824a12.43.2025.09.05.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:24 -0700
Subject: [PATCH RFC net-next 5/7] net: ethtool: update set_rxfh to use
 get_num_rxrings helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-5-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=leitao@debian.org;
 h=from:subject:message-id; bh=EVX3rLFghruPiq1XL2IrD4i1q86cWmPVrWJL5Cu3vjE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjSc+6vRRhaibZiaSOjhLELTodvncDUilHJ+
 FBe2U6tnUGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 be+1EACroSZI1BBv4XxZsn+FEIpg9NWuRhLmEM1e75InHiQYW+gHjqX+hAqa/8ayxNwa8prtAjW
 BInXgZrEm1VBgbtx5CLPh1lfSSOJZ85EFuKMVPu2CoY3W0fjSnT8BhiKDJIPcr+dPUl1nYVUFsD
 g1c+2/gYi+cjq82DlhRdy4ysG/RpLO5gLXmKJZmDneabzwGUgOGthxaL+n29AIBfrbj3ybUyAHC
 Fmkl255MxdhnTMe+aoWmamrPYHW0ILAHCFG2edAO3JzeT5FCKhrXt1JoevR4xu/1q7Tj8YbdYyb
 abSIqG4/70pcVKl73ltckBxA7hgNi1GgjclzuovapA+poxho+Yd3OclQmkBEsjAvPbAu3o/HBnL
 HonGtzOswXL48fvFl0XhPfeCvf5ESHM3extCHKwDZ8z7/dL3qssyQQrmO10fyhNmUCW9Lv+f8At
 D8I3D1ETHAVGwJjd39ulNFk3g0pAfBTfEb57MhvUa4peTiHcug0vqNcR3NnjQWDlODgVAXXTyH+
 j2LqeS1bGpHb8loywJGhLaXjFtRtvIiT2XzpObeTymL/Qk/R5JHQcARJ+L0vRZjqMpZIOnYRvkl
 jaG3lE9rhWsQ8yKgXhN9Ck2UjZiT78vssED1QCuDZh6i4lBiPx8+r1ij6sfAP2RfKO/GolTthp8
 r/zvaMlgWVcf2yA==
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
index 2f3dbef9eb712..daab20b392f7b 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1548,9 +1548,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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
@@ -1611,10 +1611,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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
@@ -1627,7 +1628,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1639,7 +1640,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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


