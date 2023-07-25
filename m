Return-Path: <netdev+bounces-21031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3672762360
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6FB281A8F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09D2590D;
	Tue, 25 Jul 2023 20:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D21C39;
	Tue, 25 Jul 2023 20:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C3BC433C8;
	Tue, 25 Jul 2023 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690317362;
	bh=ShNrhZ1aA+WGsXQTsxGvUWT5T/IpYDxfVtLObK7+6kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EccIAWdNEiZ9FXKxJSooPomVlkz2E1al1jxSVJaOSZyTS/e+wMghHdVl1bD8Hu3JO
	 a+nhMaEamSBpotP+28TxxdkXcRfJ8yJFnst9duJjBacefpF5QfUZXT1N1G+5z9UdUB
	 bCqUksGiw/mdelVZZipcB4XJ3v4cdfrat2/REIFkiOtfkgB8sgLQDGszDTHs+qrxwW
	 vm64Kk9JEqd0rs6x3x0XrjgZRqAj9U1/fdfARirHkwk0bIdn1Zv5boWFBYhXGsTNnZ
	 0wnpZLgnyyXPFl0xTc5d/ETgD2iaXvwdDGTGFC7H2agI9V4PDHzg4MElU+AUYxyqqD
	 kPQn5CYYFHMJA==
Subject: [PATCH net-next v2 1/7] net/tls: Move TLS protocol elements to a
 separate header
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 25 Jul 2023 16:35:51 -0400
Message-ID: 
 <169031734129.15386.4192319236812962393.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
References: 
 <169031700320.15386.6923217931442885226.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Kernel TLS consumers will need definitions of various parts of the
TLS protocol, but often do not need the function declarations and
other infrastructure provided in <net/tls.h>.

Break out existing standardized protocol elements into a separate
header, and make room for a few more elements in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/tls.h      |    5 +----
 include/net/tls_prot.h |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)
 create mode 100644 include/net/tls_prot.h

diff --git a/include/net/tls.h b/include/net/tls.h
index 5e71dd3df8ca..10141be02b5e 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -45,6 +45,7 @@
 
 #include <net/net_namespace.h>
 #include <net/tcp.h>
+#include <net/tls_prot.h>
 #include <net/strparser.h>
 #include <crypto/aead.h>
 #include <uapi/linux/tls.h>
@@ -69,10 +70,6 @@ extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
 
 #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
 
-#define TLS_RECORD_TYPE_ALERT		0x15
-#define TLS_RECORD_TYPE_HANDSHAKE	0x16
-#define TLS_RECORD_TYPE_DATA		0x17
-
 #define TLS_AAD_SPACE_SIZE		13
 
 #define MAX_IV_SIZE			16
diff --git a/include/net/tls_prot.h b/include/net/tls_prot.h
new file mode 100644
index 000000000000..47d6cfd1619e
--- /dev/null
+++ b/include/net/tls_prot.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (c) 2023, Oracle and/or its affiliates.
+ *
+ * TLS Protocol definitions
+ *
+ * From https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml
+ */
+
+#ifndef _TLS_PROT_H
+#define _TLS_PROT_H
+
+/*
+ * TLS Record protocol: ContentType
+ */
+enum {
+	TLS_RECORD_TYPE_CHANGE_CIPHER_SPEC = 20,
+	TLS_RECORD_TYPE_ALERT = 21,
+	TLS_RECORD_TYPE_HANDSHAKE = 22,
+	TLS_RECORD_TYPE_DATA = 23,
+	TLS_RECORD_TYPE_HEARTBEAT = 24,
+	TLS_RECORD_TYPE_TLS12_CID = 25,
+	TLS_RECORD_TYPE_ACK = 26,
+};
+
+#endif /* _TLS_PROT_H */



