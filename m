Return-Path: <netdev+bounces-70906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE8850FDE
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11674B20D59
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1F179B7;
	Mon, 12 Feb 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7kAet9L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C66FAE
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731024; cv=none; b=jtTDuwENTPhgLwePkI2EvvYZm4DBl7397k/QVj1gouts9CxrLjXMDGpnBCnNIF8PEWlEQkJZBe7cjE6zaMwN01mSQTKizp/SYBFaNNW4WubV09GtuHCUkZ6wEL+GgymbRmpqLAD8uyJXKdZHpeR6aawNwSLDbBD+pXdz37zEzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731024; c=relaxed/simple;
	bh=iSKl5xJ+OEMS+tXjJ8uxetnwHoHUJEqxr7Kkbz0zJrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbkVQBdKwOrkU/RF4HsdsdcU0WDsJMPSk4fTaWqedQkSyOkngCXrUQsnjuh/iR2Dv/cUEAXct2Cpw8q13C58AsFhOA0AmDy01P5g6cKwEyi+zCHzlM35vgRzTclvxW4gLDGTrKyZkG+ZDhgu1FUr7GFKNV4/c8bSRAGOofPIpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7kAet9L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707731022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CA1Sd+KSQCRE8haUuU/BPQ64HetSDpLuDbvoKy4Dslg=;
	b=G7kAet9LZtmYQsHFnLIwcnfy6AQpUnjgI/w41T06Js60XHQSX7v3eIFVaO6fnDyBInO+H4
	yexWs8NF5/F3bNtKVA63D0cZD5V+u487ctlsAt0HjGfYRDnnuLbNj7UCWY6hke7+KN9pIs
	B/pgBvZ79FoBebNQkLoEi1xFmnyEvuI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-cEsdzH3aNAiEKOHiOvHRoQ-1; Mon,
 12 Feb 2024 04:43:39 -0500
X-MC-Unique: cEsdzH3aNAiEKOHiOvHRoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A6DD2999B26;
	Mon, 12 Feb 2024 09:43:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50F5F2161818;
	Mon, 12 Feb 2024 09:43:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: cope with slow env in so_txtime.sh test
Date: Mon, 12 Feb 2024 10:43:31 +0100
Message-ID: <2142d9ed4b5c5aa07dd1b455779625d91b175373.1707730902.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The mentioned test is failing in slow environments:

  # SO_TXTIME ipv4 clock monotonic
  # ./so_txtime: recv: timeout: Resource temporarily unavailable
  not ok 1 selftests: net: so_txtime.sh # exit=1

Tuning the tolerance in the test binary is error-prone and doomed
to failures is slow-enough environment.

Just resort to suppress any error in such cases. Note to suppress
them we need first to refactor a bit the code moving it to explicit
error handling.

Fixes: af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/so_txtime.sh | 29 ++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/so_txtime.sh b/tools/testing/selftests/net/so_txtime.sh
index 3f06f4d286a9..5e861ad32a42 100755
--- a/tools/testing/selftests/net/so_txtime.sh
+++ b/tools/testing/selftests/net/so_txtime.sh
@@ -5,6 +5,7 @@
 
 set -e
 
+readonly ksft_skip=4
 readonly DEV="veth0"
 readonly BIN="./so_txtime"
 
@@ -46,7 +47,7 @@ ip -netns "${NS2}" addr add 192.168.1.2/24 dev "${DEV}"
 ip -netns "${NS1}" addr add       fd::1/64 dev "${DEV}" nodad
 ip -netns "${NS2}" addr add       fd::2/64 dev "${DEV}" nodad
 
-do_test() {
+run_test() {
 	local readonly IP="$1"
 	local readonly CLOCK="$2"
 	local readonly TXARGS="$3"
@@ -64,12 +65,25 @@ do_test() {
 	fi
 
 	local readonly START="$(date +%s%N --date="+ 0.1 seconds")"
+
 	ip netns exec "${NS2}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "${SADDR}" -D "${DADDR}" "${RXARGS}" -r &
 	ip netns exec "${NS1}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "${SADDR}" -D "${DADDR}" "${TXARGS}"
 	wait "$!"
 }
 
+do_test() {
+	run_test $@
+	[ $? -ne 0 ] && ret=1
+}
+
+do_fail_test() {
+	run_test $@
+	[ $? -eq 0 ] && ret=1
+}
+
 ip netns exec "${NS1}" tc qdisc add dev "${DEV}" root fq
+set +e
+ret=0
 do_test 4 mono a,-1 a,-1
 do_test 6 mono a,0 a,0
 do_test 6 mono a,10 a,10
@@ -77,13 +91,20 @@ do_test 4 mono a,10,b,20 a,10,b,20
 do_test 6 mono a,20,b,10 b,20,a,20
 
 if ip netns exec "${NS1}" tc qdisc replace dev "${DEV}" root etf clockid CLOCK_TAI delta 400000; then
-	! do_test 4 tai a,-1 a,-1
-	! do_test 6 tai a,0 a,0
+	do_fail_test 4 tai a,-1 a,-1
+	do_fail_test 6 tai a,0 a,0
 	do_test 6 tai a,10 a,10
 	do_test 4 tai a,10,b,20 a,10,b,20
 	do_test 6 tai a,20,b,10 b,10,a,20
 else
 	echo "tc ($(tc -V)) does not support qdisc etf. skipping"
+	[ $ret -eq 0 ] && ret=$ksft_skip
 fi
 
-echo OK. All tests passed
+if [ $ret -eq 0 ]; then
+	echo OK. All tests passed
+elif [[ $ret -ne $ksft_skip && -n "$KSFT_MACHINE_SLOW" ]]; then
+	echo "Ignoring errors due to slow environment" 1>&2
+	ret=0
+fi
+exit $ret
-- 
2.43.0


