Return-Path: <netdev+bounces-304305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DxyrERr+RmpBgQsAu9opvQ
	(envelope-from <netdev+bounces-304305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8386FD8E5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bdluCieV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304305-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304305-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91AD33048F11
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB74175A87;
	Fri,  3 Jul 2026 00:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5B128816
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037416; cv=none; b=a5xnMCS7wrGlhQpkU37RXUa2CeJ51D+RzOvXWT9EeFQEohsQzsBLNjmyNmJYFnoQN2ad9SImmOSuKcMsYT6NF6k5ARMBBQgEbcjKBY/MS+jpKrcsGNumE5znT4g8SmvwAOv2vQTMRsQGv9ZwPbRdKFAzUAdMGQJ8s4/3RSorLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037416; c=relaxed/simple;
	bh=X7ktUp4xHKu+AYmxibtJRYJGmeDgJ4e44TyO5B/TaUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WieOHlUEOWIZ7ifOvY4VxUqIvy+kfe2H/wrlorW0T7h6WVZ6JWJ+kdSPIh344NSevpY4DXZTN5clAH6lykEVM7Pu7D/55gsKUL5J+gE8gfqdd26br3PEkNsQwhnjwomPW57hz2oM2hz1SzF2O9x2hauw7bvhHlkQbdHgh0m74j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdluCieV; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c860544c077so4651358a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037415; x=1783642215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFVgptdL2qPrx3QMqtbeTtbwPOeCrgHocJ7ApqP2mUE=;
        b=bdluCieVCD0OaItqhSsU04L+rVxxKVNLjmkDRsR82EK7sjz29YCpXufUYZUfHUqObR
         GFJNxCvofIyLH+d4IZA/n9CDFrO9vIoNPkLEPQBmKc5vgbbWulR/r+6x3Fs9V8Q4cUGq
         vf5hnRmBRlMR6SKM0tZrySMwH/MWrbLOoJYf4nhpNtvfhN6qGnzMhBwDoP4OGJ4vW5iw
         Ou9yUbEkWAyhFAIH0iclxqZ6BdeY5LhqLJMaSFejOWueAv7L33fJUhPypujsq98g22W2
         ywL9unxNprYwfpGK/Bgl2rTj6VO5Tsu6Km5W9GZZTR7FfKiicS7905pYdCI10Zz+prYg
         0xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037415; x=1783642215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFVgptdL2qPrx3QMqtbeTtbwPOeCrgHocJ7ApqP2mUE=;
        b=fXz95DvNwJgLg7Y4tCBTfJ8CEVO5uHM79OO8rrHk5PrZ/41yKdGSFtG/be3tQsEfZs
         3U+6D/Sar8BG/TXHglO0Uwx+jAc+M6hiaa6bi9QJq/IEXK8Rh4ZSZIZcY+tjNyC1Yw6J
         AFY/6mnVwOVDn0P0Qun4/bjHjZ4phPxiW2gAx6/ayrrPKb4/MUlAKwbQJpXxOcJTryDY
         a1ExNZ9s+5GrWi71ribcaAOylNBiU8impPuyZdIJ0Vn8AZQ1WfxXryFozLYrYsftK/l/
         OJb9enPKBzs9ck46KxeNlPYEpKSauHbTbejLJTEOIl9RhRDDZQ8tTZ/11eLah5g1pGRI
         1aog==
X-Forwarded-Encrypted: i=1; AHgh+RqGwFA++Ql5TanRlG05H8ecJVnSwu6lTHKUuDHZQrO+kRLdO8rBSCEHiaetXV7bgLrqj76Xdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXGyYoriQSV9XMbTVgT8u/XvQZU4g+Z+3IzOI/6zdWcAiJQea
	oJUTn2pSsJc9yyk6JLTrJAUX8FwfZNUpZMYS9UHtw/wF/ptmi9R9nVbMYuGclJVpsWovJjg2GyR
	rvDNOjA==
X-Received: from plkp8.prod.google.com ([2002:a17:902:6b88:b0:2c7:ebed:f6e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234c:b0:2c0:b6c7:2271
 with SMTP id d9443c01a7336-2ca911121e5mr76433925ad.4.1783037414476; Thu, 02
 Jul 2026 17:10:14 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:15 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/14] net: Wrap default_device_exit_net() with __rtnl_net_lock().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304305-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB8386FD8E5

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


