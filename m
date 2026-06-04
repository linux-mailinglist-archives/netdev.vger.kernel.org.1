Return-Path: <netdev+bounces-295278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YFfkF3eKIWrxIQEAu9opvQ
	(envelope-from <netdev+bounces-295278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:23:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A98640D29
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:23:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tdh1hKGV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295278-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08B2630EA673
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57FA48C413;
	Thu,  4 Jun 2026 14:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53948164A
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:14:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582446; cv=none; b=qYhCV2X7lkeZWKafp83yT9yCMhKxIoVjPfDQzxstGoMnqiV4W7UrbWo2dZTWN+WCCVpbSla6K32dZy8P/LeVkAjo/91g6K4uN+ImH9W3BzL/HCp79pD6eiSPA2reYgSKyvWhFHZGv0Fxm4o/SHCtm+dT4q1wx36u2ftRH9fZnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582446; c=relaxed/simple;
	bh=Q6qv850Xf3O7XgX+15zFqiMvjkkBm+YiU7KwI+E3vXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M1oArHNNWq/URy5wGyoBgpgK2B8Jke6oeQ/VX5LXcCU8sl5r+C+zIwl1vpJk1JE/BFvj+DVymfO/aicT77nVrPNznJEavRxKGYvrjFmiQrtu5T0kJu76m/BCLArBlIXpoTt7VnRYf16A8jB/6i8Qxm+D1L9TI586qbd4BKnOXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdh1hKGV; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6605e943296so3366334d50.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582439; x=1781187239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3SX5SXyebLQwXMSUVNHqZoB27EzuRqsyViqPgWgQKU=;
        b=tdh1hKGVBWssiY3Cg1azFCrASAmSazT91bn3Wp647NFLCwJSJXOqm0cdMaSMge9iry
         v2qqvJLEpEIzNzvcxheqKKF/K32js3pvGUOWRQ0wLisL2hkN01Zqt16hALcUH6qnpp88
         6DO54cr4Swl1p9GKIxc8/Rc5APiGknr4/owD6RD/Jse6TYb+i2xxeToognfXRZ9SoinX
         NIXkPS7UevJIy5YU45hvTintKRm37AEfj6O0EsKV1o5sdD6MSl6Pea0pEg1vLaeJrjYf
         6TQ+lFQumGChGkxpDOUtSPVr9kS0HPGVV6TqVBs9wymEpkbbgUTkEceU9qniANmfRIfz
         vhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582439; x=1781187239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3SX5SXyebLQwXMSUVNHqZoB27EzuRqsyViqPgWgQKU=;
        b=Xj4Q27csJTTYglYgVubvZqLaMi4rPgnAKHyRho0lNGJfwC7/MYtZpOpJILnmXTvmWX
         KSgxfCU87M+iAWONTJ27wW90RNpUVu4BoHfwhZ2HMt4AVtizF45cCOsmehB3mfVda9XM
         t4jpqGUbiFIPty8zIfdii8DfHsJv7HnNDziAcr+kX90ig2DOqicBFgLMMkK1Yg+Tey/a
         P+SLinJiYApRMuyq/X6mtFAs8eGNohmN6YiZhx4PlC+uX+wWZhyYEJr45ILK0O5bwlBk
         ZZs3xEidgXgnGRLmUBTnmpqLKtlixTJpz9EvlLsBi5BfoYdqzbfw0SNjME6uoSzYTrzG
         kngw==
X-Forwarded-Encrypted: i=1; AFNElJ+yr9Bu8acl3Ao+1aWahvX6bLigrGOeWs3gAXeCRHC+rvwrttKOHJ/KrKVUWDQoPriJmuT8kdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPpHFHduyCsGmaFxJ0J3zP41HR/WKq5gogWfZiWZmtsui3NRc
	/L4EU/M+Y1ZRfsJOVlxvnTFijeVGJpS1m65lENY/F4R73cCZvbyracHRvrxMNPhP1pDMIyb5La3
	6kFgg7Dlx2sWagw==
X-Received: from ywii6.prod.google.com ([2002:a05:690c:a046:b0:7dc:1adc:72ed])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e372:b0:79a:b49a:cb4e with SMTP id 00721157ae682-7eb8ae8f419mr30138087b3.6.1780582439020;
 Thu, 04 Jun 2026 07:13:59 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:41 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-10-edumazet@google.com>
Subject: [PATCH v3 net-next 09/11] bridge: provide lockless access to p->port_id
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295278-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00A98640D29

sysfs show_port_id() and BRCTL_GET_PORT_INFO need this.

This will be needed for upcoming RTNL avoidance in "ip link"
dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_ioctl.c    | 2 +-
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp_if.c   | 4 ++--
 net/bridge/br_sysfs_if.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 2be802991f70ab3ce48ade5da6d1488e072dbec6..a017374c6e659498d98c6af3f8d8e46a8b93570e 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -257,7 +257,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		memset(&p, 0, sizeof(struct __port_info));
 		memcpy(&p.designated_root, &pt->designated_root, 8);
 		memcpy(&p.designated_bridge, &pt->designated_bridge, 8);
-		p.port_id = pt->port_id;
+		p.port_id = READ_ONCE(pt->port_id);
 		p.designated_port = READ_ONCE(pt->designated_port);
 		p.path_cost = READ_ONCE(pt->path_cost);
 		p.designated_cost = READ_ONCE(pt->designated_cost);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index fc25c6b6cc9713080873976f443da1fbd764aafe..f8266a7a9e2b910f1b4e08792b2940ae0fd2bba2 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -267,7 +267,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 			READ_ONCE(p->designated_port)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST,
 			READ_ONCE(p->designated_cost)) ||
-	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
+	    nla_put_u16(skb, IFLA_BRPORT_ID, READ_ONCE(p->port_id)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_NO, p->port_no) ||
 	    nla_put_u8(skb, IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
 		       p->topology_change_ack) ||
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 3524bb7e87f0586774a883720be9fa8eb60f0370..8a418f6af423ccba88fae57d2254e35e1ae4a1a0 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -34,7 +34,7 @@ void br_init_port(struct net_bridge_port *p)
 {
 	int err;
 
-	p->port_id = br_make_port_id(p->priority, p->port_no);
+	WRITE_ONCE(p->port_id, br_make_port_id(p->priority, p->port_no));
 	br_become_designated_port(p);
 	br_set_state(p, BR_STATE_BLOCKING);
 	p->topology_change_ack = 0;
@@ -322,7 +322,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 	if (br_is_designated_port(p))
 		WRITE_ONCE(p->designated_port, new_port_id);
 
-	p->port_id = new_port_id;
+	WRITE_ONCE(p->port_id, new_port_id);
 	WRITE_ONCE(p->priority, newprio);
 	if (!memcmp(&p->br->bridge_id, &p->designated_bridge, 8) &&
 	    p->port_id < p->designated_port) {
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 3f666d4fef42324a4751779153ecc48bdb44b85a..1cc474ed0fdc02234a9f9d6b936247c34cbb127d 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -141,7 +141,7 @@ static BRPORT_ATTR(designated_cost, 0444, show_designated_cost, NULL);
 
 static ssize_t show_port_id(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "0x%x\n", p->port_id);
+	return sysfs_emit(buf, "0x%x\n", READ_ONCE(p->port_id));
 }
 static BRPORT_ATTR(port_id, 0444, show_port_id, NULL);
 
-- 
2.54.0.1032.g2f8565e1d1-goog


