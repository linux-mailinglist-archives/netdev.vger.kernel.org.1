Return-Path: <netdev+bounces-105229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D192391034D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2362834A5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F4D1ABCC7;
	Thu, 20 Jun 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMD3tm9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A11AC233
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884039; cv=none; b=JmslSCrvxtDfXf/AWjfAmzpZh/uxP95n5sRCZrnlfkUZ+VVeLn5C7OKOR4+e9t85U/ZwBwtBKkYcil08moPdlvoNuzsNXc4SrxrISMPEFl5Xt1LTh05BSFBwVuApifDs3+nUwHV5Ju1qxJO8HrX9D7T1qh3YCR7oQR54MFCdEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884039; c=relaxed/simple;
	bh=i5ek/H2xewLnWY0l8ZSHif2f2l/QR/ndrpNq2r/WBic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=THVCeRaxxF3vqtolzAUhro+D4f7u+8LN5E/PJIz0H3qaVndBFDK4+ZuA32GSZL625TLJTjGrHG51iZkx0iBQsmEAIkgiK8mw/Ue0UyKfRK0r+c7BItTUBo1c+qr1TMFpfHEvDzz9DBPDqQQapBKNQNegbPRjqtBu1s12cn9JfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aMD3tm9Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-632e098ab42so16492697b3.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884037; x=1719488837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XoJ+LDaZQa6kQaJG3nZHbUf5IeIEJtBZ7kJKCerotM=;
        b=aMD3tm9Z/t3JZ13B86JffWcopac1XbQGdc2vrmbN5Ufhn9FelVRZhswTA9Hg4YWaq6
         aD1Aaqhbuhfo1VojL6q+0Ly8puUvN5vk3sF69IF2Dj4E8DqDFkVCQJRvGEuelhzxlYxv
         9A83Z5x96eP4uHdQFB/ZuB4kWbIpIR9rhFXhkjmOsGYMjiA8m1EXCj1AOhEm9oueGUPR
         A6/Qf7EUgo9HFsLpsYnMspHfJeUTabjvshC777C8iKvM3mePptdacBaYBNND8lCJoMSM
         dL6uLFE83WQXKNBDSJSUVrDqNB0ynYDcbbXS27rEadvWDEIsZp1IFnH4rNMQ7o9xt0Fj
         f2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884037; x=1719488837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XoJ+LDaZQa6kQaJG3nZHbUf5IeIEJtBZ7kJKCerotM=;
        b=Unzl3lWztEEO1sK4DUQsqWFnC5E/8ZcjeRldXbqcZnkTySU2kNMg4I0ximhdB7G73g
         xHQuS13eQ0zGMw7iUHxxJFAcPeL6X/RTzCIa9qSWgvQ54gvc81TiZ97LiE7mv8HuCO2X
         saJK2kmTVt0m/Gb0iYS89rvQxBR1LA6tKvKWXi8mdGvHXtP+tu7L6LGlEPFd9Z/7h8T3
         6RSVXhdcBHBYe3yD2eh5DvUVsQoQjehRWoX1z/xl3UwLJ2d6idKHUezB64Xxr0c+z90o
         iNhiUJiCOAtZJ89BZDbo3GkJrSV3F9K8NOfW9tB2TIZd0usS4Ha9qWVpWk4rYdsJ241Y
         Zfew==
X-Forwarded-Encrypted: i=1; AJvYcCW5P5r6Jlj5ed+ZTAUD41AdWlfh1UfJNr39AIkAj5w7ZROYJSHLvwQWLfC1l4GRYtoxBWpvfqRRi6BYGl4wwLJ40Ym3ESqw
X-Gm-Message-State: AOJu0YzmRkRwWhLzICzfdp3hpFdjdXVIcHRf+4dI5KwUEFWZmEx+PngL
	qhZpi27+OwW18UJhmtiy2sF4wywWn9BQ0jlX8l76VhTaZ/d6jAob0yzd0XP0DvcFmI9PG3erMVJ
	7sJZQj86ljg==
X-Google-Smtp-Source: AGHT+IG6k0LxBp6qaDynyKp3aHZc/8Qonks9BOG1IhBCgd98LvgFiqJRtoz6r+5MdPQCd6CJcUT+CaNeEtKv3A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:729:b0:dfb:1147:cbaa with SMTP
 id 3f1490d57ef6-e02be1f5f37mr1383388276.10.1718884036815; Thu, 20 Jun 2024
 04:47:16 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:07 +0000
In-Reply-To: <20240620114711.777046-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620114711.777046-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-3-edumazet@google.com>
Subject: [PATCH net-next 2/6] net: ethtool: add dev_ethtool_cap_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Perform capability check in a dedicated helper, before grabbing RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethtool/ioctl.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 01c52159aef7a47165ef11aab2c599ffe4ad345d..45e7497839389bad9c6a6b238429b7534bfd6085 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2850,21 +2850,8 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
 
 /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
 
-static int
-__dev_ethtool(struct net *net, struct net_device *dev, struct ifreq *ifr,
-	      void __user *useraddr, u32 ethcmd,
-	      struct ethtool_devlink_compat *devlink_state)
+static int dev_ethtool_cap_check(struct net *net, u32 sub_cmd)
 {
-	u32 sub_cmd;
-	int rc;
-	netdev_features_t old_features;
-
-	if (ethcmd == ETHTOOL_PERQUEUE) {
-		if (copy_from_user(&sub_cmd, useraddr + sizeof(ethcmd), sizeof(sub_cmd)))
-			return -EFAULT;
-	} else {
-		sub_cmd = ethcmd;
-	}
 	/* Allow some commands to be done by anyone */
 	switch (sub_cmd) {
 	case ETHTOOL_GSET:
@@ -2908,6 +2895,16 @@ __dev_ethtool(struct net *net, struct net_device *dev, struct ifreq *ifr,
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 	}
+	return 0;
+}
+
+static int
+__dev_ethtool(struct net_device *dev, struct ifreq *ifr,
+	      void __user *useraddr, u32 ethcmd, u32 sub_cmd,
+	      struct ethtool_devlink_compat *devlink_state)
+{
+	netdev_features_t old_features;
+	int rc;
 
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
@@ -3151,7 +3148,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 	struct ethtool_devlink_compat *state;
 	netdevice_tracker dev_tracker;
 	struct net_device *dev;
-	u32 ethcmd;
+	u32 ethcmd, sub_cmd;
 	int rc;
 
 	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
@@ -3171,13 +3168,23 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
 		break;
 	}
 
+	if (ethcmd == ETHTOOL_PERQUEUE) {
+		if (copy_from_user(&sub_cmd, useraddr + sizeof(ethcmd), sizeof(sub_cmd)))
+			return -EFAULT;
+	} else {
+		sub_cmd = ethcmd;
+	}
+	rc = dev_ethtool_cap_check(net, sub_cmd);
+	if (rc)
+		goto exit_free;
+
 	rc = -ENODEV;
 	dev = netdev_get_by_name(net, ifr->ifr_name, &dev_tracker, GFP_KERNEL);
 	if (!dev)
 		goto exit_free;
 
 	rtnl_lock();
-	rc = __dev_ethtool(net, dev, ifr, useraddr, ethcmd, state);
+	rc = __dev_ethtool(dev, ifr, useraddr, ethcmd, sub_cmd, state);
 	rtnl_unlock();
 	netdev_put(dev, &dev_tracker);
 
-- 
2.45.2.627.g7a2c4fd464-goog


