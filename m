Return-Path: <netdev+bounces-295704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+Z/FKF8ImqKYQEAu9opvQ
	(envelope-from <netdev+bounces-295704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:37:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDABE6460F3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:37:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GM8WqJuq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295704-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295704-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1311A305A863
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EA4779BF;
	Fri,  5 Jun 2026 07:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA2346AC0
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:34:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644870; cv=none; b=R171/BzNMBKHwXShDBmf0alAjd/SmRKGCwYCH+0CQFOCfFEayssG4v9FBMhP2yHiTui5iZljQ6F0HyY5dUyNIWGc4uE+ypSjXa47696S6Qbl60TGNGsAG8sGaFx3e8D7Q/Yg3KLv3TG7HcJuol/GefBy306zObpovUYqFTQPBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644870; c=relaxed/simple;
	bh=hUFA2554Id2srJynw2lq2auV/Inev945TA3xcDeUFos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RbPcjxO3gbsMYxba4qGe+Pm3D9K67eFBUl8KhVI46m8m/P+Uaov4bsNdn0zEBUsfj/Odtd7fo3N9IrKLY5wBH4ECHIjupsjlGv0/OUvKAxhckwQ7b52kz5WWKQnQQEFcGGo3GYTu6Re051LHHKCpSL8aWaWLUeOfVzsiqEJFGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GM8WqJuq; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-914b4036b15so135249685a.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780644868; x=1781249668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylxJFlBOStUGovpdK+PVQYtv+sP4H0EAdd3JuohPqu8=;
        b=GM8WqJuqK5ICCXc5MfD9yAgMyheBuz9H4WDbKS/iqLNRIAKpcO3V99Quhh+zyF8f8I
         KVvbUPALcyG/s+WYJ9DY+A+J/o+AeDuy7ZzHyeM91CqwlDTPp9fxP0/jdOgSehBPJ7Gd
         lL4MnzdG70hXH6eUvI8NHekMV/blOds/kDdX7VWr9hRrFK6hdrAT9Xa62YHhxsScjTZt
         Tr4B5hkbsNAugJ+QbsFd9r7ks63oXgKO1fiaeZmWPZqULJLROomHalQqi4nkyMYtqRpY
         55MNqV5A/oHLA5+Su5yE151YpRwZ/xUXYCFWpTCIAcid6EFeG/5mxNZKabJ/tpZMSrfS
         345Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780644868; x=1781249668;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylxJFlBOStUGovpdK+PVQYtv+sP4H0EAdd3JuohPqu8=;
        b=NKUDDAps1plt/cFfp6yVWkxbgb9cwKeh4yHLBvySpdrApMFnFE0fu6k/NJ9WJiKP+e
         dqusOj8UzpfTrCMqUIycTeERs+rjjzQi+w/4V687clxncmGp+CLbH4mX0W0OLgQUUjdr
         bc7z7Y1eL/UDsSimi6Pecq5P6/5yBWj+xcSHpkU0vFuFPhZbfAVrAie0NeQBcZOO9pNV
         3aTRFiSs94jUv9RBnTddPvly1XvNKP2iKlCwTiuAot8mhxtWwKFubRXcj6qa8OanXTh5
         Ma+e07BHyMxQwcIafGvlTj+1xSFEUZU5eKo8kYYK9gKIv0mv7xp8zBlJ407n0VkXQlKn
         JWRQ==
X-Forwarded-Encrypted: i=1; AFNElJ89bCPzrFbHMkhG5Y4H9vZNz6sHpmvjFDJM4EXK806G+cYXZAij8SgS1sfcmMiMGtDdZpD/e5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSOlPEZJqZUHuJeSSLYYK58EBfi2f6bCbvQXV8DSoCczpqKhC
	s+fgnH2riAJD9CQeLNlbJz75GIhQ7f++c5Tq2iR+Lzz0Iua9FJa2fx9PVuZd3EOVH5LUdWh9rXY
	MPt5CQUfc/oxjcg==
X-Received: from qkhm17.prod.google.com ([2002:a05:620a:2211:b0:915:82ea:9d7a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:258d:b0:915:94f7:55d0 with SMTP id af79cd13be357-915a9c75837mr463637585a.25.1780644867673;
 Fri, 05 Jun 2026 00:34:27 -0700 (PDT)
Date: Fri,  5 Jun 2026 07:34:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605073426.2922242-1-edumazet@google.com>
Subject: [PATCH net-next] neighbour: remove obsolete EXPORT_SYMBOL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-295704-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDABE6460F3

IPv6 can't be a module anymore, we no longer need to export:

- neigh_changeaddr
- neigh_carrier_down
- neigh_ifdown
- neigh_connected_output
- neigh_direct_output
- neigh_table_init
- neigh_table_clear

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5d92160165071f73e486d5193220188038cb1923..1349c0eedb642539b28391390fd82f543e004353 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -457,7 +457,6 @@ void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev)
 	neigh_flush_dev(tbl, dev, false);
 	spin_unlock_bh(&tbl->lock);
 }
-EXPORT_SYMBOL(neigh_changeaddr);
 
 static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm)
@@ -484,14 +483,12 @@ int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev)
 	__neigh_ifdown(tbl, dev, true);
 	return 0;
 }
-EXPORT_SYMBOL(neigh_carrier_down);
 
 int neigh_ifdown(struct neigh_table *tbl, struct net_device *dev)
 {
 	__neigh_ifdown(tbl, dev, false);
 	return 0;
 }
-EXPORT_SYMBOL(neigh_ifdown);
 
 static struct neighbour *neigh_alloc(struct neigh_table *tbl,
 				     struct net_device *dev,
@@ -1652,13 +1649,11 @@ int neigh_connected_output(struct neighbour *neigh, struct sk_buff *skb)
 	}
 	return err;
 }
-EXPORT_SYMBOL(neigh_connected_output);
 
 int neigh_direct_output(struct neighbour *neigh, struct sk_buff *skb)
 {
 	return dev_queue_xmit(skb);
 }
-EXPORT_SYMBOL(neigh_direct_output);
 
 static void neigh_managed_work(struct work_struct *work)
 {
@@ -1880,7 +1875,6 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 
 	rcu_assign_pointer(neigh_tables[index], tbl);
 }
-EXPORT_SYMBOL(neigh_table_init);
 
 /*
  * Only called from ndisc_cleanup(), which means this is dead code
@@ -1914,7 +1908,6 @@ int neigh_table_clear(int index, struct neigh_table *tbl)
 
 	return 0;
 }
-EXPORT_SYMBOL(neigh_table_clear);
 
 static struct neigh_table *neigh_find_table(int family)
 {
-- 
2.54.0.1032.g2f8565e1d1-goog


