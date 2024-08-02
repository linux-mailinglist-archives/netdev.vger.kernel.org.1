Return-Path: <netdev+bounces-115294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C57945BEA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132D7B2157B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B591DD39D;
	Fri,  2 Aug 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMFg9I+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050C1DD38C
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594099; cv=none; b=uDDBJzZ3K4QtOOG3wA6u/tfeQMznClIXPbfs0OH0eFDDq3pXhBpFday7rUjVm7OdDmfDR2SW8fxIIzW/fssrUrgEI+IVREC1f6Iea5lP3ewLIb7E/rINtN00OEU84AVWpHIcKd3Hd4XxMup4gx1aBfS/4482zAkbHkDUx0P7JIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594099; c=relaxed/simple;
	bh=aLmR9AtcQnoMEso4BgolU96go//pa4IzcLIKCgZT8co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nwf5M1ruVtmV1UynkY+M1i4zRwbsTubOx13F3dbiH2TgWqiXmzXxZS5YdFB23lk/wmi0EwYrJ70ie19mTKoySrZS7tm7xxMdW0mYfrpLK0Ro8mCSCWsukczKcnlwMhYspf36nJNxlhbX5z83Y9Utd0BPtMw1Gi5vNlZtCMuyNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMFg9I+e; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70936061d0dso5266181a34.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594097; x=1723198897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwHm92BbLGHRx6QTtSopvfWeZrLAi9o2tWG1Id2MUAA=;
        b=kMFg9I+ePbovXvt3+Ectvr6Dbs4qCwJXCYELghGLZ1m/PJTlGkWhlZngueGdpoJaf9
         mSe/4zLxCtCRfu1wGJn9MYiI8u5MkkzLRCEvju8Ql0J8KdcQiOCOi4zZOFcBXp9tO/9r
         262ZECyen9a0zAmK+Yq1mr6o0eyWo5EVoEuqrm1Rt04SmlrbzLV4/X1AkjLnAdj0oPh7
         vQphQe4u3ewJf24urwXkGB8X9X9lYWM9Cr9604rGxx58TidHqWD+q9ynKCGfkFmR7jwc
         AtrAlMyrwJCcxZ/0WCEqN81kBRnDpPs0bTdOQdLDfFDhTNXwwygqGu+lQW1+BMfHcume
         5rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594097; x=1723198897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwHm92BbLGHRx6QTtSopvfWeZrLAi9o2tWG1Id2MUAA=;
        b=AR2dfEiI8QBbezmaE+BWCBcYGGHp/4NXAvOUqbm69CqPCcr3/xwMNmUppQM0r/Ulg+
         ZLSCg/gNju+etfDRb0gLhlUNtIvBlC+o6UxLWA1vUtqcFi9ra1Sj7oM5xop99QgaOQ4F
         IG/Y+JkSAkvJmCf4O/FOf8gngClDKxVuQB54mlzvJjchJ+G902p3RPH83HEj/STDff/o
         rLd6+rUmLUiCjGyphS5ly7PVqD7WC01tKXS29rBb8JIDjQxS4HMbfzd9PNGtxQQkuW8M
         rewHOm8lYgwPZTfZIC9TtQZ2oVdBPvuqmWYdGoIL4ecZCPvhY3bZfcorBicdEUWtslqq
         CnRg==
X-Gm-Message-State: AOJu0Yy91qRE2AiHrsLmhbFFphIQkcLxeFZUCp7OM+EYcBoLmLN4LgBA
	tZTolsvY6eEcS0zqUrQkeDFWZng5H4oxWle9MrGHA1FrcPJdgoaD
X-Google-Smtp-Source: AGHT+IHj45lsLr+ftoSo7knhUgc/3P4AxLTtg5yOwL3yNVxzSFOn/BzRPJu0pMu3PLEIDkDzdXfh1g==
X-Received: by 2002:a05:6830:b90:b0:709:4279:8347 with SMTP id 46e09a7af769-709b3205ae7mr3070460a34.8.1722594097153;
        Fri, 02 Aug 2024 03:21:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 6/7] tcp: rstreason: introduce SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for active reset
Date: Fri,  2 Aug 2024 18:21:11 +0800
Message-Id: <20240802102112.9199-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When user tries to disconnect a socket and there are more data written
into tcp write queue, we should tell users about this reset reason.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
--
v3
Link: Link: https://lore.kernel.org/all/20240731120955.23542-5-kerneljasonxing@gmail.com/
1. This case is different from previous patch, so we need to write
it into a new patch. (Eric)
---
 include/net/rstreason.h | 8 ++++++++
 net/ipv4/tcp.c          | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 9c0c46df0e73..69cb2e52b7da 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -22,6 +22,7 @@
 	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(TCP_STATE)			\
 	FN(TCP_KEEPALIVE_TIMEOUT)	\
+	FN(TCP_DISCONNECT_WITH_DATA)	\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -115,6 +116,13 @@ enum sk_rst_reason {
 	 * keepalive timeout, we have to reset the connection
 	 */
 	SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT,
+	/**
+	 * @SK_RST_REASON_TCP_DISCONNECT_WITH_DATA: disconnect when write
+	 * queue is not empty
+	 * It means user has written data into the write queue when doing
+	 * disconnecting, so we have to send an RST.
+	 */
+	SK_RST_REASON_TCP_DISCONNECT_WITH_DATA,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 24777e48bcc8..8514257f4ecd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3033,7 +3033,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NOT_SPECIFIED);
+		tcp_send_active_reset(sk, gfp_any(),
+				      SK_RST_REASON_TCP_DISCONNECT_WITH_DATA);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
-- 
2.37.3


