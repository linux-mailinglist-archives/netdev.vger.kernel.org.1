Return-Path: <netdev+bounces-70254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB384E2D8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CA1287498
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406E78B54;
	Thu,  8 Feb 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQ4Zq4yd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7A78B74
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401540; cv=none; b=TKR28+xKVM96fRgLMfBogLxPWwctUBBvcdQSTekJ/nxjy/W3fkY0lKHb124Gk/GS1vkHqbedB6cy6IjpDHYju4JqIzLRJTbyBDSoadNSG/14l/h7dboYQGooxsCYhlFTncvHqQYSetc/S2T56FI83hC4m5ZDUa/FCDiIn0uCDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401540; c=relaxed/simple;
	bh=KmLHO+HL/fa3SLPbI9KG8FzT8dHpErT1Cx5ii4zb/0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hFuU5YTG0pf90JwXWHIOhOgbByP6VgCQVUrbDM/2GnMXylub5uWFXo/dgUp5Ap/95tKorsBjc61ZZJb142sSYQ1RUYXmTZj7nLJsi2hlBYoEyyZBMD2v7GBqiKVjzYsg8qHd+x07BjhxCIlWBMYbS/mciMcMxvx89AZ1qhg5wPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQ4Zq4yd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6cd00633dso2679761276.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401538; x=1708006338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsTKCr6CY2ttUGWultr+DccJc8tHsXi9+4ztlvRQG4g=;
        b=LQ4Zq4ydnbgk6fM7yXlC3PJMK01Dgl6PuF0SF2w8xYM1//nNVpG6Vk+yGsoWe1SCV+
         8ikDd6vMHC6dvBXegBaWt68+T5w812+vGUqiYKu1enXkj4NtUOy+eaekRZjbXckC3Wtf
         BXpzWDQ/gK9P/AwUXuwKiPJ14vUvUnrYM3Wfiu4mluoaNnCKbkEXSxqCfpCJQqc/zu1D
         a9pR0xu6gJq7EDSz1iRLH+h6p5c0/cahJc2m8ZFNcu0pYFVJOCA+9w5jVThNIA2z67es
         8ibwkjyt8M8IQ4+Z31fRFNFCIUQnm/7L0hdJiiiyzfUXAAi1Rr0/XHb3TzwWk88qOhqU
         O1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401538; x=1708006338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsTKCr6CY2ttUGWultr+DccJc8tHsXi9+4ztlvRQG4g=;
        b=KoigZoPQBeLY4XIU6x4fr2r2Bt4nUmml1kXAgY4KzUQc+1iZRA/6NcVpiyM4obM9TC
         jyHeUJSqqk+JUlLax7z3uzg0t0US8GQXOKbB+UmDFjO7M0ICrUrD9211C02B+Vt13Q5E
         KCpX2rsBICNRvOEB4V2b4F7/l7Hkd4FU/KVWGA5m4HXQgmX8wTMmtt3L7riSFjucndWS
         rhnIog2f5kaXDGyLxHuA0TmLsfugkzPz9216P3lP1ByV+yaTHM1b1AR3MtVrvARssfIP
         pXaVrpYxOfPhi7NY0IQ3VjXECuEBwfCB8HXvXrQNqcV9z9TAMuedOUExSwfjd9K6T4Go
         aKyQ==
X-Gm-Message-State: AOJu0Yyz0BOtXPKvyZh+czlhCwmKfSz+IN+fllv6Cvcs8mGE5ENy/q0B
	TydMXvsB55Xb5iTTkzssmMeLuV9pwBm9u+FCiXv+1BHUL+ovDX7Q26BhfXIu9AgKGvgaiUXbzk9
	sgKN1+n6zVA==
X-Google-Smtp-Source: AGHT+IH5Umztw8PibSKV3ZfITRo3BEWTQI1QD4rmyhj1rA91frw35/ZKXfHusQFEEF3+Vp6jgPrgygwMCrOh8A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2512:b0:dc6:f90f:e37f with SMTP
 id dt18-20020a056902251200b00dc6f90fe37fmr323187ybb.13.1707401538278; Thu, 08
 Feb 2024 06:12:18 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:45 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/13] net: convert dev->reg_state to standard enum
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepares things so that dev->reg_state reads can be lockless,
by adding WRITE_ONCE() on write side.

READ_ONCE()/WRITE_ONCE() do not support bitfields.

v2: use a standard enum, so that try_cmpxchg() added
    in a followup patch will work on all arches.
    ( https://lore.kernel.org/oe-kbuild-all/202402081918.OLyGaea3-lkp@intel.com/ )

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 25 +++++++++++++++----------
 net/core/dev.c            |  8 ++++----
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 07cefa32eafa93dd1a4602de892d0ee1cbf2e22b..5f138025d5f189cd5ab7bb0434205b66d30e60e7 100644
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
@@ -2372,22 +2381,16 @@ struct net_device {
 
 	struct list_head	link_watch_list;
 
-	enum { NETREG_UNINITIALIZED=0,
-	       NETREG_REGISTERED,	/* completed register_netdevice */
-	       NETREG_UNREGISTERING,	/* called unregister_netdevice */
-	       NETREG_UNREGISTERED,	/* completed unregister todo */
-	       NETREG_RELEASED,		/* called free_netdev */
-	       NETREG_DUMMY,		/* dummy device for NAPI poll */
-	} reg_state:8;
+	enum netdev_reg_state reg_state;
 
 	bool dismantle;
+	bool needs_free_netdev;
 
 	enum {
 		RTNL_LINK_INITIALIZED,
 		RTNL_LINK_INITIALIZING,
 	} rtnl_link_state:16;
 
-	bool needs_free_netdev;
 	void (*priv_destructor)(struct net_device *dev);
 
 	/* mid-layer private */
@@ -5254,7 +5257,9 @@ static inline const char *netdev_name(const struct net_device *dev)
 
 static inline const char *netdev_reg_state(const struct net_device *dev)
 {
-	switch (dev->reg_state) {
+	enum netdev_reg_state reg_state = READ_ONCE(dev->reg_state);
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
index c0db7408fa9f9a3ae9b5b83d34b50663604a5f99..89dbba691c9db83102d15074b6ea96312689be10 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10268,7 +10268,7 @@ int register_netdevice(struct net_device *dev)
 
 	ret = netdev_register_kobject(dev);
 	write_lock(&dev_base_lock);
-	dev->reg_state = ret ? NETREG_UNREGISTERED : NETREG_REGISTERED;
+	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
 	write_unlock(&dev_base_lock);
 	if (ret)
 		goto err_uninit_notify;
@@ -10559,7 +10559,7 @@ void netdev_run_todo(void)
 		}
 
 		write_lock(&dev_base_lock);
-		dev->reg_state = NETREG_UNREGISTERED;
+		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
 		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
@@ -10979,7 +10979,7 @@ void free_netdev(struct net_device *dev)
 	}
 
 	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
-	dev->reg_state = NETREG_RELEASED;
+	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 
 	/* will free via device release */
 	put_device(&dev->dev);
@@ -11069,7 +11069,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* And unlink it from device chain. */
 		write_lock(&dev_base_lock);
 		unlist_netdevice(dev, false);
-		dev->reg_state = NETREG_UNREGISTERING;
+		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
 		write_unlock(&dev_base_lock);
 	}
 	flush_all_backlogs();
-- 
2.43.0.594.gd9cf4e227d-goog


