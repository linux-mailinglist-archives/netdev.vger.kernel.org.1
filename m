Return-Path: <netdev+bounces-286670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOOZLXjjAWoqmAEAu9opvQ
	(envelope-from <netdev+bounces-286670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6160B50FCC9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AD09303866E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5653F7A85;
	Mon, 11 May 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Sdcjyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3B3FB069
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508376; cv=none; b=D4eYzskBvTadqUjCOCdxWDiaWbvfT3Fn2aSJXJ3dmzvh467pncrGM28Lmr9bitkoJjNQhKHVhri5j0qzkTlksvSeI6C0+p7h28c8EBtIfA4kxrK62xf+xe9DVukJxXbpOrHRTOASp9WXRgKbNUCvcdDAWivCqyV/43Gwaqnejp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508376; c=relaxed/simple;
	bh=F+AUqteAfAdB4EzjzusIXVnGPbxMlbEUCD4dKZHK0ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UZr5lf4yU98HMG4YSWtt8b369jhwQ9XivWpRDxCRmlNX2ox60oNoX1LsKS6CmLnehMNBZvhABl5KMod8hVQSwDvRwoLJuo7gewdRF8Usokf0oHsjM0q2cYo8eYP2K2cna20e6Kv/KIWnb+argIsWKaWcxxFxpUmARYlbsLmBegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0Sdcjyo; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ff5472f263so191409eec.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508374; x=1779113174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icORVuvXvQyOwUwE8vDHR4wpbRYBXsNZDnMyIZGl2Os=;
        b=N0SdcjyoVxYK/H9zMm9vpkIv1Ss+4itdbGePbcoSpGVYxjo8IqzqUZPL+4VcBfhV0M
         JIl+3TBjpacaOcOLjBLjIiNzG8sGlyZzTqF5/rZ3fBNVhyC3wWiwheHHa7wgJF/rkkby
         KMcsuVSY3o2JvQ0mDhuk5K44Mvqmp0JH5WeZAmTc1yAXXZhpaHSH2x2DeTesH0jDy6zC
         G9VUqyreVi0wAVI/k8Irzuv+WVyefbLX7Tj2WwXuqxebYhmFN1m8mf0B7Ds3ugwKru17
         JzlGW81x5+vYZesUHdbhacTE48YaAMlXpg3oTsINWiCi945NBdMjfeNzlfb0pFxpnMAx
         hqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508374; x=1779113174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icORVuvXvQyOwUwE8vDHR4wpbRYBXsNZDnMyIZGl2Os=;
        b=dHSmjKhPB5J1s68QpoP9Y6/g+h0x3ntPW7U1dM2mW0mEqZLTfp8wxsVMANpEugwk3D
         Inyaknrw2l2iMIwR9epRUgHbEg3OGmdKh454b+FiPXeHr79sT/DJTNgeFx3V6Q8ySOiv
         mb0lwcoXi0+gi9Jn1c3xXCBkfh5hXlGOu713SkaqNh09CxLDjSXFShunXRnocVh6a6kJ
         FulZwjzoOkIYlVrVU3GsGBQ3GN1vGsGVeta8nLN1GBn/Kg0P45oxWwksCO9F16hjrMkb
         8C5rHkGo/49VD/exCq1rPsQ7qJXmNOlWCMQGzRlZxULq7qn0GQAmR6Xhn01GInlKg7tw
         s6CA==
X-Forwarded-Encrypted: i=1; AFNElJ/fDBPtEH5M0QHK4yyIKeC+ceNxLURAG6c59mk453qBzbTuQxGg2yBM9q8Rg+SRTxxOkz5qUbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONO5BlsPBJ3OmrtLLZ3UfxrykbP0lE4Tm3hFiBMAnRbH+9+Ho
	U3GYe1DUPW3dTjyl8sWEeU7kkFKUBuAYsIuw6039wiZUCZ0YQwhH23qw
X-Gm-Gg: Acq92OFmm/QkEjZa3Yb+1eTgv9oVnMO5KfTbzbmZRxGnbDEgiXekntbF6SwjmLDFxMk
	Rpqtn/djRC6bXZdhkBV1aVAOvVdrZpkSRwS8VwLDnZnPchSVUBqDpegqk0OMcpAjabsqjh9CiCM
	jj5uVHK1SAq6Fh2OXd/fBQvZJG1rEuVFSTpqSNMfS00OYmFaD1l3LA3uloT6jkRPp+D9s1tvsny
	8wsFn63dbc0ecYw5NDJrXh8T5warTfI5PTEsXCGpE4y63eA9I4fXgVY2vWgYnWyAkdEYdOc/nc/
	C097cVeHRipNVXz3ZFxUpLh3/qXAY+dW4d3k2dGJgOOP1SKKODJU4IwjW1EfvMKRQE4MoJFY4r0
	FBVs9b76ThSwL38fR4LOLFaFledVerZWLrUYPEA5vOmkEJURZrodKcTlCKj0GBe/GCm2/wJGeS/
	bW4hcZC/v8vN5CPOe75t+jQQ==
X-Received: by 2002:a05:7301:578d:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-2f5482684a9mr11634929eec.5.1778508373698;
        Mon, 11 May 2026 07:06:13 -0700 (PDT)
Received: from dev-ubuntu.. ([128.14.159.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm16347837eec.14.2026.05.11.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:06:12 -0700 (PDT)
From: faicker.mo@gmail.com
To: faicker.mo@gmail.com
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] net: net_failover: Fix the deadlock in slave register
Date: Mon, 11 May 2026 22:05:51 +0800
Message-Id: <20260511140552.3284563-1-faicker.mo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6160B50FCC9
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286670-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faickermo@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Faicker Mo <faicker.mo@gmail.com>

There is netdev_lock_ops() before the NETDEV_REGISTER notifier
in register_netdevice(), so use the non-locking functions
in net_failover_slave_register().
failover_slave_register() in failover_existing_slave_register() adds lock
and unlock ops too.

Call Trace:
 <TASK>
 __schedule+0x30d/0x7a0
 schedule+0x27/0x90
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x538/0x9e0
 __mutex_lock_slowpath+0x13/0x20
 mutex_lock+0x3b/0x50
 dev_set_mtu+0x40/0xe0
 net_failover_slave_register+0x24/0x280
 failover_slave_register+0x103/0x1b0
 failover_event+0x15e/0x210
 ? dropmon_net_event+0xac/0xe0
 notifier_call_chain+0x5e/0xe0
 raw_notifier_call_chain+0x16/0x30
 call_netdevice_notifiers_info+0x52/0xa0
 register_netdevice+0x5f4/0x7c0
 register_netdev+0x1e/0x40
 _mlx5e_probe+0xe2/0x370 [mlx5_core]
 mlx5e_probe+0x59/0x70 [mlx5_core]
 ? __pfx_mlx5e_probe+0x10/0x10 [mlx5_core]

Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Signed-off-by: Faicker Mo <faicker.mo@gmail.com>
---
Changes since v1:
  - Fix the space chars (Simon)
  - Change the dev_close to netif_close (Simon)
  - Change the label err_dev_open to err_netif_open
Changes since v2:
  - Add lock ops in failover_existing_slave_register (Jakub Kicinski)
Changes since v3:
  - Fix the lock ops implicit declaration (Jakub Kicinski)
---
 drivers/net/net_failover.c | 12 ++++++------
 net/core/failover.c        |  6 +++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..3f7d31033bae 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -502,7 +502,7 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 
 	/* Align MTU of slave with failover dev */
 	orig_mtu = slave_dev->mtu;
-	err = dev_set_mtu(slave_dev, failover_dev->mtu);
+	err = netif_set_mtu(slave_dev, failover_dev->mtu);
 	if (err) {
 		netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
 			   slave_dev->name, failover_dev->mtu);
@@ -512,11 +512,11 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	dev_hold(slave_dev);
 
 	if (netif_running(failover_dev)) {
-		err = dev_open(slave_dev, NULL);
+		err = netif_open(slave_dev, NULL);
 		if (err && (err != -EBUSY)) {
 			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
 				   slave_dev->name, err);
-			goto err_dev_open;
+			goto err_netif_open;
 		}
 	}
 
@@ -562,10 +562,10 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 err_vlan_add:
 	dev_uc_unsync(slave_dev, failover_dev);
 	dev_mc_unsync(slave_dev, failover_dev);
-	dev_close(slave_dev);
-err_dev_open:
+	netif_close(slave_dev);
+err_netif_open:
 	dev_put(slave_dev);
-	dev_set_mtu(slave_dev, orig_mtu);
+	netif_set_mtu(slave_dev, orig_mtu);
 done:
 	return err;
 }
diff --git a/net/core/failover.c b/net/core/failover.c
index 11bb183c7a1b..e43c59cd6868 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -12,6 +12,7 @@
 #include <uapi/linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_vlan.h>
+#include <net/netdev_lock.h>
 #include <net/failover.h>
 
 static LIST_HEAD(failover_list);
@@ -221,8 +222,11 @@ failover_existing_slave_register(struct net_device *failover_dev)
 	for_each_netdev(net, dev) {
 		if (netif_is_failover(dev))
 			continue;
-		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
+		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr)) {
+			netdev_lock_ops(dev);
 			failover_slave_register(dev);
+			netdev_unlock_ops(dev);
+		}
 	}
 	rtnl_unlock();
 }
-- 
2.34.1


