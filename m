Return-Path: <netdev+bounces-170648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52613A49717
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C143173A1B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196925DAF3;
	Fri, 28 Feb 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Clyyy+Mh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3125BAC0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738110; cv=none; b=fmsJfqrJ0ojwgXCQTeKptwJjDLtvlK2uDjqrKQFj0s5b2wH3rbFYRq3oozQnJg0c+djFBAL7SpIxB0lzfQh2FluMasmKY87w+6fQKEvC5OZSfZkyeqDfv4RTbgDjZQuzqGJvANzJT9VZIELGZ3fV1urIYsVghp6dEwQLPW/DUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738110; c=relaxed/simple;
	bh=4RJ2PameS5b42Ie0ZYUr2zUbs6+YZ0xp5yxnFp4tfzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvTyK2u9bWbqmmnRrnLQPaJpKqdUvgrqIa2C1a0AuzS4vfH0ytmgdHeB8B6zmxYabhOaR4/yI9RDffaALKy8GuAt0nh1oN7ET75AwZ38e9HZWIqIh1Fuy6yblxosxt0aV05aiQKOjEJduZ5o+SK1JWfBGC6sB1Uw90TTRJeW/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Clyyy+Mh; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-30b8cbbb940so1569141fa.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740738106; x=1741342906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIGYvGr8Jl6yUj/HqP5Q3QiR6wOvhJB9B+2uBP88vis=;
        b=Clyyy+Mh81SQKtunKCmPGJCByRzZ3vlYmFp+cX+tHV7Dl6xodR+Vk4ksOWqsJ3eArC
         P7uP3cWnsyRD0FkwqFdoL4IlS+fM8bUOPI8aAJVnLk7QaUB6MmDUP6+X5Mc8Gyg40doQ
         F8VaxYsbqENEktVv687hB45YmMp3MGU37rq80ZMQcmOXznEln44rPWDnmQKDkCbJ54h0
         iD0oi/E352CawcJqDK9Syal24crm5EBfGMWPDQQmH+eQ9SmObKgFwzVtWFT5kNYHHBKl
         Q1rtOitH5TmCY5mzYiqrCR91yaH280OzVTlWeJMJFQxJ9SsVlI7VrvK1OfulpFA5Iaq4
         AlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738106; x=1741342906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIGYvGr8Jl6yUj/HqP5Q3QiR6wOvhJB9B+2uBP88vis=;
        b=iZ7rTppDJnwqPeIqbQOjkTjJse90r7bjqeTlNi26/f2pCEZSNVBtLwafu0r58TiQpf
         nMuirbB5Chph7y+yGntaGnChGNkLIHptzS9AK6HX3hRJNqkdO/5q5EzvdZhWMpt0FK5/
         NR6jweIssY+A4SKnC9cPoJBiZl2uj3EWNLGZESLVLl8VMdvUehYr2A0QY40bL/XpvznH
         8d46IFOCYB/uCViXT0bivSbS2mzKRT4pPBAEnBRxNohzhLo5LueLVoN5jbEBtsU2S7SX
         TfW0xnaDOiye3nnDAomQytafiDig5nvZ5eZihheW9YT7cdU/g3sLfeHugYa9lHqjSExG
         bTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUxajfdyfqroM5n7bz9hmuflJkQ776exLjX2rxQeQ99Gh7PmNCp7IGY6ypxpyYjY40JeL+oDlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdvz/+dVY4WkK7X0rrPX01vaY/bD8wZtVKewSFxdM1bIz/0uae
	7kOeVUXFQVRlDeYBL8kBUq3ZxGv/iQ/NcpvmGSUTCIjOcMJyuEm42NtSGWsjaNSJh9WfkpNSPsC
	lchGktvLE/m0TMpP0rW0kNlButmH9P24f
X-Gm-Gg: ASbGnctRse9TLL/RojpL5NdrnNUCaGXwqt7kQ9/q0GBK/+dY3PE6XVcWjB17xEdF409
	3P23JQN+aOjLPe5cvk1RcCyYx8QZAPY0TWxaixdDwhXva7mz0bHXxFYBm7QDA6VwZwaD+SEup7d
	giB03EzKbBghDcjN939d2fRhi6t2aixXpMD0nvZaPim+0X0Npqg62K1DOMEcxhu8o7IkKtsWs4d
	l2+PoRs3Yp5o65nkdK2nSp1dcpxVW8n7e3CRbwFcAJEu4Bp8eruMxDz8ZlsN2ipsi4El07ExKJC
	NcwYQMIxfEo99aUvOTyzFiumzs/p1MLkiRTdWRiUc7an12rkOvQN2e+myY9Sx2NsKZCxjas=
X-Google-Smtp-Source: AGHT+IHMPl425946PqahWxEjs+r4BO7YTD3uNKuvhCh2tysfRkYA76eBfX7RUdxjHLApQliLgAMH6ACCvbwO
X-Received: by 2002:a05:651c:19a5:b0:308:e46e:e62c with SMTP id 38308e7fff4ca-30b93309f50mr3696101fa.7.1740738106020;
        Fri, 28 Feb 2025 02:21:46 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-30b867bf3fbsm1045901fa.16.2025.02.28.02.21.45;
        Fri, 28 Feb 2025 02:21:46 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 924C318603;
	Fri, 28 Feb 2025 11:21:45 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnxV3-000eI0-BH; Fri, 28 Feb 2025 11:21:45 +0100
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
Subject: [PATCH net-next v6 3/3] net: plumb extack in __dev_change_net_namespace()
Date: Fri, 28 Feb 2025 11:20:58 +0100
Message-ID: <20250228102144.154802-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
References: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 43 +++++++++++++++++++++++++++++++--------
 net/core/rtnetlink.c      |  2 +-
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b8728d67ea91..7ab86ec228b7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4191,12 +4191,13 @@ int dev_change_flags(struct net_device *dev, unsigned int flags,
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
index 357ae88064a5..5c9d2bd29e15 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12131,6 +12131,7 @@ EXPORT_SYMBOL(unregister_netdev);
  *	      is already taken in the destination network namespace.
  *	@new_ifindex: If not zero, specifies device index in the target
  *	              namespace.
+ *	@extack: netlink extended ack
  *
  *	This function shuts down a device interface and moves it
  *	to a new network namespace. On success 0 is returned, on
@@ -12140,7 +12141,8 @@ EXPORT_SYMBOL(unregister_netdev);
  */
 
 int __dev_change_net_namespace(struct net_device *dev, struct net *net,
-			       const char *pat, int new_ifindex)
+			       const char *pat, int new_ifindex,
+			       struct netlink_ext_ack *extack)
 {
 	struct netdev_name_node *name_node;
 	struct net *net_old = dev_net(dev);
@@ -12151,12 +12153,16 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
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
@@ -12169,30 +12175,49 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
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
+					   "Unable to use '%s' for the new interface name in the target netns",
+					   pat);
 			goto out;
+		}
 	}
 	/* Check that none of the altnames conflicts. */
 	err = -EEXIST;
-	netdev_for_each_altname(dev, name_node)
-		if (netdev_name_in_use(net, name_node->name))
+	netdev_for_each_altname(dev, name_node) {
+		if (netdev_name_in_use(net, name_node->name)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "An interface with the altname %s exists in the target netns",
+					   name_node->name);
 			goto out;
+		}
+	}
 
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


