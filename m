Return-Path: <netdev+bounces-290441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBFhIwkPD2qSEgYAu9opvQ
	(envelope-from <netdev+bounces-290441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:56:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44C5A680B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C9830B0D71
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5E3E16B5;
	Thu, 21 May 2026 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVuxaD22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE453EDE73
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369578; cv=none; b=B1wX7us/rjy4uGNVr44oCzon14UH57TbfjDTb38a4nb4DePDR728EcyHLJJ5riFKRLlTbTrKdN//o4/N2mtNauqgUV2urWZdWwpBeO58dCWmxrJgiRQdhl5n3rzSGkRUK6Z0t70OhS5djLWE3d8ky7JPqp8TkuECamPwYR5pTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369578; c=relaxed/simple;
	bh=XmhZgtTx1Q8eZTNCfVkLrehap01ysZbfl0OltkBSgAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gOWPzygfHncre2sfQu15MF2tOYHNYiueEha4VQlSzKtvkb+lr9nfkc2QnvwJQ6tWkuS4lrkGzMvzuXFdIitNvKMEHm0QskIsmRyXOtMFzodUyHTiwmZZ7ELzJ1wRTSiKhJnvQuS/Ol5F22kg3tLUe070+mzu2KNvfZaBDPH2ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVuxaD22; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8badccc9194so115123256d6.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369576; x=1779974376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0r6GliuL0vB6Ivb3deSGXxITJ2XKZRygEGacWWIPPGs=;
        b=fVuxaD22YU+5t3wbbf5qTQSF840BOE0KtDItZ72XPtv6GPRKLJPGymyPFPOq2RP6M0
         bDiQ6PruyW0wRZgNc7LSm4yiRkJnycfX/WUIX+BsOgaOZBvUIS4vAyIwtVPDcz3JuKzM
         rmqTL+uW/EMIku2AyrndjTRU983ieUmF4Letvg1z+V4C/bAx9c+jGJ+khKTJ2OixW0Yd
         1IEFgBXhqZ03Lqw79KUS+q5lKyeJF9vbl8INMJdLBL13gAdz/Q6fZ/g7XomWrf7GK9Nu
         xekN1xgYxUcKfXFmJ/RJ0b/IbIpypVLlv/zjPg0Qt1lEoZRqoG7id4z1VD5OypqJEjna
         sQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369576; x=1779974376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0r6GliuL0vB6Ivb3deSGXxITJ2XKZRygEGacWWIPPGs=;
        b=MHRZ7xLwryCeRwfkjZXRVcB6yhgf6xSSh3CXxp0Hkon0cNae8jDYVqsuOTtXunmojB
         g9XlFOCtYFU03QYK2JZP+ATPMR+pAmDMjhrdYVPUfnlU/WKoup0rxynw87GNxet0152Q
         RVPnhFsohs9Wmku0qGwD42H3JiKWI3chKti4Q/TCRjirf9uO5oAO5jMDaADhAxEnX7Ye
         5djG+P38iwahpStK6md1GdogICkkkRs9JPPFshzvkgpnoB74fIB5j8Vnw1maBrNaa4pl
         c7mNJre/Vf4r8QqwOUJhleNbddgRaIlyvkvZEgUcfVkXc8u4vFAW/E3lGnTmber1dHxo
         kS1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+hqwaIOIAIORVhrPXu3jWGr2cibQb78o/RLjv9BFvyCSt+XAKk0nbMq4SJNTzb1QGrdxC+Omo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpDD0iumkIViclmvVJauXBqosz1M+H86knJGdCfD0epBJTxzj
	8VF8CG2SxLmNfL3/9zm6NAVTTP8DZxnyX+gGNaWsr4yjZkvEa7UMT9mlgpQ/sWgr3xiSKiu3aQV
	87xgN3yb7vw5CNQ==
X-Received: from qtkk27.prod.google.com ([2002:a05:622a:a95b:b0:516:cd98:30a1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d88:b0:50f:783f:3196 with SMTP id d75a77b69052e-516c557697emr37996941cf.33.1779369575386;
 Thu, 21 May 2026 06:19:35 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:15 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-11-edumazet@google.com>
Subject: [PATCH net-next 10/11] bridge: provide lockless access to p->config_pending
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F44C5A680B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Needed for sysfs show_config_pending(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index 7b039994d6a2df00a2fc8ca50e45e7db4f392fa7..cc485b929d983ee4faf2541b661cad88896d39ed 100644
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
index 4c364a7f0f53f4f9360887b93bfbc592c738e311..4db0b21b50ccd908b5fe8c70d77daa1afaee550d 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -215,7 +215,7 @@ void br_transmit_config(struct net_bridge_port *p)
 	struct net_bridge *br;
 
 	if (timer_pending(&p->hold_timer)) {
-		p->config_pending = 1;
+		WRITE_ONCE(p->config_pending, 1);
 		return;
 	}
 
@@ -242,7 +242,7 @@ void br_transmit_config(struct net_bridge_port *p)
 	if (bpdu.message_age < br->max_age) {
 		br_send_config_bpdu(p, &bpdu);
 		p->topology_change_ack = 0;
-		p->config_pending = 0;
+		WRITE_ONCE(p->config_pending, 0);
 		if (p->br->stp_enabled == BR_KERNEL_STP)
 			mod_timer(&p->hold_timer,
 				  round_jiffies(jiffies + BR_HOLD_TIME));
@@ -483,14 +483,14 @@ void br_port_state_selection(struct net_bridge *br)
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
index af17f62e95aaff320f8407aa7b50244573ecdc00..58ba535da4e5f473be6c6eec21ce1c71f4bf97c9 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -142,7 +142,7 @@ static BRPORT_ATTR(change_ack, 0444, show_change_ack, NULL);
 
 static ssize_t show_config_pending(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->config_pending);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->config_pending));
 }
 static BRPORT_ATTR(config_pending, 0444, show_config_pending, NULL);
 
-- 
2.54.0.669.g59709faab0-goog


