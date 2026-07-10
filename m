Return-Path: <netdev+bounces-306675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vjmgMzRHUWoNBwMAu9opvQ
	(envelope-from <netdev+bounces-306675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5873DBCC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:25:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ESxqYbUh;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306675-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AD23302861D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8285388E4D;
	Fri, 10 Jul 2026 19:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0318391E57
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711414; cv=none; b=EUuj65aBSX200kvhGzJdBB1pV/tEyADmmqE/iGU4CeQgn7WBL3s6PAfm7h9T4i8STEo0LNCYTUjYcM+qx2wHi2Xmti7WzKpQETIBmOhD1oaJb8VO9VQCifRG4UPg11ggG7RN1NKusIogHEtlyCmAHq1Dvkkj4On57NfFqLxKSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711414; c=relaxed/simple;
	bh=jL/n3KbP4JNk40aWbW2ZOyrzCg64XxxSJKZmsed2wSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrvKBiqS6Wy9lzytZk3GN7/g4vAeXPkw2HVklYCuKq6fb0zHGPDV705TPQo9Wv7MYSAejTSuBXtYo7idEoNp/DbKSZNRzj+TCp+6RIUGjvoB8417SEqudCM/Y+U17AZKxu6jd8rlg1eUuAmd2yW8nMpui/H4z/WbXiYClVHxJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESxqYbUh; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCUI/0ckGuUBQpX7hkXR+xl1LYu86FOTTvPjyyN2CUY=;
	b=ESxqYbUhHQuxZ4Bokg91shxXeptzvcFhLECRwFH5+O2/8sMYYpWZhhc/kfmkZO5UmtFbOf
	pTB94PhnsuTDmCsgM0aN5msWOk18NE0aJ9BTqx/9/V/lgZekpoJOYlENLHpixMG4zj5BIW
	y13xNekVd5pz7J3/LEX7Eg8NijxRfWc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-pz4iIGlvNJStMwEUYqdvpw-1; Fri,
 10 Jul 2026 15:23:28 -0400
X-MC-Unique: pz4iIGlvNJStMwEUYqdvpw-1
X-Mimecast-MFC-AGG-ID: pz4iIGlvNJStMwEUYqdvpw_1783711407
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D797D1800750;
	Fri, 10 Jul 2026 19:23:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DFE73000B4D;
	Fri, 10 Jul 2026 19:23:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v2 12/16] keys: Add refcounting to user-defined key type payload
Date: Fri, 10 Jul 2026 20:22:14 +0100
Message-ID: <20260710192220.1922433-13-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306675-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:jarkko@kernel.org,m:keyrings@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DC5873DBCC

Add refcounting to user-defined key type payload so that a kernel service
wanting to use such a key can hold onto the payload without the RCU read
lock held in order that it can do an allocation without having to be
concerned with the key getting updated.

This is the first part of the fix for the AF_RXRPC challenge response
generation code.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: linux-afs@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: stable@kernel.org
---
 include/keys/user-type.h     |  2 ++
 net/dns_resolver/dns_key.c   |  1 +
 security/keys/user_defined.c | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..7002a993a472 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -26,6 +26,7 @@
  */
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
+	refcount_t	ref;
 	unsigned short	datalen;	/* length of this data */
 	char		data[] __aligned(__alignof__(u64)); /* actual data */
 };
@@ -37,6 +38,7 @@ struct key_preparsed_payload;
 
 extern int user_preparse(struct key_preparsed_payload *prep);
 extern void user_free_preparse(struct key_preparsed_payload *prep);
+void put_user_key_payload(struct user_key_payload *payload);
 extern int user_update(struct key *key, struct key_preparsed_payload *prep);
 extern void user_revoke(struct key *key);
 extern void user_destroy(struct key *key);
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..aa3c058f4095 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -208,6 +208,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
 	}
+	refcount_set(&upayload->ref, 1);
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 6f88b507f927..90c1bd5d7dfe 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -67,6 +67,7 @@ int user_preparse(struct key_preparsed_payload *prep)
 	upayload = kmalloc_flex(*upayload, data, datalen);
 	if (!upayload)
 		return -ENOMEM;
+	refcount_set(&upayload->ref, 1);
 
 	/* attach the data */
 	prep->quotalen = datalen;
@@ -88,12 +89,22 @@ EXPORT_SYMBOL_GPL(user_free_preparse);
 
 static void user_free_payload_rcu(struct rcu_head *head)
 {
-	struct user_key_payload *payload;
+	struct user_key_payload *payload =
+		container_of(head, struct user_key_payload, rcu);
 
-	payload = container_of(head, struct user_key_payload, rcu);
 	kfree_sensitive(payload);
 }
 
+/*
+ * Free a user defined key payload.
+ */
+void put_user_key_payload(struct user_key_payload *payload)
+{
+	if (payload && refcount_dec_and_test(&payload->ref))
+		call_rcu(&payload->rcu, user_free_payload_rcu);
+}
+EXPORT_SYMBOL_GPL(put_user_key_payload);
+
 /*
  * update a user defined key
  * - the key's semaphore is write-locked
@@ -115,8 +126,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 	rcu_assign_keypointer(key, prep->payload.data[0]);
 	prep->payload.data[0] = NULL;
 
-	if (zap)
-		call_rcu(&zap->rcu, user_free_payload_rcu);
+	put_user_key_payload(zap);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(user_update);
@@ -134,7 +144,7 @@ void user_revoke(struct key *key)
 
 	if (upayload) {
 		rcu_assign_keypointer(key, NULL);
-		call_rcu(&upayload->rcu, user_free_payload_rcu);
+		put_user_key_payload(upayload);
 	}
 }
 
@@ -147,9 +157,8 @@ void user_destroy(struct key *key)
 {
 	struct user_key_payload *upayload = key->payload.data[0];
 
-	kfree_sensitive(upayload);
+	put_user_key_payload(upayload);
 }
-
 EXPORT_SYMBOL_GPL(user_destroy);
 
 /*


