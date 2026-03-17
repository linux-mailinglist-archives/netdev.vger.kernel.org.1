Return-Path: <netdev+bounces-268827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBO8OWPpuWkRPgIAu9opvQ
	(envelope-from <netdev+bounces-268827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94A2B47A1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8854D310A3B5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD433AD8B;
	Tue, 17 Mar 2026 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0JVRjtE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCD3A783D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791555; cv=none; b=HoKVHyMLvHGDHcc9gDOOBDCVaw0D7UZgTJyc1FEMwOT92E2KlqYjTgjCYneMut26qc1MYQ8FbL+iF6zfuzSLJOymIV5w7kyv2W9NoQKRuqOQzafPL6eimaWwUO2BykAqMqbwRoYGbgWu06mKGT283+nD1fc226IjwAGVVJdzDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791555; c=relaxed/simple;
	bh=xaAQwmB/emLJGJW95qBKo9fy65VJw13GM2llD/jyJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ7qQ16NEcRmgdQ5m5Lh7dbsfJS1Keqr8bksXosYIcopvfgq/ebsQH5i/3xKSDZMAfX3m/hoihMMlZxAOZp9dMfCcPFfCB7ESHBGW3wzd3CfyoJH4qw2KEyLoEC0nJxLB2nd2w2tyWeS43nxHZsA6uiFlx1ST7g2FkuR7EKjHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0JVRjtE; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64cb34a81c5so750985d50.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791553; x=1774396353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuJHg8h2oSkf9cXwpBXu1Y4TRq+6ictsegM8LgmkOkY=;
        b=Y0JVRjtEwCXqm6V4lUhc5NzXETTcPEJdYF9yZiMa4dD9UJfMnpm0fqGb7p1xJ9imbX
         r9UirFWk/hHScPpfYNc+p0vZziPx2z0svqXhjwBBdv5n6fpfiJGL8P2uXseWz7ihs+Ip
         Y6+rXTh8Lh/YdQVnW2ZBnYnwyt4GPsvwyXDFRnCs8UF+ZvPuA6glmJFxmLSGKNuWk7u2
         Ent0CwE2c2YFpxyTXuBF/Cea3SuCs1+WNh3/nUHZh9ZpH1GEI0Tj1VqF0Uz7PNCz9TEk
         zty51Z9XIbt9J5IXclGC0rxlhju7/G0WUFdRBFJcutR8tD8Hiczbr2x2bICUq7f5Vknv
         Yt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791553; x=1774396353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuJHg8h2oSkf9cXwpBXu1Y4TRq+6ictsegM8LgmkOkY=;
        b=l57ddsnPfyi78v/G7KzX5vIj8XFX1YO4HU8IOD3M3QnlGk7QdZrMSHglIjoxIVvQg0
         HtnSpkA+uo3atOPPGwc4qRjHy6yfNrvrv7sB5xicoNQHTDYjJk3nt56Cv9bMuFp5mShE
         ACizKCHCmuxSPvd19EQECJRwPmjlVuCuaSbUj46hqfEc3ARfc81KHDPXvarYgxB02yw+
         /NXQdA8b21WweSxvKUVMz5fTNh657KWVqDjE9Il6pEjLxTgvTQuTmt2Ys8G/QfqdJNok
         nFsAKDhIlbnEh8JK09Mzh0x4v4qOgQXa6kk3kAkDlBqRglG114Pmw5Z3/gX6d45ZSkYB
         qctQ==
X-Gm-Message-State: AOJu0YxaGXWw/7LoGslGl0g+wVCgDUONxbsYN5YkBaco74BN6nyGO9gs
	KnIHRNY9ncbkxDEzJVCpBIkWx/XBiVAM3u4zhBVX9DdSjzJ/r0sX+f9tqD1Yhdcs
X-Gm-Gg: ATEYQzznz7/t0Vy413oB3W1KqA8Rk1S325zJ9qDGArIEMxEycCdO5xce4eTz1LWQ3h4
	QnDWBA/5ordO8GT6eUgCqAek45u6rxuQ3eHgqf8lNOgf6uS4wDAq8o4dfunm2fg5BOX+hAhyvcF
	/wdOZIyZkOxmm0Qys6rvQcwWU48nzhlYIzugaEVuIC9j24BFwgwpMB9FH5+jQrzzwMu2vyTMnhb
	nyA4dUO4jwGubI52EFtEI8xuf8Fr+9eKZ/7kiVktKPWpxY5dafxGK8XkeKDpbhPHInuKK5aAhpN
	Q60B+XUbHTfBPSDdgbKrpVSuTdcKmoWkD//itkOSW/IFHrSe3WHhzvF6hG7M3JEfpY3/86Oh0QH
	ArsCwPlLapU2aM/fHy26P5GlzUDTt8ptWtFUsD2QSggwZYqVcWMJ4yniw8K/8UUK86DDn3OFENy
	Bgj+mDUmR+KBwU0EKwnD0UQsI=
X-Received: by 2002:a05:690e:1c17:b0:64d:294e:9c34 with SMTP id 956f58d0204a3-64e910e4c7amr1478025d50.0.1773791552839;
        Tue, 17 Mar 2026 16:52:32 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e915d9c04sm735196d50.0.2026.03.17.16.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:52:32 -0700 (PDT)
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
Subject: [PATCH v6 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Tue, 17 Mar 2026 16:52:16 -0700
Message-ID: <20260317235222.700615-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317235222.700615-1-weibunny.kernel@gmail.com>
References: <20260317235222.700615-1-weibunny.kernel@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EC94A2B47A1
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


