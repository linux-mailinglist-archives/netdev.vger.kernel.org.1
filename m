Return-Path: <netdev+bounces-69842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A855B84CCAC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635F21C21268
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545657E56D;
	Wed,  7 Feb 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/75g602"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230E7CF14
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316003; cv=none; b=U5ybfdIc1T+We9Gz2SMlLYseEuujAF8W1PUT3d0gLYE9w7ep/0IRsz71elMW7HAniN2W6XKVD7qJxDmYBAGulRceCi3I9xauPuYjtIgryNQMvr2HTZmpdDoND41LxWju+GhCWzAL82kl0XOl9J6NkqFbg3xWDT3t4Q/2ubxsf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316003; c=relaxed/simple;
	bh=iKeXnvQd0BNCGxSfGrwTf4bm+nHFmvpTgh8xqNNbc2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BdsEg3HWCCOZW2X6sh1H85erVzH9cSUoYtmgoAdHxIM5JfGLa303XbQgkUw7DIOjZYqkbE/JCCHii7ql0BlspC4AmyG82jUtCaOZK76IiQJ/c2O1nznNqQSct3qePX9dQlOfvFVKfuhHQ5VYDZRxth727PMYh8VYz8FG3OnlOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/75g602; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6bad01539so892535276.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316000; x=1707920800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4yYR4Ow9u9RBP+h5D5648K5t5UOdRTxXm/RiBeaOrM=;
        b=x/75g602xgonW+10JqcohCXHn7tZgaAgPr5xZMKYPziq52KnCvBWuw2vB8J5hp8hJk
         DwUu40Llwk82wK261DEHr8Akz2qNTZnRVn8M+9xsIfKC/PQmMdpLxQ8WLDjYTyik2Bd/
         +X+fdQpR8lYCnj5uMHqcoUdslssXCJOMReNPHorxXr+kpbki+ugj0YlP3RIBzrLdid8F
         jG2R1JqaeAcFq6Tzo1kVMKkSnPYYFWbaChjJNqZRKV2t5f8JuARUPi6gy17T7erkmTqM
         hUsgcqOrw8jngRhlXPFhKmTIqbhPw068+j5sSSRYEottGrZNrEShNbClKZdwWFCyN03r
         SVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316000; x=1707920800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4yYR4Ow9u9RBP+h5D5648K5t5UOdRTxXm/RiBeaOrM=;
        b=GOwpMe2MJXrDBxydZSaQDiZKmKBqsHJLWUOVjgXVge9gwp60n7WN7QOj9UqUp4wgJm
         cGlwhuW/YZP2uBRFuwDgDOAv9yV0RRjQ98Ag5hCVkpOOvFfu19DAyKMCQN+Ji2qL7dPT
         omNNc9Lo5EGtjOmAXIygoun9siTQmKADQoMCXib7CaxGm5E9S6bJo16+x79HegdzBPyy
         y3rRHuvR+cyobzApsTAC+VWjxLUse/a1QsyPhispRumahQRjlQlCbGv0KHw1mZiUz6OQ
         iPq/aMjOj54JiWl2njIK+Cgk/8ci//XWKOqY80N6oMf2U21oVcFem7xxpaxqz6Cj/ZHK
         4QXw==
X-Gm-Message-State: AOJu0YwWxO0M1u4Rm7R0Yma2arMBBoxugyzIp8Qz10uaV/vIujnLF//i
	8SppJOWShB0nnCyCWia7A88weVmJ0mISc9CvS472GxvAsSH9zK0d+rW5z7jftW/Pu+/fCpEuZwm
	KT/EMXVcUUA==
X-Google-Smtp-Source: AGHT+IHzgHCgeOMaxoHn+ZoRUqPxpbYeSE8m3X34zeIZd3shW8wB7PEFBOoqhV0vaeAKwXbeDVnA0FYlygB/jQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b81:b0:dc2:25fd:eff1 with SMTP
 id ei1-20020a0569021b8100b00dc225fdeff1mr158829ybb.4.1707316000690; Wed, 07
 Feb 2024 06:26:40 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:20 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-5-edumazet@google.com>
Subject: [PATCH net-next 04/13] net: convert dev->reg_state to u8
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepares things so that dev->reg_state reads can be lockless,
by adding WRITE_ONCE() on write side.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 23 ++++++++++++++---------
 net/core/dev.c            |  8 ++++----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07b787adf518e576e75545e4bae846..bed8de91e91a4bd83fe80f6835643af68f1adc53 100644
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
index d2321a68a8abb4a4253c5843952b542ed040327a..027d0b7976f337df885266aeab2c90fe631decf1 100644
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
@@ -10561,7 +10561,7 @@ void netdev_run_todo(void)
 		}
 
 		write_lock(&dev_base_lock);
-		dev->reg_state = NETREG_UNREGISTERED;
+		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
 		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
@@ -10981,7 +10981,7 @@ void free_netdev(struct net_device *dev)
 	}
 
 	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
-	dev->reg_state = NETREG_RELEASED;
+	WRITE_ONCE(dev->reg_state, NETREG_RELEASED);
 
 	/* will free via device release */
 	put_device(&dev->dev);
@@ -11071,7 +11071,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
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


