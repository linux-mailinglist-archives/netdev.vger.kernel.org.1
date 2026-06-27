Return-Path: <netdev+bounces-302314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AvgfNJOXP2odUwkAu9opvQ
	(envelope-from <netdev+bounces-302314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:27:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DE6D18F5
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:27:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=hF2yAGFB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302314-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9EEB300F47C
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72C396588;
	Sat, 27 Jun 2026 09:27:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D538F954;
	Sat, 27 Jun 2026 09:27:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552457; cv=none; b=KEwuLP3XQ7RkfnwXkA+D21y4GB3a57UIuehkeFSuXr2Mt87J4vPg1vmun6kgl0iC+3WVpDzrHL7x/007qXI5/JgU3Rg0DrN9yGXYXri497/KO404fcYugPj1/wKyQLB3vnzwANXPeYPSf2nm3pJQOWhEVHqt677RLqz824LEmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552457; c=relaxed/simple;
	bh=jrVtsHnfDRNSEJ/aii/rkH/8a/kolbD9GzkJQOM0Svs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBYsrboKgvQukE91KNBi2yn60HCfQF1Ro7sJ/yJb7mtss0csypjlaU59gpffN7ddS0ysasPHS4nz3JyKFzAHy2wLiyU17HINJUfaMV0NTfw/lKrt4AdVzAqJMjBWRcp5rsgFjQlkcGfLH+YY9EFCfZFwDOb4d87ZoAuEBBMRFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hF2yAGFB; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fdf9cd9;
	Sat, 27 Jun 2026 17:22:20 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: sam@mendozajonas.com,
	fercerpav@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [RFC PATCH net 1/2] net/ncsi: defer freeing VLAN filter entries after RCU removal
Date: Sat, 27 Jun 2026 17:22:13 +0800
Message-Id: <20260627092214.373480-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
References: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f08631a5903a1kunmb5b491adc8bea
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGksZVksdSh1KHk1JGBhCS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hF2yAGFB0J0rFrsaO1TUsCScW+pX1hdnLcU4Ikse4f3DnarNY5ZlgRJcjMjyzz3/nn/ZFq8hsHNvargspqPmwP0gj3x11nz58kDw7qBbLTMqMYp7/WzvHKJKZWdmw1wXnxUsQLOHmEe7m/cklsyj0y/L+MOUVRKq3j7yTaVDick=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PeYn69QskiMyDm2sM1NSc6St2B7NpfiUq6HwvAi6PVs=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302314-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam@mendozajonas.com,m:fercerpav@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 840DE6D18F5

NCSI keeps VLAN filter entries on ndp->vlan_vids and updates the list
with RCU primitives. The configuration workqueue reads the list in
set_one_vid() under rcu_read_lock(), then dereferences vlan->vid while
constructing a Set VLAN Filter command.

ncsi_vlan_rx_kill_vid() removes matching entries with list_del_rcu(),
but it frees the object immediately with kfree(). VLAN add/delete
callbacks are serialized by RTNL, but RTNL does not serialize the NCSI
configuration workqueue reader. A reader can therefore keep a pointer to
a struct vlan_vid across list_del_rcu() and race with the immediate
free.

Give struct vlan_vid an rcu_head and release removed entries with
kfree_rcu(). This keeps the existing list structure and makes the
list_del_rcu() lifetime contract match the real set_one_vid() reader.

This was found by our static analysis tool and then manually reviewed
against the current tree. CONFIG_PROVE_RCU_LIST was used as
target-matched triage evidence; the lifetime change is based on the
matching source-level reader and updater paths rather than on the
dynamic warning alone.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ncsi/internal.h    | 1 +
 net/ncsi/ncsi-manage.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..d9f0eadc7a24 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -310,6 +310,7 @@ enum {
 
 struct vlan_vid {
 	struct list_head list;
+	struct rcu_head rcu;
 	__be16 proto;
 	u16 vid;
 };
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553..5316eadd8ce4 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1737,7 +1737,7 @@ int ncsi_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
 			list_del_rcu(&vlan->list);
 			found = true;
-			kfree(vlan);
+			kfree_rcu(vlan, rcu);
 		}
 
 	if (!found) {
-- 
2.34.1


