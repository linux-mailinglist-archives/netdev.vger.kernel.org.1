Return-Path: <netdev+bounces-273349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMoyOU/6ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:33:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B683361FC9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 482C0305ACA0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960DB3E5EF7;
	Mon, 30 Mar 2026 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgyEIfDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013D3E121C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909925; cv=none; b=WtAyjd93/KyluG+JJnnUJn7XgGHkxUAvV1lW+T0/Q8yJ7yBhti0elTbbfFs6aORjeQrjf3nAHRr6BO/OIziKMEYoq2j9bVfPR9dcTjMa0kyGWcdA+Hg2eKPFnONW5eIOiOwtEVYnr55nnVP0vJgydUBEacUhq/YpqnVV4jifmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909925; c=relaxed/simple;
	bh=nvL4F1EMyCcTXJ5/JDAbNnx0SaNT4GYo0GAWARCUGnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl5/+PuMP/tm+I4yx3rd1i9dtNRIem+FRrZ9Zk0AAeEuiJmYOD+/+OHiJg3rzUYy/3qariZ0VtYJIMKCwzPEfzNNn17W8dN79enCQhPS0qSYpDVDiP8ck6u2Tp8m27vOSEWkhajUcr3gaLIdeibjEY3MPhNC2C6n1/5S0Eho/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgyEIfDH; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ee072d105so813645d50.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909911; x=1775514711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia2pXaacJxqVW8U65rm9c9otRG8MxkuOMZodgHKgwjE=;
        b=CgyEIfDH/7WT67YGjjAXZHePo3D3kpBhVi1jqFrgoycmJnysSOBn+VlLNfI8DtBjHl
         fxAcwl3i5o2TcqaCo82ZmVDy/fEI9BqdDMoI8i+P7cZs8/BrKe+Bc8/1jG1wGuRGNs83
         kJptj2zuoEk7hSwQ2sK3ue/mrwyuOFQNEAsLHVxveZMS6ftoZOovgUEGYVvbZFFT1pqL
         W3ZB9Va8te1Zkrf1AqD1A3l7kUtp8mg8qDHT4NTMesfbj7d/wdK5kYMfHsyk6ZO+HXMb
         eyHsEAj9mv90gj58zBBrUd8S74cQbFGTsygM2jZ5iXNfLjnvaXi8yjV5s5yiPXU62Pq6
         T6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909911; x=1775514711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ia2pXaacJxqVW8U65rm9c9otRG8MxkuOMZodgHKgwjE=;
        b=AUHO1vR2s9bX4oPX+ePIpj1W1lD2IIPKQSXHBkqMVPUnmdctWZWw8aMM3GOIu55E8S
         jQDktHrpVRsrQb/lIrXwywxXd3rxob+h0dghoGUvogOZRfXn8whjgMXPE9q6p6AgYa52
         NJWdA/xqEHCtYxL1+5VKBDTfwoAekB0t/i/NwX/9R2dYwpowaXYLq/iZdLkvdLPvZy4w
         JGVHs684RRjcPbkxBcD5ZirTQnnlLFQDR02NEQRjY+6A8ENKAMfZzA9ft00Sf+/yYDnY
         vjPnfynbytfM/y4nxmSlS1JHwIRYAPprBJxxDUlzPQbx7ynPgvAq4H5uoYIasJbuKc63
         ODng==
X-Gm-Message-State: AOJu0YxrKpRg18bOigL8BQfw/v88RCr68b0H21yy7lTBhJfmIdRdz7fi
	EhDauvkrsLxmwZLJo7B7pYQYgdLS5wqwxQNKxu7qMhJ/ArMXkis99bsouayYw/Ve
X-Gm-Gg: ATEYQzzyCkHsuRbNHZdYABe5SL3LAastZoTgB5Zls31ndZ/XQryj2g0BsXUzEHjUjDu
	GSJ7QNDBoX0VddMadrjn4ge9ycLo68+8gFH3im5/Ft60MIOE+pbex/hbxO3Bl+win7ElBkgux4N
	+QIbuSWVv+TkuuwV3KvyJ4ur927To4uJ+Y2MQtlB/M8djtGw35Jht0HLBS33wF2pQIBbsk8c+F2
	wijNe5CmU6gjmChXq62MDnTfXTgVnjMzBDz3k6Kz0eN+xRCXTFcU43InAgpVX9Us7ctRlbjz76x
	oHrupkmDEayZhNO9260K2Iq0+rj0RVrPhjJQ1gMMZzYsc1B2C886i1zDOCdmg91xwbEZIQpLhyt
	CNAIZm0pJYwQBHdsu5IGaRbLsfQFyuu3UQI6AsRiyyIc51e3nirdIk3x/YYKhj3pJrOfBJ10yn7
	MwSGIGBKDiybsbUEV7utdwx9Q=
X-Received: by 2002:a05:690c:46c7:b0:79d:4a94:2329 with SMTP id 00721157ae682-79d4a9436c4mr72869227b3.3.1774909911111;
        Mon, 30 Mar 2026 15:31:51 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm41421047b3.28.2026.03.30.15.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:31:50 -0700 (PDT)
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
Subject: [PATCH v9 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Mon, 30 Mar 2026 15:31:40 -0700
Message-ID: <20260330223143.2394706-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-273349-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 5B683361FC9
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
+
 subsys_initcall(psp_init);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 8a70848c74d7..e77c4ec3991e 100644
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


