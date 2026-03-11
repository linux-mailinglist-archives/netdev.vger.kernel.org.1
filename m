Return-Path: <netdev+bounces-266749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB6YESi8sWmxEwAAu9opvQ
	(envelope-from <netdev+bounces-266749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:02:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A168268FF6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7AD3092AEA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597A2D780A;
	Wed, 11 Mar 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf4t20dp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4423C4F2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255674; cv=none; b=l3J6CyCUBc5gZxdJ9a6lGbyvBQFnLWkDf5bbbNXUKaLHCv9SPiDC9rBYo3K3Obo5VSLeP41Std4oqrfsWs+cwzkZut5UGRnJPq3t2G/HzM6UvfE9pAVLmwFSjcGKt0CepNAt9Yp05qXK4w0N5Q06T5QqVyd+fRP/1i9in6iNsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255674; c=relaxed/simple;
	bh=oFbNfUZ1EKlcB0E6Dze15Yy3zIfKKBbBg37jnwooBEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzECQoovHiqmzjETkQ4W5UTQ433rI7y+i886VN9MJBZZ9qxaqecWqBz8dtIwixwPCgShoxO7bOl25aqaTlaOzT+Qm3Z4jA0DB7g70XUFezACMTqoVdoxttnpkb9L4LzSzkBq1KkoyYI8ntbkxetuJPDgfburuYuo5VGkZy5wmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tf4t20dp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773255672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhQPxMNdb1rSqCIc9Y8of9ob3oNOibTdHDac+Eop6yc=;
	b=Tf4t20dplU2NWqK5WdY410gl8w8mWfjcJL/YkNvgD31ioHRHbMzhPspJKVoCu2g1LeG4O4
	/7tl72fA/aQ/Mx4DVHSnRSo2tQLir4Wr7woxQ4fjBMnyBalLG1pJJxiR+ebiNqfMBjAfPo
	u7MDl7sKIyz52mr96jMX+o4ysoRPXIw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-SI4f66-BNB-2DDgHYpO6TQ-1; Wed,
 11 Mar 2026 15:01:09 -0400
X-MC-Unique: SI4f66-BNB-2DDgHYpO6TQ-1
X-Mimecast-MFC-AGG-ID: SI4f66-BNB-2DDgHYpO6TQ_1773255668
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48A411955F38;
	Wed, 11 Mar 2026 19:01:08 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3D8E30002D2;
	Wed, 11 Mar 2026 19:01:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] dpll: zl3073x: add zl3073x_ref_state_update helper
Date: Wed, 11 Mar 2026 20:00:51 +0100
Message-ID: <20260311190055.139006-3-ivecera@redhat.com>
In-Reply-To: <20260311190055.139006-1-ivecera@redhat.com>
References: <20260311190055.139006-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266749-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A168268FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the per-reference monitor status HW read into a dedicated
zl3073x_ref_state_update() helper in the ref module. Rename
zl3073x_dev_ref_status_update() to zl3073x_dev_ref_states_update()
and use the new helper in it. Call it from zl3073x_ref_state_fetch()
as well so that mon_status is initialized at device startup. This
keeps direct register access and struct field writes behind the ref
module's interface, consistent with the state management pattern
used for other ref operations.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c |  9 ++++-----
 drivers/dpll/zl3073x/ref.c  | 20 ++++++++++++++++++++
 drivers/dpll/zl3073x/ref.h  |  2 ++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 10e036ccf08f0..07626082aae3b 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -543,13 +543,12 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 }
 
 static void
-zl3073x_dev_ref_status_update(struct zl3073x_dev *zldev)
+zl3073x_dev_ref_states_update(struct zl3073x_dev *zldev)
 {
 	int i, rc;
 
 	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
-		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(i),
-				     &zldev->ref[i].mon_status);
+		rc = zl3073x_ref_state_update(zldev, i);
 		if (rc)
 			dev_warn(zldev->dev,
 				 "Failed to get REF%u status: %pe\n", i,
@@ -679,8 +678,8 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	struct zl3073x_dpll *zldpll;
 	int rc;
 
-	/* Update input references status */
-	zl3073x_dev_ref_status_update(zldev);
+	/* Update input references' states */
+	zl3073x_dev_ref_states_update(zldev);
 
 	/* Update DPLL-to-connected-ref phase offsets registers */
 	rc = zl3073x_ref_phase_offsets_update(zldev, -1);
diff --git a/drivers/dpll/zl3073x/ref.c b/drivers/dpll/zl3073x/ref.c
index 8b4c4807bcc44..825ac30bcd6f7 100644
--- a/drivers/dpll/zl3073x/ref.c
+++ b/drivers/dpll/zl3073x/ref.c
@@ -51,6 +51,21 @@ zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult)
 	return -EINVAL;
 }
 
+/**
+ * zl3073x_ref_state_update - update input reference status from HW
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: input reference index
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_ref_state_update(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_ref *ref = &zldev->ref[index];
+
+	return zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(index),
+			       &ref->mon_status);
+}
+
 /**
  * zl3073x_ref_state_fetch - fetch input reference state from hardware
  * @zldev: pointer to zl3073x_dev structure
@@ -79,6 +94,11 @@ int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		return 0; /* Finish - no non-shared items for now */
 	}
 
+	/* Read reference status */
+	rc = zl3073x_ref_state_update(zldev, index);
+	if (rc)
+		return rc;
+
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read reference configuration */
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index ab3a816c29108..06d8d4d97ea26 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -52,6 +52,8 @@ const struct zl3073x_ref *zl3073x_ref_state_get(struct zl3073x_dev *zldev,
 int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
 			  const struct zl3073x_ref *ref);
 
+int zl3073x_ref_state_update(struct zl3073x_dev *zldev, u8 index);
+
 int zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult);
 
 /**
-- 
2.52.0


