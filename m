Return-Path: <netdev+bounces-105232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACF910353
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5207A282460
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6D1AC458;
	Thu, 20 Jun 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/Qhy9cZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F621AB8F0
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884044; cv=none; b=O9kkzDyHfr5mbCULb8Nszm7DSPcLKI6Dj2aka0e7R0raFrRKZ+XYOvdgBE9n2aO0v2nARQXg0tzXBRLM+lMs47arpLxgKKirJjk7y5mepp2kbVhvRqE7uouJsgVNIsrpohCrIWUuhUdSqEJZzB9tThtQEp60JP5Ujy4OUSQoRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884044; c=relaxed/simple;
	bh=0GGECpbjh3ycFYT6pu/CUetA0+l1IS1AkGwWCJN9biw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SwP9R0qrol6L0EbrzLXjsRtIvfUW3WXFZj7arMIwbPcr0Afb+LFCgjtx3lckVblyU28wAJScpaHjnNbjmPKLy2yAxi6T726GxILIw4qQYSZvUmnQYnO7sht4xX7L5v4DWIOZRlzf7s3gNRVSSizeYdufI8lAHcQZE1X5LY441/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/Qhy9cZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02c3d0f784so1351393276.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884042; x=1719488842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nNbInJfrL3GbMNQXNczNCVPth5SAn7I4SKHYQrALmw=;
        b=X/Qhy9cZP2re4qjW3xC2+OSbzSTKT/ecmj75bdPyyATZtduD5lACAqXQO+JHVX9diy
         9nPZkiyy/AaN2/0dDhgzHfgk45vHflQNkQbJatZiBGegGlDWLNk33n+Uh928tKzma/Ub
         z68ognz1oWmhveC97zcKnxZvYvUiGd3HX5AFyah/CngG6Q6IZZHzERWZocN/6C+Azu5v
         XtfEz5xR18VF3uwijZ8dBy+eETsItF6VCI9OPL/zjiM1AYiDNJTTprKE++3NL5ISOjPz
         32REVVj2o8B3IsNM5ZxZAMpxmx3a26/na37SLSB5/t4hdAQyMv9ZzmhFEGy2B1hmWV5z
         S6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884042; x=1719488842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nNbInJfrL3GbMNQXNczNCVPth5SAn7I4SKHYQrALmw=;
        b=MRIwEb7DOD6vEOPJO0BsZChisWGdtz4JJNNj2MJKBUxBEUqBeQH+mAcavCNtP8a8VH
         QeekTDA4+xqUzJK6hl29fiSEb1tEqnh06yQGXU69LgRNbj/xe1Sllrifv5Z7JbbTK/wX
         Qu7Tw2xkpYStQE0npZc20+UDHh5mCZo+eu9V5ImAKFPf2qFl5Z6S7ZDO9IRk2h+tXZE/
         DtBFdrLEI+YTD2l4Q0LjF2td2yNsBNTmBLjcJmr4uFpSDkywypVsCbE7jEJLJridbnsi
         ykOxgaqbaLpxwFdkyQzK6bv+EjrXI8T084QIDDRHFTscB7OSs73+7woHF1TP8fPLuuFW
         uFbg==
X-Forwarded-Encrypted: i=1; AJvYcCUtRBLW0QVBOXkMq2hIlvaGbVYQtu06cM7ta/oEhpAsZT3H9zfyzZE+ZsLzrrEgkQTsTOlxE63BscaHw+3gu/XUhn4OYKM2
X-Gm-Message-State: AOJu0YyGOUKTi2S8SUIeGizixOqi3ig+ZE7oH1ElE66DOuAZYc9tV9qA
	vXALJo6/+vQ++nzxUW8Z3rO5UHAcjQSbHvuodYCTxbhGUlzrfkaWjI2McTmlw3DCYMgbMJrqaAc
	bnEX2ABVEmw==
X-Google-Smtp-Source: AGHT+IGkta7OKISp6IhsfAFYVw6fN3+Kkv2fVqNBrdn0XAyMYJBucblZTA1Hl026gTBRzXpakpfpMueAo+Bkmw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18c8:b0:df4:8ecb:ae57 with SMTP
 id 3f1490d57ef6-e02be1dc849mr624130276.10.1718884042340; Thu, 20 Jun 2024
 04:47:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:10 +0000
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-6-edumazet@google.com>
Subject: [PATCH net-next 5/6] net: ethtool: implement lockless ETHTOOL_GFLAGS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ETHTOOL_GFLAGS only reads dev->features, there is no need for RTNL protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethtool/ioctl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index d0c9d2ad9c3d0acb1be00eb4970d3a1ef9da030a..56b959495698c7cd0dfda995be7232e7cbb314a2 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -291,17 +291,18 @@ static int ethtool_set_one_feature(struct net_device *dev,
 
 static u32 __ethtool_get_flags(struct net_device *dev)
 {
+	netdev_features_t features = READ_ONCE(dev->features);
 	u32 flags = 0;
 
-	if (dev->features & NETIF_F_LRO)
+	if (features & NETIF_F_LRO)
 		flags |= ETH_FLAG_LRO;
-	if (dev->features & NETIF_F_HW_VLAN_CTAG_RX)
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		flags |= ETH_FLAG_RXVLAN;
-	if (dev->features & NETIF_F_HW_VLAN_CTAG_TX)
+	if (features & NETIF_F_HW_VLAN_CTAG_TX)
 		flags |= ETH_FLAG_TXVLAN;
-	if (dev->features & NETIF_F_NTUPLE)
+	if (features & NETIF_F_NTUPLE)
 		flags |= ETH_FLAG_NTUPLE;
-	if (dev->features & NETIF_F_RXHASH)
+	if (features & NETIF_F_RXHASH)
 		flags |= ETH_FLAG_RXHASH;
 
 	return flags;
@@ -2993,10 +2994,6 @@ __dev_ethtool(struct net_device *dev, struct ifreq *ifr,
 	case ETHTOOL_GPERMADDR:
 		rc = ethtool_get_perm_addr(dev, useraddr);
 		break;
-	case ETHTOOL_GFLAGS:
-		rc = ethtool_get_value(dev, useraddr, ethcmd,
-					__ethtool_get_flags);
-		break;
 	case ETHTOOL_SFLAGS:
 		rc = ethtool_set_value(dev, useraddr, __ethtool_set_flags);
 		break;
@@ -3179,6 +3176,10 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 	case ETHTOOL_GGRO:
 		rc = ethtool_get_one_feature(dev, useraddr, ethcmd);
 		break;
+	case ETHTOOL_GFLAGS:
+		rc = ethtool_get_value(dev, useraddr, ethcmd,
+					__ethtool_get_flags);
+		break;
 	default:
 		rtnl_lock();
 		rc = __dev_ethtool(dev, ifr, useraddr, ethcmd, sub_cmd, state);
-- 
2.45.2.627.g7a2c4fd464-goog


