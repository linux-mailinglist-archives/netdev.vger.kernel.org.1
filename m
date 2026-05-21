Return-Path: <netdev+bounces-290439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JErGvsOD2qSEgYAu9opvQ
	(envelope-from <netdev+bounces-290439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:56:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 145915A67D1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8A6A30A414C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082313EDE4F;
	Thu, 21 May 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUYjSu7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF733ED5CC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369574; cv=none; b=qtzbsj7jkqwtdXpTj2G5BCltJPQTwKfkLyztKYX0eSkMe9o9sxSmE+sZfIfofUhSxV7siCALxrgSIe0eZ02+iCb/cyPoM2wwGvpVDeWhHgAzu1pYsi+XZ95kywhyvdsqCACbnirPX4CxwSJ4ltCS2JEDUa2Modzv+bbaLtZKhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369574; c=relaxed/simple;
	bh=RDmgpg+69BQnG3BpvWC1zE/KZnG1gGaBk0M3s5fNaxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hfKWV780AEruWpinqHYyjBMzUFibTu1CUsdbXuJrkmgpIm1Nl6QX/CVcuwH7k63B2kYqFsvxcoFaiDDQqpO5MyQzDBnWyDkAK1MkE1wWWIKwW5Z7Z9ZkzJpa9AfQnOyXxIBe3DU05sp2cZ5fud+4YudgbpyieRnwXfMR3mXFMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUYjSu7a; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50faf575af4so165706801cf.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369572; x=1779974372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn5jtEJajccOsyEEaQ6Y7KqfGKfcO0KJj9JEJw/Sn40=;
        b=nUYjSu7awn2OuC3Gx677rceWhWYcPecVxUjRnvLSAY2wOck1+f0yVKWn4qCGQ7ZPOL
         oHSDkdyIuz7Af0w99SKgsySY8OOIUcsEXgOvCOgxxDv7b5VyQJ1RZ5adqqv7wkpsCiQv
         WOjsXgFavdQwYFc3eylyPRRe3tK/hp5z9FqEukPnIPUsFqvhCN6Ip/x1HS0G603CgHrH
         RVX+5Kh4fYV09S4eRn7jEEOIuCa8HDU149+qpECUs/WLBwhZySxx6bfzLET8HIQMRx/+
         n1Sz5bvqtgKKCyuhFHlSoVX+JtLE1zTIVDD8dbHZEU2DdJku01IT0FQ676yPOoHuST1T
         hZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369572; x=1779974372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pn5jtEJajccOsyEEaQ6Y7KqfGKfcO0KJj9JEJw/Sn40=;
        b=YKlElqL7P+NiWxm2CO62CzQ5jqhkaEaiubWRiEcztd3u6vXJyEdye/kOr24c8jE9Jt
         dr+PIZ3m5lTCK0/c8yHHvGapCGVFoGy8eVTVEdHRR9npav+w4pVOWKml/enm+my8L91/
         sMX0CiaS5ekFOYNZcHTFcivY5lNgXVTlqqwS60gh1CeW6uy/YKOYOA0mTGuCmZozUEJO
         3x8Ve10sCb3YtCq4hZ6QQBxh1kpN2AV99Mo2PrRvXEFz7MWSxpciPGlLrFmsBfFfulVL
         IN/ekSQZbzD3GKU5oIQKy1KbpGqAzVk3Dst8KLmVE5UyT6vi7Oj22Se2oCd8/i5Yb8o3
         wqAQ==
X-Forwarded-Encrypted: i=1; AFNElJ89lRolWfSlHEWKERA6+uSazEmR0i1guzmaZ/GbUSlBqfCKvCCHoAaDwVYjZJSItk5VieNAi2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKa/ZRsONJW53zZSRLiZ+LD7L4haiYtTV7g77iH9dJO7i64SQm
	Xk5x3UqGAFRraQuRErS9YRm0/mIfXiLCY28Iy/icrJUsy5MCGvc0vPWC9pv+wubW2P7H8YVqAf9
	DMPIs/hf2+3zpYA==
X-Received: from qtbfp26.prod.google.com ([2002:a05:622a:509a:b0:50e:5e2d:ed75])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4889:b0:50b:4001:ae11 with SMTP id d75a77b69052e-516c55ee5bamr35304761cf.57.1779369572175;
 Thu, 21 May 2026 06:19:32 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:13 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-9-edumazet@google.com>
Subject: [PATCH net-next 08/11] bridge: provide lockless access to p->priority
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
	TAGGED_FROM(0.00)[bounces-290439-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 145915A67D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sysfs show_priority() needs this.

Also br_port_fill_attrs() might in the future run without RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp_if.c   | 2 +-
 net/bridge/br_sysfs_if.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3c10125cfa6e703dec609a63940632b9b206d132..30e253ca8d0b1ec9126e576629ade5211ab066ca 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -239,7 +239,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	u64 timerval;
 
 	if (nla_put_u8(skb, IFLA_BRPORT_STATE, p->state) ||
-	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, p->priority) ||
+	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, READ_ONCE(p->priority)) ||
 	    nla_put_u32(skb, IFLA_BRPORT_COST, READ_ONCE(p->path_cost)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MODE, mode) ||
 	    nla_put_u8(skb, IFLA_BRPORT_GUARD, !!(p->flags & BR_BPDU_GUARD)) ||
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 7b0d1a334785047905a00694fd65e3212b160e5d..3524bb7e87f0586774a883720be9fa8eb60f0370 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -323,7 +323,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 		WRITE_ONCE(p->designated_port, new_port_id);
 
 	p->port_id = new_port_id;
-	p->priority = newprio;
+	WRITE_ONCE(p->priority, newprio);
 	if (!memcmp(&p->br->bridge_id, &p->designated_bridge, 8) &&
 	    p->port_id < p->designated_port) {
 		br_become_designated_port(p);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 23ea003d72f413b1164496c3055832ab49197d4d..7c55f78237d9e421ac9c3e64d71cc021ca75d1c7 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -91,7 +91,7 @@ static BRPORT_ATTR(path_cost, 0644,
 
 static ssize_t show_priority(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->priority);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->priority));
 }
 
 static BRPORT_ATTR(priority, 0644,
-- 
2.54.0.669.g59709faab0-goog


