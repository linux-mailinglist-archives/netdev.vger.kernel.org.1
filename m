Return-Path: <netdev+bounces-94099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607778BE1DA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649A8B22EC7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0445156F5D;
	Tue,  7 May 2024 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Trch9/hC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7073530
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084271; cv=none; b=O1NUGchCE/qHJbD2CE0vgGEfvM6jvPz/ON8UVhIMbIH3af8b3jXeG0mdwc8BQ0vlR+Ud+ojWkiDMyzddoqXnk9vD6sPuT2Bgo/3RtMC6ly5oVlnpPmhNNhbhZ0vhUQJzt7QN3I2qRYqpmAQhBh2yX4XbL47JH2p17b5hGrmO6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084271; c=relaxed/simple;
	bh=CFnhRfVVMb6W18q4kQBKyyaO05P1kJKdUisOQqI/Xc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h0q2vP244SKQY4lOG5ENb7V0+SAn+dLFvI7Dq8EyINEZKsJ9wcGs/sDZSeb0YkBn75rCP6HejWbSo9+M6fw3Ioa0iCr4cFsaaqYzMrJpEzcTAxRLdDsBi025wLu4gwFB23gq6tb5wAdAMbHw6ge71qvOLClI5ZMKp+L1ClTkre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Trch9/hC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0c296333so66154087b3.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715084269; x=1715689069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SaKcvGzisgxVw+30ti0gDUw/ORGEq//I2ZgeYuQh9vk=;
        b=Trch9/hC0+4Ht/TpxYLT2uN/TP3f1NMIR6vrdnzVfjGABdiVPg6ogk0uSOSR4ABRbD
         GXgoUTy94GhkOyTYvRG6fjmKW717p5eux16S66H39S4cbhDOtr4MQP5SONlm4FdQ4hN+
         9El6lLFadqDJMmZqp5NMlZ5sE1L6eokLynkKmtcXIB+eZntzB5pV1lXVdwMrou/cuShS
         9D2wBcfa8OkzGc9mYLfgjLYzIcD6fK2iPNUxKCI3nVNM1TOyo0h/t1wbfEbnknRxliZA
         qZzADDv0pWG87/OrOtpVpd8vEpQl5S59hUA6BBRZ6HA21EZCtjmsFiR4ShR2SLIDy8lz
         4ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084269; x=1715689069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaKcvGzisgxVw+30ti0gDUw/ORGEq//I2ZgeYuQh9vk=;
        b=GlH9fYU+dyQDN2Fekwyvu0tBr/e+FO40QldWZwRoHPMVq2QldChWx/HlX8GLZpQ5Vi
         lw39kjCf5gQKmXGyf5vmZSCffICqO0/OGRZgjJ3AftsX5fRC30GBmaGXS+IrzZo7SRZI
         wN6313efvtfg5+PyodSUIvesnj1wpKecBFG7upWj/HzVVGmjFOo+znlY477WA9Opgn1h
         1bPHWOC13/xSlCI3rnZ6garQI5tDjnSu/ywrMMTlP9EGGUCERF6o3V4YzVGHaM5k9YoX
         VGUQhWTWDelfxeM86ao41Mme9UiT4krf4bKvLJJ79Sut5Pm/PsMUvul0vjJkNwgJXzgi
         6zcQ==
X-Gm-Message-State: AOJu0Yx3zuvS2eDUJU/QfFiEG4KLQI0jxd1lgRZyRi5OWJn5bj9AjbvE
	b8zhGfByPjqMaxpKg9kw+pI6l2X4wn7yjM19ye7g+84NqN9Nlogae3l1Tp4FYovgeMSvjVMLKj6
	4pSACAIlcsg==
X-Google-Smtp-Source: AGHT+IFbAGnEohbfOzVTI7/wzXp/auUKxB7x5D7PFDuAzc70kQiYLe59z3NYj59Yupwe8zUSTqbzudQVR7sPEg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:910d:0:b0:611:5a9d:bb0e with SMTP id
 i13-20020a81910d000000b006115a9dbb0emr669325ywg.4.1715084269353; Tue, 07 May
 2024 05:17:49 -0700 (PDT)
Date: Tue,  7 May 2024 12:17:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507121748.416287-1-edumazet@google.com>
Subject: [PATCH v2 net-next] phonet: no longer hold RTNL in route_dumpit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"

route_dumpit() already relies on RCU, RTNL is not needed.

Also change return value at the end of a dump.
This allows NLMSG_DONE to be appended to the current
skb at the end of a dump, saving a couple of recvmsg()
system calls.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Remi Denis-Courmont <courmisch@gmail.com>
---
v2: break;; -> break; (Jakub)
---
 net/phonet/pn_netlink.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 59aebe29689077bfa77d37516aea4617fe3b8a50..92245fdfa846cb8b9747764a3330e17d8c6b1f16 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -178,7 +178,7 @@ static int fill_route(struct sk_buff *skb, struct net_device *dev, u8 dst,
 	rtm->rtm_type = RTN_UNICAST;
 	rtm->rtm_flags = 0;
 	if (nla_put_u8(skb, RTA_DST, dst) ||
-	    nla_put_u32(skb, RTA_OIF, dev->ifindex))
+	    nla_put_u32(skb, RTA_OIF, READ_ONCE(dev->ifindex)))
 		goto nla_put_failure;
 	nlmsg_end(skb, nlh);
 	return 0;
@@ -263,6 +263,7 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
+	int err = 0;
 	u8 addr;
 
 	rcu_read_lock();
@@ -272,16 +273,16 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		if (!dev)
 			continue;
 
-		if (fill_route(skb, dev, addr << 2, NETLINK_CB(cb->skb).portid,
-			       cb->nlh->nlmsg_seq, RTM_NEWROUTE) < 0)
-			goto out;
+		err = fill_route(skb, dev, addr << 2,
+				 NETLINK_CB(cb->skb).portid,
+				 cb->nlh->nlmsg_seq, RTM_NEWROUTE);
+		if (err < 0)
+			break;
 	}
-
-out:
 	rcu_read_unlock();
 	cb->args[0] = addr;
 
-	return skb->len;
+	return err;
 }
 
 int __init phonet_netlink_register(void)
@@ -301,6 +302,6 @@ int __init phonet_netlink_register(void)
 	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
 			     route_doit, NULL, 0);
 	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETROUTE,
-			     NULL, route_dumpit, 0);
+			     NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED);
 	return 0;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


