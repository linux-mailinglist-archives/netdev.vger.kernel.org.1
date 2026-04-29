Return-Path: <netdev+bounces-282448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHuJKhE+8mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:21:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD14981F9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96CEE300D1E6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949B410D38;
	Wed, 29 Apr 2026 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSS06cED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC3381AFA;
	Wed, 29 Apr 2026 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483278; cv=none; b=IQo1+WMGP6MPIbpnn7NIHnqhefMAvmy85OMzY3Q0YvnLhHG4q9gD2EuAUwHn7NwMLdGcR7BBsLkR1V++cjEhTHt4g1LwyayEbiTI9CQH9rZGi1WMeVIXp0gAG18jMC4QiqUbM4lIREbPtjHQqnvZEX9EuZ79OF+VadiEtrr9PoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483278; c=relaxed/simple;
	bh=t7i4sW+nUd3seEDXvZIMITm86tFwI6EhlGV8sUQPar4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ua9uxj87BQcG5F7ff1cxpKig6mr8xT9JdEdQtct5bJ0WpLe8H5ZzyFuOsJXGYemXpxCOiwjyMlZs2O3HSqZQZt8XaIyxAHveoNmmX8HkjCf56YFhhK3q5zhJ7kRmy9PV7yBDk4udvOZySWMPnKXxGvvldyW/BgioSd0yYAXdYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSS06cED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C62C19425;
	Wed, 29 Apr 2026 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483278;
	bh=t7i4sW+nUd3seEDXvZIMITm86tFwI6EhlGV8sUQPar4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSS06cEDHAGA6lndfSJPRYJPxML0fRDNbeu4injgOo5Sv7sN/ZLBGpujZDhS6Qqgf
	 u/SUYacTc68rlv5hB4ArtE8VM3kz2Exc1MSsY9mICOWnjl8k8d5UzVBgE9wJIUloGY
	 ntHgtfb3K59UBMtaFkbp74aKKvmbCw9oMSodKbOnQmPqcqjWgjfvViU7Jhd4eeYBAz
	 l4qG3OaKgU3nh5UtEL7dmz+Y9eE3xWXCE6rYr1Az8wxAia40fAq+6n3REYArfZNGpA
	 UPoS5FLrIERmQ1P4fy8Hvxcbiwbwh+c4T9BTLCM6KJ821HInQVBY34jvlQsE4Jpmte
	 gqoESpIy/lU2Q==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yury Norov <ynorov@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/5] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
Date: Wed, 29 Apr 2026 19:20:28 +0200
Message-ID: <20260429172036.1028526-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429172036.1028526-1-hawk@kernel.org>
References: <20260429172036.1028526-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43AD14981F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-282448-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
 include/linux/netdevice.h                              | 2 ++
 net/core/net-sysfs.c                                   | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

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
index 47417b2d48a4..7a1a491ecdd5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2048,6 +2048,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@bql:		device uses BQL (DQL sysfs) despite having IFF_NO_QUEUE
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2462,6 +2463,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		bql:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e430645748a7..4360efc8f241 100644
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


