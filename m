Return-Path: <netdev+bounces-284206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE2/LU18+Wl59AIAu9opvQ
	(envelope-from <netdev+bounces-284206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5854C6BC5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD5B301464B
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76363A5455;
	Tue,  5 May 2026 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATGH2O+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835D280035
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957962; cv=none; b=lZxaFuFu1A3lLN7E9rEP8BWuMzkdKAIpjgZc3UOXb59YiU1uvTc07beTfniOWNM5hoxkRPGgM/Jjjta+tXDwSngg8RdigCX0UYiWxVViFAhx2Wsxqd7yvCwMGhjZfTScKoFqdKq16tafSkYvQfK1sMG25G4Q6qi5fJun00fdu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957962; c=relaxed/simple;
	bh=iUgeGSsqv7MOSHVQK8yrYNQjBQhy4lMDkURuG/cYfgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJLBcG7tJHWgqXnHksXmg8JTFG32GIk1PfqLz8tzUbBMLWxG+fHVYl6S0KzQWIi3mwwxVcXFT1FXJsky+4sVUhAgfAFggYBk/Z566X8J5ktbuhiaoyyoYSXmbERNg43+c3dexKMpXGutk1EoHgPLZy1PGQi7HXog8RvNrlhpEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATGH2O+s; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso3292554a91.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957961; x=1778562761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrhTMqHn+rMdQZeR0f4MqPn+xrSow9rW/RMkyGQyv4Q=;
        b=ATGH2O+swMAsO4QhgOqgtXsjMBSGxUHlO6WqLXQvHOu+dMrJB6f5zYw/2oSa1TMQ4k
         Y65WnbOUjJRzFXz7zNn9y6MQ+f3kTUd0zOviw4JeY5aCaF41HSui9ClbWkgfqTnPuhjG
         UGsZfibRcsh/qCoMj2sC7z4dvTRHbV1BbCJ6oXmNivv78JK+nWBD2jxEPa5daL2aROg3
         tkhF0qCSJOwpZmhS/mqHJEo+aFswaKF1D6f5eSfANPgK6iqy4ZDEYh9WUAYd/INwzQds
         5qxLSg+PUYHgzmKbrmU0qGYyqrZFB+/VvyLnbnxhhLEAUkK4XYz0+RTQup+qWhYN2rCU
         z61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957961; x=1778562761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrhTMqHn+rMdQZeR0f4MqPn+xrSow9rW/RMkyGQyv4Q=;
        b=D1Cv+fL53moXmL0GbRA28J/5ShtLwZrm1QOFUMI67I8DNQBnISt80cHcCxhnJb2JRc
         zPjKooZwcdruE/4Yr3oD/sJ2PmhTyEDmS1eqCJHfRKdPkJZy+n0zQSkca14mkR0NK3pe
         Vn1nRhyse1P44Oy9+9Mw7pPLvjbKt+L9DAjvCyxd208nZwCfTfqEg8jvhph2L1wOx5gX
         DXzgx8GT86xLvda2cQZMp3kP8f4O+3TFuAT5mQ3ab5gTlNgHEPTI2Z/Rm+K2DKu3gREB
         xwhZ1stPdVN8fzbJ7u/qRuW8kAgNMOt5x/8fNL+6eK4ucwkeFlv0F6CYWnazFoGo+5sc
         cr5A==
X-Forwarded-Encrypted: i=1; AFNElJ98WWVpG2WdGnWGJDm87KCQHOYTg2Y4rGwyMyKi3b7DjbsvtiChuiFxhAZrGjoKSGu4IHOQvbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOm5xr17tasHDM7EPU28TUwm2z/Kfy1Zb3YNJdT7zMTYdLv9ux
	PoXUKIQ0CIt209hcXxG5VS5SUuW2OLqckyvlHIz/OOBr9M2PU8I7t2Za
X-Gm-Gg: AeBDieuph7MEcbh02ohHwnZR/1Sa+RByotZ9QRism5PXvhUqfxhs1K9FWntr/L0pIxN
	KpfW7CUOY+QTIyHXM7MKuIRtkEr5laXxm0z1DvrUb3t1dv32y7YLS8rM5q27xq3qQEgKLAAidFi
	9FynUqgMNfIougoU/ItPMb4QA3Cc4x+HcYnkyxcJbLdEfIdJbnDAlRa4HH6yQDhVvzYL5yyUwMI
	dCzVsGjoZD5MiqI/2Wlw1xja5822rr0qAldJA6qbXQVwmXPwLZJFKdjBRRpFv88QgbeVF7+3AIB
	m50o3fUtd1ppt/EY6KhRc/L1QhZvtVFCGauvlE/bAp+hndtRqeNz8gDHMAKFcKYKh6H1wW450aC
	Fs77mCr2teNupBoMWN5JK83VebtIcACsBRmh52quqXPgyv57pUN0C2XtNyt/fvFLFuVXCL2DLg/
	3RJR0d8NJCUxQq20rhkTnJmKhjeYbfir/NIZRlLkGBsMGALXSzPdw7rWRo1qp5U/g7RB8Q4STmJ
	aWSD7HqGtJLSZYJiBtsQqIrx3r6/brPdzO27XBnHDg8jsp62zHU8XkI9lrpdjCDffZFEZhCCYM=
X-Received: by 2002:a17:902:f651:b0:2b0:6e12:bb21 with SMTP id d9443c01a7336-2b9f2846196mr116836475ad.41.1777957960980;
        Mon, 04 May 2026 22:12:40 -0700 (PDT)
Received: from alchemy-Precision-3630-Tower.tail7db246.ts.net ([156.146.97.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0e5fasm120896855ad.54.2026.05.04.22.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:12:40 -0700 (PDT)
From: Pratham Gupta <pratham36gupta@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pratham Gupta <pratham36gupta@gmail.com>
Subject: [PATCH net] netfilter: ctnetlink: use nf_ct_exp_net() in expectation dump
Date: Mon,  4 May 2026 22:11:57 -0700
Message-ID: <20260505051157.3895177-1-pratham36gupta@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C5854C6BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratham36gupta@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Commit 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")
introduced exp->net so RCU-only expectation paths no longer need to
dereference exp->master for netns lookups.

Commit 3db5647984de ("netfilter: nf_conntrack_expect: skip expectations in other netns via proc")
updated the proc path accordingly, but ctnetlink_exp_dump_table() still
compares against nf_ct_net(exp->master).

Use nf_ct_exp_net(exp) here as well so the netlink dump path matches
the rest of the March 2026 expectation netns/RCU cleanup.

Fixes: 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratham Gupta <pratham36gupta@gmail.com>
---
Tested expectation create/dump/delete on the host and in fresh Ubuntu 24.04
Docker userspace. Concurrent namespace churn/dump testing did not reproduce
a cross-netns leak.
 net/netfilter/nf_conntrack_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index eda5fe4a75c8..8ae3f6acc2d2 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3158,7 +3158,7 @@ ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 			if (l3proto && exp->tuple.src.l3num != l3proto)
 				continue;
 
-			if (!net_eq(nf_ct_net(exp->master), net))
+			if (!net_eq(nf_ct_exp_net(exp), net))
 				continue;
 
 			if (cb->args[1]) {
-- 
2.43.0


