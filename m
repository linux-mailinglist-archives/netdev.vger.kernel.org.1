Return-Path: <netdev+bounces-70635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069C84FDAD
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2619B2986C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630663D8;
	Fri,  9 Feb 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="in5uY8za"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB33FC1F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510904; cv=none; b=kXdz+2k0FLG2bc8eJRnizTrwC8tBuDtENHhw7exehpPtvVPmkx0gSzFriLo/laYnGYMUEGxFbKQAKyrI66EvRcFnZxl8XiGc1NISqc9WK4ls1WMjiMk48RZIY7D4JiEd/FqElnEu2ySDbKPvaEv9jsugfjO8zAZiZc+GRehDZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510904; c=relaxed/simple;
	bh=XR6Q3i9lvU+eQ+xyvVUWYrLwt4qXVowyAbQBoCHD+4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9FzYGgvB4vgNgAjPu4ulJ1/65kGc0/xTLueO4829exuQv6Rf+gABkF/yd9yUpBS3xadQ1qb07vYacXelwHbAAqHObRtRQZpTukT8Xj6jdKETxa7/FjvDrSK22eHNbttrcO8hFf4ko8m8hXuPkLmp4zahZpj+ZymgCNFLGhrZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=in5uY8za; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269b172so3178627276.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510902; x=1708115702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=agcEg7RUfKpO7MS3iSdPVPtBV3s90hsiCqWLYe1LlpI=;
        b=in5uY8zaCOE+ccUxMTw5ZO4QT/IYVut1f/oejUn5I60Eg3WU3bcYVqFpFq9MN9pZjs
         CSYpYW0ZMFLOcl4BuiUSASFXTbqIBzDkkegWLJa0DHFaOPcUvpRYgeCRfEIuE8zNPUM7
         pZTbDa5+QEUuOjxMd6TbxZOMHyc0rVt3VFWJSKKURmp+E+zPpxXtLyAvxLHQ+XaNRoCQ
         zHQa7+aNxyi8xzTJUCYyRP4/O58vJyMKwqDP9JrhyXLB5P9mqaVvLTKVEMqi8DgIfkut
         Top7SLeEKdkB00q38zTpyxoJ3QlBruz0JpYLZmXYkiUx2ZEPiszhEAd52iFo2nV6Nx7g
         8FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510902; x=1708115702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agcEg7RUfKpO7MS3iSdPVPtBV3s90hsiCqWLYe1LlpI=;
        b=V15KuAPfy2CjpGBN4TY6JYTbPZvRIKAtavPxqrHKs0qaQq/V7S8V+flOsosJzOEace
         do5CckPgT6HFSZjt7C4P5V59JYWuyI1N6s2+CDNYM/DmvJyzaarxNr8AMGHBaVgiRVo6
         wiI8pGmhI83nfzKJD1J6eKFeSvOi/K1muxAEVkfn02+Ltq3PDw8F/VZ9SHKwu24swbMB
         8FOI0lz2n/8s1w3wQCgJBW+uiZB349rGulyN9Vx9TzwrcJduDSO7XoqE2qYziiXHOkW0
         7uPEcKsRePLgPMnOnmp4DGSh2pvL2n16S8G+CJhdnN9hChq5AZvcI9XedQw58kRJcKjI
         rxIQ==
X-Gm-Message-State: AOJu0Ywg9FF6e/3E4LWB02wODbMDWrP1+pqXgAv/rMEeHknfBBbbUCmB
	tc2SyiryoRFdbD5tGAwfAgAdBGmoK7V4jJVQb639eFkyFO92XfiOeG3F1GPJl+3+4rC3oorzO1G
	l2O+vs1ByoA==
X-Google-Smtp-Source: AGHT+IFYhKIWTxsg5OLW1khbZbvF3B1rIkgaOsEmfLzChZNJLpusPH83JzC8YMG6d9a/Nl6zs5HpvLMEYmxENw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:723:b0:dbe:d0a9:2be3 with SMTP
 id l3-20020a056902072300b00dbed0a92be3mr61361ybt.3.1707510902005; Fri, 09 Feb
 2024 12:35:02 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:19 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-5-edumazet@google.com>
Subject: [PATCH v3 net-next 04/13] net: convert dev->reg_state to u8
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepares things so that dev->reg_state reads can be lockless,
by adding WRITE_ONCE() on write side.

READ_ONCE()/WRITE_ONCE() do not support bitfields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 23 ++++++++++++++---------
 net/core/dev.c            |  8 ++++----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 07cefa32eafa93dd1a4602de892d0ee1cbf2e22b..24fd24b0f2341f662b28ade45ed12a5e6d02852a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1815,6 +1815,15 @@ enum netdev_stat_type {
 	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
 };
 
+enum netdev_reg_state {
+	NETREG_UNINITIALIZED = 0,
+	NETREG_REGISTERED,	/* completed register_netdevice */
+	NETREG_UNREGISTERING,	/* called unregister_netdevice */
+	NETREG_UNREGISTERED,	/* completed unregister todo */
+	NETREG_RELEASED,	/* called free_netdev */
+	NETREG_DUMMY,		/* dummy device for NAPI poll */
+};
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -2372,13 +2381,7 @@ struct net_device {
 
 	struct list_head	link_watch_list;
 
-	enum { NETREG_UNINITIALIZED=0,
-	       NETREG_REGISTERED,	/* completed register_netdevice */
-	       NETREG_UNREGISTERING,	/* called unregister_netdevice */
-	       NETREG_UNREGISTERED,	/* completed unregister todo */
-	       NETREG_RELEASED,		/* called free_netdev */
-	       NETREG_DUMMY,		/* dummy device for NAPI poll */
-	} reg_state:8;
+	u8 reg_state;
 
 	bool dismantle;
 
@@ -5254,7 +5257,9 @@ static inline const char *netdev_name(const struct net_device *dev)
 
 static inline const char *netdev_reg_state(const struct net_device *dev)
 {
-	switch (dev->reg_state) {
+	u8 reg_state = READ_ONCE(dev->reg_state);
+
+	switch (reg_state) {
 	case NETREG_UNINITIALIZED: return " (uninitialized)";
 	case NETREG_REGISTERED: return "";
 	case NETREG_UNREGISTERING: return " (unregistering)";
@@ -5263,7 +5268,7 @@ static inline const char *netdev_reg_state(const struct net_device *dev)
 	case NETREG_DUMMY: return " (dummy)";
 	}
 
-	WARN_ONCE(1, "%s: unknown reg_state %d\n", dev->name, dev->reg_state);
+	WARN_ONCE(1, "%s: unknown reg_state %d\n", dev->name, reg_state);
 	return " (unknown)";
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 7bba4a47231726d666348539538ae94eb248fc3a..7d9d43ce2cb779c922759224e2690e24acda77fd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10297,7 +10297,7 @@ int register_netdevice(struct net_device *dev)
 
 	ret = netdev_register_kobject(dev);
 	write_lock(&dev_base_lock);
-	dev->reg_state = ret ? NETREG_UNREGISTERED : NETREG_REGISTERED;
+	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
 	write_unlock(&dev_base_lock);
 	if (ret)
 		goto err_uninit_notify;
@@ -10588,7 +10588,7 @@ void netdev_run_todo(void)
 		}
 
 		write_lock(&dev_base_lock);
-		dev->reg_state = NETREG_UNREGISTERED;
+		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
 		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
@@ -11008,7 +11008,7 @@ void free_netdev(struct net_device *dev)
 	}
 
 	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
-	dev->reg_state = NETREG_RELEASED;
+	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 
 	/* will free via device release */
 	put_device(&dev->dev);
@@ -11098,7 +11098,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* And unlink it from device chain. */
 		write_lock(&dev_base_lock);
 		unlist_netdevice(dev, false);
-		dev->reg_state = NETREG_UNREGISTERING;
+		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
 		write_unlock(&dev_base_lock);
 	}
 	flush_all_backlogs();
-- 
2.43.0.687.g38aa6559b0-goog


