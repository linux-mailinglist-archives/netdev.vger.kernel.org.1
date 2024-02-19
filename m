Return-Path: <netdev+bounces-72800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE23859AFA
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B821F21800
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E49442A;
	Mon, 19 Feb 2024 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0X/KVPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17404414
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313356; cv=none; b=aQi4YLI8rqkq2zcOl6n0AwpOLobte/YPW4eeolJfHa9jRlAmdCq1e1q5ifHKTFF4kWdnHuFNg29SCUnURwz/5A4IBBpTxWmQBRge2JJUzmCyKuRLDtPy7QcP/QQN8Gt/yGYpDncW/5PTXIsvQNW6sUx0ZaXGoZXaaXpEUPtKcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313356; c=relaxed/simple;
	bh=/dbStDVEktR0UsVQ+/dQhQVkIN/iqXYzYBweRKl7zPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ebg1Cex0h6E4R3xNyM3B6ZPeQxzTbW3vPPCgBrukJU0tzwu0OFVHpXaM1FjIdL1LMX+vFnlILIZMFPPZiaEAkQxjHYXiGKfMVIdgPV1CldoaLr357ddt+Xh5xk1K7KrgW9d6eekzpB13QERYS0y2Y+3Ee/x9v90zBoyYeRWEAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0X/KVPN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so748790a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313354; x=1708918154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H9Q/kPjFOvJNIuBeuI+vbrAPgxPqkEtPTUzJ+HZ7kU=;
        b=H0X/KVPNMVYGnS1kpic1DMbszRK//n0tT1cAKaT3DiMZ8Si1YAHDhwMTFWjeqGjnQq
         jKfKJaDe0ybLJO3XmMLnVGCDCSbMaB+Fr3lWE5HUcryoOEtF0o2k9lOZzbjae2vQJMSw
         aNIMpTEZYGdIe4DteEDqUtmS2SA5UgDskJEf9n71njpxojQmBji4HctCZzfTPlIc0l/e
         l6/3SfOVh5RcWSxKHU+KgTRv6H/W18uaqdfkm1DTLlMwUq9GzwpMJsEo9ZQ6ss4R6uxh
         3eV5UtcUCy5inKxnLYcBevsTqqHe7frTkfI9XO3DCPdwfo4Bn155FncuUa3agQ7fiQZD
         HexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313354; x=1708918154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H9Q/kPjFOvJNIuBeuI+vbrAPgxPqkEtPTUzJ+HZ7kU=;
        b=JIrywH3LF090ALbtcAEMN2asxONyWiM8ZjPvTlvDGtUy5ryE2xvskcObDmTRpPdQgz
         5EXPkvqsJJWytPT4JMZ9kv7En/rRufLZhl5w3tKrZXtmD+HR87z2CwhqiLJ7+Q5fUkRd
         9cRVkHCiv3Il+5TH9K/oXa9luXTC1K3z6m0s//mF8mMlaaQili5LyiIGIMzm73/kzaBf
         ToyfBH5Ryv8hJzoifFedF4Tn7GpRQAOkItNEUfCgyiiTSXGRGGn2vlPAD2u0NsTVzwvV
         040ysbyRlgPCY8oCq5Ozg0+e89pk0BKDPN5/cZbtdGbyGNqiHZgHJUW0VxG3zLdcPJTG
         lUfQ==
X-Gm-Message-State: AOJu0YwrtsnQPi26h2loG2BcuJfRoObsvbffvevwdoQE4cdLcBmCgtua
	r5b01VBzTqsFm8t33Hj2W0fWAeoVtMQeg20Qa05asqkT0NShdgsM
X-Google-Smtp-Source: AGHT+IEW09SIgtzYM/HoHbbxGbiRjGUdAkbzdwEdd8OrgzZxzP+RoZgWSRe+epPW88YB6nOPP66HWw==
X-Received: by 2002:a17:90b:111:b0:299:2c43:662e with SMTP id p17-20020a17090b011100b002992c43662emr6387568pjz.31.1708313354312;
        Sun, 18 Feb 2024 19:29:14 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:13 -0800 (PST)
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
Subject: [PATCH net-next v6 01/11] tcp: add a dropreason definitions and prepare for cookie check
Date: Mon, 19 Feb 2024 11:28:28 +0800
Message-Id: <20240219032838.91723-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240219032838.91723-1-kerneljasonxing@gmail.com>
References: <20240219032838.91723-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only add one drop reason to detect the condition of skb dropped
because of hook points in cookie check for later use.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
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
index 6d3a20163260..3c867384dead 100644
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
+	 * @SKB_DROP_REASON_NO_SOCKET: no invalid socket that can be used.
+	 * Reason could be one of three cases:
+	 * 1) no established/listening socket found during lookup process
+	 * 2) no invalid request socket during 3WHS process
+	 * 3) no invalid child socket during 3WHS process
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


