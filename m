Return-Path: <netdev+bounces-175738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FCA67567
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A377A366F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9A20D50C;
	Tue, 18 Mar 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ6dmNsF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC920D4E6
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305409; cv=none; b=oAlPgWBEj/+SMjyi8BpVq1XTBzrZm3YhMVjifA2ecsbfpZ0w5w9WfEMOmw9njr6FsgBh1xR7HmqjhR0QE65bdOngisx4sQnQdJhKE41zmC8XRs5Qp5Rbkd70bi5H+4SF3UcxROseNEBR4pJA75GMw36sYkR9zoISiWRIHcjoUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305409; c=relaxed/simple;
	bh=fclbCAAogzO5TELWwNeVPp4YXPQGdH0oHV8kXh8JcZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7OiLQMynPNAx+dcWUjluzRm8OGypNUviIJjxZ+UJaFVB+5u31tkMNThoyiOjKJ83CMm5PFbrDiJTWZH7AjWEIR6k1auaYbTrJAUQvBAW4rJgdIRaxcdc6wqcn/YTeu0M13S4uEH+iIbiflCe2o5dSU9N712povXx3D45xJvG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZ6dmNsF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742305407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J9ZqlqhDnmyRhXG5WpWZX4M2zoIV7vrfnOKM1wlQCW0=;
	b=SZ6dmNsFOS8osZnOZ+hSgoQsPq2PyPLZHYuCzEWBfjxetjxhFjY11vUZbVsejCRLPa2mt/
	Y3Z0zfuahEDMK1HMPs6TiQOCe8DXEDQNuNLW1S6WFHFrd4gRQrmKztj3Gbom4e42fKe8nm
	9QDfz0q2rTE78I05zk05F6TcFx+Yovo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-1REig4SIOuqvV5P52APSbw-1; Tue,
 18 Mar 2025 09:43:24 -0400
X-MC-Unique: 1REig4SIOuqvV5P52APSbw-1
X-Mimecast-MFC-AGG-ID: 1REig4SIOuqvV5P52APSbw_1742305403
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EC47195609E;
	Tue, 18 Mar 2025 13:43:23 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.42.28.99])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EAFB1956095;
	Tue, 18 Mar 2025 13:43:20 +0000 (UTC)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Pablo Martin Medrano <pablmart@redhat.com>
Subject: [PATCH net v3] selftests/net: big_tcp: return xfail on slow machines
Date: Tue, 18 Mar 2025 14:42:50 +0100
Message-ID: <472257e02c57.git.pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 tools/testing/selftests/net/big_tcp.sh | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index 2db9d15cd45f..52b9a76b1c19 100755
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
@@ -143,21 +142,20 @@ do_test() {
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
+	test $RET -eq 0
 }
 
 testup() {
-	echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
+	echo "      CLI GSO | GW GRO | GW GSO | SER GRO" && \
 	do_test "on"  "on"  "on"  "on"  && \
 	do_test "on"  "off" "on"  "off" && \
 	do_test "off" "on"  "on"  "on"  && \
@@ -176,7 +174,8 @@ if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
 fi
 
 trap cleanup EXIT
+xfail_on_slow
 setup && echo "Testing for BIG TCP:" && \
 NF=4 testup && echo "***v4 Tests Done***" && \
 NF=6 testup && echo "***v6 Tests Done***"
-exit $?
+exit $EXIT_STATUS
-- 
2.48.1


