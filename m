Return-Path: <netdev+bounces-288660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBNUJTDCCGph4AMAu9opvQ
	(envelope-from <netdev+bounces-288660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:14:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0933255D7D1
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD0B302E324
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC1361DDE;
	Sat, 16 May 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yns+WYNW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789035E1A1
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958822; cv=none; b=YFta66j98uhdmbQM7uuNMtAIg6QCtxp6OG4At84kf7Y/scqYlLpqrDd4j1NCl2wqhjuzovrtRdiVnZuzKBHqXq6WsCfMg9TJIFo2988xRGdMJgCWYuaoFrJHxmqIq2dVaatHvBuSedW6o4VgZ2PCF8iOhGhUcrpTcZKURWInA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958822; c=relaxed/simple;
	bh=aairhOuEZ/yJXBB7QRohlAMS+C/i0oi1qnLIZouQ0lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm+XnU19mZ0LE4ENcChCUxlxQbLhPMuki72Q+AoJ1XSU6F/RkNL1oFgWNlqAwVPpTU3LBRFkOpSuX6LkPgGoTKAZuD017CjLrwanMXsDgs66yAcLG3CN/eEFFOBdfdiFJNgyGKZ2M6mKXm5uv9/Vd298ZiHA/YW0FrqIjKlxphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yns+WYNW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778958820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXQNBpnpZA0xiPF9Pkissd/3JRF00KGEdyGdDHa5h9E=;
	b=Yns+WYNW7D3apvAvHe5BKEg69+03xsQPY1yzVxV0dNKs+adIx25SOilzX3lM935eCHRiGx
	SYq6nIN09uv1eYMnUM/gDXS9DdQ7dM2wcdN4BJJYnohul+w6zYmu1s0cPudCHMC1LYwO6L
	r48MqpBxWEX0w1DN66hnUFdDbu1pinA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-JyGQjYQ9P6yllTphzDuLCg-1; Sat,
 16 May 2026 15:13:36 -0400
X-MC-Unique: JyGQjYQ9P6yllTphzDuLCg-1
X-Mimecast-MFC-AGG-ID: JyGQjYQ9P6yllTphzDuLCg_1778958815
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3256E18005B8;
	Sat, 16 May 2026 19:13:35 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73AE61956053;
	Sat, 16 May 2026 19:13:32 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: ivecera@redhat.com,
	Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Milena Olech <milena.olech@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] dpll: filter pin->dpll_refs by cookie in dpll_pin_on_pin_unregister
Date: Sat, 16 May 2026 21:13:17 +0200
Message-ID: <20260516191317.1005612-3-poros@redhat.com>
In-Reply-To: <20260516191317.1005612-1-poros@redhat.com>
References: <20260516191317.1005612-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 0933255D7D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-288660-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

dpll_pin_on_pin_register() iterates parent->dpll_refs and adds the
child pin to each dpll the parent contributes to, tagging the
registration with cookie = parent. The unregister side asymmetrically
iterates pin->dpll_refs (a union across all of pin's parents) and
calls __dpll_pin_unregister() on every entry without checking that
the entry carries a (ops, priv, parent) registration.

When the same pin is reachable through multiple parents whose
supported-dpll sets differ, unregistering one parent walks entries
owned by other parents and trips WARN_ON(!reg) in
dpll_xa_ref_pin_del():

  parent_A in {dpll_X}, parent_B in {dpll_X, dpll_Y}
  pin reachable through both
    pin->dpll_refs = {dpll_X, dpll_Y}
    dpll_X has cookies {parent_A, parent_B}
    dpll_Y has cookie  {parent_B}

  unregister(parent_A) iterates {dpll_X, dpll_Y}; the dpll_Y step
  looks up cookie = parent_A which was never there -> WARN.

  WARNING: CPU: 137 PID: 4498 at drivers/dpll/dpll_core.c:252 dpll_xa_ref_pin_del.isra.0+0x1b0/0x1c0
  Call Trace:
   <TASK>
   __dpll_pin_unregister+0xed/0x2e0
   dpll_pin_on_pin_unregister+0x91/0xe0
   ice_dpll_deinit_pins+0xb2/0x400 [ice]
   ice_dpll_deinit+0x32/0x130 [ice]
   ice_deinit_features.part.0+0xb6/0x100 [ice]
   ice_unload+0xdf/0x120 [ice]
   ice_remove+0x144/0x2f0 [ice]
   ice_shutdown+0x16/0x50 [ice]
   pci_device_shutdown+0x34/0x60
   device_shutdown+0x158/0x200
   kernel_kexec+0x48/0x160
   __do_sys_reboot+0xda/0x230
   do_syscall_64+0xec/0x680
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

Filter the iteration by the (ops, priv, parent) cookie so only the
entries this parent actually contributed to get touched. Keep
pin->dpll_refs as the iteration source (rather than parent->dpll_refs
as in register) so cleanup is also correct when the parent has been
independently unregistered from some of its dpll devices in the
meantime; switching sides would silently leak those registrations.

The fix is placed at the call site rather than relaxing WARN_ON(!reg)
in dpll_xa_ref_pin_del(): other callers (dpll_pin_unregister() with
cookie = NULL, the dpll_pin_on_pin_register() error rollback with
cookie = parent) pass cookies that must be present, and the WARN
remains useful there as a double-unregister catch.

Reproduced on E825-C + zl3073x via kexec stress: WARN appears within
1-4 reboots without the fix, none across several hundred reboots
with it.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/dpll/dpll_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 4a058b46c69d4f..4779976682fdb9 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1024,8 +1024,14 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	mutex_lock(&dpll_lock);
 	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
-	xa_for_each(&pin->dpll_refs, i, ref)
+	/* pin->dpll_refs is the union over all of pin's parents; only
+	 * touch entries actually registered via @parent.
+	 */
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (!dpll_pin_registration_find(ref, ops, priv, parent))
+			continue;
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
+	}
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
-- 
2.53.0


