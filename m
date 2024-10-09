Return-Path: <netdev+bounces-133871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38341997512
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC611C2178E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4071E133D;
	Wed,  9 Oct 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q29BYG/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151C1E1305
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499452; cv=none; b=uD85D1+KW3ajoNukhI2eG8Ig9yPX+/MlyO2PzryxMK31bsxSZ3urRr+tyFErcIs8FNOM+bBsHbX1Bg9/NXH7ZnHtsNtgt7Y1jrfhMKx0Oo4jlxNfOhpw4WbDjUKWB2q/rRaaEfoI8P5UcNlQGDIHlbNrrZSvRAQMzYow7bFBuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499452; c=relaxed/simple;
	bh=U8fsdmCWU5tm80pdUdUWzBotyCsl5fCry4pinonfIkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ReJ7earsrEmeRPta0KHGZfvfdkHBjAKpKSD2GaeyDTlMlaiWLYkBgxX8ZhyDVLu4prwjdghRFKgGxo+Xwg+gZhgqp4um3qSSrUXr9D9eprO8DhxV5x3PVeskaSQFYndam2a2oZSXu7hK+QxovgfrU/SNSaWAwSPNpDFsjLUzLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q29BYG/k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cae769abso102356276.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499450; x=1729104250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVHu6Oqjpe1Zjs4nXBUh0ng8MyB/abNtjZH5mQJ4Iao=;
        b=q29BYG/k2dB8QJrWF4Y51fVwCYudmpIbKNHe3spL29HJcpKppmCpXP/PaQ0ZlDj1o5
         by4C9YcPP0xyI16BFdn7ZykTAr+iuFYFEsnZrmVaGfGrZB3e0vcf1eBBOBF7RzhUOCsJ
         5x0vn94j08xxUJJvKuM48NzDrdt+Qg/NimeKuJen7dl4VVrV6GkjLmoLynoFC8dyExou
         7ZgRR3XD+XsF+QRCdcoAfnqOBNb5xgEJgAMQCDBemODI8FHRnmPxBHYqsS1iY88gmGuv
         gASp1uYWvvHjF6IsEDlHFQSrm127n9WJo9U20urxTls3JG9w2AsL/sgTWOjTScGF+qxH
         lxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499450; x=1729104250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVHu6Oqjpe1Zjs4nXBUh0ng8MyB/abNtjZH5mQJ4Iao=;
        b=Vlg7KNA69fPjDsURJ5mZ766HozArfI2N+Y/Uq/S4qazWuyZpXcf2xKMSfkq94O2p7p
         wT0lwbPsnQBfb/YGUf+OsLvxkQionpXL2VXZj/7hxAdrmlSVPW5VLCLZ7m4vZrdeiSU9
         yLWC1O6Znb2gBLc3jaAM+pVM500xwCaU08OMglnwIP2/YvvyHOxyKRYjlEF+npJC7AGq
         rWIyK9J7D6cg23odAl8whGihzS7iRBIe4gWUmBBb4us5N2I1v0YxessK7Lgaa+kct6GH
         72qrekb3PjeMC9pVM7qlIMbL26K7cHGlTykIbRJAnxrqKkKob9224jTLSSCJvb9odgVK
         PFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThE+nDRqlT8DBUVyZQxUDm1zDjJ4QwtvN/83bvv17qVNx6sEeWG1dW2DoCs5yQyKTF0CxaOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4D+6tF5wkIVgnpoPiz4Dam3hl9xllYj3nHO6YPAu2sne2SGF
	9N524fKMgfeuaPusOEIAM/7AYPN8hClsY5TRcf/RfP56c/LKHAtBdgp/FWrS9d5tx5IZnzbUprD
	md7AUt4mHqA==
X-Google-Smtp-Source: AGHT+IGbJTJMIVOUbd/sb+2rk4KTK7bMR4N9htGC+Tw71BP+sR6E2EoUjKpMRb3OG44T7oWdIgjD9Mw7VZqgvQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:6904:0:b0:e28:ee84:e4d8 with SMTP id
 3f1490d57ef6-e28fe3559f3mr2209276.3.1728499450235; Wed, 09 Oct 2024 11:44:10
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:44:02 +0000
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009184405.3752829-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009184405.3752829-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] ipv4: use READ_ONCE()/WRITE_ONCE() on net->ipv4.fib_seq
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using RTNL to protect ops->fib_rules_seq reads seems a big hammer.

Writes are protected by RTNL.
We can use READ_ONCE() when reading it.

Constify 'struct net' argument of fib4_rules_seq_read()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_fib.h     | 4 ++--
 include/net/netns/ipv4.h | 2 +-
 net/ipv4/fib_notifier.c  | 8 ++++----
 net/ipv4/fib_rules.c     | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 967e4dc555face31a736f6108cea6b929478beba..4c2e2d1481ebff5292b9e433f56fa7289ba8e139 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -347,7 +347,7 @@ static inline int fib4_rules_dump(struct net *net, struct notifier_block *nb,
 	return 0;
 }
 
-static inline unsigned int fib4_rules_seq_read(struct net *net)
+static inline unsigned int fib4_rules_seq_read(const struct net *net)
 {
 	return 0;
 }
@@ -411,7 +411,7 @@ static inline bool fib4_has_custom_rules(const struct net *net)
 bool fib4_rule_default(const struct fib_rule *rule);
 int fib4_rules_dump(struct net *net, struct notifier_block *nb,
 		    struct netlink_ext_ack *extack);
-unsigned int fib4_rules_seq_read(struct net *net);
+unsigned int fib4_rules_seq_read(const struct net *net);
 
 static inline bool fib4_rules_early_flow_dissect(struct net *net,
 						 struct sk_buff *skb,
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 276f622f3516871c438be27bafe61c039445b335..10c0a8dc37a23e793007ee47706b402fffbd08da 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -263,7 +263,7 @@ struct netns_ipv4 {
 #endif
 
 	struct fib_notifier_ops	*notifier_ops;
-	unsigned int	fib_seq;	/* protected by rtnl_mutex */
+	unsigned int	fib_seq;	/* writes protected by rtnl_mutex */
 
 	struct fib_notifier_ops	*ipmr_notifier_ops;
 	unsigned int	ipmr_seq;	/* protected by rtnl_mutex */
diff --git a/net/ipv4/fib_notifier.c b/net/ipv4/fib_notifier.c
index 0e23ade74493ce10a3f2572c39e091f132684884..21c85c80de641112d66a28645b1fb17c7071863f 100644
--- a/net/ipv4/fib_notifier.c
+++ b/net/ipv4/fib_notifier.c
@@ -22,15 +22,15 @@ int call_fib4_notifiers(struct net *net, enum fib_event_type event_type,
 	ASSERT_RTNL();
 
 	info->family = AF_INET;
-	net->ipv4.fib_seq++;
+	/* Paired with READ_ONCE() in fib4_seq_read() */
+	WRITE_ONCE(net->ipv4.fib_seq, net->ipv4.fib_seq + 1);
 	return call_fib_notifiers(net, event_type, info);
 }
 
 static unsigned int fib4_seq_read(struct net *net)
 {
-	ASSERT_RTNL();
-
-	return net->ipv4.fib_seq + fib4_rules_seq_read(net);
+	/* Paired with WRITE_ONCE() in call_fib4_notifiers() */
+	return READ_ONCE(net->ipv4.fib_seq) + fib4_rules_seq_read(net);
 }
 
 static int fib4_dump(struct net *net, struct notifier_block *nb,
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index b07292d50ee76603f983c81a55d45abca89266e1..8325224ef07232d05b59c58011625daae847af30 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -74,7 +74,7 @@ int fib4_rules_dump(struct net *net, struct notifier_block *nb,
 	return fib_rules_dump(net, nb, AF_INET, extack);
 }
 
-unsigned int fib4_rules_seq_read(struct net *net)
+unsigned int fib4_rules_seq_read(const struct net *net)
 {
 	return fib_rules_seq_read(net, AF_INET);
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


