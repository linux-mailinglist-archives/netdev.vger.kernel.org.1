Return-Path: <netdev+bounces-251870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD2RMVjScGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:19:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8F5771C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8853360C563
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626E481AA4;
	Wed, 21 Jan 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgvJ5vqA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1A481A9E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000428; cv=none; b=IoBX+LxzsYOCQ3TaXEhJ0cKbWfh86pBeSSyKfmbI8HmMmhJt7j5hi+e3tasbxNpWwqUhXjmLvPQpNZMsUCaor6zTrm0VNp72xTv/qGwS/OFq4x8NZtUp385GhAsxrKwUm8KCMWUTGIHSslD0gj8NF36b8YeIQ2e3GY2fnQ4NfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000428; c=relaxed/simple;
	bh=bUu43LQgT8yAOzAl+/u9fJOsAD/+bXQRvmZtMsuwt2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kc4nQZ/eKH3P435AsZgeBGnScGd6DroynXvIiW3YPYyHKVpyLNB/AfZk1J5mF8hMWdX1DkE3+0AXimoXu/U4lfBaHox/JfvSEo+KyW5QzFX98pIfqkcKHht5yC8n8M6a7l23ZWJWtRGKOPIX7NLKi9KgUtw3fWxojU9JKgdsOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgvJ5vqA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769000424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=07keXz77xMZfJHIoYajXfcSDc0qFVlaNkmTnOeD+/10=;
	b=QgvJ5vqAa2sfU2MzBOj2v0o6N4tirBRKz8FpUqPtzdoQFfcpXExIByohvzmkgfLtYcJHcK
	XVIsvV6RoY0RU/R2oBZFdNZwHl6FwNqHaouRLW2LmB48TAWszPvEwdH5rLMOhs+CoJKWWm
	QaWybzE+IIA1TY+VBcABmCk3tyzWmfw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-66WmoPQrOxSCBRIXBfjNdQ-1; Wed,
 21 Jan 2026 08:00:20 -0500
X-MC-Unique: 66WmoPQrOxSCBRIXBfjNdQ-1
X-Mimecast-MFC-AGG-ID: 66WmoPQrOxSCBRIXBfjNdQ_1769000417
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCB751955F06;
	Wed, 21 Jan 2026 13:00:16 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F0AF19560A2;
	Wed, 21 Jan 2026 13:00:13 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Michal Michalik <michal.michalik@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: Prevent duplicate registrations
Date: Wed, 21 Jan 2026 14:00:11 +0100
Message-ID: <20260121130012.112606-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251870-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3BE8F5771C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Modify the internal registration helpers dpll_xa_ref_{dpll,pin}_add()
to reject duplicate registration attempts.

Previously, if a caller attempted to register the same pin multiple
times (with the same ops, priv, and cookie) on the same device, the core
silently increments the reference count and return success. This behavior
is incorrect because if the caller makes these duplicate registrations
then for the first one dpll_pin_registration is allocated and for others
the associated dpll_pin_ref.refcount is incremented. During the first
unregistration the associated dpll_pin_registration is freed and for
others WARN is fired.

Fix this by updating the logic to return `-EEXIST` if a matching
registration is found to enforce a strict "register once" policy.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a461095efd8a..8879a7235156 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -83,10 +83,8 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 		if (ref->pin != pin)
 			continue;
 		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
-		if (reg) {
-			refcount_inc(&ref->refcount);
-			return 0;
-		}
+		if (reg)
+			return -EEXIST;
 		ref_exists = true;
 		break;
 	}
@@ -164,10 +162,8 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 		if (ref->dpll != dpll)
 			continue;
 		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
-		if (reg) {
-			refcount_inc(&ref->refcount);
-			return 0;
-		}
+		if (reg)
+			return -EEXIST;
 		ref_exists = true;
 		break;
 	}
-- 
2.52.0


