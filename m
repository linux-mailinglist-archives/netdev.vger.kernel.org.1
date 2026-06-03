Return-Path: <netdev+bounces-294576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Mc+F2fIH2p8pwAAu9opvQ
	(envelope-from <netdev+bounces-294576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436A6349F7
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=M111BIte;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294576-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB2F7303BA5A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6B38C401;
	Wed,  3 Jun 2026 06:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD363F5BF8
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467662; cv=none; b=mqEBetha2ieeQdbmFb0g31DbW4YVtN/17rLR5cgTwB5VqINCtUmK8v6xFrboEB/9sZk3ifLfmyzhzKMNEl87y2fPBVkF6ixpvTT2aEiWo6Pucm718jREoDSc6JJ+VnzQfiwbwufg0CuSjfoe5QA1ir6hPeU0yzew78dwG4QcnII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467662; c=relaxed/simple;
	bh=HaU0b7w4DHRqaXU0rDcDnAS1z6lk7Z4j/pocJIv59jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ugVE/w9s3OQvHAKBpMVU5ceZt/eRJ/rXPaMyQaZBcdcLMdUmNhTN0aXVQ5kVkXZej3X74gmtTSKt0Uw0xGMWd6+4cLAfgqpgHMyqwOFD95xFn54Fs2myGvUrVltDhKB7pQoDC0/AQqC5uwwaWifjv7atU0d0WoIOV+sb2pgcPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M111BIte; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5176d5d7222so30188591cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467657; x=1781072457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKzafJDjZEPIcgnXIzqR3ob6CtdeCKWGCVwowDPQ7kI=;
        b=M111BIteoyiuDxIqUGzBVN8jAJsrtyRzH0b5LCDtF8o7cjgAUiUNDHGqQRzLK0YD4x
         XNX6nfm89ppcgvhqhCbVUSaVzs59v5oQGGBUTtQ0BQ8IZCupVsyYOvyW3cAPlS1uWcjA
         3Qy3JR03P8CROx8102aAdUE67b2Jja+mgx9ZOgH1I4F7ruZ4DyTllHreB6hJlSrusxDL
         IytKu5zjL5J1vvmrXEmY2qU8pWfMn/04pqkNaf1CkDJOKNS/n2SFU4RNmAnaOzfuiqEJ
         JHoGt/PMqsLSj9HTyL71IJKo/RHE2ER58R6x1tMJvum9ZoESVBDSXeLErpSGuoPj1E/y
         Yu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467657; x=1781072457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKzafJDjZEPIcgnXIzqR3ob6CtdeCKWGCVwowDPQ7kI=;
        b=rEeJOpnWVwOP36/xHumiisoOoJOsomzVTHoJeIYjOT/1TEFaihCZ8jv53yc6fjCVCB
         AGYZ/BHakjwdUblgeq5Qeu5KXK6BMwVNWBhMTX4H+KlSO/dKvFtXpmwzr4EyQpVuDHLo
         UlqC/bYwxO+vkYm/NpdKjxF/CZopFvmPSdjfPCaF23YQfswy3EQHDDZCSy7XGgRASI9I
         eDSxQ4IQzWSiiEz8rjU+APNx6/02+U07RCWvuuATEtjO5SBepr7MA/Fs4NFNm09Ly2GM
         MMcxoC3TPcyPKq7vaPSyiEkViKQAkyPPFI9QOOuqrHnCPQMHId/l5vuOF0YkUQQvv0SD
         wSxw==
X-Forwarded-Encrypted: i=1; AFNElJ+yxbnePPIhygnsymjw1OrB1Hnc4oqxKD89IOx36p39mymWry6eW4A8IglIqZOU4teJ2zTu7Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsFHANP/wE0kEWBgwsLS5Vv+lya0Y8xrc6JdcnZYr+BupecMVJ
	b7nxQHFC1HIQoDLgBQoMJbpfQb+4E02BWQPvSb6TOVDcpu3FiaYF2GjilOnH2sdUURiQknM7cCf
	SiVX8MZy1j3l8lA==
X-Received: from qtvw4.prod.google.com ([2002:ac8:4d04:0:b0:517:5b5e:1abc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:411:b0:517:7104:4e94 with SMTP id d75a77b69052e-51778628cbbmr34766651cf.19.1780467656965;
 Tue, 02 Jun 2026 23:20:56 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:40 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/11] bridge: provide lockless access to p->priority
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294576-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5436A6349F7

sysfs show_priority() needs this.

Also br_port_fill_attrs() might in the future run without RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp_if.c   | 2 +-
 net/bridge/br_sysfs_if.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a722db89aef6bbb6ecc77c7e0f173dc79418797f..fc25c6b6cc9713080873976f443da1fbd764aafe 100644
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
index 1023f97b1c9a22a1f79c3c734aef9bd41832ea39..3f666d4fef42324a4751779153ecc48bdb44b85a 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -100,7 +100,7 @@ static BRPORT_ATTR(path_cost, 0644, show_path_cost, store_path_cost);
 
 static ssize_t show_priority(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->priority);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->priority));
 }
 
 static int store_priority(struct net_bridge_port *p, unsigned long v)
-- 
2.54.0.1013.g208068f2d8-goog


