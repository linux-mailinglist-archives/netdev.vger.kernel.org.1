Return-Path: <netdev+bounces-198983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682DEADE942
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0251189ECD2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146A283FDF;
	Wed, 18 Jun 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WK2kvWoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB1283FDC
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243240; cv=none; b=eZ12FfCNpIOmUwEis0Ue/r9eZ1y12jw0e8YkxtOG6wsKZyHF9ikbllAMnqPUkE3SwvLd/GceJomg8GJ45Llw1mbdAJCkn6Fn2CMk5QmzBLsBSGRpYfiZceXzNIn3WDBIGyzZuG7wRsH7LwY0LPb+jwJ2Qoi16d4x971bZ/nDiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243240; c=relaxed/simple;
	bh=IFrk+Wt+3IOL5c/d/oA9s1HjP/eu3QahRP+hmKMQO48=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MwWJ0ofnB+w9jSaL/AeyUIqa6XFekM0cv6SMGR4LLpSBHo4nCUFD7KlO4Ph8+XGZf8ihC1nYy96uFQs2TM+pxe8cmMbiac1P+7yQERcI34bcgvv9XZ/P5Cg/oIm06qUP3R9RKd68Av2FMCnGQPXpYERtxaqFwCtufpMvvYTTOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WK2kvWoY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748764d84feso9360156b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750243236; x=1750848036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5ZRzpxuw236Qa1RlkQYMr8Acq5Mq2S5Ae5QLL/5mzs=;
        b=WK2kvWoYfJaQgF++P5iaPDbW/BY0ytQCs+vhdngpQSGRgg2xfiHcRSzqRA/4m0mPD0
         Km+mTIrtuN4GVPFfqgxj8S9iEJoSscsxfUEsDX9MG1w4Phf2jNfcH9WcHK6D1BoIB60y
         J+zg4Z6e+uYDhRuhVW9gibl14kJ74l2UYqzL0yYIBVNaXw09WjN1asXicGKtNllqEVNp
         ryD+i4aSTKtMHvakEjAWKpdkYRDWxfmGfIeMYtoCKFZ55IUr2zVvwUcWW6qQRrmVWgq1
         b4QtiMcZZyKK1PSuvQDeN5pZJM9n3yKQFlKGbJn+4tiUOb5v2JA/Biauq7kYF3QX2d4H
         T2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750243236; x=1750848036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5ZRzpxuw236Qa1RlkQYMr8Acq5Mq2S5Ae5QLL/5mzs=;
        b=KR5HtcaXyHUVqpkZG9wUAOeXe2AvU7Vjyjbcik1mSbR9J9drnxO0pCicHBPd0FG7lU
         qtcOkMsqhk1XUnr3XZFKv+72E+zBadX3i3ACY47yRzxPCWuP+LM12hlUWmG9JON3wivF
         2Epfvtnngo0DSB+hZi2GcKALM1cTP/4p/Cm/80DPPsShYYtAFVAQ86I0keRGYDDX/f8x
         lZx4OVyvgczpZVbGYXZ5QkFlERTvnAom5a8KyPmPblFyaxDBICazU3zOmONqLRJMLhAh
         mniobyJzb4CpqQjqo+SUVam64JZXRoxMeAP611FqF1+x6rVGHisrggkKInXKNIBlS9ZY
         d4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8xCaJg/KjSt74A+z+6bsM0La/yONAPr4wPuo4Uz5Jadx7FnxGHAq6aXnRhC1aJM+4qbVaMfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfile25PtHcToRfqCIjb9oaBYuveKm0cvdzdwNxvnouy8Mt/l
	zRZqFaYmYtQR7tflmoPebSEj8GsojeZSBrTSznWevKX+PsYCy6YqeMP6rMBiuXyc4uun0oQSxvE
	oSOqWfLTeMmARG75sAkRnZK4h/Q==
X-Google-Smtp-Source: AGHT+IFm6jRnVgcFeMCAYW1rUtQm4z9LOhLiOCwsAqf3bSFUHFjg6zoWoywY8kEyAIzz78G43yBDi8e2+p1zScjWFw==
X-Received: from pfbgd14.prod.google.com ([2002:a05:6a00:830e:b0:740:5196:b63a])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b4c:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-7489cfde7a6mr23990572b3a.18.1750243236415;
 Wed, 18 Jun 2025 03:40:36 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:40:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250618104025.3463656-1-yuyanghuang@google.com>
Subject: [PATCH net-next] selftest: add selftest for anycast notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit adds a new kernel selftest to verify RTNLGRP_IPV6_ACADDR
notifications. The test works by adding/removing a dummy interface,
enabling packet forwarding, and then confirming that user space can
correctly receive anycast notifications.

The test relies on the iproute2 version to be 6.13+.

Tested by the following command:
$ vng -v --user root --cpus 16 -- \
make -C tools/testing/selftests TARGETS=net
TEST_PROGS=rtnetlink_notification.sh \
TEST_GEN_PROGS="" run_tests

Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 .../selftests/net/rtnetlink_notification.sh   | 52 +++++++++++++++++--
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink_notification.sh b/tools/testing/selftests/net/rtnetlink_notification.sh
index 39c1b815bbe4..2d938861197c 100755
--- a/tools/testing/selftests/net/rtnetlink_notification.sh
+++ b/tools/testing/selftests/net/rtnetlink_notification.sh
@@ -8,9 +8,11 @@
 
 ALL_TESTS="
 	kci_test_mcast_addr_notification
+	kci_test_anycast_addr_notification
 "
 
 source lib.sh
+test_dev="test-dummy1"
 
 kci_test_mcast_addr_notification()
 {
@@ -18,12 +20,11 @@ kci_test_mcast_addr_notification()
 	local tmpfile
 	local monitor_pid
 	local match_result
-	local test_dev="test-dummy1"
 
 	tmpfile=$(mktemp)
 	defer rm "$tmpfile"
 
-	ip monitor maddr > $tmpfile &
+	ip monitor maddr > "$tmpfile" &
 	monitor_pid=$!
 	defer kill_process "$monitor_pid"
 
@@ -32,7 +33,7 @@ kci_test_mcast_addr_notification()
 	if [ ! -e "/proc/$monitor_pid" ]; then
 		RET=$ksft_skip
 		log_test "mcast addr notification: iproute2 too old"
-		return $RET
+		return "$RET"
 	fi
 
 	ip link add name "$test_dev" type dummy
@@ -53,7 +54,48 @@ kci_test_mcast_addr_notification()
 		RET=$ksft_fail
 	fi
 	log_test "mcast addr notification: Expected 4 matches, got $match_result"
-	return $RET
+	return "$RET"
+}
+
+kci_test_anycast_addr_notification()
+{
+	RET=0
+	local tmpfile
+	local monitor_pid
+	local match_result
+
+	tmpfile=$(mktemp)
+	defer rm "$tmpfile"
+
+	ip monitor acaddress > "$tmpfile" &
+	monitor_pid=$!
+	defer kill_process "$monitor_pid"
+	sleep 1
+
+	if [ ! -e "/proc/$monitor_pid" ]; then
+		RET=$ksft_skip
+		log_test "anycast addr notification: iproute2 too old"
+		return "$RET"
+	fi
+
+	ip link add name "$test_dev" type dummy
+	check_err $? "failed to add dummy interface"
+	ip link set "$test_dev" up
+	check_err $? "failed to set dummy interface up"
+	sysctl -qw net.ipv6.conf."$test_dev".forwarding=1
+	ip link del dev "$test_dev"
+	check_err $? "Failed to delete dummy interface"
+	sleep 1
+
+	# There should be 2 line matches as follows.
+	# 9: dummy2    inet6 any fe80:: scope global
+	# Deleted 9: dummy2    inet6 any fe80:: scope global
+	match_result=$(grep -cE "$test_dev.*(fe80::)" "$tmpfile")
+	if [ "$match_result" -ne 2 ]; then
+		RET=$ksft_fail
+	fi
+	log_test "anycast addr notification: Expected 2 matches, got $match_result"
+	return "$RET"
 }
 
 #check for needed privileges
@@ -67,4 +109,4 @@ require_command ip
 
 tests_run
 
-exit $EXIT_STATUS
+exit "$EXIT_STATUS"
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


