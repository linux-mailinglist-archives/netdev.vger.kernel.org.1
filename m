Return-Path: <netdev+bounces-94919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF848C1034
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944121F23B21
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58746152515;
	Thu,  9 May 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmkwwJkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E06E60E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260415; cv=none; b=QvDZeYREUAuU9WjMzWed67JO05rFyj4FnqD4rKbBjGglV6darhIfKZcyzkO1E0cRlTx6wQncylrKAVwTqF0QC+jfeSMW8+geKOjhVibmJ+Ir15UyErB3LNJIw11h5oseBZTNZAjI1y1oucAdeIY7hhfJlS2HmdOOSC8TRx+0MtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260415; c=relaxed/simple;
	bh=knq2CZJ/lIONxBGqA6bIZQPooOdPRX2qxDdFxQ3HazA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgArNAROG10a4JQo9P/RJA5vVZb0dOMYpcQjN98+4LB3gzh66WAr3TxzwhVBuZIA95WzZddAhAXrxOLh7pm4iDrZ9pgHnGOyTcC+FRN4oKG2d2X+hMC6WhuAJr8tcKchX82dzvnf+fuOjaDa0lQTIf0+K5WBrGBvQqp0W2e7NKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmkwwJkR; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ac8c73cf88so475107eaf.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260413; x=1715865213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ALCVOOSj+rqcdr8A1Z1U7kRca9PY4A8EpwP1XC8Nrw=;
        b=bmkwwJkRehWgPvdrQqgVRwQh91qvrbGyO4+nQWqiAwDZfmkJ8f3NCDci8iKGCagInb
         4mcjAMX8AA6nwa9YwwCvbHCmAUnM908KhrsakCJ8T+HUlQPRvIS1mZnMHecbyv8g5wTT
         /fPJeTq+mIErVsu/Ul2/qJ4D7imbznStpLV7/S/gh3vhFysZgOYIFW+WKaSrX7DiZW99
         R7s6BQhyZRxHZXdJj5D27GHm0TjviOYa30L/IavAwahfJITrFjQSTr0PYTcyhtMSQQF8
         55koabfL/O7sD4OQ4coo6WQ9umpe9OyFS8VMgNZmOblhzIJcquxdFv7Tuyd2U3lCt6of
         cFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260413; x=1715865213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ALCVOOSj+rqcdr8A1Z1U7kRca9PY4A8EpwP1XC8Nrw=;
        b=s375Fz4/NRPPbXSn3XaKEk6BXaeCA+Td7gK/gyDr2jSGWTnCQwF9xH6WC+7XPJXmTR
         MgwCmQHpcPHUooElKJfGaluYPunR338JGVeZhl8Xb5vpV0dajzUwxMkK4+lPFs65jzQP
         T+IlmfXEwOZXI5uJT7NW9TQlmf1Xzk4wq/u6I1LTnG1KJ9UhHJgt7Qqw1u7rc68qDAsH
         5mF8trytb8tgXMnWQQqZl46okkpq8wtuaYYAyl1dT7V4b046EtLH3nz7bSqd1jbr37fp
         YnSXNR7mCDYRdriVftYLRweOa8dbiR9HR0tOBqunZ91whGLZ8mVEa78m8V/xhGAStcXT
         x8Dw==
X-Gm-Message-State: AOJu0YyRf13IiW6fYqstgdeECtq2xd4ynbtgXRK71h/TAXWV7krm5REQ
	uPHB3Gnt1NXj2lcVWWaimlZ+6YPwJViDSVnECFGrpBxvRWRuhPrq
X-Google-Smtp-Source: AGHT+IGNhto5HWdEdUYmo6+zaYBWdeiplH+2dvFbY/piRJSSz2bRta1MvFUx/cB2zqGLjEVR5vddaQ==
X-Received: by 2002:a05:6358:910c:b0:18a:8e58:b992 with SMTP id e5c5f4694b2df-192d396f526mr674015555d.28.1715260412712;
        Thu, 09 May 2024 06:13:32 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346eebsm1133887a12.84.2024.05.09.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:13:32 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 4/5] tcp: handle timewait cases in rstreason logic
Date: Thu,  9 May 2024 21:13:05 +0800
Message-Id: <20240509131306.92931-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240509131306.92931-1-kerneljasonxing@gmail.com>
References: <20240509131306.92931-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There are two possible cases where TCP layer can send an RST. Since they
happen in the same place, I think using one independent reason is enough
to identify this special situation.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 5 +++++
 net/ipv4/tcp_ipv4.c     | 2 +-
 net/ipv6/tcp_ipv6.c     | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 61855d4b27e2..62e869089da4 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -15,6 +15,7 @@
 	FN(TCP_FLAGS)			\
 	FN(TCP_OLD_ACK)			\
 	FN(TCP_ABORT_ON_DATA)		\
+	FN(TCP_TIMEWAIT_SOCKET)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -69,6 +70,10 @@ enum sk_rst_reason {
 	 */
 	SK_RST_REASON_TCP_ABORT_ON_DATA,
 
+	/* Here start with the independent reasons */
+	/** @SK_RST_REASON_TCP_TIMEWAIT_SOCKET: happen on the timewait socket */
+	SK_RST_REASON_TCP_TIMEWAIT_SOCKET,
+
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
 	 * RFC 8684. So do not touch them. I'm going to list each definition
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0427deca3e0e..d35cdb77d7b5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2421,7 +2421,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
+		tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 37201c4fb393..bee26b961835 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1999,7 +1999,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(drop_reason));
+		tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_TIMEWAIT_SOCKET);
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


