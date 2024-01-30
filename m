Return-Path: <netdev+bounces-67337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F2842D9F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90981F25745
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B1762CA;
	Tue, 30 Jan 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="2s6U+sKq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04860762CC
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645992; cv=none; b=SwlpFtS7GB/Iv9ClKnfljo94ksjL/3ppp13W26ATP/bESYIsdeegwX5ZHknvMp8B5dWDslY6WZDCDTr10U6UuEVwMxnvUz/eSCY9sqVffjl4nhRuJHF1nxovI4JfBmJr4qSH6THU3tb6cuGPa47jxWMcTKk39FQt2IbtFqJ2eiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645992; c=relaxed/simple;
	bh=dDP0qs8DhKtLjMFYjmLFo4VHMamdrl6xaZ2AkfXYAoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCGUjRcTwJwPye21HOgvkq1UrcLZVWZn6jaxK1pX4snozKtlBWqJfJ6rhWz//3j3X9UZ4+F5NoIw+oldc7PyEAaN2jLrnbWJsT/8jeXy1xdcfyk10iSOKe32YiKIlpNJhjhGVABBqK1k3YyPyc4l3YNgLt+sozvAiiKldNBMjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=2s6U+sKq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d05df82b28so13088891fa.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645988; x=1707250788; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsxS6NRjh94C5E7qE0lZySKxuu+izJy1bIEhTVzYMDA=;
        b=2s6U+sKqyIWITwBZUQbjPxeo01J8APUhWRt9ciEPSuuPZF+LnNK4/sv2guewZSGDwl
         1tmSEiDBMR8q1IolCsxqOnvY8YQy0rC7ZE00GFQ+61V2XGA9HszgIs3yJJK2vIOU63qB
         5DzcXqavdJmx9gYBY6txQHKz2MQy3dfM+HU+iAhGwuTzx4VspH/7JHsTXFT3ZbbGzHyl
         3WMeG6lanKJ+UVFBZOUrBAW2n9WUyB0S3LBjcGOpOTuwtXAqIDS7MlKRwJv/7JwAWEAZ
         DnhHBuRYteFptWwchjygd4vd9Zm3GZs8n1gtOycH0uW/9zWcb9dujml+TIRTP32cs9VZ
         F3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645988; x=1707250788;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsxS6NRjh94C5E7qE0lZySKxuu+izJy1bIEhTVzYMDA=;
        b=TVWqsseZvNcnQu5w5ePGEqiiuZr+NlQComyeNyUi5nnEXGhvnkq1HJtDurdi6NBk+i
         klzim/M4Qlo5ay503XFJqJdkMOCcJITYgUK5itXGPLnDmp/OmvdqrJpuopoM5roDn6R3
         FJqeyMlI5Jqn7fMrpVbfTOmQXffvyJTY2AKIFtm4v653flDBlqwX6ebctYJEWsAM8bUw
         ie2kLqywqnUgb6mzmdVgTsUi332+hWLKIMpc2CaF+IPm/SkJ74wgeBD6mjmOIJlqsD83
         Gc5IOp0Rc0mDDUxX8o1OTYzxM0/eg9EIyGvZ2O7EeDLEu/e8OsIrUxuXpTROwc1eNaw9
         HegA==
X-Gm-Message-State: AOJu0Yx+5CGbvfqHIFjbXEKOXBeC8MIFJ2VqoRhzOoJrpQ6QzADD2Mf0
	y/Abf8qDEFoVDxSvLbUlhYn9DxV84nb2kDDqjsiODIrLEmItnPCzOOD3wMTq0Cs=
X-Google-Smtp-Source: AGHT+IF8GONpbLNPK+lC7Gr5bM7GG2hs5GaIlwvCk3P5ob0qBim2niYmBL22jido4U3k8fFb0UdVAw==
X-Received: by 2002:a05:6512:11e2:b0:510:44d9:ccdb with SMTP id p2-20020a05651211e200b0051044d9ccdbmr294255lfs.59.1706645988125;
        Tue, 30 Jan 2024 12:19:48 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:47 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/5] net: switchdev: Relay all replay messages through a central function
Date: Tue, 30 Jan 2024 21:19:35 +0100
Message-Id: <20240130201937.1897766-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130201937.1897766-1-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This will make it easier to add a tracepoint for all replay messages
later on.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 +++
 net/bridge/br_switchdev.c | 10 +++++-----
 net/switchdev/switchdev.c | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 250053748c08..974cd8467131 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -337,6 +337,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
 
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info);
+
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
 int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..b9e69b522544 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -306,7 +306,7 @@ br_switchdev_fdb_replay_one(struct net_bridge *br, struct notifier_block *nb,
 
 	br_switchdev_fdb_populate(br, &item, fdb, ctx);
 
-	err = nb->notifier_call(nb, action, &item);
+	err = switchdev_call_replay(nb, action, &item.info);
 	return notifier_to_errno(err);
 }
 
@@ -376,8 +376,8 @@ static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
 			attr.u.vlan_msti.vid = v->vid;
 			attr.u.vlan_msti.msti = v->msti;
 
-			err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET,
-						&attr_info);
+			err = switchdev_call_replay(nb, SWITCHDEV_PORT_ATTR_SET,
+						    &attr_info.info);
 			err = notifier_to_errno(err);
 			if (err)
 				return err;
@@ -404,7 +404,7 @@ br_switchdev_vlan_replay_one(struct notifier_block *nb,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
@@ -590,7 +590,7 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 5b045284849e..e50863a03095 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -307,6 +307,23 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_call_replay - Replay switchdev message to driver
+ *	@nb: notifier block to send the message to
+ *	@type: value passed unmodified to notifier function
+ *	@info: notifier information data
+ *
+ *	Typically issued by the bridge, as a response to a replay
+ *	request initiated by a port that is either attaching to, or
+ *	detaching from, that bridge.
+ */
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info)
+{
+	return nb->notifier_call(nb, type, info);
+}
+EXPORT_SYMBOL_GPL(switchdev_call_replay);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1


