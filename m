Return-Path: <netdev+bounces-279529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KKzIgq542kiKQEAu9opvQ
	(envelope-from <netdev+bounces-279529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:02:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C878421B8E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDC53018D4C
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5622F5498;
	Sat, 18 Apr 2026 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSOPMDxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65823128A3
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531693; cv=none; b=R5tlviQRElD2qPEbyEl42+Bvy956XVApOUvP8n86DsjHQF/DnPJCTcmT1auaFyXYRCGy9xCPMxz1tRNOXrqL0VB0wApoS4ddzz6GumpLJux0gKtdMQAalLKHF+4J/xiGqVYmNMT38+7ByLRX+Oo9DKCRIir64/pdqmmt+x7msgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531693; c=relaxed/simple;
	bh=J6esjVZxd1VTXq5TIFvU6Q0Ue1ktI0Qm/1At0zzEDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7WBhWn/tGOyo8sLUX9zFJTpeEEqMiTJVmNesmompHITa1LNoD3bGx4ds4tctPMz93z9pXCRK8Zz4qOW+HSdHSvOVzH/QENCx/Rmf5amcPjCbarwKtKdVohUpkWQnqN3waPpXV6MpxT30VRIwh64MvNNTWRExKzuI6vboe+Vtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSOPMDxm; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-651bc5494b4so252444d50.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531691; x=1777136491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/PCvNJ6KaRuSRpjGZQBJOFcQdGv9I2AVBT1aKol/lk=;
        b=jSOPMDxmb0yv+8yJVWftzckSuBJdbIT2linQ8IAKXJbo3UntzTmIvPX6A3tnlxusFN
         HnAxRIQe8Zzf/Wj0CoI1wW5EOIMD1iToG36QeSU4EizX/Er7KQBskGgZPwCLgn6v2lQN
         0UZAbUdyBzoQOHzxPiUCPM2W3bC645SOInUKDmx/pqt6zQ76g0u9ImRhJEFXLwhryAit
         6yYMZiUW/9r4fRlKsIYwGa3T0Nlth3tZV9f6LtPl534DwdAoMnbYY6Te+rK8jz5qAjp/
         6blcudrPvGA7nfYOtLIM0wC0hfSxVJumu1hmcf7LzezEYDSlMQuLIbajxso+Fl/5puZH
         amQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531691; x=1777136491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i/PCvNJ6KaRuSRpjGZQBJOFcQdGv9I2AVBT1aKol/lk=;
        b=ATe4y8zlNdF4DNbpn3kAiLnJqA0k7dOZylOsRcO3BgRhL0hhTOP8mM80FM8mfosFS0
         a+bq4cWU5Mi7dAwgDbxMYIuVfLDAHmaKArVzl4QgQGLuQMOnWqqcd3iGUKYrBLMQTrG4
         TYsrXbr1MwAbuKy7K+TrxJCZlHhkvX4O/VkX2nIB0yif1WkIcCjoGbnRVpdBv13dAzvj
         BVriVqIppdOotUQ7CrebCKqTEWakFZriB24lGb8mkbZ11VyRZh4+7gOQLDN0UZbK0oZZ
         z5nYiEcqVufjlzvILuiYmQUjNJOS4/9GZRL0/ck38jSvAsH243X7768c+c4aqgiVi0WN
         yzTA==
X-Gm-Message-State: AOJu0Yy0ZHqliufqCEBZNRke5Qqlwdl3hB8zRMRtTz+LeDRPXbbo35xN
	6W1BQ4lWZ4ofNhrZGqvJF0/sm+OvOxKkGP9KByK5uqsBthj9oZQ29qvcZkDQJQ==
X-Gm-Gg: AeBDieuFzCOnTuED9/Vk+RcueIJWtBG+xWLBvWIC6pgzggjJ6ItnxualRPQ9vmlCDkx
	686SgEKnW0yqEXJigZrNxQdTCRRAu54se2S1x8yFUwHKBZ2EW7uSNcHdGcO0MBvyZVMXmO4MtzZ
	MkQBrNvUfKZdivUTrVOulfdSYzrv1zFfxorn5PaDkTJEiTLzt5WRsHXrp3kfREsAyKBgL/p/cRM
	aK7Vjwmc2S08lKUYyceI3BphhIqmV4g1H8ruuUD/N/DtVrtaXc8YJmhyeHDKi1QSWScCORKuiz2
	cZt1AvqWJ8fi7oDrjW5TJnoDmZH0PHsRV8UXbMn9D8eZHX068ZZ9BRj8mfDyibq0mKN08B5uPzU
	Oamev0oHlhXm913fgj9LlW69xB2WGVoJIS1rkCzZ/mnHCarHjyeef7ZmeVCMDKuGG95ZuxASbGC
	mSOWivYyrDE4QHnCfMG/clJVA5W8VnjCd3osUMPc93OfIleg==
X-Received: by 2002:a05:690c:e348:b0:7b1:2c46:94aa with SMTP id 00721157ae682-7b9ed12b004mr48252247b3.4.1776531690648;
        Sat, 18 Apr 2026 10:01:30 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8be8e4sm22104507b3.14.2026.04.18.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:01:30 -0700 (PDT)
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
Subject: [PATCH v12 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Sat, 18 Apr 2026 10:00:53 -0700
Message-ID: <20260418170056.3490525-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
References: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-279529-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.909];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C878421B8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 3d1b7223e084..538ed9184965 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -328,7 +328,7 @@ operations:
             - nsid
         reply:
           attributes: []
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-dev-assoc
         post: psp-device-unlock
     -
       name: dev-disassoc
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 114299c64423..389a8480cc3d 100644
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
index 9049f1d2ff02..5a134b72f320 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -376,6 +376,82 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
+/**
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
index 75ca32821d28..d622f91a979e 100644
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


