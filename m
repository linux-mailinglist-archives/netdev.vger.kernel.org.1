Return-Path: <netdev+bounces-167072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D082A38AE5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267723B19E1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B3231CAE;
	Mon, 17 Feb 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IytPaNdS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D50231A2D
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814572; cv=none; b=a1Z3EQjzLLW5B6ZPyfwR8n9OHxMB7MNvjDBBzkoJuwnPTUNmviKqVik7wevR27KFgdA1sLuQzl/VopxQjgZOz1ih+KYDyWVh/aRS+FGIWgup8NozFcLTcvQh34gRj78DaNTRhKxl86Zl4CbyQL+2Ux/L1oAR/vxYqsqVHdv0U3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814572; c=relaxed/simple;
	bh=vmDlzBI7fMtRaNukNweZIKFeUNjtl0XMgUnDmg3B9zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RW46JIcr1NsjBKuWornHWpmXnmInMWiA8oesJs9dVNGWwD1NeIo3WPPOPnw5ALaMsae+0uSJZKrLP/P2Z6wKxXz7608b8qjN0RlmNCw2r3qDnz2w+ERSQ9LY/0URRpjM4qVogBQ4tGGpRh7v889qniBFtTcaB0NnABm3elEmpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IytPaNdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739814569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8De1E/HTN0JCoFuuul4V+yOXX2h57Hiv+C0BleIaF2Y=;
	b=IytPaNdSLxTdkogv9CwRX0dyGl1d6vn68wKU1EFejQMrU4ABfwjyysyAwQNJ9nOi8CWmOE
	Bbm0LRgly7XiCxvB6+Es19qt6IxWcj1kxXNdxRFyVARphLt05kxPF5SSIBMDz9Wb1oVnHf
	G52jI/X+oC/JuHEwNX598n5BiCyynbE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-40j10DlcNLikxRXw6bzMsw-1; Mon,
 17 Feb 2025 12:49:26 -0500
X-MC-Unique: 40j10DlcNLikxRXw6bzMsw-1
X-Mimecast-MFC-AGG-ID: 40j10DlcNLikxRXw6bzMsw_1739814564
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2A7919039C2;
	Mon, 17 Feb 2025 17:49:24 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.34.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B79A1300018D;
	Mon, 17 Feb 2025 17:49:21 +0000 (UTC)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	pablmart@redhat.com
Subject: [PATCH net] selftests/net: big_tcp: make ipv6 testing optional
Date: Mon, 17 Feb 2025 18:49:08 +0100
Message-ID: <20250217174908.1157168-1-pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Allow to run this test where IPV6 has not been configured.
---
 tools/testing/selftests/net/big_tcp.sh | 42 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index 2db9d15cd45f..476ad882c1bd 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -21,6 +21,8 @@ CLIENT_GW6="2001:db8:1::2"
 MAX_SIZE=128000
 CHK_SIZE=65535
 
+ipv6=true
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -34,9 +36,9 @@ setup() {
 	ip -net $CLIENT_NS link set link0 up
 	ip -net $CLIENT_NS link set link0 mtu 1442
 	ip -net $CLIENT_NS addr add $CLIENT_IP4/24 dev link0
-	ip -net $CLIENT_NS addr add $CLIENT_IP6/64 dev link0 nodad
+	$ipv6 && ip -net $CLIENT_NS addr add $CLIENT_IP6/64 dev link0 nodad
 	ip -net $CLIENT_NS route add $SERVER_IP4 dev link0 via $CLIENT_GW4
-	ip -net $CLIENT_NS route add $SERVER_IP6 dev link0 via $CLIENT_GW6
+	$ipv6 && ip -net $CLIENT_NS route add $SERVER_IP6 dev link0 via $CLIENT_GW6
 	ip -net $CLIENT_NS link set dev link0 \
 		gro_ipv4_max_size $MAX_SIZE gso_ipv4_max_size $MAX_SIZE
 	ip -net $CLIENT_NS link set dev link0 \
@@ -46,9 +48,9 @@ setup() {
 	ip -net $ROUTER_NS link set link1 up
 	ip -net $ROUTER_NS link set link2 up
 	ip -net $ROUTER_NS addr add $CLIENT_GW4/24 dev link1
-	ip -net $ROUTER_NS addr add $CLIENT_GW6/64 dev link1 nodad
+	$ipv6 && ip -net $ROUTER_NS addr add $CLIENT_GW6/64 dev link1 nodad
 	ip -net $ROUTER_NS addr add $SERVER_GW4/24 dev link2
-	ip -net $ROUTER_NS addr add $SERVER_GW6/64 dev link2 nodad
+	$ipv6 && ip -net $ROUTER_NS addr add $SERVER_GW6/64 dev link2 nodad
 	ip -net $ROUTER_NS link set dev link1 \
 		gro_ipv4_max_size $MAX_SIZE gso_ipv4_max_size $MAX_SIZE
 	ip -net $ROUTER_NS link set dev link2 \
@@ -61,16 +63,16 @@ setup() {
 	ip net exec $ROUTER_NS tc qdisc add dev link1 ingress
 	ip net exec $ROUTER_NS tc filter add dev link1 ingress \
 		proto ip flower ip_proto tcp action ct
-	ip net exec $ROUTER_NS tc filter add dev link1 ingress \
-		proto ipv6 flower ip_proto tcp action ct
+	$ipv6 && ip net exec $ROUTER_NS tc filter add dev link1 ingress \
+			proto ipv6 flower ip_proto tcp action ct
 	ip net exec $ROUTER_NS sysctl -wq net.ipv4.ip_forward=1
-	ip net exec $ROUTER_NS sysctl -wq net.ipv6.conf.all.forwarding=1
+	$ipv6 && ip net exec $ROUTER_NS sysctl -wq net.ipv6.conf.all.forwarding=1
 
 	ip -net $SERVER_NS link set link3 up
 	ip -net $SERVER_NS addr add $SERVER_IP4/24 dev link3
-	ip -net $SERVER_NS addr add $SERVER_IP6/64 dev link3 nodad
+	$ipv6 && ip -net $SERVER_NS addr add $SERVER_IP6/64 dev link3 nodad
 	ip -net $SERVER_NS route add $CLIENT_IP4 dev link3 via $SERVER_GW4
-	ip -net $SERVER_NS route add $CLIENT_IP6 dev link3 via $SERVER_GW6
+	$ipv6 && ip -net $SERVER_NS route add $CLIENT_IP6 dev link3 via $SERVER_GW6
 	ip -net $SERVER_NS link set dev link3 \
 		gro_ipv4_max_size $MAX_SIZE gso_ipv4_max_size $MAX_SIZE
 	ip -net $SERVER_NS link set dev link3 \
@@ -165,6 +167,24 @@ testup() {
 	do_test "off" "on"  "off" "on"
 }
 
+usage() {
+	echo "Usage: $0 [ -4 ]"
+	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 and IPv6)"
+}
+
+optstring="h4"
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage $0
+		exit ${KSFT_PASS}
+		;;
+	"4")
+		ipv6=false
+		;;
+	esac
+done
+
 if ! netperf -V &> /dev/null; then
 	echo "SKIP: Could not run test without netperf tool"
 	exit $ksft_skip
@@ -177,6 +197,6 @@ fi
 
 trap cleanup EXIT
 setup && echo "Testing for BIG TCP:" && \
-NF=4 testup && echo "***v4 Tests Done***" && \
-NF=6 testup && echo "***v6 Tests Done***"
+NF=4 testup && echo "***v4 Tests Done***" || exit $?
+$ipv6 && NF=6 testup && echo "***v6 Tests Done***"
 exit $?
-- 
2.48.1


