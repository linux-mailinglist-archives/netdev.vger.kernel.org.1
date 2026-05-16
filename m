Return-Path: <netdev+bounces-288661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH0oGTPCCGph4AMAu9opvQ
	(envelope-from <netdev+bounces-288661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:14:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100EB55D7D8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 21:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612E9302ED7A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652B362149;
	Sat, 16 May 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDwsgAqC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E73612E7
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958823; cv=none; b=uCVHAUOEu4nJNHdoWPYaTK+DIUi5TdzARe3kJCDkg3A2HVHO7oTw05eKOLGE4GHhizl6WBCXjfQ4KKyALhJZpqCpJhsLx0QnoCZ+5aq18367uXc99gA6pTgq2LL1rtRp2EvkrwgWdoTRjH6s1EO8IXnKHyaJRlMyM8DcxP5eiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958823; c=relaxed/simple;
	bh=AV/PZNcVDZtD3wIbTgjMAGnt05Ae2fGl6vs20KGKVOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8t4WAP3IGZzCLP4uRi+sx3f3/kMyuNAY8Vr/KhYvhVbn1/qEN7Ca1KNarYNFh1nll6Dyki1Tzn7De6DVD15n4XPL4Sq5w/6/yrCboQv5b/L/SmcoeLZt/dZmCnMwCWJFxgdFdzGS0xGeSX0il2VOE/Ftezm0BxcNJYIai8pDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDwsgAqC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778958820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2WYfddecpwHUAGt4Gbbl5tbqcWFhdWpYjlHOX+xowA=;
	b=TDwsgAqC1voBAt2jc6QoKwtS/0koPPhLcZTkJUxw9mITJ57NaBnEbaoBILS0Sx40wd4d+7
	jfIV2Z3hloQgkuE11ZIEEXaUbpkmKWGkVCz1xGhYj13l6YT2wkBUBTqudEefRHnEd/aDpo
	DmZyyw/lEqoBr84tHyjZiV9UOyz9b0U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-Onjj8GdQOTal3xFCFk5WAA-1; Sat,
 16 May 2026 15:13:34 -0400
X-MC-Unique: Onjj8GdQOTal3xFCFk5WAA-1
X-Mimecast-MFC-AGG-ID: Onjj8GdQOTal3xFCFk5WAA_1778958812
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8B7D195608F;
	Sat, 16 May 2026 19:13:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AAD219432BB;
	Sat, 16 May 2026 19:13:28 +0000 (UTC)
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
Subject: [PATCH net 1/2] dpll: fix NULL deref in dpll_device_ops() during teardown race
Date: Sat, 16 May 2026 21:13:16 +0200
Message-ID: <20260516191317.1005612-2-poros@redhat.com>
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
X-Rspamd-Queue-Id: 100EB55D7D8
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
	TAGGED_FROM(0.00)[bounces-288661-lists,netdev=lfdr.de];
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

When a dpll device driver (zl3073x) is unloaded via rmmod while a
foreign driver (ice) still holds pins on it via
dpll_pin_on_pin_register(), dpll_device_unregister() empties
dpll->registration_list but the dpll object stays alive on ice's
refcount. A subsequent PIN_DELETED
notification on ice's pin reaches dpll_cmd_pin_get_one() which calls
dpll_device_ops() on the still-indexed but half-dead dpll;
dpll_device_registration_first() returns NULL and the accessor
dereferences ops at offset 0x10 (struct dpll_device_registration::ops):

  CPU A (zl3073x rmmod)            CPU B (ice workqueue)
  ---------------------            ---------------------
  dpll_device_unregister():
    drop reg from
    dpll->registration_list
                                   dpll_pin_on_pin_unregister
                                     dpll_pin_delete_ntf
                                       dpll_cmd_pin_get_one
                                         dpll_device_ops()
                                           registration_first() = NULL
                                           NULL deref @ 0x10

  WARNING: CPU: 27 PID: 972 at drivers/dpll/dpll_core.c:1072 dpll_device_ops+0x20/0x30
  Workqueue: ice_dpll_wq ice_dpll_pin_notify_work [ice]
  RIP: 0010:dpll_device_ops+0x20/0x30
  Call Trace:
   <TASK>
   ? __warn+0x84/0x140
   ? dpll_device_ops+0x20/0x30
   ? report_bug+0x16b/0x180
   ? handle_bug+0x3c/0x70
   ? exc_invalid_op+0x14/0x70
   ? asm_exc_invalid_op+0x16/0x20
   ? dpll_device_ops+0x20/0x30
   dpll_cmd_pin_get_one+0x303/0x490
   dpll_pin_event_send+0x93/0x140
   dpll_pin_on_pin_unregister+0x45/0xe0
   ice_dpll_pin_notify_work+0x7b/0x150 [ice]
   process_one_work+0x188/0x3b0
   worker_thread+0x2ef/0x410
   kthread+0x122/0x240
   ret_from_fork+0x28/0x50
   </TASK>
  ---[ end trace 0000000000000000 ]---
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: 0010:dpll_device_ops+0x24/0x30
  Call Trace:
   dpll_cmd_pin_get_one+0x303/0x490
   dpll_pin_event_send+0x93/0x140
   dpll_pin_on_pin_unregister+0x45/0xe0
   ice_dpll_pin_notify_work+0x7b/0x150 [ice]
   process_one_work+0x188/0x3b0
   worker_thread+0x2ef/0x410
   kthread+0x122/0x240
   ret_from_fork+0x28/0x50

dpll_lock serializes the two paths but cannot reorder them: ice's work
was queued before zl3073x took the lock. "Empty registration_list on a
still-indexed dpll" is a legitimate transient state caused by
peer-driver refcounting; the accessors must tolerate it.

Drop the WARN_ON in dpll_device_registration_first(), make dpll_priv()
and dpll_device_ops() return NULL on the empty-list state, and bail
out cleanly in dpll_cmd_pin_get_one() when the first dpll the pin
references is already gone.

In-tree doit/dumpit callers of dpll_priv() / dpll_device_ops() obtain
their dpll via dpll_pre_doit() -> dpll_device_get_by_id(), which only
returns DPLL_REGISTERED devices; dpll_device_unregister() clears that
mark only after observing list_empty(&dpll->registration_list), so
those callers cannot see the new NULL return. The only path that can
is dpll_cmd_pin_get_one() reached from dpll_pin_event_send(), gated
here.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/dpll/dpll_core.c    | 12 ++++++------
 drivers/dpll/dpll_netlink.c |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index cbb635db43210f..4a058b46c69d4f 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1060,12 +1060,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_ref_sync_pair_add);
 static struct dpll_device_registration *
 dpll_device_registration_first(struct dpll_device *dpll)
 {
-	struct dpll_device_registration *reg;
-
-	reg = list_first_entry_or_null((struct list_head *)&dpll->registration_list,
-				       struct dpll_device_registration, list);
-	WARN_ON(!reg);
-	return reg;
+	return list_first_entry_or_null((struct list_head *)&dpll->registration_list,
+					struct dpll_device_registration, list);
 }
 
 void *dpll_priv(struct dpll_device *dpll)
@@ -1073,6 +1069,8 @@ void *dpll_priv(struct dpll_device *dpll)
 	struct dpll_device_registration *reg;
 
 	reg = dpll_device_registration_first(dpll);
+	if (!reg)
+		return NULL;
 	return reg->priv;
 }
 
@@ -1081,6 +1079,8 @@ const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll)
 	struct dpll_device_registration *reg;
 
 	reg = dpll_device_registration_first(dpll);
+	if (!reg)
+		return NULL;
 	return reg->ops;
 }
 
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 0ff1658c2dc1ba..8e7e61982b867c 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -682,6 +682,12 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
 	ASSERT_NOT_NULL(ref);
 
+	/* The first dpll the pin references may be torn down while still
+	 * pinned by foreign-driver refs; drop the notification cleanly.
+	 */
+	if (!dpll_device_ops(ref->dpll))
+		return -ENODEV;
+
 	ret = dpll_msg_add_pin_handle(msg, pin);
 	if (ret)
 		return ret;
-- 
2.53.0


