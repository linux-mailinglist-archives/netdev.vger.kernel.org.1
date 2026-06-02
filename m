Return-Path: <netdev+bounces-294097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH6cHKWhHmquDAAAu9opvQ
	(envelope-from <netdev+bounces-294097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:25:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081D62B718
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8A630C0B1D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB543D3B3;
	Tue,  2 Jun 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VC75bk+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CD357CEC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391603; cv=none; b=dlLik77WUHtj/GcQ3VMmV6kpBPszDchL6YuYyhtsKFXIwZtaSHhTTkrLYUbh/28OiVKOdEPaA2udcD82aBPbfWMoHps4YQbpzKn1sIlAsf2pDddv7MDmPtICtnEsmzaKomoqY6O70pmBH1BzqdZaGcslqAE4HbpXHis6xFwnGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391603; c=relaxed/simple;
	bh=FpfbcTXMnK6NefP1I2I3yCFPzxaW+3aP7IcEMjoDMC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jwJXLkFi5lKHRvS15Dk6AsT/YGJZfm+htoj/DDo4Z6hJx44cHenuuKh9RONXlEpFfvilvsVHHW1uqdD2O0+Hcy/NFhAOrpcWBEgtg2TlYOfSvtIbvtKUfIqapXk6jKi2mgiTz2/jFrQZ0j/8ATFlpDRYz+hPKic+asCC9Ir0AK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VC75bk+r; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ccd83d58d9so76310466d6.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 02:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780391600; x=1780996400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/Pa+KP4SHsKqLU95TxoWJWTf2Eyt9+oIN+csDnH1wE=;
        b=VC75bk+r/kXWk5y69NVkC/hq2+Na53kQ3flf+63OVs4cD2AGmsHQh+huijlBJHzw3o
         UISTdrupV0wrYpeFpWRijD3UJ2FrkB3F0rpzKz+4Mw80eKW8JfGCLrR2hw+TQ2CRUY6s
         mBckzHaCJdBuzCV0lbnPqf1U/6l5UUhn0ZFKdkvIYFCyUtpSWR6JmClyhas7vMvU4PJk
         pSaAyp8K/ftH20yLCbmjX1i0qhjRvTMGVWy9w4Yj+Dp9dLS35fevzS7FB4KvpSTGEpfr
         bgdDzhmUGZnWCjTQP7lQ6G1ey4ZUaTkxlDBwwng7s421ttz6RqeHsmhxSzits8X3oN+g
         xAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780391600; x=1780996400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/Pa+KP4SHsKqLU95TxoWJWTf2Eyt9+oIN+csDnH1wE=;
        b=sC3zFwg2pMaWwuHD4Fl9/iFC/5vO6SRtbAhGOvCUSCrwfgxu/uKxW0zDFM+hrIDJ1i
         RvkOGB8RWp44v/ZnJL5r06xYneaSuctWShbaqyec3KhrisqDY2OCUuM8BQKmWc5+pTgz
         04Du7o5Rujh5IqV8oI/Dk9dVUQMA68Bbe4SMYupBruKMf/3YiFc+vPgGsXpGGTu6BvJQ
         /fSQpxIB5fS33pT872A54M+uYMR0FlOWPw+RajGrihw6IResN8fMTUsdiCKyOOcphXmz
         jcG3uQkydnPOSkyB05yzlGh934T7GrFbqWFfrtlvq7VGJiLQHDifxC+l+OQwANWX1q+o
         rv5A==
X-Forwarded-Encrypted: i=1; AFNElJ/zGaWRwLncMMgOCRXiboDdyznWLdZ36cPiQedVzqFb8BqgYyvN1EQQEh/70J/BcXTa4MSTIsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5j6UM87b9tokL6y/6en6VLcnVttNnszZXQZ7pYcvPuWJo2lLl
	40mfzilGl/dB8gpofGyVNQCv6KTtHNVGf7NUXoyFiNuc86lKJ5lr9VkKYvtqUHzK+Z/t27HY3/p
	nHTQYrBoAPMkAHg==
X-Received: from qtbjr28.prod.google.com ([2002:a05:622a:801c:b0:517:71d9:d9c4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8d11:b0:50d:97e8:939b with SMTP id d75a77b69052e-5173a7fde61mr198183491cf.36.1780391600458;
 Tue, 02 Jun 2026 02:13:20 -0700 (PDT)
Date: Tue,  2 Jun 2026 09:13:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602091319.1753654-1-edumazet@google.com>
Subject: [PATCH net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0081D62B718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294097-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

rtnl_getlink() uses an RCU lookup to get the netdevice pointer.

When/If rtnl_lock() is used, we should check if the netdevice is not
being dismantled before potentially perform illegal actions.

Move dev_isalive() out of net/core/net-sysfs.c and make it available
in include/linux/netdevice.h

Return -ENODEV if rtnl_getlink() finds a device which is currently
being dismantled and RTNL is requested.

Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 6 ++++++
 net/core/net-sysfs.c      | 6 ------
 net/core/rtnetlink.c      | 5 +++++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 74507c006490f180d2fac6594f6dcf2c86d53919..bfc847bc47fd957b58174dc4d2b82e2e8b461405 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5660,6 +5660,12 @@ static inline const char *netdev_name(const struct net_device *dev)
 	return dev->name;
 }
 
+/* Caller holds RTNL, netdev->lock or RCU */
+static inline bool dev_isalive(const struct net_device *dev)
+{
+	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
+}
+
 static inline const char *netdev_reg_state(const struct net_device *dev)
 {
 	u8 reg_state = READ_ONCE(dev->reg_state);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3318b5666e438fe5bab2bcfed2bb260c7b4d5a63..0e71c9ed41e81d85af33a4339f556a0c5d760243 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -37,12 +37,6 @@ static const char fmt_uint[] = "%u\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
-/* Caller holds RTNL, netdev->lock or RCU */
-static inline int dev_isalive(const struct net_device *dev)
-{
-	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
-}
-
 /* There is a possible ABBA deadlock between rtnl_lock and kernfs_node->active,
  * when unregistering a net device and accessing associated sysfs files. The
  * potential deadlock is as follow:
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 652dd008955a90691403de9a54d8693d64ea7799..9e90d02b73c2909409e12adfcec3940b49dcbaa1 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4265,6 +4265,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 retry:
 	if (need_rtnl) {
 		rtnl_lock();
+		if (!dev_isalive(dev)) {
+			err = -ENODEV;
+			goto unlock;
+		}
 		/* Synchronize the carrier state so we don't report a state
 		 * that we're not actually going to honour immediately; if
 		 * the driver just did a carrier off->on transition, we can
@@ -4282,6 +4286,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 				       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
 				       0, NULL, 0, netnsid, GFP_KERNEL);
 
+unlock:
 	if (need_rtnl)
 		rtnl_unlock();
 
-- 
2.54.0.929.g9b7fa37559-goog


