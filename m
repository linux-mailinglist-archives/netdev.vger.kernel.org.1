Return-Path: <netdev+bounces-293495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKbyCGrsHGq4UAkAu9opvQ
	(envelope-from <netdev+bounces-293495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:20:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD347618CD0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C1E73003370
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AD201113;
	Mon,  1 Jun 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLM2IVEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58521DF73A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280421; cv=none; b=twiGJmQyHbt1Yp2FSpe0THjcn4VG5Y8rt4Vcr2iVQQQG9lNCWC6CEyOSuD8dJIpI+Ewy4NenhxAiE+ZJ9namiPIXR4wrsV+6znSxKWnntEq0ETKSKoL5zhkZNnmuOriNabUQQ4mW/GBuT3RU+D0jgGc5R5lFoiLeGMNEi9hZ4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280421; c=relaxed/simple;
	bh=8XquwNYqpoDi8pjPowgKuT/Kcn1pqiJjd54ju7qqiis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AArSRZpl0XxbQllw0JxwlNSQyI2j+C4uuaUrZg2iHT1KH4Y0TgqHQAHXNN6iYMkP1MgEueT6xpSWpHh6bDYUFIpWmcM794bhU1sawRiWXMcEbLgHIACodLG8p1gyps/r6NXOCce/r5u8ditlujQoDtuvL4d42BJ4TUL//hfBQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLM2IVEh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so221048a91.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780280420; x=1780885220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3kT6GFrQd2hCnARBIk0tmZtMXSIFafPGJVXZeJkvOI=;
        b=GLM2IVEhNRsb+ejsd1JQc2LJGXFOHcPEqeh90zMhQVMaxUdHNnL2HUO60j+8W55y/j
         K61x1GguHxCCxZA9YzPKq2w95dutDFKORDdXjI0b/QFMTFS49HUYP3GS9NlNDweRyz4/
         jtabp65UNLnHS15Am7GDvEy+DRgaPsw4viQEVIRiE/6fqG0bS2w3a/LkTFybja4z/0Bn
         o4mMi9tIQJDAZMpWiSQ9uF4VYWkFNSpwGaCNWywPkkx9209g5mcgwp2UgzGOvUNbg4UE
         a3oFwJ+c5nMncLek5PiW8c/awRI6yJLhs0rqhzfD2ePpzDTQXhJOYqgb1g45Usd+kRgq
         0OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780280420; x=1780885220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3kT6GFrQd2hCnARBIk0tmZtMXSIFafPGJVXZeJkvOI=;
        b=aKFi4lRY2TTDfQcQLYa8hHidpKBIkjxmgJdZORKkndkNJsW4lh4iN3IMZmI1WZjyQs
         YEW7jpJ0da55lcFP3XjRyXj7qWRsTX/nKIGmzboYT6Lx/ZoV6rtJesweattGKCMSWe8q
         IjcrwDe50A1Z6R2wLAwzxFVuNfGLVSSo4914gjnonMxeIf4UvpD2jXHTmwyAyizgkyIr
         5waloGelTTFXySDQ2p38+YZLc/RYf36k99ZXJlDtCwKz4yA4cw8rgZGl7TWuIAwtNEw9
         14qbA7HmE0/mbvIU+RHaFycB5ytqCVqoqxtB9cGI3qqKUUdUiPXRYou89Al+aMHhiLvD
         h2WQ==
X-Forwarded-Encrypted: i=1; AFNElJ9V5rbTTHBlUGOeWuA7Z+nWcMK0/PldJCA4Fpc6WyjU22MMBBNvwWGtOFu+GuPUi7N/ry5J2Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9UNR1B30JxWwnGXPK/RHs0cpPsE1RXUZgSVdwfCpqFdx86lT
	jbKm6JLANDw0A3BqPuu/U81zhW0JwO+0bb6jfyqPevlS0ixJaZpVWRgC
X-Gm-Gg: Acq92OHtZSJgvHFQfMBst0zOu8rLlUChbOY+RHy33e9PAAoZJcmC4xUadIaNEj/CgiF
	prHaRkpTzZn40UUtVHRbZfqEp+uhSqjrXrCj1wP36r6qgcBF2VWInVndZda8l77Tqt99B2w0Znd
	3b/tGqHIG+AOhUerg7b/+YbQwD2hp6O210p29gsPV6ASG73Vcoow7Fg8ABB2dgSL8xgY9w03aGy
	xh2LCz8U8YAd5/G/CR6Hs/GG8Cfyln+hGyokc7RdPTBFzX8BbTJI4uAO/YK+AdcBFiYFjD3nvkr
	9+DPrWH+8c5CzNhgJCUEY/uK0rbY6Bg71Y7bWbJoIc7bMu5c20NWwnnB1o2/C0YhaV6rM5LtqNz
	Zh78TO1Hj4YtGzrGXnd7+fdin1aRgvZ8QVp6PQV9nxsRV5WGXwFhlsKXZL3PnwIyw2fNqVhQSHA
	OBR/TxDuP5Sh9buvaLRLuc7aOKUSGYr5OHJMn/MTTO9dCHE0Bgelz54RlFJO8=
X-Received: by 2002:a17:903:4b4c:b0:2bf:2243:d4ee with SMTP id d9443c01a7336-2bf368021a9mr102681195ad.18.1780280419974;
        Sun, 31 May 2026 19:20:19 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm85701235ad.31.2026.05.31.19.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:20:19 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Jan Vaclav <jvaclav@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Taehee Yoo <ap420073@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net-next v2] hsr: broadcast netlink notifications in the device's net namespace
Date: Mon,  1 Jun 2026 10:20:14 +0800
Message-Id: <20260601022014.1175348-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.de,redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293495-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AD347618CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v2: Drop the Fixes and stable tags and target net-next. As discussed,
    this is more of a behavior change than a fix, and the .netnsok
    commit has been in since 5.6 with no report. The multicast stays
    inside the rcu_read_lock, which avoids taking a netns ref on this
    path. Fernando's Reviewed-by carried over.

Inquiry (2026-05-18):
https://lore.kernel.org/netdev/CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com/
v1 [PATCH net] (2026-05-27):
https://lore.kernel.org/netdev/20260527075924.2707856-1-maoyixie.tju@gmail.com/

 net/hsr/hsr_netlink.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f0ca23da3ab9..eb6d222535d8 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -252,7 +252,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 		goto nla_put_failure;
 
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(port->dev),
+				skb, 0, 0, GFP_ATOMIC);
 
 	return;
 
@@ -288,8 +289,17 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	if (res < 0)
 		goto nla_put_failure;
 
+	rcu_read_lock();
+	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
+	if (!master) {
+		rcu_read_unlock();
+		goto nla_put_failure;
+	}
+
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
+				skb, 0, 0, GFP_ATOMIC);
+	rcu_read_unlock();
 
 	return;
 
-- 
2.34.1


