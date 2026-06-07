Return-Path: <netdev+bounces-296292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hi+rLVy6JWoYLAIAu9opvQ
	(envelope-from <netdev+bounces-296292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:37:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25898651456
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Bx669Co4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296292-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296292-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E93003013788
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD2319847;
	Sun,  7 Jun 2026 18:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345830C149;
	Sun,  7 Jun 2026 18:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857335; cv=none; b=ptHEB5VHnRGAU+DtO1fLR/l44UM5s62CUCxDkXV/I3Kbr6raiIQb8mwsyVdrHwbff715nMhD00vcfl5NN6EiExomjWzw+i+j2XyHfpxK3dOeHMLIope9vCewJLzIxfUWBsiFMaGyaivJ2Dz9iu+qwgwc3wXEz2de7IZWOpkZdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857335; c=relaxed/simple;
	bh=jDp4eSRwMsigpbrYQb0dTY3bkMQJY0JpBLge9f19z38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPiaxXRAUSscd2jsrYQoWh/LJpyfx3YJceDB3T1VBEHmUeMzsqQCTMgk3MFr3lxoSGPFOorOtX/JiWdTQzYscP5A8A/260LmUYZpcjXLEwqhMKepDjvjLitaSZII7Ildx+DW7qVHZ+/iDNuXoHgXo6LbnlvF5SN2Oz+XBFC3V3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bx669Co4; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780857334; x=1812393334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jDp4eSRwMsigpbrYQb0dTY3bkMQJY0JpBLge9f19z38=;
  b=Bx669Co4cC4CmqP7RqZnZWHalFxjNIF9h0/yX5pYRFgBy64G4lYNnAs/
   jypO7cAaDNQwNCwPQG3GXXCDycTgz3t24wFzRaLLMr/lAH28lO17uHadv
   ecIOYWDDVMPJL9AXItF4OVeGviYce3lrfSbClgOlovmb51ZtibJt8llA8
   r3LEt2no7WKZGjhcoY6IV30FhVzgh4zNUW2OpxQBT56n3dAzRF66mQqzV
   582R7hXpus6Obc7ip+28Im5Ac87hshqemJGHNzr9+9IIzPrz7fTr+6A8f
   B+7DjCYIW9uFhTF+Jd2ubYX49VflOaBjfjdp49c3crd1onZgoY/dLF+r3
   A==;
X-CSE-ConnectionGUID: TMPbO7UjQNiHDxy2w+CqYQ==
X-CSE-MsgGUID: oshTho2tSVqAecBlIEd3gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81602033"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81602033"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 11:35:34 -0700
X-CSE-ConnectionGUID: RHmeJ/vbSy6E3AFNXfjQRg==
X-CSE-MsgGUID: lb/aNk++S3Gwm2FBQbxitA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245171355"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:35:28 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v14 net-next 03/13] dpll: fix stale iteration in dpll_pin_on_pin_unregister()
Date: Sun,  7 Jun 2026 20:30:35 +0200
Message-Id: <20260607183045.1213735-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296292-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:grzegorz.nitka@intel.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25898651456

Neither parent->dpll_refs nor pin->dpll_refs on its own is a correct
iteration target at unregister time:

  - pin->dpll_refs includes DPLLs the child was registered against
    via a different parent or directly; blind unregister WARNs on
    the cookie miss in dpll_xa_ref_pin_del().
  - parent->dpll_refs reflects the parent's current attachments, not
    those at child-register time. Another driver may have (un)reg'd
    the parent against additional DPLLs in the meantime, so we miss
    registrations that exist and visit DPLLs that have none.

Walk pin->dpll_refs and use dpll_pin_registration_find() to filter
to entries whose cookie is this parent. Symmetric with
dpll_pin_on_pin_register(), correct under any subsequent change to
parent->dpll_refs.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 6dc7e93ece75..cea7e2be2cbc 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1031,14 +1031,19 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
 void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 				const struct dpll_pin_ops *ops, void *priv)
 {
+	struct dpll_pin_registration *reg;
 	struct dpll_pin_ref *ref;
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
 	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
-	xa_for_each(&pin->dpll_refs, i, ref)
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		reg = dpll_pin_registration_find(ref, ops, priv, parent);
+		if (!reg)
+			continue;
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
+	}
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
-- 
2.39.3


