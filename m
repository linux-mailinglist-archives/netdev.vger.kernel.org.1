Return-Path: <netdev+bounces-74345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E120C860F48
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107681C20F77
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7345D755;
	Fri, 23 Feb 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUSlOCRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37275D742
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684185; cv=none; b=KNdQRlmqPv6KvSK5a2Tmdtekxq/d2daePTIuVAtchfoLlJvPzfPL7lzyqueSqo5WQOgk5jJfGWGA77slOzyaBRzkkfLQvxYh49fMK+0YeRhOmxf10KISlKOljhaTg7WmFzHcXHdSxCweyvQWb9Ig9KowDSiZGbdk2WvDn89tuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684185; c=relaxed/simple;
	bh=AREo23cwfwzchyqwHLU3RqgiUIuL0S6YBbBo6jUuBSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I11u/n3qWZUJef+YuKAxrQMklbzh1UObpwrC8XL97QHdqVomvrRUur6Bl8Vq9/1A6rZ/Nh4Nymyly9QYBuzjPNFS3ivCefjP+1jHk8eHYlHldgDwsfY44BTlkJxuHeNp/HW7eHWdkcE9J2vvVRRSyIbVp4bXR4lXvdc4Gnmh1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUSlOCRm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso5133415ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 02:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684183; x=1709288983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inDueKCVz75DWzfXh5jhlCQ4SZ0ppOahXRbM39RRwQQ=;
        b=BUSlOCRmf4Bq3AH4Fy1VIRRaNbS4RkyrNWNJay5bNXPJKzD+zcFo45Ap9u/Tl7vXOb
         OaCwUOKTg+BOD978hIg+mteqVprcYkII8s7+iYCkerUix6/C0REDgOgP8oaUB9s6Fl4H
         H6s5Qv1IV1CVdkep3ocjJOz62+iUWsItYlVJ4ShEBAGfkhuJ7zne5io7AzU/OHftz4S3
         W2G39MMbJbGYEksACqljeGUCVY7Lh+hjND3M5IydL0GS6q2456GIzdb+WowO6Q/gorac
         D3Up6M2LGBeqkCulGLQk4h0dIU5tDq9Pmzf3KtxM9c5yOimDbJR8Ed8PKlsnVDs+FffI
         m0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684183; x=1709288983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inDueKCVz75DWzfXh5jhlCQ4SZ0ppOahXRbM39RRwQQ=;
        b=GCVuFXja7JE1xCUj+Jj6qbTD94nYn2xd4Ck8ZXQmClWRPlLBImuf2OZikeRG4nOc8R
         1jwwndd3QNrkfB/b4v2gFkX/6MGCTQ7dHxukD9wOO0KeHY+N59/bfpul1RSm1CBQ+9eA
         bG12SU1GziM/9SnYnxRKP1RRZ7O8II6yjyTN/BPC4TBUZFYYIJU4K9q1AjH2AUlVy8Fx
         qEMNuI6VvOzk62tnj7nCv+n0ukpXpNO+fEsS0c0y1i5vCWrvGx5fAZ5x3h2GqqHVHmU5
         DUTl6LzpBv8UjeW4VTp3ucj7MfXyI+3gK9EAgNF/Bnszgny3yt+AmMQB/KtSNlM6cpHu
         0buw==
X-Gm-Message-State: AOJu0Yz2oC4GoOKC96aCVhPV7kVVwvo59hvhKBzfVeP0sR5Z+EReMuSt
	W4yeH1pT8dWElgYtUCGmp7Ufy+Wf3q1b8srj24g6yajBEXN7uAFx
X-Google-Smtp-Source: AGHT+IFzqxNpJyNO8qARXKtPaPLXGjVfuSpS9m9ZJy5093Q6F0/QLH7r6zyEO7LUi6dTPgArdiP6ug==
X-Received: by 2002:a17:902:8606:b0:1dc:9dd:961d with SMTP id f6-20020a170902860600b001dc09dd961dmr1397541plo.62.1708684183094;
        Fri, 23 Feb 2024 02:29:43 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001db717d2dbbsm11380543plb.210.2024.02.23.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:29:42 -0800 (PST)
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
Subject: [PATCH net-next v9 06/10] tcp: introduce dropreasons in receive path
Date: Fri, 23 Feb 2024 18:28:47 +0800
Message-Id: <20240223102851.83749-7-kerneljasonxing@gmail.com>
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

Soon later patches can use these relatively more accurate
reasons to recognise and find out the cause.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
--
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


