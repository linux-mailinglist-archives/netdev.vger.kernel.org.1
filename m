Return-Path: <netdev+bounces-71185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E10852909
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E541C233AD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71017981;
	Tue, 13 Feb 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIPf2wvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46A1119F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805987; cv=none; b=qFr/X9QvFRHBKJPz3ewimbZm6zEZFlrQSwpBljMRyo0cZUjIprPF2ywMTFUXybCZgs4Lbe7rJN44wFz94+eeQoN02mJxc9x6n2MtyhNNUE8z631JyiCTixncEYSs0ycfGOOItAg2yOYLY+Yh4rvYeWtTv5rQenf4xmrtI9w4IIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805987; c=relaxed/simple;
	bh=Mz682iuCs23ZTWRXLCB7A9Cq7ROqWGTCIcCo4D6PUm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ffbxl7JPhjwo94hIsBAGHbMMocf3YJDvoaSPiDdMSNK9zxPcKusWwvOnrC1+zQP3RP/jzi9GUjpCEJOKcDDkPPLLkMzZsSHe20FTrwOos7BpUnWIFno0/uNzRdgmmA9XC5s2teILuSF2X1f09rVbJwVYSmBj57+aHanjn9PN4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIPf2wvr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60779e8f67fso9495447b3.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805985; x=1708410785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1okATnf6wZRBcxyhRD/wGg50tRHuYYIo0E/4k/zY/qY=;
        b=hIPf2wvrs2NUozbSOH9yvATxAC9GrmsW1VrKzeqLeUaKxQoOCAv0PSlnlJUKRZ/Mm6
         Ult9HMzKRpmCu325KnNOC7Zu2xGEBkxM4zJ3T47yBXdHb7MdQsuFVqk5jug5B+xsbm8x
         Yu1EWWsGpb3W2d7CCaFNTtI4U/StRgJwCib0FqmxoWuMBgy3oroDg7dxHsPEf58O4VeU
         xfCTPsVl1PLlmUgf9I7H6m9NUGboaby6mubXxEA2ScBWeb1VBZSvSuMWxoh5wgLoO4PU
         BL8x71dULA+XnN83icrRMncaSlnslaXigf6aOBNxWCPDM/zgWVl10wiQVYmGmzDu1lB0
         NNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805985; x=1708410785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1okATnf6wZRBcxyhRD/wGg50tRHuYYIo0E/4k/zY/qY=;
        b=kzy/NIqpxZx7bEqEWsxfYbc8eE08yYMOnqjIfFLrUGKbN7TTf8Jh4MK48XvAg0tdd/
         M0851wbzr+dxAvAgK6A2O9w/UDkn0qVSVgClMU1psmxLjdCc4QBtjZA6mYrTw5qYxrsh
         YxeSp2sgBQX9t8Mg/j7RndfKs/DVSF5n4vIXGz5kJh4Mu02Bt7ciQUd00Fs/tgDfd0n/
         Ca/1WyrovBTYa06/3pmCiD05MfEQb5GEYhn6HdOWLRNDN50V6XiYz6zPsQ8raLDWE9/n
         UWi0zNXQipnYrAyVZEwlTXDpBsjyfVpAHXn2vE3xEXX3ms7IZlF/4vlfWs+pya435YNT
         GNcA==
X-Gm-Message-State: AOJu0YxumbR+9yoczzfRJsJKeWe3DIJ4qBoUtf6b2tILBsT7erY1XOoN
	cJ/HhBF2NH5Jbuh4A216TX7xz69pQ63WopDg8v0a2vdoNEP+U+Xj5i0On8X6yn303IMglfwOkHM
	8zQ/A0pOrPQ==
X-Google-Smtp-Source: AGHT+IGbT6y0aoVe2RZoRJd1HG72l4t6sioPkaN3RXrx+oKReIF9Y++jl1Oly1ifZEy2hbZ9QM8K/Q85JKuSfw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3505:b0:604:a2f4:4741 with SMTP
 id fq5-20020a05690c350500b00604a2f44741mr1551348ywb.1.1707805985215; Mon, 12
 Feb 2024 22:33:05 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:42 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-11-edumazet@google.com>
Subject: [PATCH v4 net-next 10/13] net: add netdev_set_operstate() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_base_lock is going away, add netdev_set_operstate() helper
so that hsr does not have to know core internals.

Remove dev_base_lock acquisition from rfc2863_policy()

v3: use an "unsigned int" for dev->operstate,
    so that try_cmpxchg() can work on all arches.
        ( https://lore.kernel.org/oe-kbuild-all/202402081918.OLyGaea3-lkp@intel.com/ )

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  2 +-
 include/linux/rtnetlink.h |  2 ++
 net/core/link_watch.c     |  9 ++-------
 net/core/rtnetlink.c      | 22 +++++++++++++++-------
 net/hsr/hsr_device.c      | 22 ++++++----------------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 24fd24b0f2341f662b28ade45ed12a5e6d02852a..0168d6e457bd3595eb6fc70938a83c0ece521a71 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2258,7 +2258,7 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
-	unsigned char		operstate;
+	unsigned int		operstate;
 	unsigned char		link_mode;
 
 	unsigned char		if_port;
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
index 1b93e054c9a3cfcdd5d1251a9982d88a071abbaa..8ec35194bfcb8574f53a9fd28f0cb2ebfe9a3f2e 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -33,7 +33,7 @@ static DECLARE_DELAYED_WORK(linkwatch_work, linkwatch_event);
 static LIST_HEAD(lweventlist);
 static DEFINE_SPINLOCK(lweventlist_lock);
 
-static unsigned char default_operstate(const struct net_device *dev)
+static unsigned int default_operstate(const struct net_device *dev)
 {
 	if (netif_testing(dev))
 		return IF_OPER_TESTING;
@@ -62,16 +62,13 @@ static unsigned char default_operstate(const struct net_device *dev)
 	return IF_OPER_UP;
 }
 
-
 static void rfc2863_policy(struct net_device *dev)
 {
-	unsigned char operstate = default_operstate(dev);
+	unsigned int operstate = default_operstate(dev);
 
 	if (operstate == READ_ONCE(dev->operstate))
 		return;
 
-	write_lock(&dev_base_lock);
-
 	switch(dev->link_mode) {
 	case IF_LINK_MODE_TESTING:
 		if (operstate == IF_OPER_UP)
@@ -88,8 +85,6 @@ static void rfc2863_policy(struct net_device *dev)
 	}
 
 	WRITE_ONCE(dev->operstate, operstate);
-
-	write_unlock(&dev_base_lock);
 }
 
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4e797326c88fe1e23ca66e82103176767fe5c32e..16634c6b1f2b9c0d818bb757c8428039c3f3320f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -842,9 +842,22 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 }
 EXPORT_SYMBOL_GPL(rtnl_put_cacheinfo);
 
+void netdev_set_operstate(struct net_device *dev, int newstate)
+{
+	unsigned int old = READ_ONCE(dev->operstate);
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
2.43.0.687.g38aa6559b0-goog


