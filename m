Return-Path: <netdev+bounces-133873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA7997514
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0CE1C2138A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A61E1037;
	Wed,  9 Oct 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XTYx+MQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6951E1A2D
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499456; cv=none; b=XqQuBhjgima85411iumCUpFx+vvtqMHMtpqUYufl7uiGbhIEc9pP5kgWmmHRH1bAUXKmonJmyQgGwqDsrUujJOAEr0MhUHX3nqMNYZEFRp28hkLwPmOyzzWQqMIIMwbpzGyz+M+zw8N/GUUyRRTdkXwcsko06Rnn8SJTIOK2K/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499456; c=relaxed/simple;
	bh=bo8W9ZMvqGAnB1UHLoQV6O/9djAa9UH6iqBalojdqOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3u3lkUdTuk1yxN4hiyWFSXmJjuXCsGPOcLMIMAvW5w8WiG26cLZKDBwsz7CPNGaaL8gvia2pyQG4aa5Qbkr2smKFdlbpmNEEZHb0kIj1p0ZxPr+wb9+MRoOl1LRnXlyeovUB9k+mDafCQaArvL1MItsY41zD1r4gqw1kYc0Yoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XTYx+MQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29097b84c8so96614276.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499453; x=1729104253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nCTJYL1opnVGlcwAvLc4p21H9gJQSXakHqmPoxdj28=;
        b=2XTYx+MQHWyU6YsDaxTnnrg3eCsjstNzTxSMiE7zHWDUl+oplLWOteuwvG1JZcd0PG
         VdctZa44Ej1NVUJ9gOm0h9jlZb8bfgZgLJK4quHAOUQSeQKL5/+WtDEssILmOMcw70RW
         C0R6VHX6U2BM3AwdhnOjBD0ZrfqI95d12LhiljQAlyea73lMHv7a8fZ7mlw+aG9o895m
         HMbZwf9mY3z2R1pe3N/Ef4mlw8Q22t9tOYlnuTvTUBQDV4m5rEiZXRVBXv9Mt4OSaC0C
         8yTwpDNM72RsgEK/J8eIQH7i5biBMM/b5mer9rO94+nHIulAAdy23+yu1tUQEW6zrv1s
         YTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499453; x=1729104253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nCTJYL1opnVGlcwAvLc4p21H9gJQSXakHqmPoxdj28=;
        b=AEtyVjdhobFJfXAm9NeKXCiypYaaz6VMwZQrXgcgGk1ok8WGQiFKauXBo9RXr4W5Pv
         sKTrRoIHnI1n9CMmti1NqBfZu8IyXazXBpXnSPmBXEZIrTCQDOKwEEfZ99EkYHdSpxfk
         KN5hF72YWKtJXg8IVhsPzT7teyETbe4Y8xQLJ9Cp4mEEpCoAgdicmWgBjkExANDySxlO
         hRK5LVETUw0ftbNF0fhL9pH9pT9Vj4YQ6ZDB3OvoXVE8cHbR0lm+0EU9PPDSC7eRYgYQ
         C0rkaKyVhPXQ19ClKA5GeB/j+I7gtr5IAZGcdpnp4FGwEXw/dd5RfT0bshe/Xg6lSsn8
         hirQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZQRwt4B5l1AfEaZ/RFJgZQvR8Ij3rGIdNSNIHF9GZPibrW79wGJKAehNM2C6hlKAdP+Y5V1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+8sXi1clYVCwCj6kk1IN67vpadBQ553utf5sHJiAHQKTX0IG
	acJT4R4pIZp/Pxbd5nlZ0iJZ1QWOCxLT+fM1KSS3AFznAd1T8GKku9CIuzvdyw5DQu1lqc2lmfs
	7kKdU2CVDAQ==
X-Google-Smtp-Source: AGHT+IHh1/niW8ubY/DJdz3j0Y84jTjoQPR05iwjtZrNJi/Ke1qJiTAvtlrGq4O4xgjCjq+m6FOhAy3zZ3mY3Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:b86:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e28fe516b5amr2569276.8.1728499453383; Wed, 09 Oct 2024 11:44:13
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:44:04 +0000
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009184405.3752829-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009184405.3752829-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] ipmr: use READ_ONCE() to read net->ipv[46].ipmr_seq
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

mr_call_vif_notifiers() and mr_call_mfc_notifiers() already
uses WRITE_ONCE() on the write side.

Using RTNL to protect the reads seems a big hammer.

Constify 'struct net' argument of ip6mr_rules_seq_read()
and ipmr_rules_seq_read().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c  | 8 +++-----
 net/ipv6/ip6mr.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 089864c6a35eec146a1ba90c22d79245f8e48158..35ed0316518424c7742a93bd72d56295e1eb01aa 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -288,7 +288,7 @@ static int ipmr_rules_dump(struct net *net, struct notifier_block *nb,
 	return fib_rules_dump(net, nb, RTNL_FAMILY_IPMR, extack);
 }
 
-static unsigned int ipmr_rules_seq_read(struct net *net)
+static unsigned int ipmr_rules_seq_read(const struct net *net)
 {
 	return fib_rules_seq_read(net, RTNL_FAMILY_IPMR);
 }
@@ -346,7 +346,7 @@ static int ipmr_rules_dump(struct net *net, struct notifier_block *nb,
 	return 0;
 }
 
-static unsigned int ipmr_rules_seq_read(struct net *net)
+static unsigned int ipmr_rules_seq_read(const struct net *net)
 {
 	return 0;
 }
@@ -3037,9 +3037,7 @@ static const struct net_protocol pim_protocol = {
 
 static unsigned int ipmr_seq_read(struct net *net)
 {
-	ASSERT_RTNL();
-
-	return net->ipv4.ipmr_seq + ipmr_rules_seq_read(net);
+	return READ_ONCE(net->ipv4.ipmr_seq) + ipmr_rules_seq_read(net);
 }
 
 static int ipmr_dump(struct net *net, struct notifier_block *nb,
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2ce4ae0d8dc3b443986d7a7b4177a057f5affaec..3f9501fd8c1ae583d4862128e8620ce6cc114d25 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -276,7 +276,7 @@ static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
 	return fib_rules_dump(net, nb, RTNL_FAMILY_IP6MR, extack);
 }
 
-static unsigned int ip6mr_rules_seq_read(struct net *net)
+static unsigned int ip6mr_rules_seq_read(const struct net *net)
 {
 	return fib_rules_seq_read(net, RTNL_FAMILY_IP6MR);
 }
@@ -335,7 +335,7 @@ static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
 	return 0;
 }
 
-static unsigned int ip6mr_rules_seq_read(struct net *net)
+static unsigned int ip6mr_rules_seq_read(const struct net *net)
 {
 	return 0;
 }
@@ -1262,9 +1262,7 @@ static int ip6mr_device_event(struct notifier_block *this,
 
 static unsigned int ip6mr_seq_read(struct net *net)
 {
-	ASSERT_RTNL();
-
-	return net->ipv6.ipmr_seq + ip6mr_rules_seq_read(net);
+	return READ_ONCE(net->ipv6.ipmr_seq) + ip6mr_rules_seq_read(net);
 }
 
 static int ip6mr_dump(struct net *net, struct notifier_block *nb,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


