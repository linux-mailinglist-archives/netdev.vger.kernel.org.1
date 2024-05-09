Return-Path: <netdev+bounces-94920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950A48C1035
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D6F1C22A7F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671215217A;
	Thu,  9 May 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lulL7ZGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A21514D8
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260419; cv=none; b=oHf5AvDkDa6xD8/xvfHBT/Bo1zXgiZyozwHLEXYU4iI2rH6dm8K3QIpGgLWADmv4w4/as7EsVHB2R46yhw4BvP4gc/h3objJE9NXzO3/QLWjMaD9z25d3zDOxtpsJooNBovCItiahsfgGQ4H7/3VXaxHWQ4yrcqladGZoGcnzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260419; c=relaxed/simple;
	bh=2rvYE6PluPzfpmoCmQHw0C2gV+bsXw+3M14T1fkC7KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AU9PMZ2CqKSSD9KsYSQGdAnIrbv6Srsi7LbNFlHFDKckt3WSnrhElb8j32h7c2C10aZvOpy0KYsAM/mUri2ZuSugID8PFt/XDPdtpqJnUVQjj2ml6W2sCedUJ581ysZkNWzjFqDduDhIHhtk3TtMJqav/VolnFJc8+HvsQjR//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lulL7ZGx; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36c5d26045bso3908925ab.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260417; x=1715865217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3w8I4AS7qJEwhuYtp9u5CkKL+sAa1rhMt6gkPETXNo=;
        b=lulL7ZGxnvWsYzBXTQ+GSLUOjz5YeQjDCTWGyP4wjF6SA21yW9aPP+AH653PH/wr3V
         s6FWwkH3tLJWJRrU99MQXrgWaRDIt5IR/aPQpN0+acVHQULmJjW/rshCF6Nu5en9GWLV
         eOfH3EBZ8nvHVdFML4Tbl7+AZmeEuDZr5ymsvFopCFAPqGV5nzUYNiDZPUVwbRxR7jjK
         SGPThjMKFKSaVCsgAztQJ+1jcM6HwioaXo2QbVLmoB+di5Zsw1rsTeTPl1+vktG1LLgr
         eEBvQ71wfsC1HbEIyaPqWuzdDEC/PNiaHW8TPlxSlbr6tqxlfN3fccthi0v4gLCMppe3
         5yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260417; x=1715865217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3w8I4AS7qJEwhuYtp9u5CkKL+sAa1rhMt6gkPETXNo=;
        b=Q+BdZItJ6d2sNbQnEMFvJdxA+/46CKzWXESG0mIXuECFBzidRQgJ9GThCNWkk/anrs
         ePhWCfDbei0ZcBY+585+UFIo6dcL+zNeHytBKfsX4Ey61di+ATbfus7v3H8HY0A93LcR
         ihhXmBpbJVhxEtDdQfYUXcQ8Ip+du6K3zJbDvLXgC029pNPOaSl1P/8v6bGZTrNlP2Ur
         Wq+ZBhIKKond/qeycK/5zCZtBhy1qUCWR6RmI7J8AScuf3uyEZWY6GcrHHP0jRNYA2s4
         Y29r5ViUvMZWwmbNbtoJ9U2m/QU0ASD4afhMy38VZ+cXGh4LgmuRzGinuX83NphDm81q
         hyyw==
X-Gm-Message-State: AOJu0Yzm1mvdHqO9/84ZRjV0Ct/8eS+DdsvcNdW1O/U4tu8y/a54Blkk
	XWbJQxq394jdlIIcxkjE/FZqjtVufq70MfEGDSxMZdW07eprRiTK
X-Google-Smtp-Source: AGHT+IHFLrvi0HzuSZGQukH+2xhiJKv3lPgoYz/at6fwi9g4ByafHcNI7AjPORk2D0jwlvkzz+eawA==
X-Received: by 2002:a05:6e02:1d16:b0:36c:51bf:8796 with SMTP id e9e14a558f8ab-36caeba74b5mr62691655ab.1.1715260417102;
        Thu, 09 May 2024 06:13:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346eebsm1133887a12.84.2024.05.09.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:13:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 5/5] tcp: handle rstreason in tcp_check_req()
Date: Thu,  9 May 2024 21:13:06 +0800
Message-Id: <20240509131306.92931-6-kerneljasonxing@gmail.com>
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

We're going to send an RST due to invalid syn packet which is already
checked whether 1) it is in sequence, 2) it is a retransmitted skb.

As RFC 793 says, if the state of socket is not CLOSED/LISTEN/SYN-SENT,
then we should send an RST when receiving bad syn packet:
"fourth, check the SYN bit,...If the SYN is in the window it is an
error, send a reset"

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h  | 8 ++++++++
 net/ipv4/tcp_minisocks.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 62e869089da4..bfea05ff8d88 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -16,6 +16,7 @@
 	FN(TCP_OLD_ACK)			\
 	FN(TCP_ABORT_ON_DATA)		\
 	FN(TCP_TIMEWAIT_SOCKET)		\
+	FN(INVALID_SYN)			\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -73,6 +74,13 @@ enum sk_rst_reason {
 	/* Here start with the independent reasons */
 	/** @SK_RST_REASON_TCP_TIMEWAIT_SOCKET: happen on the timewait socket */
 	SK_RST_REASON_TCP_TIMEWAIT_SOCKET,
+	/**
+	 * @SK_RST_REASON_INVALID_SYN: receive bad syn packet
+	 * RFC 793 says if the state is not CLOSED/LISTEN/SYN-SENT then
+	 * "fourth, check the SYN bit,...If the SYN is in the window it is
+	 * an error, send a reset"
+	 */
+	SK_RST_REASON_INVALID_SYN,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7d543569a180..b93619b2384b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -879,7 +879,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 * avoid becoming vulnerable to outside attack aiming at
 		 * resetting legit local connections.
 		 */
-		req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_INVALID_SYN);
 	} else if (fastopen) { /* received a valid RST pkt */
 		reqsk_fastopen_remove(sk, req, true);
 		tcp_reset(sk, skb);
-- 
2.37.3


