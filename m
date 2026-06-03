Return-Path: <netdev+bounces-294737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BbUXHroiIGrJwgAAu9opvQ
	(envelope-from <netdev+bounces-294737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9066637AF1
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:48:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=CSoG5TK9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294737-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294737-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8EBD30293DE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDA47D927;
	Wed,  3 Jun 2026 12:35:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC64657F3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 12:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490119; cv=none; b=lJ1Yy8kA5yIg8gIW4oWvqdlWob8FiZUZj4tiZN7CMZ8wlePdabQYD5YckNApkm7WE98W1hTwmWplvEZ4fffcxDnuxDwav0zf0hD5cxPQiOpgwuqAKz5AQienSOba7Ha2TQnNyhOxUdGIR0iLIvoqNMrPEyrAgRc6abYEKqBtq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490119; c=relaxed/simple;
	bh=rRBEsRTDflJ9Q4eLBOOdUfcF0KXsbnFySbjo0K+Zq2o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DC8/Xtkh/1zBLJnlxQ9Slw0E0YYwgU7ZO45ioTF1Ie5aVpGvGm8TsEQal8b6dnpWxWeHlWd2xSK8kQNkwsSzPAyYbqoGyqGK09OqiWdhl+GWf0x6JuFbiZvEtb90g7o1IWDAUV8Phc3LV1eoeqmvoaCLtfG+Be4IjXD4rsPiLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSoG5TK9; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5177f07ea82so13270211cf.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780490116; x=1781094916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zk0Y6gNJyqRTkm6r4Rs4nmREu3OhXqleLfQRft941O4=;
        b=CSoG5TK93EJ8WbtN9tv0w9ZIsnz5vS1N6sB+UtEwtqyCrt+RMJAaOqlSxEPEP/sSm/
         Az/z/941ZXMkve86o12obeVeZ70Uwk/uQ1plyc1Rurec6e/KJRN3rv2mpnKlDCKGVW5i
         l+RygbftLhR+JSxMEsGN9rRiRAjmvvi97I0852WqLCUtIi48lXRoEkImHADuTiUJjdnI
         ISjPYseU0VCORTpECXsD+vWOour8JmCEnChMXlhn1EUoXqVK0wgpwnynvZ9Hg2T/RQdX
         EHx9mV3HHkur0x3IOvJBW0vMrOSv5ZzSJ7hkerxQjhYSp9Uv/G1aqYx08Avn7KaP9hW/
         q1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490116; x=1781094916;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zk0Y6gNJyqRTkm6r4Rs4nmREu3OhXqleLfQRft941O4=;
        b=eXs4mM6nkaMPCQUNb/lqNBQYwHgxj8bAurJejAFZHcnn9+Jdw2Auy3NoagGzjnCnm8
         yaAfTiABqfWDnavEiI6hicHcqiiopV4jWqqp5oE1rWvvb6svyHkHMk+kqksfxuAXdAUb
         OJfqQNjCvf0CydQlETZcJUsB0l5KlPgXJ+3ofOL7W8oUbuGf0S2YORDq9U+Zk+WjqKnU
         sGe/xA4JAbMhqz3OMeTQxmNuVxX4vah83InnYTNzOTGIu77MsPUQY3mRtx48unFvWZnM
         HUbwgZGxNsuNT6GRgKyYg7dBlR76Z3zc7vg9TVRkU2imedsnB+QaKNDiOjJhIB8e416y
         O+ig==
X-Forwarded-Encrypted: i=1; AFNElJ8+VcDIMbx3k9gkyr16joj1Xw/lC5E4tzLpy33taVB38PRj3qwJH0Z2zowfIAp5V1Kda0cbtiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsdFqVjrmVi/u866ngKBHmRjGXnIijuuM+YKpiy1V+In6HgHw
	yMm36G4ZLaLWVj63Z/LSfu4Lwc/90KxORGvoZaNwV7ttRPPFJPL+JzoUUMYqAcY4pKv914GQmQX
	x4g+mmL9/6Zurlw==
X-Received: from qtbke26.prod.google.com ([2002:a05:622a:289a:b0:517:7390:a4d1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:610c:b0:516:f4f7:3315 with SMTP id d75a77b69052e-517787a81c3mr46623441cf.57.1780490115645;
 Wed, 03 Jun 2026 05:35:15 -0700 (PDT)
Date: Wed,  3 Jun 2026 12:35:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603123514.388226-1-edumazet@google.com>
Subject: [PATCH net] bonding: annotate data-races arcound churn variables
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
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
	TAGGED_FROM(0.00)[bounces-294737-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:liuhangbin@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,jvosburgh.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9066637AF1

These fields are updated asynchronously by the bonding state machine
in ad_churn_machine() while holding bond->mode_lock.

bond_info_show_slave() and bond_fill_slave_info() read them without
bond->mode_lock being held, we need to add READ_ONCE() and
WRITE_ONCE() annotations.

Note that AD_CHURN_MONITOR, AD_CHURN, and AD_NO_CHURN are defined
exclusively in (kernel private) include/net/bond_3ad.h header.

They should be moved to include/uapi/linux/if_bonding.h or userspace
tools will have to hardcode their values.

Fixes: 4916f2e2f3fc ("bonding: print churn state via netlink")
Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 43.4.17).")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bonding/bond_3ad.c     | 18 ++++++++++--------
 drivers/net/bonding/bond_netlink.c |  4 ++--
 drivers/net/bonding/bond_procfs.c  |  8 ++++----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index f0aa7d2f21717a7084d78a8016643fa9f7e9e91e..985ef66dc3331e89458c9951a222d140c2275fb9 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1386,8 +1386,8 @@ static void ad_churn_machine(struct port *port)
 {
 	if (port->sm_vars & AD_PORT_CHURNED) {
 		port->sm_vars &= ~AD_PORT_CHURNED;
-		port->sm_churn_actor_state = AD_CHURN_MONITOR;
-		port->sm_churn_partner_state = AD_CHURN_MONITOR;
+		WRITE_ONCE(port->sm_churn_actor_state, AD_CHURN_MONITOR);
+		WRITE_ONCE(port->sm_churn_partner_state, AD_CHURN_MONITOR);
 		port->sm_churn_actor_timer_counter =
 			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
 		port->sm_churn_partner_timer_counter =
@@ -1398,20 +1398,22 @@ static void ad_churn_machine(struct port *port)
 	    !(--port->sm_churn_actor_timer_counter) &&
 	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
 		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_actor_state = AD_NO_CHURN;
+			WRITE_ONCE(port->sm_churn_actor_state, AD_NO_CHURN);
 		} else {
-			port->churn_actor_count++;
-			port->sm_churn_actor_state = AD_CHURN;
+			WRITE_ONCE(port->churn_actor_count,
+				   port->churn_actor_count + 1);
+			WRITE_ONCE(port->sm_churn_actor_state, AD_CHURN);
 		}
 	}
 	if (port->sm_churn_partner_timer_counter &&
 	    !(--port->sm_churn_partner_timer_counter) &&
 	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
 		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
-			port->sm_churn_partner_state = AD_NO_CHURN;
+			WRITE_ONCE(port->sm_churn_partner_state, AD_NO_CHURN);
 		} else {
-			port->churn_partner_count++;
-			port->sm_churn_partner_state = AD_CHURN;
+			WRITE_ONCE(port->churn_partner_count,
+				   port->churn_partner_count + 1);
+			WRITE_ONCE(port->sm_churn_partner_state, AD_CHURN);
 		}
 	}
 }
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index c7d3e0602c831dcac74d2bed16b5026cddda4839..90365d3f7ebff7f762b4cb10303a3dd3fdd49cc6 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -82,10 +82,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 				goto nla_put_failure_rcu;
 
 			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
-				       ad_port->sm_churn_actor_state))
+				       READ_ONCE(ad_port->sm_churn_actor_state)))
 				goto nla_put_failure_rcu;
 			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
-				       ad_port->sm_churn_partner_state))
+				       READ_ONCE(ad_port->sm_churn_partner_state)))
 				goto nla_put_failure_rcu;
 		}
 		rcu_read_unlock();
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 3714aab1a3d9c54cb41de06e074ff483f2ac0b94..3607b62f9b63f65d01bfa4f1e85a34b4f1af803c 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -221,13 +221,13 @@ static void bond_info_show_slave(struct seq_file *seq,
 			seq_printf(seq, "Aggregator ID: %d\n",
 				   agg->aggregator_identifier);
 			seq_printf(seq, "Actor Churn State: %s\n",
-				   bond_3ad_churn_desc(port->sm_churn_actor_state));
+				   bond_3ad_churn_desc(READ_ONCE(port->sm_churn_actor_state)));
 			seq_printf(seq, "Partner Churn State: %s\n",
-				   bond_3ad_churn_desc(port->sm_churn_partner_state));
+				   bond_3ad_churn_desc(READ_ONCE(port->sm_churn_partner_state)));
 			seq_printf(seq, "Actor Churned Count: %d\n",
-				   port->churn_actor_count);
+				   READ_ONCE(port->churn_actor_count));
 			seq_printf(seq, "Partner Churned Count: %d\n",
-				   port->churn_partner_count);
+				   READ_ONCE(port->churn_partner_count));
 
 			if (capable(CAP_NET_ADMIN)) {
 				seq_puts(seq, "details actor lacp pdu:\n");
-- 
2.54.0.1013.g208068f2d8-goog


