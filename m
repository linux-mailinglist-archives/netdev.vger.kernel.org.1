Return-Path: <netdev+bounces-303845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XyuzJyOKRWrVBgsAu9opvQ
	(envelope-from <netdev+bounces-303845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9876F1EA2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rCDWQOTY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303845-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303845-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 806E53028C92
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE983BB11D;
	Wed,  1 Jul 2026 21:43:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880F3B7763
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942229; cv=none; b=E+omPIU45iu28+O9dKdIsGVRJ0zu7F2LI1NNUR8ErKNQwo1gnHGzDW5sqI+HbJ63y0mlOm1Og47xROgLPw7Acm3x5P8rgM0CJVbrmSlj7Cl+DnptQAaXxypoOy348DH+I9xQyDhV3EFnErynVPAh+uuY12C6n+iZZ8M//7gw7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942229; c=relaxed/simple;
	bh=pnJEz2QMgw9cN6VgdMZfdtWI2Yh+zoyCaCsqtMOzc/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a4anJFANRdUryzvV4jV+NnYZf6YecGwpXvmE38dnVJIgQEEHlJyxT8sCBsLIsl8MdwrqmOHQEZu4RkJMcT2h2decAKaRdvKmaGP9QUuvc1nK8obAcM+f9xDFq5+gtyPVJH2bewutNpFWStuw85MQlOB1Q44e9pzfoG3seAvV2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCDWQOTY; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847ac21582cso1234759b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942227; x=1783547027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFHPOwnfS0RTxLbSafbHe36q2pu48/NBNi/jujPA5Tg=;
        b=rCDWQOTY4mmzywLP6KkFJeWOUSFLeAQJfckiWBB+CwASfx2gZvpyRi1JDWYOyJhysX
         FR3ZSDDEmFoNaHmI3sJKCnR82cG9zZC3+aZDtbEhhvrztiyeEmH5JacsGj3T8ukHYVOZ
         7Na0cP2lV0nGMYjW3KEiwabdHnK3vktj3ieresY1OWIxFEH0IlQTjOnxjf1whykF+wfw
         3zs7u3d72K8fo04X7Ef2X28VM7/GRRnRL3hD9M30X3sRrKQGWodk7Sx6O09xhB+p0OdG
         CyrxT6UCpt3c6Y5FerNyexShuHqi020dU16lorcvPDyAMp1JP1Y9bs8uzsBEtgCAZHV7
         lTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942227; x=1783547027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFHPOwnfS0RTxLbSafbHe36q2pu48/NBNi/jujPA5Tg=;
        b=EG++flOIF6az2CGyAiofKUFLabowp8aZ9ib0oikFQPQAJmZrYati4T0V1z+N+24zZL
         Kdcltc3EqDMxqjFYS8B3Vgkz4DK3cqlHRMLIdImAw03ISX6ZCdf3tiMDXV+SG8zRU0/w
         48cFb3kggbyyPgpizKz+JJp0SrHzpO7uiHzEVLz9ugWuU/7behJNawhwUfBJ/yMd3Za+
         qkUsa8TuCshw7TT0obtkHJDakpPyfQ/uR67H9aWfxKjUHGKki50v1hhRfUtElrpXRM/N
         TuCYrbWjT5YldKYYoOqwIm7RGtqBJZR47wuef7xWUqcj+VMQqLnAMv6EbXmmM/BnuO7t
         TDnA==
X-Forwarded-Encrypted: i=1; AHgh+RoXwXig9l4AUt/wCTFqEBlryjhNhRLA8AQFmnkELNCcIMWLTK3PMLmFhDOvHt76+EOEsuVpivg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvl9kVUUP9PXPfMLiBh8XR6XmEVdRhsPV86CeJOUYCQp9J+ecR
	7THgiMWPL7E8mIVjw8LEDuKk5piuaZmdFcntpgd/a59z6DP4uuUbL190uNJtvCyPnNU9QiNwkBe
	SXF9lmg==
X-Received: from pfgt23.prod.google.com ([2002:a05:6a00:1397:b0:846:96e4:1b7b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d96:b0:842:6a3b:60d1
 with SMTP id d2e1a72fcca58-847c08af3b5mr2911879b3a.31.1782942226984; Wed, 01
 Jul 2026 14:43:46 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:43 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/14] net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303845-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A9876F1EA2

Currently, netdev_run_todo() processes pending devices from multiple
namespaces in a batch.

To expand the per-netns RTNL coverage for NETDEV_UNREGISTER, let's
acquire __rtnl_net_lock() in netdev_wait_allrefs_any().

Note that netdev_run_todo() itself will need to be namespacified
before RTNL is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c477c4f84ed9..48818a194fa5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11608,8 +11608,13 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rtnl_lock();
 
 			/* Rebroadcast unregister notification */
-			list_for_each_entry(dev, list, todo_list)
+			list_for_each_entry(dev, list, todo_list) {
+				struct net *net = dev_net(dev);
+
+				__rtnl_net_lock(net);
 				call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+				__rtnl_net_unlock(net);
+			}
 
 			__rtnl_unlock();
 			rcu_barrier();
-- 
2.55.0.rc0.799.gd6f94ed593-goog


