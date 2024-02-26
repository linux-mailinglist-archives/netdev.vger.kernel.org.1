Return-Path: <netdev+bounces-74803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09808668B2
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 04:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BB281FE4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBF134B2;
	Mon, 26 Feb 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc2NIcNl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B314263
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917773; cv=none; b=caf6eEwF/zvu2D/20PLG0PZTjIyc6t20g2CPwSme/h1sSm+3DtS+0lBEYw2Ghq2wBTNRJEa93osApVXkqOdAoX3OJTXYKxWTY8olb+BRwqsK2E/LoDz5XBfsy8sNuhdhZpwrc1PeEbLXJISvjZfy6Fjd7L7b9ghvuePjVnIRdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917773; c=relaxed/simple;
	bh=J/mAy7it+D2yD+hqcIT0b27b80IhoZe5v8+aEV5Kesc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUimz6FIaoIyYxA1EFjZAGm71MqNT2te20xVAmT+7CUkmpVpIu5C8gPlj1XfRcscejaFXCD6q8aPV9XNOciaFw4ujh10WtTHjpg34mIXCFJ8s+Hm9/xgzVHursGJxt5angQcUjM+aqNq+JnSt5ly5NNYnpCr8+MPaOUy3MRcdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc2NIcNl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2036625a12.1
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 19:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917772; x=1709522572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2MxW//NuJvbOxIgqnwV9AwctPjgUYVm/k4pGlCFbrs=;
        b=Lc2NIcNl6O9+ciENTDBWOVJmymZDTQ//Vk+mciXnGp6K9rEETbUAYJ+E5meauG1rsd
         Chha/3TNHPBAG3bE4oii65zwLOyjLCJAcb65KivJtt9NI6eM7u+O/RB0mFPHnMWNZFQD
         bW8P2Re/W5TLkn6CH8h+SgkmQOlA8/TLHFUxfFohXXFb33wVaJdvQm0gFHm9cfnnkR5F
         0BS34RgzE/iuQ4mN1ij33x3aXyKvWIAfthKcYhpUCW2Cf39Yp+J1bvIOYYXnx25oaWMz
         AOCpVJcGU53VicDg+5cwmJzjh87jtEVLphpBM/DM9QCWcTUlDiwEvAYrCielP0i13Ogn
         VN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917772; x=1709522572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2MxW//NuJvbOxIgqnwV9AwctPjgUYVm/k4pGlCFbrs=;
        b=IS8OtDDQNmeV354itAC/oOC4cJd2m5plL8S6PYTkbIHZIBizXC36q5jHf4AkIr25Yl
         lQoDQYt8AvGLWJzAmEtm1UZnGNvo4cWM4DTP8A7vQv8JXYvERg8ji+gzp7Kjh8qgwOTR
         EowShVYcdg4fftpI+c6z44FnLByAfFLmOcXHCekt+Ajr7Awdk+1duFj2zZfuuFC8gqJR
         uPfdJEB1Iqs8xSH07aeJyp1MUziL4A8b9UknUEpyFupMRjngGe5i2AudRFJKcwFvt1Tp
         n/OhSdnUrU+Ar9699nKsvVXYAhApQc89Vg0TykBCrQivRIoYmQNHACGP3HBooOu1KtMJ
         FxYQ==
X-Gm-Message-State: AOJu0YxxwVRdnaN2XomzUu74yAtsU1J2RlWosdEQYSxsHDJz60iDPdww
	KJ9OShfAZZjaBzOqQIzqZxS/aZbCipmrC9EEXJpxH5uga01sCFH4
X-Google-Smtp-Source: AGHT+IEOadXtTh3JSG04gw7M0y3usO3nRwAz8+ZnKn7sdnFE+OtGvmRo4aPBfl0kliCN1qjKTfIo/g==
X-Received: by 2002:a05:6a20:4390:b0:1a0:e80a:b79e with SMTP id i16-20020a056a20439000b001a0e80ab79emr10201946pzl.14.1708917771754;
        Sun, 25 Feb 2024 19:22:51 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fr12-20020a17090ae2cc00b0029a78f22bd2sm3262521pjb.33.2024.02.25.19.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:22:51 -0800 (PST)
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
Subject: [PATCH net-next v10 01/10] tcp: add a dropreason definitions and prepare for cookie check
Date: Mon, 26 Feb 2024 11:22:18 +0800
Message-Id: <20240226032227.15255-2-kerneljasonxing@gmail.com>
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

Adding one drop reason to detect the condition of skb dropped
because of hook points in cookie check and extending NO_SOCKET
to consider another two cases can be used later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


