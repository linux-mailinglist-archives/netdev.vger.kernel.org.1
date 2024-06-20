Return-Path: <netdev+bounces-105228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21591034C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FC5282CE5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387611AC228;
	Thu, 20 Jun 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nr0/yLCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52C1ABCC7
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884037; cv=none; b=Wqrjkb2QCuoJArXaDYWM1PKbnlqkAjDN4WRk5PlMS3ewsN8ynZtlw4I1oy74upJciWBPoCyHVYtcuWeiHZTCqZEkR2aTQu4NcPliQgzq029EbPTxfc/Ftzb60GvoYnvHyMlekhGappaf0FJ5ndluXB5eSyMBO6usUwCpBJw7ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884037; c=relaxed/simple;
	bh=6k1ACoQfcvcjSGAdPrceCftyFpOBfzhZGPY5Zf5rPpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZwTg4/76QP2MuaSrPNtfL3VGgEbTY6UePFu5jEV72Gacsm6/QpuNhPdoi8NTxHJJCAYU5Iko4bv78dbxmR7uXFrBlDsim05H6LhvlE8dYRBMyGLB5/ywD85dlvVlNFEiBsBSL/GxjDrtC74sxhmFBRAP/rt6jxNZypRXtayYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nr0/yLCZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f4a731ad4so17105487b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884035; x=1719488835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMfbVnUPhTujqT8L/s0KUahjgRHHdhMW+BGUKMdzCh0=;
        b=Nr0/yLCZkjN8ohaSqqnx/wupfwLgieKfZQ3gwYKfhjj3XELyKN6esp0jRUDFg41AJi
         Q33ypDmwsbo81sUPfqnhKWuMXGJwQPKfADhtg7pQL4bXyOGiH3bmcmmABskueV/WCFUS
         FLv13rGBPMHQpxDcC8+5T65XmuPyUT13Y47peUcOj4CUwasq3UETf2jXFfVr3UjTUBOP
         5U0KvtC6rVS6b3BpBjz6YBdFCHqv9SqZ/jpcQlL/a10FL2XdCwSy6f9vOMiIowbq7Gto
         mc8Y3G89g+xaGL0noh2qRQy+JvAMX8fukxEcNgIiKv3FIVo68kMY0vaqjg++eTR88M86
         6lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884035; x=1719488835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMfbVnUPhTujqT8L/s0KUahjgRHHdhMW+BGUKMdzCh0=;
        b=BcvfGnXHN6etcOraav3v11QRFVthHsid+H+F3UiIFoK/Napw1S97twcivKkT6eVRLS
         mwa0S4FY0ZaZT1ZpyyxvA7em+yQdFlojx1tKH2e7hMha3sTHmo4JsijEymBK65CeEk0x
         kNC7ZhVGyTVI7tfrZcNuoezQ1IdeO+yt7Ei7m7rss+IM3MiwJXxogqJqeMWdoRwSD8nN
         v5di4kM/mGKUyWW4zEf1TV4Xymh9gfcNdFf9KVajNSzJB8p7qx37pwdgshksox8XAVi0
         6+3Zev5CDdunOBJqdzjUaAPlSmaBYvu5QrnX36bKUoYDAJyus+13bHrAHDgLVZqRRtM6
         HuaA==
X-Forwarded-Encrypted: i=1; AJvYcCUu8l66bKgqJ0kOgVNFWjQoUzcvDro+TXAc0ly36Kbux7e/R7XLXoE3S4XyX4EeW/hyzG/31xxfuQiIlI6hj6VnftJ8HVpd
X-Gm-Message-State: AOJu0Yxuw7jJvAKUeFs09Z5V7CGs2ZfJ7HwXjR2QG9xBuerwBxIQZdYF
	e05/wTThKWrqhaX+QDOX7NOAwTNjf8dVvF8U7xXekOKCc4+YtbGzB+s58M7bI4F/SBrHO1Z/zL2
	J7Pp5OUD8KA==
X-Google-Smtp-Source: AGHT+IGTV+ykH3VtY8k8oqlf+rgSp7qd6QCZ0qan5fe0sd3ZmUudVedGBjQ42A6dCyUy68KqGqO2aU+vjsUoEw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c11:b0:e02:c478:c8b9 with SMTP
 id 3f1490d57ef6-e02c478c9d4mr379784276.12.1718884034734; Thu, 20 Jun 2024
 04:47:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:06 +0000
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-2-edumazet@google.com>
Subject: [PATCH net-next 1/6] net: ethtool: grab a netdev reference in dev_ethtool()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We would like to not always grab RTNL for some commands in the future,
to decrease RTNL pressure.

Grab a reference on the device to ensure it will not disappear while
dev_ethtool() is running.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethtool/ioctl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e645d751a5e8998064ef5fa239d465f66c044e6f..01c52159aef7a47165ef11aab2c599ffe4ad345d 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2851,18 +2851,14 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
 
 static int
-__dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
-	      u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
+__dev_ethtool(struct net *net, struct net_device *dev, struct ifreq *ifr,
+	      void __user *useraddr, u32 ethcmd,
+	      struct ethtool_devlink_compat *devlink_state)
 {
-	struct net_device *dev;
 	u32 sub_cmd;
 	int rc;
 	netdev_features_t old_features;
 
-	dev = __dev_get_by_name(net, ifr->ifr_name);
-	if (!dev)
-		return -ENODEV;
-
 	if (ethcmd == ETHTOOL_PERQUEUE) {
 		if (copy_from_user(&sub_cmd, useraddr + sizeof(ethcmd), sizeof(sub_cmd)))
 			return -EFAULT;
@@ -3153,6 +3149,8 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 {
 	struct ethtool_devlink_compat *state;
+	netdevice_tracker dev_tracker;
+	struct net_device *dev;
 	u32 ethcmd;
 	int rc;
 
@@ -3173,9 +3171,16 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		break;
 	}
 
+	rc = -ENODEV;
+	dev = netdev_get_by_name(net, ifr->ifr_name, &dev_tracker, GFP_KERNEL);
+	if (!dev)
+		goto exit_free;
+
 	rtnl_lock();
-	rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
+	rc = __dev_ethtool(net, dev, ifr, useraddr, ethcmd, state);
 	rtnl_unlock();
+	netdev_put(dev, &dev_tracker);
+
 	if (rc)
 		goto exit_free;
 
-- 
2.45.2.627.g7a2c4fd464-goog


