Return-Path: <netdev+bounces-93704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A870E8BCD85
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7E1F21104
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439614388D;
	Mon,  6 May 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+FdRltv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0044143867
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997521; cv=none; b=m8HTIbo4KN1VHlnA5wshozuBCfC222uGTyJ4k+DpaDC5NQUwN3DpHTilF8pY9iQMDEqJ5O6OkMpbll5zZtDFp4ZOXKY1wMye9ThO3faKsfI1P2MMrVp2hs+LrMaGi0Ktvx58QTGxaoKJgVKLZIlbCDknH2MYnusM50VrHH5SzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997521; c=relaxed/simple;
	bh=5lLBLjtuylKM1sLjkqaHlYcFDN2ulhy61uxmvcbbQ+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HCpW5+pka3JH4vwd0f4Ax+g2PVzLHdyzuz0keqgir368wo5f2gwM7X/jSa5yhkoUJG6429XJav5F/S5PUYkwU1Is1uIf4Cf27gilIgJ2sWWmfEDWppD/DMv9AzngDuiTvJbehmAAuaN+mAaUszcVB0y1B9zrby826y6YdP1ZCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+FdRltv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de617c7649dso3728895276.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714997518; x=1715602318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjfrUS6KgXlK+FIQF6JUoUN1dMZgXtxoVsDZ5CFF8WE=;
        b=U+FdRltvSQVhav039VZvYQJkMgmLdaM9di/pW4jXdwXsrrW2lGGLEsSnn/Nw6xKzvN
         xVggP35f+kTqjBy1Kw0YJKOCwSejAHer9CAFfJpjA1RDMwGYe1588VXxM7fpFB9AbVyW
         MfPQTfzE7n6qLJtKR1YizsZnYzQxutItsVgiC4M9QJ/G429hJEzdFyMT3gsD+BQpNE4O
         IMV6e//UOFCBoG9cdayrkRQYA8UmvQnV5J1TfVWm2QvyW5A0iFOsTUTUP1LxP4jNicTM
         ve9ERBxkpit0Hv33SEyJ5FUBH6O+r1vVUXJ3ATswHWL9RFZ4XmtMGns3ZpEmi612jYfi
         S/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714997518; x=1715602318;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjfrUS6KgXlK+FIQF6JUoUN1dMZgXtxoVsDZ5CFF8WE=;
        b=rxiYEmRlXznBzMiYB9YUaswv+6LqpUbvGVT32nHavyFYBLU/QIkdOgBX/tqpFDT+ki
         Nc6Oc12h7J1X+HTcyeWeLVmryxInnCiY2qV5VsudZq6PVa8QJFIp10cBPXEFkgQBPDr0
         n4BwRhuzpKnS1Demyf4FgfEfK8ufYH1GoLx8mCdGg4eGxoM8V+HUC3CZX93xYYiJgUQj
         s+eDjZ04feUuXXgnSOMHTv7dIIs8MbjzMmPoIDT7z9MmVDBMkSi2z9VFPhb7FrACE6G0
         gAWKlGwRPlBQx1iymCoKigFGHj+gmei4N7Pia6537H3KlgqyY8M13glQHatON483h3qh
         w+Xg==
X-Gm-Message-State: AOJu0YwIfgNIBu7wBtm29jqtc5ATl3kR7jzmFOWFpXC5i1wS9x6oX5mz
	78Gj7p02Z6/kHPmFrWbhWrLDG/gvgUqovZAAY2Yzqg6b4zII+ebMfei8d1LYxpfc2kFJHq8G3OP
	N1riWoBfHPg==
X-Google-Smtp-Source: AGHT+IFLlenAnPC47/+e108SNSRtdx/EW+uKYHSRutRD6fMF3iBT6CDj1Psfu0M+0wmB4/v5oO1EKTeQ+ufnbw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c504:0:b0:de4:654f:9ad0 with SMTP id
 v4-20020a25c504000000b00de4654f9ad0mr1280168ybe.6.1714997518681; Mon, 06 May
 2024 05:11:58 -0700 (PDT)
Date: Mon,  6 May 2024 12:11:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506121156.3180991-1-edumazet@google.com>
Subject: [PATCH net-next] phonet: no longer hold RTNL in route_dumpit()
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
 net/phonet/pn_netlink.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 59aebe29689077bfa77d37516aea4617fe3b8a50..c11764ff72d6ac86e643123e2c49de6f0758bf97 100644
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
+			break;;
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


