Return-Path: <netdev+bounces-278017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBoTOLy73GliVwkAu9opvQ
	(envelope-from <netdev+bounces-278017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9C3EA041
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 979E63042258
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316843B2FC9;
	Mon, 13 Apr 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/rxVuzC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE963B27D2;
	Mon, 13 Apr 2026 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073516; cv=none; b=ELnBaeh57h2G0lHhtEAkKdZy7sqxuoG/CJwtnTyA9lGd1X7bdETGyzd4/3ruhT7HRsm7vhvlnjXoupJ5ZhbxKgMV9Am4JSqU7XhYRZ21jmae104MNyCyeVwo8AiHO0LJ81mjCAi9uQLDSfVKS8dz4pFr1GQZfIeNgVaBiNy3OUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073516; c=relaxed/simple;
	bh=t7i4sW+nUd3seEDXvZIMITm86tFwI6EhlGV8sUQPar4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNOEgNsrbAYU5f/6lPcPPR5QEl55Wgt8uGWx3WuVlraYr36WYyxx7yZ6ht74kRxv6PAno3FAuQRHEEoW19b4rYyqsOigRjwhWeAoTE28tTY29wv5z67gw8VVedbGzxNToK8YqXYb5ZucelLRWb9gCSQLyozLyBjtzNQf+/uc6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/rxVuzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91F8C2BCAF;
	Mon, 13 Apr 2026 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073515;
	bh=t7i4sW+nUd3seEDXvZIMITm86tFwI6EhlGV8sUQPar4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/rxVuzCpT8qEbn1EGTksiDeMyMa9DU27wW8kdA34pqTh/h16L8yeN4k0eLfbRIz6
	 nQn5eZO156m0nu3AgKu9okh8W4IYpVFHyXmlQAvH8scFH9n3PtgTXYPRRJW6MU3jsR
	 lIidvSdx7bF4RMesJdjDoNQO8Kkd0ndeTZeOwpvkhKu/TLDNjp2P2TOGEz6P9s/KbC
	 FF8HOa09AFLZpbrV4Et5zqL5YknfdjE6RxljR8F3se2mb5POCMLK+bWrWfzqEkD7Nr
	 p/i0H830lNDCfAoCMiOTd0HxhSRBep2lojorXkwDsUtTG3N2jexEAFC2X2aE7hDgcg
	 QK4scEQtyN0CQ==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
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
	Frederic Weisbecker <frederic@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Krishna Kumar <krikku@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/5] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
Date: Mon, 13 Apr 2026 11:44:34 +0200
Message-ID: <20260413094442.1376022-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413094442.1376022-1-hawk@kernel.org>
References: <20260413094442.1376022-1-hawk@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[cloudflare.com,kernel.org,tu-berlin.de,lunn.ch,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,fomichev.me,linux.dev,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EC9C3EA041
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


