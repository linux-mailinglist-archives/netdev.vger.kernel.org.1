Return-Path: <netdev+bounces-73957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B832785F6E7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7238D282166
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286A46BA6;
	Thu, 22 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dA6VRlDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DE46546
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601425; cv=none; b=cl4WMYMSu428f+dh0XEDXXxqhVzaLTJHwmP94ctkEqtqNBwvTsoBaflsVvbOBFaTTR1HacztESDzw/3ic4KElkIotpsob6hwbuMUf85DpgmzCcVbvZhkzaHPOGNR3sPCA8w2Qp3YPPgqt+8ne6OOl4Q+hPs45fFG7ORNNGjT77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601425; c=relaxed/simple;
	bh=5L383K71Sykzof3XggUP6MeeOoWIwWQ6SWasb2J3J1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uz6dhpoK2VmZ/mF7WYH1sCOTTvEjV0fPCTdYh6+N90InptXFKCzplES6I5W8giyvHgJe3JPigtqAlSAgdpCEoZsXmuXNA/sCZs8XLoH5arDlIOxQLJ6i+DouGcL/D3xGLsKaOvK/O6sUlZLLyyloHaObgZ/m7LM2iDTNcg5CpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dA6VRlDY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso1074602276.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708601423; x=1709206223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lL5tq1nReVh6oRLdhmYTpJJlu1xVX+Bj353+8k9A24=;
        b=dA6VRlDY50Dsc+ygTpa5eZ4rA00bRlI/Q47yyKX0o3oXMDdA+OAaVSpPeIizEgfz3X
         InliPPStCYMrw2pk2SeVZHP2txKcxn/K6r8dflUrSdn/G2HUjCu7rDtjUc49uOUVznYG
         oc/5XnylKC9nWkMnJDQugJldFBHSL1Q2dQHAJwLAsvtn4aQgwCsYeUpSHzU++xC8e1Kr
         YnFPF62ZGinJAHJshOc6C0n1p68vR/c27qO0xNhpSWPJZfvMz/3+LkYt1QU7iP5OsISc
         uKuOPjL8nbmGKDXTwXQMvuchY8VNoWRrEHp2d9MR/gfbswjaAVXk96VyaHKJ/HtEOvbn
         C/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601423; x=1709206223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lL5tq1nReVh6oRLdhmYTpJJlu1xVX+Bj353+8k9A24=;
        b=pVT+DQD2MJPYQFExXvqd8aD0vE7eaL3ej/XIfeuxtES1TB16AOQCFWQkHv544w1UQz
         NXpLe97K69KzGN9NKX/IEKVPu3lR5Pl9I3Bx6e+A7oqgcEFkKMK/n0Zqzf2SZKTeAwsB
         /DNUK4OOlXSC0rXRp7Z7govpyCg9IXSYU43RXpssMQOQIlzumZwyZ80PV5mQgPBH7C7u
         aHCsI7U5zYoJNA4ziCj6sd2XRBfA0q63VbVxTgXLh027TunYes5wU0QgeC6rjnkYWvYt
         lX0tJ+O3cY61470Ifh9ds5N4kFRyC/2t5YS7beTzgYwnrpMOnhWF3s1bDyrDg71keLlb
         SHGw==
X-Gm-Message-State: AOJu0Yy+RGvhpmoSp+29riLN2xXJ1FMv33N0nPBRhf1SAmXOZGhGeth4
	Sr+FLMh359RxQOmCerBjnLu+e32D6HhbmV5mPxY75/jsjF4OCwELzSwR06aydBgpaIePxWM/l0R
	nUgaGRkaCdw==
X-Google-Smtp-Source: AGHT+IElGV1TUFTzJWvl8+SBjngmvETdhBF8+JDGJrUvUm0aXCCqB+KPpaDWs6LOw031RaoF/OpsgcmslRPj+g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1008:b0:dc6:e884:2342 with SMTP
 id w8-20020a056902100800b00dc6e8842342mr537089ybt.5.1708601422830; Thu, 22
 Feb 2024 03:30:22 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:21 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/14] rtnetlink: provide RCU protection to rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to be able to run rtnl_fill_ifinfo() under RCU protection
instead of RTNL in the future.

dev->name_node items are already rcu protected.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2d83ab76a3c95c3200016a404e740bb058f23ada..39f17d0b6ceaa9fcf29905ab0a97645a4e831990 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1699,7 +1699,7 @@ static int rtnl_fill_alt_ifnames(struct sk_buff *skb,
 	struct netdev_name_node *name_node;
 	int count = 0;
 
-	list_for_each_entry(name_node, &dev->name_node->list, list) {
+	list_for_each_entry_rcu(name_node, &dev->name_node->list, list) {
 		if (nla_put_string(skb, IFLA_ALT_IFNAME, name_node->name))
 			return -EMSGSIZE;
 		count++;
@@ -1707,6 +1707,7 @@ static int rtnl_fill_alt_ifnames(struct sk_buff *skb,
 	return count;
 }
 
+/* RCU protected. */
 static int rtnl_fill_prop_list(struct sk_buff *skb,
 			       const struct net_device *dev)
 {
@@ -1927,11 +1928,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure_rcu;
 	if (rtnl_fill_link_ifmap(skb, dev))
 		goto nla_put_failure_rcu;
-
-	rcu_read_unlock();
-
 	if (rtnl_fill_prop_list(skb, dev))
-		goto nla_put_failure;
+		goto nla_put_failure_rcu;
+	rcu_read_unlock();
 
 	if (dev->dev.parent &&
 	    nla_put_string(skb, IFLA_PARENT_DEV_NAME,
-- 
2.44.0.rc1.240.g4c46232300-goog


