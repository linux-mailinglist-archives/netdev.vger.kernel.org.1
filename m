Return-Path: <netdev+bounces-88613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F98A7EA9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D8E1F229C0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B912A15B;
	Wed, 17 Apr 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhWQP+SZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2C7E0E4;
	Wed, 17 Apr 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343917; cv=none; b=AC+/FNNRCaLsMhM2t0FdEROHa1MAZxM+PMHWMSrxRbwZ1uc02c62Cq6aWAkJ1+5K9TiMQhDrAi+Owhg3+N8O0uIA7QzkpPU8cPIh7xYVebZm0yccCFUQpJwP11gF8+xOLlzp3bqed0B7nErhcfX3qLqvjfFnaq+DkCzzYrbc++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343917; c=relaxed/simple;
	bh=RJnbFc5JHAO9cPZZJOzJbZBugWtXN/ZrYKzKfwfgFG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWKvVAokpFIq2owLfPXHtetHvSrAClxz0axoUa2+wQUal4t90AP/TSEniZyAfPTLgaiHijDF+5ItKMpZuv11Z80USkcXaQxd0AS9YF7qdFd9qs8sXVQgmqsWfXEF/diLVGlfeyXXGOz8OZtg84PhUWWvR5e52dPEXX8ZBwMtKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhWQP+SZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3ff14f249so4397325ad.1;
        Wed, 17 Apr 2024 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343915; x=1713948715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=IhWQP+SZuvPSubhPTIPi1mD6coBTYNdi++OdX9hilEz9UvqkViLUO5rQpGaRgCWOlk
         8QAkzLpdvT6ZU0uu/QjpG9zEEpYJlr5aPm2rh6aVHAoenY4UW/fnM7WvMV9p64LOTIl5
         VzSk/trEqDq5T/BSMSSI7gpZ/yPa13xH83rrGHkut9djVpLfonBEZustHr/j0+aNuYTI
         PN8VwdNHWsqWCvZ/U6gfCPaCKDy+kck9y4GWGVSwYgQVbT6rFIfAb7uJC+KmasP+s+xJ
         +JBlf/inyMJsrnViEiRKB11wAVZSQDsf4qB/rQ+WkUONVStsM/bbffn2+4iE5oUxGcq7
         4oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343915; x=1713948715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=A2hHdLTbWTW9j+c1U/uTOo0ZjZG5dmDRR8lmlk6iIkZdoeO7mVkgF+Hl3etBiTlU6K
         zLqsVpY2oVKZwmZg4NMMH3pbfiDGtfclke3/tNCFBd1Jbz6YGBeSAtvxU23m+Fi6GDbO
         YlyPUHp0GJ1SanLUTmnjzeCy3aMB6SiYUpzV6CQ6Yq1iLAqiaZDHmiiaLoFmiEbptWmF
         fwInXU5BWILoXlJjFNOGarH2E2hWP+zz9SLsV8o/6QxvVDEnDFuYbjuPQYZf1TCuYI3g
         ST3QM65R/yHOlurYQTMwk91VjzwryEuHF8Hen3fDIDNraT8eAjFqZYU0+Mt4FmzOU/4g
         6kXg==
X-Forwarded-Encrypted: i=1; AJvYcCWVgy7pIO8YQuhL6j59J92Tr1Wl39sgrmGOs7uvwsAvypWdshTiKm9gtUwbp427989CT72Y7+uJPF+2zdOZpgvnVbOFglZ5QctPUj2za7aQgqfCf6x3S1siFD4X0qgfvSiyZoQ6PMMWx3rO
X-Gm-Message-State: AOJu0Yws+u85WLs8/+hWOpseukv+iRKMOUuhH5q5cuhUjk4e6PMBNA+a
	tDX0HNW9BufplR/Q5CwwO/8dfW8mX3e3R6+7elRIuVX6T6N9r+HQ
X-Google-Smtp-Source: AGHT+IFcbXoGxv5QBhgwgyJmRMrg4ypTAJG4ljx/U4Cp4Yh5XnVsZMOuwccIJDpxhtbjpPr+OZ7ACg==
X-Received: by 2002:a17:903:1ca:b0:1e4:733c:eac8 with SMTP id e10-20020a17090301ca00b001e4733ceac8mr6204202plh.8.1713343915001;
        Wed, 17 Apr 2024 01:51:55 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:51:54 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 1/7] net: introduce rstreason to detect why the RST is sent
Date: Wed, 17 Apr 2024 16:51:37 +0800
Message-Id: <20240417085143.69578-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new standalone file for the easy future extension to support
both active reset and passive reset in the TCP/DCCP/MPTCP protocols.

This patch only does the preparations for reset reason mechanism,
nothing else changes.

The reset reasons are divided into three parts:
1) reuse drop reasons for passive reset in TCP
2) reuse MP_TCPRST option for MPTCP
3) our own reasons

I will implement the basic codes of active/passive reset reason in
those three protocols, which is not complete for this moment. But
it provides a new chance to let other people add more reasons into
it:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 include/net/rstreason.h

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
new file mode 100644
index 000000000000..0c3fa55fa62f
--- /dev/null
+++ b/include/net/rstreason.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_RSTREASON_H
+#define _LINUX_RSTREASON_H
+#include <net/dropreason-core.h>
+
+#define DEFINE_RST_REASON(FN, FNe)	\
+	FN(MPTCP_RST_EUNSPEC)		\
+	FN(MPTCP_RST_EMPTCP)		\
+	FN(MPTCP_RST_ERESOURCE)		\
+	FN(MPTCP_RST_EPROHIBIT)		\
+	FN(MPTCP_RST_EWQ2BIG)		\
+	FN(MPTCP_RST_EBADPERF)		\
+	FN(MPTCP_RST_EMIDDLEBOX)	\
+	FN(NOT_SPECIFIED)		\
+	FNe(MAX)
+
+#define RST_REASON_START (SKB_DROP_REASON_MAX + 1)
+
+/* There are three parts in order:
+ * 1) 0 - SKB_DROP_REASON_MAX: rely on drop reasons for passive reset in TCP
+ * 2) SKB_DROP_REASON_MAX + 1 - MPTCP_RST_EMIDDLEBOX: for MPTCP use
+ * 3) MPTCP_RST_EMIDDLEBOX - SK_RST_REASON_MAX: independent reset reason
+ */
+enum sk_rst_reason {
+	/* Leave this 'blank' part (0-SKB_DROP_REASON_MAX) for the reuse
+	 * of skb drop reason because rst reason relies on what drop reason
+	 * indicates exactly why it could happen.
+	 */
+
+	/* Copy from include/uapi/linux/mptcp.h.
+	 * These reset fields will not be changed since they adhere to
+	 * RFC 8684. So do not touch them. I'm going to list each definition
+	 * of them respectively.
+	 */
+	/* Unspecified error.
+	 * This is the default error; it implies that the subflow is no
+	 * longer available. The presence of this option shows that the
+	 * RST was generated by an MPTCP-aware device.
+	 */
+	SK_RST_REASON_MPTCP_RST_EUNSPEC = RST_REASON_START,
+	/* MPTCP-specific error.
+	 * An error has been detected in the processing of MPTCP options.
+	 * This is the usual reason code to return in the cases where a RST
+	 * is being sent to close a subflow because of an invalid response.
+	 */
+	SK_RST_REASON_MPTCP_RST_EMPTCP,
+	/* Lack of resources.
+	 * This code indicates that the sending host does not have enough
+	 * resources to support the terminated subflow.
+	 */
+	SK_RST_REASON_MPTCP_RST_ERESOURCE,
+	/* Administratively prohibited.
+	 * This code indicates that the requested subflow is prohibited by
+	 * the policies of the sending host.
+	 */
+	SK_RST_REASON_MPTCP_RST_EPROHIBIT,
+	/* Too much outstanding data.
+	 * This code indicates that there is an excessive amount of data
+	 * that needs to be transmitted over the terminated subflow while
+	 * having already been acknowledged over one or more other subflows.
+	 * This may occur if a path has been unavailable for a short period
+	 * and it is more efficient to reset and start again than it is to
+	 * retransmit the queued data.
+	 */
+	SK_RST_REASON_MPTCP_RST_EWQ2BIG,
+	/* Unacceptable performance.
+	 * This code indicates that the performance of this subflow was
+	 * too low compared to the other subflows of this Multipath TCP
+	 * connection.
+	 */
+	SK_RST_REASON_MPTCP_RST_EBADPERF,
+	/* Middlebox interference.
+	 * Middlebox interference has been detected over this subflow,
+	 * making MPTCP signaling invalid. For example, this may be sent
+	 * if the checksum does not validate.
+	 */
+	SK_RST_REASON_MPTCP_RST_EMIDDLEBOX,
+
+	/* For the real standalone socket reset reason, we start from here */
+	SK_RST_REASON_NOT_SPECIFIED,
+
+	/* Maximum of socket reset reasons.
+	 * It shouldn't be used as a real 'reason'.
+	 */
+	SK_RST_REASON_MAX,
+};
+
+static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
+{
+	return reason += RST_REASON_START;
+}
+#endif
-- 
2.37.3


