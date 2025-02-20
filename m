Return-Path: <netdev+bounces-168138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88FDA3DAB5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D078316D273
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7181F63E8;
	Thu, 20 Feb 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hgu2zk2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6BBA3D
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056620; cv=none; b=tb2J6gnYCLBdbOFjbw8xZsMLBXAWakTj7Jvahz7Kjx7EdacRTdaSYgcA92yb/W15k1DSvWInqn7aaBpv6aFOW2oMl6DW1mVqdNpZPMTKS1lW7W3zWzeUt8fozlFhFhMYA1Q5rYInZwwLxP/w56OK/XIB6Z1lhNnYfekzLta2oLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056620; c=relaxed/simple;
	bh=LYdEkg/Il3Ey78ojWmepyOXM813oEzU+1B2SlmWX1gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvge0Hb6/rLCLs/UjpX0UclXUOx83crpUor3KF9FMrhj4bv3b0z1FFl6VqPi21J78S9sEjDrHeWfr6OdbDrLRBFdKwA5dfArBlZGirn4faN3LEiI4hoibnOeLCcvFCVlC4KrZsbFITSoMp8aOfQmVtvyRXpLzv3GyUB5oSa64Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hgu2zk2/; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-54524431726so139099e87.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740056617; x=1740661417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnESZ+CJt+zX1Z18lMXZcWAwOp2i2lefagFpWWmJy0o=;
        b=hgu2zk2/3MhZfkatjA7hbfBwHK0/ioW4E3WR2iJ3wyKIwv0Vr6XLfJQWjKX/0PsoIb
         j2itWxzzAIpG54F2Zww7rh7Czzq81jnHj/3Ybi/O1tHkqTWybcnZL0mnQc+3enrChfxm
         s3XOnSqMS7Tgj/Tdq6vmWx8A1uaSBmWNL5yTTyFVnzB/WBT6JsLDLvtxRKdbwdyPCO0g
         AAZkFNR+pOMIk85sZPnitS5f3NqLtDzizgZPKViMWetAkJCmV81WjCPyPVB7UqnOUp1t
         jMOFZbG0V21oVgxwRWaaIdeh+3yD9iTqdnOX4lOtdOnCn3vo+mp118QKU80gk3n+MAnS
         u5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056617; x=1740661417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnESZ+CJt+zX1Z18lMXZcWAwOp2i2lefagFpWWmJy0o=;
        b=SGUvgdSh5gkTdtTFl5Lg9qeBDJ+BMuAtQStC5j9ph3glw8Q1HoEUQEDFCJC77s2I4+
         wioJX67j61TOy7QFFAwLaVJKybkGej4GhFTYeTKOtm+fGiP09bzoVCuyDcMHtSVDOpgi
         +iArIBIvukYrKK/oRs/EQXJc3EAAN72SpxEkm15InIb1zthnxKHBmm32f9vqxaIzgDAZ
         OKqe05yz9rcFkb4XtFekXAnnIbwUYbAxC+lqibDLIZJiOVBtfdXf+BEFNbY4NjuEgU3R
         DfUGkCkaDBFaiCUOssp1ejM9mi/kdsJ2uv8GSqk4AXdtU+IGB/82R1GQXrS3/geWQQJU
         SE+g==
X-Forwarded-Encrypted: i=1; AJvYcCWramlIsa1FKxeCpQJ6U38v8fPngeY+WhkJjcWKKH58m8xxX1QAuINKWIGY9Cz8ghEENENvBMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuoQCF1N/w54JvLkddrjtcabLfR1U3DxMOp3Q4slnLwfhL1Ukn
	Y7YavXyn+wXNRqIeip7Wv0lCQnq1gllgjylCNOSvQwNbnhmORzdixojBrmmNOBj9LOJYdv7yImq
	oDCDUuLkbWsZGzv6FcXbLMSPuSNE6wsrN
X-Gm-Gg: ASbGncsO5j1YOKxTOn65+ppJzNwT+oRxw58+uo1PjIiKAbcjN1DC3SXXw7MSQinuuw9
	4zb8cZ1OCfAYdbWO9DSHWlSMsykGmalBn6ch5cyjv2ZmFZ1vdStD0b0FTi4Amtk872Y9l9+ofgU
	fFc5x64uWG8vDvqNY9MZklJPcoIbMNh3xlfqdpkAWjoNBwW1h2RdAfwm6RugTDHHLC4xY+Cmibv
	A7BKZhYjZcRRrSx/ao65LyWHJTNsrmFBXI3US467TzpH+T/JHAiwsC8MLjQNlCTWjIFIfRrX/z1
	ZSTgBRU5CeTqiUUgbc6ISirimU8MeHmAFIC7fqfHAF5iCocf1x5EO4JNtdJv
X-Google-Smtp-Source: AGHT+IEF82rFAwrDck8eIB4QwoHJEMfqAYYnqydXjlQAwc1pMMRCWXz+A/FDUSFjmDRXFmndOBlH8UnvZBXG
X-Received: by 2002:a05:6512:a91:b0:545:40f:5753 with SMTP id 2adb3069b0e04-5452fdb5df0mr2551688e87.0.1740056616728;
        Thu, 20 Feb 2025 05:03:36 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-54529701d03sm562975e87.30.2025.02.20.05.03.36;
        Thu, 20 Feb 2025 05:03:36 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4F6D11352F;
	Thu, 20 Feb 2025 14:03:36 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tl6DI-00F2Dm-2J; Thu, 20 Feb 2025 14:03:36 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v3 2/2] net: plumb extack in __dev_change_net_namespace()
Date: Thu, 20 Feb 2025 14:02:36 +0100
Message-ID: <20250220130334.3583331-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It could be hard to understand why the netlink command fails. For example,
if dev->netns_local is set, the error is "Invalid argument".

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 41 +++++++++++++++++++++++++++++++--------
 net/core/rtnetlink.c      |  2 +-
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fccc03cd2164..58d9f052f154 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4155,12 +4155,13 @@ int dev_change_flags(struct net_device *dev, unsigned int flags,
 int dev_set_alias(struct net_device *, const char *, size_t);
 int dev_get_alias(const struct net_device *, char *, size_t);
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
-			       const char *pat, int new_ifindex);
+			       const char *pat, int new_ifindex,
+			       struct netlink_ext_ack *extack);
 static inline
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat)
 {
-	return __dev_change_net_namespace(dev, net, pat, 0);
+	return __dev_change_net_namespace(dev, net, pat, 0, NULL);
 }
 int __dev_set_mtu(struct net_device *, int);
 int dev_set_mtu(struct net_device *, int);
diff --git a/net/core/dev.c b/net/core/dev.c
index ebc000b56828..9605fa2e7415 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11917,6 +11917,7 @@ EXPORT_SYMBOL(unregister_netdev);
  *	      is already taken in the destination network namespace.
  *	@new_ifindex: If not zero, specifies device index in the target
  *	              namespace.
+ *	@extack: netlink extended ack
  *
  *	This function shuts down a device interface and moves it
  *	to a new network namespace. On success 0 is returned, on
@@ -11926,7 +11927,8 @@ EXPORT_SYMBOL(unregister_netdev);
  */
 
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
-			       const char *pat, int new_ifindex)
+			       const char *pat, int new_ifindex,
+			       struct netlink_ext_ack *extack)
 {
 	struct netdev_name_node *name_node;
 	struct net *net_old = dev_net(dev);
@@ -11937,12 +11939,17 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-	if (dev->netns_local)
+	if (dev->netns_local) {
+		NL_SET_ERR_MSG(extack,
+			       "The interface has the 'netns local' property");
 		goto out;
+	}
 
 	/* Ensure the device has been registered */
-	if (dev->reg_state != NETREG_REGISTERED)
+	if (dev->reg_state != NETREG_REGISTERED) {
+		NL_SET_ERR_MSG(extack, "The interface isn't registered");
 		goto out;
+	}
 
 	/* Get out if there is nothing todo */
 	err = 0;
@@ -11955,30 +11962,48 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	err = -EEXIST;
 	if (netdev_name_in_use(net, dev->name)) {
 		/* We get here if we can't use the current device name */
-		if (!pat)
+		if (!pat) {
+			NL_SET_ERR_MSG(extack,
+				       "An interface with the same name exists in the target netns");
 			goto out;
+		}
 		err = dev_prep_valid_name(net, dev, pat, new_name, EEXIST);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Unable to use '%s' for the new interface name",
+					   pat);
 			goto out;
+		}
 	}
 	/* Check that none of the altnames conflicts. */
 	err = -EEXIST;
 	netdev_for_each_altname(dev, name_node)
-		if (netdev_name_in_use(net, name_node->name))
+		if (netdev_name_in_use(net, name_node->name)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "An interface with the altname %s exists in the target netns",
+					   name_node->name);
 			goto out;
+		}
 
 	/* Check that new_ifindex isn't used yet. */
 	if (new_ifindex) {
 		err = dev_index_reserve(net, new_ifindex);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "The ifindex %d is not available in the target netns",
+					   new_ifindex);
 			goto out;
+		}
 	} else {
 		/* If there is an ifindex conflict assign a new one */
 		err = dev_index_reserve(net, dev->ifindex);
 		if (err == -EBUSY)
 			err = dev_index_reserve(net, 0);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to allocate a new ifindex in the target netns");
 			goto out;
+		}
 		new_ifindex = err;
 	}
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index acf787e4d22d..717f2e3e333e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3028,7 +3028,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
 
-		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
+		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex, extack);
 		if (err)
 			goto errout;
 
-- 
2.47.1


