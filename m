Return-Path: <netdev+bounces-22003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCEB765A6E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05015282433
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27C27151;
	Thu, 27 Jul 2023 17:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088C15AF5;
	Thu, 27 Jul 2023 17:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B65C433C8;
	Thu, 27 Jul 2023 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690479335;
	bh=1gId2qU5YyEKz8aLJMQLJoFuQSFQRWWUSPfXMTYJBsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rdZizWc9/8Vc5y9rZc6qQwRZxWsVnodVTYfj2FtDCmIux/GU2sNxTI8Uxeze3P74W
	 X4tTXFrk9faQz9i0xPbE3uBB9r/fewQqg/W1Y3ksdpx8fJD+EzlUb/gphGOQxILe87
	 BCY2+OWD59JG32IzqtVZFpOd417+5AvCPD6LfHyEAzmR6BjYO1VXDTmCnsq7e+qCYe
	 RvZHIW5cYKmEbU7fV69kuyuX9vzUqW+6Cj9Lz+Va77kRWe8b8rPG0y2+SEL3LYZsBl
	 Jtk/ulBj3/o3Bpw3lUXw3thbtZkuPtPl7yo13ffWdQGmVbh2hUz8wZygvEjAtJRtRR
	 fUoikf5hXm3/A==
Subject: [PATCH net-next v3 1/7] net/tls: Move TLS protocol elements to a
 separate header
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Thu, 27 Jul 2023 13:35:23 -0400
Message-ID: 
 <169047931374.5241.7713175865185969309.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
References: 
 <169047923706.5241.1181144206068116926.stgit@oracle-102.nfsv4bat.org>
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
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |    1 +
 include/net/tls.h                                  |    4 ---
 include/net/tls_prot.h                             |   26 ++++++++++++++++++++
 net/sunrpc/svcsock.c                               |    1 +
 net/sunrpc/xprtsock.c                              |    1 +
 net/tls/tls.h                                      |    1 +
 6 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 include/net/tls_prot.h

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index 68562a82d036..62f62bff74a5 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
@@ -22,6 +22,7 @@
 #include <crypto/internal/hash.h>
 #include <linux/tls.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/tls_toe.h>
 
 #include "t4fw_api.h"
diff --git a/include/net/tls.h b/include/net/tls.h
index 5e71dd3df8ca..06fca9160346 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -69,10 +69,6 @@ extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
 
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
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e43f26382411..449df8cabfcb 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -44,6 +44,7 @@
 #include <net/tcp.h>
 #include <net/tcp_states.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9f010369100a..9457ebf22fb1 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -48,6 +48,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 
 #include <linux/bvec.h>
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 86cef1c68e03..26a0358f6f49 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -39,6 +39,7 @@
 #include <linux/types.h>
 #include <linux/skmsg.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 
 #define TLS_PAGE_ORDER	(min_t(unsigned int, PAGE_ALLOC_COSTLY_ORDER,	\
 			       TLS_MAX_PAYLOAD_SIZE >> PAGE_SHIFT))



