Return-Path: <netdev+bounces-291568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLU/DeVPFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:46:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB75D1DE7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12125303BB22
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B83CC7FD;
	Tue, 26 May 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzqpke1F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E143CC7EC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781540; cv=none; b=QrAnEv5Xd0yeoU+iFHXoSS1XILf1z9Le5lTaSf2Oeo0bUbMegVslQpq5LJm/nEKRJBN81DjQKsxGsJo+eWQiic/fbFkkeMf6MZpmv9gOV0wQDK5f/q4sx/KeQTDSTuBQgNt75rs8UXIuDJfzibaT+bzfbF6uIM5UFnTXWgngLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781540; c=relaxed/simple;
	bh=dzD4bc6V/oUDibuM4AToGSaxbDMRBoPYOsmyRHbdMdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVVIyFEftd2ezxHoyh/0XvPOwfmOXvzGYonLO1kwYNlC40AIESkfF+39S80LxF87Y/PvK1ID4MJPR7YT52odKQG2RWzfUWVvTlGNf4Mq8aHrRC44uoWb2uVnQtBT2ZPL3KwbZ05qLIr+DbJTm9wQNKRJO3xRrgxPYeo619iztLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzqpke1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779781537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9HIX5k4A0YH7zbZMexPpDcifj2A36GK+V459xIGOwE=;
	b=gzqpke1FVhZVh1D2jDbeiAqI9p/+jc1Ca8vH4J+QDY7fYqakmvoMT9lDxO8TCf7paHioGQ
	5xKgCHgI1lhWR29o41UAzhPlv/c4MWllFwbjBSRQ00MXIe4NmBW91cbbOnSNP3p617+3nw
	6zv+r7psHkO/Pvl5L69lC7STn3HvXO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-7Fkf5yM5PPuEdG_kSAc_PA-1; Tue,
 26 May 2026 03:45:34 -0400
X-MC-Unique: 7Fkf5yM5PPuEdG_kSAc_PA-1
X-Mimecast-MFC-AGG-ID: 7Fkf5yM5PPuEdG_kSAc_PA_1779781533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D624195608A;
	Tue, 26 May 2026 07:45:32 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD8D8180034E;
	Tue, 26 May 2026 07:45:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] dpll: export __dpll_device_change_ntf() for use under dpll_lock
Date: Tue, 26 May 2026 09:45:23 +0200
Message-ID: <20260526074525.1451008-2-ivecera@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-291568-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A2DB75D1DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export __dpll_device_change_ntf() so that drivers can send device
change notifications from within device callbacks, which are already
called under dpll_lock. Using dpll_device_change_ntf() in that
context would deadlock.

Add lockdep_assert_held() to catch misuse without the lock held.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 13 +++++++++++--
 include/linux/dpll.h        |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 0ff1658c2dc1..75e3ae0c16d0 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -829,12 +829,21 @@ int dpll_device_delete_ntf(struct dpll_device *dpll)
 	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
 }
 
-static int
-__dpll_device_change_ntf(struct dpll_device *dpll)
+/**
+ * __dpll_device_change_ntf - notify that the dpll device has been changed
+ * @dpll: registered dpll pointer
+ *
+ * Context: caller must hold dpll_lock. Suitable for use inside device
+ *          callbacks which are already invoked under dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
+int __dpll_device_change_ntf(struct dpll_device *dpll)
 {
+	lockdep_assert_held(&dpll_lock);
 	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
 }
+EXPORT_SYMBOL_GPL(__dpll_device_change_ntf);
 
 /**
  * dpll_device_change_ntf - notify that the dpll device has been changed
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index f8037f1ab20b..2dbe8567eafc 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -284,6 +284,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 			       struct dpll_pin *ref_sync_pin);
 
+int __dpll_device_change_ntf(struct dpll_device *dpll);
 int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int __dpll_pin_change_ntf(struct dpll_pin *pin);
-- 
2.53.0


