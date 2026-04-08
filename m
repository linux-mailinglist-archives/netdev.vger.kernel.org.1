Return-Path: <netdev+bounces-276746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHY3Kx7i1mnUJQgAu9opvQ
	(envelope-from <netdev+bounces-276746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9963C4C0D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF24C3037E5E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768133A0B05;
	Wed,  8 Apr 2026 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPPL5bSe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBC378D9A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690069; cv=none; b=ohg1fzSEUkP9NoDSiOuaVPOQEiriwrq9udOmpcOJI78S3myb79yCr1GwY4W0xrTR0PR3AA4EidR8Mc/z8Q57KBSKu9copPGxmZlW8LAdtorSXfSR+OUABEbF1VERAN2qjBGUIfu6THoNAbir4M4BNujfn/isSkmfrOM74dZNONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690069; c=relaxed/simple;
	bh=JFe8AwCz23n8EAx9Eqt8J+jK+pT5X7hjP5f/QZLiUZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gghAtLHk2xQT3YHHNdvCRXwimGAb98A8npSC/YIWvwl2gQWty1WiUVJrOPSR0i/h1u0BPSmt7EQ+hAOgB95adlv5KTX737DoxzoSnqi1slT/ouc6mgbA2DH0I454iO+P3bZLR6ACDqxv1ohrbhnlpL3Ftup7LgD/eVSeGABayjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPPL5bSe; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ee072d105so32045d50.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775690067; x=1776294867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycgEuONv+R3OgLyfOHvi6muy7mBx93xYJlD/Vd27ofM=;
        b=qPPL5bSelaWwnGAEIRAZKjgVmcsiddJL2gLgJ5JnEA9QLDGk9136m5qmf8pqFbGK7D
         RX/txZqIWDwtkMfuBVzU7oi19K2Rs9IitSoAAfAhmLilYJQ/SG0VUQm7zumatN/KESyE
         12EG/d1ZQ+WvgpEO6pJFyKD7q51n/x8qA94hlwJA/0r18CzCZHyjjN2yJ1aVJ9klRxOx
         l2+XmqYKOpELPNF/MPy8jGCZ1DNZZrzw3uRrOLU27utYKEiS0Y9T2sAIDpCQBSYEmgWI
         0roSj+TPitxfKmNOGokhD3vAFjYFh7Nrvk0LYJA4eAU9tnVv4BoahZMuUrxExAXohl8z
         rctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775690067; x=1776294867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycgEuONv+R3OgLyfOHvi6muy7mBx93xYJlD/Vd27ofM=;
        b=VJbd/uYBntBQ3U1Kz0MeGze2YWau7eX7SmFmUakXbKLLhtfxi1GZjf55AMg2Pph+sk
         q1rjprIx1uxrvhCQBccQatubyyWjWQimotCYRm7T/F74zsQB25+6da7y5MWfsPFn737q
         QHBW9NLeQSph9xZyn/u7o3B/qyCVVwi1QiGHUcQsglCnVFRgzaU3C2m15gx3tBnbC2Ia
         PK+Y7Z/COD0398V9fnj0BaB8l3pkWebXv0ME9noVNwGtV9a4ocC6QaOrke7nHK5hVDE0
         Dz6o9aIXdRMTIciHbskIGSBi4NbiKTskV0GJ6IIjX3NzstLEKSMNZFXzciOA7noKwzFE
         0yHA==
X-Gm-Message-State: AOJu0YwAdneGtKjl7v5oPei4JEZtirvoWdcl/xSZtrwJfFO1hAN0D6uB
	s4Tx93EXwUmAWiIMQt+nx+mr6kdN9s+A22BCk6taAYe7zkQEfBmgn8OK/YixiQDM
X-Gm-Gg: AeBDieuUh9wdZKBvQD9ow+zq4jk/DUQj1KGdyzLVFKMFM1cul3DvlJSlsIAJbygwinG
	/zTOAhkipQ5DeYoeCOus5zVEcbp6xmUseE5x99mg+9YY3dgmoQ43e8D1YSPXZaXWfSYV65yOixd
	w8p7Ytn9C7SGzbkIIvOOH+1lYnewpMmafzTdazV9GIE0Ot73Uxx7ZskmQ2Pcb5Trt74/2hjPODz
	kcumk0yDMq48PapzeyXg7cMuu3TRHH7cqD6eMsP/KVgISlnmwPCjfAUtPB69g7rkKt9BXa5tWBP
	gNsmq/fOOhl9Pk1g7vF+I81sxWiL6zv5kYZ328F5LN/d+2nytCxub9RvDCBFsNwi2/Or6uT8i6X
	9DrV1yLoINiKoo99znDYdf+0E8thI8AVrGKB30ZHw4MsPNZ0qtrZsw1ZrsTqKAuFrM3+aVM//D4
	SQd/g5VSSaEGdkzIyMGWn2d1PO
X-Received: by 2002:a05:690c:67c4:b0:79c:ff02:a03e with SMTP id 00721157ae682-7abad2e3dd5mr37592417b3.2.1775690066911;
        Wed, 08 Apr 2026 16:14:26 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e31ff04sm91271907b3.7.2026.04.08.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:14:26 -0700 (PDT)
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
Subject: [PATCH v11 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Wed,  8 Apr 2026 16:14:12 -0700
Message-ID: <20260408231415.522691-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408231415.522691-1-weibunny.kernel@gmail.com>
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-276746-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 5A9963C4C0D
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
 net/psp/psp_main.c                   | 75 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     | 16 ++++++
 6 files changed, 97 insertions(+), 2 deletions(-)

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
index 97b04958c413..90836997aa97 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -375,6 +375,81 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
index 8f2b925eda00..8f87018f1a8e 100644
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
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
-- 
2.52.0


