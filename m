Return-Path: <netdev+bounces-304283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSlJN/7pRmrOfQsAu9opvQ
	(envelope-from <netdev+bounces-304283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6636FD478
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HHtKaPC4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304283-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304283-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C918D3031336
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35564335067;
	Thu,  2 Jul 2026 22:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1F3D25B2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032117; cv=none; b=ihMdoA30qvwvvB7B5K4WtO6I4uR8vZFh7h3GTLuuWYwj/u+ox+i5+gzAAvANmqmXTnBG4oefvvxAzJqkpM80KegQeSEaLJ7NxvEJmdMzOoa8FMJw2uwM2Asb0KNZmfeKi8gkjl4HSCJikDcnfhslkjixi7WEhzGRS7yTfqedICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032117; c=relaxed/simple;
	bh=EbDXHwZhKWezlvHibLxaPTBKS4CLC+lVVYHUqlY3D6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC1IhZS9401FLbznwceQ3uqmzBpOulgBPXJjA292VyKXR2tUia85hQf9+v3hfnMHY7ovNmXZCl3YhuuxFZbaI+gEc07klQHBaTWnBwHwQciNi8CE1BG1rCgkrGSJQW6oMnVTSwHwwWsJs8dwOLHiD7CgWK+PbmdjSpau1ITf6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHtKaPC4; arc=none smtp.client-ip=74.125.227.129
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabf1f1051so2082905ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032113; x=1783636913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7upDWRqYnMkDp7WGbybswVJOmwtvnZhv59i8fe7oAhk=;
        b=HHtKaPC4PkOMIYLJAxJ7YYzoCU/eYSuA3eSZiVXcUlQ3jzxCs7NRgn9sZOolY3VayD
         8p/b+e/hSfZ3aLpRNs+DzCxDe5PiGvii+6eZsAwoKnXBYpjZvHa58AEGbCY2zbvOwx2f
         MzVSIN1R/ibOsBlts2oGKxM5WZ8AdyIDf8dIWhCC18lca2S6Z6QhHTZIpk6PxAkhJVro
         2wRRsfftzBZ3dsulnWj4cD9F7VpZZ0qG3bswXzn6CHPF05duFF9iVlYHSPKvBqVlWgvm
         ra952QNRHqmN1XNYrOXjDDMrhzL15z+yd5dj4L50WAAqOLTqFq2fnDBZV3sUzv5naEAn
         8Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032113; x=1783636913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7upDWRqYnMkDp7WGbybswVJOmwtvnZhv59i8fe7oAhk=;
        b=AQbnLPEJPfhhTmtzXl4t06BDFOOCdMJr2a3zm9Koj8zUrXmlEIGoUVMJwjbfDxkXur
         jdLdl9sM5trUXQ/PjppS7QxAefhdy6DB9nPWVQCnooC+Bf/t32JyEePS19esnoeEjjnC
         PY/CZfhoQjC3/tMWl+PrTEAuEX9+Ei0zLK7jkxCVpypZZCwnl07hvaH8YWtsFCjpMA06
         mr6zuYvOqdJul6t1DKMxbu9Del1aCC7d0ZpX3cUxjkK2ORhb9Ym0x7tqQdIZRfoWRwM9
         7KiH0PPHewAdtSFDkbXyK4gkTmo4ZoEbpuz03w8X1AWaZfOETfmtiZwtTtZlC06KZ8Ps
         iSqw==
X-Gm-Message-State: AOJu0YzkNGooSsJmhac68LyaYspoJ5Q9AnBvilrm5YJqojdBIBce/rdn
	yIhLsBxgBrqj3p2NV12QlHOdKGFkqrmaKpivwEeOpG7BziWs4bpZBbI1/TC4C7VX
X-Gm-Gg: AfdE7cmaa4uVzzDe6EcmdklQ03c9cWQg7YyDQCtF19DwelaxMcqxqvcutfSoXvWSy25
	LqfnpYwAWQWlFGFwQkCZ1C5So8h+XjLBys18cU6ll8Zze7STtUQTQ/M5SW1Hss9sGYx039U9yQK
	enCk2OET1w2nsP43FO+ufYkkX5s+Rz7PbB6Q5va/BoJhM3H01uBDt8p1KV/laSXvONeIdLs9dLp
	u31Kd2nTWALzum8t0GnmFW3oJOxlyFnh5kLb1gH+Cjb/0TBsEF4U0VT7E2B0iRFZQiq7F71MY0u
	rpPG01SG8rq1CCTwTdFENe2160/fWWZrjj7yMdFCreeZNCnQC8pD4FB3sXXtAgSdmJsq66QZ/xm
	+2qw8iHJqaOfUaZ3eOJcsYmTuIfhN7Wko+sR5ZVHfh1JJh6BeEoEk8cOP9tffUXT8lpskeXSaWi
	wXDBnjcQ==
X-Received: by 2002:a05:6a00:1c9a:b0:846:2f3d:6259 with SMTP id d2e1a72fcca58-847c51d2a31mr6795627b3a.57.1783032113338;
        Thu, 02 Jul 2026 15:41:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb7933e1sm1881989b3a.26.2026.07.02.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:53 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 2/6] net: dsa: hold instance lock on close-on-shutdown paths
Date: Thu,  2 Jul 2026 15:41:46 -0700
Message-ID: <20260702224150.3730033-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
References: <20260702224150.3730033-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304283-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fomichev.me:mid,fomichev.me:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A6636FD478

netif_close_many will soon assert ops lock (for locked DOWN/GOING_DOWN).
Update dsa_switch_shutdown to manually grab and release the ops lock.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/dsa/dsa.c  | 20 +++++++++++++++++---
 net/dsa/user.c | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 9cb732f6b1e3..da53a666d4b8 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <net/dsa_stubs.h>
+#include <net/netdev_lock.h>
 #include <net/sch_generic.h>
 
 #include "conduit.h"
@@ -1620,10 +1621,23 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
 	rtnl_lock();
 
-	dsa_switch_for_each_cpu_port(dp, ds)
-		list_add(&dp->conduit->close_list, &close_list);
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		if (!(dp->conduit->flags & IFF_UP))
+			continue;
+		list_add_tail(&dp->conduit->close_list, &close_list);
+		netdev_lock_ops(dp->conduit);
+	}
+
+	netif_close_many(&close_list, false);
 
-	netif_close_many(&close_list, true);
+	while (!list_empty(&close_list)) {
+		struct net_device *conduit;
+
+		conduit = list_first_entry(&close_list, struct net_device,
+					   close_list);
+		netdev_unlock_ops(conduit);
+		list_del_init(&conduit->close_list);
+	}
 
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 8704c1a3a5b7..8ea47444d6d5 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -13,6 +13,7 @@
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
 #include <linux/mdio.h>
+#include <net/netdev_lock.h>
 #include <net/rtnetlink.h>
 #include <net/pkt_cls.h>
 #include <net/selftests.h>
@@ -3600,10 +3601,24 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 			if (dp->cpu_dp != cpu_dp)
 				continue;
 
-			list_add(&dp->user->close_list, &close_list);
+			if (!(dp->user->flags & IFF_UP))
+				continue;
+
+			list_add_tail(&dp->user->close_list, &close_list);
+			netdev_lock_ops(dp->user);
 		}
 
-		netif_close_many(&close_list, true);
+		netif_close_many(&close_list, false);
+
+		while (!list_empty(&close_list)) {
+			struct net_device *user_dev;
+
+			user_dev = list_first_entry(&close_list,
+						    struct net_device,
+						    close_list);
+			netdev_unlock_ops(user_dev);
+			list_del_init(&user_dev->close_list);
+		}
 
 		return NOTIFY_OK;
 	}
-- 
2.53.0-Meta


