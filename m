Return-Path: <netdev+bounces-114153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93594133F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CCF1C233B2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC21A0701;
	Tue, 30 Jul 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y32ASjw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB571A00F4
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346535; cv=none; b=r/ZMxNseUxYmz5nAgm/gd6jfgQUu7MMHzA1W79tIgJ32gsylqIILHIZUYC72RijnoCq3XS1MJWXr96pm7Wcnz866XUuSNxEfjV3mb2ofCvT402Ei3p3pEbxEQDYOZO18QlmruMTRkLehBb8ZfyVc7XQObaUXAu5rSd1gZoaB9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346535; c=relaxed/simple;
	bh=wVa1ccJeseNY3fiGdLHG7LQGRcIJthDze9EEAOwxBQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2uRReMBaXRP5l8N6nwxn7qGIWBTITm6p81Vr3lSUVqUKZFui0KnQq1R9E3kimAOd5q94qJysobKLf/rFfA/2XP3QpD56C201Un1TQDVKl/SEbE1F7ZE2jvllA8rfkEKLPfoVtcfUIZ0zm+mctE/4pGVI/iCp5CT8tDg0PbF0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y32ASjw3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d19c525b5so2964665b3a.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346533; x=1722951333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd8SawcL1fjjON1L9lvfL4eTUDsCc9Q6YNNuKjobjrA=;
        b=Y32ASjw3+xxZbZA0pYjS/EX6JYNTcuA1r0aBeUK7sW9N2EdporjEeJudXh6M/zwQfN
         V/hbQS9FumveBMhiq5aMgH2LuXJDLomJpT8VzTgeFCt/ua1l0T9SsGyRsF7XdDInsQWv
         wgtOjKmS5n2GAN5nrq+1LSyCy8YzruEW59wDXzq4Wjpss+8gQHXaxmxUwPyy3yKlKvti
         N16HLtep0F+FuOCGj4Fjqmt265fMfwd20Llut1b+ZiObz1EBSvznCkrt/xALTp9bq8wW
         jH/MkFxWhCTwqbyJ6Sb11BANPWeqh4ipVAZKkGsVHSsflsATOl00raO6p32dx5ifDcAu
         3eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346533; x=1722951333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd8SawcL1fjjON1L9lvfL4eTUDsCc9Q6YNNuKjobjrA=;
        b=XAoFLn1KTK+qHJB90sPF4ooe0zQOMJH+6zcvotkLmKUlXMCrGjG0RtCprm05rrbgJT
         9b09n0n4VYQDZPUxm4recukvKCQSbDsWE6Xm93V3ecDTiCtDKg8H0/Zft78YO+dsDk7v
         B+zwS5S+rd3e3kOi5pXDIn7ay1yOBEHlA0Wok3BmZhtkJWiR7SYuXXy+9zZLnZjKnnXe
         qXeFSecNCG16xVLa8jbUZxs/wBfHxsrQPdv6iKRa4qDeEMaBwVNaDP5JI7LJIeI+/aKt
         DwAbFosEMdpEkqNy1G4magB+774uEvHKUWWTFnWuZJ3zTn2GsI99PtlP964Yu6fGpV8h
         9ebg==
X-Gm-Message-State: AOJu0Yz4ZweQpE7IIUDl78/wCfdCKdNmQYOHC49vbGKQEqMfbelwMgzy
	MdZSanQt6hPnkq9tqUokx9ZJ3hx7t2GBNr67ZoP1Lds0pbkNvOYm
X-Google-Smtp-Source: AGHT+IHcxdCevNPSZ6r0szV4wO6JEqMGfGgBm7owlgkBAP5MGBNgn2/S+ukcvfHRKy1x7gNpqjUWsQ==
X-Received: by 2002:a17:903:1c2:b0:1fd:9c2d:2f17 with SMTP id d9443c01a7336-1ff048e1ddamr93639245ad.44.1722346533423;
        Tue, 30 Jul 2024 06:35:33 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:32 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/6] tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active reset
Date: Tue, 30 Jul 2024 21:35:10 +0800
Message-Id: <20240730133513.99986-4-kerneljasonxing@gmail.com>
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

Introducing a new type TCP_ABORT_ON_MEMORY for tcp reset reason to handle
out of memory case.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
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


