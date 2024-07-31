Return-Path: <netdev+bounces-114549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D5942DD3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B081F24FF1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD51AD9F4;
	Wed, 31 Jul 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqUKVtTw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167551AB516
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427813; cv=none; b=XG5cJgxmLWgzcbTWukSX01lDyGJ3lIHE+xnFpm0gruZc95jI1Yi7ECQv4y61PPltLoQIIZuwDNnP1GSl3xvRerHNNhML+VnRtbARGZZiGMIzu3fy2JkDoh8k8X6kd1Tokz23xo93eAv4/sk15mN98p7f8wAy4OP/1t34utBRY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427813; c=relaxed/simple;
	bh=sELGKtAigfVF1zgsTyPKm9ZUrrRps71mcbi75aSK++o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcGKycCVFlpwH5sXU227QMBq9lH6VrXXrk7IYrZxjcs9s+1IjJR0KpO0tpuf0fXAIMXobtYbziK+hShNAwAIeQ+FbFZ3KglN3KPRkJwHFigKesEHNb+rTCm8ssn6NBr8PPv6eHOxhbgT4TuU18zUBZMns9Av3063MoShaqohrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqUKVtTw; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-264a12e05b9so3575913fac.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722427811; x=1723032611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktupWLflllZrX9z6dcV/AAu/RJe8BItZC51A5Ri4yeE=;
        b=nqUKVtTwliwu8kB/Oz5VoKQfZ1sWbK8KNeYsk+YO2oEWgMUP/Wn2tNk8mr13n7gitU
         ZCbyC22B+korFa/UmolARNcMy3SCqZkfDkHaC6HNxpqm2eOnYeS87C+OQa1WThQyGmKq
         KhOl6YzCDFbOsGAf3hx0QiU1arj+K8OQikIfmZjoT2c4Cd/nyvEmwpR/fFgOsAdluJUL
         k7skgyfvA/Ni6mbFtdYG9zaSLTtcrLsOg2h04ApYj/R1goTzyeLg5iLyNZlR+mEVqfJJ
         Np2HLH0OXaV8Ai5XQMo1WIbIjT/bmoKH0w0zldh2yJI4tW5PJVtlV6znfMDiJdp5KAJE
         FKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427811; x=1723032611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktupWLflllZrX9z6dcV/AAu/RJe8BItZC51A5Ri4yeE=;
        b=CdZxlu8VdTvimIS1xUTFyR15UFn4OqJc3Vbxos0OiR0rUryLXX+PabpE72CbBqHq7f
         JYHQ4a8RVmfmyUTPAKBU9wjkBpsuz+bh5V4PP7TrTY893USU0UTgc+QYPv96pLkqsqfK
         zzBjpw2JJZuEyg8RYT6qNETM5OZb9/2KlZv/TrcyMhSos1UCuVEVxrGKZHIzzFrPifhQ
         hileTRxOpOn3EEBMbP9n2Jh4jwON6oUoM8uVGqJXR4LG0YRWa+lA7i/EtDiywDloIiaL
         7N2J7G1n+ug0+hTktZRBKKpmcbdLfZbUY7hKlcptNXM/pXv91UJAhEXWa8oXSBmaPbnp
         yULQ==
X-Gm-Message-State: AOJu0YzZUeKpq/x9vDGpfrR5movbJY/yPcsHInOrS3KP3kGNKYkNq8UK
	UES03E6ZZu8khVNJCxyK1X1A6hn78SCJU5VDCqeaDowXQ2aBmrj4
X-Google-Smtp-Source: AGHT+IGL2K65AEv7Mt+qJY5ywQYap5/RAwM+Aj8hOPnXqU2xeTMncbHYCO3OaRFdRdJuokuBVSO2FQ==
X-Received: by 2002:a05:6870:8a11:b0:261:ff6:7496 with SMTP id 586e51a60fabf-267d4ee606amr18610206fac.40.1722427811005;
        Wed, 31 Jul 2024 05:10:11 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm7488545b3a.180.2024.07.31.05.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:10:10 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/6] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
Date: Wed, 31 Jul 2024 20:09:51 +0800
Message-Id: <20240731120955.23542-3-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_ABORT_ON_LINGER for tcp reset reason to handle
negative linger value case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
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


