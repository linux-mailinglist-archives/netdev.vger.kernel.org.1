Return-Path: <netdev+bounces-222994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE7B5770E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868AE170C8F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0430F302761;
	Mon, 15 Sep 2025 10:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE230216F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933268; cv=none; b=mE+6UnRXPvOI3mNmJGaOZveuPSDqIGjD2Kzrz1BxQfdv+vrXcQrSZnzV4f3HE6XviLv6CVW6Dq1fgmtcoVSsWUmyk2qzsYaQ3snKBgQOJc3/QBZGkyc0QmDZXVLNrFV2GxTfy2wCuGUi81vQKIoqrSCLc0tpwbqCqJ9UNszjDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933268; c=relaxed/simple;
	bh=b8e8OaWNtnadVIxSNP9KePI7AvW3rS2UHvHFSh890lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8iz0bHOw+AhSUjBKapBrquf8BM+tyRxuqTnS/FqILLkeT5naO4C1SQYmBLrtjx0jVq/kHAFoe5VpV3GOKczw4L/A81eEE72g+2xCKSl6hgEJWGuboHpNpU2B5MwI/JoSVGV7VWuJX27YpEWR65mYAEzf1y2rBZcDdqO9TYDyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0411b83aafso600849966b.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933265; x=1758538065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7HyATeze4iHdtm3Jn5UcYkJ1c2GNNZC+W/TqjLRDmY=;
        b=P6np5WH1iZ+b469cKY3uAomalt6ojxnkwtq1al5ELB6Yc9dl+WJiMP8knDFTbeSIps
         hZXcPbwxqzRwzPJC5dPdVc7ATAH9j8KskTS0fQJ3HoSkpVz2cs/nvS2l/ddHyX4YswsG
         eJDs2jW8LY6Nyb8xVz2oFAuywRnw/F0v1xutxoTaBaLGcDCIp1EpkD6/9riFBqevCd3Y
         elDG73VZM6VRlqfG1Gu5X4gPRg4AGpIB6YgVmiERv2NLUmVtaut7CADvLZ8XRp6oDrcr
         zjN65SkmWNXkbiyhQ4Gll2FJxWdtIz4kCGzMAZEKby+hPZnFA+XPVb9SgOK5ymhLeO/p
         vGOg==
X-Gm-Message-State: AOJu0YyjfhV8WxjS2AfWpWxqgPuegviWbaM+uQM0HvOwLpzSTIogC1X6
	ZJ228OluURBxsqI1JXz0eAQQBBVvT7/acULrX//ZPeDSKZFxvIChovK9
X-Gm-Gg: ASbGnctd6UCG0LpdCsFtRVPQjRnAy+35ERziK+mlQZm5knNeeXsHvNyjeMz0jIqJO8S
	/1esMgcoVDl6Jidv74FxxKYeQ9I2ZiH6fIhxgwzpUJR6+7ibGWeALkBt2tNdsBIYyRVi8jQYV3V
	1mYPNupQ19vWrH1qtcAavaaVJhfFgCLwNM2WW4SrimDPo8LPyDjmyVBl0h55mFO9rBdRlaM19jw
	3/u6g5A3rFrvJXgxlqrUYFvbUTCxxZVVtBhyoaUnNK5qUzXI+QQY2BOydxZi1DnbQ3eB5nH9qjM
	QCMKncrB3kDlL78RP0Q3SenS4FTr2iVt6fXaiAqLyOEa6JRErJY5FgTXY2wMrCqR+5KV2vdAlfB
	eZwXKU7ndUz79
X-Google-Smtp-Source: AGHT+IGp/mJO2oohkJBO9wkXgeZW6c1+lSdmqvm9cI4B/RVB1WNWpeBKx1eZf48BYogf1YjTyHGKeA==
X-Received: by 2002:a17:907:9617:b0:b04:c7c5:499d with SMTP id a640c23a62f3a-b07c3833a41mr1095994866b.47.1757933265119;
        Mon, 15 Sep 2025 03:47:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm908527566b.67.2025.09.15.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:29 -0700
Subject: [PATCH net-next v3 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=leitao@debian.org;
 h=from:subject:message-id; bh=b8e8OaWNtnadVIxSNP9KePI7AvW3rS2UHvHFSh890lk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HwVVGDRCgyCtSdI1fF4Q6fbRHuHKhZJjhV
 IHl21NhkU2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bSp5D/4mvnlmyjVJSm/vLWnl0aLz3ZcZoum4iaB+BznlaOH0XVWCgGs4WSLKBBKjLB30Xlsg9WD
 NiIROe1uA/sPL2U2YRLnvW38W720g1vf+iFyDCiJ+/fYcc41l06bSIvtcxZdwezPs2JLpVuhwQf
 o86uQdBdPDsO5kg56YDD/j2W49t36X/KhVkDN23PJPPn+VFRvsLdNHSMDGO9fuc6gPFMRqyzNmC
 rJ7DOCarl05LOScu+uap5Xyw3kICe6fPMB8/zUQ07kXI96IY7+F5cTR0Ku7aHqgRiSKcXGewjhd
 bfYaK6RoTSLN1wxE708bBcfP6d+TVDV/Mx+DkG5E84b7RdVp0jssyqq+Pl9GDgW2Aqfkg5o8r41
 ntyA9eDoq9OFssebdIvQh/ZZMKbwq///I3dutP5BjH0sIDTv3Fr4Vrl2D5Lp6Ug10IBaRK4iseY
 TKt2DHCl7dp/ysGGtWHp0T6Mvl43v5rDFTp7CJpuzpeLFxs7C3xhAFmqyEPYPeVY/Z9bb+riezd
 wd5nEyvCRT+5HvntJ3i5S+s1PLNCuRCRZyCJuisTiSXhJeFGoGOgDFEV/Qc+X7e4IAtFY1kD2tx
 FZ+hObN5WQIt6R/citTQ4/JvZKvjiDmdjIQx6VExcrHJv1Tpq21gvC4AxBtlGXyV7QT50/hsLfl
 Q4I2ZEakH9zxwtg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Create ethtool_get_rx_ring_count() to use .get_rx_ring_count if
available, falling back to get_rxnfc() otherwise. It needs to be
non-static, given it will be called by other ethtool functions laters,
as those calling get_rxfh().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/common.h    |  2 ++
 net/ethtool/ioctl.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d7d757e72554e..c869b7f8bce8b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -968,6 +968,7 @@ struct kernel_ethtool_ts_info {
  * @reset: Reset (part of) the device, as specified by a bitmask of
  *	flags from &enum ethtool_reset_flags.  Returns a negative
  *	error code or zero.
+ * @get_rx_ring_count: Return the number of RX rings
  * @get_rxfh_key_size: Get the size of the RX flow hash key.
  *	Returns zero if not supported for this specific device.
  * @get_rxfh_indir_size: Get the size of the RX flow hash indirection table.
@@ -1162,6 +1163,7 @@ struct ethtool_ops {
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rx_ring_count)(struct net_device *dev);
 	u32	(*get_rxfh_key_size)(struct net_device *);
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index c4d084dde5bf4..1609cf4e53ebb 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -54,6 +54,8 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 			       struct kernel_ethtool_ringparam *kparam,
 			       struct netlink_ext_ack *extack);
 
+int ethtool_get_rx_ring_count(struct net_device *dev);
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 int ethtool_get_ts_info_by_phc(struct net_device *dev,
 			       struct kernel_ethtool_ts_info *info,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a0f3de76cea03..5b17e71cb3032 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,26 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+int ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings = {};
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
+	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (ret < 0)
+		return ret;
+
+	return rx_rings.data;
+}
+
 static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
@@ -1217,7 +1237,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
 	info_size = sizeof(info);
@@ -1225,10 +1245,12 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
+	ret = ethtool_get_rx_ring_count(dev);
 	if (ret < 0)
 		return ret;
 
+	info.data = ret;
+
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 

-- 
2.47.3


