Return-Path: <netdev+bounces-89913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC468AC2E0
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F52B20ADD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37995C99;
	Mon, 22 Apr 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ient4hEV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EECA40;
	Mon, 22 Apr 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754885; cv=none; b=FEnLuTP/MYflyeld5z5lI+jYtXubZPS4GKxIHeObouQAvMFeci+NWdCB1NZXPvAM/rmcUyYqAOEp0ARJ9urL8HzZa3WnM/yLRTeroDBMtja8VijSz40C2neU3jPGay5GSpTMB25XujLvg9PUR+IZgsHQWvTBlXKsLUl7z6Q4rHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754885; c=relaxed/simple;
	bh=A0+lVjcnZtXBQTlCyTGaoCOQxWNlvze1Lo/Gsj96H6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifDx3RiHdM77GXMG4SZJGoXwjyoh/a+wzEaNmPSiP6GY3SInQY6vSfFiQe2YDv48izvov4BO2LbajJ33IXm+HwwBEOJPpM50s9/OOVdFxuz7Puq6rlEgwJo0U9cW16/8bXH+IgNn66ozpOhJNolTuXIz5dKE9m3EP2uJG2MrZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ient4hEV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3c9300c65so33158975ad.0;
        Sun, 21 Apr 2024 20:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754882; x=1714359682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzAkyxG9AVwGz60CC3f/7tiHEIrcRZuy+oTme1mlZJQ=;
        b=Ient4hEVyVYnBvdkeCcNTm03/Sm/2SuWHCU6/dvdRQJzfygBho5I/a7u6pWalcz/Bx
         0R5qH+UDawJA+iI8831V4JJjG6dWEvoE4ZQIqguem08cI7R2axhZWUvl5FOOqzp9VdHj
         b3vPpIWzNGjGdbpbInRmw72MFWHls+zTBT+GkkCCCkzlO6avb5cwWIVVU0GUUMLAdB3w
         z0qVbdUKNoYbz8b+QVLDIPNtWwzugl+LX61OfMKATI87AiPKTo2KLv3ZuVOfTRCL63Q+
         x/kX0EZa15ptveyv4EvozyO7Ay25/YSslWZXuRd/Za9JEh9ju6AJXGHIzC8A6LglHYsY
         A/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754882; x=1714359682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzAkyxG9AVwGz60CC3f/7tiHEIrcRZuy+oTme1mlZJQ=;
        b=jcKnxVf1GzOWJnGjH2H3FqyNkSM3hn2zdFzHAg9qCB3KIlW45CB6Id7jtmDluIRDgd
         FSZSIWq9NdoDDKqDs8Qv83OGZA67Lq5stq8AONdQ2TpRrjGF6xy5tCy6lMjeJHfuTKj6
         WUmYYnoOt6mNIdBl0Llr1h5KUNr65szsLHLM7xFG8jV1oYieUsH18it5+f/Jo6H+qWoA
         49cphu4K1wXbJRq/VCLBUCto+Au1fPQqK8Ha82No9qtPC4GK1j1sYCXxnH9HZ+G3Fx1j
         ZVcARCnvHMpNs58QAr/Wyoh9VvoGBmf6OLvVxOGvccr8qnclUWiwDa5K6j1qK6Z7NcTN
         dAwg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Jq0PM7gjt6X3Rx43zV5Dl0JP941lrlfLJciMCKx6zEO5FmG57/FAIdMHvqnAe3EXohV7/XJYwGBE333XvyQCYxaXb+DJYnoyQapqvoZrtL5reocMzLsAExWunFnfs20pRyIG9e2+Aywd
X-Gm-Message-State: AOJu0YxMjsXn2ZYNkj4p1n8vTVF7FLaDB/7JxUrMDTSmUQlsKHW4ZG4U
	2vzD8KQbLDqnl8xA45IvshZ/e2qgp/eqEdyh61bWoDE4ffj9NTPX
X-Google-Smtp-Source: AGHT+IHmDBUqF0fWd75hmvRosTsDXdT4f9yAvAN8nap/0Aig4K+7NfEkCyBzHk5N4R2B+lzvDXMmrg==
X-Received: by 2002:a17:902:b486:b0:1e2:718d:f290 with SMTP id y6-20020a170902b48600b001e2718df290mr8552958plr.67.1713754882446;
        Sun, 21 Apr 2024 20:01:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:21 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/7] net: introduce rstreason to detect why the RST is sent
Date: Mon, 22 Apr 2024 11:01:03 +0800
Message-Id: <20240422030109.12891-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
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
1) reuse MP_TCPRST option for MPTCP
2) reuse drop reasons for passive reset in TCP
3) our own reasons which are not relying on other reasons at all

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
---
 include/net/rstreason.h | 144 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 include/net/rstreason.h

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
new file mode 100644
index 000000000000..c57bc5413c17
--- /dev/null
+++ b/include/net/rstreason.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_RSTREASON_H
+#define _LINUX_RSTREASON_H
+#include <net/dropreason-core.h>
+#include <uapi/linux/mptcp.h>
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
+	FN(NO_SOCKET)			\
+	FNe(MAX)
+
+/**
+ * There are three parts in order:
+ * 1) reset reason in MPTCP: only for MPTCP use
+ * 2) skb drop reason: relying on drop reasons for such as passive reset
+ * 3) independent reset reason: such as active reset reasons
+ */
+enum sk_rst_reason {
+	/**
+	 * Copy from include/uapi/linux/mptcp.h.
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
+	/**
+	 * Refer to include/net/dropreason-core.h
+	 * Rely on skb drop reason because it indicates exactly why RST
+	 * could happen.
+	 */
+	/** @SK_RST_REASON_NOT_SPECIFIED: reset reason is not specified */
+	SK_RST_REASON_NOT_SPECIFIED,
+	/** @SK_RST_REASON_NO_SOCKET: no valid socket that can be used */
+	SK_RST_REASON_NO_SOCKET,
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
+
+/* Convert reset reasons in MPTCP to our own enum type */
+static inline enum sk_rst_reason convert_mptcpreason(u32 reason)
+{
+	switch (reason) {
+	case MPTCP_RST_EUNSPEC:
+		return SK_RST_REASON_MPTCP_RST_EUNSPEC;
+	case MPTCP_RST_EMPTCP:
+		return SK_RST_REASON_MPTCP_RST_EMPTCP;
+	case MPTCP_RST_ERESOURCE:
+		return SK_RST_REASON_MPTCP_RST_ERESOURCE;
+	case MPTCP_RST_EPROHIBIT:
+		return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
+	case MPTCP_RST_EWQ2BIG:
+		return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
+	case MPTCP_RST_EBADPERF:
+		return SK_RST_REASON_MPTCP_RST_EBADPERF;
+	case MPTCP_RST_EMIDDLEBOX:
+		return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
+	default:
+		/**
+		 * It should not happen, or else errors may occur
+		 * in MPTCP layer
+		 */
+		return SK_RST_REASON_ERROR;
+	}
+}
+
+/* Convert reset reasons in MPTCP to our own enum type */
+static inline enum sk_rst_reason convert_dropreason(enum skb_drop_reason reason)
+{
+	switch (reason) {
+	case SKB_DROP_REASON_NOT_SPECIFIED:
+		return SK_RST_REASON_NOT_SPECIFIED;
+	case SKB_DROP_REASON_NO_SOCKET:
+		return SK_RST_REASON_NO_SOCKET;
+	default:
+		/* If we don't have our own corresponding reason */
+		return SK_RST_REASON_NOT_SPECIFIED;
+	}
+}
+#endif
-- 
2.37.3


