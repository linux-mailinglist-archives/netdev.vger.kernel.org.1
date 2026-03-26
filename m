Return-Path: <netdev+bounces-272053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDeSFbA2xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:37:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15A336164
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D8D73133077
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E713FB7E6;
	Thu, 26 Mar 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbDT6vyW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9543FA5E0
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531155; cv=none; b=Mp0kOOnh36gzbq9m3XIiZ19AL4SX7wMh7n4tXfHdENED4HzYbA3dEr2kqBZZ08Y8Lx1DVRNkGmaXb0Ejo0vUszFuM0+6BRE7j4UI+9bqln2QdOjfQUXkA7aisUyFIacw41RbhG0QYb3Hr03mk+ygUfPUch4Z8hyO7z+rXLRlpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531155; c=relaxed/simple;
	bh=mBKrZtOnIAHd6KsphkSL/iGsCqPyJf6gyUryLPO2bOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7E+eez9+gG6PAwTFMGM4loIkRdF7sCTr31p+wAw0AZ3AaVp8Emw2OeUkqwhGPbCsBoRSGjB1ZzHF2p5iT3ffposE/OPuidaPkhZ//364TQziwHxlDMX+fxAhPZq5qpgac/69EJQtRZLnrUiydT/orot1egSYVoh2TpC5E2r9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbDT6vyW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774531153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w/tzujNq6shO/Yk27oYEh0iCXtTypElru3vLGpkYIY=;
	b=VbDT6vyWXPO+4os31l2ExNnHHF82D0UgnrYx0yKgwTgl1aL46mhn5Nf7z36r9s1BiEKhh/
	y09GwBqwEiT0dfR64J2r950aF4HbD91LeTrzdq65BSjtJDN9DzejsOAH9ssWSi/tIdtgRL
	m6ZPN9Vz5V/oLnBmmODLvOkgsY7kkuY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-SRuUNOehMoCCTIHOHqYf1Q-1; Thu,
 26 Mar 2026 09:19:09 -0400
X-MC-Unique: SRuUNOehMoCCTIHOHqYf1Q-1
X-Mimecast-MFC-AGG-ID: SRuUNOehMoCCTIHOHqYf1Q_1774531147
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C57C19560B4;
	Thu, 26 Mar 2026 13:19:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93EA6180036E;
	Thu, 26 Mar 2026 13:19:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Johansen <john.johansen@canonical.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Simon Horman <horms@kernel.org>,
	apparmor@lists.ubuntu.com,
	linux-usb@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add on_list() also
Date: Thu, 26 Mar 2026 13:18:29 +0000
Message-ID: <20260326131838.634095-5-dhowells@redhat.com>
In-Reply-To: <20260326131838.634095-1-dhowells@redhat.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272053-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,synopsys.com:email]
X-Rspamd-Queue-Id: DA15A336164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unfortunately, list_empty() is not usable with an entry that has been
removed from a list with list_del_rcu() as ->next must be left pointing at
the following entry so as not to break traversal under RCU.

Solve this by moving on_list_rcu() from AppArmor to linux/list.h, and
turning it into an inline function.

Also add an on_list() counterpart (functionally, this is just an antonym
for list_empty()), but the name looks less awkward when applied to a
non-head element.  We probably don't want to use on_list_rcu() generally
because it requires an extra check as ->prev is set differently in the two
cases.

Further, rename the on_list() function in the Designware usb2 drd ip driver
to dwc2_on_list() to free up the original name.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc: John Johansen <john.johansen@canonical.com>
cc: Minas Harutyunyan <hminas@synopsys.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: apparmor@lists.ubuntu.com
cc: linux-usb@vger.kernel.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 drivers/usb/dwc2/gadget.c          |  6 +++---
 include/linux/list.h               | 26 ++++++++++++++++++++++++++
 security/apparmor/include/policy.h |  2 --
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d216e26c787b..04b6aef8ac13 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4306,11 +4306,11 @@ static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep)
 }
 
 /**
- * on_list - check request is on the given endpoint
+ * dwc2_on_list - check request is on the given endpoint
  * @ep: The endpoint to check.
  * @test: The request to test if it is on the endpoint.
  */
-static bool on_list(struct dwc2_hsotg_ep *ep, struct dwc2_hsotg_req *test)
+static bool dwc2_on_list(struct dwc2_hsotg_ep *ep, struct dwc2_hsotg_req *test)
 {
 	struct dwc2_hsotg_req *req, *treq;
 
@@ -4338,7 +4338,7 @@ static int dwc2_hsotg_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 
 	spin_lock_irqsave(&hs->lock, flags);
 
-	if (!on_list(hs_ep, hs_req)) {
+	if (!dwc2_on_list(hs_ep, hs_req)) {
 		spin_unlock_irqrestore(&hs->lock, flags);
 		return -EINVAL;
 	}
diff --git a/include/linux/list.h b/include/linux/list.h
index 00ea8e5fb88b..d224e7210d1b 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -381,6 +381,32 @@ static inline int list_empty(const struct list_head *head)
 	return READ_ONCE(head->next) == head;
 }
 
+/**
+ * on_list - Test whether an entry is on a list.
+ * @entry: The entry to check
+ *
+ * Test whether an entry is on a list.  Safe to use on an entry initialised
+ * with INIT_LIST_HEAD() or LIST_HEAD() or removed with things like
+ * list_del_init().  Not safe for use with list_del() or list_del_rcu().
+ */
+static inline bool on_list(const struct list_head *entry)
+{
+	return !list_empty(entry);
+}
+
+/**
+ * on_list_rcu - Test whether an entry is on a list (RCU-del safe).
+ * @entry: The entry to check
+ *
+ * Test whether an entry is on a list.  Safe to use on an entry initialised
+ * with INIT_LIST_HEAD() or LIST_HEAD() or removed with things like
+ * list_del_init().  Also safe for use with list_del() or list_del_rcu().
+ */
+static inline bool on_list_rcu(const struct list_head *entry)
+{
+	return !list_empty(entry) && entry->prev != LIST_POISON2;
+}
+
 /**
  * list_del_init_careful - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 3895f8774a3f..c3697c23bbed 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -57,8 +57,6 @@ extern const char *const aa_profile_mode_names[];
 
 #define profile_is_stale(_profile) (label_is_stale(&(_profile)->label))
 
-#define on_list_rcu(X) (!list_empty(X) && (X)->prev != LIST_POISON2)
-
 /* flags in the dfa accept2 table */
 enum dfa_accept_flags {
 	ACCEPT_FLAG_OWNER = 1,


