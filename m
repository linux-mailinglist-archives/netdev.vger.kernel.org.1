Return-Path: <netdev+bounces-168576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD61A3F611
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A20A4223F1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477C20E02A;
	Fri, 21 Feb 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="CFStWvYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47520CCFA
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144707; cv=none; b=HlF1+o6P5fERdrF1QKTGGpth2QvuxlJFYzMPpEgpGsT1K/I/hwEQBN8W1o9iCMaElK7THz/4o1Pd8UTuibJj7GJH/j410EikBJRJRKGQ6ksqPw8JRgow0d+arepeliPYSWazDMEDBx/v2pj+aIhtDM7sdOGAtXyOw3RpIuqAnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144707; c=relaxed/simple;
	bh=V2963nK+B0X6rGi/ZVUQgn260cb3UBiVHbS+ah81Zu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI4UoK1yFmyUmerbRonvdRZXOp5Mr3gMxmDs+i+LG54YNMp/gEbdmgQYcJUb4MnsoB3Qx1NLYm4VBgovjDWOevQbZ/Hi1Yi7g6FhK8I+LEBW9aRmx8u5Ammfes0qQbqXWVLn/gmR7f20Uf6geIzuhytDN6x50sktaco7zNgVRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=CFStWvYM; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-54621bc7f44so268113e87.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740144704; x=1740749504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA016DeSEFu+cxP8XzHZyfB40HWht8sismSdjYZCkXs=;
        b=CFStWvYM7eScIEmHBSZmYVs/dFawLYfgjAfEn77Qu2ltyr16Adaw/VH2uiJ8ms9L84
         N1YVyHvsno1iuuKHYD2o4ZIQ2+HD0tGWlGIvmUfjpaSiQLHvg8nWCN0p8n00AEoQ4AJa
         BviSaS5ANKXrqaqIqgkJ9Hn31FnvCs9eP+dwJ6OVqoTGc3Pt1Zn9WiNOilEE4znTO3hk
         9a3w57c9qQStSjYWuNxlmQAsR7zG/sSbeuU61o0UTGHGxYErwylqHri6nYyOTtCaFrhN
         2rHhUvJLTIWHQI4LI3no324TfEtbB6kTwO+MP7Lb9EwCQKVEwqKtijO9cgjMwjY0E8/k
         8+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144704; x=1740749504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA016DeSEFu+cxP8XzHZyfB40HWht8sismSdjYZCkXs=;
        b=bcH/0m+RVulq8IJtm3EZyJo4XsQ48J54b6AFFy8LU8McStvvoE6HUv/KF1rA+XkR9B
         gINsTdvM7Ocmo0eCAptj6XHYy9uphUkGv7BnEqx/GAa4yKw+dfZcoE0JUpCi32OPlHEG
         VLfJIMSc/STZvceaSSafetzVtwDIFS10R7dLnM/Sq4dYz1oMWg0jqb4LtUotmmRjZbvV
         9Qc6AcdE/mHiOL5ub+YI8iJKoygCMHRg4elka+FTJ/RDgA7C4q1yGH1cgBy/mU3qZUTU
         1j0dBM715iujggU7ITgUdezlBBK/BF6JTKlEMfOl3urw0lpxuK4MauLj91gPmhyeFAQr
         s7aA==
X-Forwarded-Encrypted: i=1; AJvYcCUHqbirToryo+r6ZbcQFctBvEtqAaeBvH/ldxyOFq6NMXNjS/BnbnMtSD7LovukeqxLt86FQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3BG3/z3BBCribObMdxIsyJBo0GBAdV33+ZoZ8Pf7ppn/cU8G
	RbUD/fA4URV3KPoMTcSinSIJW4qy09IsD4VzTHTsHkJwHlJ7pTLzEMz1dRFUNa7eOl4k5HDbPrs
	vfToS7d/wRteRhn/u9rHvMUFEwWfO+W+u
X-Gm-Gg: ASbGncsa8gRD14CNDg96kN98+DXC/p9ELUR08MMG1Bji+n3bpbPuWkfW4IvBt2Ro8DS
	X+eORhWqSiA5fpMEM0HNUXxZ1u6PL9VmxE82tMwp5Vk33Wd9XRtL6EzaLtNQU0mXVkZF7r4r6Hs
	1uDTwUoKNn6SQW9YDdm9vxDls/O4CuJr3cuFVXhpM2JvePMEPDCoWH23MfGwxgw/a4Enp/tf0rx
	H3X7PwwYlpnT2IDZ0uDkEYPROzz8tL0WrFtdAtqaINFKsLEvfXLxKBBzvIecV4xZkLfIYVEvBtq
	5MzsdncsyNlBMSdmKJnCZ53ANOxP3hGyoEv89wWJ/M9EXTPKhQEL3BwvdytUp7YGWWl4PlU=
X-Google-Smtp-Source: AGHT+IFF57seK4w2bdkUyYlurelqAp9dLJqTGBgLrs61vmVRanEE0nrNLcoYgURpLIJD+5csXJjEDIpBuyPs
X-Received: by 2002:a05:6512:3b8d:b0:545:5bd:bf3e with SMTP id 2adb3069b0e04-54838f824afmr396734e87.13.1740144703692;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-54625bcb69esm351970e87.104.2025.02.21.05.31.43;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4BEB513E9B;
	Fri, 21 Feb 2025 14:31:43 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlT83-008b6j-1t; Fri, 21 Feb 2025 14:31:43 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v4 3/3] net: plumb extack in __dev_change_net_namespace()
Date: Fri, 21 Feb 2025 14:30:28 +0100
Message-ID: <20250221133136.2049165-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
References: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It could be hard to understand why the netlink command fails. For example,
if dev->netns_immutable is set, the error is "Invalid argument".

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 40 +++++++++++++++++++++++++++++++--------
 net/core/rtnetlink.c      |  2 +-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 598acba04329..f4dcc2fbec29 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4156,12 +4156,13 @@ int dev_change_flags(struct net_device *dev, unsigned int flags,
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
index 91b07fd1c86d..2f5554927fb8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12003,6 +12003,7 @@ EXPORT_SYMBOL(unregister_netdev);
  *	      is already taken in the destination network namespace.
  *	@new_ifindex: If not zero, specifies device index in the target
  *	              namespace.
+ *	@extack: netlink extended ack
  *
  *	This function shuts down a device interface and moves it
  *	to a new network namespace. On success 0 is returned, on
@@ -12012,7 +12013,8 @@ EXPORT_SYMBOL(unregister_netdev);
  */
 
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
-			       const char *pat, int new_ifindex)
+			       const char *pat, int new_ifindex,
+			       struct netlink_ext_ack *extack)
 {
 	struct netdev_name_node *name_node;
 	struct net *net_old = dev_net(dev);
@@ -12023,12 +12025,16 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-	if (dev->netns_immutable)
+	if (dev->netns_immutable) {
+		NL_SET_ERR_MSG(extack, "The interface netns is immutable");
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
@@ -12041,30 +12047,48 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
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
index a76f63b926df..1bcc98e342f2 100644
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


