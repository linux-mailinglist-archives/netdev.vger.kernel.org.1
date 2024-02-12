Return-Path: <netdev+bounces-70898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB390850FBF
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A21D1C21AF0
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234D12B7D;
	Mon, 12 Feb 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyfQ6xk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F814010
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730178; cv=none; b=dCmm1B9TvHDZfwqm9VNi1ZZcDw0q+RQWnImM52T5gZTqneLe2uBR/Z+fvpOUE44LVO5UwmhRXkXl3v2MuPgdsZArMIuPlwMlAwN3Hd9bFE292w0RFwyPF3N5nQ78i944aT2rAvxQSqbyhRnZAFmVIJ/9aPCIFuX+s6V3WpwaGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730178; c=relaxed/simple;
	bh=HfVSBaJfDzcfCtKeSl5LmTBEFoD/5ZETIe3NF4zIxrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVpMvtsPLxUpXwSbOwGLXLl8jCNFfdittSGDfChVTr9WLzRRmMjX27h1vVTgQwsW4iapXEVoho992jG0nTgui1eWKph5oh8CCAtE9dLSAT4jKRFHFsbXhFnlPsdXJ8TsRz/JlSQf0mpv6b09kCKW4eY1QJJRKUn+bGDaKvDW43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyfQ6xk/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso2478254a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730176; x=1708334976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkN9Uw6RXhSc1sqpdvq5JNyS78LT5R8JJjTZGgod9mg=;
        b=UyfQ6xk/s27fNHaeQhALUp+TXo8RM+SitWhhuWxYdD1bcpPnCU2VDXaaSfDv2iEFZ8
         39dxY9GaYx9DOb1v0qzuFTCDEU6Eq2nvvUk6a3aINR7MOD8RUDczU6UibRW9ROx1lytX
         qbpPQ4MCZNdenC83vEyGk+4l4m1WXVn07D7mUGUPXhlFMX3jz02Cpz2I13eWJjkD/O7h
         pTzKi1lBY4lg5ZvwNEKhB745qJHgXZx7l8Rq9ecP6NcCe0NHp0OutP7HVG/2D0fh9FcM
         npXq1lgxR9ogGCXXeGx/qVHpEto2SLOwnLaVgtF2ZTaG90kxBZJzGzdoO4mFT9kXCSdR
         z56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730176; x=1708334976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkN9Uw6RXhSc1sqpdvq5JNyS78LT5R8JJjTZGgod9mg=;
        b=pv9cZ7Ot+DSGpkU/Gr0pGWMU1qLa6Hv24shqfZXbCx/ltVgU6M3SduY74vMrgzEvt9
         D/7DX94Yo3DG/i2c86qe7k7n9UbsnzKq+UaY++BNhXWZXJO4WHHeF0KMk6hUcn3g0ieM
         703o57K/x353gnjqdMpENyo57kd7c/9ot18BKWTyMnuJqp9RAo0y71DK8B4l/vm29QKb
         BjfgkR0k8RtHOVWkOXGH4xk4JhJ3Bgl50NvV4bEn8Xhm7U8mhaD8YIsdRJKe5aBoIF/D
         Ep6CguGycqPJjsQVkZI9WgdvruX4oioEMbYKe/go9VnJGDkEr6rCaInu3MAgfQQgbF0l
         880g==
X-Gm-Message-State: AOJu0YyRqL6pzxJrlcHH1KY4Nx/a/J3I2USwHbSQCUz9Xxgen1fUnFAn
	pPlFH6MbBMLy6Xm5AXDXcZuNXRhpeKJH8Ho9Cz6Cdb4z0dY/2bgo
X-Google-Smtp-Source: AGHT+IH0ZSs6yM/wtDEVmsoVtkRE+4NOz4H13/IgdjQ/SJIvGfnKB8YXSlJwwiaz3BCeruocfP0Baw==
X-Received: by 2002:a05:6a20:ce4d:b0:19e:957c:f7e6 with SMTP id id13-20020a056a20ce4d00b0019e957cf7e6mr5200216pzb.13.1707730176166;
        Mon, 12 Feb 2024 01:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWazc4L69maCSm+XUtsLqXEiZFt7dWO+hGeG0LgmJL+0PX2993eO2dHQbFlRDYqnCjl/kS5Tuh3XQskm+2ETcLY3/FAux9qnFekIE1qSOpjHux2bnrXb0x3GO4CXBrUroiXeQM15tQEPUU1aUB7ul/MLT1FcF7wuunSNhmt3yiHyy/ENLmtK1WqtlEmn8RAFAn2nKk1JY8dbq+fAkG94Pf8VkXdVGpXslc+A/NJ12U=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:35 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/6] tcp: introduce another three dropreasons in receive path
Date: Mon, 12 Feb 2024 17:28:22 +0800
Message-Id: <20240212092827.75378-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212092827.75378-1-kerneljasonxing@gmail.com>
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Soon later patches can use these relatively more accurate
reasons to recognise and find out the cause.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/dropreason-core.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 7cedece5dbbb..92513acca431 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -31,6 +31,8 @@
 	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
+	FN(TCP_CONNREQNOTACCEPTABLE)			\
+	FN(TCP_ABORTONDATA)			\
 	FN(TCP_ZEROWINDOW)		\
 	FN(TCP_OLD_DATA)		\
 	FN(TCP_OVERWINDOW)		\
@@ -38,6 +40,7 @@
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
+	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RESET)			\
 	FN(TCP_INVALID_SYN)		\
 	FN(TCP_CLOSE)			\
@@ -207,6 +210,17 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_BACKLOG,
 	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
 	SKB_DROP_REASON_TCP_FLAGS,
+	/**
+	 * @SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE: connection request is not
+	 * acceptable. This reason currently is a little bit obscure. It could
+	 * be split into more specific reasons in the future.
+	 */
+	SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE,
+	/**
+	 * @SKB_DROP_REASON_TCP_ABORTONDATA: abort on data, corresponding to
+	 * LINUX_MIB_TCPABORTONDATA
+	 */
+	SKB_DROP_REASON_TCP_ABORTONDATA,
 	/**
 	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
 	 * see LINUX_MIB_TCPZEROWINDOWDROP
@@ -231,13 +245,19 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OFOMERGE,
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
-	 * LINUX_MIB_PAWSESTABREJECTED
+	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
 	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
+	/**
+	 * @SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK SEQ
+	 * field. because of ack sequence is not in the window between snd_una
+	 * and snd_nxt
+	 */
+	SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
 	SKB_DROP_REASON_TCP_RESET,
 	/**
-- 
2.37.3


