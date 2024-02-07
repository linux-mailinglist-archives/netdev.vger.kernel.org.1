Return-Path: <netdev+bounces-69848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6ED84CCB6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2F128A471
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB957F7C7;
	Wed,  7 Feb 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T72puXuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E087E78A
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316013; cv=none; b=aBpCxTpmCW67S1yeNVuh+k3OXd0lr3SSJdXQuo+KrB0ZZOtNmGNsZpXpizC84f0831RlBLRhUSvRUu3z3jR9/emCUzwFXDKJPXviL0cFdCoP+qq2W4bstZrEa/RdP7E9u4u69dAJO3Rz1X4W1cn0xPRjxdGc1R9Fk+uQG7vvK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316013; c=relaxed/simple;
	bh=5f6RmfQvvv/uxeZm62Yhase170M4G5RvO8eoCEczq/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XMCslbbXzfA1e1n7x+cw3U3xzG6ls4S/16K8HApke3RMIjLOHUTdQw795RTcD+SGVNkql+s1hsFHS6zhTcnwbin8LDPCrsfal3xDxekjDp0KIPC/35wSW/x38l1PWAA+ky+zYg4bJU94w6LzHTHBFIMd+0kJDjNxRfrj/CZ6N1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T72puXuC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6049bbbb964so3919617b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316010; x=1707920810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnZR/Dndvwfoe4wnDlMsNduldDMdka0pVG0Lr5cBWUM=;
        b=T72puXuCDJdROlLiw6sHqGeKuAwgPKTWfgS6XF4PbnH/0m59C2LpShIUQmIMuP6YdY
         QJGiyvP1EgHJKtH4kznRmTrbgzFDLK2a/HPmxrpqk8OTg+B++fO5xxrLZpSLlxTUOVjx
         0z4+H5dF0+uuOObnmAuqY0JYow6+i7jSexN4+4EZYZupnsO1+ZXgPNn+PXZox66BRh8r
         kgRoFJwrL1fT+bXTF2lifHq01qByIaRpQrKR2dW9/H5bBsFZEo9BigJDjFwFMC1sK+jr
         z5V0JgiZ/w1+GBenWeZ9DN4cZByfJj+KgcIg5WY0JPDTm7nSnsnPNUJ3X5Lpahg339yI
         FH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316010; x=1707920810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnZR/Dndvwfoe4wnDlMsNduldDMdka0pVG0Lr5cBWUM=;
        b=X1Xyva7HzT50nZRXI99xTFkiKbiak73ZUEV5D23K6+P68iPxprcBnJlatUEQt+PjMD
         0jQtlz/Ih3feEorQ1gJDBHNTHltsddzJkczyUrSEzgMzYl2U+mXD0aP9laq3pppGQ6fC
         DbPrlXGP5/+tqKo2+oIu/22XZszL89BB2akPeITAs1D7lIJc3PX/1KhcME0H07WW3psK
         OBLyctJuCFQLbFjirlnADvtwYYvkZWY4S1va2FYA87NzycLKtQ6L68eZa2Y0ELe8XTC9
         cSIO/aqhb0heo9JQzAT7aNus23JR7m4/XDBVcPB9cV/P3jIcDqSxKcGZqxo1G3KmT4GU
         r9+A==
X-Gm-Message-State: AOJu0Yy7abQ8mk9UdouUtGuEfxJ4sus+EFnrcC5V56DIHOgvp0p5kCln
	9VcRcKZfmUe59BVNA9mCPkIA6bC7Oueaz1cQfmdcKF9vvmW6YqiHqkNb+yFJbAss73eXyGTD8N4
	GKbflxerWKg==
X-Google-Smtp-Source: AGHT+IEtu3gMEqswQrFR15TGnVgutTi3krbvW6a6CGtkewnFyqPw5TGjqp9dGj1cRKWr9kY1U5dz5R4m+eY/jw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:248a:b0:dc6:d1d7:d03e with SMTP
 id ds10-20020a056902248a00b00dc6d1d7d03emr187327ybb.8.1707316010788; Wed, 07
 Feb 2024 06:26:50 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:26 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-11-edumazet@google.com>
Subject: [PATCH net-next 10/13] net: add netdev_set_operstate() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_base_lock is going away, add netdev_set_operstate() helper
so that hsr does not have to know core internals.

Remove dev_base_lock acquisition from rfc2863_policy()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rtnetlink.h |  2 ++
 net/core/link_watch.c     |  4 ----
 net/core/rtnetlink.c      | 22 +++++++++++++++-------
 net/hsr/hsr_device.c      | 22 ++++++----------------
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 21780608cf47ca0687dbaaf0d07b561e8631412c..cdfc897f1e3c683940a0958bc8a790c07ae819b0 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -172,4 +172,6 @@ rtnl_notify_needed(const struct net *net, u16 nlflags, u32 group)
 	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);
 }
 
+void netdev_set_operstate(struct net_device *dev, int newstate);
+
 #endif	/* __LINUX_RTNETLINK_H */
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 1b93e054c9a3cfcdd5d1251a9982d88a071abbaa..83fdeb60dbd21169ab7a52def3674615b2ddedbd 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -70,8 +70,6 @@ static void rfc2863_policy(struct net_device *dev)
 	if (operstate == READ_ONCE(dev->operstate))
 		return;
 
-	write_lock(&dev_base_lock);
-
 	switch(dev->link_mode) {
 	case IF_LINK_MODE_TESTING:
 		if (operstate == IF_OPER_UP)
@@ -88,8 +86,6 @@ static void rfc2863_policy(struct net_device *dev)
 	}
 
 	WRITE_ONCE(dev->operstate, operstate);
-
-	write_unlock(&dev_base_lock);
 }
 
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4e797326c88fe1e23ca66e82103176767fe5c32e..46710e5f9bd19298403cdb8c179f33f155a4c9ad 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -842,9 +842,22 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 }
 EXPORT_SYMBOL_GPL(rtnl_put_cacheinfo);
 
+void netdev_set_operstate(struct net_device *dev, int newstate)
+{
+	unsigned char old = READ_ONCE(dev->operstate);
+
+	do {
+		if (old == newstate)
+			return;
+	} while (!try_cmpxchg(&dev->operstate, &old, newstate));
+
+	netdev_state_change(dev);
+}
+EXPORT_SYMBOL(netdev_set_operstate);
+
 static void set_operstate(struct net_device *dev, unsigned char transition)
 {
-	unsigned char operstate = dev->operstate;
+	unsigned char operstate = READ_ONCE(dev->operstate);
 
 	switch (transition) {
 	case IF_OPER_UP:
@@ -866,12 +879,7 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	if (READ_ONCE(dev->operstate) != operstate) {
-		write_lock(&dev_base_lock);
-		WRITE_ONCE(dev->operstate, operstate);
-		write_unlock(&dev_base_lock);
-		netdev_state_change(dev);
-	}
+	netdev_set_operstate(dev, operstate);
 }
 
 static unsigned int rtnl_dev_get_flags(const struct net_device *dev)
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index be0e43f46556e028e675147e63c6b787aa72e894..5ef6d437db727e60bfd8cf68f010f0151d0db98b 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -28,29 +28,19 @@ static bool is_slave_up(struct net_device *dev)
 	return dev && is_admin_up(dev) && netif_oper_up(dev);
 }
 
-static void __hsr_set_operstate(struct net_device *dev, int transition)
-{
-	write_lock(&dev_base_lock);
-	if (READ_ONCE(dev->operstate) != transition) {
-		WRITE_ONCE(dev->operstate, transition);
-		write_unlock(&dev_base_lock);
-		netdev_state_change(dev);
-	} else {
-		write_unlock(&dev_base_lock);
-	}
-}
-
 static void hsr_set_operstate(struct hsr_port *master, bool has_carrier)
 {
-	if (!is_admin_up(master->dev)) {
-		__hsr_set_operstate(master->dev, IF_OPER_DOWN);
+	struct net_device *dev = master->dev;
+
+	if (!is_admin_up(dev)) {
+		netdev_set_operstate(dev, IF_OPER_DOWN);
 		return;
 	}
 
 	if (has_carrier)
-		__hsr_set_operstate(master->dev, IF_OPER_UP);
+		netdev_set_operstate(dev, IF_OPER_UP);
 	else
-		__hsr_set_operstate(master->dev, IF_OPER_LOWERLAYERDOWN);
+		netdev_set_operstate(dev, IF_OPER_LOWERLAYERDOWN);
 }
 
 static bool hsr_check_carrier(struct hsr_port *master)
-- 
2.43.0.594.gd9cf4e227d-goog


