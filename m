Return-Path: <netdev+bounces-91176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BCA8B1947
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A41F230C6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F431CD2B;
	Thu, 25 Apr 2024 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbpQLmBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95B1B5A4;
	Thu, 25 Apr 2024 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014836; cv=none; b=G/4yCdlnxWXrJhmq8O9QEN/M0ado/pixXl8Fb2ld9YHDtq1Nm7X7c4QbbrDdTS0mdtsg+uBKgFkuVIFNDRvzcFOIP2Lf23Bq0xHZkb4ABW2/6WXPjKnc5nVrEbaw+oXf81oEoNbIoyli1I8swbB04q0vbu1p7a/2vI3bDIHtQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014836; c=relaxed/simple;
	bh=+LesTt3Z2LMFg+SpRs/f+1BWhpKFNiGytAfxtWegupk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OuHiko0MzeJ1TzwgjymVBefLxjDyA5aKRbIpqi6/EpM0BcGiVYJJOAvf8YNu3YuyYpAiQtauSHulzja7KPkAIZCZelCTbZp5O332jajuH8Yu7WrMiU82vwTREApwVtvjz9WF7vjfNAFdAkGS+AVQ0xI5z9wVjjWmTjuUy9pmuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbpQLmBx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so527563b3a.0;
        Wed, 24 Apr 2024 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014834; x=1714619634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYes8UrjLtTge23x1oPsqCt8zdeGWq3g5+fzgOsk/os=;
        b=fbpQLmBxgDvAMC5akTqEiZ8gL6M6EnJE8U4cFVslJVfFMiGJg33l72xLUbtsHcBXtl
         /xwhVyLYj+r4VacWKLXa4PltsSd4nduO632CS6rA0USpYUxcQe4XWaUgiSiugRzv4riV
         kd+UyO1Gl8L6Clsxji9N9QErY/78DFppGuxMQ0gNg2fxKY2iFXU2tMMy4CaNRXgp5OUe
         bWPXk3MSybcLn+9gyLpHfosmRQk+TIeVORNSFCX3qq3ygrKCZtNTgaZYJogAOjM5n/D6
         CIjsj29MeWorAk3FaV/P1ZMApd1DH6i7sM8OHYf3c17qZenNKRo1XkmEkQN+CAdB0CB0
         Dd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014834; x=1714619634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYes8UrjLtTge23x1oPsqCt8zdeGWq3g5+fzgOsk/os=;
        b=Im2p8mYviViaI85tGD+xvvYt3v2akgCYCFin5K0Hc5bO4b5pdKjUzkCyQQq0gfOLjj
         4nM9pe13LHb6N5Ev27GDxIEhOAKkd3cHJ53rMXNpRGZfna5s+ezGDWSl/jt05AladBkl
         iNcbni1FDddGg3QGuB/2WzEoTEh+07K95QWj2yyPFWCwNjYgsQciuVm44n5wkX+rOC5t
         DgdSmv0CDv/Lf3YuRUVRyBfPPEcgG1R5zouBw8NwtSXo07RJzqsvTyacrKWpvMG5k+Qd
         8W2Iw3PeI6DAaowNc92VcxUOF+8VNAIiSmCPylNwvLHxxMAyJWx49SV29s2o8k4dq5zB
         uFKg==
X-Forwarded-Encrypted: i=1; AJvYcCX2mR2Tw+4htguCejF1PdhRI0uwXpLzxWbA3oXsOOO+UP+FKA6fLI77qHZNWlAe6AxvlrB2PceJG8I34E5MVDb84+VNbX6TRUwsTd44vmE2q9bIghK2eUKtKSBKl67vuoJq3R5qTcjuo0OJ
X-Gm-Message-State: AOJu0YztWEj4So4IaNAwBC+zU9KpTOITkDTohJgQslfokoXYg1vrcJnR
	HWVQH6ewAs4jl1pg+Ez49dPGPr57cWiOkU8UQlO1DPL64ADyHn38KJXsMDyN
X-Google-Smtp-Source: AGHT+IEWvJViSoVS0wr9rr1/aeg8rz7tLGFqWHjwyTo05J3Py8YBVZ0LEjHJtmkaauTpWtMGe+8o0g==
X-Received: by 2002:a05:6a21:788c:b0:1a7:39a8:6ca4 with SMTP id bf12-20020a056a21788c00b001a739a86ca4mr5096219pzc.29.1714014833849;
        Wed, 24 Apr 2024 20:13:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:13:53 -0700 (PDT)
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
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 1/7] net: introduce rstreason to detect why the RST is sent
Date: Thu, 25 Apr 2024 11:13:34 +0800
Message-Id: <20240425031340.46946-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
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
2) our own independent reasons which aren't relying on other reasons at all
3) reuse MP_TCPRST option for MPTCP

The benefits of a standalone reset reason are listed here:
1) it can cover more than one case, such as reset reasons in MPTCP,
active reset reasons.
2) people can easily/fastly understand and maintain this mechanism.
3) we get unified format of output with prefix stripped.
4) more new reset reasons are on the way
...

I will implement the basic codes of active/passive reset reason in
those three protocols, which are not complete for this moment. For
passive reset part in TCP, I only introduce the NO_SOCKET common case
which could be set as an example.

After this series applied, it will have the ability to open a new
gate to let other people contribute more reasons into it :)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/rstreason.h | 106 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 include/net/rstreason.h

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
new file mode 100644
index 000000000000..bc53b5a24505
--- /dev/null
+++ b/include/net/rstreason.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_RSTREASON_H
+#define _LINUX_RSTREASON_H
+#include <net/dropreason-core.h>
+#include <uapi/linux/mptcp.h>
+
+#define DEFINE_RST_REASON(FN, FNe)	\
+	FN(NOT_SPECIFIED)		\
+	FN(NO_SOCKET)			\
+	FN(MPTCP_RST_EUNSPEC)		\
+	FN(MPTCP_RST_EMPTCP)		\
+	FN(MPTCP_RST_ERESOURCE)		\
+	FN(MPTCP_RST_EPROHIBIT)		\
+	FN(MPTCP_RST_EWQ2BIG)		\
+	FN(MPTCP_RST_EBADPERF)		\
+	FN(MPTCP_RST_EMIDDLEBOX)	\
+	FN(ERROR)			\
+	FNe(MAX)
+
+/**
+ * enum sk_rst_reason - the reasons of socket reset
+ *
+ * The reasons of sk reset, which are used in DCCP/TCP/MPTCP protocols.
+ *
+ * There are three parts in order:
+ * 1) skb drop reasons: relying on drop reasons for such as passive reset
+ * 2) independent reset reasons: such as active reset reasons
+ * 3) reset reasons in MPTCP: only for MPTCP use
+ */
+enum sk_rst_reason {
+	/* Refer to include/net/dropreason-core.h
+	 * Rely on skb drop reasons because it indicates exactly why RST
+	 * could happen.
+	 */
+	/** @SK_RST_REASON_NOT_SPECIFIED: reset reason is not specified */
+	SK_RST_REASON_NOT_SPECIFIED,
+	/** @SK_RST_REASON_NO_SOCKET: no valid socket that can be used */
+	SK_RST_REASON_NO_SOCKET,
+
+	/* Copy from include/uapi/linux/mptcp.h.
+	 * These reset fields will not be changed since they adhere to
+	 * RFC 8684. So do not touch them. I'm going to list each definition
+	 * of them respectively.
+	 */
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_EUNSPEC: Unspecified error.
+	 * This is the default error; it implies that the subflow is no
+	 * longer available. The presence of this option shows that the
+	 * RST was generated by an MPTCP-aware device.
+	 */
+	SK_RST_REASON_MPTCP_RST_EUNSPEC,
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_EMPTCP: MPTCP-specific error.
+	 * An error has been detected in the processing of MPTCP options.
+	 * This is the usual reason code to return in the cases where a RST
+	 * is being sent to close a subflow because of an invalid response.
+	 */
+	SK_RST_REASON_MPTCP_RST_EMPTCP,
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_ERESOURCE: Lack of resources.
+	 * This code indicates that the sending host does not have enough
+	 * resources to support the terminated subflow.
+	 */
+	SK_RST_REASON_MPTCP_RST_ERESOURCE,
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_EPROHIBIT: Administratively prohibited.
+	 * This code indicates that the requested subflow is prohibited by
+	 * the policies of the sending host.
+	 */
+	SK_RST_REASON_MPTCP_RST_EPROHIBIT,
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_EWQ2BIG: Too much outstanding data.
+	 * This code indicates that there is an excessive amount of data
+	 * that needs to be transmitted over the terminated subflow while
+	 * having already been acknowledged over one or more other subflows.
+	 * This may occur if a path has been unavailable for a short period
+	 * and it is more efficient to reset and start again than it is to
+	 * retransmit the queued data.
+	 */
+	SK_RST_REASON_MPTCP_RST_EWQ2BIG,
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_EBADPERF: Unacceptable performance.
+	 * This code indicates that the performance of this subflow was
+	 * too low compared to the other subflows of this Multipath TCP
+	 * connection.
+	 */
+	SK_RST_REASON_MPTCP_RST_EBADPERF,
+	/**
+	 * @SK_RST_REASON_MPTCP_RST_EMIDDLEBOX: Middlebox interference.
+	 * Middlebox interference has been detected over this subflow,
+	 * making MPTCP signaling invalid. For example, this may be sent
+	 * if the checksum does not validate.
+	 */
+	SK_RST_REASON_MPTCP_RST_EMIDDLEBOX,
+
+	/** @SK_RST_REASON_ERROR: unexpected error happens */
+	SK_RST_REASON_ERROR,
+
+	/**
+	 * @SK_RST_REASON_MAX: Maximum of socket reset reasons.
+	 * It shouldn't be used as a real 'reason'.
+	 */
+	SK_RST_REASON_MAX,
+};
+#endif
-- 
2.37.3


