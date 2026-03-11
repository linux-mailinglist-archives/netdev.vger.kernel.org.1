Return-Path: <netdev+bounces-266803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBcnIQoCsmmHHwAAu9opvQ
	(envelope-from <netdev+bounces-266803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:00:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F366826B809
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51083306078E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964963A5424;
	Wed, 11 Mar 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moSWMddS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C183A1A2F
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273569; cv=none; b=Dc8Or6d/F0hBVnUKSxvDYnZp69MkRJVL6Vumjhi1vRCPmCjW0jFs0V3+kQy7MHgX4rgp3QPZL+43ytgmp8Tj9nGeK1JuomaWfhxxglDkkGNoheneA+dsNZQL8oOm11ix7BY79qMgsEAfv/fPC4igxsWau8QQpRXSJ15BrCBXxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273569; c=relaxed/simple;
	bh=Uoig/3Yg8HeWUFccOHdWV4J9AKi4KIdzLqGMOa2is2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc1ryyN5iorl/b7fou/+EPu+8zTIk9U1OpBZMLER8LoOITtlnV03jEgenlcPINFMzln8TuiAXTz9SNEOH46jBsehnaK7+2sCp4o7ORPLIMa5y7SoRNxziVo5kIs2WP7IgJtCv61Yrb5O7F/v9uaXX+/QYSt9mZ/i56JGQfod/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moSWMddS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-798736fa734so8227b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273567; x=1773878367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttVOOc/g3ijg5oaGmicDG2Jg8/3iAsYkv2zCzbduDWU=;
        b=moSWMddS30hIlIeRPfGY1z4pl4tP2PSr++zp704WprJp4un3Y4xg1FVcOMN2F2o81D
         t/1BG2oswUeG/E+zH/c5vvc3u0gdELBGXNaOdsaF8WgVaIyyBeTefb97rOjDuJAGmEm9
         bKXHyzEQpYKAMGrJFKs/tyAhvZhd8JRafltpiXhpr60dvKzJQwqpD0/Fv6makvA4e0Ui
         GuhpykWou0o8MxbaweMfWs/algNVSC4jIeUsgpkDUEMSy3NrJ4ZLa9d+yVTy1op4wvYt
         jnAymVoEYmf/Jos1J1e7BGYa1Vcu1lxFGH9eICx70IqiAjE1klaZivEizOlxBMDlz8OK
         qWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273567; x=1773878367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttVOOc/g3ijg5oaGmicDG2Jg8/3iAsYkv2zCzbduDWU=;
        b=f25j9IYycLuoXif/nQajH0qGnErGf7NRNW+E885PZ7vEbupcgJCWtskMvNoLnofHdG
         CXHU6Hw0juBeWZV3h+QAgYnsj2kJgwBot0nXFa5IOsnEWvv4BrjfnH0MEoTukS9/fg6K
         x0rutgoQZqCocIonCr8Ba/27X4cujxuKNyTlUpZmVKobckwROueY3UsNqQCPIrjYta8b
         fbQwCl6PSy7gWIw7PwJVu62LTUrTU/0grCP+MDj0AyGsonctDFQbxJE5877LTZN700dE
         1K9/psLbgIJjyaqTtRAMrlaFuslB7+hg5A1M4CJaB2OATvx7EoMwf2FNgCPNECJlPjlW
         9JSA==
X-Gm-Message-State: AOJu0Yy9ErZPLiQxK/mjbOGZc7yDo8vA3ydPFZfBOmNdWE1rYv0onB/9
	myYvTPM95PqdEjiQmAaKLq0uYMjFUeXU6FiyrGZB+k06p10ouDFC7XXtCd+OkmIg
X-Gm-Gg: ATEYQzxS3Z2dKJqM3gzZG79V2HtQPDTSiETDQTWvMLlmsBgUHd8D/3S3ct+56P3AwU9
	Oo+lmmbyegflwgCMomsA1xgewUgB5kNyxRuV3zyipg5KO3fKlfuAbPGSG9GusNhPLfK8vRYk2On
	ohomlOFEO5G3tr1oMl0ytZ0jPxUiszesjRzkJhqHViGfRp3wvAyTnu+PChkdw2ulzsYtImpllsx
	7QRn7HeDWS/vrRgx+4suItXDE+WoQBlowNsKTYR1ymz42aMvN2huJ6mzRWNd25ImxaLONwNjrPU
	Nfa01rs2bbnpONki6cAhg5N1321mMTob+vo+RToBqwu3LH4I54mfBmPu3QMAnbd9C6tVK1Vj89w
	DDFS5eGfPWEgLlzdb1lAxa3QJ2djcb2TRnXBVbqZaQvKR+gNyoVTyb5dTyhewxPt47A8FxSuBTk
	pvHMBldX5nXwDgsWm4G4ltLBY=
X-Received: by 2002:a05:690c:386:b0:798:78ea:f0ae with SMTP id 00721157ae682-79917d627d0mr33726487b3.0.1773273567100;
        Wed, 11 Mar 2026 16:59:27 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1cf02sm21652287b3.41.2026.03.11.16.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:59:26 -0700 (PDT)
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
Subject: [PATCH v4 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Wed, 11 Mar 2026 16:59:01 -0700
Message-ID: <20260311235904.2392010-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311235904.2392010-1-weibunny.kernel@gmail.com>
References: <20260311235904.2392010-1-weibunny.kernel@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266803-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: F366826B809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list, upon the first successful dev-assoc
operation.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp.h      |  1 +
 net/psp/psp_main.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 net/psp/psp_nl.c   |  7 ++++
 3 files changed, 88 insertions(+)

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
index 178b848989f1..22f21c556b30 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -375,10 +375,90 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
+	int err;
+
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
index ce67a4dd41ce..7d6eb4633e90 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -532,6 +532,13 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 
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


