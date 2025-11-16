Return-Path: <netdev+bounces-238952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A6C6193B
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8788A4ED5A9
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2111A30F944;
	Sun, 16 Nov 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFPL9+Mq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EE30F93F
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313261; cv=none; b=AIHRYUkk34YuOZTCpavsR630w9URMCEYYiCNU+TwKmGl4dduoKClfrdR/loJRNdJm9zVdKUpaY2wl7OOy15VrtAnTaaoja+gDqAhP5owoZnICgAX96WM6eza7y6pDyHOpRYN0kJPLFerQtTu4ahq9A+RKvrFlp/0GtP+hEvzSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313261; c=relaxed/simple;
	bh=460Otk0eYLOBQe5n8jsdt5eu5Fafrt2266A8G3HE0cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbP/3NvdWHOfeBxoQgkXfBgxS+qq1WrVkhTiuJAeltOEqHdrodozU2dKcTEShK7j8t01YepcImLWsLVJKXbasWok51TWij3yWM9ZDDtwQotrfdlb+zEGHsq4fh7Ch3LPlZViMG23oGRdbO7Zb9Ker9CTUwwAoKkCkLueGlZnKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFPL9+Mq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a637712so6738095e9.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313257; x=1763918057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+8nDgOH9ap03TaeT/Llb/5RzbyThgcaKGFiGWwimp4=;
        b=PFPL9+Mqnxvpw2pCM/67w1ELFM7N1MeCSwlO1N4Xsacve8SIHsCa+0wAe2KMLNRCPH
         MoGgxKIjQBLTuDosaVuPTQXmMKCVJQ6QdMJ1V9YuLoafwJcT7C8xjB670A4BoRCReh91
         5qCdVWUYnm54XhEAqC5LcZbHSYKM5LAenz76P1kVCBO9cLDI95Xl2qakkkwdnf9JWC0W
         uagEtsW4ek4/bikZRK7/9otavOsCaNbZou26LlFZNNgNAAwwbH5MFKlhwc0AxwqVXJVc
         kgTUE9Isl6mjMxjT1Kl0gDDecBbVXpVTdrGdDUpJlcnpzMtRw84ys9Hdj2eoVh8S2hT4
         dOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313257; x=1763918057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+8nDgOH9ap03TaeT/Llb/5RzbyThgcaKGFiGWwimp4=;
        b=V6owq0rygK6EQ/rvPyNfT1hTVFqq82TS3ZNlE/1wQgHcShezSKRlQLHvkfgVi43azz
         4eF9+mxnnim8w/BXiuQAftt7lP2BzeSRlDfOJXwlDDHUkUV1zFH2UKextO5/NUo9cemL
         fCY2fAMrxsbWxSFvRMqWXIamVXHY78T7SbbzdKc+1yScMZo8HH9Kb2qUBHRhBu9xt917
         lgbkvNSV+BkKSJavvFc7o9Or58dz90iK9xCaITs34lfTCLH4XDGXFjesyG52TSHeHJyH
         9kQYHzK41NIhpE9DYwGlxCojNl25bohPR2QipB1XbK6h22XRWD03vfsEkVPG+9q7/734
         2gWQ==
X-Gm-Message-State: AOJu0YzG8r/Jgpb3zjZpwyXdv0f8YYeX+y02QspfZkllWT+2K6E1xOm4
	IUjoi/DAnTdn/vzGhjl54YvXk1zg8R/fXwtevUi9cN9mSj5O3y8oZkdS
X-Gm-Gg: ASbGncsMRsTtN4IsoOy4lp0wcrZB3OYYmUbqZylJwwmdHQ0AiJvPffOrUClfmfJJpug
	+z/+vlSYvk1/3f9YRf6uuzGnQ237K7+nJyXRTEMTvehkdDKYzG05/U3NXur9ytjeGaY8R+aZdwk
	1Mb6zcn287oW96Aob+l4PS9JbVf7czCZBtsUiUb3r6H+ekYp2mD0/fimkNG37rMphdN3AHElvaI
	31FlsRh/9ubrXob8E2NGg/zefdGsbq8RH8R6+qWviEMAMkCehunl3KhfUFg7UxGPJX1Of9S3X1E
	oPnASNJmoERlwKQJ1uPsT/ay9oiema+Nzg00CgUix01jWZxjZx67jwJVn6UrU3Xu8mwm24kAjP3
	9bkH0PoTOwQF8NukylNk43b6rAkmLQLAD45W00N2Nenwu1ARYuiQ9nz5dFhy5+UTajgnsRAhtbx
	BVUxY6sMhHVdQT7vCmbAy349PRfg==
X-Google-Smtp-Source: AGHT+IGK0rAtMtP6hsyUp9naDX0gb61WIUxqt3FZA3VMgbYKJWFNkqUjmzpMgqUlSvpS3r54c3sCww==
X-Received: by 2002:a05:600c:c83:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-4778feaa58fmr88355385e9.34.1763313256458;
        Sun, 16 Nov 2025 09:14:16 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:15 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 16 Nov 2025 17:14:04 +0000
Subject: [PATCH net-next v4 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-netcons-retrigger-v4-4-5290b5f140c2@gmail.com>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
In-Reply-To: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=5456;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=460Otk0eYLOBQe5n8jsdt5eu5Fafrt2266A8G3HE0cs=;
 b=NcSaQKOVCR/gsjazYAkiddvDuHd2P8FgRdD/zscLpWEgP0cZCyevhm4GZ47MTLQ98CDgR1bK4
 DjHs6Ql7+GRATqfvF5e/1xo7m4vp0OfuixIXO2hW+bfAOwoiB2JyZ7+
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
 drivers/net/netconsole.c | 81 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5a374e6d178d..2a5c470317b5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,10 +135,14 @@ enum target_state {
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
@@ -1445,17 +1449,75 @@ static int prepare_extradata(struct netconsole_target *nt)
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void maybe_resume_target(struct netconsole_target *nt,
+				struct net_device *ndev)
+{
+	int ret;
+
+	ret = __netpoll_setup(&nt->np, ndev);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+		return;
+	}
+
+	netdev_hold(ndev, &nt->np.dev_tracker, GFP_KERNEL);
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
+/* Process targets in resume_list and returns then to target_list */
+static void process_resumable_targets(struct list_head *resume_list,
+				      struct net_device *ndev)
+{
+	struct netconsole_target *nt, *tmp;
+	unsigned long flags;
+
+	list_for_each_entry_safe(nt, tmp, resume_list, list) {
+		maybe_resume_target(nt, ndev);
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
@@ -1475,6 +1537,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (event == NETDEV_UP && deactivated_target_match(nt, dev))
+			/* maybe_resume_target is IRQ unsafe, remove target from
+			 * target_list in order to resume it with IRQ enabled.
+			 */
+			list_move(&nt->list, &resume_list);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1498,6 +1565,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			dev->name, msg);
 	}
 
+	process_resumable_targets(&resume_list, dev);
+
 	/* Process target_cleanup_list entries. By the end, target_cleanup_list
 	 * should be empty
 	 */

-- 
2.51.2


