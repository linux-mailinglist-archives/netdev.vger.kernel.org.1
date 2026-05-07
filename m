Return-Path: <netdev+bounces-285111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ARrC1Xz+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:05:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E646E4E2288
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 042F7300DEE8
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1022773EC;
	Thu,  7 May 2026 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHF+Iatq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF722877F6
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119496; cv=none; b=Cz9Xqf5d3M72EyvN/XA7L+KVskhAU3g3HMFtEfftldFIroxjjJyg15QXvEL/wpvDt//D1GZ6yaSUrwDKoGUPE6kiOBLDj5V8mNbimhN1wiina29NAmhuau4ID311lkbW1C4mtOXN9aalF8N3GzUIExmfxtnCBvGrbGsJkeOIULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119496; c=relaxed/simple;
	bh=+HDHnMIAC76OSjoTpiW5uF8eRfsMLaMFVa+SCMAlBFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWRcb4rKeW5Fxz9MrSKQ7wVvZD8Fr+p1rMnwL+R1Q7SFuXguNvtvSy3d6bS5s9yRFgSMcUgCYVF/Ekjj66+xkSaSGGdh7MeCDEY6HevtsWdPHhHPpE4YBTap1yOigW6VZDnTzUPFhjDyO9ldEK/tG3wc5VcLPGMXDJKn4/oXtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHF+Iatq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-365312a27abso318847a91.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778119494; x=1778724294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPdiWS2f+1x223pVffSMsT/qYQvgv2R52jqKtSop6iQ=;
        b=sHF+IatqoQ5uY6GxSGSydUjin+ciJFjTjpBGPBfSXAvh8f5t5B+etVxXKPJGmgFCE4
         i8DTjxAZUjfswOhAkSoGrZXrUIy3Pk9tmNH7eQPbeEWhURyrQKsSyptzNM1ZRD4F6YB9
         qVbL7UIwefBUi3XW5DcVs5oHWKBi+tTiX2plCsCjm6znipyFYiukPySSoa2EGh7r0rqk
         D7su92A6lTubkeJxAozQNpm9WeBrx0R8erYoWmVyPogiQvIURk3lE9pzCm9ixYt4/DwR
         pPtCCCLZfRwtWpk058xXbN0Pd6E7SHSINu61DTWrvTg3ln+otkoG0MTp7t4mCNzkgy5w
         O74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778119494; x=1778724294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPdiWS2f+1x223pVffSMsT/qYQvgv2R52jqKtSop6iQ=;
        b=hgk2V2utWRnsrkTHN8Q56cup0QpAmZDxLhTB6aj2BToYZPlQOcTqV+yHkmXrX2wzwk
         3sVl1cBBiEBBS9cZxuflTfUjpFnuNDZtkT3HaDrvD1AShJhyEfDdy05K4hWMVFO1glH5
         wmUY0YoS84p1I/MkRMR2BKQ8wSKfSAoENIPM2xb8jJ5H4ywMDXsRaD+aDIHeMsmqO6A2
         ukf8m3I8SUT0sxLeAPM871yWMMBhnXvunhmHQcop52IhJhVEkGORMB9H51WeocVdA1Jy
         w/0ynyeh2QH7GA4QBVrwKxFoyqMcA3on5O2Ge0NbETF0X2VuJZvX2w+hVn/ZCIiOHl+b
         3SPg==
X-Gm-Message-State: AOJu0YzMNk9j963GySziLdq4WaLPpbKUfqJjUMmoKiVI0dICqLf+UVZC
	Nb+D4iERaUvXIxZ5f/gAUpNbUVqwwS00TbWw1d1zRngOHaa6nU7Slnql
X-Gm-Gg: AeBDievSC7bDW2ZtAIjv6vE7WRxtddIXOXETnYU4dGtpgFwp+Se4WTASB9tiQg47/ZJ
	joc42rVFR0xrmnEBEENXalWgcq7QKLUwBFqjJ9RxMoQbKQmsF76KJbNxEKiKY++ink/dxc0HMFU
	ZCj81JJ4CYki7XTeA2JXr8NDGlMgTAYYhtYqCOqe9x8xoY1BVtGuTHXeAOhxVTfIGIfUYxv2V92
	VhkPbR/S0T9y30UMoFi6vpJj9tVKV98GA2nyooBXO6moq4wCndBOCJNWzuEHpFBvUAvNrZR5P6n
	wFWk7w2UOvuIXZEfujYJk0doVDiZx9MBrUSEXeMomJw7DXAwC/NnbX1MfPe3IpP6kcAH/HYZZm0
	DiStwsoeEsEluf1vDdBpVYU+sPBtNluipwNEJcdenzT6m2+cpEvpTA99NtcO5y1EV4CuF7KkgxV
	TDQikfks7634wGKN5agJ50dTF5SxqyvbB4Bis69FfMEEe8lwT7qw4CFu1fcpAkCfSzSTE83eU=
X-Received: by 2002:a17:90b:1c84:b0:35f:b7f5:9b3 with SMTP id 98e67ed59e1d1-365ab8ba745mr5805240a91.3.1778119494184;
        Wed, 06 May 2026 19:04:54 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4cba340sm5100204a91.17.2026.05.06.19.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:04:53 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hannes@stressinduktion.org,
	albinwyang@tencent.com,
	kuniyu@google.com,
	shenyangyang4@huawei.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v2 v2 1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
Date: Thu,  7 May 2026 10:04:24 +0800
Message-Id: <20260507020426.1126254-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260507020426.1126254-1-alexjlzheng@tencent.com>
References: <20260507020426.1126254-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E646E4E2288
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

Introduce a dedicated ordered workqueue, macsec_wq, which will be used
by subsequent patches to defer SA crypto cleanup (crypto_free_aead and
related teardown) out of softirq context.

Using a dedicated workqueue instead of system_wq allows macsec_exit()
to drain exactly the work items belonging to this module via
destroy_workqueue(), without interfering with unrelated work items on
system_wq or causing unexpected delays elsewhere.

rcu_barrier() in macsec_exit() ensures all in-flight rcu_work callbacks
have enqueued their work items before destroy_workqueue() drains and
destroys the queue, making the two-step teardown correct and complete.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 drivers/net/macsec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..ddb22473e701 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -26,6 +26,8 @@
 
 #include <uapi/linux/if_macsec.h>
 
+static struct workqueue_struct *macsec_wq;
+
 /* SecTAG length = macsec_eth_header without the optional SCI */
 #define MACSEC_TAG_LEN 6
 
@@ -4450,10 +4452,14 @@ static int __init macsec_init(void)
 {
 	int err;
 
+	macsec_wq = alloc_ordered_workqueue("macsec", 0);
+	if (!macsec_wq)
+		return -ENOMEM;
+
 	pr_info("MACsec IEEE 802.1AE\n");
 	err = register_netdevice_notifier(&macsec_notifier);
 	if (err)
-		return err;
+		goto wq;
 
 	err = rtnl_link_register(&macsec_link_ops);
 	if (err)
@@ -4469,6 +4475,8 @@ static int __init macsec_init(void)
 	rtnl_link_unregister(&macsec_link_ops);
 notifier:
 	unregister_netdevice_notifier(&macsec_notifier);
+wq:
+	destroy_workqueue(macsec_wq);
 	return err;
 }
 
@@ -4478,6 +4486,7 @@ static void __exit macsec_exit(void)
 	rtnl_link_unregister(&macsec_link_ops);
 	unregister_netdevice_notifier(&macsec_notifier);
 	rcu_barrier();
+	destroy_workqueue(macsec_wq);
 }
 
 module_init(macsec_init);
-- 
2.39.3


