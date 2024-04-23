Return-Path: <netdev+bounces-90364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF9F8ADE22
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D6E1C21A25
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63747A48;
	Tue, 23 Apr 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF4ICvkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E634776F;
	Tue, 23 Apr 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856912; cv=none; b=q6C8OScDMPNCn7Fk7S9qYSSh0Gh6JDXjefTT0bEszxvn/FDqY70ekIJh4fRnUDUgq21vAKV/UQu7GFDZnAaAuvt0twx2qqpmb0IrQsdwWvCCImWYqWyBe9vCE1ebo+rUkLLIWzKsKvvS7S9e1DO/JKb1oyCGPlVrPa/Tg7uxzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856912; c=relaxed/simple;
	bh=iS9puIZWDL9mAV5XRbSd7nWKVTz3q2Q3PLosvS6Zu4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTabNrTCar1KGdItXTXr4rVwoQwk3H7YyXfeC5qxil/oMQ/2xtmPz1up0bmsMOnwEzWHxpAuziKFwzH5QbuSHBJ4nMYNe0CvsyFi3rkVYqY9STfAxss0827nlTtt71Kbgxw9UkEgdk8ATg+kKZsM5tvshDqKOGZEwb1Mulywh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF4ICvkJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e65a1370b7so50802785ad.3;
        Tue, 23 Apr 2024 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856910; x=1714461710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxUdYPbXk5f8/g8ffitrfrSpLMMkBSABqs7z5ecFUfs=;
        b=RF4ICvkJb07wDVqBAwL17GVPkvPM8swyTX61m8OHfMW1eI2mFvb/b7yTPHAcdkYiFs
         DVvtr43A3qbuIsUqeXCk6M38C2GL9ESz7k8pkavNwYVZXF8tFx+RRWlaA7Lo5MA1+X9k
         i7E0f4pxHw/FSr1afrFYVcbbVtRjGW9Bv9FiIytQ/Yw4TgbuB1/81ef/UDXAXXHl9TEM
         JmEzd9ZjPMLOR1FyC204YHGsRFH72B4zoJPjJlXc9lF3QyCJzi5l6KlTpSTFGstimfH4
         490NOIxzbgaM1HUBdVueJ6aJI2cet0CLDZ9SP/4uSN33dFfaMswphckgEoKZjE+zVbkH
         14Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856910; x=1714461710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxUdYPbXk5f8/g8ffitrfrSpLMMkBSABqs7z5ecFUfs=;
        b=srEErbUMPpt0aisWFhqQccqCojnj4Ms7cSUMvtaluyT0dT6mCUlYTaCFoexmgn4Uw7
         5O13vd5Th1vYLeXoXKMwEJ5QmTOkSDAhGwQoyXdZm3JIOP0QQEgvSpk1ZZhGXfgyCNNH
         yTBEuZuIEKf65Tb2b8lynLe4s6oBPdherMQlP3+ulH/IMJpic6ZGXAsPayoDE2NxsI0D
         WzeE7DO4Uho7GPh+BOpetunIfzjoco4Go1F1f2NcDYjuHRS7Fz/LlMSKgQCzc/IVbk+w
         RP5qMXztPGobHDPH6OcGS5tve2DqEo418LLeLbIls4Yn9LUKlGf1ldH83zEg0/8GgBwZ
         7Nog==
X-Forwarded-Encrypted: i=1; AJvYcCUmCd40KP6zLcmYcjkIoKt0ZzT0uyQQ86pLPaFFS1KkxzPm6NgeZrFhVLJChNyUkN+n70XFtjbe13h1KEK8c0FwgEFL4zmAZWwKt5wqfv5q4TO/xsm51YjrXYweyjHuBT51K2K+7pFq7PjF
X-Gm-Message-State: AOJu0YzQuroCrBWdzpbfRMqigASKiMl/X4fDvgBUgg4PuUhFBg3hPUmo
	Kt6z6PyV8uTY1Dg0ti6zDZys2EYWcL1pkIPaB1eFkZQCXkV0WKGL
X-Google-Smtp-Source: AGHT+IGbv0HgHbnG8i38n2BfmB2ww8XP3g+lbrGhBz3YVHnYEkYgfVl4RsYhP9j22nyq+qsoc5yfhA==
X-Received: by 2002:a17:902:6901:b0:1e2:b4ce:4f8a with SMTP id j1-20020a170902690100b001e2b4ce4f8amr14368631plk.53.1713856910046;
        Tue, 23 Apr 2024 00:21:50 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:21:49 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/7] net: introduce rstreason to detect why the RST is sent
Date: Tue, 23 Apr 2024 15:21:31 +0800
Message-Id: <20240423072137.65168-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240423072137.65168-1-kerneljasonxing@gmail.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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


