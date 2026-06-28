Return-Path: <netdev+bounces-302373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l75qIaFqQGrcfQkAu9opvQ
	(envelope-from <netdev+bounces-302373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 02:28:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C986D2DFB
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 02:28:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xzv1LjUO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302373-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E84E30103B4
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3916A395;
	Sun, 28 Jun 2026 00:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355049620
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 00:28:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606494; cv=none; b=IdIvIYZWsvZqn4HrNTtoNCdf9HNZGVQLpoXgIyqwIDLd8Kpla+LDRlmCtv/hKW9PaW0L30eJIw/T+uYTgNzgPQAcwJBRgZ88dTz2+Lj+SibLI6EE2ks1f2wsxm3IIM3aHcQfLQlm8wuR3VE1dYTFy4jVmqE0L8hkwl/UY9X98wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606494; c=relaxed/simple;
	bh=ukach6//OujD9p6sL3XrO28ru0ezc2TX7FIoyJAK1To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A71D9u2IqpkjLVAtG7o/iNq4lDGXm5xOFCi0ygcxLuxJM0w5jIxhniZF99t3f1Tt7OMnI6yVsKLID8crmYi7hA1dwH5QPtaxD9ptZbE1ftIKz9jM/PEidNK82opd26AUrEDaWvW9m0l+uz1a+BLBAPtJOyRmJeyVay0gYKmzz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzv1LjUO; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so15552555e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 17:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606491; x=1783211291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Vt5aQ4hA6sI9gKzTAa2Ur+vxC2MjfYGoremwvMSA+g=;
        b=Xzv1LjUO/ViLvu0+GqH0l0zHUESUWka55oU3oXkrjzY4PrwtShfhEa78ZjP/TYtemm
         PRlMwM6lbV6IdzyYEu/om/eL09WIMt8SEhEp7UncSr4X6TyVHhvDOYajl9Wi4jPVyvDZ
         p3OrwWBF41ACf3ZWodW37u5p6lgpgWJFmIbZh/v9P9sTjLRg/kDXSsDuouQs/RHYtx55
         GmF+blWLXs3aGqcFqfYwEKvmLLnEMNTP603MvjbgDwCrMYH4xWKjfueDkKyVTVne9VEl
         JftMEpiqTWpRF1wf/UbqjCih1zFEmm/GEF00OgqW2tVoi2bSZzv1HkMjLDnPpAYOUZUi
         0rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606491; x=1783211291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vt5aQ4hA6sI9gKzTAa2Ur+vxC2MjfYGoremwvMSA+g=;
        b=dvmmCd3tkKvj0frzQLzQKrqVeHpO99Rcc3BXRXAb+xuq13n7lNBJ3JWvFaZfZUE/1l
         35t6o/pI4jLbxMdmTIRnCFn1BaefA135eZt5E+TWd/3rKFGpOoIO7iNEobPQlladyyBE
         8hfiCyGr6lNWgaQezIaoqrGfy/ECOrrQGJFryvAWEw7CtZtfIvbl9/MqvW2pns5Bf9kG
         VodigEgbpwaOUlpQGlBtL+46lGtah9NMjyYz1jnOrS6TwcNZT6W1wWK6DP+lWwEL8TgS
         qS6+xMyo8TVhCSBQi4s/1GyB8yO5KwlHMvOIEjWcckhbz+ceGQsIRRDHp60u+tvRGS5V
         pvHg==
X-Forwarded-Encrypted: i=1; AFNElJ+uRDXbnm/TL9/ldllytYWbpKJ6+8hO5zqo+Z/Mr4++675YPlvbPgwj2e2ju3b6iKrIyYzFst4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZoamiOACSvgd1Lhf1pAOAvGM3rGOk80sP7XvqQ13J1QY51Ot
	1HIXbZ5WXjW1s7KA6XWfdz6Ys65Nnz1UWcOkkKmwHyulOeOU48NukslO
X-Gm-Gg: AfdE7cmdDCTFVFGhv3kWCu+BY9DebQR4Pkxnb0prSCEOUc6t8ybOTp71g22KuAXxMSP
	Vla3rLWrceG3fsTGXRGgcTbyZDCt17MLLZwyEq4UAEQ4BNIVo3JoNEh4Lvy7l6GLsA0HiKqMv8w
	/qd+Mzjct822uQGD6xqn0FHUXFoTlWWJmpwNwsuawNNzZq1obXGSySV7bx1E7i2xb+U7qpez/rp
	z6sxbUZL0pbdCfnkratDzxOSlgFqY0IWAwSUUX75ke7J9Xn/F+nSyLjoikD1fgzxrwUm0laMTgw
	Y7Nac/UwXVQrRm2w88LruyNEZSg2Kc7Jb+CRCAQazNd0snk4pECKUgEtKUQa+oN9OJzktlVvvnn
	gzOJFsSOUEOPcI98BhRPBaFAFTrPQ1ItZfYk4lcZH8rbJOfr0VYd0IOWoj3N2HRRoFAyykBOXel
	Ej0zqwBEzFcZghAhztxFgU2tAHCwm8M+zf7SN1
X-Received: by 2002:a05:600c:6215:b0:492:463c:48b7 with SMTP id 5b1f17b1804b1-492668985c2mr161633475e9.22.1782606491518;
        Sat, 27 Jun 2026 17:28:11 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690100c7sm216713895e9.12.2026.06.27.17.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:28:10 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] netdevsim: remove ethtool debugfs files before freeing netdev
Date: Sun, 28 Jun 2026 02:28:04 +0200
Message-ID: <20260628002804.24214-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302373-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6c25f4750230faf70be9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1C986D2DFB

The ethtool debugfs files point directly into struct netdevsim, which is
allocated as net_device private data. Their containing port directory is
removed only after nsim_destroy() calls free_netdev().

An open simple-attribute file can consequently dereference the freed
private data before the directory is removed. KASAN observed this in
debugfs_u32_get() during network namespace teardown.

Track and remove the ethtool subtree before free_netdev() on both the
normal and registration-failure paths. debugfs removal drains active
file users before returning.

Fixes: ff1f7c17fb20 ("netdevsim: add pause frame stats")
Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/netdevsim/ethtool.c   | 6 ++++++
 drivers/net/netdevsim/netdev.c    | 2 ++
 drivers/net/netdevsim/netdevsim.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 9350ba48eb81..025ea79879f3 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -252,6 +252,7 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	ns->ethtool.channels = ns->nsim_bus_dev->num_queues;
 
 	ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
+	ns->ethtool_ddir = ethtool;
 
 	debugfs_create_u32("get_err", 0600, ethtool, &ns->ethtool.get_err);
 	debugfs_create_u32("set_err", 0600, ethtool, &ns->ethtool.set_err);
@@ -272,3 +273,8 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	debugfs_create_u32("tx_max_pending", 0600, dir,
 			   &ns->ethtool.ring.tx_max_pending);
 }
+
+void nsim_ethtool_fini(struct netdevsim *ns)
+{
+	debugfs_remove(ns->ethtool_ddir);
+}
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 27e5f109f933..4e9d7e10b527 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1165,6 +1165,7 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	return ns;
 
 err_free_netdev:
+	nsim_ethtool_fini(ns);
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -1178,6 +1179,7 @@ void nsim_destroy(struct netdevsim *ns)
 	debugfs_remove(ns->vlan_dfs);
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
+	nsim_ethtool_fini(ns);
 
 	if (ns->nb.notifier_call)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 4c9cc96dcec3..64f77f93d937 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -154,6 +154,7 @@ struct netdevsim {
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
 	struct dentry *vlan_dfs;
+	struct dentry *ethtool_ddir;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
@@ -169,6 +170,7 @@ void nsim_destroy(struct netdevsim *ns);
 bool netdev_is_nsim(struct net_device *dev);
 
 void nsim_ethtool_init(struct netdevsim *ns);
+void nsim_ethtool_fini(struct netdevsim *ns);
 
 void nsim_udp_tunnels_debugfs_create(struct nsim_dev *nsim_dev);
 int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
-- 
2.54.0


