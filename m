Return-Path: <netdev+bounces-73623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B52385D642
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0701C20D14
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8BC3FB17;
	Wed, 21 Feb 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zsop1G/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EA3FB15
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513173; cv=none; b=kd8CaphI7qJ+MjMYUgFn3iFnMrl3mwyoOwRxEZgiUJMbA3rotTjwt8t0S/4xJQ6k2G8aE01nYmiabuFOdpwF4V6F+5zMy0qT/6Ttx/toQdqQ3hZouPZCoo9yeCYGMTY079YaCdUnOKC/XGJs3R3PuRq6/t2ldcxjnq36Quzn20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513173; c=relaxed/simple;
	bh=1JR62QTElunoRnY8TYLpVg69GVC4gfifWwqZyyuusvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S612HCEAq4lOU6DsFhuR8KeDOIxKDAuQygiWnFet0RiaQ6SQ+UDfBXKaCKfwHHqfI7BFzCu4+KSYWKh3f9sYB19CEc/E+jTu+GfTdMZzLgZk/FcMIpGOpG/huFpB5gl3mB7RHsmWscPoG61du9/9j5zDzLpIQIhQ/Sxm+cfFxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zsop1G/Z; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78775d5f0c3so211711085a.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513170; x=1709117970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91c61MZjc9DbUAAS7MkONFkHZgDnNZqaR0l8fEceOy8=;
        b=Zsop1G/Z/C6eEqnTpeajz+xw0nXm3KcMO8XNC04cNldBpivWfk/j58nMpyBVGmHGRo
         sb0u49EGCyWFzJ+LxfpHTjlPTInRVFxmIDyjcQtrsB7o0tRjuysZ9hiZMrx12iuYtdHl
         nhN4rx8Bqg8ABUyZKwkZMc2VCZKesGj/rjB3djDMOMLaMJMITYo0phgi6vs0TrcE3Qwe
         o8Q42BCBLginDapG2TLhgAZNpl5mzULESOBf5OlIRRNM0oNEojaH0ZTdtO/whjMp5m+g
         UrHqWVB+aM1db9GDWecUGgYkfMVbDIMsDdWNWw6FPShR7rleY7GLG/QFMUZSQxoPCDrL
         nIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513170; x=1709117970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91c61MZjc9DbUAAS7MkONFkHZgDnNZqaR0l8fEceOy8=;
        b=G4/JJnYNui/JXTQPot9eqjlGdMl6XJL8qnB8STRgPo0h9WKvjHbVadVBZ/t37X9npd
         UoTqL1xQ1VtH9/0kAruMoNbJGaG801HKcOOJsURBM7iKMGByzKybCeydVsRshc084VoN
         zFo92KuS7WOYFmzNQgjVqb8DzIZjD+oOwhcb/kbxx3qydDnH0TovDhDxqvenAdzLhmQg
         gksZ2Ds4MPWeMNDmi7qfYFBARyL38YZr0Q+3LuJE+qSjiBNHNJ8y7wxfVpjBZ8SLwJf1
         BLjK2wlUk0v5qxEouBviCqXSyCgc+fPKMrmaqTJkuO1AToGSBKV4VglUJN0PWbJSTu6v
         KnFQ==
X-Gm-Message-State: AOJu0Yx5W3VGlYwlSfw72+v7yerkk0qZK3iU7fYwSLPJBRRDzQAwd27H
	dKsjG2id93MHpE0yTSkdhYy+H7dyKPSso8Yb8PUmiGew1697DBBqcuLoVXV5dnyzyPjnWtnhQSh
	1XLrB9nIHPg==
X-Google-Smtp-Source: AGHT+IHgATZ75dcOJbabU2WS0yemPt2coHoqlrtYhNV68HN+8oz9x38+Ytk66uMI8mf4X3HjPtO2ywihiAMCkQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:4724:b0:787:843e:3418 with SMTP
 id bs36-20020a05620a472400b00787843e3418mr19490qkb.9.1708513170614; Wed, 21
 Feb 2024 02:59:30 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:10 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-9-edumazet@google.com>
Subject: [PATCH net-next 08/13] rtnetlink: add RTNL_FLAG_DUMP_UNLOCKED flag
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Similarly to RTNL_FLAG_DOIT_UNLOCKED, this new flag
allows dump operations registered via rtnl_register()
or rtnl_register_module() to opt-out from RTNL protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netlink.h  | 2 ++
 include/net/rtnetlink.h  | 1 +
 net/core/rtnetlink.c     | 2 ++
 net/netlink/af_netlink.c | 3 +++
 4 files changed, 8 insertions(+)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 1a4445bf2ab9acff630b3712453c8a6cdf8fc47c..5df7340d4dabc0c0b1728dafde43b5522dacd024 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -291,6 +291,7 @@ struct netlink_callback {
 	u16			answer_flags;
 	u32			min_dump_alloc;
 	unsigned int		prev_seq, seq;
+	int			flags;
 	bool			strict_check;
 	union {
 		u8		ctx[48];
@@ -323,6 +324,7 @@ struct netlink_dump_control {
 	void *data;
 	struct module *module;
 	u32 min_dump_alloc;
+	int flags;
 };
 
 int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 6506221c5fe31f49ccaca470e0b24dffb703c28e..3bfb80bad1739d244a3906fa7f0e1a606dfaf868 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -12,6 +12,7 @@ typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
 enum rtnl_link_flags {
 	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
 	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
+	RTNL_FLAG_DUMP_UNLOCKED		= BIT(2),
 };
 
 enum rtnl_kinds {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 060543fe7919c13c7a5c6cf22f9e7606d0897345..1b26dfa5668d22fb2e30ceefbf143e98df13ae29 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6532,6 +6532,7 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 		owner = link->owner;
 		dumpit = link->dumpit;
+		flags = link->flags;
 
 		if (type == RTM_GETLINK - RTM_BASE)
 			min_dump_alloc = rtnl_calcit(skb, nlh);
@@ -6549,6 +6550,7 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 				.dump		= dumpit,
 				.min_dump_alloc	= min_dump_alloc,
 				.module		= owner,
+				.flags		= flags,
 			};
 			err = netlink_dump_start(rtnl, skb, nlh, &c);
 			/* netlink_dump_start() will keep a reference on
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 84cad7be6d4335bfb5301ef49f84af8e7b3bc842..be5792b638aa563232cdb96de8c97c4fe45b3718 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2261,6 +2261,8 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 
 		cb->extack = &extack;
 
+		if (cb->flags & RTNL_FLAG_DUMP_UNLOCKED)
+			extra_mutex = NULL;
 		if (extra_mutex)
 			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
@@ -2355,6 +2357,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	cb->data = control->data;
 	cb->module = control->module;
 	cb->min_dump_alloc = control->min_dump_alloc;
+	cb->flags = control->flags;
 	cb->skb = skb;
 
 	cb->strict_check = nlk_test_bit(STRICT_CHK, NETLINK_CB(skb).sk);
-- 
2.44.0.rc0.258.g7320e95886-goog


