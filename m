Return-Path: <netdev+bounces-74808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61F8668B7
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340C1B216D4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7451B7E5;
	Mon, 26 Feb 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuFtG3vF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB61B7E4
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917789; cv=none; b=TW+eOG1nn2RDFpvYyLDL+WNtrhPU5moYMM91FC6bapA4/fjVhjllV232P9sWVlRu/sTUrMaIbQXkR5jAFiZXEFvZ4/uNPjfAHQFXDl5KE4VCBr9HL8cfaVNhNsU8CiNuaPqETdU92FmWLPJsXJRdKKqAFaVxeSyY7bFLnCZYBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917789; c=relaxed/simple;
	bh=KaaiJ18KYQmqhFkXjULw9YatzoqaSa/KaNvtu6kfjMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noiWCpmVV72n51H/RndmOc83307kWxe0gFVBz2sYqvE/iuxN2Mt6aN6FWi53IkkrtRgUoLUNx6yITw6by/mjr6MLLWcdWJRdIftLJeXQH73RanYPqM1zmEVcEyDgw7dABcsXL7uaWp+U+Os/o5jzAmZkpNATdgYfWGpgTeM6OoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuFtG3vF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2594773a12.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917787; x=1709522587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3qlBSMKAox2vGn4VMLrenRBnLFBak7dDbUh01hBi3U=;
        b=FuFtG3vF9yCyj89jiWsuqTUVDbutNN0pUSCBBieXqOQwzE+oLIQM/9C+45KqI7CKpI
         VU2TONZzDnroZHpg8Hfz8nL1f2GLdjZOlSbuXthIB0dgZlqnd6Vk3Z4U+NR6bdB8XK4f
         nQFANA1Cy0OrM3yWq65wE0Xsank/7aDEmIcJPH+fZjVyQe/wH8o+Li+J4X4Ugw+JA7mt
         ODbwVx3OP8uWHs+icK8fuOzMaX75cjnOSSxGHoIUUOk0QrLIJLJ2aBnAMM7/fEDrp9Ww
         GgntPt6wns7KvJI19H0Wds3MLaQ+ymyPQypLxabxCc9FkbJF+ClnCSf2C7Of8k9Zbe9Q
         1yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917787; x=1709522587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3qlBSMKAox2vGn4VMLrenRBnLFBak7dDbUh01hBi3U=;
        b=Ptu4MGYSgSriPSJzn9eeT3FATzqJFfR+pb86E81loeip1DmdOlpGWvRgL4RXbZ7CZS
         6vrflXmI75Kdm/Mmw9F4vOKtFCiqcWkDy4lLChyth8fP0/WrtOXyQcPnFmB+Nd95Dfr6
         2FSKIRz3tw4+fYovtqE6hVU1JlNwbC9IYAdKO73+p9SUVu3VMv+3zXN3e+2GcmuxzTln
         KypEM/xZA086Pn2/+1Da3ywduWOH6eEzFWkuwwqWNifciGQCxL+VE1EGfXp0/sAmj68u
         WmStGlCUfg6tHLM4GBRBCmohG2PlFLEtZ5GiLj8MQBkrnSBd1bl+L6+HNS8snuP31uns
         idOg==
X-Gm-Message-State: AOJu0YyzzZqzQNzmyEyIR3aUaWflAxQmgBqJoLYRigO9JLiN3oFOvqfU
	OmUF5ZBvRmjUhHoywbFAqusYXcvQiNE1isixiy/NCCaRrLW4TtAl
X-Google-Smtp-Source: AGHT+IFbhWNupKrvwAGSnFWDjeSe9cZoPUsjPyOOJIkw+FEKV8BESH1SYxE56miKvnNiPQFyLoBqqw==
X-Received: by 2002:a17:90a:9201:b0:29a:c886:243e with SMTP id m1-20020a17090a920100b0029ac886243emr963925pjo.39.1708917786975;
        Sun, 25 Feb 2024 19:23:06 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:23:06 -0800 (PST)
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
Subject: [PATCH net-next v10 06/10] tcp: introduce dropreasons in receive path
Date: Mon, 26 Feb 2024 11:22:23 +0800
Message-Id: <20240226032227.15255-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
--
v10
Link: https://lore.kernel.org/netdev/20240223193321.6549-1-kuniyu@amazon.com/
1. nit, fix the trailing tab problem.

v9
Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
Link: https://lore.kernel.org/netdev/CANn89i+j55o_1B2SV56n=u=NHukmN_CoRib4VBzpUBVcKRjAMw@mail.gmail.com/
1. add reviewed-by tag (David)
2. add reviewed-by tag (Eric)

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
index a871f061558d..9707ab54fdd5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -30,6 +30,7 @@
 	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
+	FN(TCP_ABORT_ON_DATA)		\
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


