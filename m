Return-Path: <netdev+bounces-240758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C1C79117
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D95B3362D19
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1A31578E;
	Fri, 21 Nov 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biaJ3Diq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007B3242B0
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729387; cv=none; b=Se9vcREXZ3jQLnPVwNydZ0gObgYyxHBH9yuBPjItz+MFYdNHHm2KODYnsekZ1/uyrzmD0LQ6rNWfNIJY9btXxidbeP4JrA7Cd0CwBAcAo+B72taB6DoWtT7pUB9+Qorsm4hFotIAcIdFFpNaf/GuER+ozM5Q8d6g5qAg3Zhm4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729387; c=relaxed/simple;
	bh=tIo1ihv/ZyMpAJc0ot8C6fX6nMW0iP+Uvvhx7LuMZ44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tk4aP+XP/MX2bbqGd2AU3rHZH9ostV4ovmZMjxQKc/mQcGCa7X+bR2wXUA+ECrGyC6/O7EeTHRPsDGKcEynb4mLM+1qmW2wBsQDLwwiQeWO+4WEpXtOGmP60Kpp/OV8+JFTI8r4gZauJOEo/SIqb/pRAzgASn64jPlWXrQ24znI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biaJ3Diq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297ef378069so18505575ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729381; x=1764334181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twzFm4emRBl3ugSRkzw7asEAUSM3TYyx9FDMT6PC5iU=;
        b=biaJ3Diq33bHMFmJwPDdugQqnVcldmHj48SUpkGwP9cBX44kelo4J1SpeohSiLeKN1
         5JP7JKp82cFDgnmJy6a/Bexhz251IjPCgiVpbosuUr0W7V1VrXb0V+eXQ7SCeSOdacYb
         sspm+WvmMXjfk7l4RKXGaymwPuKH+hG0/mP3SiL3kax5v1UiUSQyrYON9alrJ31C9D5Q
         pGYQk7LYdHIGtrWxPQphC9rrwtKmOS0psMuPhXDczITVzj1+XWuJOfJWCZlzPlJm3dQK
         /FOzAuLlkBxPk1dS28kCbIUI0ege9tC1tlyh9HjBn1BPTIX3CAbTc+w4ETYLxv1CrSrU
         0zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729381; x=1764334181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=twzFm4emRBl3ugSRkzw7asEAUSM3TYyx9FDMT6PC5iU=;
        b=I1Zk09RWG70+8H557hbylseKyxoioQLhSWrOdnhxH8KuArhpWMHzqwzLKpN88hYw3n
         d0L+nU91pOLfDwFDfmHkEt/321sUBuZl8rd/adrs1z3Aoer6HH2imGBm4F/wMcUeEZB8
         OAYKQghj+9Pm/yOwOsepYWuAwyPYVigf20r8qLOnhu5hr8hFlkKfrXRUZtHCgZqOGkoc
         a8YoKPTMM3axNUNbF1i04zqkPz+X0/rkGrGqrb6gCTkD29xPcfjxBjy4tQKyQeNtVBb7
         w5UrrG5I7ZDoDoY0/i3SW+fN4E6DXXq+wJrtgKHnEbcutl5WlUSbNWFbt30fw7NaZla5
         4vMQ==
X-Gm-Message-State: AOJu0YxJzCScnf/C0kc/sfJW7BcHzu2oCV3+rwUxNPxDu799EDN7yIdM
	MdWArdoAvOG9i4dims89aW7pjSBICCA1ri4kfwwCSRHiOpb3J1S7BkabXQ/aN5WC5q2QCtj+
X-Gm-Gg: ASbGnctrjOA8VWmwL5M/1FQXg7IsATwwSJfOE8aoOosV88fzIpFR6L+I6sh6SYNUXQi
	0sn/esbAd1bRFq6U+AuPV2Bik/WK3e8pdhKrQeed8o5Mrgr7WKtgHHSyG1bJF70u2JbWE4ygNva
	A7V+9sFYefIrHGhyp8tlHdutqPxJmvIDYBa+fbUAAno5HTdD1QYRDJb4l40kdRCEEpv2Bd+eGmZ
	Nx9g9F8OM8GEVgZZPlXMXpTyu8e1CGMc/+TFeHthg9U7OERA9AV164v0eIamj31Y4G9wrme9hNK
	xNQb1Oq1JqGub8mPKl0atS4aRCgJPqVdiLzYBey1a06Ahf6kQlJ1CcJPtzRf0pqoWc3ShzC5Js4
	I/dcSTJkkaFznnjUyxTI07Qn1ZnsRg2K+6FJiqUYUEnOkUtT1j7ZKzFyZ3wlvVHv6LzgWdVSyUB
	jQsQfwdc6/K2o0+HPyVgvb9QieKco=
X-Google-Smtp-Source: AGHT+IGj77Q4G5JSki9S4sZ8Icq5LKswCcfsVmzZ4PWYrvCxJ5l+h8U/aERHvy3ALA3r4RXKHnDHxA==
X-Received: by 2002:a17:903:3c43:b0:298:d056:612d with SMTP id d9443c01a7336-29b6be94938mr22324195ad.9.1763729380475;
        Fri, 21 Nov 2025 04:49:40 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:38 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:03 +0000
Subject: [PATCH net-next v6 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-4-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=5495;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=tIo1ihv/ZyMpAJc0ot8C6fX6nMW0iP+Uvvhx7LuMZ44=;
 b=zbjtqpOX9o5U0GkqJgVJlnbHBLhjIh8nqad7fOQ13wlXV4HAGAD3T7HFcOXghvJsZwDvVE4uv
 XHLHfN1MMLnCLFshp+OlsI00UfQVVS6yuuLys9obU7n97H0nwS2Vgwe
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_UP event is received) by calling
__netpoll_setup on the device.

Depending on how the target was setup (by mac or interface name), the
corresponding field is compared with the device being brought up.

Targets that are candidates for resuming are removed from the target list
and added to a temp list, as __netpoll_setup is IRQ unsafe.
__netpoll_setup assumes RTNL is held (which is guaranteed to be the
case when handling the event). In case of success, hold a reference to
the device which will be removed upon target (or netconsole) removal by
netpoll_cleanup.

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 82 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..2dcdfb44a9e0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -138,10 +138,14 @@ enum target_state {
  * @stats:	Packet send stats for the target. Used for debugging.
  * @state:	State of the target.
  *		Visible from userspace (read-write).
- *		We maintain a strict 1:1 correspondence between this and
- *		whether the corresponding netpoll is active or inactive.
+ *		From a userspace perspective, the target is either enabled or
+ *		disabled. Internally, although both STATE_DISABLED and
+ *		STATE_DEACTIVATED correspond to inactive targets, the latter is
+ *		due to automatic interface state changes and will try
+ *		recover automatically, if the interface comes back
+ *		online.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (state == STATE_DISABLED).
+ *		runtime only when it is disabled (state != STATE_ENABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -1430,17 +1434,76 @@ static int prepare_sysdata(struct netconsole_target *nt)
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void resume_target(struct netconsole_target *nt, struct net_device *ndev)
+{
+	int ret;
+
+	netdev_hold(ndev, &nt->np.dev_tracker, GFP_KERNEL);
+
+	ret = __netpoll_setup(&nt->np, ndev);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+		netdev_put(ndev, &nt->np.dev_tracker);
+		return;
+	}
+
+	nt->state = STATE_ENABLED;
+	pr_info("network logging resumed on interface %s\n", nt->np.dev_name);
+}
+
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
+/* Checks if a deactivated target matches a device. */
+static bool deactivated_target_match(struct netconsole_target *nt,
+				     struct net_device *ndev)
+{
+	if (nt->state != STATE_DEACTIVATED)
+		return false;
+
+	if (bound_by_mac(nt))
+		return !memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN);
+	return !strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ);
+}
+
+/* Process targets in resume_list and returns them to target_list */
+static void netconsole_process_resumable_targets(struct list_head *resume_list,
+						 struct net_device *ndev)
+{
+	struct netconsole_target *nt, *tmp;
+	unsigned long flags;
+
+	list_for_each_entry_safe(nt, tmp, resume_list, list) {
+		resume_target(nt, ndev);
+
+		/* At this point the target is either enabled or disabled and
+		 * was cleaned up before getting deactivated. Either way, add it
+		 * back to target list.
+		 */
+		spin_lock_irqsave(&target_list_lock, flags);
+		list_move(&nt->list, &target_list);
+		spin_unlock_irqrestore(&target_list_lock, flags);
+	}
+}
+
 /* Handle network interface device notifications */
 static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
 {
-	unsigned long flags;
-	struct netconsole_target *nt, *tmp;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netconsole_target *nt, *tmp;
+	LIST_HEAD(resume_list);
 	bool stopped = false;
+	unsigned long flags;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
+	      event == NETDEV_UP))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1469,6 +1532,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (event == NETDEV_UP && deactivated_target_match(nt, dev))
+			/* resume_target is IRQ unsafe, remove target from
+			 * target_list in order to resume it with IRQ enabled.
+			 */
+			list_move(&nt->list, &resume_list);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1492,6 +1560,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			dev->name, msg);
 	}
 
+	netconsole_process_resumable_targets(&resume_list, dev);
+
 	/* Process target_cleanup_list entries. By the end, target_cleanup_list
 	 * should be empty
 	 */

-- 
2.52.0


