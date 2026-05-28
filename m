Return-Path: <netdev+bounces-292886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPfJLkrOGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:22:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359025FB611
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30F143118EE4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF044370AE0;
	Thu, 28 May 2026 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmNA9tET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489D36F91D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010217; cv=none; b=MG4jBAhK7GWH1lMN94EvzrEh9lj05g23ox0ch2hCIACSnC0/6leGaZe3FqaceqwPwyFQLprdY5Br4+9lKr6P/N1+wuxesJQZrM/7Ms5/wv6dccNGM4uS2Yjy4WPbphBdgqPPtucd8vdP9pMI4aZMureXQtQYaFiwQzbD6+szvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010217; c=relaxed/simple;
	bh=0wid0A1WEddsxRmojrquvMvKMMDVKTOnKlJaFTHZbSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3cS3BXf6zXhSbvjmak3MHYcBpa3JQfWhwb2OvkkDhrKYQh/TSnIAYDRraxPShwiXibaePAgKy41AfwJ4ZaecLpWj/N+oF+jN3a1hheCaSyxsEJR7CM/NkkBNdxBpfpvkKazY9R7VGAX7FBT3cPwJ4i4fWdRhEg7IADCoSW5uF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmNA9tET; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D631F00A3A;
	Thu, 28 May 2026 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010216;
	bh=Am0LcCQo3hex/flMBZ8cx5LktRiogWaGlPeQ36V8VDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmNA9tETRMYD576p1iSfQIxnY4QiPC7ajohB65tdwHp11DLVX6XhRAJGXDMSBdg4l
	 16BB/99z11jT2Ik0S2Yh4cMMhshIkFMEXKZiUcOk9e/PgqdyCfRX7Yt7nDVsoFKUeJ
	 ebZBZmLo9W15l8xmKl93sUkihP1UjZySnALBCfWV8ytqRghFMD4gvuK24L2tcjWdTy
	 JPTfG/sUgzhHRZxC8epCgQqsIXY/7Mk3h1ut+zxmaen+CbPU/X7TEpavzJjNQSN8+b
	 hdqXP0Fh8jtx8p9UgantStqqlDMJXfXu2eokWyUQs5bDe1l9c3VDzQX7sceVlATomo
	 4MczrD/4j+z2g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/14] net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
Date: Thu, 28 May 2026 16:16:32 -0700
Message-ID: <20260528231637.251822-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292886-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 359025FB611
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethnl_tsinfo_dumpit() iterates netdevs and per-netdev PHY topology
calling ops->get_ts_info(). Switch to the "ops compat locking"
helpers which take either rtnl_lock or instance lock, depending
on what the device needs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/tsinfo.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 14bf01e3b55c..c9b680a9cc3f 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -6,6 +6,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <net/netdev_lock.h>
 
+#include "../core/dev.h"
 #include "bitset.h"
 #include "common.h"
 #include "netlink.h"
@@ -473,28 +474,25 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ethnl_tsinfo_dump_ctx *ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	struct net_device *dev;
 	int ret = 0;
 
-	rtnl_lock();
 	if (ctx->req_info->base.dev) {
-		dev = ctx->req_info->base.dev;
-		netdev_lock_ops(dev);
+		struct net_device *dev = ctx->req_info->base.dev;
+
+		netdev_lock_ops_compat(dev);
 		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
-		netdev_unlock_ops(dev);
-	} else {
-		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-			netdev_lock_ops(dev);
-			ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
-			netdev_unlock_ops(dev);
-			if (ret < 0 && ret != -EOPNOTSUPP)
-				break;
-			ctx->pos_phyindex = 0;
-			ctx->netdev_dump_done = false;
-			ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
-		}
+		netdev_unlock_ops_compat(dev);
+		return ret;
+	}
+
+	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->pos_ifindex) {
+		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			break;
+		ctx->pos_phyindex = 0;
+		ctx->netdev_dump_done = false;
+		ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
 	}
-	rtnl_unlock();
 
 	return ret;
 }
-- 
2.54.0


