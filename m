Return-Path: <netdev+bounces-71179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359C852903
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15EA28447A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA211756D;
	Tue, 13 Feb 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKwujSj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1114287
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805978; cv=none; b=HnGo1Lm3JPeK8WSrKuege9mM7kK6FP7kOFuLOFIfrRfSN+U5Cm4OUR3dAJCgVljbCA36XGzTbc/x9qwSzmnnPiutnAWn+eQCXceb9LMlEq752aDXTiRHkRfQhJ0meVjKzEk0XeMaZ7usCxf3CCZmiEW2lBlNPo93mPLc6tn0Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805978; c=relaxed/simple;
	bh=1PKbHBlkwrMftJp8C2JP1vgGBe/peRVq48qVE3fg5uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BpXP2cVg4gORgPIrbteab8PBvYIDeOYMZeM4wdZw/clzJ6dfzH3qJFzkBZXiD3+g6nkg5N2rpabTrRUUmzwJXOGFD8adZc97OPAopTxgiOgc/dcIEhrMKDghXhihoobD227ziO9z3LFy2En5d/ah5EUlIjU+GQqRR4Ru5yFhB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKwujSj4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so5544153276.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805976; x=1708410776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSyuV0I41sbdzqG4atoE8PPSOSz951aKzaJULHugV0o=;
        b=NKwujSj4PPRGbuUHiqSuCtotImPvnDxYq0p2d4DnalMwBR89YMpGc4LrfPaiBW0tCy
         k4S9Jwwpu5UNxVIOzppAL/TovlnhWqtEQEcxmMJ2vIqBp6Jm2tRqwBT7iecp7E0CCaa6
         V9HWfW6uLGXBCv5nmDsqVT8zPDehQD15jacXA72YJ/dim1RIufr7fn1xJGSR8rlddmdV
         5RJ2cKsFMYizb/MiFw3j+PbAq/8CERxICTJqTcOCi3nJf6HN6PXQRBakOS75WLhN/3sR
         c59sDrwGsnuQPT11gzs6g20RA+LvV6PhFN86H//oFPUGE1tQjnkiDdSF3p4Y50PuHV1l
         uVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805976; x=1708410776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSyuV0I41sbdzqG4atoE8PPSOSz951aKzaJULHugV0o=;
        b=d93g81HcJI4+rHRjSknqzn8pVtBO5Ijm9zgzCZlefsBX8NuDQFNMc8aDMTdONujaR/
         6V2OfpYDGhIt8NSo9xzuH0wsKkmix+RwpGPo2u1Kl3eJ2afs3x9bS0Ce0lQdvQZKhHFA
         /XZ/MZY+fnVDD8tIBDc+CwdgEj7LcNykGm8ZjWxUAORDGpltFtUoy+KKiE8D0PjZ3F//
         5SbpRvynGN2cVgnDiE+HhLJVP893ZuANXKHYHw4CTogDGlv8Uw6GTmrOAu5PpnDjfBzB
         f4z37DrVENClqLmnpDPhMHM8GpWJ8tmE/cvdkI0XdKq908Eio4dVBlJ4TxBegKurOth+
         H/MQ==
X-Gm-Message-State: AOJu0YzjNnSanwbQb+Tco8c0PmVdci+hoKYHzsMFQTAjQCj20DalVdtb
	+yc+RlLjWjuWpvZbmVZP3NKflY4Gm24awLpm92dP6khsrP8OrLuraGqXHY91RVJ0bwQUTaLxgFm
	Rf6QXIxGQAQ==
X-Google-Smtp-Source: AGHT+IE80CjrI2GJl0bsCMbTTkKnlSY7NJONo07aXrqF/PjrvXJKMZAhs3zhWiplzw/CwS8T6s6Bp8IEjB++IA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:701:b0:dc6:dfd9:d423 with SMTP
 id k1-20020a056902070100b00dc6dfd9d423mr295412ybt.3.1707805976131; Mon, 12
 Feb 2024 22:32:56 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:36 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-5-edumazet@google.com>
Subject: [PATCH v4 net-next 04/13] net: convert dev->reg_state to u8
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
index 693e08f3304d1de18f859ff4a65947b4a5cb9e4a..c08e8830ff976e74455157d3a3b8819e8424f93c 100644
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


