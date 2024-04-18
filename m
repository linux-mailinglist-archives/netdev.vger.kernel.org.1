Return-Path: <netdev+bounces-89214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A665F8A9B57
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342931F22EBD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593AEECF;
	Thu, 18 Apr 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSsyg0XT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894915FD0D;
	Thu, 18 Apr 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447185; cv=none; b=ighBM0Irdy0oAOAp9z9XOPomdGTMtqB6EPoZ7yfR7eFw7c2fGOmQvHGJL3jBC+VEe4Zmh8nWX3SrEHaLwXg6mjz2mbjOj2eYcQ5ejyPorgQ19meqfBhrNkjQEMI+RXeO5E2/eAGomAgHKeQ6ry5CxCI+eLSwOlbZWNfRaxU5VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447185; c=relaxed/simple;
	bh=RJnbFc5JHAO9cPZZJOzJbZBugWtXN/ZrYKzKfwfgFG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLzbbv/SanAVkW1d7hwVKASM5qSK9vcH4sGc5VbvGbCu9vdbC5Wgjwq4Wh8s5OgeQ2zsM+5IdRXafsIEC5EU0jLDEuJsPBFawVW6f6bYW0iMVbjZJPHhAqTwxjnTDvc1DFhC7POYxLRVTLec+lVo9xDDZQ7y0Lfde60FBu8p8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSsyg0XT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e4f341330fso7334515ad.0;
        Thu, 18 Apr 2024 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447182; x=1714051982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=mSsyg0XTh2n2XMtgdWVocvPoowU+HrYfJEZMcYtq7Jr0PbKdyidReY4BDr001z5W/o
         VVZj3enEn9CRdmozdejBEJrhFnDWqqTC3NdksRWblCKKDm1YU0dlI8DzJJHtIg1ajS11
         w/AO1rZ0CbDfnNP3BisHSR+e1YQTMeHeSW/iZgQH0B8E+d4/WO2zb2Kj/k6yJZktMiJ3
         Sz7bOH24znU2+IoM5PHE4mP+D04X7STM0Jjq3cjxZ1GkEFm+8nEzqyRi3ROT3tMD3Olv
         iz1vu/3il1I8DwOu7Ugylv0090SaWV3EWd4UiVBcvhMGLwu0isKQUZjS1+owRyms0o36
         CLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447182; x=1714051982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UH4meUAVHMlL8PvFN7UeOC3D/JlMgEbNXoAK969ZI8=;
        b=IR4zciYHebvQXWtNH4/1Hvz3hHbITqmLKWPBHqQsDDKVCuGiSvdUPDCpnbJA+5+1gO
         PisMTds6UxjPKk47IidBb2pjHNexDmATsqMKHrcmBGYfy+p9WugTSRbVp6dCa1T7Ia6x
         y9tD3DGMGayn+juWmh5T/xkmGYoJG2IVpJ75mS3GLFS8CwTIiso2l9sVM3G3Xq1EzFUi
         NafNn96GijjYcWOG4rVwbiTjw/5NpwTpZbjysfnw2OWsmP8EvuhNGdhB+j98TdnkQ6+f
         o7KCld5M6wKgf7hFEgid5QBPxGnaLC1SVOnTdssiU0Q/e6o+aLrWMvqcApmTTvdIld9h
         eAeg==
X-Forwarded-Encrypted: i=1; AJvYcCV7P9afq88Nk7nM2BQgaQiitAUOzOqiPg9pJuhAE4rRIkak+xa+DRWyT1ehVl2Vr9v30mT5JvYqq/oJTe476XmvuKdSWdNdXKAuJE0MPS0AhEcO7sBnOkv9Q7ifXMaOnkLfoAXREPGwyOJc
X-Gm-Message-State: AOJu0YzJcMJtaSSB1442cRkkGy4mGd6J/jKT2XcNZF1g3nR1Mk5ZrryV
	y07NpIHU4T2YNqo4fzlGchpNoIzLo7Hj9d1OnsGtZGEVbOQJ33qa
X-Google-Smtp-Source: AGHT+IG31XCqYyXm7yKhKzmNVht96b9dF5lC1StriyAdJI4/TfU5MoNFCeIav8+eawaN49I0SCJ3kw==
X-Received: by 2002:a17:90b:124e:b0:2ab:de86:d667 with SMTP id gx14-20020a17090b124e00b002abde86d667mr1547185pjb.48.1713447182115;
        Thu, 18 Apr 2024 06:33:02 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:33:01 -0700 (PDT)
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
Date: Thu, 18 Apr 2024 21:32:42 +0800
Message-Id: <20240418133248.56378-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418133248.56378-1-kerneljasonxing@gmail.com>
References: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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


