Return-Path: <netdev+bounces-18700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9375853A
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414CB281659
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578A156E1;
	Tue, 18 Jul 2023 18:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB5168A1;
	Tue, 18 Jul 2023 18:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1CEC433C8;
	Tue, 18 Jul 2023 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706769;
	bh=ShNrhZ1aA+WGsXQTsxGvUWT5T/IpYDxfVtLObK7+6kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zw8+ZtEmkdJMS2cSZXtLOmmLx9wro0TUtcKc22SdwYJOK8SDTXuvAWv1hyFn1ppQi
	 TFlI9pOxYRvV7yj9e5fhhAYFlrMgmObOxbfFrfVxo8yiSfvUFtoBo1aSbw92okBQH3
	 /ucedCyEooY6kQlBYN+UIuUQArgAbx1tS6zwsn5DoJVFcQ4yT/C1iS1Y0hB+Hr3PvM
	 N/H8mMslrpNVcBNdf+FABh7BlRGXTW2Nkkrfv1ZNYaVSfPIRmubq051Rz1u74HQvO3
	 pD+etMGzNjmc2bdgDn5M+Au2AqxmNXCFBfQSp9uk3LW55/3O0vgj56xEilBdh98QGX
	 zCA/9SpXwrDeg==
Subject: [PATCH net-next v1 1/7] net/tls: Move TLS protocol elements to a
 separate header
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 18 Jul 2023 14:59:18 -0400
Message-ID: 
 <168970674791.5330.17127606927415243712.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
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



