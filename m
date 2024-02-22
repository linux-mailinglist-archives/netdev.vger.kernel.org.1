Return-Path: <netdev+bounces-73959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79C85F6E9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6591F241E2
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9A46549;
	Thu, 22 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQxV93+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11814501C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601429; cv=none; b=prX55lD7mfP3rGZXgEvN8/TWkXfQJftwEV9iaBXNlRQu0GraRag7mm4iG0UpRKWfQ94fYAPrHKQVY7O0bmg66RRxtUsa/rC+r8fD7q/Seiyoo0fo4KKX6iporcUy3oqPiKFdCP5JC1dFhQQt+zlozL0kzwjPZAyUBVt/89+OLW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601429; c=relaxed/simple;
	bh=7Zp7x785+/uhxiU2Ik7D9xJ4gfhXMG38++pvy5SIfvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lu3Ksf/dmfMmctQpzQ9YO2iLWpPKxoHQqcXSxkx3VzaF1HMLzl9Jf831yy5anPCFv8Fkd7Uk197IQP7fP8NctUbb0s+l2bWEW/LwIH2Q4ehrZAgskgPqJpmj5+T3rejl+PiA22mlTQyieTZzrI1MBG+TcBnTq8mgzixJmTjAAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQxV93+L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbd32cff0bso39793875ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601427; x=1709206227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMelBBUb7lQfw+CAX9NdYFLemt4g519UfusTQ2lvYJQ=;
        b=gQxV93+LHpAlFVRiwCFB0a9xallqkaHWqcYUJlyq4IstjTV+te8hkwDZLSzHiHYK2L
         juuTF3Lejxx8WlRUOFc/WqiCvoUyVEDpfYmAOTz46t9u8NRiEA5dfkOTBA3sp8avzbdz
         xziGPb/AyIalvnauV71MmCO5xGaRg/Ra9BGHXZVKPGnIF4DrRHmdxnEZEuixlCsNE+mP
         lvF55GPllLA/19iaymhvP+G9c7YlMrKItCfgxdL+7kEm8AjgRPnSmjcpchdFH0UKzU8l
         mGAulSxNV+53IPtcwBU64iAjwzOPwZ9EicII4nRiRGdWSZT/ob5IYQfbXokqSujBkmu5
         KqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601427; x=1709206227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMelBBUb7lQfw+CAX9NdYFLemt4g519UfusTQ2lvYJQ=;
        b=lkAfuyc98+7gZakBTvMYpgDkCYAxcjBamuD7SOfJjkf5Aja8sQKlaAj5e1kndC328n
         MJGrfwUqZvpvADJFrjROB/mhZGVCQV4amNg35M6LTYfO84Y0eELomd/AoXjdKRNXCz9M
         fVWyQPfe0LL7p/EtFBGjAK1Sff2cxgOY5GvDFnJAgQDr27qmVODIzk8uYxTgGa77WtYa
         nNe970/vem2zf2eZdsB8jDYFiiW45GT0v6N4+NuFaRNtYVwtHAHeCk7bwgg2ONlQVS6t
         oCfv07Esw0V5VGd0CFoLMkmcWfG3SWtlIi7+h8w5hJNZAQrLMGDjuFrUsbJG7uLo/COg
         x2Kg==
X-Gm-Message-State: AOJu0Yyxnj9hrWOyKmfpzr4G1+ymblABHSidpw4W11gWVelMecWotKVo
	T8Y1/izfie3GqBmWoq19y8wzyXfGJpZA3UlTzKa7PE0ZRUYseuqd
X-Google-Smtp-Source: AGHT+IHb3p0/C1nTmvMihu07POztlAzO3q8bzxp76+9fEhLBHv44elySLXQ84Jo6PtaQUoPjBY2Htg==
X-Received: by 2002:a17:903:452:b0:1d0:b1f0:1005 with SMTP id iw18-20020a170903045200b001d0b1f01005mr17556253plb.63.1708601427188;
        Thu, 22 Feb 2024 03:30:27 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:26 -0800 (PST)
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
Subject: [PATCH net-next v8 06/10] tcp: introduce dropreasons in receive path
Date: Thu, 22 Feb 2024 19:29:59 +0800
Message-Id: <20240222113003.67558-7-kerneljasonxing@gmail.com>
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

Soon later patches can use these relatively more accurate
reasons to recognise and find out the cause.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v7
Link: https://lore.kernel.org/all/20240219044744.99367-1-kuniyu@amazon.com/
1. nit: nit: s/. because of/ because/ (Kuniyuki)

v5:
Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
2. change the title of this patch
---
 include/net/dropreason-core.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a871f061558d..af7c7146219d 100644
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
+	 * field because ack sequence is not in the window between snd_una
+	 * and snd_nxt
+	 */
+	SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
 	SKB_DROP_REASON_TCP_RESET,
 	/**
-- 
2.37.3


