Return-Path: <netdev+bounces-84291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C287F896668
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA531F219E3
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8095BAC3;
	Wed,  3 Apr 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyE0BsR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F285B68F;
	Wed,  3 Apr 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129526; cv=none; b=Td7u0yqmPkwaYlCcwac0p//kJCperAUFRuhU+fDadG7IprwF3y6+77H7ZG3NHVCLekpbO2haykaJTAaGqQbUKgxzSy85kxg87DtmHLsX7VaL30AQ6f9G3tDYTcnNb6i8B6r3G/5FDjTmX46X5H9DsQtsXGS5wUQscfx0qecs1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129526; c=relaxed/simple;
	bh=mlfxcIg4+Phml4qIdFRVfQLahA9cOJbdd5MjdoBa8Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5EFOn4+vGUY60JgNUiVgZ/anBzzoSSLuJf7siXwWnJ8CqxHHkhRN04rCHwkORS/DCFNfKHazFNHQkvUjek9eEM5j1fApJoPjaZDaZ4qum2mhkO17tuloodwpZJ8hqvqR0Yb/4e9EatHzZhnomEeHSAHoCDg4Mu8kfrpi4zRyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyE0BsR9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0f3052145so56948145ad.2;
        Wed, 03 Apr 2024 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129524; x=1712734324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=kyE0BsR9J5n058Cs757614RP3Wt+SZuyO+LiW7SIUo8MeETmjp87QVP4rP05dM+qNe
         gqIvYVifajzVb2B5Uoju6vxjBm7mXKYFxa9dW1vjVS53F7w8/DqiDkTAivbPnjnMdY6M
         UfTR4O4J63yr58gw3sqmlVSlAFWi38DO1wZxaVlpXBMl+ddE5ko3hR+D9yymngkmg9wB
         yZiXvl2VQ9cP9vXw/Uo70xkKEoYNRuJfC7bOBJdY7e57VABNmMgyT3fu5BJgYjr9dU4c
         D8I3kjyM+xreogXmc6s51X/4poP+DW0ygsY6U9tEXl0kRNtQWs4nXq3/sP73CK0/i5Pn
         KvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129524; x=1712734324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=u2uBBaijrjGMz/IYGYI1WIP2mLDUmy5f6Ex37t+FWsxSe4IcH9hfHB2POm6We5KOpY
         NOwiQTVPa8V4a5vh4nOFQINTtVguo3UDGPaU5mG59YcQikYaGimACxwvzex9XGr9/8XC
         hw3ctmELlO3DMabq0Vh8L4loK83DIWQaw0Icx8T+/zpU1VrUzX6RRfppFzF2eJVwpsx7
         Q+gck0VD4vuZTsZds5dEUMD1d8Tepq9JEBy6cxGbLtIcrgVAjZ1X3DYs54yrrjpsKiMX
         a5JRV1KA5GNqXqbczduWs50N7m6INuLK/udDvqh7yJKJT/t2LvZwfH+pH527ZXnE9VSU
         kh/w==
X-Forwarded-Encrypted: i=1; AJvYcCVBrZOE8ss9cAaJMdHuUfLigItHQoDj0WtYut1q2nIWC6ktXhiih9Wt3Sk1M9JddIgcWMmQy9HTTChPmASstW7ykIe0jZy1gHxlrgQC7jbrUlI/Fhhyav4f7qeKPmbujb/d0Aakh6STCsBk
X-Gm-Message-State: AOJu0YyVDcEIWroBuiIej2bVzzHsK/8OjBeKUzoHl9i93D5aLuvXaq/z
	eF9607ETlwj+opEIJ6Mj63FG63pX9Cp/upWiRrbN8iHxZSGTyN0t
X-Google-Smtp-Source: AGHT+IEq39ZufbwhA+BmTcV9hmUNMfaHPyNs+0nOyZkKR0v/03C01OveuPqj5H80nkzjEzAIaaIsYw==
X-Received: by 2002:a17:902:e741:b0:1e0:b3a8:7db4 with SMTP id p1-20020a170902e74100b001e0b3a87db4mr2397777plf.45.1712129524467;
        Wed, 03 Apr 2024 00:32:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:32:03 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/6] net: introduce rstreason to detect why the RST is sent
Date: Wed,  3 Apr 2024 15:31:39 +0800
Message-Id: <20240403073144.35036-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
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
index 000000000000..24d098a78a60
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
+static inline int convert_mptcp_reason(int reason)
+{
+	return reason += RST_REASON_START;
+}
+#endif
-- 
2.37.3


