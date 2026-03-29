Return-Path: <netdev+bounces-272855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBX4EaOoyGmjoQUAu9opvQ
	(envelope-from <netdev+bounces-272855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B13509ED
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEBDB3025145
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 04:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820E277C9D;
	Sun, 29 Mar 2026 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDihWpY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C8487BE
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774757979; cv=none; b=U6E76HfoiJuEamCrSgVWyzHEtQrlmXnqdygiGYmtmHNKLe+FRXLITtEj4DpOMlnl341tndI827lfG5NAoVJf2oaPs0JvIHqcyKXeGx+fs2Sa1dECDkoBsZGoHcgzeQDpJ8A3sCZXFM57ZMGtQbY9PPHtZB45yZIoFDnds1Rs+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774757979; c=relaxed/simple;
	bh=mWDIlaaqmUWsQPkSRnMJCwsq3f1VaN+RBn6mpHhYtfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm3nhH3ofXfDpjWhCyX9HTHzGeCaqvCX0L9SbUgAapmHC/AhMap49rpRmKPY3ltCtbn6M77LMMv+X8bfPBTn8CBINwseRU0W5GyEXAxk8fQPpzCuXgn+g0PQymZVlwpH3H7gSBsVNgFNEjYS2wID100xvM+E7JxGalldragCglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDihWpY5; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6470d549e10so432616d50.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774757977; x=1775362777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYfpMAFbESRxq1lio2/L1MMmI+lZgUGfvPLM3VLOCnY=;
        b=aDihWpY5sd6H0TkwpM06IHBppW2MHqzcAUj92fcAwciMal04vMjUz5Sd7UoP8BEu3d
         YoIRHDvfkOKEHD7UYQGz/oNcej0Y58CvgVKtBNzMB99q/lKY03+Mnaorg18Aa7cdW7UV
         y7RX/augd3ShLVE3mq/b/NPa5E9E8gU33n7AjHfIh/WQPWJeLyAsOt3D6rkW06rHY1H5
         1dlrxDvFlAeQImEHQiPtI6IkWdHV4ovrI7GWpMg1dDz5KQ8vYXmfe4+i9h/U7cuwmR3B
         DPVnRCwWThMSAplfbVqP3Y4vgmYBdSmRldAM9k1hYC/wPOC1hYNnyLddQw2pa4oDSUd+
         uaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774757977; x=1775362777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TYfpMAFbESRxq1lio2/L1MMmI+lZgUGfvPLM3VLOCnY=;
        b=iVBnx1ca0W1qETpzRKTyGP/Tdh2Xymzf1skrkqYBLF6IOkFQv6CmDoNbo1Ex0Gc2+R
         n1N7lQgn3j8QF9KANzxgR2fuz/3GxKB1RPk1E7m7cfs9wf5fINBoBybBpRPA68C16dcI
         AczU4UhmM+ypkgBXIrnfLvhjjPV8IcjJl2URRLEGWwiFcIqTmKowbAMA+gxBukUn2YWy
         +FsPhiMy7uYufBPAz/5WfevjIc9m+NsHZXZVUiz1gGKFf+EY7S7jXL7665YSnV/RdQGp
         zGRkK6CSzdqFfu4GhqY5JvDoEYZw+1t65h3Rieb2T0A4b/LKHPb1osmpfBiknFjW2y8I
         vzJg==
X-Gm-Message-State: AOJu0Yy71vmvp3lkdIbsNn9+5WEPPmNKgryxYpCtl/PrZqPuG75NwB3c
	XpX4JqIFNGONt162VUr/tIfPRWVEHi7iERxD/+9AGOcrHY4z6jYZxtoQyZ2SH8ti
X-Gm-Gg: ATEYQzzSjotLsrPBP5rKVsvhBtAOuyut5pH7b5MwW9pmmcjul3dA4W7kKtnp5ksHanW
	e5aPSew6IoTNU5DK/kT4wwy3u7Z8/F4JuEEXCScu25ghhknZ6aKlg2gZp/hQT8Mps3PGesuWeAy
	5oE0Tq+kNaby4VQirBs08DEnPp3SZp/npibSUeQ23Z4253FvotpER/HIHNhUr2crumJRREUBcST
	2gSyQ9oN28pc1OWT81iye+1U/0CK16Kbd3796fqSFOgyxT87xC9H3I05Uyi+iU1IZQvbCBbBc2w
	yWE/ftaIoqHkLk69myFkmZCfrFvk6nPv2OVAwEkC+L6AhuZR0J7Qw5OB+Nni6A7YUUB+WKLzWWz
	+71GBWVaVnt0n1xBrjqnze0MbX5bisYdqwL9pFeY3CkUqPBQx6s2HM9HrMAuaSOuzKRAp1V0d1R
	kzorX6Vb48hBdC1djIxkMR0do=
X-Received: by 2002:a05:690c:3501:b0:79c:ed68:2ee1 with SMTP id 00721157ae682-79ced777d8fmr28375677b3.5.1774757976568;
        Sat, 28 Mar 2026 21:19:36 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79e91a65955sm208677b3.9.2026.03.28.21.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:19:36 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v8 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Sat, 28 Mar 2026 21:19:19 -0700
Message-ID: <20260329041922.3850747-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
References: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272855-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB8B13509ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list, upon the first dev-assoc operation.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 Documentation/netlink/specs/psp.yaml |  2 +-
 net/psp/psp-nl-gen.c                 |  2 +-
 net/psp/psp-nl-gen.h                 |  3 ++
 net/psp/psp.h                        |  1 +
 net/psp/psp_main.c                   | 70 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     |  8 ++++
 6 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 336ef19155ff..d7c1fc62de1c 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -320,7 +320,7 @@ operations:
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
index 0f9c4e4e52cb..fd7457dedd30 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
 
 void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
+void psp_attach_netdev_notifier(void);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 178b848989f1..160eaf3e7229 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -375,10 +375,80 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
 
+static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device *dev)
+{
+	struct psp_assoc_dev *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev == dev) {
+			list_del(&entry->dev_list);
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
+void psp_attach_netdev_notifier(void)
+{
+	if (READ_ONCE(psp_notifier_registered))
+		return;
+
+	mutex_lock(&psp_devs_lock);
+	if (!psp_notifier_registered) {
+		if (!register_netdevice_notifier(&psp_netdev_notifier))
+			WRITE_ONCE(psp_notifier_registered, true);
+	}
+	mutex_unlock(&psp_devs_lock);
+}
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
 
 	return genl_register_family(&psp_nl_family);
 }
 subsys_initcall(psp_init);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -159,6 +159,14 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
 	return __psp_device_get_locked(ops, skb, info, false);
 }
 
+int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
+				    struct sk_buff *skb, struct genl_info *info)
+{
+	psp_attach_netdev_notifier();
+
+	return __psp_device_get_locked(ops, skb, info, false);
+}
+
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
-- 
2.52.0


