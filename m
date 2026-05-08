Return-Path: <netdev+bounces-285620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ60Lg9n/WlhdQAAu9opvQ
	(envelope-from <netdev+bounces-285620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A314F189A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B55F304725D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21FD32D0FC;
	Fri,  8 May 2026 04:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP1YExmF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AE32C923
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214381; cv=none; b=ELefy/yIndmdtfYfapWcoTeyBM1m7akQzPTSk+wJBBAsPd8eMGJ6IobJdtIdggBBW1DEbfEgWuU3P74/oIg37kWoQCFJDUZWjDDX5Wx2X/aAyFSju34CHQUbPomw4Zho4rGW3gOWfqfCsyIG1xGBiJzYybkoIieJyrkHyqYqNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214381; c=relaxed/simple;
	bh=F4ikSGr780dlcNfo/Zo8Azz0TYP1Jsr0u8pzMLGHgq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwRsr6l7TUN3NywEXRItZJPLAD4Sdy/YOKcCjt5cUW6gI5sdvzwfayCKILQCTMgzZY4x3o0D20UQNxiTnfLz6pm/Xs8KOEs6XuvkzaROdcInYFYc05/6+KsBt4kG0BbvQp9bWT3jbv5SRbrjjtC1jSxpYlLInMCmkJBt4u2OePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP1YExmF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bfea8dc6d8so18517b3.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778214379; x=1778819179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMsj60XMhp22rBV56xsqh4A9lnyovDCRdW0fw5CQun0=;
        b=EP1YExmFzsJQQjHZYC4epDK4zS+WJhh5Q3WjQ8PaHe0pLyw2HEdj2x/1vOfagZjQEa
         D6AEf7jp01wd8pwj5E+kqXj8saWx4AgNfYMEoWpqKFl4/IJ4KpQvtFI3puW7lJSfZGMM
         QInizRf68K04hFFsDcDrwgioxehOR9ZMQSTwBZBqRoATGblm2KDNlA9wmqIRjkJOCiE8
         nXI0oyGkEK8GCPPZ8Xo0oPgwrt1n69Xd8Sxbcc0uKa1X8awcwp/z9xPraM3cphD7ZuPm
         10Ub+dbLZdtBsujf0zZsforqPwZCToBZy0RhM7ZzHhzde9JZHd0QjvGP9aWMVfJK9X9j
         BDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778214379; x=1778819179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMsj60XMhp22rBV56xsqh4A9lnyovDCRdW0fw5CQun0=;
        b=XBBg0bf7r8Ik9xnvOEG3tJSg4YeRNyDyl7f23PeJzLekcGD5GMxyoKduHCVvqoaakJ
         BBmVAxdFH6LTkg83oTHqKumL8T0rLLUOVwpy9ZkLcC2qqnDnYbprjrJJiS3/1PJxtMvc
         IEYFTl0g7AJjV0FUD4FnA/OFUmkTwgEYUvBeFazO01KjLK0PxtWtD4DsV3X/dp5S92vk
         PdZVF4lhpVH4Eej8oSN++4YvZq+O3Hc5XxvLBbJkLrIFHa2mlZ+5XnThrok/kJzHGOpH
         LD/7D3iVQWTOAQVouJ6bnku+79MjR3PGCLndD9v/MpZPfuipEkGHg+AEOVSvqDOf2xgB
         HAUQ==
X-Gm-Message-State: AOJu0Yzd5/9+vaFsQIbLS5QW7n3DdBvKnVMVV6utXGQDCHKt+Cc6tKVZ
	WEes1VoNHvu7Q7MxIfmpjWuHvQ99rym61pyzLuyla0KwKxkAStLqvmiVwCpc5g==
X-Gm-Gg: Acq92OEBiXoIaurcbE39vOMvr+3OpaPysoxGLc/YYuAVYhAhQPHf+EvcteqkLV7JPgM
	CJHXZez7c2orPl3ktF0rVxY0jtmj54KgICHEdB2g7+k7w2TsDWjjWCBSiYr9LqOtePbRMfpmU4m
	7FbuYcAP+IuGL53Z7g2PhnEWf4pIRPaubEMjfqy8oo7X5nc3ZgG3KBLQrc6u1Wc0dXFj6DdfhCC
	9yqwIu9WMpFRL2Da9otUBBIHB1tFEtmb0tc5kUgebqJOdAvoLKnt9udldaw2g+sj42HSOKR2vHM
	RqJBX/U1MUvPWpxaDO/ZtTYC+LPTKXV2T1xzxMkV9iV+3G1VI2+YvS5XxxL0PU1SGAZSKpI8B1F
	jk8u1ao6Qve0AOfJr+/F+rFNW/CXs2WyUH+UgUHV/4I3UE7SO1jegmcI3O1EdeLWK/VBpQgUBBk
	CX3BYu/CpUjgIbvcrkgvViADwZ
X-Received: by 2002:a05:690c:c512:b0:7b3:3cbb:d71a with SMTP id 00721157ae682-7bdf5e8b422mr77378647b3.4.1778214379454;
        Thu, 07 May 2026 21:26:19 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd976fd09asm62444987b3.41.2026.05.07.21.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 21:26:19 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v14 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Thu,  7 May 2026 21:26:08 -0700
Message-ID: <20260508042611.130945-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508042611.130945-1-weibunny.kernel@gmail.com>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 22A314F189A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285620-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Action: no action

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list, upon the first dev-assoc operation.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml |  2 +-
 net/psp/psp-nl-gen.c                 |  2 +-
 net/psp/psp-nl-gen.h                 |  3 ++
 net/psp/psp.h                        |  1 +
 net/psp/psp_main.c                   | 77 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     | 29 +++++++++++
 6 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index aa79332cb9b1..e9c2ee7e28e0 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -331,7 +331,7 @@ operations:
             - nsid
         reply:
           attributes: []
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-dev-assoc
         post: psp-device-unlock
     -
       name: dev-disassoc
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index c3cc189f0a7b..0e426ffac398 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -135,7 +135,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 	},
 	{
 		.cmd		= PSP_CMD_DEV_ASSOC,
-		.pre_doit	= psp_device_get_locked,
+		.pre_doit	= psp_device_get_locked_dev_assoc,
 		.doit		= psp_nl_dev_assoc_doit,
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_dev_assoc_nl_policy,
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 4dd0f0f23053..24d51bff997f 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -21,6 +21,9 @@ int psp_device_get_locked_admin(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info);
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info);
+int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
+				    struct sk_buff *skb,
+				    struct genl_info *info);
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info);
diff --git a/net/psp/psp.h b/net/psp/psp.h
index 0f9c4e4e52cb..c82b21bae240 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
 
 void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
+int psp_attach_netdev_notifier(void);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index aef9f1cc2e9c..fa69298abb49 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -411,6 +411,83 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
 
+static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device *dev)
+{
+	struct psp_assoc_dev *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev == dev) {
+			list_del(&entry->dev_list);
+			psd->assoc_dev_cnt--;
+			rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
+			netdev_put(entry->assoc_dev, &entry->dev_tracker);
+			kfree(entry);
+			return;
+		}
+	}
+}
+
+static int psp_netdev_event(struct notifier_block *nb, unsigned long event,
+			    void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct psp_dev *psd;
+
+	if (event != NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	psd = rcu_dereference(dev->psp_dev);
+	if (psd && psp_dev_tryget(psd)) {
+		rcu_read_unlock();
+		mutex_lock(&psd->lock);
+		psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
+		psp_dev_disassoc_one(psd, dev);
+		mutex_unlock(&psd->lock);
+		psp_dev_put(psd);
+	} else {
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psp_netdev_notifier = {
+	.notifier_call = psp_netdev_event,
+};
+
+static DEFINE_MUTEX(psp_notifier_lock);
+static bool psp_notifier_registered;
+
+/*
+ * psp_attach_netdev_notifier() - register netdev notifier on first use
+ *
+ * Register the netdevice notifier when the first device association
+ * is created. In many installations no associations will be created and
+ * the notifier won't be needed.
+ *
+ * Must be called without psd->lock held, due to lock ordering:
+ * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
+ * and takes psd->lock).
+ */
+int psp_attach_netdev_notifier(void)
+{
+	int err = 0;
+
+	if (READ_ONCE(psp_notifier_registered))
+		return 0;
+
+	mutex_lock(&psp_notifier_lock);
+	if (!psp_notifier_registered) {
+		err = register_netdevice_notifier(&psp_netdev_notifier);
+		if (!err)
+			WRITE_ONCE(psp_notifier_registered, true);
+	}
+	mutex_unlock(&psp_notifier_lock);
+
+	return err;
+}
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index f1d91ada7c91..78ddda78c425 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -167,6 +167,22 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
 	return __psp_device_get_locked(ops, skb, info, false);
 }
 
+/*
+ * Non-admin version of psp_device_get_locked() + psp_attach_netdev_notifier()
+ * only used for dev-assoc.
+ */
+int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
+				    struct sk_buff *skb, struct genl_info *info)
+{
+	int err;
+
+	err = psp_attach_netdev_notifier();
+	if (err)
+		return err;
+
+	return __psp_device_get_locked(ops, skb, info, false);
+}
+
 static struct net *psp_nl_resolve_assoc_dev_ns(struct psp_dev *psd,
 					       struct genl_info *info)
 {
@@ -532,6 +548,19 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	psp_assoc_dev->assoc_dev = assoc_dev;
+
+	/* Check for race with NETDEV_UNREGISTER. The cmpxchg above is a
+	 * full barrier, and the unregister path has synchronize_net()
+	 * between setting NETREG_UNREGISTERING and reading psp_dev in the
+	 * notifier. So at least one side would do the clean-up if we are in
+	 * the middle of unregitering assoc_dev.
+	 * And the clean-up is serialized by psd->lock.
+	 */
+	if (READ_ONCE(assoc_dev->reg_state) != NETREG_REGISTERED) {
+		err = -ENODEV;
+		goto rsp_err;
+	}
+
 	rsp = psp_nl_reply_new(info);
 	if (!rsp) {
 		err = -ENOMEM;
-- 
2.52.0


