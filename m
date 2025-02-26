Return-Path: <netdev+bounces-169762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD2A45A29
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63363A93B6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A42226D0D;
	Wed, 26 Feb 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="e/qDt7dN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD220F079
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562358; cv=none; b=TYwbCPUh38FarCXlWh8g9klA8x/ihbUJmsy1puEuTXFraMatzOqRSdNBVktcPndU08qaYRX4oTyfioLfM4lua0vwpOUKZn2ALBJQs/hxF9ow4r3lIeckkiWovu6dHc7SgCLhimIugKtR9eQ3K0BLoX8kjGnV6A7xREhDxB1wzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562358; c=relaxed/simple;
	bh=zy6j9xkJLWg9D13msQj8k8koPK9coIWdv7Xn+JDHUmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVXxC8iR8I2RbmBWibR9SBsHw2FkXM40IpoU6rj6HYMzv05xGEhcDVHkOBIxQUttXfKKTLJE+oVnYZIZpPhOWFb99wPMQcDuWh/z5rJBrly2/koDXKw4Y72l3DivkuYPNI1+IdCH6onyIngD6ZVIUyJW+7us6jFmefATSXGGC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=e/qDt7dN; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-5452e71d67dso954761e87.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740562354; x=1741167154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlOozV+L8sYbJ2QtpMdbbDX7iIJPfln5gUfdQ/zXCqE=;
        b=e/qDt7dNTen6FcEWh+1EHxgDp75P6gAtGpglhiiybEab9onXSMn+yWxsgVe2XXkrDZ
         TOn4Jpww48vadHL4+tRv0/iqfGQvbrhZaUI8N6eVsLCRuQOnWLBuYN1MtwjrX2+T+0G8
         bm/6BqesY8bfvoajvZHzGxEJoaSxdNP1WdrJDjZxBug58j7y8ixhBRI+GVkf7wycdhZc
         AY5sf4fPhVhrJUI4eFHtDPr6FwgkRaoXSuNWlo9fzvrMdkILXQscmtCEg/7SmmJ0uV33
         AX7hpNdiZIETG3RWVJ0jwMuHy55bFq8H9BcUr5Va+PULd+fIOG8Lhl8XlHzBXwwcTcdR
         sUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562354; x=1741167154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlOozV+L8sYbJ2QtpMdbbDX7iIJPfln5gUfdQ/zXCqE=;
        b=ImuzX7T/TSCLYrbqvAVSd4TxrwGx9ThSd3ELUihnKqXkwxBec5u0w3qn3NDKaL1Tcr
         eI//iHH7IE25s6QXcn+CRhEXCtX4mT5u8btYfPEj1C+yBjbDndgnFOKAxHOspD1Myaoy
         7K/qU/SYzaU3SfeguJiEwPfvk163NmWLwD/N5u5h4DA1NejKcewahcJN/gQakBRsvGyO
         HCHZMdx/jSSijCi0H5kYEESxDe9A3uU9rFK8vPgaBGjk/SeQkWtLCl7rNVYSUcwdEc8V
         LuUSh5wURJ5zZz5FGXnyw/yU29etd27tvyqgGkG4LX12/rVJUiZApYhEHQ1DYwi1oj03
         jWAg==
X-Forwarded-Encrypted: i=1; AJvYcCVtzcMT84THe27lK5alQxytsLsGq6UW/TUhz/gfqKIQRAmmC3MGbHDBi89eouU31TOOhP3beSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Umv1hD7GIQ1kE/YbHHGZy9S0rf+0hogZdCeCVTmcZvdL70Yj
	p+QivN2hGx8vSLF0i7yZtG7z92qirVO0E+NOesJ3MMda0ati7Sr+mw/YH1Q0G36aGienbj+8geY
	oRXR+T1alpDuoBGsvAIJlLUPXOTIMkqjp
X-Gm-Gg: ASbGncvYzIdR11GN8h8A05kVrPriu6vMigxAFQS4YZajc5lyw3iCHNA4xavhi8paKRG
	hoPfgmviMy3Ap837mYx1w6WwX1mdaSzzT+as1Sx+alob49JsqncDmjbykUHURzxBrYid7teYLft
	JQJkrIqrZ9osxc0SD9e7Wt8Ff1ppdASDlb6pyw9k4fHiAWjgvDsMMsLo0pIfbxwkyCVSIFr9bIR
	gWkad1x0MkXhfsMSQCIX+R1wgGsS9ArCVPc/IiqW0fpA0Mlkr6lFIZLALgV2DaOjUG1pHIs+2yA
	bDcdDQSO0jDRdMjy5U7IuqyAzJjfEjcMWui6W/ahPCBZMfYh29CPEH6MD8ofKRPB0iDFTEE=
X-Google-Smtp-Source: AGHT+IGQp76jNnfsnR7bBlV7C1JAOqGmaOtPEBe7RvdFi9/iw9XdPaPXY+D/euzbyDh+ZxwgIsn8Wu4dtCKN
X-Received: by 2002:a05:6512:138b:b0:545:3033:4373 with SMTP id 2adb3069b0e04-54838ee9327mr3489819e87.6.1740562354286;
        Wed, 26 Feb 2025 01:32:34 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-548514f747esm107214e87.110.2025.02.26.01.32.34;
        Wed, 26 Feb 2025 01:32:34 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D3E371669D;
	Wed, 26 Feb 2025 10:32:33 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnDmL-002hmi-Jd; Wed, 26 Feb 2025 10:32:33 +0100
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
Subject: [PATCH net-next v5 3/3] net: plumb extack in __dev_change_net_namespace()
Date: Wed, 26 Feb 2025 10:31:58 +0100
Message-ID: <20250226093232.644814-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
References: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
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
index 9f5024b0f36f..525a3dd1fa7e 100644
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
index 8b6bf5e9bb34..b4612d305970 100644
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


