Return-Path: <netdev+bounces-73939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90D85F619
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CB3B255C1
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5B4644E;
	Thu, 22 Feb 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzVgM64u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86794405F4
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599038; cv=none; b=eHxpYDW0p230+8Fv1sgmJD58BryjBrUNt/FLbT9qIV/AkdyA5bbTcUvWR4Q1Q87NREu/4clzqqFzCP8e9vDz8JZUzANGIwkF37SwmV6be8iA5LxRUe7xWboa+geONKzKx8coLx89s/fe6UVQQHuxTVD+hIPNocfeIgRDyynNAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599038; c=relaxed/simple;
	bh=x0gaI5HPo/Gni69DlefYrKGd8tFxYcVGKn4g6trRTGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSk/ImtZc/lHzytuMEua1YdTF7qHxl6C50XMGFT8opo13hCdr58VD7DNG6qBAs8joRiF1PTQHtXVF/XmCNqoh/D1lZ1gry7/DYsP+Icb5KrJE25Q14531rRaOn4Rjvf5ld9CvinlFxXjQAmZ7UOhnpZaidgqiqWp9yuM+F4JZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzVgM64u; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so13645934276.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599035; x=1709203835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cto4V58l9fhN9hnc9s3j47PeAImDsjr7u6zwd7GI/kE=;
        b=jzVgM64uKtX0L1R0oTXYF4AGmQi9wPwwdTEhBPrDIiYiulN2xf4pEn2Aq0Apgf5Hu5
         jPgm3vZluL8tKY5LNPb+oCupndMskMmvPMSNXvTABk5KrJxSGhN1lxQXgscy4nJIUg08
         EAKi8Cdyos2lUgN+gs1FrDDUchU1DI8VfC8ztAMqE+HJKQMGBhjOYjV2+mqHugcTqLMo
         tk4jxH5oVNtDkotYO9exwtIlxxX/QqKECQawYEEU92aJc2BluAJ63JPMqGqntHI9Dq5S
         rWoTp4x2n748/+PRU19X/AzXu9oONm/754SoCraGf6EDeeRf66/kpu3PHkygwqKg9/iV
         CYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599035; x=1709203835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cto4V58l9fhN9hnc9s3j47PeAImDsjr7u6zwd7GI/kE=;
        b=RVRbGeDvtPQwbzreJHZ80GHeHLFEk8asNcQfqQ/sOjtSbdomlwFv5HLgrxYGbzK5Wv
         D8Jn2Ky7/I5NeyDC2RzjLmztM0PKoklq7iqvrOlBLmliijvj8dE15rXLrhL9BKRFs+xG
         6R40lH/dAanTejAUfLsioxbUZ2isx38kPUwCGeWHqjpBNOTi7+Oc7GZ2+ZqECxGVPMtU
         J3uNKshZz4oiuadcKdEpDQy26PzwxAjMEdSFd6Bz+Ho6rtcjhcagjO1lvfw9nZlxjoEe
         PN7LuK6I4HZp/kwvo/JBdjpgqqF72NwXBjwGUwWOwaAAHp/0z0n/Ez3guhAXgdfJhCvt
         a5Ig==
X-Gm-Message-State: AOJu0YzQqM2odb2LJAs3/jAg+ifNNlLJYNIkS+K7HE9Amip9cd7m9+25
	jPPPl4hYIIQRCu0K0mLc9CP9C2qE2uA9v10ZxLSok3CsiHV5ihrCqFYOPn48cnNMRIiRviH9KI8
	OBU/wV6V8OA==
X-Google-Smtp-Source: AGHT+IEtexQB52Hplp15ogPVvu+f3XuMC/2tgLhg6clwu34uzVZST+zW/txYAQg42qZotrhTGDJWJ+5icbBP4g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1024:b0:dc7:48ce:d17f with SMTP
 id x4-20020a056902102400b00dc748ced17fmr512886ybt.10.1708599035564; Thu, 22
 Feb 2024 02:50:35 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:15 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/14] rtnetlink: add RTNL_FLAG_DUMP_UNLOCKED flag
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
2.44.0.rc1.240.g4c46232300-goog


