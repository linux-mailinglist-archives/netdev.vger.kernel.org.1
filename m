Return-Path: <netdev+bounces-74340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD8B860F42
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2AB24877
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214D5D467;
	Fri, 23 Feb 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/JmEKf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075F5D72A
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684170; cv=none; b=ZRQT0GltgKVFmwCK/a7QhyXKh0KHen0gk8MzlIgb8wBGr/joN+O0XOtxDf215aDKxlVgJqFYF7R167HhzSJYNlLDVUqG186j1G5ahca7nYBRlmbwY7t5czHHePQsjh/RgS8wtIxrZvS+DrP58OjflKPfRbR5ePXFcX9mEgSbPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684170; c=relaxed/simple;
	bh=XU3xXP1Z1r/XTAA9F5jpuZg6AyOJdHSI7WZD8Yabjkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qd1Oj3t8v2qSHLwHKqbJfa7D4IP/7b6ZSxHnF+JRNLaty5Y+3LkKoCMej0IREdpJGO4poCKGECsDxmAa6RdPPTsF0Y3g3dL8Etmy6Ya38+5a5Z37uwMX5OZgNdE+E0+1SlRJ61i0uE6X1EOGSrFWQaQAUugRaGIVl7N3zKPgtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/JmEKf8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc29f1956cso4261475ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684168; x=1709288968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGa3x8JeC2eEEsTxndb5FJy4brOQuJXVDeDrBzAkvIM=;
        b=j/JmEKf82+QUteSK261LLh1jdYkd4BxVSjGhPMzmcWA8uM6hAEhvXKvD5TtqnkG1ig
         sevEbunrRODmmKMj6sqGtthcIDfcWEeNYDW2Owge+nqPEv8sI6/SiPpaMcey4dc0wiMD
         edz5qzpUjECCmDWQm1RCzw3WxSu4Vem9nctsjeYC8O5bqAbK3uJiAtv2wMaPteH1hb+n
         grCncfZ5vlwVjWM6wVUQiIjT6S/iaSawybvhmjiRbsLLQS6CJT3hcH8OCOVQHtA2ODdC
         sDKqEOx6YyZh/ybKY6Cwbo3xHBYy8mSvGcpvWgjhIzSujvnBQPDhZaFc4G9OMfa688Xe
         PfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684168; x=1709288968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGa3x8JeC2eEEsTxndb5FJy4brOQuJXVDeDrBzAkvIM=;
        b=SE4SrbAz0dFQ5X2AKM+Y7ENf6PGJt6ITSk6AKZBI/B3wzZ8nJqc3hUG4//jDD3EZIz
         yoFH/7swByG9XMX48e0KoijGnvCQNk1Gwrc3UVcNDkZZYemf6EK3/X2FDv3M+vl806HE
         17Q0NNvs44XvYPkggJcPx5G0AMedMOzmf8lF+577aES7goPXeFH/63N5AXjG79v8v0Fq
         IMzUIs7POzmDUTJchSSiDJWesPZhD1yRapjGwuNzaWUiyy5mu6tzJIvnFwI3cEe5h2CB
         W3fUR7uvMhulW53oIst0qL6W7e5mXXQUzNwQhezWcX4JQCCIgrecETXiZFm8vsP8eid6
         WG6Q==
X-Gm-Message-State: AOJu0YyBoVZ2JClMmavJmColKU2sQdTqK0n6JWpoMnOSX0TjattMgji6
	lP6AV9AQ0J33Xio1JFTieINq0V0Eaiaq3U/0k0CzaJ3M+duUaerft7zkqFOn2Qc=
X-Google-Smtp-Source: AGHT+IFBiAhiOjzIZsuicMLXcUbNJ1vWvyD5TLthLhQE7i6+pQzR/gOIwPKmgbSd33urocb0nMM5Dg==
X-Received: by 2002:a17:902:f7c7:b0:1dc:1ef:aeb4 with SMTP id h7-20020a170902f7c700b001dc01efaeb4mr1492972plw.35.1708684168451;
        Fri, 23 Feb 2024 02:29:28 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:28 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 01/10] tcp: add a dropreason definitions and prepare for cookie check
Date: Fri, 23 Feb 2024 18:28:42 +0800
Message-Id: <20240223102851.83749-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240223102851.83749-1-kerneljasonxing@gmail.com>
References: <20240223102851.83749-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Adding one drop reason to detect the condition of skb dropped
because of hook points in cookie check and extending NO_SOCKET
to consider another two cases can be used later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
1. add reviewed-by tag (David)

v8
Link: https://lore.kernel.org/netdev/CANn89iJ3gLMn5psbzfVCOo2=v4nMn4m41wpr6svxyAmO4R1m6g@mail.gmail.com/
1. add reviewed-by tag (Eric)

v7
Link: https://lore.kernel.org/all/20240219040630.94637-1-kuniyu@amazon.com/
1. nit: change "invalid" to "valid" (Kuniyuki)
2. add more description.

v6
Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
1. Modify the description NO_SOCKET to extend other two kinds of invalid
socket cases.
What I think about it is we can use it as a general indicator for three kinds of
sockets which are invalid/NULL, like what we did to TCP_FLAGS.
Any better ideas/suggestions are welcome :)

v5
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
4. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
5. adjust the title and description.

v4
Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
1. fix misspelled name in kdoc as Jakub said
---
 include/net/dropreason-core.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6d3a20163260..a871f061558d 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -54,6 +54,7 @@
 	FN(NEIGH_QUEUEFULL)		\
 	FN(NEIGH_DEAD)			\
 	FN(TC_EGRESS)			\
+	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
@@ -105,7 +106,13 @@ enum skb_drop_reason {
 	SKB_CONSUMED,
 	/** @SKB_DROP_REASON_NOT_SPECIFIED: drop reason is not specified */
 	SKB_DROP_REASON_NOT_SPECIFIED,
-	/** @SKB_DROP_REASON_NO_SOCKET: socket not found */
+	/**
+	 * @SKB_DROP_REASON_NO_SOCKET: no valid socket that can be used.
+	 * Reason could be one of three cases:
+	 * 1) no established/listening socket found during lookup process
+	 * 2) no valid request socket during 3WHS process
+	 * 3) no valid child socket during 3WHS process
+	 */
 	SKB_DROP_REASON_NO_SOCKET,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
@@ -271,6 +278,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NEIGH_DEAD,
 	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
 	SKB_DROP_REASON_TC_EGRESS,
+	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
+	SKB_DROP_REASON_SECURITY_HOOK,
 	/**
 	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
 	 * failed to enqueue to current qdisc)
-- 
2.37.3


