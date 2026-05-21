Return-Path: <netdev+bounces-290438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Na2Ne4LD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532195A6224
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD3E309D4A1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F623EDAA0;
	Thu, 21 May 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvK+7qkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15B312836
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369573; cv=none; b=Q/HU/ES+1keuHLgsurAp2bARe3zDLJFllySpddnjxPNpZpHWKkVTnFEH4RoS1TcHGa11pk23hiKiw1PlMoLqv92MQLsksFHAInbv7te7lhvw05uUmZ1fzT39AjopeTWOoZ4+gsGjj3/WOQh271YYoPul2rgAlx2kion7/0j0zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369573; c=relaxed/simple;
	bh=ACHgyRqkOpZ+tSOqswXUEM8y4hsYq2DxSlHVc+my1b8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8BLi1/jkCM/F6INS9puD46fXFv25ozDhPkZC1Fqbq/b28dEn3KyNYHOt/u3Lb8X24cP5cA478/2vup78LL2gmbw3+/RwdaZbDDq+PG3o4yUZ75fYJ+2WcDa+krCuVCqf4XdSQ5XlztVqQe1GtSp9fMfxwGAJBqfBhz8m27sznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvK+7qkv; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90fb1490e2cso1436963685a.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369571; x=1779974371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIv0fTFdgK82MyOkvaVOSlIpdPPd3IpfEDLLq+W5pe4=;
        b=gvK+7qkvsiAo6XteYlNq12S4Sl+FzNgNZHSO1dMJSh5jjZhVi2hDSevB/fUYwrAQKc
         GwZDHxXLYGVKLHYSDSIOITmlSLgiQTQRWY6ZV6P0SDASDjXJImqQWlhjnip24JM+2nau
         KrHElI8ApOCGamziNamoVX9f3ZtQNBxNGcQMGIsPU44SVcI8L/1lo4vLD2k3D6T05bG2
         nbXumdx+1jYex/J3uPZHE6ZT00EE3D7Sa917Gkizk5nDX/M4Vz/XgC6koIl/IVmxcfPU
         JTWWT/TimwKlltPYHmD+qqAxYKhxSnLIJV3eU89Vm8f1Qu+gKpqCTdplyC0t0jalFaJb
         cF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369571; x=1779974371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIv0fTFdgK82MyOkvaVOSlIpdPPd3IpfEDLLq+W5pe4=;
        b=OA21xbwO01+KoxOc6vqswyIbig5Kgmd0VKPUBARVeoBEjbDryuBlgmTrth6H2gQzL5
         h+En+mt4nfQCO/Anh2bKnoEhKQWo1PYo9yO33GLGzM8G5GHUtNdkrAF7tWHrtCGe+lF+
         d+WO2O4Ymhq5CNBqGEAW+oCRpvUEpmgrBP32K0g+RnsRYMG3wBsdcoAqdePa8uFV/gU2
         kREdg0ikvWpOs9uwiFsLpbFHvnhLJ65y59k4kHeGFS0ber6V93w0yu67CGKfuB1GOVVo
         jWNlNs7WSQh/h4aaXndTgh3nxZ+Ws1wA4JLG4I4jl8n2r7Wtnsvq4Zsk1ROAM0Aey3RK
         X6Mw==
X-Forwarded-Encrypted: i=1; AFNElJ9w2KI28DPTr1nQ6ooTG77d7PxdtmxP3w0qoGB04cH+adBJ2KDjEDHKv19al4gAhWl6HzznWJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEex9+Ahr1oQXAN8isS/hdQ2SStejKjAzjvjuSERCExMb9238b
	6DPsR2mi5t0qSgwsU52M7IqFEJhQYRXbshQfC0G6wh6jWwnj72zCh0cVN3N1Y95YbHwdEwAjjfY
	IddnhsnoZKCCwZw==
X-Received: from qknqz23.prod.google.com ([2002:a05:620a:8c17:b0:90d:23cf:6a4c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:45a5:b0:912:c22f:6676 with SMTP id af79cd13be357-914a2ce9e69mr368740285a.35.1779369570813;
 Thu, 21 May 2026 06:19:30 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:12 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-8-edumazet@google.com>
Subject: [PATCH net-next 07/11] bridge: provide lockless access to p->designated_port
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290438-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 532195A6224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost

This is needed at least for sysfs show_designated_port(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index 153e1cb0fbb6ea9f65933d884b9a78f5446d0de6..3c10125cfa6e703dec609a63940632b9b206d132 100644
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
index 62dcac1a181c829e2736d7ab8679c870ee676a71..4c364a7f0f53f4f9360887b93bfbc592c738e311 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -256,7 +256,7 @@ static void br_record_config_information(struct net_bridge_port *p,
 	p->designated_root = bpdu->root;
 	WRITE_ONCE(p->designated_cost, bpdu->root_path_cost);
 	p->designated_bridge = bpdu->bridge_id;
-	p->designated_port = bpdu->port_id;
+	WRITE_ONCE(p->designated_port, bpdu->port_id);
 	p->designated_age = jiffies - bpdu->message_age;
 
 	mod_timer(&p->message_age_timer, jiffies
@@ -427,7 +427,7 @@ void br_become_designated_port(struct net_bridge_port *p)
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
index 9d560482e558aa1ef4d2f583373f15ae5db8a0f0..23ea003d72f413b1164496c3055832ab49197d4d 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -111,7 +111,7 @@ static BRPORT_ATTR(designated_bridge, 0444, show_designated_bridge, NULL);
 
 static ssize_t show_designated_port(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->designated_port);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->designated_port));
 }
 static BRPORT_ATTR(designated_port, 0444, show_designated_port, NULL);
 
-- 
2.54.0.669.g59709faab0-goog


