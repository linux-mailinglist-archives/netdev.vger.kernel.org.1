Return-Path: <netdev+bounces-267556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNAGOpxXtGlbmAAAu9opvQ
	(envelope-from <netdev+bounces-267556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:29:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 482D7288BE4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7BB3220619
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498573DD53B;
	Fri, 13 Mar 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkSVo3u3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EE3DD528
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426501; cv=none; b=QoI+D3HJwhGMFXsEIGHyPpu/XoCrAOPN//vngFEZer9G5d1UklEwixYH9y77ysUOMCOsYcHgD5uspi8YBURFwt+aOkHg4NfI6+jdCi2dsApXiky3JSHAkfNpdwjx/afnq8DUOojXBh0LtzMlQNvREGo6ovGw7OiqyY3+6OXzd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426501; c=relaxed/simple;
	bh=zfcpY/0Ybg/bbFFEdvZM7/r3XOcbzm0hlpCMkQUMZ8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJXF4xfmTeQVA/Eev/Xe2f0hY1xzgGwmclISRLinqu2iC84PazoedVmr+ceeFtRw3XiNh+4r/c24MZKu9kHGw4QyNhSCFVSCzMnjiT/U8ZF18gtuc9cBTykt5ixLGhGOHQYFSjp55uge63eY2ZDtTk6eYdvlJg69kNy3OD+8PPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkSVo3u3; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad57fb9baso289055d50.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773426499; x=1774031299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/VE3S/bCf/448+4cP3VxlXKDepwHqYtTEVQQWGvok0=;
        b=AkSVo3u3LEuRrm9nrURZKFGPESI9JplrPf3gDjvEOrV4uSvEeSTMslxhNMoLc7q9IS
         u8F9MURa/60LK+Yl0y+ceYe4XPQsRRQBe3s1k3RX1RTgUX8VW5eLeRT2BkAVV9hCraYO
         Ec3QxxZw51uJEqMpME0yCA0qE3BgpT8htyhX6CEjXaet1A+A6vTuYiQnkR04n5Djvtxj
         1nLhsP+0UBQmDnUM0/UfFJj+frhtElmvwF7Aw1iyZO4gQwVKv8bZzJxCiy+ZHU5Euwc2
         Q9g+HOPj65hmY96CHaqaYeAUH6QDrKac86UfOLZJbs2ok8vosxpTup7ctdlUdyyhllDE
         6T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426499; x=1774031299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/VE3S/bCf/448+4cP3VxlXKDepwHqYtTEVQQWGvok0=;
        b=qZyW+/9UH4V8kTy+BHjo5Tq66sWuTYwT7/xzcxU2H8EKO89l3WWqLdJBILXsXW3NSs
         QDBFO02pg2IhOAsC2+hYkFTFoftc7lj/uNlC0WnHjZTM5gCJQsMU9WHgCPBuRsyqOeTQ
         zAN1SqHIr1xZV48PbguY0tO417fp2IcXvJfIsW38CoPgy0YgVIiC5Q55CuSSQ0AFfnV5
         W/6eD+yyBC0oB2KWHNMF78pBfBEFOzFdRHX5z7K7ZspXJS/K1lkDuv9xdczXKmqDVczo
         ycnADOjiB7tjhV84UlLrGLeizrHPZ7qK72bMH6N8MofEidTT7wzgShhipKI3QZRxqxKf
         RLsQ==
X-Gm-Message-State: AOJu0YxfJ2GsRib2Tg5n2xoLjep5D+ILGfUfq6Hk3hWbyvZ62O/LcMgg
	mDFYLQTFRm5dqbqzlfnJRIxmBEmGhph26HKl32mJ6J1q+yKjDmROCrOxj8dVkdUN
X-Gm-Gg: ATEYQzxhAFDqEX3ebDkDEjuo9bl9399liIglWbZHtkeg5YK8z3iDJr9+4uAIVyfuJKT
	CYNrYC0X8kSlLnPnhfyBWRgGauvXxIgoA6Okd/cJ8RcNOkXwsug4OFsO/cYJwbFA521J/X9WLOU
	An49+rtmDzhFwcyTZCiIAyxKsILfAC2ZMG7uis1xc6DvXvULa+PpiUmK+SG9xVhH3prjm5Dp/mc
	L8M8uJHfg2dXJNJ7WmgIzVwCVnfRWcsJiDnXsVCYMOX/CIKXyeW1yl6SCo2kryhbFbVP20W5IYX
	Sbg1rfRwVZWFEGvaC17YW2caE9GLbO/U5LLcJ9i0fIn2bXV2Qmgi5yGBFCRwRU92T5EnqVziTU7
	F/zCOxDWdW2irfC6hG2s/kd/zTOm7MI/2ivqYpv87UWWEogHVPmSHlfNhcwXh+gKaHv2ywObM3m
	2+vCwCAp1ZJb8ycyxAZI2nO/E=
X-Received: by 2002:a05:690c:ed3:b0:798:6e05:4c18 with SMTP id 00721157ae682-79a1c20957amr40421627b3.7.1773426498808;
        Fri, 13 Mar 2026 11:28:18 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917de8c44sm51207847b3.9.2026.03.13.11.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:28:18 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v5 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Fri, 13 Mar 2026 11:28:01 -0700
Message-ID: <20260313182804.696100-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313182804.696100-1-weibunny.kernel@gmail.com>
References: <20260313182804.696100-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-267556-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 482D7288BE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list, upon the first successful dev-assoc
operation.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp.h      |  1 +
 net/psp/psp_main.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 net/psp/psp_nl.c   |  7 +++++
 3 files changed, 86 insertions(+)

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
index 178b848989f1..36de1944286f 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -375,10 +375,88 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
+static void __exit psp_exit(void)
+{
+	genl_unregister_family(&psp_nl_family);
+	if (psp_notifier_registered)
+		unregister_netdevice_notifier(&psp_netdev_notifier);
+}
+
 subsys_initcall(psp_init);
+module_exit(psp_exit);
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


