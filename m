Return-Path: <netdev+bounces-295051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FcdRGQITIWqf+wAAu9opvQ
	(envelope-from <netdev+bounces-295051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:54:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFA63D18D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:54:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bdNNhv66;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295051-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3675230097FC
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719A3D3489;
	Thu,  4 Jun 2026 05:50:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47083D411B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 05:49:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552203; cv=none; b=pRWhm3trKGFIbs0ZC62dOu4QcasvWurVksxDeFbp9bAy8RTGHxYEz945jCjfro33q1h+aoE4H+MvSJEXQkHO9iVbqyKux0d8Auo4Kxn5Rim6cBDZN/074DVboiaUvkLpZT4auyadsRkG+By9Du9Tg1ItkbSq8AdZMeWh3MmvPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552203; c=relaxed/simple;
	bh=zpCv17Sg5kWkxuzMxb1CNjR4cVcHw9YcPd9dSnigmAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WGpQdAslwCSCKHc8F09zeU0hNzRLKU+Q5l+RIFnKbfg5qikGqATXa1qh4z/5Z25Ynz7eAUtnjB4AQiXWtDmgYbUUiwSpkpOv88zvtBcDUuYO0RQBLJaB2a1w3+0kZCeklpAFK/ae9OEG9LXzLX65ML//jjyFeh5MqRN7vU9vV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdNNhv66; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84237c55ef9so135715b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780552195; x=1781156995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6O/WIRCX+AkXpjS4dBwmz/ZiRhzvinSASQRSoiHl/o=;
        b=bdNNhv660kGRaonALZmmrRjd3LWqkfTf9/1GC8ICyOmlygFO2Tmxvz5/XGHdms8BIZ
         fE3AYYs1evukfkAbH3IoHwPb3Bf73o3yd1EU9LiWUE+Hfu+1kTZBJ9F9nYMkS+BYL4U1
         nxnhsaguKWjKZgZ/2eqZQrcMcBhpufNIY0rXxDsp2hknz0DJMBiQ2a+v4bc37vVnP/eG
         OfC9FxxzkEpQlVYB3dVKDgdtIAwQmQI+UoCvQgJplLYoPuIBNRBcg218b7MScAKDomxG
         ejlZ4lvht7H4YIVgSThQyNN5HoPlyL7ymFdspZWDRTVp9cUur6sEVi5srIrG8aur2WbR
         LyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780552195; x=1781156995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6O/WIRCX+AkXpjS4dBwmz/ZiRhzvinSASQRSoiHl/o=;
        b=KGd64AgenJ3KJ0r2USDnO5m3wRO7qBit7x4fyeU6SiDGZX5l2KD+LGLl/uaNyby4gE
         DqW4aCykQvn2RmOxAi91B9LokPDbS5hHvVG8uulBigt5ybFMNT/6UbOZ/WjX7AmKbKMB
         xl4byS1nJJ8wD/sD1hT6DZYEUWy1d4VNKshP4IxBbsXwBLfPVHEhXrejM9Pa0AExoNOR
         aZA4tnNG9uUeDhQMw3UAI6Tt0ml/5nIX4NfITiyrZ0ddTMrVcfEw+ALrgqLcBPmpjxEG
         QVLmKGZi4O5juBmbtPIjzvFfQfIo+1FIjkQ02VNSXWTi1gyTIr6gqbZjC31AfrI0aVG/
         atxA==
X-Gm-Message-State: AOJu0YwvPxZWbJ6ABVRT3kBzutCwWH9nC1idVgf0e1T3oKg9tSN+Z7nI
	v27M1HNJaktHvaA55zq357V4qtHBJy9caSQ7tOfkySS9l4VqP7IMXOfb1s9l0g==
X-Gm-Gg: Acq92OFz2ek4SAOGKT0vyG4+kRWopWsn951OzOrf4xCsAMgeALy5QZ8oaVRMkrHsOw4
	f79GHaGHrheb8wBdALWcDTJc+zrNkGeW5k3dwxep4lTe8LPxsEgWjS8Bm5o1tPvSAEr6aU28oGs
	M89rkLiwlnjwusWosMBm4tuFSLJT7p6rZMDnVKptrpu+af6QDYxdejSfhXH1VfZx6QoYXfae16Q
	5IlnW9p8ihpEff6ZZU5ryV6bBziHaBnDBn+PoOvyaiZqTS0tP2iThK4lNsnj2xXpwC/Ri7CDQQb
	O4XuceDetIZQ0pb6acpa5nWC9Rn7+9j6iSGMliYLCb/J/2P0IoOQKQvRHnFJzazRiApX/2YDK1p
	qsCnNmKZTJ7ORWEWGNoVL/P9qv5zS/LAvdiZhw9Iw+1Oow3TexL1qTQ+1E4s8fylt1nrPFBLNGs
	dZnhh/G0J5Ym+IXbHO4+vVjXNxFuh06NTD/RAZaHGFa/RTRlzS/8KhADijKtwiQ3vQx3QGoA==
X-Received: by 2002:a05:6a00:9094:b0:842:54c1:8e15 with SMTP id d2e1a72fcca58-84284ecf490mr6679870b3a.29.1780552194807;
        Wed, 03 Jun 2026 22:49:54 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821ddsm4880943b3a.35.2026.06.03.22.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:49:54 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	fmancera@suse.de,
	jvaclav@redhat.com,
	andrew@lunn.ch,
	luka.gejak@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ap420073@gmail.com,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net-next v3] hsr: broadcast netlink notifications in the device's net namespace
Date: Thu,  4 Jun 2026 13:49:49 +0800
Message-Id: <20260604054949.2999304-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-295051-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fmancera@suse.de,m:jvaclav@redhat.com,m:andrew@lunn.ch,m:luka.gejak@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ap420073@gmail.com,m:maoyixie.tju@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1DFA63D18D

The HSR generic netlink family sets .netnsok = true. HSR devices can
live in network namespaces other than init_net.

Two async notifiers broadcast events with genlmsg_multicast(). They
are hsr_nl_ringerror() and hsr_nl_nodedown(). That helper delivers
only on the default genl socket in init_net. So the events always land
in init_net. The network namespace of the device does not matter.

This has two effects. A listener in the device's own namespace never
sees its own ring error and node down events. A privileged listener in
init_net receives events from HSR devices in other namespaces. The
payload carries the peer node MAC (HSR_A_NODE_ADDR) and the slave port
ifindex (HSR_A_IFINDEX).

Switch both callers to genlmsg_multicast_netns(). Other families with
.netnsok = true already do this. Examples are gtp, ovpn, team,
batman-adv, netdev-genl, ethtool and handshake.

hsr_nl_ringerror() already has the slave port. It uses
dev_net(port->dev). hsr_nl_nodedown() takes the namespace from the
master port via hsr_port_get_hsr().

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v3: Drop the master NULL check that v2 added in hsr_nl_nodedown(). As
    Fernando pointed out, master cannot be NULL on this path. hsr_dellink()
    calls timer_delete_sync() on the background jobs before removing the
    master, so the notifier never runs without one. The check only produced
    a false positive static analysis report. Use master directly, which
    matches the existing fail path that already dereferences master->dev.
v2: Drop the Fixes and stable tags and target net-next. As discussed,
    this is more of a behavior change than a fix, and the .netnsok
    commit has been in since 5.6 with no report. The multicast stays
    inside the rcu_read_lock, which avoids taking a netns ref on this
    path. Fernando's Reviewed-by carried over.

Inquiry (2026-05-18):
https://lore.kernel.org/netdev/CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com/
v1 [PATCH net] (2026-05-27):
https://lore.kernel.org/netdev/20260527075924.2707856-1-maoyixie.tju@gmail.com/
v2 [PATCH net-next] (2026-06-01):
https://lore.kernel.org/netdev/20260601022014.1175348-1-maoyixie.tju@gmail.com/

 net/hsr/hsr_netlink.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f0ca23da3ab9..8099f2069a74 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -252,7 +252,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 		goto nla_put_failure;
 
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(port->dev),
+				skb, 0, 0, GFP_ATOMIC);
 
 	return;
 
@@ -288,8 +289,12 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	if (res < 0)
 		goto nla_put_failure;
 
+	rcu_read_lock();
+	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
+				skb, 0, 0, GFP_ATOMIC);
+	rcu_read_unlock();
 
 	return;
 

base-commit: 8415598365503ced2e3d019491b0a2756c85c494
-- 
2.34.1


