Return-Path: <netdev+bounces-269023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNaOADKuumlXagIAu9opvQ
	(envelope-from <netdev+bounces-269023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:52:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573382BC624
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C1A73055945
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FAF3D9035;
	Wed, 18 Mar 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N87/CKan"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91F3D9027
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841716; cv=none; b=Eq6mJxyRNvU/5PtKIzKmfYsYPWmhc6cKoCHbSG+cA8+Q2BZJ0677CH2GopNV/NC5fZ+5KfhYgBssyVPfkKx69Jpy6UfMZawSILxEPJpGViFdVJsr6NKiByWqgPJdYuzEpaCtGX0hmT8xTRUsgg5k7UE/gbt+HRYvZKr7tyqsL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841716; c=relaxed/simple;
	bh=5t6wPUU1Rpso5ZpeFFrf81lT4S+ExPQYc+EF690GDOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elbRK2zSuBKngnIjfPyVDmA+bcSX35nojp99fLFQ1VTeXM6/ZrReJbE4AUt6aGu4KqYkrWQblWN8s8dOq9nBWdiM/QGunsCDD05fq23zFmPmHvrljj5GYOozAzxho9yPSCi41TtD0Uva1LNS4bNtHhirwqFY8YXiCz5RwWdO0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N87/CKan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D8C19421;
	Wed, 18 Mar 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841716;
	bh=5t6wPUU1Rpso5ZpeFFrf81lT4S+ExPQYc+EF690GDOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N87/CKanolkiASsXbhNB9Lom53KEpbC/h+InrEf5D83tuX0PwyjbQGTcntsVfQwJg
	 3uAvbjNuJBEwpZ/UDGHr4j/7JK/3FTDYAWlhGVlXxyECiPxnmb0p5fKjj/0ZOx4Tmg
	 8HqojDqDCgvS4X8FXSaENSxQg84lNzSnmQNAvtnRUdF6f9NGxOn9XcSd1RT2j8WKLb
	 t8eUoL93l/WKQ62e6tN0HQ1MT4e1eZzxeP4cZ+58PE2BZdQp46DHg3wgyVmVLZuBvu
	 tzwTxnpOwfiOpyS+Zu64RCYT5T8nPnIu4KzTlqWyHqaJiRdvyF6KojEHjDxsTKegvs
	 7HlVmYjessqTg==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	toke@toke.dk,
	sdf@fomichev.me,
	j.koeppeler@tu-berlin.de,
	mfreemon@cloudflare.com,
	carges@cloudflare.com
Subject: [RFC PATCH net-next 1/6] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
Date: Wed, 18 Mar 2026 14:48:21 +0100
Message-ID: <20260318134826.1281205-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318134826.1281205-1-hawk@kernel.org>
References: <20260318134826.1281205-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269023-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 573382BC624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Virtual devices with IFF_NO_QUEUE or lltx are excluded from BQL sysfs
by netdev_uses_bql(), since they traditionally lack real hardware
queues. However, some virtual devices like veth implement a real
ptr_ring FIFO with NAPI processing and benefit from BQL to limit
in-flight bytes and reduce latency.

Add a per-device 'bql' bitfield boolean in the priv_flags_slow section
of struct net_device. When set, it overrides the IFF_NO_QUEUE/lltx
exclusion and exposes BQL sysfs entries (/sys/class/net/<dev>/queues/
tx-<n>/byte_queue_limits/). The flag is still gated on CONFIG_BQL.

This allows drivers that use BQL despite being IFF_NO_QUEUE to opt in
to sysfs visibility for monitoring and debugging.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 1 +
 net/core/net-sysfs.c                                   | 8 +++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..b775d3235a2d 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -170,6 +170,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     bql                                                                 netdev_uses_bql(net-sysfs.c)
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 67e25f6d15a4..09e8c4dc16a0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2463,6 +2463,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		bql:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 2ce011fae249..b57f76b7e578 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1945,10 +1945,16 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_BQL))
+		return false;
+
+	if (dev->bql)
+		return true;
+
 	if (dev->lltx || (dev->priv_flags & IFF_NO_QUEUE))
 		return false;
 
-	return IS_ENABLED(CONFIG_BQL);
+	return true;
 }
 
 static int netdev_queue_add_kobject(struct net_device *dev, int index)
-- 
2.43.0


