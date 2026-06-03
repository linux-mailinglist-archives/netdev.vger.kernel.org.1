Return-Path: <netdev+bounces-294873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZYwdMnBvIGqz3QAAu9opvQ
	(envelope-from <netdev+bounces-294873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:16:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08D63A764
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:16:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=s2mKqRh8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294873-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294873-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED77303581A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E41383322;
	Wed,  3 Jun 2026 18:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E89383C86
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:08:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510115; cv=none; b=o+Y4f60JWWwSaJdodiFrbkyqllPc5O7El0WVm8+bbGb9LEJeXjR4CErnzD1b3VEDuIjTpIk06SyvEtXCXsivq9Uu+pMQbn3AXfYguZ1GoRUEwHWcxJOKXrLcfUS2ZcTHWgk+FOJaDRsz5ermaFCDBXUGMa/NQYKMipqbl6JaUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510115; c=relaxed/simple;
	bh=YqupHAP5XNrHRo4vfKIy9r45R8SJkHOoV9IidczokD8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cDe/Fqhv/+qFpgcLLgDlCcNaZiVjC5VcM8PeOyP12jOb8xY3TsZ+CPOz0WHXRv2Zf6fadEpzfxuM8W/JrxJzt4Mm6vFaOV34ou9s7OzbT+1wRNPifN7VogrYznnFaIN0N8QDokh6+9CccNnhBkIW0uEIpdiBDKYlEArP2CoXXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2mKqRh8; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9157f1be083so444876085a.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780510113; x=1781114913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yl00vsXLuwnA8oTJZMqwDB+uTJ/geVRXfTd5Cia/kYo=;
        b=s2mKqRh8CM93nTrdhzPf2SKph0/Ut5oUsQOSGB6zXXFW/5gQWHdYAGMJj4BTpLUnrn
         jYTS1FzyK+4A3IFjxgZ6HXCqdB+bLXe4kQ7SfqXxJxiFm/plZjS9Vg44wAuC5gAECf5w
         pjAFAIb0NkTi5CjoqlnvV4zT/1bZxTVOJJVlnUztYOkpIwIEYhlzwCfZACgK8E5p9NTi
         9qCSIEmfKvVYr/ngBKVyYQKluygAgnn9VI0WDDIGcVCNGT1EwEeddoONZhWob+hYI15i
         RRqb1ALroZIGHDuIJUijSKyMGIt7/lqG0N214vHAI9BcwVxLlpGnp8Awrsv/lSZtb66v
         jgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510113; x=1781114913;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yl00vsXLuwnA8oTJZMqwDB+uTJ/geVRXfTd5Cia/kYo=;
        b=hbpzMwbhKeYcMMeVqTxSR8M9VTO0yHGD4iPQHIz0jWJBJVujFz2mvN53vftM5KgwL9
         uDQcLF22MBAFkbC5zcyWGCnEsC71tDDkDj4i2GqGr9CEFGVKRtg8pWlMbt4AB9sFxeue
         6zO/HCsTddsfIaT5wufDM63zH2K+FGwCGWAdGm+Y0FA0X5Y/m3tWdpOac3giww0Uh/mJ
         zeC/Ix08OC4yUiv3ydmHaRYGvz4EawrRq/O4oaqPqnh3Nc67UXr5VT5PLsUiZuxceOK+
         AFj23i8uJZ11McZRX0ywXI/za3GodKwkcoEE62YkXx1G9vunp+8umMxDX30LT1wS8mIA
         EIJg==
X-Forwarded-Encrypted: i=1; AFNElJ9EaDggQIS3aA0MZSO4dMcsiDnOV7xQydo538BwGFFOHi1YRQh5qWOoKicpKeL1bQxWBPHeeg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2P/lYxOpMhm4JmUlQUPn4nayC0SadWkrvX2DB27eJ9t+w8pI
	dfwKN+nHm9RrxGH6nBu8yYGiaXz5Idh6kYTpCcjZh7x2/Wn7TvU++C3stFXNOYPmFXzR9wwZvbk
	/9X7mMeddXAi2cg==
X-Received: from qknwm8.prod.google.com ([2002:a05:620a:5808:b0:915:9acf:1fab])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a14:b0:915:3522:54e9 with SMTP id af79cd13be357-9158a6bc11cmr763978985a.23.1780510112529;
 Wed, 03 Jun 2026 11:08:32 -0700 (PDT)
Date: Wed,  3 Jun 2026 18:08:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603180831.1024716-1-edumazet@google.com>
Subject: [PATCH v2 net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:jiayuan.chen@linux.dev,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A08D63A764

rtnl_getlink() uses an RCU lookup to get the netdevice pointer.

When/If rtnl_lock() is used, we should check if the netdevice is not
being dismantled before potentially perform illegal actions.

Move dev_isalive() out of net/core/net-sysfs.c and make it available
in net/core/dev.h.

Return -ENODEV if rtnl_getlink() finds a device which is currently
being dismantled and RTNL is requested.

Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2: clear nskb (Jiayuan Chen)
    move dev_isalive() to net/core/dev.h (Jakub Kicinski)
 
 net/core/dev.h       | 6 ++++++
 net/core/net-sysfs.c | 6 ------
 net/core/rtnetlink.c | 6 ++++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 0cf24b8f5008a951f569ff1b51da91a0e19b347f..9e94314408695be763320aa8282340842f7303e2 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -396,4 +396,10 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg);
 int net_hwtstamp_validate(const struct kernel_hwtstamp_config *cfg);
 
+/* Caller holds RTNL, netdev->lock or RCU */
+static inline bool dev_isalive(const struct net_device *dev)
+{
+	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
+}
+
 #endif
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
index d0b0499dddea37148f6a86d9464c40319610129d..1761376cdfd5d5ed41c3dd3089c812b3625e3a94 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4267,6 +4267,11 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 retry:
 	if (need_rtnl) {
 		rtnl_lock();
+		if (!dev_isalive(dev)) {
+			err = -ENODEV;
+			nskb = NULL;
+			goto unlock;
+		}
 		/* Synchronize the carrier state so we don't report a state
 		 * that we're not actually going to honour immediately; if
 		 * the driver just did a carrier off->on transition, we can
@@ -4284,6 +4289,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 				       nlh->nlmsg_seq, 0, 0, ext_filter_mask,
 				       0, NULL, 0, netnsid, GFP_KERNEL);
 
+unlock:
 	if (need_rtnl)
 		rtnl_unlock();
 
-- 
2.54.0.1032.g2f8565e1d1-goog


