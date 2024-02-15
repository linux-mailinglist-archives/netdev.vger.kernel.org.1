Return-Path: <netdev+bounces-71903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E70F8558B0
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D601F21EE5
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BFA138A;
	Thu, 15 Feb 2024 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx3zEFZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCF6116
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960069; cv=none; b=hfhiFCA5lwzjdi5CsKeXlXkSSdVFFp7nALBiUCTKud5h2KvKaH+0Y6QnjF0vUqpbbTMWZevPj0beCeSL/qLACgvvKtk88ywYliDs1OMjPCJhfwJnRpAIu/RHgHRcCMMguwbjLRiMr5KFT0vaiGR12NpRsg65Grthi8lbpUKjfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960069; c=relaxed/simple;
	bh=J0NxMYBKX/e2aOXb5+x5L2AU5cOSk+fLQr3n0Mzg5AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqrEq0t93NrOG2R80XxN6aTenOj5tIRxbinAudZR/oqV2J3NNspv2CCC4KGGsbilEcR452fIV16sxAW9pISYjHAPL0XBp05gp5FNr1aW+rcMqCsEvfSej130f++T2v8fEz5bxl2zss1qqHjdNBqORid1q4wDSRCQjuL1ywAB1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx3zEFZ0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso357551b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960067; x=1708564867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id/o+c1wlHyi14IQwAUKwLJ0ogFgd2ncR8poTUkArw0=;
        b=Dx3zEFZ0KNHbOhKs7qKSrtlmh0nU/48nC3YOTCpJOKV/UVYMYvwO7kLm52R5HyKGES
         74nyOjzZG/aM1xWtMLnsHa5FmbYCP32q3zomUNePX5NjJBrLNdbu6Lc3vQOKUc2OBh3I
         SqztU+erB0I9YmCtb1+0lWbR+cybMN/vDofq7QJkqd0h8ifs1GwJoZLvEVf6Ka9d3bUu
         tvCC4wUh1sMoClWFtj4UVcCzwxTGG3hoTy8kgMjSRcwic995TRqpY05ZPj3p39QSvqaX
         jzT3C5ty1ixw4Wdpc8IEw2W6KEPon/pWJun8E2z74vqXSjenlY1I8ujwNSA1MIOo6QjH
         QUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960067; x=1708564867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id/o+c1wlHyi14IQwAUKwLJ0ogFgd2ncR8poTUkArw0=;
        b=ZjvQ+d8joCeIp4v3PDZ6iqo358QyI8Y9C2xpBOdnSwo+JRC0yww1APSS4Kpf3IUd/M
         p5I7uL2DLIak7tT7sF8Okm14+G24v4WE1kKukGGzUL07hjivTJGtQp/mKS0eERA4632P
         p6njeVtyDtLF4K3gdYycKjrW+1ogwLBmDDH2DNbLkIqqVsWXa7GEVIT3pcsX+gM0faYS
         gfURp4pr24aKwiuVtxaqe/ZJeffSib45WNdXqqGvQMsemcOD9iAppXQGFEj4BJM+PC7m
         ugNOSuEHD7Fe/iwE8PgSqMIOxdQ02jFMEqeLGR9VM6KDkJ8QDlMz+ElwiId6u2RABTax
         l8YQ==
X-Gm-Message-State: AOJu0Yx7Z5mTAzjBkXeKdLjpYYeKIPI/Ibb/xPzki+UTWaWyQONIr6EQ
	8ia4g6h4HIQFl4PR5WE3VwMyDb3K4yR66c6zHanbSwIbYtA6ugDN
X-Google-Smtp-Source: AGHT+IH2EkGtiZ++PK+8evgEVK52hMkAMBsLuSqAbGKw8PZHZqq4T8x0hRXZWh2L21hgzDQiWgqIEA==
X-Received: by 2002:a05:6a20:c886:b0:1a0:73b9:85e2 with SMTP id hb6-20020a056a20c88600b001a073b985e2mr574511pzb.10.1707960067136;
        Wed, 14 Feb 2024 17:21:07 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:21:06 -0800 (PST)
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
Subject: [PATCH net-next v5 06/11] tcp: introduce dropreasons in receive path
Date: Thu, 15 Feb 2024 09:20:22 +0800
Message-Id: <20240215012027.11467-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
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
index 3aaccad4eb20..581775763db7 100644
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
@@ -198,6 +200,11 @@ enum skb_drop_reason {
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
@@ -222,13 +229,19 @@ enum skb_drop_reason {
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


