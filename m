Return-Path: <netdev+bounces-294580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4geJBhTJH2qfpwAAu9opvQ
	(envelope-from <netdev+bounces-294580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:26:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62E634A3A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=twiJd+ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294580-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87D673118D58
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8401C3FB040;
	Wed,  3 Jun 2026 06:21:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48D3F0ABE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467664; cv=none; b=er2W5zt6A1E1oUh1ucqt+OCtFUFvS1KxIUg607YOBn6t56lu0WYjMbq5I2j+1TDamrZYiL9cK/NffhfGBtNJWS0cToZbgGUgHL7P7DtYYrg58hlxa+LkECxj+PdgpDtjmvgTNnYm1QgxAOFR/+Mfg2i2zRTB6ksniShKL0cd02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467664; c=relaxed/simple;
	bh=wk4I7fBmYb6a2hudJf7sJcdV74xc0+DHdZKMW+Jsg1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AFzgB9P+uyPhS5wfOyEZXqSbWVkwjafhO6EYQ1tzHzh98gT2dg8y8P7jLMpqdmjNQ3VvwP9BLXQK8mpLCQ32xouEdPUVhMBkjlFWJ2lwe7FW8W/0cFv6tmhKAf4JkHVndsMmuezn155m0CVGObFYTXv9helo77TUVqLMIF8Bbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twiJd+ch; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5176d949c58so8092651cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467660; x=1781072460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=08HGE6G9fQk+H+MjW3nrg7lYKnVCDKtIShzL2LuJb8g=;
        b=twiJd+chSLdUuLfH4hM3TmPhhKMV+uB60/5DGTk5+eHLbp7Pa/gsA/vA5IJGLGDzbz
         g9jqnrTPiD+B+O23L61J6NvH231YZkyiTw+k760y1T3pHJ7Q/iNH1I0kxweMBCKj05NT
         0j/4thea5pi9dq+XbrYytOJ2WAeVDFr5aEiCTR+r9vC+MiFUzdyOOBL/1yEciqTtk7yy
         CFb3/LiO7HlCcXcCVL8l8jAve5l3tZZW8klBQ1V2UpNUo1avODIhfFJdVYG4UBhgpCg9
         1GoFAGsDJLSD7veSEtD0ESabKS1PCeKnU18Vbd/fYJ4A8Xa6d2mQ0X7QvteqYoHDFPu8
         RWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467660; x=1781072460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08HGE6G9fQk+H+MjW3nrg7lYKnVCDKtIShzL2LuJb8g=;
        b=gEk7I5cKdMl/I5fkLrqLqPhIPriyTViz3RkrCFsZ8HV4VmeFvadbrzY19AmGYHPoIp
         ipHLyZm1kM+vGOXwcVexNGUGCTfui/mpPnK4ck4N6w+zoFVm/5GBa+eq7gSWdjqHsrVZ
         aY4CQqtbx/u4mdYQshltLvQQb4PnOcIIuRakfTb6/u6QvAlOKpjEZaaTRZubY1PYNJFW
         +yWP+tXuNzT6BCFTZGPZdQru2CLZzl7DTou74cq8d8DpErF2sXubQvz+RuyItzTqYEDK
         yqGFZ6/mDg7Zpm0PtmHvh58X2mx3L/gPt4qrhUTBmDzkYUtPb686iDwcgfHcTlY6nVKA
         u+2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8uM7cRO8w/160UGvhu4FSG5TtUOCSWXJ6+QbJVD+fsQhNh6ZKmb0kddf2R5LTkh5OXZ7KzQ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+O7Tea9fwaF/12VgvbEgIOJfXqLq5QLMX4yBzPYWyXqx9OlL2
	ae989zRKKrl5jJOm0Hr61OUK2NkGOvsbEvM6N334oKikqiPi5k+HrBMsIAEceZEsEcBJ9SBEX13
	6J0DE2E5IozMKOw==
X-Received: from qtpa25.prod.google.com ([2002:ac8:7219:0:b0:516:d746:4e0f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5745:0:b0:50f:817c:5d45 with SMTP id d75a77b69052e-5177979eaaemr29128151cf.23.1780467660032;
 Tue, 02 Jun 2026 23:21:00 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:42 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/11] bridge: provide lockless access to p->config_pending
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294580-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D62E634A3A

Needed for sysfs show_config_pending(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
index f5ea14bb8fb865045d50fb09296d0db466e8fc6e..f84e0389ab9d4c95d0123b926e1a12b0dbc83f93 100644
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
@@ -488,14 +488,14 @@ void br_port_state_selection(struct net_bridge *br)
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
2.54.0.1013.g208068f2d8-goog


