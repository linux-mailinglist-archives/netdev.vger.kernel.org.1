Return-Path: <netdev+bounces-115289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57693945BE2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF9C1F2283A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A71DB45F;
	Fri,  2 Aug 2024 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzAUtB8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897D14B962
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594084; cv=none; b=FPJQDajPcG+P65URCeT1pm8NdZx580Gpk5aboZ7Cny3c4VbXocrsNCQar6VMg757sF1KIowvs0JI6VJpNZRqlGaXZGSV8KfnoDfq8byRcPGGeyAhMx7VdSmjT7abqspvaYK1MEqu3QDv0njjOYIEKDBmJeNuhqfnye3DtpE2gD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594084; c=relaxed/simple;
	bh=xmrNaBt5a2CwB7pE8jwMkJ9DwMXjVuJmHd6iM+Z0v4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IiBZf2Xix8yQJL3zRsq42AVM6dz94wj5OgTzMq5yatrGtSSSNBoYQLA37qQtKlQJCqeNsIXeP6dgTazdJL9c880eKm9NzvjNDX7Hrffv2fB92RXPN/4Lqx4PL+MH0lHg0SCZgseHSjHnnJEXYYewRIIWOK18yIkb7O2KqTk4vOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzAUtB8D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so5850985b3a.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594082; x=1723198882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65OKnjJuPQeRm+91VoYodiWcGDqklxrBSmzt5OD+SFE=;
        b=bzAUtB8Dnxovg/M3y037Tgtt2ZbsNc4oGYfB+dtRPtz5VW7LKktDaHSFnd+Rzy1oKp
         Hw1+Va6PdW9Svk6bVl3GMxiHXqyOYKpSFzNqL2CRJX1P+abDfvGWJXLkODSoP8Ny/KvQ
         3x/OIYegUSmcZk1f5mobE00L05HMXhhQttOiisvz9HimbNZpGZBZsvXBJScv0US1l69z
         QnAx4mYJXxd1g7gmX50SKipAKxOKPQ/d57DMzcJxjW1oi3ONdASgxaGUYwSshuJq5VDl
         ZeXioM5UMKsgiNHnXLVHgDs7dQmFxWFYXq+joOnBZApXQ09C177PoeWvR3WnA5oMSTxZ
         2qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594082; x=1723198882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65OKnjJuPQeRm+91VoYodiWcGDqklxrBSmzt5OD+SFE=;
        b=dIHBcDKMcJGdLu7bmlX91aXYK8eo3cGVUtZivgovo6JMw13+/4WaSe2UoGWAZrZecf
         6LjSVZtsMqdNLVzdPly3ua5SfAAfY3bgXmvA1bTDYQmUY1foAXxXiLkZMvGpluYoV95f
         JN9NCHph0b2fE1u/rccb4E/urr6peoH61Zj0ECVtliMgg5IAFLW6KxuaLIY/pdb0Fzds
         IPgDLKoTL4vnZav00LuKyio592g6+GDWgxFTEiFRKNpumKGVHIN5ClMVUzE/PnzEE1QK
         F46VYU49MdqiJ625T9FosEmeKRMSljpCErou6vR+GRpBe4Ifaui92+zPxIhb8Aq5LrDH
         abGg==
X-Gm-Message-State: AOJu0YxanWBbVqt8qF3L1mZBz+4Zz7ihDiQcPMrK+Taz1HOET5IjmZJM
	DTrxUnMhOBQHgVNga69aOUkIw2YlRnWqd0t+eNT3EXZiSBaN8vUd
X-Google-Smtp-Source: AGHT+IGPEAV7vuWRdz++sY7EpAHIYk8Dv7YlXghHrfrlcpE77Jomiif7BDDK3UkY1R1lakeWaOHn+g==
X-Received: by 2002:a05:6a00:c86:b0:706:3329:5533 with SMTP id d2e1a72fcca58-7106d02fae3mr3669516b3a.24.1722594081841;
        Fri, 02 Aug 2024 03:21:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm1109050a12.26.2024.08.02.03.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:21:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 1/7] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active reset
Date: Fri,  2 Aug 2024 18:21:06 +0800
Message-Id: <20240802102112.9199-2-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_ABORT_ON_CLOSE for tcp reset reason to handle
the case where more data is unread in closing phase.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


