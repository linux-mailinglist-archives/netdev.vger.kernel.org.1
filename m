Return-Path: <netdev+bounces-72129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8571856AD4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B13286E67
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A61369A4;
	Thu, 15 Feb 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8RWlQI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FC136659
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017677; cv=none; b=U1gh3niOzn1xyzA3TAuOE12AJ1IxWhfKB5sPE8veicjHYkmRupHZeut0OcadpPga8IA9fzCQMuEcSjdT+zi3FP/OcC+V4ulaAgPc/ZMBCQPVGG5WpgDOlpDm0nJZQCmGgMu67EcYEdt+wFyM5Qa4ZYXy4og6/tjq0iiu7wdXomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017677; c=relaxed/simple;
	bh=MEbzybGk8GQz/rTBUxsacdqXrvIWEyqeuBERO6EXLGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyNyHsl+ALltal6SwKy2FeZcP5rr46vRifmWgIM7k0hOgTBzpk2YdgycaW2815Tux3XQKJjsoMjjKj8Bd3OK8PZprjQlkuDTv5Awu3l3A+j/SwaW11/kSE1oC+QdwZcUE0Agk9OjlMIo3BvvFglqSBt0Z/yzfJmuT+AnfNN/X4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8RWlQI7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1356122276.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708017675; x=1708622475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=48FiiKm6VucZAgFy8UnlGyFOf8qVvdTh3r3BSPh1ZOo=;
        b=x8RWlQI7HDLt4oHtWvHRbRpYfiKhvJyh9I6y4lVv/9+kREAA5r/YdlJhrl1kqnKjVg
         vnrkHkSWn6SkjZ+QE5IDwwI+qaJW1vdIpVFu0vta6hoHsg/336Sr+uQa/UkEPfLpJ8bI
         oN0gKkUdZaD/OvMFSGjGSqINfTxs/OMOUC/z7WtxA7MSBUlCrfjtVFSsRezPjjdxOYO3
         UvZJNghZSXg93rcMrz2srDl61f31EI+9bTvYDYruQrE98u2taSkqurPudGH+bIi3ZD+A
         M1r732hwWEDMYIFPr0op2pfOGg6etIAaufDwJReZEZL8xhN26+O3oH7QjiFDHADfZvY8
         bRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017675; x=1708622475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48FiiKm6VucZAgFy8UnlGyFOf8qVvdTh3r3BSPh1ZOo=;
        b=gokX2Gd3QKhhF+pNMxZD0Y9oTKsEtfaCsajh5JqoZRaA0cBGvTD4e63Iapu+kxKjLS
         uVMHufVtsvRksbli+unUBCDcwdnfTteuV72FkWHg1vMtAlLRZdiDxKInBpoJdLqZA7aA
         xBqys5eJxid8VLXsf4TPVf0T3SOt0oZpcGlqJ2x46vk7/kcL4C8pn/uB+58yvRR6ChB+
         Y/Xhd4Ta4pVRC5QZcO9uguTJqnTu/Q+LuZN4uzZ3VYsquwJ2oZcXvN0XSc+CbYSinxo+
         lhezAtCexbxISjlBIlwPBYXwuTXHWkbH5UZuFtcrR5ZohSDAa8YQuUadMQnw21sr70Jq
         U6HA==
X-Forwarded-Encrypted: i=1; AJvYcCXDWcCGUhf5YMU1CvlalOwyq8RGPZE+Ydf9HUEvJ12MGwhnCbuFr6/W/4ru3gPYjRtl493fUdkdzwIRl8/jPG5Kl5DqMjW7
X-Gm-Message-State: AOJu0YxT/aTXiMy9HZyYIzp3On6vwccQ0aEa+sBSk5OFQhlf05k7Ljeh
	rfkizwkRO4rczhCQ9sj8i3+ChApbWzYF2iVN3T5uREMFHYBgtoAYQuUwwwEo/D+KerCtVcrXvmN
	x6ubvrYUoRQ==
X-Google-Smtp-Source: AGHT+IFsQow5Px868NQP7uPqejMi7hnys7ozM7i3Z3WPRG+x+UAe2FOoz2ktaChNiGvwKE0fqGhbBCbYac58tA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:4ce:b0:dc7:865b:22c6 with SMTP
 id v14-20020a05690204ce00b00dc7865b22c6mr73903ybs.8.1708017675115; Thu, 15
 Feb 2024 09:21:15 -0800 (PST)
Date: Thu, 15 Feb 2024 17:21:07 +0000
In-Reply-To: <20240215172107.3461054-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215172107.3461054-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215172107.3461054-3-edumazet@google.com>
Subject: [PATCH net 2/2] ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

net->dev_base_seq and ipv6.dev_addr_genid are monotonically increasing.

If we XOR their values, we could miss to detect if both values
were changed with the same amount.

Fixes: 63998ac24f83 ("ipv6: provide addr and netconf dump consistency info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 733ace18806c61f487d83081dc6d39d079959f77..5a839c5fb1a5aa55e5c7f2ad8081e401a76d5a93 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -708,6 +708,22 @@ static int inet6_netconf_get_devconf(struct sk_buff *in_skb,
 	return err;
 }
 
+/* Combine dev_addr_genid and dev_base_seq to detect changes.
+ */
+static u32 inet6_base_seq(const struct net *net)
+{
+	u32 res = atomic_read(&net->ipv6.dev_addr_genid) +
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
+
 static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 				      struct netlink_callback *cb)
 {
@@ -741,8 +757,7 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 		idx = 0;
 		head = &net->dev_index_head[h];
 		rcu_read_lock();
-		cb->seq = atomic_read(&net->ipv6.dev_addr_genid) ^
-			  net->dev_base_seq;
+		cb->seq = inet6_base_seq(net);
 		hlist_for_each_entry_rcu(dev, head, index_hlist) {
 			if (idx < s_idx)
 				goto cont;
@@ -5362,7 +5377,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	}
 
 	rcu_read_lock();
-	cb->seq = atomic_read(&tgt_net->ipv6.dev_addr_genid) ^ tgt_net->dev_base_seq;
+	cb->seq = inet6_base_seq(tgt_net);
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
 		head = &tgt_net->dev_index_head[h];
-- 
2.43.0.687.g38aa6559b0-goog


