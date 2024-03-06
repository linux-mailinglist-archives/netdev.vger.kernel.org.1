Return-Path: <netdev+bounces-77865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A100873473
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F07B2FB11
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9245FB83;
	Wed,  6 Mar 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEWiAWNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9C5F84F
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720670; cv=none; b=q3Ot8ybDNjw6ZOqB64O281TJMUPnC7G/41a1zGC43KV5SkGS246aK/DQ1LXc2xyegYkwbyIplNL0Z72G+HDKk9gz8HiLD1/2vMTeKXbMM95jSQb8lC6pHb+EK5HcbOytEULm34KL3C2nOFRIzGb2MEfe30TXAkDRtWDNcJDQWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720670; c=relaxed/simple;
	bh=DfVxMZnEAhwv6BNWSUQ9dby7KQl1kvZXcOByhID2iEk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UtbNwzbRYmCUw3PqO+SCFL11XbDc7XBzGN42a2HvA2czt1oWVBJJsEY4xFwgY88afu/s/7goDaAmIWCkPsFfDDXGBRLpqAMbLkz9mqAZYJuMf2OZLd/FxlAiTbsjmgDQZLxonOeXIk44p+n/9l2n3ElcAwhwnGkk4LvARJiKO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEWiAWNm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609d8275c70so10801457b3.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709720667; x=1710325467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s68qACzZpLn7Rpnl5zAF/8XNR2OXpYldEDqUAGswKVo=;
        b=fEWiAWNm40rT1FB9B/gABCi4G4f5lBBkyIPx6O5GNQ7iMqaMj9kLMm8b3Fo7fzmgMj
         8DyR+7c1nZglziEVu85PUHAdflZX/oFiQuHf2MZOXDnZ08qQiORCFQ4ftDs1MYWZYMsy
         ruxn6EYQyYVYpJG9G1QSzWHgQzK/Bb06snn4+Kc/rVK5XRzwdQWy/6xyyjkzLREs7Gqq
         3OExs8Pl5shDZpUNc/6stb2+mNW1hm9kvK4NDmrzdQT9aSlKt9lyxq1XiwBVqDiXPIHQ
         0z1GFPNlcg7kAMafIANAIul2nv75s2J9bMeUcPnsZ8EfEo1h91SGipwZDzXrwbBvso2k
         52aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720668; x=1710325468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s68qACzZpLn7Rpnl5zAF/8XNR2OXpYldEDqUAGswKVo=;
        b=jnYvGiJlSSWWHLm1fVv+l5Niqag+DE4oOMwDnU30IlpFsIMkeVaHn5DHEW+ndUWgJT
         WFyJvWjE8RPAYqX7AfYkhqHJXV2hKefFzdv+yjCEIy82TtcWdXch5A+C6cB75l8H8BTl
         alvo9XDEEq871ZYDAL1pXLQx6UhwtGboru005+Ef8AkEYq2k19G71FvelvByD3WktZcQ
         3UcvyBN53S897jkTnB/TviCn+sEL8Qg34KeJJZ9v/LKXjb2aA/PC616IHKGdrWx4peRF
         1bqx0/Zk6R09hR+S92JMrFvXNPp0I3Fui7Iyz7LCKEQNSBxcyTwXCWTWcGSuRJx/d4ui
         IdFQ==
X-Gm-Message-State: AOJu0YxFR1hgYI9j/mmJOgPFEwN7r+EGFabe4jK+An6/SD8l2nERi8/6
	AhVLJ9O6XJTecUnKlGVwBInLVGLu68NWu0VppkhWZWW6wo5MYcXVDsXCfwxT3DeCU0r8siHjYVx
	6mJx/ltUQbQ==
X-Google-Smtp-Source: AGHT+IH1pImH86dsd34ZfES+gdQ/N8Dyt5cjJcP+BTy6Bw+qlNpnznA1+1FVp6ssttPl7SjfPlo81VfLxmvW1A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1209:b0:dc6:e20f:80cb with SMTP
 id s9-20020a056902120900b00dc6e20f80cbmr510847ybu.3.1709720667788; Wed, 06
 Mar 2024 02:24:27 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306102426.245689-1-edumazet@google.com>
Subject: [PATCH net-next] netlink: let core handle error cases in dump operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors
in the core"), we can remove some code that was not 100 % correct
anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c    | 5 +----
 net/ipv4/devinet.c      | 4 ----
 net/ipv4/fib_frontend.c | 7 +------
 net/ipv6/addrconf.c     | 7 +------
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 780b330f8ef9fa4881b9d51570d1a65f5171ee5d..7eac6765df098fd685937ace63dfb5add9c77731 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2267,11 +2267,8 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 				       nlh->nlmsg_seq, 0, flags,
 				       ext_filter_mask, 0, NULL, 0,
 				       netnsid, GFP_KERNEL);
-		if (err < 0) {
-			if (likely(skb->len))
-				err = skb->len;
+		if (err < 0)
 			break;
-		}
 	}
 	cb->seq = tgt_net->dev_base_seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 4daa8124f247c256c4f8c1ff29ac621570af0755..7a437f0d41905e6acfdc35743afba3a7abfd0dd5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1900,8 +1900,6 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 			goto done;
 	}
 done:
-	if (err < 0 && likely(skb->len))
-		err = skb->len;
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 	rcu_read_unlock();
@@ -2312,8 +2310,6 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
 		ctx->all_default++;
 	}
 done:
-	if (err < 0 && likely(skb->len))
-		err = skb->len;
 	rcu_read_unlock();
 	return err;
 }
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index bf3a2214fe29b6f9b494581b293259e6c5ce6f8c..48741352a88a72e0232977cc9f2cf172f45df89b 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1026,8 +1026,6 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 			goto unlock;
 		}
 		err = fib_table_dump(tb, skb, cb, &filter);
-		if (err < 0 && skb->len)
-			err = skb->len;
 		goto unlock;
 	}
 
@@ -1045,11 +1043,8 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 				memset(&cb->args[2], 0, sizeof(cb->args) -
 						 2 * sizeof(cb->args[0]));
 			err = fib_table_dump(tb, skb, cb, &filter);
-			if (err < 0) {
-				if (likely(skb->len))
-					err = skb->len;
+			if (err < 0)
 				goto out;
-			}
 			dumped = 1;
 next:
 			e++;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2f84e6ecf19f48602cadb47bc378c9b5a1cdbf65..f786b65d12e43c53ed36535880f6e6d35879a44e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -793,8 +793,6 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 		ctx->all_default++;
 	}
 done:
-	if (err < 0 && likely(skb->len))
-		err = skb->len;
 	rcu_read_unlock();
 	return err;
 }
@@ -6158,11 +6156,8 @@ static int inet6_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 					NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq,
 					RTM_NEWLINK, NLM_F_MULTI);
-		if (err < 0) {
-			if (likely(skb->len))
-				err = skb->len;
+		if (err < 0)
 			break;
-		}
 	}
 	rcu_read_unlock();
 
-- 
2.44.0.278.ge034bb2e1d-goog


