Return-Path: <netdev+bounces-73530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ECB85CE62
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10E21F2338D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960128371;
	Wed, 21 Feb 2024 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOcDtuzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6332B9C9
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484274; cv=none; b=k9ZsffdCyHJJ3NVrBciiMDSW/nVms5hxdMIyvKs16+oioeGWVv9jBNyDMKakpOqKE4e9VQNKbv1htIrCg5Ajp+7FtA48+/3roQseKAUuzGkHzTwyzOic2rrd3hECa4xrv3cBzHJxcRgUAynFeW15QGq8um79/sFu61aEXYOu038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484274; c=relaxed/simple;
	bh=1tlFmQ3I4YhGa6kxyiF8aijgBtLof/ukfg3x85afNSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCscQCC0D+1aN6r05HZQs/WWWYGng3IGwpvYd6SBGIcwqiqi1xDV3AugNvxYUC2wAhaqnmz48XuUiA8jsdeUy4xIIcjdAE9LUfFd4Rx5cNOtUxGEIXKFHstk+ioKIgYv7NrJ0fvopi6cxqHa0m+LR+971i6j9QyCi259Tr2kGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOcDtuzP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d751bc0c15so55817965ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484272; x=1709089072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1sqTGaVty/GVaHDXUz8Tx4GLUTtAFIwAB6eTC+DZxw=;
        b=TOcDtuzP0tm2sFHC5VXZD0hjWLtuVb+U3dYwvR8qoRsVdzk4jOMa0BCawrzCK3fdeQ
         N0Nfp2UDgOjv8rmOHpIWLFh/XjznXkymMChtQ5s28n+CTierhiSVS+xLn+/Qn53mCtKV
         LUrBbicj8+uyzNYIr+WS4dMOEVH0D+qtmZNRBc8nOPzJBC0KhUHQPtd5QTyc+9mNX9ik
         C8AaRM1GwdWHMXCAxhqqZI0cMx8sYYPifYWCySmorkUfXYMhAyZBUJbdHq/nMlfID8JL
         Rqf0OLKPttsIE54Ze+PNFNCgQ31SK/2DIX/eXrhSL5TmhbeeMAw5sveXvxbxxyc9YJGV
         SLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484272; x=1709089072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1sqTGaVty/GVaHDXUz8Tx4GLUTtAFIwAB6eTC+DZxw=;
        b=W0Zxu2kpzHUcdIdYJKP4Aq3p5SuQ0md2ChvcSIghSR6/ikX2jbuEnCBYyd7u88+LSW
         kakftsa2MSxbrGo3Cwn5RgBeMvR6B58nP9Ks+QKrTfKCdFI5anHsMRtqjrSYV/cXoqxL
         W3FmLve0SDgqsZ7B5zO8UEGkVLtCtMqYFg8GaPVYKe4TnsnCwEdtY19UKLFSaHRrUOSc
         1Tk6sqTz34OzXbuF52SO+4WfvYj1GOCajMCY52/5DdIRBzGIujvgCnkerhaThDb2KgFD
         KdVpSbbW/Bj3jbQVgX3cOthI5580q1HAf4G93XPs5/cg/U/jT6cxZSAfdaJJiLZglEeD
         Z6wA==
X-Gm-Message-State: AOJu0YyumsPSrLsk4kpnHy6LO4Qm8iNRzandVXwExLQSi4F2Od5QeGgw
	cEG08tuZSuUJSFzTXAngdoRYG8hK86/ku/cd0QSjdmyBYHl2lgUe
X-Google-Smtp-Source: AGHT+IEGHydPg1B0IaUp2jm51DQBy2fp3MdYWiA9VEcMJPNyPh6jN3waFWFpvOquVw5jnKdMk5NPGw==
X-Received: by 2002:a17:90b:1990:b0:299:48de:9c7a with SMTP id mv16-20020a17090b199000b0029948de9c7amr11429297pjb.0.1708484272294;
        Tue, 20 Feb 2024 18:57:52 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id pv14-20020a17090b3c8e00b0029454cca5c3sm426467pjb.39.2024.02.20.18.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 18:57:51 -0800 (PST)
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
Subject: [PATCH net-next v7 01/11] tcp: add a dropreason definitions and prepare for cookie check
Date: Wed, 21 Feb 2024 10:57:21 +0800
Message-Id: <20240221025732.68157-2-kerneljasonxing@gmail.com>
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

Adding one drop reason to detect the condition of skb dropped
because of hook points in cookie check and extending NO_SOCKET
to consider another two cases can be used later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
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


