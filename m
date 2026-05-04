Return-Path: <netdev+bounces-284080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ba4LKsl+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:03:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA4C4C4B89
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D29303CC10
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602B38D6B8;
	Mon,  4 May 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZByPdnW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCA390200
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935679; cv=none; b=hfLmm3L/QiIFpArXvWHhKdEo6k3Y9dYtMxvW4okWU4riVp/N/amXOv1d8Zzi/yEuGH4dNOqhBCxZsbsRbZ8ikdTGxeCsz+04qYyXV6yU9DZ4TRcy6uhRJVK34KJ/238kZI6YRmCnUDn/BpkpZu2tcuulv7qkU82kAqn1uUTfBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935679; c=relaxed/simple;
	bh=J9Mg46283csBizpiOXyPpEK3AArqvmohr+KxCZwCOP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbL7LuB80eSlgh/5gOdj2gEIRDrI08Z2K5ULhhtfRAxy34omGVh+11re7ruHXO9cRhIKw6a8aG4r/F8ekOWQAwzhByu5v09a4H/rpiY1d9sCmhrHU7SuZmM/X5sVjP2+hVsMHSkHr3asRGCTPVD/xolrsdQovwF2gH2Qa/b8oOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZByPdnW; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c2e7ff1acso514825d50.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935677; x=1778540477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok9UlmT7cGv7PmMBt9Vrcl0Na48/XmlcswpoWzO9gIo=;
        b=lZByPdnWF3oJG39TCHn/qYvCu8ynpCrGSAuNGp5qwITOXgtF3KmOTL+RArJVwW45eB
         xm2JuMqPw0YBZV86bKZxJHKFEKwNFbr/3DlDDt0Pu0Cxj4N+ZNn6UMZu/jBLqpM5eW/4
         rcG2XBxjUTb+3xF42mr1ZKivwt6YH98UfrARTQEYQKpOt3AVP5/6gEYY8MtPBcaWn2uv
         RS8Z9bSJGBX08lySXAbQvhsfzeqdH+9XZl03M/T0wJ75X9qTUCvoC6Xi0GMRMy1cylCk
         HyVaPiKZ4PgI4TeUMA3C1HZTwwbFs1B0zMfB4t2GyNhi1Q30Q1agDCIdRB0WgILqdhW1
         fd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935677; x=1778540477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok9UlmT7cGv7PmMBt9Vrcl0Na48/XmlcswpoWzO9gIo=;
        b=lAtrRow1o2wCgr29+MrUoOPjfNPQ2YniGfY/XQu3hDcLd2ywxixIgvNwUuGT39EWA7
         c2F0bJoan4/UkqTSnXnkRg5Ho9Efy6tN9WKSV2M5kA8+lcvID1t0qozxo/uVCE7TtMvV
         9DR4j9MPyyTQXLnlQfLIu5CmryBxYR2WZubDFc6iEf5uCE6DQcBLO6uVtAz8fCWmXaRD
         v/4eKkuYGuBJpiDvC2fCPXdPwMIwMANDaT+bHIzLMWqbMcdC4gCH8XhjJh3FcJLYGSRB
         bjyFg1tjA8DdphaAH2G/O2RQonwso50TQ5TqlZJsbueT7Kmcol+kQKoaYxIzc9DQOvCE
         KZVg==
X-Gm-Message-State: AOJu0YykzDyYyWMy6bKUIeqfJSCMRzttzwPjDdoAvfiM08Uu1b5K/nxQ
	LX7KlA5ur8/7wU5EBSvdEkLTCXFOdRjBLGgHyITrmnO5wz9vSH3KP5A7BtTnJQ==
X-Gm-Gg: AeBDievWMbmNsWCAibJGkDY0R9zW7/eFd6AprQcFH67ijDLsH+c/XSaDN8txv6Mw0uM
	vG55md4gToNsXraLkg9D121kbuq5TT5oOmtSrz1N4RGIFpJuD1ucrDAcASMtjvp/6pRPEJYKECi
	OmKKIMM7gY2+872XS9odedYgy/bKb5UKl1sIljzB85aFh44vpop0D9AglknekyA594nHIui0zU1
	jaE0+M5AOUcWLkfBx8NZnM8j8RNafm/lcO9APg+z5J5A+J2A5meL7CL4vIN6CclH08FRWR8LnlO
	1k7AR1ohB8SExTsHc3SvPLSkgq2Kd1UqpDouo2OMRd0jR56yNyXQKeJ/F4YDz1nrRgImR/ob0Ow
	cpRQAOfy3kuQPP4fxjC56pU0EfmP/6ddg4iwl1u6HpqyErAN5XhoEaxsi2vhoIOLNSWiL98219K
	A6DCxnNupK5KeiVznw3XHP24opqWtMd68Cb2k=
X-Received: by 2002:a05:690c:23c5:b0:7a0:5979:8d9c with SMTP id 00721157ae682-7bd77105446mr81322187b3.6.1777935675476;
        Mon, 04 May 2026 16:01:15 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm55595727b3.44.2026.05.04.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:01:15 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v13 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Mon,  4 May 2026 16:00:53 -0700
Message-ID: <20260504230056.917415-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504230056.917415-1-weibunny.kernel@gmail.com>
References: <20260504230056.917415-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CA4C4C4B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284080-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 net/psp/psp_main.c                   | 76 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     | 29 +++++++++++
 6 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index ce0a03e2d746..a3853caf7206 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -330,7 +330,7 @@ operations:
             - nsid
         reply:
           attributes: []
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-dev-assoc
         post: psp-device-unlock
     -
       name: dev-disassoc
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 18a6e8bdb6a1..9d0461b7f1f6 100644
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
index 792a47105a6c..546c3611d50a 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -391,6 +391,82 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
index 8dbe2fe882dd..2fe7bb13eb24 100644
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


