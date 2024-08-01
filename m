Return-Path: <netdev+bounces-115026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC68944E8F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4C51F2251B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4951A721D;
	Thu,  1 Aug 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWy1T46h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF81A99E1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524101; cv=none; b=DWtANLNPYanIjDUJ9CMxGd3nDqUzqMwEkAv4LOB9gO1jY4FHd5/EwQ8HIpclMPgl4zH5Y0hk+4NI26HlsyjqntlEH3ahNBZntWYnBCf48NvT0GYk2WSP9etA64ORccDV+pVtETkgaWA5VHKxq1GVLB3OOXEACYPQZVf+kvV5p3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524101; c=relaxed/simple;
	bh=g3fhbhumzkeNAkIMtG7+6lCFSXQXdNT2W0/nZ/J6upk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeXABqzgGAGGc2q886IkXUZ1m6oSBJbvCiZeRR2i2m5Np5gURj67v3dOidfLVgtDDM2ByJmbdzdREQZzBP27AbL2p2PQTZ52HgOgW7A4FM6q72pSdfe+q45P2YUgE85tWayN5R0QyrQEuoGK+jQBbDrof+EHfnkp3vY9HV7qQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWy1T46h; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so5121910b3a.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524099; x=1723128899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2L42Y3fxOPDIWwTt7ZYcTgRSPw4dmgExss+Yxe/O+A=;
        b=JWy1T46hkp1IraMxAxF4Z/L1NtG/4cTtIyTxhHcBtRLLCtIJz+W/+yyvkliYKhH9Od
         Vb19IofoqENHnEw/BmPw/YS5QaV5Z39D/XzoHT72t07g+DpWS53B11Ian1IjxnmKI3kV
         JKmSKlR8FEX5A5JC6rxu8OHN8EtjjeOpUd6ZbGE0PoTvk1eiDgqYQnR0f1reoOlKNrkR
         m5+n1LSUJM8HGbhMyFVPeS3yi3qTW6lhKYC+gA1lmUh86JB+CHPsW5jZCty77W5wuRM+
         ypzic97P1RMaKqb8ScSOOPA8mDAUV4VZOcP+GdAl98J9u6vQOqd9BOBJjJr8Qg/MktBs
         9IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524099; x=1723128899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2L42Y3fxOPDIWwTt7ZYcTgRSPw4dmgExss+Yxe/O+A=;
        b=NaSVUjmSeU0Djt26EIs1GI+dA3uZRekt0le/qXZOZlHZrSda/SIZS5NFNAkwkol+k+
         BUKOf6DaFw7g/w1t8pHKHgjukLP5MIR6bV8hF3tx83ga+jkg7JCjtAE2GVezZop7/y12
         Fu70VZzXfkQv2Zsb/v8sD+arlxIGBBTeD+nzXG3rEfmdu1fO+1J6zOUGgrC3JVm50eqx
         2Qm7WC+ybx4j5yT00uFkLOuiW7gz6DJZRAX7fIDaxyNKF7oPMfjBPTmoYRN2UsWTNmHE
         7DzFR0G8TUblrxZZPxSc1+3wpoBZa/09Gox0oNeRqiFN4VmMVvwqzS6ZwGQ8lQfziJEr
         684g==
X-Gm-Message-State: AOJu0YzNG6GvxsRhbTIJOBCehU5UfXqSW09M3u4fqfnopEU0aXbYINz5
	nOGWJH34lzsbcP8PXzP3rix58ngda5B1ULxSzB+IezpZhwgp5ND3
X-Google-Smtp-Source: AGHT+IEfb1BQlvGorvjcIt/yNR/Vgh8S1hYEMvgHG6C/7E/qf25T3D9Pa/r4uHBlMIbyeABm3fGO4g==
X-Received: by 2002:a05:6a00:1744:b0:706:8066:5cd8 with SMTP id d2e1a72fcca58-7106cfa3081mr579986b3a.11.1722524099037;
        Thu, 01 Aug 2024 07:54:59 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a35c7sm11611739b3a.200.2024.08.01.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:54:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 3/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
Date: Thu,  1 Aug 2024 22:54:40 +0800
Message-Id: <20240801145444.22988-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240801145444.22988-1-kerneljasonxing@gmail.com>
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing a new type TCP_ABORT_ON_MEMORY for tcp reset reason to handle
out of memory case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rstreason.h | 6 ++++++
 net/ipv4/tcp.c          | 2 +-
 net/ipv4/tcp_timer.c    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index fbbaeb969e6a..eef658da8952 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -19,6 +19,7 @@
 	FN(INVALID_SYN)			\
 	FN(TCP_ABORT_ON_CLOSE)		\
 	FN(TCP_ABORT_ON_LINGER)		\
+	FN(TCP_ABORT_ON_MEMORY)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -96,6 +97,11 @@ enum sk_rst_reason {
 	 * corresponding to LINUX_MIB_TCPABORTONLINGER
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_LINGER,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_MEMORY: abort on memory
+	 * corresponding to LINUX_MIB_TCPABORTONMEMORY
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_MEMORY,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5b0f1d1fc697..fd928c447ce8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2927,7 +2927,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
 		} else if (!check_net(sock_net(sk))) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 4d40615dc8fc..0fba4a4fb988 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -125,7 +125,7 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 			do_reset = true;
 		if (do_reset)
 			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
+					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 		tcp_done(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
 		return 1;
-- 
2.37.3


