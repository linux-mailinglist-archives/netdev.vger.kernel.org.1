Return-Path: <netdev+bounces-114548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C652942DD2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFEB283543
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B431AE870;
	Wed, 31 Jul 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa37+XjD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064E1AB516
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427810; cv=none; b=Araw8roPFYqPGHEiAlODzo5Xb/XUiWpWPoI0xGUF7oozvAe35h79x0TActfxH9icXvGRY+g95lO9w8JRaWXEkbDLIX2/53IbytP5dY992EZdZA0ih0ourKTUZnDl8nsgaX4HyPydXUX94NqNRnEYcLJgK13O44JqgmgDfIVsVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427810; c=relaxed/simple;
	bh=kfcSXfC5JcvC+7C0W1YUJMsNNRJUrr80jzzuWO2BF3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5Njt7/ujwTO3GK6Z4JGB0vSGLNbCTNYPQq5w3tyXG8on31ucK92J8txuuSMWwr4i0PiVvMtx8Fhr/CkMXe4Zj1m2QJwoF9P6mAAd1+FVddlnk1vRkA4idDTGDfOv0z9K7pDrg9u0Fredo61Bjzch/onaaW4P1ZrSYHXyEmNWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa37+XjD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70ef732ff95so2205081b3a.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427808; x=1723032608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W23wy756KJnEnaODYZZ3ycAfBd3JNd7g+sLxPmGmsM=;
        b=Xa37+XjDe/qnEoG6ssKd1obn4HljpszR7L72lNV4zQXx2EoHM8ExZ2Ma4+nfee3IoK
         MOG8tttII9f23/ES4J0IyR3aufjvbxa2yLULGI1A1cAhZr4hrQAe3pSbsIMcTEs5aWbZ
         diVamzn2Ls5kAB6Zv5rWMeaiPzzWkrKu+H5aF6X5X3M4oApgseyI236nyimlbPlhXh8j
         Swq1H1mET4tWyx9jULZY5tuQoX5nhw+McSg8YRggN895xdXD1m+rv0J49GGraQtsVl8o
         ZCw9yJtBZAoP/vF1QyZIoVCW7UTh98GS3SNA2MyzyOc/cKc4Wg82tpy/SPPwtQgF8FPT
         3lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427808; x=1723032608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W23wy756KJnEnaODYZZ3ycAfBd3JNd7g+sLxPmGmsM=;
        b=VO61PdQVVWLT2M9Go/iYVTmi53UN/J+xzpbAkRq7CKwZ/W43isquGa4XlPsCgIQtO+
         7baEaltaVCV809kgBInhQhXlt0yPmMnqJFUWI0C7L7y0/DIM2xnttbxVrNWUBOeWH6MJ
         lp94bdnHCiNylf5Qtil3WJ9gEHvjX0UVEHfhNeOdVRBJuLpzxM+UjvGuhoBs9SC0H++u
         quiOYm7o6LJh6pq+4ifiFeppAaWX9FHYcb5fFJUft9puz0CU914YrQExcQ3aVYvEOIJl
         G0wrHc9SsdEhEbDQ5TLivFWAA1DVROdaxVXM7Bzp6av50y0lcmyG0mKDf78/UrLSVohc
         AqEg==
X-Gm-Message-State: AOJu0YyZkxPj+f0XmoatNuHgBP2DH0xaI3BQgleoS4KEtHqtE4Ktpq+e
	YMCQn01G4CImmO0qO9laAsJtygupd5OClvdvSWBE8vKgLAxSIpL7
X-Google-Smtp-Source: AGHT+IGtAF7Z2uoGk41gY7gCdHi48Rqp/zJre/uI1OvsKaVV5WWXWdpJTCNeHu5C4tU2yELI98lKfw==
X-Received: by 2002:a05:6a00:1910:b0:70d:2af7:849d with SMTP id d2e1a72fcca58-70eceda313bmr11540578b3a.23.1722427807973;
        Wed, 31 Jul 2024 05:10:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/6] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
Date: Wed, 31 Jul 2024 20:09:50 +0800
Message-Id: <20240731120955.23542-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240731120955.23542-1-kerneljasonxing@gmail.com>
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_CLOSE for tcp reset reason to handle
the case where more data is unread in closing phase.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 2575c85d7f7a..fa6bfd0d7d69 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -17,6 +17,7 @@
 	FN(TCP_ABORT_ON_DATA)		\
 	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(INVALID_SYN)			\
+	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -84,6 +85,11 @@ enum sk_rst_reason {
 	 * an error, send a reset"
 	 */
 	SK_RST_REASON_INVALID_SYN,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_CLOSE: abort on close
+	 * corresponding to LINUX_MIB_TCPABORTONCLOSE
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_CLOSE,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..2e010add0317 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2833,7 +2833,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
 		tcp_send_active_reset(sk, sk->sk_allocation,
-				      SK_RST_REASON_NOT_SPECIFIED);
+				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
-- 
2.37.3


