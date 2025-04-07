Return-Path: <netdev+bounces-179547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72594A7D951
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882E53BB47E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A4233D9D;
	Mon,  7 Apr 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQ+CNyYX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCD233D91
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017324; cv=none; b=QTJkiFfcWeTaXykeZHWZvaaWWZFDh5vHAE1XOsFTKr/kTHVQ2RrVi1euij3hi1JkmK94SKzBNSZEnFW5rFy1xqeuNkClsbMBsg5RTObK9EAC4kczsUi7+Qq0EW5QzyN2bJrLiBRPELX+20LKPSplmybGVWn4hEuQsLVVF/Q+oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017324; c=relaxed/simple;
	bh=9z3V689PWrZKB2em68oywORRS8YveeMbEGmMKB14TCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkqJrdE9YrgnukPCTtGDoq7+0pHMG8fME4eca7QmNwE2Heh4CPRXVGZ5gAJcqDTKxCe2Nwbs9UgA+DEikm8nf7NnjdR1IJIVvV0N4vZTug1mGhoUYfTEhToehpwWc+J0K/EkzX7DcT3o4b/flIEyvhAwcXjGK67Cb5ShvPJ1eQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQ+CNyYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkheVW39FDJEC3CYWkGrKoKpytSKVAai21e5VNhL3CU=;
	b=TQ+CNyYX+ZdGi83xJjauYJAteAD4+sLDVnD5JdPigr02/MFfmJ2DIpf+JXsPdoexnCo87S
	7MMvE9pswpqDWvnojW1EW3y+wjBRLxrzLTpGej8+l4KdOY2fQzKXcD5GsK/jUgr8qbViGy
	WPssyyM/CTPzz8p5v5hVrZGSOSO1Zbc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-1KLJDN38PKilL67mvaJ-SA-1; Mon,
 07 Apr 2025 05:15:17 -0400
X-MC-Unique: 1KLJDN38PKilL67mvaJ-SA-1
X-Mimecast-MFC-AGG-ID: 1KLJDN38PKilL67mvaJ-SA_1744017315
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6465019560B0;
	Mon,  7 Apr 2025 09:15:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 044AE19560AD;
	Mon,  7 Apr 2025 09:15:11 +0000 (UTC)
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
	openafs-devel@openafs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/12] rxrpc: Add the security index for yfs-rxgk
Date: Mon,  7 Apr 2025 10:14:34 +0100
Message-ID: <20250407091451.1174056-4-dhowells@redhat.com>
In-Reply-To: <20250407091451.1174056-1-dhowells@redhat.com>
References: <20250407091451.1174056-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


