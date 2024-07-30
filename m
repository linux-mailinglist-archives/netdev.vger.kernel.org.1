Return-Path: <netdev+bounces-114152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8494133E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B26D1F252AF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871941A01CD;
	Tue, 30 Jul 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD1/ryoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF41A00F4
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346531; cv=none; b=qVifGR1tAVJ+sPpher+UO5OjWWOqyfeNQi38734KnbDj/wjwpJA2BfPxu3PrRaPhzziRFnXTfEr/4U7H2rz+PrZTM2rB9XCHEUvTIpSfyOjy7cZwgQAI2HoflW09sWLSW6hHPZxgOp0cDr+LocBktaXJ/Cmyi5hM/OrhjQq2FpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346531; c=relaxed/simple;
	bh=sELGKtAigfVF1zgsTyPKm9ZUrrRps71mcbi75aSK++o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkyWGyd33Ep+9muU4A55+HdnHFpZTOqzDjG3wz6rB35mbQhDUkyr47j7nmuEPW/S9ti9zDqEtHANPFqUAVVfeqxid9UufFhGCMtbyT2rGDNlkgEZ884SxzWw94Q2F1i2t7dP8glqQWhJeerMP+qFJojryLD/bj4TjfmE2FgQxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD1/ryoR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc66fc35f2so27613495ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346529; x=1722951329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktupWLflllZrX9z6dcV/AAu/RJe8BItZC51A5Ri4yeE=;
        b=LD1/ryoRxT0nIERyFzLMivcWwhpp/syViGuqE5v/DJG6KH0bGlizB0fuQXhn6E11uK
         wkHyZTljWP65paCZ21vRlg6qqwW0uX0EJetpolZmlgbNihhqodIu8oZBnjCJ0J4sGMCK
         uL/OLijJTp7t8JOqmmWl/QD1SyG7xT4GmnnmP8pG243KVuXQoo1it87qtCdwTIp3/S2I
         GEtOkQrjgdduaN84hzlg2EOVwP15a+peROl2mSf+84ddv2Cn4/CEQoWkBtkHIYrBIsJk
         9DzNEovJz30uhW5DSepV1qNzPOUzMNbIz8dC4EG0iqGFnImDxUt09LhBokgBtjOR9bsT
         RHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346529; x=1722951329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktupWLflllZrX9z6dcV/AAu/RJe8BItZC51A5Ri4yeE=;
        b=VgkhMG+LgC1WsuiiN4Wms0u+sr+pU2WkTun+QM5IxGPAkcwdsaFXdI+kSnzUWpC8/A
         iS3mBZsRXUfCpz9NW5sT8u2yGy4WE49JWa0pOxL9mglYEFpqTSyLHvar26dY+3Gc16xh
         FPWE//0zgAuWC4zKBAvE8w9EM3qLfoe7n18/4Flm6l0bESW1NAFFvtEDpLYV2NJEOKVl
         uOeFJ5XP/oCyiLytghsUp6v+dwQ/CL51KTetvfguM1T+QfRsT3UirXzkyu1dQaQkW/At
         9BGTjZsLJKLBp6lC9B+2TqNt9Mhb5r4dRmSWB4B+V8JqcFzKi+J3RIG0TsC7lhRA9Oo5
         k7Ww==
X-Gm-Message-State: AOJu0Yy9EebREGTjfECwl/VMmsT9ZqVRxYM7vL2Oza4Qon9FJ3kp14VP
	QYZMDOIjog4bUGX+OoArICB1TYYwLyL2DLQVBqhIFAlgSnZFHDtJ
X-Google-Smtp-Source: AGHT+IG3CI80cROfbxu63IzeFExoOOumfbgslulntkl1plJxUNGPk+m6W5wVcL5IQE75UbfbOj9VYw==
X-Received: by 2002:a17:903:246:b0:1fd:6033:f94e with SMTP id d9443c01a7336-1ff37c111damr36581345ad.27.1722346529338;
        Tue, 30 Jul 2024 06:35:29 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:28 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/6] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active reset
Date: Tue, 30 Jul 2024 21:35:09 +0800
Message-Id: <20240730133513.99986-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240730133513.99986-1-kerneljasonxing@gmail.com>
References: <20240730133513.99986-1-kerneljasonxing@gmail.com>
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


