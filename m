Return-Path: <netdev+bounces-270293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLzMCyJrv2lk4gMAu9opvQ
	(envelope-from <netdev+bounces-270293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:08:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6C2E82EC
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD478301BCF2
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 04:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3937FF5C;
	Sun, 22 Mar 2026 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAvDGXhH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32541E9919
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774152437; cv=none; b=Nq/oD1Ebl2nlwcj8giQoyfFSYhRZ1zssNeA9AgWQ/yJAacQKvkUr86jO1Fu9cqerZWpJUiX9eOjPqd4QJCzgjMzaHa4odjbY+EfF3OKeiH3g7yl1n9wm9PaUIqojTeGyhh8zz42dwFIxZaiOMLUtP4E7zo35aJEzgfZNv6pCQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774152437; c=relaxed/simple;
	bh=xaAQwmB/emLJGJW95qBKo9fy65VJw13GM2llD/jyJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqCCMLSF3qoRE2Nt0gjrIPl6s+pWAk2mRBcMOJ77jwxupm2dwfRuB7LFsJalPcyGimOdhzn3zaZaDBY4z9SHixYtfnmb9V7Z40H/UWkb3PayIoSC6ZmAI+gMpmQ79IZrpJBwQ9vRPWe1nbEmwP71TPcYwGPpmwaQPTsIZfoDcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAvDGXhH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a350ed246so1978237b3.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774152435; x=1774757235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuJHg8h2oSkf9cXwpBXu1Y4TRq+6ictsegM8LgmkOkY=;
        b=TAvDGXhHkDneM3cidQLDWZI5yZEnG8aEVQfkVAD6O2goA5tiWu8TLycGXlhWpkG+3m
         QYL1DUrz31bRnzJ0RmRHn4mqH6Lg1bhXOFaNieAcikr2CczpjYr2myDhvv4WM1ApVnpr
         XJRePL68LYRB5pfeO6nanrQ5dxUTG63tiBaClAfRQTOOmDnnGP1Zjg/t9WUen8Yxp2KE
         oP8c0zrKIeKS6w9EFBJUFtJxPoOGYbc6Hn57nQ1oT/VjI4pRjEJ1QygDl/YDbnldPO2C
         L6mMmcgev4u85elcBmYLvNvDsyQx+E2ygKagj4XSPXUmBz4HB/MZeHLifG1z0jse3LqL
         YOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774152435; x=1774757235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuJHg8h2oSkf9cXwpBXu1Y4TRq+6ictsegM8LgmkOkY=;
        b=mXyYzeDpYIKNlMMcGeTeo7f7jfnBcXjnAQ527qY1tHwm3aAY5Ab3L59nB9OhIVYvlM
         cnVmw8XN5pJb8yk2jeOZrIWOEpwEB0KG8/T/hwlkIt++YA+J4JOb25m2YyyPCuQ5JX6s
         XIofyexWbal/xht+BPy5n/nVTZbxiPEZVz1wLPBlCLoCSn/77O6ww2w2XJ2Q9s0r1Ltq
         Lasqh7liY4v1a21vhQtPkYy2sbvltZW9H+9wTT3Bd+gmIhpCguxwiJdNFfqRdcXW1L6B
         rKgi2m2lMIY1LPZv96ygKDsLcECDBPTOoc0aXlsBTLylPh+w1QZ/IC6Ke5RLFTYs60jt
         d2rg==
X-Gm-Message-State: AOJu0YxevgPLEBdnCOiAf1fXAD1A7JyykdVtDEeoUn+F9O6MI3J43isB
	eDYT+AvsCstjk4nU5btgLbgRdZlrB+LU7/3GomPaXVK39IHN2p6IqgbaXHdZL/cs
X-Gm-Gg: ATEYQzyI1W0mxD1cvueX1p6uXzqKmu7iKAs4nyVrYVCgHhSG/rZdAhY0n2otEPm2Sko
	AfTmDUTNBgIFrwtIxp7a7qcPdH6tHJRWHRuDg7qbHNsazQaY+YEgTiIi9N7S7riZfzeDzWY8we+
	SdO2ei9tob/AC1PnEkvsmfRgWox6UO4tTNUqUX7irbfx0+2gZVbJVazj5Gl53i3XG4O09n0YbvE
	XU8/HgUYbfeGhokw/MpB9jTp8vy696ULxYGxzUTwyZBeaxS8+48MI7TEub4mjn0qpiw+F634gb8
	1PNcCbXVt+tFEdAEQA5gqcJTZJt2GNERX1QHKPqgGAO9gVmiqekvqN2T7fq35M0D9+YS1vyvMHq
	vHNbm/eS55E6WkzcTyKkoQxiX5MKeECV+iAQyDceDOEa7oOlIl9rcfwf17Dp7rmtlcNHeK4MlwC
	JAjra31c4noGkGHCxcmi3okWDd
X-Received: by 2002:a05:690c:c1e:b0:799:7c33:e626 with SMTP id 00721157ae682-79a90b8800amr70468147b3.3.1774152434757;
        Sat, 21 Mar 2026 21:07:14 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9054bee1sm38701667b3.32.2026.03.21.21.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 21:07:14 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v7 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Sat, 21 Mar 2026 21:06:49 -0700
Message-ID: <20260322040704.991766-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260322040704.991766-1-weibunny.kernel@gmail.com>
References: <20260322040704.991766-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270293-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AB6C2E82EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list, upon the first successful dev-assoc
operation.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp.h      |  1 +
 net/psp/psp_main.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 net/psp/psp_nl.c   |  7 +++++
 3 files changed, 78 insertions(+)

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
index 178b848989f1..db4593e76fa7 100644
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
+		register_netdevice_notifier(&psp_netdev_notifier);
+		WRITE_ONCE(psp_notifier_registered, true);
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
index aa60a8277829..44e00add4211 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -515,6 +515,13 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 
 	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
 
+	/* Register netdev notifier for assoc cleanup on success.
+	 * Must drop psd->lock to ensure lock ordering: rtnl_lock -> psd->lock
+	 */
+	mutex_unlock(&psd->lock);
+	psp_attach_netdev_notifier();
+	mutex_lock(&psd->lock);
+
 	return psp_nl_reply_send(rsp, info);
 }
 
-- 
2.52.0


