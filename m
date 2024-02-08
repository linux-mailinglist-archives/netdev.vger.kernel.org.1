Return-Path: <netdev+bounces-70260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E384E2E2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E639028D7A7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04F7C0AF;
	Thu,  8 Feb 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fe465cLi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB47B3FF
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401551; cv=none; b=R6QbEivD2xA8c5bX7EgYYUq2vuWbAo2QQ0eX+cQgbarjge+DjCKOLIk6nJXpHT1VcYopnYGXBv7AqgrAWIwuI9S9HzmmlGOotUJ/ZC9b6FxYSL7yrWKtIJyjuB3ZGnqsFI9vWTLRdTrq4oZk2HF8Dsy0+NNTg6DFKsHWhZQyzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401551; c=relaxed/simple;
	bh=5f6RmfQvvv/uxeZm62Yhase170M4G5RvO8eoCEczq/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U855vM+Ly9uJp9YpYV7qr68QeUaGT4pYaL6Z1imhlvsC69K+v1dx+98bVLnjnY5j7rT/jOeZc5kM8vwP/epxPusPCk9niD/Yq7uZ0+qPyk7ExeVkKCp1a55p93fB7t3Qd2pc6f6j0WWOr3PP3TnIJSDb0On0AnfcPKrD4yUX1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fe465cLi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604ac3c75ebso6815347b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401548; x=1708006348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnZR/Dndvwfoe4wnDlMsNduldDMdka0pVG0Lr5cBWUM=;
        b=Fe465cLi/8yyOx4mkxJVRYVUMkcWJ6GOpR8CFot1KNZFN7r+B5/zKgSe6w70p1EuSp
         x7503AC1/+5AYSTl2CPpIbMMW9UqaroqiRe18Wba/LBDU/hhTa9UlIz1dbPQX8chJmdL
         nT2sS5T0C4Z6MHna4Gn0pVd444zabPcxKLUzyB3YDnWaTrFBheyPkPBbBqbmUejPou+H
         HSHTeyNmFNDMf3MSH3W7CCoyNJ4ZZ2jAdbsL3xXwkqojz6qstZwD+Ojsn+KqJiTIZu4/
         w5cqom9Gl5M5KvV/ircQbbznZ/nrsGUeO94hFwqbYjjQ4qQgqPzgatQlvRVuGU9YvttD
         kDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401548; x=1708006348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnZR/Dndvwfoe4wnDlMsNduldDMdka0pVG0Lr5cBWUM=;
        b=GSB7d4I85h3r0v0m52htHfF1RComwjOKBLSO6k9Al+OnFGpTC5ZMMUUFh9skQZjigU
         wVpdiUzY5dmhhVb/PlqYf2QaGzIisQGPpCsCTB7QXY2O5yJPjojytiaExLqd9RQKRVG3
         z0cPUjuDVr9HIZWdOqiJLmEYMrXrOjDuwkGQ0sCyaQgIQ/o21X6bHFQjkG4wOwn/2AIL
         n3EtN9d1NBQIOEkQonb5VfpjLvwKrRLkWOyAHCBdpmgPv6YeHepzeq8lo/HaTKLOmcOk
         9B1oXVhwHraMkB1XJ9b9p7Sx02UX7Y8duiM8jhVsRTAgu1BfTm+N0PsYmhbYjZbzyscB
         fdag==
X-Gm-Message-State: AOJu0YxmPx7CZavoiB6YUNVDYEtJBQwr4q+qc4ehJO5NmAD6QnpZJXoR
	YsMMvtDpKYNn0px/hUnVeZSI0cF9ybY5kF/Ct1+lvTrPNh2KLC4sXMNZCMSxO4JFhLDc2Cm820Z
	3rPzSW54Z7A==
X-Google-Smtp-Source: AGHT+IHPis6H0ak/srMn59k+DYm5+cvhleVDcLxJ+15XZDvTI9onX8fs8lozvR/2onWCcCpH9QoYYjrPJZmflQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1025:b0:dc7:3a6f:e0f0 with SMTP
 id x5-20020a056902102500b00dc73a6fe0f0mr912733ybt.11.1707401548667; Thu, 08
 Feb 2024 06:12:28 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:51 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/13] net: add netdev_set_operstate() helper
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


