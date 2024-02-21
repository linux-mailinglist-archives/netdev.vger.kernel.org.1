Return-Path: <netdev+bounces-73535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569585CE67
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CD3282B76
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261F52B9DA;
	Wed, 21 Feb 2024 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQgGDpCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21132B9CC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484289; cv=none; b=iecPNKbITg98q4l+WbQt8cXaTDSZ5SlDHICkO1jWGBJgAmWetId3gCWuDgtceMciNjd9J24CmmzezHq0E8nZVhtLbcareJgcOEosmgLtObFhW+arCK+0DWdfjvoNmJaLDNDW/Vpmw1jUlvaWWU0uujHWWheHYi5Zu5ukbM3Rle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484289; c=relaxed/simple;
	bh=7Zp7x785+/uhxiU2Ik7D9xJ4gfhXMG38++pvy5SIfvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTtqqKFiZe8oTGnOuc2+DRM6gOYpWLdv3K9VNogVZAbG97t47rZprZ/Ijb8Va4cQuHhIvqTe5AtvBIDSGmAOHESfGUCCVRipzJe9+YYJ8oQGTMQBIHtr9UK2r+h7zp/f5HO+f3S9yaCw3isqb2NeBnQhnFiNup2UeA87YJQpRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQgGDpCO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2998950e951so1751267a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484287; x=1709089087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMelBBUb7lQfw+CAX9NdYFLemt4g519UfusTQ2lvYJQ=;
        b=AQgGDpCOKKBzMONteZt0bDjLyDXBiCdNpKkXw2TUbwK5hMuxTqg8MOVcFMaviDs2yL
         dVlvKQsyyGFMkWK2C8HQRO3l7x/+vDRptD+oi5vb/lo1LmDrJ+endN9kEatdY5W/q4Z3
         daVjXLfwk2Me5RcqtxP7vUgco3iHphmDrCtYfYuuYPjC58xoKvVf86LDGW2ztv4hRkwW
         /CKtEmHV56YMbOaH7xcqbG/CQ4uG4y3gHqXo8te88TQJvMq6YLdZITyNE7cbE8RrBJnL
         Mzpqy8Q7AD2Mc+JEfzlZXuVKySjPJtJClzUJOwJPQY6xwM9G/YcRYsJwhX+jNz/Q3ziX
         dcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484287; x=1709089087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMelBBUb7lQfw+CAX9NdYFLemt4g519UfusTQ2lvYJQ=;
        b=getzjrh+SBPOXQNWDyZtWJuhnrEiCiboyzjAP4tsU0S7DbaCK3ygQ3rDD6YF55/642
         6AxaBzi2P2EBDGH0hfM4+0cq1OcEwpU2sgyg9dCpxljteUo6oIo/X1tdljpCzWgkmE6G
         aZ80G526FI64PmaulfogNwmjlL9LX8aw8QNLJ4A0u3BjzIo5NbLrvmsovPm7qXhXHf8Y
         oKOPctwhIkvswPpSVGLOV1LoXUwLs0JtIqMSe5NJhnDABzO4nUDKvgXTIRmFihFuY1mR
         9glomOjvJHd9eb+/nyE/MMepLh5NXmLS4dHwFDnHEJ3J4tn15zic2do3+sO2pJWX3fMB
         4fsw==
X-Gm-Message-State: AOJu0Yw2t7kZF3OeDEGG48CyUadVYDiUsRZNbUWwxOb3LgbMXDNOfTyX
	QBwMx4xye+KkpPFRMKmw1vyCI07rabAZpZf0UCGdrhvsK96leQJV
X-Google-Smtp-Source: AGHT+IGkRmFlWYiqdVJQqLH3z8pxqvG1SU6CEvDCed/fJHI5+H6YEawdQJV+Jum05XxW2StGpQ6reQ==
X-Received: by 2002:a17:90b:1c87:b0:299:f6a:98b with SMTP id oo7-20020a17090b1c8700b002990f6a098bmr12310935pjb.12.1708484286984;
        Tue, 20 Feb 2024 18:58:06 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:58:06 -0800 (PST)
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
Subject: [PATCH net-next v7 06/11] tcp: introduce dropreasons in receive path
Date: Wed, 21 Feb 2024 10:57:26 +0800
Message-Id: <20240221025732.68157-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240221025732.68157-1-kerneljasonxing@gmail.com>
References: <20240221025732.68157-1-kerneljasonxing@gmail.com>
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


