Return-Path: <netdev+bounces-73953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7CA85F6DA
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF679B21539
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DE4446D5;
	Thu, 22 Feb 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVj5RdF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948A3FE4C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601415; cv=none; b=pMEMsq90zddEtEIImFRfr1LSHQFUNRc64pPd4QECOCUlbSUCZcik9mVmGs3TtO6nw5d1FN8PqTXqwBoB52Gw1/X8nrkXCiWKskIVrazHqa61YA8Qdf1mrLePmcr8RPlvCF1lGKVI9PRfpcuxhDdEvlvveMW8EeveA7FL/wx01sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601415; c=relaxed/simple;
	bh=9P3/dqf/SCbDCM/INxxXwECtGJLis5ZXi3z5fbwHBRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D16l5YwEwrH7gSYKy85zaDfwug+E5snyS3+If0Yxj+87j4z1iPbslzFJqwUdzqZkRBqqBgaq7EY0vMOM36xFd2+vMxCekhTaxhm01mCGalvUALdDuC9uTOPBlEIs9xqB5ZsJvBbqAsHXuzChTNh3hNk7u6UsYUeofUHnUJRa918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVj5RdF1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dba177c596so4953915ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601413; x=1709206213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OErMr2/tFbMgm5lFiZzZbH6qllUlMl9rYlHOVu/pd28=;
        b=mVj5RdF1c6GoD9/Ls26Qt7NpRkmzAuvWruZxG6Wdi+D4dsyG7JUVYwwSMh12833Gwt
         depCuKP7xTjFvKcnej4jMQt39TS6dm2mESTDe0RsQJvk7WOF3PoZUmQ+Yv3TTsbZAvbE
         hBLPtoWp0Fa5gJ+hKtqzvXTMDIVpfbuZvVFCVeFPzA+wWPKqm7pUI0TCzqpdtxz66I02
         Bo7GLqF60c9jzIulVYuhSceZExeH9TmJBHqRO0KNLEx+TkSFRYv/Xgfah3zywfGBkkmR
         FuI565rTxqsiupaoxoTCWMx1cAkgmU7rgNcAYaZXGNhmmfccdr6O5MUCzUVbAkWtlhZo
         0MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601413; x=1709206213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OErMr2/tFbMgm5lFiZzZbH6qllUlMl9rYlHOVu/pd28=;
        b=gBQ327mn2XBH6uHwD2hhhC3u5pt/vxnIg8Z77QOGhvoWj20jmTnFJC8ONcljBt5lh7
         m+qinN1cCJ6DmpTf9H7w5CN/I5l7xxSdAG5zocwCKPKCwtn79G9Ryg+BB3jUFjUfw1BJ
         D0KgJbX9mOHKDXfy816SZhqSM1SQqYc0qbDI2cf0Fnn/4EM9O0+BRr/D8ecPTx16LDvA
         yKylFTKVWfFdsUA1hworVBG+yLJvyeSBuseE5KZmnJBdMj9QwKYbqzK/7kYR9TLeSw9t
         Kw7Mce7XGiDIoqnVS4YADyBHPwLJEUqImhVjySFVwC3DTZzxQSwSpkfpBJBnyNKc/zGb
         AmgQ==
X-Gm-Message-State: AOJu0YzT0OoSAvc5WEweC15yf2EM/pj4u5CR5SrOQCbKw9ZexWTVKETI
	CXdlrUdpnuKu+Vk53pYOX7eJWLZr3WS/pmktc8lVgpXMcS6jcce5
X-Google-Smtp-Source: AGHT+IECP1yLa5iIqsT22OMG79LxS7NCwI5hSbT9Px9pR0BWpLJXZ2P0wDHzpliHOsGADVxTzR9MZw==
X-Received: by 2002:a17:902:d484:b0:1d8:ff72:eef8 with SMTP id c4-20020a170902d48400b001d8ff72eef8mr3032789plg.18.1708601412794;
        Thu, 22 Feb 2024 03:30:12 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:12 -0800 (PST)
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
Subject: [PATCH net-next v8 01/10] tcp: add a dropreason definitions and prepare for cookie check
Date: Thu, 22 Feb 2024 19:29:54 +0800
Message-Id: <20240222113003.67558-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
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
--
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


