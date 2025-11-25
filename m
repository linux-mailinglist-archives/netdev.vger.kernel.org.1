Return-Path: <netdev+bounces-241700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D0C877C0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8DA3B62FD
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16FB2F12DF;
	Tue, 25 Nov 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsKMsIIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2062F25E0
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114038; cv=none; b=Qrs/l6BxUZ+iV/Wqw+NjRFqQsRylXqbN3r6/MqxOXpuEAHCnEUMLysA+1bwzIKYHtzNS5jtDobgNDcy86tDX+Qs6BTjCUe9kWjuQrca27erxXedViKg7rNxS4Xl0m8GT94F6RYl0FlICcfkNwOolOXpYo4NAVMjRpJT0N8RUD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114038; c=relaxed/simple;
	bh=gSYkiH7So3fE8gqCThgFwEH8tIsmHQ2y8WQmmzc1MYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOhMrSIIsqc8zljkr0KARQ8Ho/UKh9bPv5EM7kGblPc9wQ8TKE1WEp+I9I3f7YsEx59Ggh1VX+rukLq3P3596jG/icZEicdWW3/Rr1tANA/meLYvQ1xzcOML1W/y9+IXGSCh/ZPLOCo0n/Z4DK3MyfY1SFxtnUyoqyk3YBsPVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsKMsIIY; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640d43060d2so5359037d50.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114036; x=1764718836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLrXfe8n+2+AK4csS8uACa7Zm5ejxvANdGZ5NdFU54E=;
        b=lsKMsIIYedpRRZoARChd07pnnCvP6sMrLJS3S0etb63Rbzpv5dsxokpcArxqhDjqn1
         rGbFaCECzfoBIlHuGxlHlzDTMOR/JrgSQIsNBnKsy6+F0/nFqe9hr0H6S2mOUbJvSCar
         AS6msUlrnaSXSOhjb0c7aZVicIFjEjaCHB5VRRc5mF+ErWpAL15M0zebpS0G3bvX9zpc
         aLMUxh1Hy9z4VPxUnduAvuq/P3rNfaFin/gM7JwBbXrjpKxBMgQgVZUb5ayNjE37Aiip
         /8S5Ka9v4H1cfmrPg/EURr2M7Q+3K4Ep3XQdufreumifKtu0/i0mLlosusEhpcwdSwS1
         yGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114036; x=1764718836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLrXfe8n+2+AK4csS8uACa7Zm5ejxvANdGZ5NdFU54E=;
        b=rDKOzkJ+YlBlnUOBOVR9tUSI8Lm/KMscFvzEGQ0qjcQ0rHPDIYk9e9+SXvUiKPCqNp
         qd2l47JpGhxQoBknUD6tMkX/zqMfwFk+x34vo1fH/ZmUbbAyISkdnHTzOc5xP16XcyDM
         EsGh8vTRNEpgbT89UeQTGsqqdK5btogxIOpfhLhgofP/efE7hbT4kBzqafzBtH6QcgOd
         aUI5CSXnlGF5F8lHq94HtPwU7XhhQVDxyP35GVifJrFaz01wFwAhQjiHJkWzFMTePsfh
         Km6L+I7gmK+nJ0hPsVW03cSEqk9Xbi9nZBW5ydnj6KNNC58Px9B2yMC2HMSu2s3sc5Ud
         BhbQ==
X-Gm-Message-State: AOJu0YyGFtjqC2gmDp9Puv952fmPKgHeWy3L/krq+GmUIqf7FpOsXCXo
	CjefKIU6/lG+0w24NVD9An3Wd0fW/ofYzJ/7xADtknWUfmWDxPW7CmFxFCZC2w==
X-Gm-Gg: ASbGncsOJlhq2mhmpuRKhEHNkRdw8e0tzjuIDlTdcuKGIR3HsbFGmAVoBYEUDPaJ32Z
	rHliRcUphchzbsgSY6JBDJGTdjdvrtTgUAr82a2cWqVch3a48Mga3G7GTWtpiuZL8xHeixKXVjt
	q0fmIMtP1Qic2zPLZoZWtw5l/BE6KVt3sqV45+uTqX3JSQwNcKvbg+ugtPOeminW2cJ2tlM+FOL
	wAU0N1GKHii5iMVXOLklHQ5DYY8MWFqryJx9Oy3KZpu/pnhLA8W8eJ3ZPZx4k6lV2NjqsLaZjFj
	b22hHGmXpwlzJsp+9WFqgVLE6qSRDrEcdrpizMUhMsXNCfVOKXjr7HbEW1QG79OV1cWsRHlwyzf
	bSoLKVcTyuRAByghsQlhNvE9NwXlkleblOsqdi1uufgN8OCZRFVx1UVE4mm5SKc6EH2GwjEZRZ9
	gAtFCgcs62DqezeCBirbnV5dvd20m8sIf4tkgl6s7XSZGNh+IB/jmkMgoZ9qMRiPFfXa8F4jVr+
	4qfeN/acQWYrexP9w==
X-Google-Smtp-Source: AGHT+IGQTATBQfqBnrjEwdx/XlTJLic/W7wVww/yPdLJoKVfmz9Ky65jMGIY6f1ZvmCwsLailwkiPQ==
X-Received: by 2002:a05:690e:168d:b0:640:d9b1:ecf7 with SMTP id 956f58d0204a3-64302a2f96emr13467729d50.1.1764114035560;
        Tue, 25 Nov 2025 15:40:35 -0800 (PST)
Received: from willemb.c.googlers.com.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f718b7c3sm6628396d50.19.2025.11.25.15.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:40:34 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] selftests/net: packetdrill: pass send_omit_free to MSG_ZEROCOPY tests
Date: Tue, 25 Nov 2025 18:35:05 -0500
Message-ID: <20251125234029.1320984-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The --send_omit_free flag is needed for TCP zero copy tests, to ensure
that packetdrill doesn't free the send() buffer after the send() call.

Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
Closes: https://lore.kernel.org/netdev/20251124071831.4cbbf412@kernel.org/
Suggested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt | 4 ++++
 .../testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt  | 2 ++
 .../testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt  | 2 ++
 .../testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt | 2 ++
 .../testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt | 2 ++
 .../selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt     | 3 +++
 .../net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt          | 3 +++
 .../selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt  | 3 +++
 .../net/packetdrill/tcp_zerocopy_fastopen-client.pkt          | 2 ++
 .../net/packetdrill/tcp_zerocopy_fastopen-server.pkt          | 2 ++
 .../selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt       | 2 ++
 .../testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt  | 2 ++
 12 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
index b2b2cdf27e20..454441e7ecff 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_syscall_bad_arg_sendmsg-empty-iov.pkt
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // Test that we correctly skip zero-length IOVs.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
+
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
    +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
index a82c8899d36b..0a0700afdaa3 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
@@ -4,6 +4,8 @@
 // send a packet with MSG_ZEROCOPY and receive the notification ID
 // repeat and verify IDs are consecutive
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
index c01915e7f4a1..df91675d2991 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
@@ -3,6 +3,8 @@
 //
 // send multiple packets, then read one range of all notifications.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
index 6509882932e9..2963cfcb14df 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Minimal client-side zerocopy test
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
index 2cd78755cb2a..ea0c2fa73c2d 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
@@ -7,6 +7,8 @@
 // First send on a closed socket and wait for (absent) notification.
 // Then connect and send and verify that notification nr. is zero.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
index 7671c20e01cf..4df978a9b82e 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
@@ -7,6 +7,9 @@
 // fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
 // is correctly fired only once, when EPOLLET is set. send another packet with
 // MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
index fadc480fdb7f..36b6edc4858c 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
@@ -8,6 +8,9 @@
 // fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
 // is correctly fired only once, when EPOLLET is set. send another packet with
 // MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
index 5bfa0d1d2f4a..1bea6f3b4558 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
@@ -8,6 +8,9 @@
 // is correctly fired only once, when EPOLLONESHOT is set. send another packet
 // with MSG_ZEROCOPY. confirm that EPOLLERR is not fired. Rearm the FD and
 // confirm that EPOLLERR is correctly set.
+
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
index 4a73bbf46961..e27c21ff5d18 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
@@ -8,6 +8,8 @@
 // one will have no data in the initial send. On return 0 the
 // zerocopy notification counter is not incremented. Verify this too.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
 // Send a FastOpen request, no cookie yet so no data in SYN
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
index 36086c5877ce..b1fa77c77dfa 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
@@ -4,6 +4,8 @@
 // send data with MSG_FASTOPEN | MSG_ZEROCOPY and verify that the
 // kernel returns the notification ID.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh
  ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x207`
 
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
index 672f817faca0..2f5317d0a9fa 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
@@ -7,6 +7,8 @@
 //    because each iovec element becomes a frag
 // 3) the PSH bit is set on an skb when it runs out of fragments
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
index a9a1ac0aea4f..9d5272c6b207 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
@@ -4,6 +4,8 @@
 // verify that SO_EE_CODE_ZEROCOPY_COPIED is set on zerocopy
 // packets of all sizes, including the smallest payload, 1B.
 
+--send_omit_free	// do not reuse send buffers with zerocopy
+
 `./defaults.sh`
 
     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
-- 
2.52.0.487.g5c8c507ade-goog


