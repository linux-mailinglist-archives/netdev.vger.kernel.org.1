Return-Path: <netdev+bounces-270584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLodG31fwWmaSgQAu9opvQ
	(envelope-from <netdev+bounces-270584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:42:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE02F6C47
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1709430D1081
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522343B8BC3;
	Mon, 23 Mar 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkzPnFuK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BE3B895B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278347; cv=none; b=hT1GbiTPoQKCkDpDLOFgPbvDf1Za9YVfZ4LeFmJ9B0vJbguXCgVjPDpneDJX4aXoedW42gLXnPi57mgfO429EDCs+iJ1OP9ysXJVkL4PJRngXzHYHzfoeGlx/8/T6nyfwFbSvJLfPGIPFm1GCQ+R5WLJOe3RLRTAxyLo/KnPmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278347; c=relaxed/simple;
	bh=n0iPo2pDZQX9XRo48GkCor41ZVjHORjsiDeF+v5aYvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhLttyAKql+ffNhqmGAvdkwd3f8xFbyAIBJCxRXq11b1bYWrq2T8q9DIj6bGvBgPULHZ+C38W6L57LvCvaxxuIiqx+1QkF8hJxw/PtUBKC9Hr0XuNrivTpb+ZfJbuLBM02Dck7EqoMaScFnge4KFu/ORFWwMsQzMhxaMZLFd3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkzPnFuK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774278345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8irQRHfFWnEfG6qljHMonM0AVFnFCevGipBEnTRuQk=;
	b=dkzPnFuK4v8ypWPUAdjfl3VzbEKzUltsCa8QlN1OWlXQcwZiRMJ2kjyWW0bxES4LC/0RCZ
	0pYDugI4v+cnXarLZXfX3bbSiQ2KbSCxlBBkOvvI4V658KFZ30OdEPf5VJVzRm55u08Em+
	9XP6pQtaLNNSQxq3Mo7Ua+xvGdY4DCI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-1PmYBqROPYW4-KZDozPj9w-1; Mon,
 23 Mar 2026 11:05:39 -0400
X-MC-Unique: 1PmYBqROPYW4-KZDozPj9w-1
X-Mimecast-MFC-AGG-ID: 1PmYBqROPYW4-KZDozPj9w_1774278337
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08B6E180049D;
	Mon, 23 Mar 2026 15:05:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27DB71955F2E;
	Mon, 23 Mar 2026 15:05:31 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>,
	apparmor@lists.ubuntu.com,
	stable@kernel.org
Subject: [PATCH net v2 04/10] list: Move on_list_rcu() to list.h and add on_list() also
Date: Mon, 23 Mar 2026 15:04:55 +0000
Message-ID: <20260323150505.3513839-5-dhowells@redhat.com>
In-Reply-To: <20260323150505.3513839-1-dhowells@redhat.com>
References: <20260323150505.3513839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270584-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6DCE02F6C47
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

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc: John Johansen <john.johansen@canonical.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: apparmor@lists.ubuntu.com
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 include/linux/list.h               | 26 ++++++++++++++++++++++++++
 security/apparmor/include/policy.h |  2 --
 2 files changed, 26 insertions(+), 2 deletions(-)

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


