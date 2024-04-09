Return-Path: <netdev+bounces-86056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8089D658
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEED01C20E8E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4348120D;
	Tue,  9 Apr 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtARYJJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC27EEF6;
	Tue,  9 Apr 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657414; cv=none; b=EaOvzJE+baXHYnYwsgpJ4dSokhfBc3rSloUS6w835KbchLL54ee16UHa6RtRkh2I1WDs8lO26DgguCiSaZLGAah18enzjlap7cv+XH51GP97Wzxnpvs1qR4lUTe+SdoP0+tMgdT5BPvre3HvCuD9mTaftA3jC2VzrtBCDtWpBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657414; c=relaxed/simple;
	bh=mlfxcIg4+Phml4qIdFRVfQLahA9cOJbdd5MjdoBa8Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIgni6xQIX4LJECLurXeTV49nEDmftGWBUVlmpwrCvPISM3UO9jKVAqbvv4DKUlxa5DAQmevLxDvWsUoE0NPHBOW6+mEibZHHyxUHzxoUG5rftVNGmyAmqENjjyNyUJw7wNVEfegqC/MYIBuYSPI9Hmwuggynl5UObBspO7OcVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtARYJJ3; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa20adda1dso2032679eaf.1;
        Tue, 09 Apr 2024 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657412; x=1713262212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=MtARYJJ3breDyv7AUxOTsK69nQXJmSxHvJBLbXcvvn1xCfI7JTAIqnu5FHDlpHMyp6
         93/f72U0FRMXvf1LLLgpxW6lWGZvFI1k4efjmY7FV41HTMQd1nfeJ3vltZCqZYK6nVCq
         itQjRnyv8HuDsAp5al+W3dNDv4QdBhgJaopigYt/c9oxoQNnfwXFGg/0OtJLLBPyPrJP
         0j/kg4gG8mHBhnvkxMrPIeLg2SsChq4lmWu7GyM28Tly5vHwblsNnwpS7gpOo1hqR8VW
         sy3MVUotQL0hfc5hzWWaMnSKFc6BIvFOJIOOMv2DzAFJ6tJxxNC+eX8Z+gQ+tpTG5zf3
         4u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657412; x=1713262212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS2aNr/EX+hXSh4C6UyaT13e9lWbB8QJ2EHpJCpiGRg=;
        b=NssLg4KPdxQpuiAHyugykTYPe3HoqPUJgurqDApghgIQYrV8H/tRRQNW/Ff5Zvgf9k
         /j/g6eqAv00KCPbeCJoPpsnw6v/WdA7FoZ25aZ5pFXFFx/H6ME5mYPtVDh5/RgATPDbC
         lkLZzPJtCAfWuEQGH6clwMPnVI+EpCATdcoqRBN4RoidEkN1ymuBS5kywmB2o0OJpQw3
         TptsGpNMlCKvDp3FGn89ZOJDRrcGGLGNF3tPr7QpnIOHK+SwRulBpRjfh9I6G2ga4Aht
         QqfNhDH7h/kxFWDe1HHU7vxr9jhGFUD4sx3FHe2WBHPK+IrrHd3nCM4gaFB10k7Y9naH
         geRg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ19iUoaUodPTli+9sOyr2xU67ceNsv02uThpN6eyVdtZK02nVBHSGghyadsnG50Ua+cveivaJ4F5JhTiGbiJ9dzfWiFmVokZ7HugAeLH62Mn2b4fg/JRH2J3SiV3SzdnUNFJQMx1DrQRw
X-Gm-Message-State: AOJu0YyVve/fyJ/n3AJ6MFBPCJycHq8No+hyJI9x+8xSy5xHdp7KZUhn
	UwSFSgM4Adv7xHEH35ouJ5AWBZISBwB7Z3m8Fe8d07XY5bgihiEK
X-Google-Smtp-Source: AGHT+IGAfyUuL5DqUrOODFzjKEsh3f6feDS348foF0B094yjqIPM8WrzuwwtI8F7juk8jb+VSRXq9Q==
X-Received: by 2002:a05:6358:c92:b0:186:1193:8ccd with SMTP id o18-20020a0563580c9200b0018611938ccdmr9710915rwj.23.1712657412155;
        Tue, 09 Apr 2024 03:10:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/6] net: introduce rstreason to detect why the RST is sent
Date: Tue,  9 Apr 2024 18:09:29 +0800
Message-Id: <20240409100934.37725-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240409100934.37725-1-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
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


