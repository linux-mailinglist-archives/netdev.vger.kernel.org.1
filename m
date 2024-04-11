Return-Path: <netdev+bounces-86994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED68A13B5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7943FB212B4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172B14A096;
	Thu, 11 Apr 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W92YsDj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767614A60C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836618; cv=none; b=CyxqjMgzNPPxKb2FzPI6wH4DBAXn9rwrB0+nMpJpJmvWNtCurESjkH0QqZxvVLC5pWyRJCgEP9vJjJT1D+ur2ydNffcb8rT3XTlIsI3vNwE+F4pgpJ6+T9xgoMr7RvrT3H6/VKJQmIIyEtrows0wFkgHBC7PEc9iobYCzfd/YE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836618; c=relaxed/simple;
	bh=QxQkbOA3Br0WuU9xk+KkTMUYboegP7NLcOJy3FqX37Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wcf47shTKzglCRJpXiRkdEyPk5gTeKTyIxZ7oVC8mCd1H5ziOfHipZAs1o/Y4EPtbPz+JK/SWXZg6vPIxhRczv+8mRylkgjPHcnXjt5d3dzW4z2aVDmsMwCkjGpy0V2K03tZkupjoEoRVmtqgavtPLoxVO4IDO0Eqw8fdyglutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W92YsDj6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e51398cc4eso12291415ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836616; x=1713441416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wNq7bsOsSHUvUgQxtlzRzCIsQGI1JY3zE4kdWaFaxI=;
        b=W92YsDj6ga24mpEaMmf8rj/5+HG3nRMS8SxIrJwOvgKo3Lb79tZJVEHzoWNArzrQg2
         iaVbe7cCTUMIXBfeOx61Z4Msgd0DOblgPeIT/6tGOj6pQ6Nwpr+du8QlPMefh3UqXb++
         UICzBynzjbFZ05+pYjamSiKxinx1pSzZI+m40rzsiDBKJXDXMvd9ux5m8Lx6E7IccKQy
         syKY/r7MckLcMZfBLaqS4skK7m4OgaVD8ZT3CWY22YtjlaLmbFVmfepgEgS4QeuyUHiv
         CdNk+7LEdSQKq9L0JlrQXSCUy1VvfKM1IGFYXeoCXOo8z5UOurrBrKj6AXvFEPvZWi/g
         qfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836616; x=1713441416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wNq7bsOsSHUvUgQxtlzRzCIsQGI1JY3zE4kdWaFaxI=;
        b=e0QLXVJTtG0tcmf9vV3jTZBpzncXkSFWLh9fdJsJwEokn4j2Uqb0SFfq1Umlv9BULO
         /jiE9ji+sQuprLww7uH6Dt4bThYwGxhlI/PLcxtkms8oWqSeRiygmxToanN4BKah67ZV
         g9DSIRndnjtDIjlblutnTrAHPiDBYExqxodIzVbjM7g3QXa2/g92qpKSFxnStDSQkXcC
         kwHaM+4w0QGuyg1pBTfhs8VfX74d2HsSqYIck4nKUm70B24dLJO78eUd7d5fQoxtFLcv
         JpBNaiX8lQiW3YaaBMT2BnSrSalnZeHZAIm/UtZyoCHfBI5fAkLJio4A9MsFCSx3imwc
         87RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6cwy+OIfASCETG/qAhd8ugrRKPWZFf6UKF5BGzDiP4Ly8573f0U0U6sfUmSM3ZIWaYQ3rT0B+ONMY1kcsuJeVhZo54You
X-Gm-Message-State: AOJu0YzYum+BZfLN+syu58WzlOj0x+YMxBmMwTx5bvxfCzcON6tgc/w+
	QESsF3rp1qxT/c7XcKuthXgHfAE0HxgRVVxKuC7GZhtnPoeC3bR8
X-Google-Smtp-Source: AGHT+IGyXv62vTZgAWeVT5K1y+w5IROp+DapcU3nqzzTDYNrLxfKRPDd+wwWLWwBtlc+nds4IBalWg==
X-Received: by 2002:a17:902:f542:b0:1e2:7717:d34e with SMTP id h2-20020a170902f54200b001e27717d34emr6303712plf.58.1712836616449;
        Thu, 11 Apr 2024 04:56:56 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:56:55 -0700 (PDT)
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
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 1/6] net: introduce rstreason to detect why the RST is sent
Date: Thu, 11 Apr 2024 19:56:25 +0800
Message-Id: <20240411115630.38420-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240411115630.38420-1-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
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
index 000000000000..38c39d32a961
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
+static inline enum sk_rst_reason convert_mptcp_reason(int reason)
+{
+	return reason += RST_REASON_START;
+}
+#endif
-- 
2.37.3


