Return-Path: <netdev+bounces-303844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id apl3ERmKRWrQBgsAu9opvQ
	(envelope-from <netdev+bounces-303844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60066F1E91
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:43:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=akAmkebd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303844-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CAA73027A6E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB983B9929;
	Wed,  1 Jul 2026 21:43:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168633A9601
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942229; cv=none; b=Yl/Nq0OUQOjuGsTA3TPyi0gJA2XrxsOd+pl3np5nyoQ1Kp9ncsU9d4GtAUC6u0CB7z8X5+qT4ZUzFKzNvwxfyRpn6oQ7l70lpkfugY6vomONcxmRPbZWiIIVipC9sY1exJSJJJ7l80t4kwgTO9PAhFuoJJQRqAQblIEAOuu3vfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942229; c=relaxed/simple;
	bh=X7ktUp4xHKu+AYmxibtJRYJGmeDgJ4e44TyO5B/TaUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhbZlCKjX02fE9jJTyogjCQ2jjGnAd/5LCwi89ZrzmqLk4IGulGBT04gVUodHLD+A/Ghr+vv2cdoUxwunrd2IMO7j6S8IWgDwDLdR2IHuGsWKhdX0grC01Q70GSSNgfcGIblIA0q9cS4dU6Yzm7BtlPV3w6uwnQ92GyO9iKAtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akAmkebd; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b3141a6so15763275ad.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942226; x=1783547026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFVgptdL2qPrx3QMqtbeTtbwPOeCrgHocJ7ApqP2mUE=;
        b=akAmkebdvty/ljk+NrAaJrwOlu6ZZ3ExL+3GZAoh/TtPjc9aZwxuaEHHoM3rmkucFd
         G6dQo/oq5JsfxBLbOGOrajw2P2scGPOpwaDcdv6NWhLosok46CiCPvYu4uKYq8iBz+Cf
         6Ak90w/Tzk3hGlX5PS+CBdsnrgPtBDA1d++0+Eg/11o/fXI2SqfbwlRrB/BpDV0NB5DE
         KGJejK9ga6Jl/eJEsgyqbdJXyqH8HE2OcInwXMIV2tLdZn5Qj+6SxtQLGLFA6PzpYsKj
         CSqIhVZiIMp68nfTUMxP1p58tGSpJZGLrm+6EessIE+ZyiEaUH2m1yWXP21XHjxSM4ya
         zecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942226; x=1783547026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFVgptdL2qPrx3QMqtbeTtbwPOeCrgHocJ7ApqP2mUE=;
        b=EAzOCsDUMF1XiQh+7IN0l2WTe549y+F8JJ4cStq+jhtle6rQtECw++cAz5zjU0TShY
         Ndoq0dbwAbSjI2ubZck6VaG/OnmXlaZnBOtaXM3mhMqMvwXISJyzD6TMfQTOZMwxI6tn
         ZoYoeGUh6ciuamZEkWjXBqe+2axY1Np4YFnkFS+VjDBiTZ5BzmdYbl5u1r3ELJd1X3W+
         iok8siFfUmaXXAQy8RiFkex7NpGtTfS9O7hE8Nzw771/8LqvL6epPd+A6ej1uWGgfcwF
         iHpxOQgg9eG1UgXVKjVGSd4eloB5E+buhG72BKCXATMKrcjP/t3R5kfcTInPYL/gL3Rd
         Olyg==
X-Forwarded-Encrypted: i=1; AHgh+RqtTeQyQjt9JCaKHONXbvpnrSQM0BXvb5CV0jNkiSO9nCSNS9+TBdHMBAunrYyDxOfplsYxJJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RhsN4z9ToykBMRaOIsHLI0p2LA6Cesc5kyvXl+5CU6N94kQe
	QCLcNCLkey1ukkV42pyALORuXDdKUHQvzyetK0kP9aQV+A/SQryPEXkrgh7D0Ed9AKnkj4u8/Uz
	7rnP/cQ==
X-Received: from plll3.prod.google.com ([2002:a17:902:d043:b0:2c1:9d1:eeb0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da48:b0:2c9:e69f:edce
 with SMTP id d9443c01a7336-2ca7e8b2697mr38964865ad.44.1782942226088; Wed, 01
 Jul 2026 14:43:46 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:42 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/14] net: Wrap default_device_exit_net() with __rtnl_net_lock().
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D60066F1E91

default_device_exit_net() could call dev_change_net_namespace()
to move devices from a dying netns to init_net.

Let's hold the two netns __rtnl_net_lock() around it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..c477c4f84ed9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -13034,7 +13034,7 @@ static void __net_exit default_device_exit_net(struct net *net)
 	 * Push all migratable network devices back to the
 	 * initial network namespace
 	 */
-	ASSERT_RTNL();
+
 	for_each_netdev_safe(net, dev, aux) {
 		int err;
 		char fb_name[IFNAMSIZ];
@@ -13077,11 +13077,19 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	LIST_HEAD(dev_kill_list);
 
 	rtnl_lock();
+
+	__rtnl_net_lock(&init_net);
+
 	list_for_each_entry(net, net_list, exit_list) {
+		__rtnl_net_lock(net);
 		default_device_exit_net(net);
+		__rtnl_net_unlock(net);
+
 		cond_resched();
 	}
 
+	__rtnl_net_unlock(&init_net);
+
 	list_for_each_entry(net, net_list, exit_list) {
 		for_each_netdev_reverse(net, dev) {
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


