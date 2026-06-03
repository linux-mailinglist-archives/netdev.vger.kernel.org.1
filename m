Return-Path: <netdev+bounces-294572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HTBCH2rIH2p9pwAAu9opvQ
	(envelope-from <netdev+bounces-294572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BF26349FA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FE1KJht6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294572-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294572-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34E630C69A6
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC713F8EAF;
	Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD73F9F5D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467655; cv=none; b=LcnVQVRpcnMrBSEqMj++ZU/W5Ehp5y1XBUOo6qKpCOM3uDpokrXNk0zYJl415JMQVpwe9kuxcqCypI0iLXFiSUoK8qPcMh9RiMd/qG5YHt071BjDG6dPJlGm9RPRrUcZmaCQD98XTEfu2SUIIvskLvlg/NxssY19oZ8JiiktsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467655; c=relaxed/simple;
	bh=6p9uB0jT3+oo3IcMLhyKSd78G3PKysoyjWNmwNrtf6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PuSiIq3nJTnw6tV/olNXf618bKDnlXFvGpBvR7tRvugExSHRsGWSjhiXim0dNJqBWHhDwmWoE6FV3gIzW1Q8WgaFvoDkXrQRQSpj3iHOqDGnXnEfH0i37Sxbef4qWyqqXkLaX3YTIJfZRoKsnUGiIpLBhvvundCSaOkga29J7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FE1KJht6; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517480bde1cso77436491cf.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467650; x=1781072450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LwIWOy39nsoBC8GXKhoK+xHs6COGI+YIOQAggUnROY=;
        b=FE1KJht6T0X236z8hPGeZqyvSYkKGzned2xa1gbHIzEU//LizwSVNpsMoWWakx7OK0
         SL0AQwLuVh14I8OW4fHAqA0huUcqP5ufK9Xr9mIdiOFaPGcKFDCpYV73xui3IQReOH58
         4pyXkT/5PelRRWJK4jRvw5a17ih99z9DMKBEp/AojHCqwiw7fXwBnEBN84Y4q9Bq8dQZ
         aJrASi1aXewHEVwKrPcK4eMtdb5cUxG8IHdirUOvf5x6JrTupsfvjs0KouPHDh9iyUlJ
         Kr8e69UduxpJix2xZm+RV1542DM3VVQqWZJWoKM4uNoi9NqPN2GV4Z/nQod1ah0M5Rr2
         hRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467650; x=1781072450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LwIWOy39nsoBC8GXKhoK+xHs6COGI+YIOQAggUnROY=;
        b=fK1YGVR3R2C2FK0rzdyTvAmNIsPpw0UJKDnVcklI2kuRekci6rx7PgE7u8WAt1+HUD
         x84WtaK4QgbTM6YWlPiBiPSavlMMGAsbWOkj3Vl9m9kncwhfKzH3YqsfHN6rd4ODg7Rx
         /X2kQPSGh9F5cN8anQNmvOhbByangRBVSSutGIdf9NbTSbDK+fGXX2yP3VOqFyUKNy/l
         HscK0Gw2irmWBJhM+WOd0aKtgek4lnZOzQGAWv/bXfWuD663SE7xQPIXlK2SO33QyCgo
         Yhd66qkXA4UGYQYbOYNRwXMN8isxlUhfPfTiIsmfDxEYceWjz+OxXBdjGS9PDVG4ohrG
         5vog==
X-Forwarded-Encrypted: i=1; AFNElJ+WIgJQo385ZNDZkdXkAev/APSnv9FpdPuMR4RQywnCjIrGEfe11XhwJ1YHDBoBF8lqOvJZYSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBk9KrTD+yD5FxQ+AFzKdMBtZvfehoXlyiYNi+uXBrfHnt+Ru
	xYfub195ilqIHL6KIebujf8HbeR8pOTgYk9VajJy44lLhuu2V7bPW2xpKqY6CMhEJzynOSiov2l
	U0pEVx1TXoDUW5g==
X-Received: from qtob21.prod.google.com ([2002:ac8:44d5:0:b0:517:5ec0:e4d7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:151:b0:516:ef49:f6f5 with SMTP id d75a77b69052e-5177873f64emr33149371cf.39.1780467649948;
 Tue, 02 Jun 2026 23:20:49 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:35 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/11] bridge: use BR_PROMISC_BIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14BF26349FA

Use BR_PROMISC_BIT and set_bit(), clear_bit() and test_bit() lockless
functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_if.c      | 4 ++--
 net/bridge/br_private.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d39571e13744431f5e4c67f34ee7de34eb8bb6b0..3169fab686a534cf2a6458ff228eee2b6fc7e7e4 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -110,7 +110,7 @@ static void br_port_set_promisc(struct net_bridge_port *p)
 		return;
 
 	br_fdb_unsync_static(p->br, p);
-	p->flags |= BR_PROMISC;
+	set_bit(BR_PROMISC_BIT, &p->flags);
 }
 
 static void br_port_clear_promisc(struct net_bridge_port *p)
@@ -133,7 +133,7 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
 		return;
 
 	dev_set_promiscuity(p->dev, -1);
-	p->flags &= ~BR_PROMISC;
+	clear_bit(BR_PROMISC_BIT, &p->flags);
 }
 
 /* When a port is added or removed or when certain port flags
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 02671e648dac7ab6fd59b80e044f62b00a8e4a8a..d55ea9516e3e369bb9e0045fca5b8d034ef5a45f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -452,7 +452,7 @@ struct net_bridge_port {
 #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
 
 #define br_auto_port(p) ((p)->flags & BR_AUTO_MASK)
-#define br_promisc_port(p) ((p)->flags & BR_PROMISC)
+#define br_promisc_port(p) test_bit(BR_PROMISC_BIT, &(p)->flags)
 
 static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *dev)
 {
-- 
2.54.0.1013.g208068f2d8-goog


