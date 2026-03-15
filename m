Return-Path: <netdev+bounces-267950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKmoNtrvtmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:43:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC59291D20
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20B6E30242A7
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FD37A4BC;
	Sun, 15 Mar 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0AlXuZh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2537A486
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596574; cv=none; b=VEjpm5GUNIXtYA8VRCVupeY1mco1EnYRZ+KMRgL1Q/P1Z3bzQmES38K3lZG22nqaDIq/3PkBfD8w17eBL+4vDHucXognCzhYczvxC5mNF0S/I+qLA3UCSBaIeqWmn1SiEwKYJuiHNjji0gJQWEbHIsp8qWkjeqqX1zbede+wNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596574; c=relaxed/simple;
	bh=oFbNfUZ1EKlcB0E6Dze15Yy3zIfKKBbBg37jnwooBEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b37akOdOAkLbKZsfm1PTH8eOnpwDiZ47LmzZXD3MFYkr9c9ZIE9n44ptyAb1wAGpj1JpEo6Y+m3YTmbxarwd2Pq3280b6z3go6ECkcNHnwOMzBJ/iYotko2cZBqAEg7FfbDYRInvpXStYiLMj2bQoxfDDdURXCQV1VTSpyFirfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0AlXuZh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773596570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhQPxMNdb1rSqCIc9Y8of9ob3oNOibTdHDac+Eop6yc=;
	b=C0AlXuZhpZh5l/EA1APhXlEl+7MS18TsgY8CqvXC7OFPj3rWSNDQr7ZXn7BnOzh+KuLPaa
	jNkOCRuDYNXyaeSyoSGKVH2eM2pFei+VQ5uSRa9y9PJCQzEnPhzL7yBOZLAg1zvWhUDi1w
	FKMr3uwhpDEY5nHRi04Qv3AjwN8q3eU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-4dynnDpJPNq-x3Yevc1bdw-1; Sun,
 15 Mar 2026 13:42:42 -0400
X-MC-Unique: 4dynnDpJPNq-x3Yevc1bdw-1
X-Mimecast-MFC-AGG-ID: 4dynnDpJPNq-x3Yevc1bdw_1773596558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A3171956089;
	Sun, 15 Mar 2026 17:42:38 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DC7A1955D87;
	Sun, 15 Mar 2026 17:42:34 +0000 (UTC)
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
Subject: [PATCH net-next v2 2/6] dpll: zl3073x: add zl3073x_ref_state_update helper
Date: Sun, 15 Mar 2026 18:42:20 +0100
Message-ID: <20260315174224.399074-3-ivecera@redhat.com>
In-Reply-To: <20260315174224.399074-1-ivecera@redhat.com>
References: <20260315174224.399074-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267950-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5DC59291D20
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


