Return-Path: <netdev+bounces-95453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837FC8C24C6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51331C21A2D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864B1304BF;
	Fri, 10 May 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTwmRuBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F516D4F4
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343925; cv=none; b=d87KshJVyDtBVliRfVQLqvOuiTSOLyyDjSv/CBtiy8/O5tbyYbMxmpYl+pR07a4T/FUeZa+zoZnOJASzHzfadNEXpoTgj1z7yk1/YDIP295RBS+KW/NVwgkHQfZlcOUpYZX5yJlwXT0RHK2K3D8RyDTuIH5WAaIwy+bGWr9WYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343925; c=relaxed/simple;
	bh=dOPWA5oUMFLJMkyrjOLwiNM4jqXOocS06R2V1tpKFlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOhh8SCbxWVIWPDo8gSSamx2RK6CR4DcIvHAd4WYxk3ups5SN3bcdUmamTNIHmGVUZZ8dwOKBKyS6PbYPbhMYSWuvsRPTYLWag58capboLrx5EY2S4f+LEk94IWgTicRHzEQ2S2GHRYxjbHOz1aEJtFo2fvuC1EWBOMqUbjEAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTwmRuBu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so1671044b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715343923; x=1715948723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlCmy+iZAQgDelBlhi5+PpnGFmqq4Df4VsGrbrOxgsM=;
        b=XTwmRuBuSHjYjk1Cczq03RjEyWWuRO1tCmYxaBJ7z4D2B6NMHRKLqZNVk9JV5kC+Tw
         tF+LWOxgqUcYoVyO0IBYty3ujpCF/D7vZvi+z+tXUlowkZnlM2/BydA/n1wReVCejHyB
         0+dKkjbitAkJrPobOUSkw2JyxbKEk+tccHmT7m0/6///8tuIuqWdvLDSQ8OtfJptW8nE
         iR0s/K/PYQ+Hn+SIW8Q8JxTAO5/QntwP7/HNYeqJZCv7c0XoO2o3nAZGk4dlBkxL07Zx
         bJK/e64iYzcu3Z/rBpHbnqOYChADNU9k3Sakx97++QLBUjtRc2uRqR1tvZMyoqyf8StL
         SKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715343923; x=1715948723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlCmy+iZAQgDelBlhi5+PpnGFmqq4Df4VsGrbrOxgsM=;
        b=FggrKHuZ7O70R5OGUtSA4bNtQjvxSaJdDsb4iuTfYhQC4Xny1XvnFBIPumauB2/o8L
         rZLxXDekm5IiMN8loDzjc6QObzh3gasRA5/JYq1BSYHKra0Nq/zR4bwEXf2Orp0VR4pq
         tO4blBrXRklHzkh7lTWb9I/RGJOek2bApUDQ8xQMjmznFJKJ7xM4qDPBb4o4zwpWRSQD
         YoEJimIzRzOQOzkHGpGZgCvJCQ0ZY5qHVaMOVjoE2tkIzCVZAB63ajNxeVLtLXMLyath
         MXHvyOUEkMCsEzxrtfO9YshzhSAOnru89X5As6U/CxGwJwl6a1EFLe8Fp91w1y4D8JQ6
         4zZA==
X-Gm-Message-State: AOJu0YzAd40DAUBIVhzAnzkmSgx+gl6GAgvYr/NcDptYf1iRmcEU6tpp
	UoHqXgm5sBDR8tVuhPW8gX5y5wsebkUHrcsC7KHl2qvPbCcI3rVY
X-Google-Smtp-Source: AGHT+IHa1IEfofgHSTXuWQF1qnE6SdHpidxY8sgIYZD8gh/Ipx0le+uaNxiPvtGwUu3qOXD+zuaWdw==
X-Received: by 2002:a05:6a00:391a:b0:6f3:876a:c029 with SMTP id d2e1a72fcca58-6f4e02ac99bmr2752898b3a.10.1715343922979;
        Fri, 10 May 2024 05:25:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f362sm2943530a12.30.2024.05.10.05.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:25:22 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 5/5] tcp: rstreason: fully support in tcp_check_req()
Date: Fri, 10 May 2024 20:25:02 +0800
Message-Id: <20240510122502.27850-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240510122502.27850-1-kerneljasonxing@gmail.com>
References: <20240510122502.27850-1-kerneljasonxing@gmail.com>
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
index 7ae5bb55559b..2575c85d7f7a 100644
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
@@ -76,6 +77,13 @@ enum sk_rst_reason {
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


