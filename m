Return-Path: <netdev+bounces-133870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C40997511
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038931C215CB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0191E1302;
	Wed,  9 Oct 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QI+zSaFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF11E103A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499451; cv=none; b=MwcuFc2mwzkBg4v10Mb7qx9KM5RcHdel5je8YwmTDL/8UI74ptLnsIoFPLGm2lCV+L05TvbfE6zlfcszjC6/qEzTtRWUoCqIm6diWti6LUViUpM+M2T0mU1DY3YVjP/DQzuEjLAlb79Q7nRNRqnwvhR8dH6ekeUg5aOupFRvo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499451; c=relaxed/simple;
	bh=gLCEgORTGRUsky+98+gFQ9kchFa7YB8clJ8cqWQAaLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=INnMAgS0muVchIZlTAeXM9wSvQDKVWYUZkWQIjD4GNifsYkJ8ENrMbD2595IBT84XFWIY6OTUFf/y7ez6tJhkkaCOLdAZmO+akS79czxRzhk/1zo1364zC52ICGSEPDbKqpKl9JKJ2wxxQy2dX8zrulorbFzFKmHSyqagAFzF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QI+zSaFN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e260d4dfc8aso121044276.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499448; x=1729104248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/xd83mEqJtYUr4NiiZTuMNfg7s56SH4cRk7v2KOyp0=;
        b=QI+zSaFNsMdXbwXUqog2A2+UVIQvQLVsjCaqhudlnaGeOIquCFOpxsOPk1AsojzvSY
         dPBnYg2KKQmSrD24J9Zv7UBybS7e/JcLHEYwXBgD6jyhPjAV/TelhCJDuMjtssNNAOIA
         YXPxNUPs7j/4HXI7/2ACDSayoFrzVjqcIaKufuZYxzMj2wN5dFPbrixotzBWnozSJx/r
         /2jwl8otfIf1iOHqy9FYkjJma5e94e0ft7sOedfXCEJSzPU2rWwOLWWYV8G5J4GAAN2h
         oXgtJCQCZ8AoZoDTkI9LmBpsEo+Vpqgh6Fae2sxX7pNqqivs+H7MMenu5Dm49THtBuhA
         lz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499448; x=1729104248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/xd83mEqJtYUr4NiiZTuMNfg7s56SH4cRk7v2KOyp0=;
        b=gzECgwTKui5cso/3nWeFWHsUL23Vcy3xZlRzWQjAmR2uTTgV61JGtcTZ1rzuQyJ0yJ
         lDSTrPQInUsuSGyZFtR6YxNAbhDekwl6/mmtTBurNzLRRDLoApM3i0knrpRclCcU6qs0
         YnCNA/d5rF1J9WxMgCoSSkbgTpF3zoNXg33wVtDb/WMLYb5PmI186c5X7liEMGj9vfEm
         zOZTDM4QSVW1HPfYQIgW+20XPRi0ODBR72o+T1IW/nM9h+tRV+lNaSnePoJzPYJrAlly
         udnsHfjaIyfFHdCLFYFgQjuYpBHxuQqCyTuPI5u+udIeBWzH6UdZsFjd3CosL1YIb0Vg
         yBYg==
X-Forwarded-Encrypted: i=1; AJvYcCXq9PjU5JagjwmFih23/UKzrRzlTm4WYR8fsbTZ1jocZlppNkZxVYRTZy0C7mBrQLVkBiuFVKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5aagC0cJSI9ChCiQrAbarm8CHPpJ4BXnhXQpp0x26PkH06am
	XV24euDkDHhZ8LOQbZqKulAKC+8waLrY7Ue4jKAZPzcrM61VIjl+KJxUbP36MYm+Kny+Tsznt4U
	0m2u3VGpStw==
X-Google-Smtp-Source: AGHT+IGQlQPOTblhOWHgi3ytvLZos1m5QQ/cZzCoRRb4TUJRlviXUYATw3kRurG3mrKcepNIFT/zP/C6GLDFTg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:180a:b0:dfb:22ca:1efd with SMTP
 id 3f1490d57ef6-e28fe665ad2mr33761276.9.1728499448618; Wed, 09 Oct 2024
 11:44:08 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:44:01 +0000
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009184405.3752829-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009184405.3752829-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] fib: rules: use READ_ONCE()/WRITE_ONCE() on ops->fib_rules_seq
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using RTNL to protect ops->fib_rules_seq reads seems a big hammer.

Writes are protected by RTNL.
We can use READ_ONCE() on readers.

Constify 'struct net' argument of fib_rules_seq_read()
and lookup_rules_ops().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/fib_rules.h |  2 +-
 net/core/fib_rules.c    | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index d17855c52ef926383f2585a6f31094899f1e7908..04383d90a1e38847d9d10f8fd0c4bf2ef67af713 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -176,7 +176,7 @@ int fib_default_rule_add(struct fib_rules_ops *, u32 pref, u32 table);
 bool fib_rule_matchall(const struct fib_rule *rule);
 int fib_rules_dump(struct net *net, struct notifier_block *nb, int family,
 		   struct netlink_ext_ack *extack);
-unsigned int fib_rules_seq_read(struct net *net, int family);
+unsigned int fib_rules_seq_read(const struct net *net, int family);
 
 int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		   struct netlink_ext_ack *extack);
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 154a2681f55cc6861d418927c396bec5d840578c..82ef090c0037817f15902d8784467f21419b5af7 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -101,7 +101,8 @@ static void notify_rule_change(int event, struct fib_rule *rule,
 			       struct fib_rules_ops *ops, struct nlmsghdr *nlh,
 			       u32 pid);
 
-static struct fib_rules_ops *lookup_rules_ops(struct net *net, int family)
+static struct fib_rules_ops *lookup_rules_ops(const struct net *net,
+					      int family)
 {
 	struct fib_rules_ops *ops;
 
@@ -370,7 +371,9 @@ static int call_fib_rule_notifiers(struct net *net,
 		.rule = rule,
 	};
 
-	ops->fib_rules_seq++;
+	ASSERT_RTNL();
+	/* Paired with READ_ONCE() in fib_rules_seq() */
+	WRITE_ONCE(ops->fib_rules_seq, ops->fib_rules_seq + 1);
 	return call_fib_notifiers(net, event_type, &info.info);
 }
 
@@ -397,17 +400,16 @@ int fib_rules_dump(struct net *net, struct notifier_block *nb, int family,
 }
 EXPORT_SYMBOL_GPL(fib_rules_dump);
 
-unsigned int fib_rules_seq_read(struct net *net, int family)
+unsigned int fib_rules_seq_read(const struct net *net, int family)
 {
 	unsigned int fib_rules_seq;
 	struct fib_rules_ops *ops;
 
-	ASSERT_RTNL();
-
 	ops = lookup_rules_ops(net, family);
 	if (!ops)
 		return 0;
-	fib_rules_seq = ops->fib_rules_seq;
+	/* Paired with WRITE_ONCE() in call_fib_rule_notifiers() */
+	fib_rules_seq = READ_ONCE(ops->fib_rules_seq);
 	rules_ops_put(ops);
 
 	return fib_rules_seq;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


