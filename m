Return-Path: <netdev+bounces-295276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f0jkJ3OKIWrtIQEAu9opvQ
	(envelope-from <netdev+bounces-295276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282D640D21
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=S1TWU5HR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7FDC312F8A7
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F3480DD9;
	Thu,  4 Jun 2026 14:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09385480DEE
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582443; cv=none; b=HB6nZhEidIabq+USRmZUOHViXEt/z0BnqpV7+TFtnRyoL82Qx/qgMBrw2H1OkfoYlqR+8wPHCajcKl/nUCqAmVDuhoWaAtfYxZ780rrZINgR5oWbrQaby0+gEC1kci73Rnw5VkRIyEkpZlZePh/16pKY4UTMbEf8UNNOZvpw0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582443; c=relaxed/simple;
	bh=DpkPVJTZBA+soZ3X7TBP0/+44ucHPSO8yoIbrrsUq5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRK+Czip4ambsC0xWHhpObQNG2sYhTtdwD2Fp/BauUTn4NDDf71+0zrzlgkb6yWwPNHHmZ5ly4yEk5MEKUAHKPVO9TBO7Cg4EU8rBCwjf+LGnqQX3av9r2JUH9yTmXzXbBThxizothrV9jv3cBaXrJGORfgpKOkD4p/PeDHKv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1TWU5HR; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccf396f53bso20637476d6.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582436; x=1781187236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HL5O3s+5Savlu/dGCFjJgchYirt3mpzmIhQQ5NINLNo=;
        b=S1TWU5HRGAAUV8Z8dlUA7X7KnKAZQBigrJWDqV3ex7p/mLW+5sM6v8JQNhrm64az+K
         89gWPlsMLbO4unFaHR/lbPFfh7QBW1YCjTpTDQr1YFTlxdr1JsDwJ2XNqcIOGrILI7kJ
         77ptRUKBYjMUDvrtPLmlP3G+I6UQfmt2xL9Bf6rRhied7tEFdKBhAEXMbqMlC1Yl61ZM
         0VJaRoc3QvuuujNKTeoa3M1SczduNWHAsxt2fcO0SwY/mL+NvNQHQNXmGCB4JtJkqX/Z
         7c651YFE4eRfY6DRuf3DaUnAP9Sj3jrH9HhfIDdm3CMmRKsrEuD5kwPe6dPRTrppVhAo
         rngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582436; x=1781187236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HL5O3s+5Savlu/dGCFjJgchYirt3mpzmIhQQ5NINLNo=;
        b=Z6d/fH4EXeBgDGAXQ0pGeNLA2OVqDQ9zaLZgwooCKOQ1uLqs3YhqOzL4Vbec6FLZko
         1ynMnKk8beI8M29Y0+9WBLkFjc+aGQgyGzm3NNk5gqgg6cf65LWkaD3Jm3hqO5A/eBUW
         DTMLh2KJTqqI6ezxVaCzBfKXD8qr9sm9fSepz2u5oTHf/Co9jQY+x8JxgIZEtFzr3tro
         sabJdssuxxl/nL2PCGECA1tKkyb2gduzyRvrms3JKTTh8ymZNsyz9ImBJ25mq1mfEOp9
         dzUDji8fyPgQ9MEh6a/x3i2oxJWrRbgEJ6BaicQ0TVMWNeyQQftgE5BaZV9z9hTOWbSw
         k3aA==
X-Forwarded-Encrypted: i=1; AFNElJ+pPPsv8wUhRZXTmyOKKIZqMXpRtSmWIWqMFvwHa0McnYo5YGlYpXiOXRDmzsr4ZL08libDvU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmuunEgzQvhYYLugfK3ZeBn1A8nJjCTJ2HpV4DxuucWZpGyi6Z
	J8XmN4XOUcwoPeWI8qVQZDbrYqzzFw72f64RfKA17W8oIUD9CkzHNzQGh/9C8A+uFdK/9LFwMDu
	TAaUrGWY5etv0ZQ==
X-Received: from qvwo4.prod.google.com ([2002:a05:6214:1804:b0:8cc:c4e8:bb4c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:514c:0:b0:8cc:e654:3100 with SMTP id 6a1803df08f44-8ced7deeccamr38074706d6.16.1780582435845;
 Thu, 04 Jun 2026 07:13:55 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:39 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/11] bridge: provide lockless access to p->designated_port
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295276-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,blackwall.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1282D640D21

Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_port

This is needed at least for sysfs show_designated_port(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_ioctl.c    | 2 +-
 net/bridge/br_netlink.c  | 3 ++-
 net/bridge/br_stp.c      | 4 ++--
 net/bridge/br_stp_if.c   | 2 +-
 net/bridge/br_sysfs_if.c | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index a507c7b369ac49803019cdca7836c7fb9ef4459e..2be802991f70ab3ce48ade5da6d1488e072dbec6 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -258,7 +258,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		memcpy(&p.designated_root, &pt->designated_root, 8);
 		memcpy(&p.designated_bridge, &pt->designated_bridge, 8);
 		p.port_id = pt->port_id;
-		p.designated_port = pt->designated_port;
+		p.designated_port = READ_ONCE(pt->designated_port);
 		p.path_cost = READ_ONCE(pt->path_cost);
 		p.designated_cost = READ_ONCE(pt->designated_cost);
 		p.state = pt->state;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 296f62ebdd4a6f3d404b5902fe661995bd1ca0f5..a722db89aef6bbb6ecc77c7e0f173dc79418797f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -263,7 +263,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 		    &p->designated_root) ||
 	    nla_put(skb, IFLA_BRPORT_BRIDGE_ID, sizeof(struct ifla_bridge_id),
 		    &p->designated_bridge) ||
-	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_PORT, p->designated_port) ||
+	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_PORT,
+			READ_ONCE(p->designated_port)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST,
 			READ_ONCE(p->designated_cost)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index ced8d23f05d1ee262d1760c768e5c88868f13178..cbc48197c3db5e225ead7425b2cee46acc9768f3 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -261,7 +261,7 @@ static void br_record_config_information(struct net_bridge_port *p,
 	p->designated_root = bpdu->root;
 	WRITE_ONCE(p->designated_cost, bpdu->root_path_cost);
 	p->designated_bridge = bpdu->bridge_id;
-	p->designated_port = bpdu->port_id;
+	WRITE_ONCE(p->designated_port, bpdu->port_id);
 	p->designated_age = jiffies - bpdu->message_age;
 
 	mod_timer(&p->message_age_timer, jiffies
@@ -434,7 +434,7 @@ void br_become_designated_port(struct net_bridge_port *p)
 	p->designated_root = br->designated_root;
 	WRITE_ONCE(p->designated_cost, br->root_path_cost);
 	p->designated_bridge = br->bridge_id;
-	p->designated_port = p->port_id;
+	WRITE_ONCE(p->designated_port, p->port_id);
 }
 
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index e5d43492d2dcf0615ee984bc190d7ce2264aaab0..7b0d1a334785047905a00694fd65e3212b160e5d 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -320,7 +320,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 
 	new_port_id = br_make_port_id(newprio, p->port_no);
 	if (br_is_designated_port(p))
-		p->designated_port = new_port_id;
+		WRITE_ONCE(p->designated_port, new_port_id);
 
 	p->port_id = new_port_id;
 	p->priority = newprio;
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 36b832902d33a492e91d53a4248778b3ee2322ca..1023f97b1c9a22a1f79c3c734aef9bd41832ea39 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -129,7 +129,7 @@ static BRPORT_ATTR(designated_bridge, 0444, show_designated_bridge, NULL);
 
 static ssize_t show_designated_port(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->designated_port);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->designated_port));
 }
 static BRPORT_ATTR(designated_port, 0444, show_designated_port, NULL);
 
-- 
2.54.0.1032.g2f8565e1d1-goog


