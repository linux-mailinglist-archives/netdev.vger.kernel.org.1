Return-Path: <netdev+bounces-167426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68947A3A3DD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3063B1A31
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739A26FA55;
	Tue, 18 Feb 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hfAFgm4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BE26AABB
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898826; cv=none; b=sMD8koIHFF8X5wyMorp7GWEM+rRtrnUQU9H2dffwZmJKHyRp9xa1wng2M0sv1m2y55X5b13HpVZENsr6jIUPJnpsBuGniRui1lFZqGbsCEe4ElOke78J/m4y+J1OtwWeLT8n8T6aJkS8W6luwajW1GA6O42/EiRsysdRCf+y0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898826; c=relaxed/simple;
	bh=lnNg3wbly+WjEADen8ni42WuTedcRWguEyyrR70gslU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWey8vO50x2LfhAFmQCTvrSVT1A8PCUJhJtCa1Ne4w0pIdyDi1Q6hEAR4NIcmnDuEba5HWe6PHVN79onyUacme4DtnQ1ypsm73hDPc+XbXZcwvN0ZilEpGbUGzg4m/L/FWSDQ039l+0PspUPSgjA9H6ZqydsNAUlA0fu2c3L9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hfAFgm4a; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-abad214f9c9so72714766b.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739898823; x=1740503623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5RMrmUeX9nhBTzJ1Wvre5NnBrl/TPK4cY0EBHyiUAA=;
        b=hfAFgm4a3y2qqNJbIefGVHRLngXLo/rVcoP4LH3YJdMbDZl+YHpV86bfoAxTiSbgkh
         NXe857FCAXpzC/hTiW3L6zICniqqcbUVMA2cFUQMmbZ8i+Fw2/o/vgo45bBx7ZzVvii1
         BYp2Iw19R6/1GpxP1M8i2ImdrHXYGtvrq1qa0RW4MDyyBzDC1OF1JdxwmUWBWzP1mDJN
         SdaHiW7BjxdH9pxoWyMCetb8SdnQJFoXdJlYisHLVe+o1gpElS4d2lSa7rbZZNYQ84Ky
         v7mZsELMF4zNCJ1smozKjBWF1uZRUTKixbasrKwXTd6CNcPo/7nowF68nfjeDp810yxc
         zFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898823; x=1740503623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5RMrmUeX9nhBTzJ1Wvre5NnBrl/TPK4cY0EBHyiUAA=;
        b=tj2p4oPtQacvZggLiR/o9P/XfFS8a7ojP5bsV4V+HTya8oOHNFlA1Lima3OAjYSMQn
         D2AlzdR07MwnxIBxoXxNE7WYl3q6+ynPH31qh8Er1TXJIT6F8yBSrLlBsUwioIymIDzS
         5xMV1p/toqDQYi9vRim7pptcnBS3AaLWM/F454mOXIQj1eobAr0oEL53/D4HV7gHSGsp
         UNv6JWbL3T3aJ0PYTWQrwLjSjygiqmlgBlbfZtGbcsWEsW6YE5s/TE33yHVuB6hknVSp
         7ff386pabBwPzUSM94+mKRT0mq7n/vOC92rLqrFAhjX0giezEHzC6Eu/oPG5YkCA8TW/
         RpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpPGjG3G2HkvW1tMjUbSBHaee+ZzFgLvnYw55pQ7BO08WIxjZvrQvALKqtv6rbD9A0i+f2IBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS9fTL1djaYjxaRSezLHwr2IPUpyZZaoTJivURDKaEXSGVtE5L
	wlwF0WkSTKF0Ty89pA5Hf/Cv/ly740SuP9GUuk30PhNa/NgHHZzyC2pW/DKb90NbqrM82EvedK3
	+F6pVzk5UdnJy5vKukzRGl+6C1bhGoU3N
X-Gm-Gg: ASbGncuRXbCXkfRPKc0fv2vpkdyE/faAmRXi3iKfwVT5RqBLSJ/h9fOwgmz4bbXWuTj
	5x8bFycDY8SAQQ7CzKe8iClVHCOZAwtWseJcUdhLawIofEsVkZXSICl/qgSzUyptSfsGigNaTa9
	HKjwrDZ6Z1/XZsYFQUITN3ZbGVY1JqAIHex76oWSmucO/Lj3jv3iOhcBxuuJrUycF5YMdlM/siO
	NbrWfwj1m8OHAhxqPgrjc/wJzYWNZzdjjDTegoaPAsX1R4F1KdqBkaXXE2gBOez1Cbbac1Vtr3X
	Ugsp6YIRiRb6CjoSeEMeuZDNVRKMKBgXuvhX3lhPFlKyz1swGzrkhJIY/g23
X-Google-Smtp-Source: AGHT+IFmXIpbiT/SOqqck1T3iKOEnk/X1cShURTSs1y/gjMeByc5q4ykrYjnbmTH0GDwUX12PgL0BRJVCMeq
X-Received: by 2002:a17:907:2da0:b0:aae:e684:cc75 with SMTP id a640c23a62f3a-abb70dac916mr523634866b.13.1739898822543;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-abbc58f0b7esm4841466b.67.2025.02.18.09.13.42;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 5560512517;
	Tue, 18 Feb 2025 18:13:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tkRAE-00F4xM-3A; Tue, 18 Feb 2025 18:13:42 +0100
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
Subject: [PATCH net-next v2 2/2] net: plumb extack in __dev_change_net_namespace()
Date: Tue, 18 Feb 2025 18:12:36 +0100
Message-ID: <20250218171334.3593873-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
References: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
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
index bcb266ab2912..499c10687b7e 100644
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


