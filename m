Return-Path: <netdev+bounces-286100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA/uOj2r/mkyuwAAu9opvQ
	(envelope-from <netdev+bounces-286100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:34:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A739C4FDE86
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA5C3023DA7
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 03:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B037BE6E;
	Sat,  9 May 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7dEtgdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB4381AFC
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297653; cv=none; b=ofAjIO+x1bHgw6pwZ20NgwF2jV9RIxP0R+0B1O5/DO/F2KwAOMFINA+6zWkD3bLxVTVyJrw2uxHUn1jpA4SOXvAEZ5J3KWZ7GIAzrsFi7Fq36a12W4Iv3xiaEsCGM/wFBpJZAsZow/pwaT+JXTgsyLXACL+gHtaWwquQVVzJux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297653; c=relaxed/simple;
	bh=gdVwM1O3NHaJYyd05hJhAOkWnuvo0J6zyfeT5CSMGO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zmahyc6Y3dZecND5oHkDw+mlwRu3kt+3jjYNS72LDiixZFyNT36gb8iy70ATVVXl6iTWeUpNl+rGLwtueM0d8B/s3djZyWwp2zd3d+eENmyPV+Fz3RazbueAy279hNIPdwOHzk39nGGc5dMqy3FVBoaYlDc+js5+pSFHtPoDEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7dEtgdz; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-130b2295ed0so7725572c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 20:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778297651; x=1778902451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vOkoZCHqUk0sHRsVjfTCZpEX/siD7cO7/dfOVMynEg=;
        b=l7dEtgdzP0TdJ7SpTsrZm0XmFPbc/+G3OTQWiOLuh0RXd9J3SpWiTBweIKr5t6PxiK
         3kH9tZGtGCG38T6rJnEOHDbFrbIzgLAyshaTOL1TIuskNHWkSig+ImUCckr7z1eEudeC
         J3V9oI3d3C6SAUX6bp0VqIRnazieXCA5WKvLSxiIuYGvEf8HzQQviFwoy8OS7dYDWM1h
         GyMYCX5VxQrLU03pabuKG/SlKKj7ssq21dCevYMnGubaxe2HxvexY1EIvbEJPbM/g9y4
         GnR2YOOqSLT9hsVaojCYOab7Hclwz60Nq8rvz6yM63H2lMTswR7J+4jZaopjXDULG1dx
         kq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778297651; x=1778902451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vOkoZCHqUk0sHRsVjfTCZpEX/siD7cO7/dfOVMynEg=;
        b=qYjjCG61wklLFge6sWxrLTD+MNSRkA+Dj9lMWv6Ws9qY3MayWfc4gdQwwuhDdpztVp
         DGytmiHCI7a3Zk0HsgV9xFMA5oKj9siAwYwHLU+MB7cEhu2KUNq/Ri41O8cnanWYKuQA
         DQKU0i5ByrO6fleq+QgkQYDbX+3iK23KYxqJPOTvmA9g+aiuYS1jkwR4HLnUYKdI07O+
         oSYgZJOljxyWnXaKOUN6pyiES0MI4+9/7VpEHH5+5Tl1nyn0XNnXMJazqOv7xSjPcVm4
         nBHVh1rIk5jdgpP60oJ7iuO4mwZlRpQZAZl4ALoLy0O0aFi5InLmTIU1jpwoFShoZXlY
         v4Tw==
X-Gm-Message-State: AOJu0Yxln82de/gNPpTC7lS7ug79rji/1LIEDMZcG4FqU5hmMDJalr36
	XUT6O8rnk+B6FnLDGCHd7kHn3Hq4k0pV/YK8XtopJcFqnXC7zfsOrKu4
X-Gm-Gg: AeBDies3Y/pj92skjghd+YbMITHfOatzLlD33fsH82wRouU1UUhKxB3+utH7b0QoDA+
	vIB8dJShUyv1wzr7seXKhDAxJAG3L+mi0ljM/sORSqDVaN3jcsY7Yo9rSvlGN3DKSMRfsogS5/Q
	Yb5qW2vfDWzz6E1kM5pABVPVo1/3gapKj/UoD3RDVhgQtobvpmXVB8LXR3Z3ahbFAvhVwpI0J/Y
	yjhlajkac629NgG9d+KC1Lf+u295Q1aoQngJd4x5PIB6cHL1g4UHZPR67JPBjlHeYi8t/bqzg/t
	pmX4w0lDKakAQDRf44/8wGwB13bmSy43HQHO3NZzVVMMqx3Bzvx+Iby8OF6RcDEHEsI5wDZsN72
	IoLL+yRNqRd6g4pdloiqjhgfw3VGJFd1YdI/4R8OqC/ECB1+DigLZ3g8xM3ho6HqJM3UeGIvRvV
	VnGxvn9BzeUklsTlC6M7m1wg65gI05zD7BnSo=
X-Received: by 2002:a05:7022:e981:b0:12d:de3e:cbfe with SMTP id a92af1059eb24-1318eb57b9dmr8244075c88.37.1778297651292;
        Fri, 08 May 2026 20:34:11 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm5500989c88.7.2026.05.08.20.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 20:34:10 -0700 (PDT)
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
	shenyangyang4@huawei.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v3 v3 1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
Date: Sat,  9 May 2026 11:33:45 +0800
Message-ID: <20260509033353.1814289-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260509033353.1814289-1-alexjlzheng@tencent.com>
References: <20260509033353.1814289-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A739C4FDE86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286100-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org]
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
The same sequence is kept in the error path of macsec_init() as a
precaution, to mirror macsec_exit() and stay safe if work ever becomes
queueable before this point in the future.

While at it, rename the error labels in macsec_init() from the
resource-named style (rtnl:, notifier:, wq:) to the err_xxx: style
(err_rtnl:, err_notifier:, err_destroy_wq:) to align with the broader
kernel convention.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 drivers/net/macsec.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..52d6dd03ac92 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -26,6 +26,8 @@
 
 #include <uapi/linux/if_macsec.h>
 
+static struct workqueue_struct *macsec_wq;
+
 /* SecTAG length = macsec_eth_header without the optional SCI */
 #define MACSEC_TAG_LEN 6
 
@@ -4450,25 +4452,35 @@ static int __init macsec_init(void)
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
+		goto err_destroy_wq;
 
 	err = rtnl_link_register(&macsec_link_ops);
 	if (err)
-		goto notifier;
+		goto err_notifier;
 
 	err = genl_register_family(&macsec_fam);
 	if (err)
-		goto rtnl;
+		goto err_rtnl;
 
 	return 0;
 
-rtnl:
+err_rtnl:
 	rtnl_link_unregister(&macsec_link_ops);
-notifier:
+err_notifier:
 	unregister_netdevice_notifier(&macsec_notifier);
+err_destroy_wq:
+	/* Precautionary, mirrors macsec_exit() to stay safe if work
+	 * ever becomes queueable before this point in the future.
+	 */
+	rcu_barrier();
+	destroy_workqueue(macsec_wq);
 	return err;
 }
 
@@ -4478,6 +4490,7 @@ static void __exit macsec_exit(void)
 	rtnl_link_unregister(&macsec_link_ops);
 	unregister_netdevice_notifier(&macsec_notifier);
 	rcu_barrier();
+	destroy_workqueue(macsec_wq);
 }
 
 module_init(macsec_init);
-- 
2.39.3


