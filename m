Return-Path: <netdev+bounces-295279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xiCdMcaOIWp3IwEAu9opvQ
	(envelope-from <netdev+bounces-295279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:42:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAAD640FB2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="EgH8vn9/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295279-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295279-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 437763234FA7
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC44A2E22;
	Thu,  4 Jun 2026 14:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C648035D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:14:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582451; cv=none; b=ama0Vrgtf3YTkwC4fGiTEfp4pT6zOUp5b+5w5jXKGuzG+eU+iL6sM0UGgPnbHF975Jfl+68foUxwcfH+qbxEZJT1SsR9W/kDVWVzeP7IGJXsLSNF3DJEP7rzwOF0nPHxCWfA/3O5dFVgRnShMSObC09VH9WzZ+9mhPxs3rYLnjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582451; c=relaxed/simple;
	bh=y4sltS63GhJaNHyOGRyxtspb+2eY9RaJjyhZ0fylXOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZT5RExRVjFqo6KFrFqNpVTvW8OsHt1RgeI6bTAtQfOj2sOXK7PWEaAlx3FL46bPtLUkyZjkPMUgEv2/mJeGxcd9YHlf6KuAU2pqmZno55k0/aRgEjsK6Xm37IkQVS1KY3PhStBiUyQzRgW2ZBJX9O5mhPHKscmH4VEXJjfGaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgH8vn9/; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5176d5d7222so13421161cf.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582441; x=1781187241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2y0lHAcKNxFUik/2vQ7hVESy52eHepPHWN7+BQK+qM=;
        b=EgH8vn9/YeY16a21wIky97uqpkd4AwwgobBPrtHLf7IY0CGKF9HYbLODiQ1TTVmF87
         XtGFGs6T51/wQ3dvjSevZxTHVBEi9HtwIlVwke927QvW5oKou5E8OQ470cLbQ6hE0U4R
         XrMYJtuxejuMq6uxepuJIRruhsTaMVOtCOXFivaVAH3rdOgfpdmviAtMr8AVyBKtvZ9m
         dJDveeINOVg18W99C+YODSIWRVNppIe9c9ork656ZXgrYljEl1RDydA61MAK7l3lSOnq
         CSBZTfdbh15HKRv4dOhZ9KGN0wwPSDpPwmSmKz0cWt1a/G2gvhh3dGaQaWdjJwdezkaF
         OimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582441; x=1781187241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2y0lHAcKNxFUik/2vQ7hVESy52eHepPHWN7+BQK+qM=;
        b=CTL6Gak0m6VtinLlo0hmnlc0KNaADz4ooUWuQqf9UGkfjUHY3MaBYvVLzJXbrdJn9a
         03qeYt7TYj84hokQL8zpki0IzUA+PVh9FaK3RSqewr1UzNOh7umRqFvy1N8O1V30RIYL
         Za6Pvntdj34EyiehioDuxw9ODRG9nqUv4ozs85cGNvHqxBJWc+j+0pRb7gWBvjJzZnOy
         vyMHnr/TiVuS2BdCtmH58t+T9gcjutMcsJ885dXpLCwQfiSxcjZ3sgBuE118YxlzGv7m
         S/nnPxQ4S64BxCdJ5HWGHA1+/lWSR434fzGAIlgJ0fqrUCgHBlOghkaSzfV4gdtSyEeW
         Ej5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Xc8Awbj+4PJLamz+cW18oiUAjISnz7cvPveciMUkAM/EqKZxa80L+XUERy/OiWAJ03V2rF+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/YXwMcu+qslEo/cnw4rUMp/SVFefSUnfn57I77M6bBpill5t
	fbmPqtxh25dd39kjIS1AYQH+i2HaTwhhWKcQd9XmXoPF3Fc6rcKEZWz4yA/GjbU3BJJBwQnaQM6
	XHOtXjKzWU7lcrg==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295279-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BAAD640FB2

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


