Return-Path: <netdev+bounces-166968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02F4A3830B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94378170F14
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D4618FDD5;
	Mon, 17 Feb 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR4z9X4d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC911E49F
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795577; cv=none; b=O81Bj2vQ1AFBYlJ/O8oq+hVCYNtlGqkJGkOHW1J+f7J5pMib6LLmDSbuDW3AGIFdw8HPbQ3dU+Cgk+GRcuR6bJjo+gmZOyaSyQs1D+I+QHOjvJ/MoF4DHZ6jnppx2VA8nIppQeRXQe+gnCYHFv2aEOQGVWAcGAQYIjlVHs/+KT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795577; c=relaxed/simple;
	bh=xIv6K0LwgLdk3yFhgcE0oXBWwt4IjCMIBZyKGISaPZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyPqHp6SxwcU4aIWCO0Aont2Cp/+Ej0PY/EHVmT1OAbc0yNxNZ4qFMGPq/z7EpQIm6FVsY+XSpYD6SZ8LEoSuq2wCzkledjG0im3nBryBwlTGPkg0Niig6ojwy4TBAsTNXRC0qF/8ECDMkNvqRE0l8sAQgDF9uqvN2P5SoOc7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR4z9X4d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739795575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4xyhv0I+etJ77UagSPvWBjilp8DJvZwON226+iJFBiY=;
	b=NR4z9X4dM8rTPU/lscoL/J94IKXzmNoEVmga8PLn8Oy3AOiXRizEkRLI7lrHevfF4ceHQ/
	N3u9gyBt3kvAy1oOou3f4s4mIRxhO+VyZ2JXBPLEd/C+4bg4UWkV5kp+o1HfBDFkekzJqM
	vL5cH7078XDCUCyMtafv/+eusC9lAr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-_-gj5doOPTiQyJ4oeHiCdg-1; Mon,
 17 Feb 2025 07:32:53 -0500
X-MC-Unique: _-gj5doOPTiQyJ4oeHiCdg-1
X-Mimecast-MFC-AGG-ID: _-gj5doOPTiQyJ4oeHiCdg_1739795572
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBF5419560AF;
	Mon, 17 Feb 2025 12:32:51 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.34.121])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4FCB19560AA;
	Mon, 17 Feb 2025 12:32:48 +0000 (UTC)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	pablmart@redhat.com
Subject: [PATCH net] selftests/net: big_tcp: longer netperf session on slow machines
Date: Mon, 17 Feb 2025 13:32:01 +0100
Message-ID: <b800a71479a24a4142542051636e980c3b547434.1739794830.git.pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

After debugging the following output for big_tcp.sh on a board:

CLI GSO | GW GRO | GW GSO | SER GRO
on        on       on       on      : [PASS]
on        off      on       off     : [PASS]
off       on       on       on      : [FAIL_on_link1]
on        on       off      on      : [FAIL_on_link1]

Davide Caratti found that by default the test duration 1s is too short
in slow systems to reach the correct cwd size necessary for tcp/ip to
generate at least one packet bigger than 65536 to hit the iptables match
on length rule the test uses.

This skips (with xfail) the aforementioned failing combinations when
KSFT_MACHINE_SLOW is set.
---
 tools/testing/selftests/net/big_tcp.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index 2db9d15cd45f..e613dc3d84ad 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -21,8 +21,7 @@ CLIENT_GW6="2001:db8:1::2"
 MAX_SIZE=128000
 CHK_SIZE=65535
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 
 setup() {
 	ip netns add $CLIENT_NS
@@ -157,12 +156,20 @@ do_test() {
 }
 
 testup() {
-	echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
-	do_test "on"  "on"  "on"  "on"  && \
-	do_test "on"  "off" "on"  "off" && \
-	do_test "off" "on"  "on"  "on"  && \
-	do_test "on"  "on"  "off" "on"  && \
-	do_test "off" "on"  "off" "on"
+	echo "CLI GSO | GW GRO | GW GSO | SER GRO"
+	input_by_test=(
+	" on  on  on  on"
+	" on off  on off"
+	"off  on  on  on"
+	" on  on off  on"
+	"off  on off  on"
+	)
+	for test_values in "${input_by_test[@]}"; do
+		do_test ${test_values[0]}
+		xfail_on_slow check_err $? "test failed"
+		# check_err sets $RET with $ksft_xfail or $ksft_fail (or 0)
+		test $RET = 0 || return $RET
+	done
 }
 
 if ! netperf -V &> /dev/null; then
-- 
2.48.1


