Return-Path: <netdev+bounces-294974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id viyMEx/BIGpD7gAAu9opvQ
	(envelope-from <netdev+bounces-294974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D8A63BF83
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:04:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="XsV4M/h/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294974-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A9930AAA40
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E334DD6D3;
	Wed,  3 Jun 2026 23:59:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B074DD6DB
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531196; cv=none; b=tit+TISQQsJfN04D3alNO1QXoi1y5XYGzigu0oZJyEkpbsPUSLaQZ2GyI4CMPcLwoxp0TWu7s45kaKcj2wwi9Bo/f3cktdhCb4Pr/acKhiwuyghxC1EVXbpf4ybT472Aj6QJgjeT5hspDE3Am8XA5fQQyrABSArpGh4v/ERHJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531196; c=relaxed/simple;
	bh=/40SUS8Vl1GdK0/VhQI6aDMcEdHkL76UBQgleYRNrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msXj1sWjCNddhQA6G46q9xlaBfl6WnsMUNojo/1VIYMP69sAQtmnJR6yZgU5BqiS0XbPowbFSljP+UPC9AQrVsDpWWlky+DQ6M9sJTYLm67FHrCKVFO7cvms7I6NVjElsiWc4o3cLvAAWC3hSUk6CeRzCkpI/GlKvbJumg7gETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsV4M/h/; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e2f9471acbso132187b3.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531192; x=1781135992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3qZTIkyNba/Nix7bR57LVD52kMec7axf2mp55aY7ls=;
        b=XsV4M/h/NJlUvQ3s7niNuCyhNCg7JJ5smOMfLZV7zF3hP05X76CgkgxyF/SDS66O5J
         DVIV1vOqRNyXGwT9PSbOXZa9pvi6t/Be8GI0LlH13+GXtxwq7f/PGGRWD28lkncD/5zq
         mK65kDietRNqE7U0EIytEbG8HPZYSettplRVFh5Q1GpKuxx0uiImV/Ea1rIBHkcRP8ll
         7xIZzF0rHTTL/u6o0eFM/Rd+XqXYZ5AHYEg/60sdQOaFfBmp89gbdgER7B7AS+lo0CMB
         8sKrGK73Te3CSxNhjZsMBXC3jEGlt21mEqHOrqVGz8sMKWQ8nNabhp10irvNdROK+DkA
         8BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531192; x=1781135992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3qZTIkyNba/Nix7bR57LVD52kMec7axf2mp55aY7ls=;
        b=hWvuipC+zZWy24ksvj8pX7dsK5TXcGDGKuZuc/FKRX7SGRNmYnIpl42TWz3qgFe1UL
         jCsQzV3ntkzGTvkhLBqTbnoegMsNSX3a6rddyprp+LDNXyhbLXm41X2YV0Cm9RHDnMqT
         EoKN4ne8YsUuhseztCJFs1p70HxCEYpftze+KJKwT89p/qzZ6z8AR7/znYuzWTxqFz8u
         N8h6Pv+r5psX+lU1SGIrmDuPhexvuT8MhmEm5CAC63tE9HnL0FcqWnZmbLLH/ENDLd2X
         N/2ZfPxvtcPyhMmbjw8r1Hvq8Ogr/iTcm5SWKYsxBEFitVz4HP+BYz8k9UiAswrHuClK
         yKNA==
X-Gm-Message-State: AOJu0YwiPge/3YOnUwefHTXyKN56VKAFNsJGd4uVMA+GQ3/aXaWbksMM
	GFkWRRQrNC+WD1lsZ98Ja33MjDblznkikgPKsea3eKlyr9Eee87lZkzR52a5pg==
X-Gm-Gg: Acq92OHhoy7YP6MjWKapKD3oikNRE7PUf241DokthKQbRNPmv6yWjTkt7xZ4nJp5nrg
	DfLooXRgxK5Kz4Y1McG4Z6PczX56qldzS3yr3gcKdZxcz/uhYr1JGWmpFiawSeuzIKnwPIqZHdw
	rPAmKQQgDi6Dva/2bziobwPzEJQCWaWviKT/IsDYmN55zLiH680wRDk1xpJ2jZc06QwOiZydrtC
	+B04CWu/EZ23kUJSv80b6RgeR46P028D2n2ogxR3BTJw2APLYaq0PbH0xW8fqxgRAzI+tCGUNOV
	kyq/cNsGKpePqsc6n5XGNaBD7pLF31SiLLiRErZ+VSDbVJDEYMPPU01hMGIbQhC8SaHIhrbW+8r
	TWLGHqKx8m/9c2EeNhekUXibx34S/LA5goR389U2/MtXsITtrSiqe+6H+i1ajnEtm3gRQ/VPTjt
	W10klEKe1AwWfQr1ZIYaG1z3rqA/fp4IHWew==
X-Received: by 2002:a05:690c:e3cf:b0:79a:649e:2686 with SMTP id 00721157ae682-7ebd8cd1b45mr2654117b3.5.1780531192541;
        Wed, 03 Jun 2026 16:59:52 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea24098d1csm25626107b3.46.2026.06.03.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:52 -0700 (PDT)
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
Subject: [PATCH v15 net-next 03/10] psp: add a new netdev event for dev unregister
Date: Wed,  3 Jun 2026 16:59:32 -0700
Message-ID: <20260603235947.2986110-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294974-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0D8A63BF83

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
 net/psp/psp_main.c                   | 75 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     | 29 +++++++++++
 6 files changed, 110 insertions(+), 2 deletions(-)

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
index cf381e786cb6..86eeba823ced 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -16,6 +16,7 @@ extern struct mutex psp_devs_lock;
 void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
 bool psp_has_assoc_dev_in_ns(struct psp_dev *psd, struct net *net);
+int psp_attach_netdev_notifier(void);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 470f6c7ce9ee..8b2f178e317c 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -405,6 +405,81 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
 
+static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device *dev)
+{
+	struct psp_assoc_dev *entry;
+
+	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
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
+		if (psp_dev_is_registered(psd))
+			psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
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
+/* Register the netdevice notifier when the first device association
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
index a2058aaf0f36..9610d8c456ff 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -160,6 +160,22 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
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
@@ -518,6 +534,19 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
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
+		goto err_clean_ptr;
+	}
+
 	rsp = psp_nl_reply_new(info);
 	if (!rsp) {
 		err = -ENOMEM;
-- 
2.52.0


