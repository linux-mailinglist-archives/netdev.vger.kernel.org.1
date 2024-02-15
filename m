Return-Path: <netdev+bounces-72128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58F856AD3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D095287559
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C7136994;
	Thu, 15 Feb 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4Ho51X7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD14136676
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017676; cv=none; b=USu5z0wIBnJO7dc/+HjbARlyDkS4EbjE5YcCTS52W5OWGSyfoa5lzuoDyvwty//UTvYuBrpj8WZuawKs6pOkF//byc7GVjhMw3NDJ7/Wg/w63/FcEICAr2mks68KTOzuwvpy0e6CtzVXRwd5DyaoYLDeFmGwg/O19k51pXwQtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017676; c=relaxed/simple;
	bh=CbevG90bbnOSKG6DPmV1iltdwtglxLk0WWvoDT33V4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8ceHbITFOeY14lzDZXs94CbEP1ERSKFGM65Bz6OR69uQlgZq5/DXmyXf0EfXr4QgRuhRUAu6wlqB4r0bexxPoPCK4sNmVT7npAGDthPwp9RQXL0fj4HNdVnrHasRM773E/h+oBFpr1ZVKfHWd8usY7Ixn0vXpSMnb1p0psGE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4Ho51X7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so1430642276.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708017673; x=1708622473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WzbCWjVHle0H47ezVDdvpxg4xn65bu2CJPqWIjpIoDo=;
        b=p4Ho51X7vaaVN1UIVwvcwDlhmNoLb0qaReDoLqYlxX4UkOF9LlSgylmY/VUP60PuVv
         YlKsWtQXYVDA8zGwe5+pzDBSsATRaToz6aKlIdRXZRQ8i5laLdKzg2BxME2ETywApGAk
         w+P4U87bPRzgJQzEZGwOlP+a8mtyx4zATJOxQxST7Ovi987yrmPY7DKs0m0iP9KKq7pa
         8mvACjm6Kjpu45YwV6iEMb0FsPXNu0Hx5OG8ljDO9Fp3EMHGiaHJeQ1s/hmfULMjF4Kf
         mQHmAsCqezDu/3n1T6n2dOxXDA5GKgt+tSn2BCHUvy5QhMzsoESyRqqojR/hozuZEv3X
         ZHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017673; x=1708622473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzbCWjVHle0H47ezVDdvpxg4xn65bu2CJPqWIjpIoDo=;
        b=OX/L2bJAs9P2U5WJ2/HkFInJJY6+zRYuZ5g0QVf3xf0d6hRhYPoQGbya6SrHgVDCuE
         BKoBnLnvi1TuFaWkeaIazq7JdGP/ZFtMGGl/NQIMR50y8WYZ3dFKRqzaAOT+xplYGqZ5
         1juNjnw3QJWAj34n0/QBmGV1f1mMO1/6P8Lv6ssN61rwEzaIvf5bVMHyjFWdyUwFWRWA
         iHqBbIvyALdykOF0UNjk4t4jPOSeqQDkKiuINdwokQAdJ3kmp2lpXXFTlaFCIRxI2Kfh
         YG/sC+M2lverHSWPg27kYiA6T4dqtkHJPWEQZ183hchxW9tOAuHNwPEC0J9B3lTqcOjG
         2LjA==
X-Forwarded-Encrypted: i=1; AJvYcCULtUNBCzf4MJQj/lBAkyX3vG0sMUwN0edqk4/v2qVVuIdUr+sN8rLGUoYP2Yrq8CnW6goMdd03HSVXvrVJd7HJjaYlKpaY
X-Gm-Message-State: AOJu0YzwK66nCh9JQhx94rsk9kt+QCZ/Jpw/23yVzGxAq1kmCF8rFchP
	425kegZrub9MlrN3CZ3Xx7Pa36/QAWeG3v524o5IbEsZGBgrFz22QhDb0XALAp+reONLyeZuqEQ
	bj8zdGP17uQ==
X-Google-Smtp-Source: AGHT+IGywmTsSTbPARhOVTK2nkus7RYoeEbfnnhJGKFxjETyd/Cc4f3ZZaDvFhM4lUF+T+b/ueM6Ev/Opnq+Qg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP
 id w1-20020a056902100100b00dcc79abe522mr87049ybt.11.1708017673464; Thu, 15
 Feb 2024 09:21:13 -0800 (PST)
Date: Thu, 15 Feb 2024 17:21:06 +0000
In-Reply-To: <20240215172107.3461054-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215172107.3461054-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215172107.3461054-2-edumazet@google.com>
Subject: [PATCH net 1/2] ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

net->dev_base_seq and ipv4.dev_addr_genid are monotonically increasing.

If we XOR their values, we could miss to detect if both values
were changed with the same amount.

Fixes: 0465277f6b3f ("ipv4: provide addr and netconf dump consistency info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv4/devinet.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ca0ff15dc8fa358b81a804eda7398ecd10f00743..bc74f131fe4dfad327e71c1a8f0a4b66cdc526e5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1825,6 +1825,21 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
 	return err;
 }
 
+/* Combine dev_addr_genid and dev_base_seq to detect changes.
+ */
+static u32 inet_base_seq(const struct net *net)
+{
+	u32 res = atomic_read(&net->ipv4.dev_addr_genid) +
+		  net->dev_base_seq;
+
+	/* Must not return 0 (see nl_dump_check_consistent()).
+	 * Chose a value far away from 0.
+	 */
+	if (!res)
+		res = 0x80000000;
+	return res;
+}
+
 static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
@@ -1876,8 +1891,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&tgt_net->ipv4.dev_addr_genid) ^
-			  tgt_net->dev_base_seq;
+		cb->seq = inet_base_seq(tgt_net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -2278,8 +2292,7 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv4.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
-- 
2.43.0.687.g38aa6559b0-goog


