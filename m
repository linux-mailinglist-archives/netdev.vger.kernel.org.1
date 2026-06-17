Return-Path: <netdev+bounces-299994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uj77C6frMWrmrgUAu9opvQ
	(envelope-from <netdev+bounces-299994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093D695D96
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s9BS3MBv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299994-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299994-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E772E30F62E7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F1149DF1;
	Wed, 17 Jun 2026 00:34:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC626AF4
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 00:34:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781656483; cv=none; b=bg1s0qcKomxIoS5d4pRrSCFUTzzlI5VIMZccbhwLZMYF61XapNw0PyAdWV9Ey0hMYZxlWh6e8YHN3+lzR/pnYhznce20qYw80tZMYgAArWjOfNNkISn3eLn8mtRQOzU88H2uBkmT4FFF6hI5YwWyJeNUkceAc1lUwQ1t+nvJct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781656483; c=relaxed/simple;
	bh=yBW2TYEMimFIStQ5LqWOnon1EnkxlBHhnCIk69550ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4nEuBNhDpTotOdIgA9+2vX1kfdndOZa/hL1FO6bkGrFVlLpE5Ke8QRaNI1MKUBjiAt+a/UtwYy8QuHTiOlg5V8PD9knO6G3ddpKIR9wVeXgh5uOwwe6B47UNrMQprt9xHqGb0JRUGpykTm/99Ictf6hDEd2dRsJ58CSHlWKX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9BS3MBv; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso45799845ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 17:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781656482; x=1782261282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxzIHiJhQyu52BykIVAY9srGag2s7Q45+WxKLmwniJ0=;
        b=s9BS3MBvOsPRn8gO1m+/TpAY8fBZimtLdMBe0KoUG9hxaoBB37eUvdBsu/Pak/JHEP
         nj5g288IrCV2wF4NoO55yO6qVhIcinUO0fVG4xSfYYbcBt3Npy6M0//x+orwje1ZFlF3
         pqeBxFB4m2DPxmdMCnMqiMcTFK/L9wpgn15fBPusRJjbGPkac1H1VTnUFRT9/QTmshxJ
         cVhNPWuDf7bixP/6o3JcV769vHNlrDWpAyoDP2tfK8WvPcZ5qjkVgh/GfybDBrEnfYLt
         L8xwmvMLsYZwaJeRzL7Oez8HD/jAD+TCXIHwsUUcJpZnGQ7OJJp09PvG2sNiSSAyETs0
         Rabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781656482; x=1782261282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxzIHiJhQyu52BykIVAY9srGag2s7Q45+WxKLmwniJ0=;
        b=bgEsFUEwgusy8Sh8HCx23n0d7/I3ouin1mMrhFsnmOke8csQaqTsdkYmqbfBtU0LTa
         v45vrbMQouUCD2PTrrkPlIXxd05D32inyvusKru3E7yhglAkhGRtAABImJ+n7lwUP6oC
         0UwvZUb5Zt3NvIHb+cpiOSgIs0rVLIb7UAzxyIaj6MWKekRDae9yNfQWC84EZssWtoRJ
         zpXnpu3RBPp9xALC023GbVqy3eVz37y1Yu2tqy1zY3fB3tCjbe7knrKo0D1b0W9/8yfl
         CS173EeQtg7t8jXjdRRcilLV2igaOAnczhOP8LXGhq47g6j6L3B94AkkjIsUHm0DYUy3
         ZeOw==
X-Forwarded-Encrypted: i=1; AFNElJ+WwY+olLVtekTpMNM2J+RoYfxFgP738n1a/9T1q0APzvay/y3+xc2eHjvrnLLHHxIX5TiFmAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lrPlWhBFDAS/iBVVhoYEVU9oulTk4FimrrGHT5cRQNXi0Zhw
	VhFh9UFvUxq1nYjAFfV/OVf+x8VKv5JBPHmd9Dbz2yR4Tn46zly3dGmQ
X-Gm-Gg: AfdE7clExwPwLBb6E2EYGfFKDCo6qmHgteRHhk1NV78n5ZDHyaHJqFD+AZITlmYpkub
	iTB1sFFzawtUGrpb0YXQx6VXBK1NXGHVAwJo9Kc2UhjPLfElv0csoE+1xiqnUQwoIqop0DoA/91
	qTe8ZTO5CY3d/7QLbWDNnSdQBwVguOy1M0g3aGOJKstGAtochd9UnxExIhuZyK78qfBcHzpwfvK
	Z1pJiFxAL7eqH5ZzBoCZgfO6tMK3syXu+/SmXjANppd0Rhdo7apPY2NTxX93pEdZjobNMaAdkt8
	tW4WEz/m4KoIXd0h6C/CZrMjPg6cucuLcf0yfNgc7Y5WRUNHN/wYpNA72Amkz8VnMei9R886YWR
	RJJYyfthqHwiV1ZTljwWIel5i98OS69tdjx5lBZxAQW2lcNwN/XCXHgB+HQPMDBRHuDq4m2rnDD
	0CshFw78YwwMlvMwcA0wW5pWwh29uWsxMWFFKk/m2Z2KbwfQwc8AerChjjxZg4EyYxKJ8FAM5n0
	Neu
X-Received: by 2002:a17:902:f70f:b0:2c6:7e5d:e898 with SMTP id d9443c01a7336-2c6bc0b69c3mr12829675ad.13.1781656481737;
        Tue, 16 Jun 2026 17:34:41 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([203.192.239.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm143221225ad.36.2026.06.16.17.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 17:34:41 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>,
	syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Subject: [PATCH v3] netdevsim: fix deadlock in del_device_store() and nsim_bus_exit()
Date: Wed, 17 Jun 2026 00:34:29 +0000
Message-Id: <20260617003429.51968-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,gmail.com,syzkaller.appspot.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299994-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mokshpanicker.7@gmail.com,m:syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com,m:andrew@lunn.ch,m:mokshpanicker7@gmail.com,m:syzbot@syzkaller.appspot.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mokshpanicker7@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1cf303af03cf30b1275a];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,syzkaller.appspot.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7093D695D96

del_device_store() and nsim_bus_exit() both hold nsim_bus_dev_list_lock
while calling nsim_bus_dev_del(), which internally calls
device_unregister() and acquires the device lock. If another thread
already holds the device lock and tries to acquire
nsim_bus_dev_list_lock, a deadlock occurs.

Fix del_device_store() by releasing nsim_bus_dev_list_lock before
calling nsim_bus_dev_del(), after the device has already been removed
from the list with list_del().

Fix nsim_bus_exit() by using list_splice_init() to move all entries to
a local list while holding the lock, then calling nsim_bus_dev_del() on
each entry outside the lock.

Reported-by: syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Closes: https://syzkaller.appspot.com/bug?extid=1cf303af03cf30b1275a
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/net/netdevsim/bus.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 41483e371..deb937077 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -155,6 +155,8 @@ static const struct device_type nsim_bus_dev_type = {
 static struct nsim_bus_dev *
 nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queues);
 
+static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
+
 static ssize_t
 new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 {
@@ -182,7 +184,6 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 	}
 
 	mutex_lock(&nsim_bus_dev_list_lock);
-	/* Prevent to use resource before initialization. */
 	if (!smp_load_acquire(&nsim_bus_enable)) {
 		err = -EBUSY;
 		goto err;
@@ -195,12 +196,9 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 	}
 
 	refcount_inc(&nsim_bus_devs);
-	/* Allow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, true);
-
 	list_add_tail(&nsim_bus_dev->list, &nsim_bus_dev_list);
 	mutex_unlock(&nsim_bus_dev_list_lock);
-
 	return count;
 err:
 	mutex_unlock(&nsim_bus_dev_list_lock);
@@ -208,7 +206,6 @@ new_device_store(const struct bus_type *bus, const char *buf, size_t count)
 }
 static BUS_ATTR_WO(new_device);
 
-static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
 
 static ssize_t
 del_device_store(const struct bus_type *bus, const char *buf, size_t count)
@@ -241,11 +238,12 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		if (nsim_bus_dev->dev.id != id)
 			continue;
 		list_del(&nsim_bus_dev->list);
-		nsim_bus_dev_del(nsim_bus_dev);
 		err = 0;
 		break;
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
+	if (!err)
+		nsim_bus_dev_del(nsim_bus_dev);
 	return !err ? count : err;
 }
 static BUS_ATTR_WO(del_device);
@@ -520,6 +518,7 @@ int nsim_bus_init(void)
 void nsim_bus_exit(void)
 {
 	struct nsim_bus_dev *nsim_bus_dev, *tmp;
+	LIST_HEAD(delete_list);
 
 	/* Disallow using resources */
 	smp_store_release(&nsim_bus_enable, false);
@@ -527,11 +526,10 @@ void nsim_bus_exit(void)
 		complete(&nsim_bus_devs_released);
 
 	mutex_lock(&nsim_bus_dev_list_lock);
-	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
-		list_del(&nsim_bus_dev->list);
-		nsim_bus_dev_del(nsim_bus_dev);
-	}
+	list_splice_init(&nsim_bus_dev_list, &delete_list);
 	mutex_unlock(&nsim_bus_dev_list_lock);
+	list_for_each_entry_safe(nsim_bus_dev, tmp, &delete_list, list)
+		nsim_bus_dev_del(nsim_bus_dev);
 
 	wait_for_completion(&nsim_bus_devs_released);
 
-- 
2.34.1


