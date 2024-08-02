Return-Path: <netdev+bounces-115291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82581945BE4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CC0B21CCE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABD1D1F4B;
	Fri,  2 Aug 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfCkuxoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE114B962
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594090; cv=none; b=rmeXGtvAQo+nbxUcQS3Fb8gRIp9+26N9aSPidn2KrxfTiDz7x59INTnb+P5AmFuYX1uZA1tIyEfJdMk2m1QO/RB6d6JMAF4E+z93iKFL+7u30E2Xm+BYUIbPZv0RxZ39pR0ywlBt/JFUjyOczgtRgoV+KZWQdXeuRsRf5d/aego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594090; c=relaxed/simple;
	bh=g3fhbhumzkeNAkIMtG7+6lCFSXQXdNT2W0/nZ/J6upk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ga6hLwvxA9GIu5nOabogUrmWx3j2VTRcaDo7MZ3k0ZC4L//kFrhhc+xImqT0pEEEdWENLQFGmZenlwbEu9DtbfCJoXk4VpGMbUTfDQSFExHPdJpLCa+Yo93z0dBDbquhRTp+0Gz479ECUoEKFgyMIG6fHOmgZFdT4FCerfOVVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfCkuxoX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70949118d26so5070433a34.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594088; x=1723198888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2L42Y3fxOPDIWwTt7ZYcTgRSPw4dmgExss+Yxe/O+A=;
        b=ZfCkuxoXC27xqF0bzYCWctplPJqLr/oCzmzyArEKclzo+uHKvOrQv71kQQKW9HI338
         8kkIZ7iQNSCw5e8NTME8k7F/5uZ7PIyg2JcnlwhdMPX8IdcVfcNWgZImMEDK+6u9BKVM
         wGCMsBZxT3XwwbaSPQ+e/tiPo/E70oeceh9qWRRzLu6O4SsSU/alZq8Y8Y9S0hC27k8V
         53XKQPDp9250yf7TqdPskCqAXyxrGNkrpjDQHojNWqdgrX7YfI2kJKh8PZifVugiGIFI
         BFC0T7kNcDvhViurWhlOKAWgaKCytGZDIyAosm5iJSe9213VwpeGf7IHMcRFKyoF2HBM
         MllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594088; x=1723198888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2L42Y3fxOPDIWwTt7ZYcTgRSPw4dmgExss+Yxe/O+A=;
        b=Aul23cF4hfL9Bja7InBrWFWbnwOTcHCEpgauxa4GUSzDUjUJZp8Fn2LAXPVsELbexN
         s9lyQLiUT5V78aQsNtsV1k2UGnJe6OY31SFpw6sOM1iKZ2r0gUZ5U8VduBTjb6pKF6ar
         0hBr8jumo9UGGA8p/T9LMcVyF4VYJFnAQ4ec9sCgZZIfYkel4s8AsNkayC60qWDjP1It
         HmIST0HIGn22el95W9u20SvXwyLwwvCfYgtzc5aUaP+5BTPnnl3K1X8rZEOxHrIjNCRl
         PR1hgf1es2or3AICi84zO8HUG0YFIu66HOqaQRwifrbzR1vyxnG1iWxhk2wAlNA+7zkU
         2yLQ==
X-Gm-Message-State: AOJu0YxwnGWespytwauYk6ngKcOWuyFKEthEvSdjq517+wuYFE9dpynD
	5JUT2wNepcWgWsR57gf85oKDH5eEahWKIhxdPbL6ou6Kyr56RXd+
X-Google-Smtp-Source: AGHT+IET/33mmYN6obSl+jHVmzARlT53MPo74lmdQMyigs/AbTItDJ6Zi4PeYMF6jw6oHvBQmugXLg==
X-Received: by 2002:a05:6830:6585:b0:709:3e50:f24b with SMTP id 46e09a7af769-709b323eaa3mr3331137a34.20.1722594088078;
        Fri, 02 Aug 2024 03:21:28 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:27 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 3/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
Date: Fri,  2 Aug 2024 18:21:08 +0800
Message-Id: <20240802102112.9199-4-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_ABORT_ON_MEMORY for tcp reset reason to handle
out of memory case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 net/ipv4/tcp_timer.c    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fbbaeb969e6a..eef658da8952 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -19,6 +19,7 @@
 	FN(INVALID_SYN)			\
 	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(TCP_ABORT_ON_LINGER)		\
+	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -96,6 +97,11 @@ enum sk_rst_reason {
 	 * corresponding to LINUX_MIB_TCPABORTONLINGER
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_LINGER,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_MEMORY: abort on memory
+	 * corresponding to LINUX_MIB_TCPABORTONMEMORY
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_MEMORY,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5b0f1d1fc697..fd928c447ce8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2927,7 +2927,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
 		} else if (!check_net(sock_net(sk))) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 4d40615dc8fc..0fba4a4fb988 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -125,7 +125,7 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 			do_reset = true;
 		if (do_reset)
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 		tcp_done(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
 		return 1;
-- 
2.37.3


