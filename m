Return-Path: <netdev+bounces-301770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aOO9OYo4PGrClQgAu9opvQ
	(envelope-from <netdev+bounces-301770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4296C12A0
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=raIVNGY5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301770-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF2AE301F88E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E963DE420;
	Wed, 24 Jun 2026 20:05:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214E1A3165
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 20:05:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331529; cv=none; b=LAj8tDC4S7fNuRXWAqZiZTrUNTW0SillHChLMfs2jX0yPQdCMaznhoXuzfD1plFcoACSZrk1nYEEjYdZA1mAMOskdA2D6Czmtqw2QqNBSxOhrU/WxSp8ruahb04xb2T/O92g8yiYlrv9WB/yWxHP9xTc7tcV4zdsgx7p4xENAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331529; c=relaxed/simple;
	bh=uGQCT8E7NdnJjk84oOCWd+hFDtOe2uO15imvJTeo8aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQPSneS2OlZYb+s8F2hyWyPM6RWYU+s1NWdZTjdxoyaHlNygudYgtLMEGLrbuAtx5KST/y69hHVjLIAFdj1OyXeamAqFg7yV14EhU8BNNTHbGp3naLC+6O53ASHKODLggIqmI05D/63OXUyyYUlg9Br4erxVCn1w5Kvbchnqx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raIVNGY5; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so3043181eec.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782331527; x=1782936327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApMdDB/EOPXueJ52vfhYu8DXz0RQ47fUhjfwMUESgEk=;
        b=raIVNGY5+kI0tjK5cxkK1eH/6ojBtN5Efv/FIVVAaVy36Nisvpy8OrF8cIntkUQb6Z
         7P6j6OFGBJd0cKxrFYz0GIL7XQIAtPbmtfltBEgPnereRSfgIMFL9dT+d0PJ750hPKps
         9UpannPRWgutzqed2ioUuCFArADQ6yzJStkR/bZ+yTLq1N6JVwvQLI8S4BTpBvAGCzha
         +veO7e/I9aPw2NHlIAjAKTVmNZh1hTND/iGANcYXRwzJtSs9xZbdYa8FncgwojGOhVg8
         sKwt0h62SNBvp4IT4QLLJc3V6Q22E/+AiLM8My7f1OzpBIcKH1IbBROrRrwrdPvvBFa8
         bWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782331527; x=1782936327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApMdDB/EOPXueJ52vfhYu8DXz0RQ47fUhjfwMUESgEk=;
        b=BlD9dIjKuEai4Cl0qLO4VwlqaGgmL7C4xhIXuLGjGz3tFtERCHJ9cchRJDFQGgcTBe
         hJqQSE+4MC1BSKmirLdN+KISoA8HhZ9wW0r3KS2MSBzdnbh6UNzM82S9PHR9UcvNNmxw
         SuqjrMkbRhex5Vq3uOh+aKzO5N0Lp5sKTZSUxyw04P7boFNvd3f5xiA5fTCo+RJz8dkH
         V/Zpf33woAUS+eG6HBDDyhukIxZWzyHWDjEI1wQx3GtPYEA/U8J0heLXGRXCDJeI/WDP
         FPStGu4o/Y62arzSgc0LDdGm880HP6vvVQLiL46lxbD9wafHd1o44+R12RZbzguwfLWE
         fuug==
X-Forwarded-Encrypted: i=1; AHgh+RogE1MrwPRbrJKL9YvJ+1Fjm+BQtIMgoYRNvh1rT0ymK881VPYu7qLyjw6GXCc2+/MxGKb7EE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH3eIjoovjMSkxxG2KBrwpEfQoSU8ifCQ530Sj4+w9e+7FUxS
	ooIvB4XqAF9DwwDc46ZLnpVuBwtp8zRHGVLUeUUAfnR0uF5sxo4fkile
X-Gm-Gg: AfdE7clg3l9FA4UKPqNoHASD8ddvXo2xP2FkXb4LdHhEuSOSO43agYgRpky7WvRe0h9
	1NkQcyLm70MFk0ROdtBr2CLMCCo9eij20cO+HNNFRM5KhP/SbXrrWE3Ktq2rXlITrdD4yFjhRgv
	d54VM3w61VPvGUFlUtKT2PK2IJlV3cHipczuDxHWvFh9xg9McR2aUgUjN+TX3xt5PM/K6Z5Lzdc
	dizLF2MUGrlauVaL0H2nJHPPkMee9n9FlDH9uB/inWj+du2WheSxQC20k5MAIUhwvVwvnRzhERG
	sJa++l0+bEN3O5gknHzmM0qddUVzemGG3xxUXeZ/MzuPFjQVuizCbojaMYyJ3wecjv4/OovRJjt
	bHge/ZQd8M4K2Gpamz0FDQDVbnB42XtHMvhPGCHV6Z96p1MfrUrkn3jR/F8c2L/xpo1NXaUljEq
	Y8HLcfga7q8Po+O5nciz/M6Z+w8Nwsfw==
X-Received: by 2002:a05:7300:cb83:b0:307:d4e7:b16f with SMTP id 5a478bee46e88-30c1dc2196amr14663620eec.23.1782331526828;
        Wed, 24 Jun 2026 13:05:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::3:7577])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca208sm1347501eec.3.2026.06.24.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 13:05:26 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
X-Google-Original-From: Zinc Lim <zinclim@meta.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: alexander.duyck@gmail.com,
	kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net] eth: fbnic: fix race between concurrent hwmon sensor reads
Date: Wed, 24 Jun 2026 13:05:14 -0700
Message-ID: <20260624200514.1332788-1-zinclim@meta.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301770-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[limzhineng2@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexanderduyck@fb.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:alexander.duyck@gmail.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zinclim@meta.com,m:limzhineng2@gmail.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,meta.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[limzhineng2@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F4296C12A0

From: Zinc Lim <limzhineng2@gmail.com>

Reading an hwmon sensor issues a TSENE firmware mailbox transaction that
uses a shared completion slot. Concurrent reads (e.g. parallel
"cat .../temp1_input" or a monitoring agent polling all attributes) race
over that slot, and the second transmit fails because a completion is
already pending:

  fbnic 0000:41:00.0: Failed to transmit TSENE read msg, err -17

Serialize the hwmon read path with a per-device mutex so only one TSENE
transaction is in flight at a time.

Fixes: 880630734102 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index d0715695c43e..e31d6f88b746 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -6,6 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -27,6 +28,7 @@ struct fbnic_dev {
 	struct net_device *netdev;
 	struct dentry *dbg_fbd;
 	struct device *hwmon;
+	struct mutex hwmon_mutex; /* Serializes hwmon sensor reads */
 	struct devlink_health_reporter *fw_reporter;
 	struct devlink_health_reporter *otp_reporter;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index def8598aceec..ac1b4a422677 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -33,10 +33,17 @@ static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
 	const struct fbnic_mac *mac = fbd->mac;
-	int id;
+	int id, err;
 
 	id = fbnic_hwmon_sensor_id(type);
-	return id < 0 ? id : mac->get_sensor(fbd, id, val);
+	if (id < 0)
+		return id;
+
+	mutex_lock(&fbd->hwmon_mutex);
+	err = mac->get_sensor(fbd, id, val);
+	mutex_unlock(&fbd->hwmon_mutex);
+
+	return err;
 }
 
 static const struct hwmon_ops fbnic_hwmon_ops = {
@@ -60,6 +67,8 @@ void fbnic_hwmon_register(struct fbnic_dev *fbd)
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return;
 
+	mutex_init(&fbd->hwmon_mutex);
+
 	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
 						     fbd, &fbnic_chip_info,
 						     NULL);
@@ -68,6 +77,7 @@ void fbnic_hwmon_register(struct fbnic_dev *fbd)
 			   "Failed to register hwmon device %pe\n",
 			   fbd->hwmon);
 		fbd->hwmon = NULL;
+		mutex_destroy(&fbd->hwmon_mutex);
 	}
 }
 
@@ -78,4 +88,5 @@ void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
 
 	hwmon_device_unregister(fbd->hwmon);
 	fbd->hwmon = NULL;
+	mutex_destroy(&fbd->hwmon_mutex);
 }
-- 
2.53.0-Meta


