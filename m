Return-Path: <netdev+bounces-115290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E3B945BE3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674A4282ECB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715381DC47E;
	Fri,  2 Aug 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO22HZTr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47914B962
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594087; cv=none; b=rjo0CDQiDQYIdt65cHMtBgbdCs7/UazMmQCyeEpRMXUUVSlPQBFEs978aYDe9Smu/aSwuz5aGOFR8KISTHUqKa2sMA0DPIiC8CFGTAnFEU+SsnS4jxdb3LZ5/UQKHI4sR1+ikuW13M1dg4JNo6KSwSWyPGwRxqq2jZp0T1LOh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594087; c=relaxed/simple;
	bh=bB5quX6hf5roJw3OqlmFW9vud3KXLMbEWmO1V3KzOcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LB7W4+7iTssFVpXJat//F8vSz619ufJ1ObZaxI8Q/tosMU6SWhFU3XIGkeYrf7S5l5+hbJfGSe8QAP/UzW5dktqUPZBRKfHZXmW5zYc5qHvoL5VUCmDV9NtYiYCtJiSz6u6ex2v6tOm9hhvwAegfz/HOl1c/ZMCwoM3BDRIJKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO22HZTr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d150e8153so2114539b3a.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594085; x=1723198885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgif6oVSTEITP/o4l4CprEQozCE/rlgITlHxlm8H5hI=;
        b=GO22HZTrYoHqPzixAf0tl6i0vvp5fVG2daRAOtdStGj6e2C/HZ3qE5zhHupD0wdNX7
         TbkV72Vc7ORkEv7CbWAHLEzU6o0c7GTDPDfvcr+oU8dAKmMYTd5gONIPW4l4t5sTkkKg
         jmOBYwoWM5XA57orsTeJfEmRZjnA/gPFmi8OrhVedAEu2QK3MneLtJQdnVgDxODiANXB
         RG5U2QWymImp+HBGuHVHx4z5+3ZweF3JNBsnqoHUBNFUqxK2sbKFaX7HVaVMTye89dYm
         LQ94c8/B1iI/LD2t00jVA63uNfgEkcj7IFhj7WB5vWodykU30RHo4Wpykl1gxqvOl/CU
         BIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594085; x=1723198885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgif6oVSTEITP/o4l4CprEQozCE/rlgITlHxlm8H5hI=;
        b=fbLhD1l/JXcovbTkAxufaFx8v9sHRuWMveqfZmpf6+UbKTVPfKesd5uxDNKN6Z2Awv
         hP2nprulubXaMDxcuZ4oyK2sgd7XV41vsS3X9xYwJ7aSwFog9OEizOVBb+YvW4GGqYK9
         R7w8eT7RZ5fmFFw08DDMp2HLA4TcJBR5Do1Q94l/LhrW5IGrL2yjQ6TZtTQrKnIHKy3+
         oCDbNr0EazfF2YQhNFTAmVWLGMvyMdiz1Yq44lFunj1Xz9CrB4sjfSeu0upapRmIe0Lv
         oWhBwQngMx5VGlGsb1ka0hlFflWkE2ME1O9rpiAq52jyVUCFfUGupOu+jp/rpIVPOMa7
         PxXg==
X-Gm-Message-State: AOJu0YyDdIceAd2QIBnPXZYbENMEVwf/XTEflFFbJyGP9ovCNXcNVICf
	R0/jEWQ0IJIuoodDcWQLcwPnryCBCg66vxFydLtpbzdMw6cxY9EN
X-Google-Smtp-Source: AGHT+IEsBu+JISJoGDT4pX/YiVo6orwMLVWkQcMBQgYj8Acv3ftrY26Ad6R+2LyeUPP8WXp1W3+N/A==
X-Received: by 2002:a05:6a00:9150:b0:70e:cee8:264a with SMTP id d2e1a72fcca58-71065de1a9bmr6973560b3a.1.1722594085056;
        Fri, 02 Aug 2024 03:21:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 2/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
Date: Fri,  2 Aug 2024 18:21:07 +0800
Message-Id: <20240802102112.9199-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240802102112.9199-1-kerneljasonxing@gmail.com>
References: <20240802102112.9199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_LINGER for tcp reset reason to handle
negative linger value case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fa6bfd0d7d69..fbbaeb969e6a 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -18,6 +18,7 @@
 	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(INVALID_SYN)			\
 	FN(TCP_ABORT_ON_CLOSE)		\
+	FN(TCP_ABORT_ON_LINGER)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -90,6 +91,11 @@ enum sk_rst_reason {
 	 * corresponding to LINUX_MIB_TCPABORTONCLOSE
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_CLOSE,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_LINGER: abort on linger
+	 * corresponding to LINUX_MIB_TCPABORTONLINGER
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_LINGER,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2e010add0317..5b0f1d1fc697 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2908,7 +2908,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_LINGER);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONLINGER);
 		} else {
-- 
2.37.3


