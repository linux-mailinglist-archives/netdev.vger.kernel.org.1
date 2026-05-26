Return-Path: <netdev+bounces-291569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLEhEiNQFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:47:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DEB5D1E0C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92FC330488ED
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC83CAA50;
	Tue, 26 May 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGyxuoFk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83E3CC7D5
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781545; cv=none; b=cjcIbYb7gEh/kB5RgM+q+wfpnyzGIdsG9Tk3tcnTEdll1Uuve2uiiRKK5qhHN1ZF0NZA+0hWNXP6pmEkX2U4muIyhGFgTSTL1hpxYdu8KG8+wd6AL8VY926UtvSStHu8COmNAjC418L7dtNIwYkWJmS+Ipeunm1YG71rgPX2jKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781545; c=relaxed/simple;
	bh=IC247OPJSELP3TYeABidbmiWh+x8QU4VGt5tZ8I7fnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdwY/kxj+oqjTdz9LQ+Rs0HZnwoFfnp91afLP+kzIn9nv+9lT2su3Bmc9vCJAheIlPIIFQj0t7ZxvkmJkHd84RIx0cZlDt0d9+vYjnXJUKu56tFBvf8ozDbDKEa2+uqqUItX/83adUDD74l7WmJSYlowVY/SAWUpRcJw2IwS1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGyxuoFk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779781538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fJWKfO43mFIzbUJOvX1Sg4iP/PsSAXPESJ1EGfBCRA=;
	b=iGyxuoFkW+ai023eR//sK62D5x70TzjTH+c10a2/wpjVTs2ib/UZIqx8T/Eyr0gIKDvdZT
	oRB+ghhEpDrcjng/V6dCWHd+OndCDM8vn3+W1lg0l4VB7cg6aRrQO8IO+RTKUzJ3+IYcKm
	DYy8O6DCBImkxLIUuxeAtTTkOybzxw8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Wk5ksTO-Mcqw1KHqXGg65A-1; Tue,
 26 May 2026 03:45:36 -0400
X-MC-Unique: Wk5ksTO-Mcqw1KHqXGg65A-1
X-Mimecast-MFC-AGG-ID: Wk5ksTO-Mcqw1KHqXGg65A_1779781535
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 717211800610;
	Tue, 26 May 2026 07:45:35 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F28331800576;
	Tue, 26 May 2026 07:45:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] dpll: zl3073x: use __dpll_device_change_ntf() and remove change_work
Date: Tue, 26 May 2026 09:45:24 +0200
Message-ID: <20260526074525.1451008-3-ivecera@redhat.com>
In-Reply-To: <20260526074525.1451008-1-ivecera@redhat.com>
References: <20260526074525.1451008-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291569-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0DEB5D1E0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The change_work was introduced to send device change notifications
from DPLL device callbacks without deadlocking on dpll_lock, since
the callbacks are already invoked under that lock. Now that
__dpll_device_change_ntf() is exported for callers that already
hold dpll_lock, use it directly and remove the change_work
infrastructure entirely.

This eliminates a race condition where change_work could be
re-scheduled after cancel_work_sync() during device teardown,
potentially causing the handler to dereference a freed or NULL
dpll_dev pointer.

Fixes: 9363b4837659 ("dpll: zl3073x: Allow to configure phase offset averaging factor")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 26 +++++++++-----------------
 drivers/dpll/zl3073x/dpll.h |  2 --
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 64b4e9e3e8fe..0770bd895de9 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1079,15 +1079,6 @@ zl3073x_dpll_phase_offset_avg_factor_get(const struct dpll_device *dpll,
 	return 0;
 }
 
-static void
-zl3073x_dpll_change_work(struct work_struct *work)
-{
-	struct zl3073x_dpll *zldpll;
-
-	zldpll = container_of(work, struct zl3073x_dpll, change_work);
-	dpll_device_change_ntf(zldpll->dpll_dev);
-}
-
 static int
 zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 					 void *dpll_priv, u32 factor,
@@ -1113,8 +1104,10 @@ zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 	 * we have to send a notification for other DPLL devices.
 	 */
 	list_for_each_entry(item, &zldpll->dev->dplls, list) {
-		if (item != zldpll)
-			schedule_work(&item->change_work);
+		struct dpll_device *dpll_dev = READ_ONCE(item->dpll_dev);
+
+		if (item != zldpll && dpll_dev)
+			__dpll_device_change_ntf(dpll_dev);
 	}
 
 	return 0;
@@ -1627,13 +1620,13 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 static void
 zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 {
-	WARN(!zldpll->dpll_dev, "DPLL device is not registered\n");
+	struct dpll_device *dpll_dev = READ_ONCE(zldpll->dpll_dev);
 
-	cancel_work_sync(&zldpll->change_work);
+	WARN(!dpll_dev, "DPLL device is not registered\n");
 
-	dpll_device_unregister(zldpll->dpll_dev, &zldpll->ops, zldpll);
-	dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
-	zldpll->dpll_dev = NULL;
+	WRITE_ONCE(zldpll->dpll_dev, NULL);
+	dpll_device_unregister(dpll_dev, &zldpll->ops, zldpll);
+	dpll_device_put(dpll_dev, &zldpll->tracker);
 }
 
 /**
@@ -1926,7 +1919,6 @@ zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
 	zldpll->dev = zldev;
 	zldpll->id = ch;
 	INIT_LIST_HEAD(&zldpll->pins);
-	INIT_WORK(&zldpll->change_work, zl3073x_dpll_change_work);
 
 	return zldpll;
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 434c32a7db12..c8bc8437a709 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -21,7 +21,6 @@
  * @tracker: tracking object for the acquired reference
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
- * @change_work: device change notification work
  */
 struct zl3073x_dpll {
 	struct list_head		list;
@@ -35,7 +34,6 @@ struct zl3073x_dpll {
 	dpll_tracker			tracker;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
-	struct work_struct		change_work;
 };
 
 struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
-- 
2.53.0


