Return-Path: <netdev+bounces-295281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lBmoJfWLIWqdIgEAu9opvQ
	(envelope-from <netdev+bounces-295281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:30:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEA640E51
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:30:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UHS59r9z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295281-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295281-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAB4D315BAF3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F224A33EC;
	Thu,  4 Jun 2026 14:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59576492520
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:14:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582457; cv=none; b=OLmtot7Xw8OPG4WYrcSvruwP5U0aDU5UPXhllAqc9wkUtZLnLRcFoB9DKPBfpc1NyTXGFxEo0DqqkqUcUUQzJ4fXUt4ePCCYO+0+zLlpWAOxWtaTMqU6N8iAp035cfD3ucWZeAAwzO/X0b20LwfhzzVKCveKN6DoNQKGyBzYIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582457; c=relaxed/simple;
	bh=y4sltS63GhJaNHyOGRyxtspb+2eY9RaJjyhZ0fylXOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HsHYsTDlNfoU+zDWAKVfN93kxvoLqr5V/FSm+9RTbqHtpz+HuEUuptrkDBajYjzt24JuKQTk4+iLxdTvtfHVR3FJVh+fTbCrR6+ZA3cDRzWy/zLCvyXFQLkQIuKvoSnHCUeLkYPhaguqEem3k4AKHb9Z0i3rasaaqPeslPQViVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHS59r9z; arc=none smtp.client-ip=74.125.82.73
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137d4309062so2430342c88.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582451; x=1781187251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2y0lHAcKNxFUik/2vQ7hVESy52eHepPHWN7+BQK+qM=;
        b=UHS59r9zvLtcUU4p7xflj08XTyPbGddSR+pzrSedDahEt2stBi2iCZdDL87ZCrVdxl
         vn2RvooAg3szZ8UIW8XsyNI0LVrfIoXTrN6so4yhcL5bwrs+zcJWqAUPiK/5BEnWBoMG
         quc7fdqp8t/Uo86uVgMfkpNBkCUiJqLbmBJ929+4G44ziBQKDYiBH9AnXpecqglqH+4X
         5vy94RkL8d5EJKiP9KASrjvbp0xLhXpTNN08L4ojBIFYofipUwv4R12wZBHohaBP0PC6
         gQJJ6RrtvC8iSFvAz6HHuTK2xBLlguQuuPxEfeacmGoFs+gX5Px+XefTwZ0vMK+cqfZC
         7oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582451; x=1781187251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2y0lHAcKNxFUik/2vQ7hVESy52eHepPHWN7+BQK+qM=;
        b=HQFmJzjQqnYdVIcY3oDOrZCYsediWGnNkY/8OBnxWWTrDhKcCGei9IBZvFVkDBkzR/
         y+l3NUTojVWj9iw2yQ0EkIY/xgpPlT6kyREr7GT1p+JMwLpQksjzkyIW4e+m+sOKpICq
         MEbrfbnxLYTbQeAufy/USj1CVbTVGuQZaSKQixCAgjcNvLCIIXwbmmW5ASh69OhKnW3O
         4pX/F9QUuYOGUkoK8gP9/rw91LVKoROwJWKMEEiHjrQLAfU6FrMavlYKMbUaTCRfB/ra
         46XWB98CKIWP2ufIMtZYtWyBX7k8FWlY3byufvniEu6QUSSsYbgv8D4OW0FyqLaHsHyw
         qXAA==
X-Forwarded-Encrypted: i=1; AFNElJ9HyYXS3RDzReXqHGkgiVY5Zc4wD7z+avYIA9RXHGEMhXEaiUmqAET8hGgt4FExzwYbkneETDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1fyxj/AMs02/88b39wYOHAIYNC2ttKZa3VYG+RI9uZRuZZsx
	EouSp3O4G9zUpRbrq0vV/JWSvX6lo1kpdWmbMBcfuZhGe0ZcBZGk+WaBQpsxrEFj4sC2VyjFHNS
	nL+7wd0ButG0XLQ==
X-Received: from qkpr11.prod.google.com ([2002:a05:620a:298b:b0:915:7fe4:76c9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:280e:b0:914:ca75:e8ba with SMTP id af79cd13be357-9158a828053mr1268683785a.52.1780582440683;
 Thu, 04 Jun 2026 07:14:00 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:42 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/11] bridge: provide lockless access to p->config_pending
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295281-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39FEA640E51

Needed for sysfs show_config_pending(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_ioctl.c    | 2 +-
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp.c      | 8 ++++----
 net/bridge/br_stp_if.c   | 4 ++--
 net/bridge/br_sysfs_if.c | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index a017374c6e659498d98c6af3f8d8e46a8b93570e..39f3ffcfa2d33f15cec6e61490100925eefc7e68 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -263,7 +263,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		p.designated_cost = READ_ONCE(pt->designated_cost);
 		p.state = pt->state;
 		p.top_change_ack = pt->topology_change_ack;
-		p.config_pending = pt->config_pending;
+		p.config_pending = READ_ONCE(pt->config_pending);
 		p.message_age_timer_value = br_timer_value(&pt->message_age_timer);
 		p.forward_delay_timer_value = br_timer_value(&pt->forward_delay_timer);
 		p.hold_timer_value = br_timer_value(&pt->hold_timer);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f8266a7a9e2b910f1b4e08792b2940ae0fd2bba2..ead66dbe1bb7679af18d5f0c2fdea6be2574727d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -271,7 +271,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u16(skb, IFLA_BRPORT_NO, p->port_no) ||
 	    nla_put_u8(skb, IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
 		       p->topology_change_ack) ||
-	    nla_put_u8(skb, IFLA_BRPORT_CONFIG_PENDING, p->config_pending) ||
+	    nla_put_u8(skb, IFLA_BRPORT_CONFIG_PENDING, READ_ONCE(p->config_pending)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_VLAN_TUNNEL, !!(p->flags &
 							BR_VLAN_TUNNEL)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index cbc48197c3db5e225ead7425b2cee46acc9768f3..b33eb085d9b6cb4cd4f3aff2aa4793d027bbc0f8 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -220,7 +220,7 @@ void br_transmit_config(struct net_bridge_port *p)
 	struct net_bridge *br;
 
 	if (timer_pending(&p->hold_timer)) {
-		p->config_pending = 1;
+		WRITE_ONCE(p->config_pending, 1);
 		return;
 	}
 
@@ -247,7 +247,7 @@ void br_transmit_config(struct net_bridge_port *p)
 	if (bpdu.message_age < br->max_age) {
 		br_send_config_bpdu(p, &bpdu);
 		p->topology_change_ack = 0;
-		p->config_pending = 0;
+		WRITE_ONCE(p->config_pending, 0);
 		if (p->br->stp_enabled == BR_KERNEL_STP)
 			mod_timer(&p->hold_timer,
 				  round_jiffies(jiffies + BR_HOLD_TIME));
@@ -490,14 +490,14 @@ void br_port_state_selection(struct net_bridge *br)
 		/* Don't change port states if userspace is handling STP */
 		if (br->stp_enabled != BR_USER_STP) {
 			if (p->port_no == br->root_port) {
-				p->config_pending = 0;
+				WRITE_ONCE(p->config_pending, 0);
 				p->topology_change_ack = 0;
 				br_make_forwarding(p);
 			} else if (br_is_designated_port(p)) {
 				timer_delete(&p->message_age_timer);
 				br_make_forwarding(p);
 			} else {
-				p->config_pending = 0;
+				WRITE_ONCE(p->config_pending, 0);
 				p->topology_change_ack = 0;
 				br_make_blocking(p);
 			}
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 8a418f6af423ccba88fae57d2254e35e1ae4a1a0..a7e5422eb5d140b501a7dcebf0238d5a77c5f4a1 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -38,7 +38,7 @@ void br_init_port(struct net_bridge_port *p)
 	br_become_designated_port(p);
 	br_set_state(p, BR_STATE_BLOCKING);
 	p->topology_change_ack = 0;
-	p->config_pending = 0;
+	WRITE_ONCE(p->config_pending, 0);
 
 	err = __set_ageing_time(p->dev, p->br->ageing_time);
 	if (err)
@@ -105,7 +105,7 @@ void br_stp_disable_port(struct net_bridge_port *p)
 	br_become_designated_port(p);
 	br_set_state(p, BR_STATE_DISABLED);
 	p->topology_change_ack = 0;
-	p->config_pending = 0;
+	WRITE_ONCE(p->config_pending, 0);
 
 	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
 
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1cc474ed0fdc02234a9f9d6b936247c34cbb127d..1923c004f0d2b746902f5b6de1bbb72f7f824125 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -160,7 +160,7 @@ static BRPORT_ATTR(change_ack, 0444, show_change_ack, NULL);
 
 static ssize_t show_config_pending(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->config_pending);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->config_pending));
 }
 static BRPORT_ATTR(config_pending, 0444, show_config_pending, NULL);
 
-- 
2.54.0.1032.g2f8565e1d1-goog


