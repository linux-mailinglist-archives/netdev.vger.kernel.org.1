Return-Path: <netdev+bounces-181567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96372A85881
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E317C8C7E01
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7029C323;
	Fri, 11 Apr 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtJVeg/b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF729C328
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365243; cv=none; b=dE4VcfAl4YoxfnLzq1nbDWQe1oQZNluoG7KKTGVPLSAX4NpoJF92aIhQhh63PAGpQcyTVGyGk4L/iSpgLxfoiFqPNa7oVW5SdbrWe/dON/q6u18rUzHqwaPTeAMzECh4Sh9GO8EGYQKM31K45ks3MkJqxy2kA43tVSWl42qgipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365243; c=relaxed/simple;
	bh=9z3V689PWrZKB2em68oywORRS8YveeMbEGmMKB14TCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCE+C6Zk2RY9NasSVoKcg5azZOBPtlOoPjPcFz/qp1PORt+jpnCkF94q7QaSOU2wivcFDNBYCcYzJKGl8vb+ZHIDo9i8cwOgw4UxZDNrUDsbN/EqtLqrORZbqFpIVPugkisiwghHcgE9YHrznVwfOS0QCqLeBoDL8cKtWXpi7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtJVeg/b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkheVW39FDJEC3CYWkGrKoKpytSKVAai21e5VNhL3CU=;
	b=ZtJVeg/bQlZfu4GqHuWHlso7uISUfoOrAq3GE9Pbl52/8Kqpe/GSmkbmODZhPlK+N2h9Nk
	Y6DR0Vhl450frh3he5W335FvzTjvlJh4fRrtv0/9HSKeUJyfwCuHZay4oqZfcTgUeKJVd8
	NSR0xWVY5dBkqC0vdMj1bDe8MfHK0Tg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-UYjDg_0VOuCqV95NGUm_DA-1; Fri,
 11 Apr 2025 05:53:51 -0400
X-MC-Unique: UYjDg_0VOuCqV95NGUm_DA-1
X-Mimecast-MFC-AGG-ID: UYjDg_0VOuCqV95NGUm_DA_1744365230
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F9D418C1045;
	Fri, 11 Apr 2025 09:53:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68CB11809B65;
	Fri, 11 Apr 2025 09:53:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 05/14] rxrpc: Add the security index for yfs-rxgk
Date: Fri, 11 Apr 2025 10:52:50 +0100
Message-ID: <20250411095303.2316168-6-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add the security index and abort codes for the YFS variant of rxgk.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/afs/misc.c              | 27 +++++++++++++++++++++++++++
 include/crypto/krb5.h      |  5 +++++
 include/uapi/linux/rxrpc.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index b8180bf2281f..8f2b3a177690 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <crypto/krb5.h>
 #include "internal.h"
 #include "afs_fs.h"
 #include "protocol_uae.h"
@@ -103,6 +104,32 @@ int afs_abort_to_error(u32 abort_code)
 	case RXKADDATALEN:	return -EKEYREJECTED;
 	case RXKADILLEGALLEVEL:	return -EKEYREJECTED;
 
+	case RXGK_INCONSISTENCY:	return -EPROTO;
+	case RXGK_PACKETSHORT:		return -EPROTO;
+	case RXGK_BADCHALLENGE:		return -EPROTO;
+	case RXGK_SEALEDINCON:		return -EKEYREJECTED;
+	case RXGK_NOTAUTH:		return -EKEYREJECTED;
+	case RXGK_EXPIRED:		return -EKEYEXPIRED;
+	case RXGK_BADLEVEL:		return -EKEYREJECTED;
+	case RXGK_BADKEYNO:		return -EKEYREJECTED;
+	case RXGK_NOTRXGK:		return -EKEYREJECTED;
+	case RXGK_UNSUPPORTED:		return -EKEYREJECTED;
+	case RXGK_GSSERROR:		return -EKEYREJECTED;
+#ifdef RXGK_BADETYPE
+	case RXGK_BADETYPE:		return -ENOPKG;
+#endif
+#ifdef RXGK_BADTOKEN
+	case RXGK_BADTOKEN:		return -EKEYREJECTED;
+#endif
+#ifdef RXGK_BADETYPE
+	case RXGK_DATALEN:		return -EPROTO;
+#endif
+#ifdef RXGK_BADQOP
+	case RXGK_BADQOP:		return -EKEYREJECTED;
+#endif
+
+	case KRB5_PROG_KEYTYPE_NOSUPP:	return -ENOPKG;
+
 	case RXGEN_OPCODE:	return -ENOTSUPP;
 
 	default:		return -EREMOTEIO;
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 62d998e62f47..71dd38f59be1 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -63,6 +63,11 @@ struct scatterlist;
 #define KEY_USAGE_SEED_ENCRYPTION       (0xAA)
 #define KEY_USAGE_SEED_INTEGRITY        (0x55)
 
+/*
+ * Standard Kerberos error codes.
+ */
+#define KRB5_PROG_KEYTYPE_NOSUPP		-1765328233
+
 /*
  * Mode of operation.
  */
diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
index c4e9833b0a12..d9735abd4c79 100644
--- a/include/uapi/linux/rxrpc.h
+++ b/include/uapi/linux/rxrpc.h
@@ -80,6 +80,7 @@ enum rxrpc_cmsg_type {
 #define RXRPC_SECURITY_RXKAD	2	/* kaserver or kerberos 4 */
 #define RXRPC_SECURITY_RXGK	4	/* gssapi-based */
 #define RXRPC_SECURITY_RXK5	5	/* kerberos 5 */
+#define RXRPC_SECURITY_YFS_RXGK	6	/* YFS gssapi-based */
 
 /*
  * RxRPC-level abort codes
@@ -125,6 +126,36 @@ enum rxrpc_cmsg_type {
 #define RXKADDATALEN		19270411	/* user data too long */
 #define RXKADILLEGALLEVEL	19270412	/* caller not authorised to use encrypted conns */
 
+/*
+ * RxGK GSSAPI security abort codes.
+ */
+#if 0 /* Original standard abort codes (used by OpenAFS) */
+#define RXGK_INCONSISTENCY	1233242880	/* Security module structure inconsistent */
+#define RXGK_PACKETSHORT	1233242881	/* Packet too short for security challenge */
+#define RXGK_BADCHALLENGE	1233242882	/* Invalid security challenge */
+#define RXGK_BADETYPE		1233242883	/* Invalid or impermissible encryption type */
+#define RXGK_BADLEVEL		1233242884	/* Invalid or impermissible security level */
+#define RXGK_BADKEYNO		1233242885	/* Key version number not found */
+#define RXGK_EXPIRED		1233242886	/* Token has expired */
+#define RXGK_NOTAUTH		1233242887	/* Caller not authorized */
+#define RXGK_BAD_TOKEN		1233242888	/* Security object was passed a bad token */
+#define RXGK_SEALED_INCON	1233242889	/* Sealed data inconsistent */
+#define RXGK_DATA_LEN		1233242890	/* User data too long */
+#define RXGK_BAD_QOP		1233242891	/* Inadequate quality of protection available */
+#else /* Revised standard abort codes (used by YFS) */
+#define RXGK_INCONSISTENCY	1233242880	/* Security module structure inconsistent */
+#define RXGK_PACKETSHORT	1233242881	/* Packet too short for security challenge */
+#define RXGK_BADCHALLENGE	1233242882	/* Security challenge/response failed */
+#define RXGK_SEALEDINCON	1233242883	/* Sealed data is inconsistent */
+#define RXGK_NOTAUTH		1233242884	/* Caller not authorised */
+#define RXGK_EXPIRED		1233242885	/* Authentication expired */
+#define RXGK_BADLEVEL		1233242886	/* Unsupported or not permitted security level */
+#define RXGK_BADKEYNO		1233242887	/* Bad transport key number */
+#define RXGK_NOTRXGK		1233242888	/* Security layer is not rxgk */
+#define RXGK_UNSUPPORTED	1233242889	/* Endpoint does not support rxgk */
+#define RXGK_GSSERROR		1233242890	/* GSSAPI mechanism error */
+#endif
+
 /*
  * Challenge information in the RXRPC_CHALLENGED control message.
  */


