Return-Path: <netdev+bounces-302769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xHV2IgC2Qmo0AAoAu9opvQ
	(envelope-from <netdev+bounces-302769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C066DDF29
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="Fl/J091N";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302769-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302769-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90DF73053E8B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4D380FE7;
	Mon, 29 Jun 2026 18:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87123380FDE
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756756; cv=none; b=T47j9t3J86zbmlhXMnwqDTxJ9Sq+2po0zIWG8D/NpbTmZRQap9uMPoSy3FWdXbfsH5PNUic9sOW2r4B71qBpmX7mPan2HfPHhwwb7A4lugX6c+mfAaW09lC2i/xDzPSY3+f0Zy1q05M4A+fE4YgyetXon6ymA3E+/QMOmheYIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756756; c=relaxed/simple;
	bh=dplleEyAyb72UrESvN7FcnpEgD4ge0Y7f9BoSqkRzms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PvezLxZ96XBCz9TtWNJYhF/vR+IZKczH071P8i5kFnIf6fVS6+spsFWJkGyP+eSGyeYIALRNpyn9ymHAIG/3t3hWXtMDvFKjd6nJu/gGpqyAkAS7IemOqNK5VXPk0ABzR0DXKTOuIeRXU0ziNmpUaztWis6lBs+Ujk7MoyXzzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl/J091N; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845e3ede1f9so1463540b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756755; x=1783361555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLT/jvNkfWMKrPf0TbNGZ+38e0hMq+zgh9IO5EiOsaY=;
        b=Fl/J091N75C4o5IFpUaINrNp5lfPR2nWhOnzDOHD4SZYIMDK+LX32KgrYk1oq9KvhK
         VFPGldyJfME5Fw/ThyTP8pZ0YwxKCCzTeuVmtuiyPV5jD6VFkRGC+kyJnZoM8gwh9raN
         0bu7my1c0/hoHOHscn0+VAt5e700tN54DLptfgdRy2ZkzPQUKk+u2JDZErZczlaEcUFO
         lf/MY+leUHSyfxxGjDd/mXWwteCYt8go0pDMXA/jg5RwtyLvX0yG9Jjt1oTwMF3rMfgF
         hTw7oDcqZr+CcAFVaEHAqrGuc2n2ifLGc8zhlXtJ3RKeNIakSNabLQbSG76z9hz1IYFn
         A34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756755; x=1783361555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLT/jvNkfWMKrPf0TbNGZ+38e0hMq+zgh9IO5EiOsaY=;
        b=Yp2huk4/pWTkLePzm3oKvc1dnYMcJVWkackhvfBd6gwtoKv2uCp/pcZjdoM7b/FJq3
         tPDYYGJ9WhQQXTNqBLsUr0RAkm1/BE0kAZIfwPJKUst9hzDGPpYS+edAeJUKNWQzqwQP
         E1JaIZtoy9Yz3EfX3QEX/i2zu3vYlyG1pNcEIhgHW/QjKdO23zIEFClxxR41erJ0wFbX
         Jq1qCFG3ACAfF0KyYRsAMgetc9uTD5DpSidxxqgs7RmiBdMDbfHsL/VmJf5dzN7kqGUJ
         yGez8gv5Jfa+Kz/f7yXmarf4tiwavN0iXy3y3Ks9qklHI7xHeNm7FfxrrZLuoKssEd+k
         +05A==
X-Forwarded-Encrypted: i=1; AHgh+RpQbTHip6Uc+q5vQNGTRIxSYKGGLzCavq1ZzsL/Mrvc9dYeUw55xrRLJhW3XX+qfVP99ENsSkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/VI9VqomjOSZlPnHNElWG+secNAuQnY3dhTay+Szsgf7/giS
	Wch96htfSPu7VSS97Cz+9GTdMxvdoAW7U9fGdmBXTYa1Oa4g7KLKSWwKOksJClPbECz1OqH5GEv
	4Is/xyg==
X-Received: from pfej17.prod.google.com ([2002:aa7:8d11:0:b0:847:7a66:88f3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1302:b0:847:823c:bdf5
 with SMTP id d2e1a72fcca58-8479f1f5750mr444183b3a.37.1782756754424; Mon, 29
 Jun 2026 11:12:34 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:58 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/10] net: fib_rules: Remove unnecessary EXPORT_SYMBOL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302769-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9C066DDF29

All fib_rule users cannot be compiled as module.

  $ grep -E "config (INET|IPV6|IP_MROUTE|IPV6_MROUTE)\b" -A1 \
    net/{Kconfig,{ipv4,ipv6}/Kconfig}
  net/Kconfig:config INET
  net/Kconfig-	bool "TCP/IP networking"
  --
  net/ipv4/Kconfig:config IP_MROUTE
  net/ipv4/Kconfig-	bool "IP: multicast routing"
  --
  net/ipv6/Kconfig:menuconfig IPV6
  net/ipv6/Kconfig-	bool "The IPv6 protocol"
  --
  net/ipv6/Kconfig:config IPV6_MROUTE
  net/ipv6/Kconfig-	bool "IPv6: multicast routing"

Let's remove EXPORT_SYMBOL and friends for fib_rule.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/fib_rules.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 8b9dac1bd4a7..25a3fd997782 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -51,7 +51,6 @@ bool fib_rule_matchall(const struct fib_rule *rule)
 		return false;
 	return true;
 }
-EXPORT_SYMBOL_GPL(fib_rule_matchall);
 
 int fib_default_rule_add(struct fib_rules_ops *ops,
 			 u32 pref, u32 table)
@@ -78,7 +77,6 @@ int fib_default_rule_add(struct fib_rules_ops *ops,
 	list_add_tail(&r->list, &ops->rules_list);
 	return 0;
 }
-EXPORT_SYMBOL(fib_default_rule_add);
 
 static u32 fib_default_rule_pref(struct fib_rules_ops *ops)
 {
@@ -183,7 +181,6 @@ fib_rules_register(const struct fib_rules_ops *tmpl, struct net *net)
 
 	return ops;
 }
-EXPORT_SYMBOL_GPL(fib_rules_register);
 
 static void fib_rules_cleanup_ops(struct fib_rules_ops *ops)
 {
@@ -208,7 +205,6 @@ void fib_rules_unregister(struct fib_rules_ops *ops)
 	fib_rules_cleanup_ops(ops);
 	kfree_rcu(ops, rcu);
 }
-EXPORT_SYMBOL_GPL(fib_rules_unregister);
 
 static int uid_range_set(struct fib_kuid_range *range)
 {
@@ -364,7 +360,6 @@ int fib_rules_lookup(struct fib_rules_ops *ops, struct flowi *fl,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(fib_rules_lookup);
 
 static int call_fib_rule_notifier(struct notifier_block *nb,
 				  enum fib_event_type event_type,
@@ -425,7 +420,6 @@ int fib_rules_dump(struct net *net, struct notifier_block *nb, int family,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(fib_rules_dump);
 
 unsigned int fib_rules_seq_read(const struct net *net, int family)
 {
@@ -441,7 +435,6 @@ unsigned int fib_rules_seq_read(const struct net *net, int family)
 
 	return fib_rules_seq;
 }
-EXPORT_SYMBOL_GPL(fib_rules_seq_read);
 
 static struct fib_rule *rule_find(struct fib_rules_ops *ops,
 				  struct fib_rule_hdr *frh,
-- 
2.55.0.rc0.799.gd6f94ed593-goog


