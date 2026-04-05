Return-Path: <netdev+bounces-275443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aElOGTT60WkeSAcAu9opvQ
	(envelope-from <netdev+bounces-275443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6539D798
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7154B3006823
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 05:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2736B07F;
	Sun,  5 Apr 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFnKVF2M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965F36B044
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368744; cv=none; b=SZ9u3kKYD3md1p9zyqPDtLAwHXt4MZkXFqUD28kaLlpb5zNy2Lk9IA/tgnOj0MDYN+wpYg7enZ4MSbFQ7TnnFG0VgM8mjbDfnCKJG7K0+9OHjjRtC8Ho8CKkCiiC11JjKVbQyU5iKSIeA36LXgqkHmDGPoNzekYP76PS1lZ9TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368744; c=relaxed/simple;
	bh=MFtBgO2F0c+0h6+fbnm9nL/Rynu8wVDlZkK6tRbCdpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrNx0p6vJ2fgCxWajO9UNCnjgC7A+s7vYTWtUS1gojWozeupqC/3+b+TRveHWjqVNdZoxFuRI8bwPQAP+MGPIGKIcqGAVvfhknSFMkuIXnHZFk3yZDA+CGH2CZ8y1qVMN4uHbUVrqcHn2p7L5MYWz0MOfdmrZzbj2DoRP8ACfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFnKVF2M; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7a2ec8c0a07so1203807b3.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368742; x=1775973542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw588awLGAFd0Qosq4KOdy5wIJRwGE4Wqxuem/si3gY=;
        b=mFnKVF2M2WvLXZwwFruXpwa3vMcpE+3Ectq03C7m5aWBLomZDL4lzix3kqtjJHgAIu
         6od48SbuIdeJw8YmBWzrORBYjeWZh8CtYM6uMNckwXnk2hfSQRPN04Hxgp+Cksox+iNZ
         2WB9OKMshqt0+IYWwdUUnh0X1siI0smZbSW/OTxfZEwwQB2DFawjxdsV8aXz8MYzVulg
         c5yMZoXJ9guMi8iBr43ayC2RDVLKM6Z0kkR1kW9+2o3rsNi5eg+0Bq7KtQ9S9DC+r1KN
         BZGi8NQhy/aSKsv6XEZBtaxyvNpFdU+Xdi32Wu2vOeJr0NvhnXWFd9qDK+KxogJKouQh
         g3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368742; x=1775973542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hw588awLGAFd0Qosq4KOdy5wIJRwGE4Wqxuem/si3gY=;
        b=KFa4aoLFg95OT0FT8r/7deOjg8rNW0K1Z0lPIoGdpYsTkTKzXAvlSpRH5RdvPvq2dd
         veL2cz3t7xuiHBH5xAcNWaMue1GdhMElBeYow3kGG6rAfnpTAmizuZrKiDiqk7KuMJyt
         1lOo+OLgozd3PSF4oPLbMh4uRkkp4xE0zfkI1Gh52KpfpfoAO3kVKDTbCaf5DeHfFxNI
         bokLf8A1uXVP9Q8AKs8izu6PiULgtg6RNeS7kBbElXJX+LDwCIpigbzvDKitO7IHffZ8
         yAJm+aab5T2I0Te9kR81/+ValFJSE5n8djIpl1wrO/TFTMM4HmMI9gtjR5GZQUWU741r
         wvvw==
X-Gm-Message-State: AOJu0YylXNktF4VJMGfSy8c40SFfvj60mHSyN6h/V1KfqXD+3r4JO0+B
	Q/9XO9GP4LCq6MuhVGROpVdi31iVr+Cj2Zv1oHVQ+yTgYdylFjM0M05HIGfjbniZ
X-Gm-Gg: AeBDietemlO9HL1MXJn30g5hXhbU0hcpzykYmlPWFOmaRLlqh1LdfMvYdwsrHFDiouI
	tK01/P4ThsT5hOHie6GsgiD9HlZz6jwSHOnjybxuNCXctjAPO+q4ZT5uhjDTDaTGpjuJXHfR+Dz
	OuDwX1Wdig4KUvttTzrV71OStnYjOrY6fKHRbpaKKzE9HDAnSQjFY5mtWM+rChkpR+rcS3IondG
	Q3XxtSw+A62k62SXg7OqqKAW0I4G53lKGd03bnRTEsNqcz83UvCQq+yq99MDajQ60ZS4QM5riuF
	yYF3pl1f+KHoJWFW6gD3dWhfHeju6aHuXudulygj8o6TSzYYaq7ym1n6mstNLRwckIVYqlI2rPL
	4kDQOwKLTMafe8juwhfx5oYuvMof5sNXWmVShoUe6X84wI1461i+KfEgNOJq1gpTWGHa/+9oh76
	dOmPyK5Sb+VhXMm/Y5np83jgKI
X-Received: by 2002:a05:690c:64c6:b0:79c:ed68:2ee1 with SMTP id 00721157ae682-7a4d5f5487bmr61375807b3.5.1775368741864;
        Sat, 04 Apr 2026 22:59:01 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea289e5sm38583037b3.18.2026.04.04.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:59:01 -0700 (PDT)
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
Subject: [PATCH v10 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Sat,  4 Apr 2026 22:58:50 -0700
Message-ID: <20260405055853.3285534-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275443-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEE6539D798
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
 net/psp/psp_main.c                   | 74 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     | 16 ++++++
 6 files changed, 96 insertions(+), 2 deletions(-)

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
index 0f9c4e4e52cb..c82b21bae240 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
 
 void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
+int psp_attach_netdev_notifier(void);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 97b04958c413..1a9ac4e551f5 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -375,6 +375,80 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
+int psp_attach_netdev_notifier(void)
+{
+	int err = 0;
+
+	if (READ_ONCE(psp_notifier_registered))
+		return 0;
+
+	mutex_lock(&psp_devs_lock);
+	if (!psp_notifier_registered) {
+		err = register_netdevice_notifier(&psp_netdev_notifier);
+		if (!err)
+			WRITE_ONCE(psp_notifier_registered, true);
+	}
+	mutex_unlock(&psp_devs_lock);
+
+	return err;
+}
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 60d29a342fcb..09057fe60345 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -167,6 +167,22 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
 	return __psp_device_get_locked(ops, skb, info, false);
 }
 
+/**
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
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
-- 
2.52.0


