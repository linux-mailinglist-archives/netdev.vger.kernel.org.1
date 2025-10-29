Return-Path: <netdev+bounces-234106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E03C1C7C5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80B014E2EB9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F8351FA1;
	Wed, 29 Oct 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OthdNM/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85999354AF1
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759246; cv=none; b=i5lteF6vKPFuZEkoWueLWdL6URrrS05eCrnpZVr0GgBJzMNzo7hpzuS2lP4xEfnJkpdhMUn6gU6oM8xh3C57liDlfd4CdFfrDcWBO/FApKhmlUVrdTgDKkHWK/ohZWk5qYfTC+SsmKftRVZtOPOtXjQRUJk8Ubg5n/T5PrPHNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759246; c=relaxed/simple;
	bh=H1grl8U3dh5NthvTrOLfJsoOdA8zldptZmufLSzL8KM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nV3VLZUcJqXqamABcUxH4S9/2xlgq+mh+S2iCczQ3JX32SrkMLgSp5vrNHpcequrgaVC2b8uE7WwMZXlKQlzOpHE0b2BTzDdHDx/eNv5dFpJblK2aMhES6PpucTGNDCPdt4eWbjCySGSOuIBU2StznFJl1RYZR9tCfZI9mBXuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OthdNM/l; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-294df925293so627395ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759244; x=1762364044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeR6D0GBIzcfXk38fA/ZB6RXtxuybGOe/gtHSXX9oUc=;
        b=OthdNM/l3FKvqBNGJLYVhP5Z/2jPH0p4Nuys2MweKbQ3UvEvgEJd+2TdvjFwwz6M/B
         9cvz5b+MHz4nQq87MyuNhDih8okCIEeySvk+Z/9tdbpvXZVifZmLJMbVo75pxpsQ0Z2z
         zIQBkFWvUY3poqOa3jb/I72SNnT89gzZg+hx9X8nhVNVYbtaNMr892Zqr20zirTNXq87
         naWYkenyF6HVtRg+s/B3d0CkZPMO4sdT0hYhkLA4l/kZ0PhvkBBp/iwVAHv+Q8O++mGC
         6OUtaT23Mo3sv7rP/whtRN4QrLwPUachMwbKvk0MKASv3c8ly/eGZpy3uwDsbtGmxNdO
         pqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759244; x=1762364044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeR6D0GBIzcfXk38fA/ZB6RXtxuybGOe/gtHSXX9oUc=;
        b=FRb2MmNcHdQ05qm2fRCLkbWASBORH65YiRUQ7Tw3mhnGL1R4BfdNAxSly8RTUouLyd
         Dgco5QJyPJwmNQP7s6QX0papVENn9+6LNY9q4dwdWWpdctXUjkrDG9Y/m+wNi+l4HLRr
         pf/E0Ik0sFHd0kxZ0uAi5coaqwM8eSesXZgHPQJUSpJqRh40JXIQukCwfTjnApNG05vA
         I1Dw27aBMgN5j62xYOqZXYVs0yenZ37BQFwfL1EqW0XuzX6yced1pfUJ7LW3Pw97NKLj
         FHGU/Kf+dxq5jD4rSw0CZILZDr6JEri84pmZ8tVztA5a/VbndmTD0UAi6kTj+DjgJwyL
         RG3A==
X-Forwarded-Encrypted: i=1; AJvYcCX7QsGReSAP5pFvCxw3fZj9wKpVDYbBXHf7BpW2Cdml43CZMfnX7/ZRVG/pD94P34XjlxkrfjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnz3amJY8jQZdbfv1eBkq3zpW57cYXFkhuc0TnXw2CcOPftnX
	rofzNfR89j5FaTq2jdXo9mZMwqGHPSeSTIR2aWSjj02FZT3enN1kZB2G/K6DG64ey/TttJJBUZ1
	u+Ny5OQ==
X-Google-Smtp-Source: AGHT+IH/iDYI0ZFxW7bOMeRG6GdAwG2ODJmpwlTQQJHzKXv2R5Zzqq7mMC8REeIi/T2Xh4sNj45k38s137M=
X-Received: from plev4.prod.google.com ([2002:a17:903:31c4:b0:269:770b:9520])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f551:b0:277:9193:f2ca
 with SMTP id d9443c01a7336-294dedd0cbbmr42602845ad.9.1761759243760; Wed, 29
 Oct 2025 10:34:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:33:03 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/13] mpls: Convert RTM_GETNETCONF to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_netconf_get_devconf() calls __dev_get_by_index(),
and this only depends on RTNL.

Let's convert mpls_netconf_get_devconf() to RCU and use
dev_get_by_index_rcu().

Note that nlmsg_new() is moved ahead to use GFP_KERNEL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index f00f75c137dc..49fd15232dbe 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1282,23 +1282,32 @@ static int mpls_netconf_get_devconf(struct sk_buff *in_skb,
 	if (err < 0)
 		goto errout;
 
-	err = -EINVAL;
-	if (!tb[NETCONFA_IFINDEX])
+	if (!tb[NETCONFA_IFINDEX]) {
+		err = -EINVAL;
 		goto errout;
+	}
 
 	ifindex = nla_get_s32(tb[NETCONFA_IFINDEX]);
-	dev = __dev_get_by_index(net, ifindex);
-	if (!dev)
-		goto errout;
-
-	mdev = mpls_dev_get(net, dev);
-	if (!mdev)
-		goto errout;
 
-	err = -ENOBUFS;
 	skb = nlmsg_new(mpls_netconf_msgsize_devconf(NETCONFA_ALL), GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		err = -ENOBUFS;
 		goto errout;
+	}
+
+	rcu_read_lock();
+
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev) {
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	mdev = mpls_dev_rcu(dev);
+	if (!mdev) {
+		err = -EINVAL;
+		goto errout_unlock;
+	}
 
 	err = mpls_netconf_fill_devconf(skb, mdev,
 					NETLINK_CB(in_skb).portid,
@@ -1307,12 +1316,19 @@ static int mpls_netconf_get_devconf(struct sk_buff *in_skb,
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in mpls_netconf_msgsize_devconf() */
 		WARN_ON(err == -EMSGSIZE);
-		kfree_skb(skb);
-		goto errout;
+		goto errout_unlock;
 	}
+
 	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+
+	rcu_read_unlock();
 errout:
 	return err;
+
+errout_unlock:
+	rcu_read_unlock();
+	kfree_skb(skb);
+	goto errout;
 }
 
 static int mpls_netconf_dump_devconf(struct sk_buff *skb,
@@ -2776,7 +2792,7 @@ static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_modu
 	 RTNL_FLAG_DUMP_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
-	 RTNL_FLAG_DUMP_UNLOCKED},
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 static int __init mpls_init(void)
-- 
2.51.1.851.g4ebd6896fd-goog


