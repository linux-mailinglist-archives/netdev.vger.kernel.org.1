Return-Path: <netdev+bounces-306681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VYXDASNKUWruBwMAu9opvQ
	(envelope-from <netdev+bounces-306681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123A73DDC9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:38:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UUFLgzeX;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306681-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306681-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2FC6300D31B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53E379C57;
	Fri, 10 Jul 2026 19:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9537E2ED
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712198; cv=none; b=llZkfu8ZlD76GKhpdpAcO1YMYISuZKhtH3tvnLHl4YBdVBHh31FeCLUNKzT29soC1xUfs1d/ZaZTtVsC4mo5IiFhR1ZG/gR0jjYy/fbi/b6bZE93F+j8Ef2xIDqX/idayZFx/1tjtEN4ET7KJxMrKmO4DbFeKK0F/ByAV+e/Mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712198; c=relaxed/simple;
	bh=WS98kGfygDlEMfZuJnC9+mF5mKSQWAxcx5kFA6qA8r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxkiW2SloEnWMsMtYWyXaADlh0/9UJmCrdfqHGiigMbrurvbMfVhdftD7pegv9tNnyyq0XFXeeER9BKQU0TsJ27sz5jsdC7ve24zC4DWNbsltYojhTpEehq0qu93NZzDDvOhcXoxGDsQcoACqyIg4JCKagnhHPe6Sq2kePXbCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUFLgzeX; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783712195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lKRebUVmsTw/jM/4fGeq3q+j+hSjHHN0rDmB9FYU7rk=;
	b=UUFLgzeXhIV/LILRXYuyGQ/+5VyYvMup5hguHWPSzvqVxVZHbRfhBNS1QXFncAiTb6tW5n
	wVMrjijRanSp9xyJp7WBMN7OIeEKR5GNT9evHbGD52g1QKRYB7ja/oCB+JQT+jp8SsXGOC
	qElYOAu4SiPF+PiknkP6v0JyCXVuClo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-34P3W8L6OqemADJc-SGs7Q-1; Fri,
 10 Jul 2026 15:36:32 -0400
X-MC-Unique: 34P3W8L6OqemADJc-SGs7Q-1
X-Mimecast-MFC-AGG-ID: 34P3W8L6OqemADJc-SGs7Q_1783712191
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF2441800639;
	Fri, 10 Jul 2026 19:36:29 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 157133000B4D;
	Fri, 10 Jul 2026 19:36:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: fix NULL pointer dereference in dpll_msg_add_pin_ref_sync()
Date: Fri, 10 Jul 2026 21:36:25 +0200
Message-ID: <20260710193625.1378822-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:arkadiusz.kubalewski@intel.com,m:jiri@resnulli.us,m:przemyslaw.kitszel@intel.com,m:milena.olech@intel.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5123A73DDC9

When a dpll_pin is shared across multiple dpll_device instances and
those devices are being unregistered (e.g. during driver module removal),
a NULL pointer dereference can occur in dpll_msg_add_pin_ref_sync().

This happens under the following conditions:
 - A pin is registered with two or more dpll devices (dpll_A, dpll_B)
 - The pin has ref_sync pairs with other pins
 - During unregistration of dpll_A's pins, a ref_sync partner pin is
   unregistered first, removing it from dpll_A->pin_refs
 - But since the partner pin is still registered with dpll_B, its
   dpll_refs is not empty, so dpll_pin_ref_sync_pair_del() does NOT
   run and the partner stays in the pin's ref_sync_pins xarray
 - When the pin itself is then unregistered from dpll_A, the delete
   notification calls dpll_msg_add_pin_ref_sync() which finds the
   partner in ref_sync_pins, passes dpll_pin_available() (partner is
   still registered with dpll_B), but dpll_pin_on_dpll_priv(dpll_A,
   partner) returns NULL because partner was already removed from
   dpll_A->pin_refs
 - The NULL priv pointer is passed to the driver's ref_sync_get
   callback, which dereferences it

 BUG: kernel NULL pointer dereference, address: 0000000000000034
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:zl3073x_dpll_input_pin_ref_sync_get+0x73/0x80 [zl3073x]
 Call Trace:
  dpll_msg_add_pin_ref_sync+0xb8/0x200
  dpll_cmd_pin_get_one+0x3b6/0x4b0
  dpll_pin_event_send+0x72/0x140
  __dpll_pin_unregister+0x5a/0x2b0
  dpll_pin_unregister+0x49/0x70

Fix this by skipping ref_sync pins whose priv pointer cannot be resolved
for the current dpll device.

Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index bf729cde796a7..5703667593a7c 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -567,6 +567,9 @@ dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
 		if (!dpll_pin_available(ref_sync_pin))
 			continue;
 		ref_sync_pin_priv = dpll_pin_on_dpll_priv(dpll, ref_sync_pin);
+		/* Pin may have been unregistered from this dpll already */
+		if (!ref_sync_pin_priv)
+			continue;
 		if (WARN_ON(!ops->ref_sync_get))
 			return -EOPNOTSUPP;
 		ret = ops->ref_sync_get(pin, pin_priv, ref_sync_pin,
-- 
2.53.0


