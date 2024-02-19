Return-Path: <netdev+bounces-72805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0AF859AFF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD84FB2139F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4244414;
	Mon, 19 Feb 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpPGGGIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A65681
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313370; cv=none; b=RHgmOwUeFRSNlUhFppO8lSQtOjbJzrzWec+OJiY1RF5bivZrpjJNEcMP/wsTBsuBzRO4BcdUd1KSkoIYB0OBLWzC99KSv9g5Bbmu233VdFK+csi5IDjkL/zZoDqUR6OWPBzbRWTn8edtWMrzl7GeGtpHkSoqy9zoYzYv5j6/LX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313370; c=relaxed/simple;
	bh=KAj9xfwEGa6SjGm8x4hCEONlZ+giy8Ehdu/2/QOPKKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8KZMJ0eDlsBYS1a2/xiNzlvEamhM+AzQ3n59bqh2ODGi7jHgsM+jHeO+Ab7kaWtYimcue89uGsgzBofUzJQd8VKBg7sw+OyNzy5fV50pg8IGpzLplB6GqyFEI61btBEUdHnKXcnWuqgQ+jJGVldA3Mo2S8hU76j4eH17fuhaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpPGGGIQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-296a02b7104so2904829a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 19:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708313368; x=1708918168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM5U9V2XSZCs4Epf5JzjpuOVpIlEpgZgzWTMDM5kvdA=;
        b=JpPGGGIQkcrH2qy4PBOIujgRXDjmBLsXJT7wSsin+QleDUAXchRyozTP6yQDPoxtcm
         l8d0Slva3mgmGACQNa5ZZ4DkvOqMkdBytdjvGtz5mie6prQgEYTz8T6herjprCdbawis
         yoZ2aWxT48mNQIGyXv/+LJyLGhRzIWuY7b67ja1WK6CayIRpmfFgZufYF7UkJz0MRLKj
         +ABcyO17tDkJRWJNrxH0Z7xse/I7GL3M6JtDKMUV5LaAWS00vhVSAQ0lt0hTRMJ3qTLG
         spm3FlZeTgeJIY5rcsvMTfI7Tbu7SXn+hcmOT0A9+iWKwjTRtSGUiNIuLkfo2B+JQvd6
         Pfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313368; x=1708918168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM5U9V2XSZCs4Epf5JzjpuOVpIlEpgZgzWTMDM5kvdA=;
        b=sYQ29kcAYhpc49r5TwihrBYGeB++eiKcue5lsZTQp04gd6nZQs+bgyWCh/i/4Uo42y
         RwDz2s7GAGvTzghtj3Dip+NQxUaXZkHT7kYhfY2s3p7Pltm2F4x28iOcsNU4gt4mrM5U
         1j8Ya9OSYQ9YCNPT1WW1HRwOf36rmWdJcXcpBOsj83ctC3RxAVnYdQUEJr0akgcNn5a8
         V8WzzBYD36l4m5sJY1a5BdKVbCdm+gDdqKx/G9qoyMJqwWJDx1t45/uwBeIKgnspY2o4
         aOILr5/SnaRBAeN/harx6dtEwXCzA8mMYRpIcvojK8VtvByiKmJBiRkTwCcX+mIVeTqB
         cy0g==
X-Gm-Message-State: AOJu0Yz1Rb2y9136XSysOytmVM5Rl+FTR99sjIEs0iL8m3QiHU62fubZ
	YQ/iGoc2xajdtXzbaG+MYaL64snJMdtK9jaAHN9EDA/JPnywsDMg
X-Google-Smtp-Source: AGHT+IHdnymzjRJ3afiQDAFSWHg/nmgvu81cXO3WuTOIZwbSW5cYVRccFg7hAnRyf9EjEjZT+4H0eg==
X-Received: by 2002:a17:90b:78c:b0:299:5401:89d2 with SMTP id l12-20020a17090b078c00b00299540189d2mr2915256pjz.45.1708313368647;
        Sun, 18 Feb 2024 19:29:28 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm3968921pjb.25.2024.02.18.19.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:29:28 -0800 (PST)
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
Subject: [PATCH net-next v6 06/11] tcp: introduce dropreasons in receive path
Date: Mon, 19 Feb 2024 11:28:33 +0800
Message-Id: <20240219032838.91723-7-kerneljasonxing@gmail.com>
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

Soon later patches can use these relatively more accurate
reasons to recognise and find out the cause.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5:
Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
2. change the title of this patch
---
 include/net/dropreason-core.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3c867384dead..402367bfa56f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -30,6 +30,7 @@
 	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
+	FN(TCP_ABORT_ON_DATA)	\
 	FN(TCP_ZEROWINDOW)		\
 	FN(TCP_OLD_DATA)		\
 	FN(TCP_OVERWINDOW)		\
@@ -37,6 +38,7 @@
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
+	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RESET)			\
 	FN(TCP_INVALID_SYN)		\
 	FN(TCP_CLOSE)			\
@@ -204,6 +206,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_BACKLOG,
 	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
 	SKB_DROP_REASON_TCP_FLAGS,
+	/**
+	 * @SKB_DROP_REASON_TCP_ABORT_ON_DATA: abort on data, corresponding to
+	 * LINUX_MIB_TCPABORTONDATA
+	 */
+	SKB_DROP_REASON_TCP_ABORT_ON_DATA,
 	/**
 	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
 	 * see LINUX_MIB_TCPZEROWINDOWDROP
@@ -228,13 +235,19 @@ enum skb_drop_reason {
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


