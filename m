Return-Path: <netdev+bounces-177176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00622A6E2BB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CACC1891F7E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE9264617;
	Mon, 24 Mar 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOjr/i2e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A41FCFDC
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842456; cv=none; b=AhlDv6bYdPFeSzhohuckTJOmeznvCCezLD8kQKS3VCBsnSZp75zBfa9HZ/qbRIPVZ1mubI1FEE1X88qCkFItEht7BS6vGfPqrtzVgVr9L/CC2foAyxhNeMeJC/Oig3iU/2QMyVZW3AVho46/CYJlwo2FQFDZvqqpUjnUbZJC/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842456; c=relaxed/simple;
	bh=9LduXilIB2Oc55Qqp9NKstHMtMvxiGgeESLsEkuPS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWcImhbglLUZTYGgEMeNv7QJn1pwIODOTES7Qu5hkOZdeSScgV0sUXO5vCwNZ+PyRbEyjappJPkYgBBZtu/HSc8TZR+kipTb94AD95J2RTtkT+e+JM3kLBG1Y5zDNJ5+rjLPKmuvwSBeBvlggXO6n9L43O94M3gLRjOv7J5e3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOjr/i2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742842453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LMI8soW9WBidteR+eGRXe50fRhaPKA/Ts6/iyoy8oVQ=;
	b=HOjr/i2e9THmzILIwlO5LxkcFNMdhZt5IjHbYc1SIh0crmaM/vEx4EjRY7cLd3n5nktYGP
	eeKnHgNTUEqNs1tcLasUAyXwTaLFoiQ41O7mRSaRFRK21390z/88/ZNQ7cheK0q48b6EKa
	QEWfm05KFYUtz0dcUYdmtyQL9psz71E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-jP9qJWxsPfei36f0u4i5aA-1; Mon,
 24 Mar 2025 14:54:12 -0400
X-MC-Unique: jP9qJWxsPfei36f0u4i5aA-1
X-Mimecast-MFC-AGG-ID: jP9qJWxsPfei36f0u4i5aA_1742842450
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CE83180034D;
	Mon, 24 Mar 2025 18:54:10 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.42.28.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E352D1956095;
	Mon, 24 Mar 2025 18:54:06 +0000 (UTC)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Pablo Martin Medrano <pablmart@redhat.com>,
	Filippo Storniolo <fstornio@redhat.com>
Subject: [PATCH net v4] selftests/net: big_tcp: return xfail on slow machines
Date: Mon, 24 Mar 2025 19:54:02 +0100
Message-ID: <aee7724405df4516494d687a5cb1835aeb309bd3.1742841907.git.pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

After debugging the following output for big_tcp.sh on a board:

CLI GSO | GW GRO | GW GSO | SER GRO
on        on       on       on      : [PASS]
on        off      on       off     : [PASS]
off       on       on       on      : [FAIL_on_link1]
on        on       off      on      : [FAIL_on_link1]

Davide Caratti found that by default the test duration 1s is too short
in slow systems to reach the correct cwd size necessary for tcp/ip to
generate at least one packet bigger than 65536 (matching the iptables
match on length rule the test evaluates)

This skips (with xfail) the aforementioned failing combinations when
KSFT_MACHINE_SLOW is set. For that the test has been modified to use
facilities from net/lib.sh.

The new output for the test will look like this (example with a forced
XFAIL)

Testing for BIG TCP:
      CLI GSO | GW GRO | GW GSO | SER GRO
TEST: on        on       on       on                    [ OK ]
TEST: on        off      on       off                   [ OK ]
TEST: off       on       on       on                    [XFAIL]

Fixes: a19747c3b9bf ("selftests: net: let big_tcp test cope with slow env")
Suggested-by: Davide Caratti <dcaratti@redhat.com>
Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Pablo Martin Medrano <pablmart@redhat.com>
---
Changes in v4:
- Remove unneded lines; local variable and return check, thanks Petr!

Changes in v3:
- Added 12 characters of length to the Fixes: tag
- Exit test on the first fail

Changes in v2:
- Don't break the loop and use lib.sh facilities (thanks Peter Machata)
- Rephrased the subject from "longer netperf session on slow machines"
  as the patch is not configuring a longer session but skipping
- Added tags and SOB and the Fixes: hash (thank you Davide Caratti)
- Link to v1: https://lore.kernel.org/all/b800a71479a24a4142542051636e980c3b547434.1739794830.git.pablmart@redhat.com/
---
 tools/testing/selftests/net/big_tcp.sh | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index 2db9d15cd45f..de9bda5f4b7c 100755
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
@@ -132,7 +131,6 @@ do_test() {
 	local gw_gro=$2
 	local gw_tso=$3
 	local ser_gro=$4
-	local ret="PASS"
 
 	ip net exec $CLIENT_NS ethtool -K link0 tso $cli_tso
 	ip net exec $ROUTER_NS ethtool -K link1 gro $gw_gro
@@ -143,21 +141,19 @@ do_test() {
 	start_counter link3 $SERVER_NS
 	do_netperf $CLIENT_NS
 
-	if check_counter link1 $ROUTER_NS; then
-		check_counter link3 $SERVER_NS || ret="FAIL_on_link3"
-	else
-		ret="FAIL_on_link1"
-	fi
+	check_counter link1 $ROUTER_NS
+	check_err $? "fail on link1"
+	check_counter link3 $SERVER_NS
+	check_err $? "fail on link3"
 
 	stop_counter link1 $ROUTER_NS
 	stop_counter link3 $SERVER_NS
-	printf "%-9s %-8s %-8s %-8s: [%s]\n" \
-		$cli_tso $gw_gro $gw_tso $ser_gro $ret
-	test $ret = "PASS"
+	log_test "$(printf "%-9s %-8s %-8s %-8s" \
+			$cli_tso $gw_gro $gw_tso $ser_gro)"
 }
 
 testup() {
-	echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
+	echo "      CLI GSO | GW GRO | GW GSO | SER GRO" && \
 	do_test "on"  "on"  "on"  "on"  && \
 	do_test "on"  "off" "on"  "off" && \
 	do_test "off" "on"  "on"  "on"  && \
@@ -176,7 +172,8 @@ if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
 fi
 
 trap cleanup EXIT
+xfail_on_slow
 setup && echo "Testing for BIG TCP:" && \
 NF=4 testup && echo "***v4 Tests Done***" && \
 NF=6 testup && echo "***v6 Tests Done***"
-exit $?
+exit $EXIT_STATUS
-- 
2.49.0


