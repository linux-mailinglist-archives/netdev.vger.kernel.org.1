Return-Path: <netdev+bounces-75232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F882868C19
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F811F23517
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64CC136679;
	Tue, 27 Feb 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xjQB7PHJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A1136667
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025859; cv=none; b=TRGfTqns9jeaex3NV4/KidfC5WKAm1XqGYnbYJQKGVrTdZ4yMQKBxLDKXyxpwMZyEuvYv1v1LZkeChWlNzOhwTb1pVRwFO+AkYDBJCPGS4IUrOq9pRHlTJImoRdzeFsAO3o0KCzy495ARxLwSlb5OhxfLcB7F+PFajr0csL6oYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025859; c=relaxed/simple;
	bh=vh2ICDBbTmXCv2gkACYwF/+D4SSe8wt3o9O6pnhy9ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gr46s9ExZRM+PJIpzxTzqevw0CGMFg8CNsBZWjTwhoJslC1Tl66TMTe/wQUL4TT5iFAV/Cla1LXzm+EA69mCJRjUgE8drj3nEeSTNDzPz+mTnxmtX44w1vc67HbIxNGqNO6oqFILsA1EXD+DQ9Il9L5rNb7C/F3h/q9x0lHQMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xjQB7PHJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so49154307b3.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709025857; x=1709630657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wPjrECtZLa3Ue5MegOH35CkWKzmgA77jCFx80Y9Fbc=;
        b=xjQB7PHJ2Fun5/WB90gDI0iezRAgANgI8EiktKHit0HI1wZxfL4yTAf/4HJ5x+6ZDB
         XTmmQxW22xip01EzBm5hSrztdzV39ZTgTYO58TnFyPA4kjes0cFfit1Xl9H3mZR7d2uk
         yaTrGhRQix89B58ehVBZaTqaedw8zlqXpPU3wGE1pxKnt16cgnzf5Dc7GC6oCml+2i7P
         InTcLoTxsZKeb/3UAeDiCfLqig5X/clJs0aXT5UmU05saPbVJ3SJMGN2b+dYwdKnf4KS
         R2UzFqilxWwYgASZD8wSDMz5U9kp9aiwjYemDVcDVhDRvW9fniuMBMmnZpHQPWnwfq0U
         GaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025857; x=1709630657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wPjrECtZLa3Ue5MegOH35CkWKzmgA77jCFx80Y9Fbc=;
        b=Ed0Q11/lLp0sJzGoPrax6RVyIf1+BZ7QcnbFFJsLczXwMvzKDnoe1LrlZKl1eDvFL3
         h+ITpfoCJUijtRHC6cNUse0ir8l/O3hgs0eHcyAkCNBPhhx/TQdFCyesHBMei3a9FP3C
         F5KaWr185T0YCTxK4dNzIxrJwyh5yxwfUKxA3T/vPKXVN95o+XghtU8RN8RDUwl4h/Bo
         NRd6JcKnTlF17XPck1VTli57k/7Bf9cn9ze3wt3zXsoeTZHuR6ugnz9f+UunRcggC3uR
         /QRwPIgjL8ExnQvrK+E9dNPmQ8DFVlPGzv2ps/ajl84TFgPPBRVJk0bo1X9iNg3G9hgV
         ZRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQbDRkA4TMuuSNTGBP2QqY/w5e8kCKhf5Vuzmjf2isWRsNgopoI6urj5UULB/pRVbFhAesVAB7MoTkL8G0c0AT8QfuZQY/
X-Gm-Message-State: AOJu0YxNC7QB/wwr3H14PjKujiKwaCZZKwW/hxqYdgClnpromT3NBMEV
	8Soogi8CENDv3cOUOwXRN6nC9KCXEpgKjrXDedb2lyq7aIQBhFZ4OUdSwviFvF983O3vFGT8DW3
	xquUEf03Vuw==
X-Google-Smtp-Source: AGHT+IHP3IU8uUPJaSpjMGLttJYkgxDX5U1cmCVkjyWq7WbfetT8pElCuSiCG5YfR2EP/xqEFV6lRIOSUxWpIg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102c:b0:dcc:8be2:7cb0 with SMTP
 id x12-20020a056902102c00b00dcc8be27cb0mr68263ybt.0.1709025857118; Tue, 27
 Feb 2024 01:24:17 -0800 (PST)
Date: Tue, 27 Feb 2024 09:24:10 +0000
In-Reply-To: <20240227092411.2315725-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227092411.2315725-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227092411.2315725-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] inet: do not use RTNL in inet_netconf_get_devconf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

"ip -4 netconf show dev XXXX" no longer acquires RTNL.

Return -ENODEV instead of -EINVAL if no netdev or idev can be found.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ca75d0fff1d1ebd8c199fb74a6f0e2f51160635c..f045a34e90b974b17512a30c3b719bdfc3cba153 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2205,21 +2205,20 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
 				    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
-	struct nlattr *tb[NETCONFA_MAX+1];
+	struct nlattr *tb[NETCONFA_MAX + 1];
+	const struct ipv4_devconf *devconf;
+	struct in_device *in_dev = NULL;
+	struct net_device *dev = NULL;
 	struct sk_buff *skb;
-	struct ipv4_devconf *devconf;
-	struct in_device *in_dev;
-	struct net_device *dev;
 	int ifindex;
 	int err;
 
 	err = inet_netconf_valid_get_req(in_skb, nlh, tb, extack);
 	if (err)
-		goto errout;
+		return err;
 
-	err = -EINVAL;
 	if (!tb[NETCONFA_IFINDEX])
-		goto errout;
+		return -EINVAL;
 
 	ifindex = nla_get_s32(tb[NETCONFA_IFINDEX]);
 	switch (ifindex) {
@@ -2230,10 +2229,10 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
 		devconf = net->ipv4.devconf_dflt;
 		break;
 	default:
-		dev = __dev_get_by_index(net, ifindex);
-		if (!dev)
-			goto errout;
-		in_dev = __in_dev_get_rtnl(dev);
+		err = -ENODEV;
+		dev = dev_get_by_index(net, ifindex);
+		if (dev)
+			in_dev = in_dev_get(dev);
 		if (!in_dev)
 			goto errout;
 		devconf = &in_dev->cnf;
@@ -2257,6 +2256,9 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
 	}
 	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
 errout:
+	if (in_dev)
+		in_dev_put(in_dev);
+	dev_put(dev);
 	return err;
 }
 
@@ -2826,5 +2828,6 @@ void __init devinet_init(void)
 	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
 	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr, 0);
 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
-		      inet_netconf_dump_devconf, 0);
+		      inet_netconf_dump_devconf,
+		      RTNL_FLAG_DOIT_UNLOCKED);
 }
-- 
2.44.0.rc1.240.g4c46232300-goog


