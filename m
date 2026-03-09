Return-Path: <netdev+bounces-265692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JKbBq4Tr2nJNQIAu9opvQ
	(envelope-from <netdev+bounces-265692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:38:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19523EB3D
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2896330DA211
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992D9349AEA;
	Mon,  9 Mar 2026 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8xoN9fb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FC34A766
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081315; cv=none; b=CeM0Vve/6KqSQPRAoMp0sk4f05iRZcEFPvfRCRE4yp18Dt6DVcoMmFPn78Xq+YErHFT1qsEub0pG0BSuSoy+WqyAvm3hDz7/qx63BSiVOsr93e5cFRV5PmfvJ9KzRYL31+azliQQ+bk3JqbVF9zsCm9LCXiI+J9UOggDH/ZKqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081315; c=relaxed/simple;
	bh=kVgLo1UIQmV5NQTNztNFJnGO7fonwctn5SLBBvwFLlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9w/vLjWebYqWsShxD6VZ7lb8PIczdR2yQSzvk20zYuWH0LIZMEQP9IftThORxyKJ6WVVsEPd8zCtDvcERcmeo/7p/PmCk8kzqJsTmmxS5eSfGrYUbAakppDxSY2g0NQ5CuqGLdN/xA+gSF6D4oe6udYLNzbzezrwM8F2Sd+Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8xoN9fb; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64caae0eb68so1107453d50.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081312; x=1773686112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdAHIjNRfECitwY6z6++rPnn/JKOE6QQtUSBJ9Is/ac=;
        b=k8xoN9fbysN8r+lv0knGsw4BczJaRIjyaK5JGB9AfhECV0bnvWFGTCyOygxTuCSmKa
         A8/p8+H19iQDOEtJL5L3L9Cq6l5vGg2A6elQ/WSe0E4Glti74r5VJ6eZTkjdgB4gvECz
         5qQYCCPldc+BOthsqlPHx5zMGfnUsPD8RSZLJji+nfuK02dpY51oUGDbIdNz64hNxEFn
         rZpQjBonU5F2D0eGFZeGrv/TGFx10UFUBMjYFDrPoQeaAZccNvQ4YfkwAsCMxkjFIXAO
         zBy+zsJnKyWXQvs0fJR4cp3Ah7lyfoBF9nbPuhYwcjeEoFb6t79is1n0IyDj0c96Zyml
         mAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081312; x=1773686112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NdAHIjNRfECitwY6z6++rPnn/JKOE6QQtUSBJ9Is/ac=;
        b=OGVcKXClq/4WPMq63zF2X5X8YAP5AxoY98cMcMd2BUfwM0AkKJWb1Io/KjNsSr8f5Q
         fXYFQFBlZxBLrXV7m/sCyIu7omX4YQwcdB4U7ewFinF+J3TVBX9/zYjR+jF/dj+yf3H9
         oS49AnU3vP/9G+9MVkjKeb8MFk7PFq6/pjQU8DKKEXWz/EXh56s6kY05RELMCMjYSJbS
         lSWo8RvGaTgEc5hKhuYVGJoncqsMatQMrUcnMgWBsGPJi3QhYcPEkwvNss5VhT6GRtpu
         4A2h+ezF0SiIgv30hJ8iBQKHnnNq8IcMFOCBs9FUxghQOK9fxsmSjhxwogF2K4TI7HnC
         4gow==
X-Gm-Message-State: AOJu0Ywvpar2O+C55pwQY/xmDHxjSVtFGfnXt1aJn5N1+8FsYJOZ8qKp
	HxuHEAxozILUdyasZXyA3kTpkGLXBk5UVqOWexs6wBh1Duo4Q114Kz9870KceMFG
X-Gm-Gg: ATEYQzyBhd1Okl4b4pawsH1NOSV5METCfc6R25NSWoug0LJBfmurv/dyF0iHXoNX0Mr
	Mw5Fr5ZrtV14W4Yxj6j2EMxT5tqWTerqD9BVnQfcT2AyZTOSOLma46BPpnId99ZWS6td8Hz6Vy3
	DvhskgDSzNnq2U8tuW5gItde8EPwl4nucsd2LdYIWe0XuMeAYVrO4g310cE2bfTVS9YX5zd3k3I
	/aVJ9zqQqg0BsTouDE9ieAhFQNbN9hKK/5c8QOr58K3JU83ETe6pCxtACOkkA8PkX8Uc2LpOvx4
	LwbYIm6PkYW4PluLyCqVw+kq9RAIPjyFH6JfG65uZAZpnG+wiByG5CezdQd948VhLInAc1zyw+1
	W8WxsyYjxdlHxYn/i9YJXMpdGnzvTyAdWX+JvndVUf13LU6l6gLdlbZGnWX/CwyXUJlo7BYGa8Y
	ezkchHeICCh978MGCbWnNuB9z0
X-Received: by 2002:a05:690e:159b:20b0:64d:294e:9e9c with SMTP id 956f58d0204a3-64d294f2d6fmr3045411d50.8.1773081312443;
        Mon, 09 Mar 2026 11:35:12 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:40::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm5046073d50.20.2026.03.09.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:35:12 -0700 (PDT)
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
Subject: [PATCH v3 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Mon,  9 Mar 2026 11:34:51 -0700
Message-ID: <20260309183454.2872967-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C19523EB3D
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-265692-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email]
X-Rspamd-Action: no action

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp_main.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 178b848989f1..8e00ade706e4 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -375,10 +375,72 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
 static int __init psp_init(void)
 {
+	int err;
+
 	mutex_init(&psp_devs_lock);
+	err = register_netdevice_notifier(&psp_netdev_notifier);
+	if (err)
+		return err;
+
+	err = genl_register_family(&psp_nl_family);
+	if (err) {
+		unregister_netdevice_notifier(&psp_netdev_notifier);
+		return err;
+	}
+
+	return 0;
+}
 
-	return genl_register_family(&psp_nl_family);
+static void __exit psp_exit(void)
+{
+	genl_unregister_family(&psp_nl_family);
+	unregister_netdevice_notifier(&psp_netdev_notifier);
 }
+
 subsys_initcall(psp_init);
+module_exit(psp_exit);
-- 
2.52.0


