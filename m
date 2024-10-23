Return-Path: <netdev+bounces-138062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF19ABB94
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CAB1F24629
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FC8249F;
	Wed, 23 Oct 2024 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIVAKFCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753718289A
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650741; cv=none; b=iTJarkEhLA1mREaoE2llPIYzj1jcOwshzlVja3VGGrHO8q35SpYBmz5AW9bEDoVVOKA3cDyfZ8xU8mLkKyETN5CoW3ttQ1Ei4SZcgYXuYuBUfpX80EOu+Cmw6RksKG/qi2YNZyfzk63v/voejyBiMM6j23bnpn6JPc7sMnk+/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650741; c=relaxed/simple;
	bh=z41vDWpbYePdTd0mhv3d1zCU5AqlJoE2kQemUoZg2LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l77RqZb8H/SmkvvNuyBOadwOVgCINj5DkiYp7C768EDOy00en/XuuVE+KK+pbpCOkE9lIAjU/TjRu6Tt/ilqBGo1i/FC1XPElQwut7Mcz3Sy5vPgnynRzP1asYfSs3rxsifNO5RYpc9gp2oHKwxtjrnNQd6SEv2Z8e27iUqC4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIVAKFCj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7181b86a749so2000326a34.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650737; x=1730255537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVqrAYudBHADfRNQe+vlD7YTXBuMXBYKujpwwARcSME=;
        b=AIVAKFCjAJzEC/XDo/BwuNDn71cXMdqFORpGJxGZJYZSuliBaI2kdh9BfiUyX5CVjA
         KEH+uH/tgogO66V1hDCEWoKtUYX+sk2ZFlWDJZOUq/qfzeqHFtc0V1GBaAd1Y0KbNFCr
         GaAPUsNMxSJdE/u09CeFr7cQEPvsvh0fs1ie43zhLw9MZTgKHnbYwW8QmAbRTF1HExCN
         ocKNE4WLr+Ja2wnUCymOW3Nsm47J7qRJcVDDEli6BQLt9LvVjyLfmM5YQsTf8PVQ7oS8
         YxVgZGLnPZOwiAR0O9m1ZrmlWUzPoqjy1dvZNCmUgbG8R/WRHlDIqffTZCQJvQnWNGU6
         lKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650737; x=1730255537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVqrAYudBHADfRNQe+vlD7YTXBuMXBYKujpwwARcSME=;
        b=rYiHvEU4SHseWqVDPzNnZ8J5SmyX22b6Xsnmg8H3s2txXu0ytn1zV08fKNca9v0aVI
         D0dYl/P5dmK0hTK+vs6cyDbcsjDMUopCgLoek36uyxzHMnEsWPGO7+gO2FQIxto19ZQk
         8a/RFySiw6Nb2CnMs9X8I9sf/DlWLKUy5oqOg3H3VTUFsV/qYgGVdivxGeFdP/tJqi0F
         G8Aazt5V7PZH1qrWqyyge+XNC7D1RvkYe4+T5qGZFa+B2/5GGrTte+IWZsAhU8oD2J9s
         lpSY8axTPBK1NnStIAvSdX6YRYwY2LxleTiZsUPuhLPIBQi0hRJ4o8sUUQ29Qn7AnzY/
         fi8g==
X-Gm-Message-State: AOJu0YzADGt+xQmV2mhe7MI5ILE5+gqsP1UhOgmu5S/DC65dh1ksulM0
	vF04VlH9Ewgmd6Q1Z/YrXUrRr+rPTHRTeInQQSqXhW2/6MmgJunsM30GJKMwmy8=
X-Google-Smtp-Source: AGHT+IEEy53EhLbM611LaZaiVpr7Vhv8np5U9KKyfV4GHSBXQ0tLWzlzRw69ax12p1INASbhgVNQ5w==
X-Received: by 2002:a05:6830:6687:b0:717:fb12:2c2 with SMTP id 46e09a7af769-7184b37e49cmr1211115a34.3.1729650737574;
        Tue, 22 Oct 2024 19:32:17 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaea9386e5sm4972284a12.0.2024.10.22.19.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:32:17 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/5] rtnetlink: Add netns_atomic flag in rtnl_link_ops
Date: Wed, 23 Oct 2024 10:31:43 +0800
Message-ID: <20241023023146.372653-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023023146.372653-1-shaw.leon@gmail.com>
References: <20241023023146.372653-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently these two steps are needed to create a net device with
IFLA_LINK_NETNSID attr:

 1. create and setup the netdev in the link netns with
    rtnl_create_link()
 2. move it to the target netns with dev_change_net_namespace()

This has some side effects, including extra ifindex allocation, ifname
validation and link notifications in link netns.

Add a netns_atomic flag, that if set to true, devices will be created in
the target netns directly.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 3 +++
 net/core/rtnetlink.c    | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index e0d9a8eae6b6..59594cef2272 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -74,6 +74,8 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
+ *	@netns_atomic: Device can be created in target netns even when
+ *		       link-netns is different, avoiding netns change.
  *	@maxtype: Highest device specific netlink attribute number
  *	@policy: Netlink policy for device specific attribute validation
  *	@validate: Optional validation function for netlink/changelink parameters
@@ -115,6 +117,7 @@ struct rtnl_link_ops {
 	void			(*setup)(struct net_device *dev);
 
 	bool			netns_refund;
+	bool			netns_atomic;
 	unsigned int		maxtype;
 	const struct nla_policy	*policy;
 	int			(*validate)(struct nlattr *tb[],
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ff8d25acfc00..99250779d8ba 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3679,8 +3679,9 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(!link_net || ops->netns_atomic ?
+			       tgt_net : link_net, ifname, name_assign_type,
+			       ops, tb, extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3700,7 +3701,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
+	if (link_net && !ops->netns_atomic) {
 		err = dev_change_net_namespace(dev, tgt_net, ifname);
 		if (err < 0)
 			goto out_unregister;
-- 
2.47.0


