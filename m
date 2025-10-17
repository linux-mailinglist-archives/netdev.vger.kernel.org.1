Return-Path: <netdev+bounces-230582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3BABEB6FF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347E34E85DD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72626463A;
	Fri, 17 Oct 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIawjOZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38E261B9F
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731578; cv=none; b=Vu3T42XfKik+5YAefqzpKA8QxZy4VfFlSVoAcTXTT7YYo8zeOKZsxm1hvG4BbFRc9f1/Kne8noFzyoc5oySh8XcWSTTIIpf6ieVRMSWw2sjYcnq7unWJNylLD67rPPN1C559WnEcfWmrSi9q4iFIby8vpqQUY7fYcJZAXD8cxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731578; c=relaxed/simple;
	bh=cllDsiwwk+W+8je7GSypbkbGwzmLegWWAjz8z3XJoU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gUDCWU3I2mQvEyUBvmSuptjnlgfRPzIkgCuvjj+m3C7mbiCteuE/G+DS7pei3HSTGf+0/1+wlbviGHrjIcGAycN3kWD78660oFex8MsfqeSu9wFKdTyHpQnYb7m/86IP/mr07eV6rVtkij6cRYrfeLdpNO4EZG8IfILmZGGvJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIawjOZC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8909f01bd00so180128885a.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731575; x=1761336375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4TfnaTw7bDrM3EMC/hypSarQpF6+CV/k1XhSGZFUlo=;
        b=kIawjOZCrc2PIvyMQ7Evpq1LGUeDf4wQOmgnBXvcQNWHVebP9kA+tiof95GKHme74n
         DL5DGOhXQYe1Jj1hCIUMk7qn+E3Cbs/sqtEm0xC4KrCURDLQNFmsWqUazbZD3+gSm+4t
         RDpjvZ+/OlncFToWUQsW8kbatUVuxEY35K5t4F1ZvoIW4f8/kZyUX8G/m0iNfGPRrO6M
         197dUDurTQ0lfnit4hXMnjbQEPOBWlJIQDshTiARhGTmC0YxGSW87G4qIsLRBcuyrFjk
         vxEgOtW7HWCkJAbNTGghc11AG6b2/DFFA7yxS1HVE/7nLpa3OodyeAUtJbuna9FmLFqN
         3sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731575; x=1761336375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4TfnaTw7bDrM3EMC/hypSarQpF6+CV/k1XhSGZFUlo=;
        b=eCDcWfVN+x51uF1//uSEeqRGm8CMPmeu0Psp2m5GpXn7eu3z96ym6ksIFuBU8Z20jv
         3n57XS4WD50ZN87IPLVE7MxngmBkcfey0N2YCL8eS3x/EJO/ZTr3wlQgLgtoAqNXeLFi
         Db7dWoG74BlZHaquUbq5KJjGZi8+kg/pGIPB3L3wJ24mOEZAn1EY2eenPNfEjV5OMfT/
         HdZWe077ktyLZqf74vzEadPx0Y6GzIWsf0DkJxnBxbmWBW+41iPr2fYi/wyKKKugwdXE
         zRdPYD0HAFc9PIdCzkEfsqgzMjmJP7ILPJoMmt31LdgGdN4OCdaHUcW2jyWNpy1JrLRR
         M1jQ==
X-Gm-Message-State: AOJu0YwVoHFC0YtL5Pv/bdlkJ/zPgAKqJZcTKMOmaYvrEyVWOvmRLGoJ
	oPk1MkeEJqjLqmSbW7ujOV5y/lOlT4U/9X1sPN9VO8ZRKxLGXgqiKmWdvRgCc8/H
X-Gm-Gg: ASbGnct8aQ68BMndvbvQeXTskOFpzNSyNbJO8cM2hOADWHkIJkEhqvypHyWzpCJD4UF
	JYyzmQAxLrBDIr9MWOy8r3wxXvEb0gN+vEHYqehNbIhX1TLc4ON5XHHUeHsSxCSKHVKjiwqO70G
	qKain5BMqJGTg5Vut0dtxBjgKdcQD5R60s0hf0EiBeulJwEh8GqeII8InGupKhO0b2xGW65dhAl
	FlJOa9EzEbQ/IQhSoRZDNuuccO7z7+Dc0PwFx1ax6Z2eSG3tEQm77xwsASMrp4gGsEbBPpG/Leu
	yx3qo0b39a6orFZmyS894ZT5DMs4b1kAr5mIew0bA692OoE/87l3yyy1ivFXgKU6xeRWkcy/GG3
	ep/1M0lFHjmTASQLzG8axbs/Oi86oAbr4l7wQjHLkbllQVNA0HzNaX5TDP8cxjjpQZqmj6EEs63
	SOF9g2U3YDendEJ8JkibLbzofDDFzaNPY1B2qa/NTzn31dbV9MO6w=
X-Google-Smtp-Source: AGHT+IHBSWCSfO0Jwq6JFVatwtCridxQj/KS+Q4RcWnxtl3CmZSYNbUSK/RXcje7bpg6GOf5Tf5uQA==
X-Received: by 2002:a05:620a:28c8:b0:863:696d:e372 with SMTP id af79cd13be357-8907050ce40mr601750485a.62.1760731575434;
        Fri, 17 Oct 2025 13:06:15 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd0976bcsm37669885a.14.2025.10.17.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:06:14 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: net: fix server bind failure in sctp_vrf.sh
Date: Fri, 17 Oct 2025 16:06:14 -0400
Message-ID: <be2dacf52d0917c4ba5e2e8c5a9cb640740ad2b6.1760731574.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sctp_vrf.sh could fail:

  TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N [FAIL]
  not ok 1 selftests: net: sctp_vrf.sh # exit=3

The failure happens when the server bind in a new run conflicts with an
existing association from the previous run:

[1] ip netns exec $SERVER_NS ./sctp_hello server ...
[2] ip netns exec $CLIENT_NS ./sctp_hello client ...
[3] ip netns exec $SERVER_NS pkill sctp_hello ...
[4] ip netns exec $SERVER_NS ./sctp_hello server ...

It occurs if the client in [2] sends a message and closes immediately.
With the message unacked, no SHUTDOWN is sent. Killing the server in [3]
triggers a SHUTDOWN the client also ignores due to the unacked message,
leaving the old association alive. This causes the bind at [4] to fail
until the message is acked and the client responds to a second SHUTDOWN
after the server’s T2 timer expires (3s).

This patch fixes the issue by preventing the client from sending data.
Instead, the client blocks on recv() and waits for the server to close.
It also waits until both the server and the client sockets are fully
released in stop_server and wait_client before restarting.

Additionally, replace 2>&1 >/dev/null with -q in sysctl and grep, and
drop other redundant 2>&1 >/dev/null redirections, and fix a typo from
N to Y (connect successfully) in the description of the last test.

Fixes: a61bd7b9fef3 ("selftests: add a selftest for sctp vrf")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Tested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 tools/testing/selftests/net/sctp_hello.c | 17 +-----
 tools/testing/selftests/net/sctp_vrf.sh  | 73 +++++++++++++++---------
 2 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/net/sctp_hello.c b/tools/testing/selftests/net/sctp_hello.c
index f02f1f95d227..a04dac0b8027 100644
--- a/tools/testing/selftests/net/sctp_hello.c
+++ b/tools/testing/selftests/net/sctp_hello.c
@@ -29,7 +29,6 @@ static void set_addr(struct sockaddr_storage *ss, char *ip, char *port, int *len
 static int do_client(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
-	char buf[] = "hello";
 	int csk, ret, len;
 
 	if (argc < 5) {
@@ -56,16 +55,10 @@ static int do_client(int argc, char *argv[])
 
 	set_addr(&ss, argv[3], argv[4], &len);
 	ret = connect(csk, (struct sockaddr *)&ss, len);
-	if (ret < 0) {
-		printf("failed to connect to peer\n");
+	if (ret < 0)
 		return -1;
-	}
 
-	ret = send(csk, buf, strlen(buf) + 1, 0);
-	if (ret < 0) {
-		printf("failed to send msg %d\n", ret);
-		return -1;
-	}
+	recv(csk, NULL, 0, 0);
 	close(csk);
 
 	return 0;
@@ -75,7 +68,6 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
 	int lsk, csk, ret, len;
-	char buf[20];
 
 	if (argc < 2 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
 		printf("%s server|client ...\n", argv[0]);
@@ -125,11 +117,6 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
-	ret = recv(csk, buf, sizeof(buf), 0);
-	if (ret <= 0) {
-		printf("failed to recv msg %d\n", ret);
-		return -1;
-	}
 	close(csk);
 	close(lsk);
 
diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
index c854034b6aa1..667b211aa8a1 100755
--- a/tools/testing/selftests/net/sctp_vrf.sh
+++ b/tools/testing/selftests/net/sctp_vrf.sh
@@ -20,9 +20,9 @@ setup() {
 	modprobe sctp_diag
 	setup_ns CLIENT_NS1 CLIENT_NS2 SERVER_NS
 
-	ip net exec $CLIENT_NS1 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $CLIENT_NS2 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $SERVER_NS sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
+	ip net exec $CLIENT_NS1 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $CLIENT_NS2 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $SERVER_NS sysctl -wq net.ipv6.conf.default.accept_dad=0
 
 	ip -n $SERVER_NS link add veth1 type veth peer name veth1 netns $CLIENT_NS1
 	ip -n $SERVER_NS link add veth2 type veth peer name veth1 netns $CLIENT_NS2
@@ -62,17 +62,40 @@ setup() {
 }
 
 cleanup() {
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	cleanup_ns $CLIENT_NS1 $CLIENT_NS2 $SERVER_NS
 }
 
-wait_server() {
+start_server() {
 	local IFACE=$1
 	local CNT=0
 
-	until ip netns exec $SERVER_NS ss -lS src $SERVER_IP:$SERVER_PORT | \
-		grep LISTEN | grep "$IFACE" 2>&1 >/dev/null; do
-		[ $((CNT++)) = "20" ] && { RET=3; return $RET; }
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP $SERVER_PORT $IFACE &
+	disown
+	until ip netns exec $SERVER_NS ss -SlH | grep -q "$IFACE"; do
+		[ $((CNT++)) -eq 30 ] && { RET=3; return $RET; }
+		sleep 0.1
+	done
+}
+
+stop_server() {
+	local CNT=0
+
+	ip netns exec $SERVER_NS pkill sctp_hello
+	while ip netns exec $SERVER_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
+		sleep 0.1
+	done
+}
+
+wait_client() {
+	local CLIENT_NS=$1
+	local CNT=0
+
+	while ip netns exec $CLIENT_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
 		sleep 0.1
 	done
 }
@@ -81,14 +104,12 @@ do_test() {
 	local CLIENT_NS=$1
 	local IFACE=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE || return $RET
+	start_server $IFACE || return $RET
 	timeout 3 ip netns exec $CLIENT_NS ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS
+	stop_server
 	return $RET
 }
 
@@ -96,25 +117,21 @@ do_testx() {
 	local IFACE1=$1
 	local IFACE2=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE1 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE1 || return $RET
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE2 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE2 || return $RET
+	start_server $IFACE1 || return $RET
+	start_server $IFACE2 || return $RET
 	timeout 3 ip netns exec $CLIENT_NS1 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null && \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT && \
 	timeout 3 ip netns exec $CLIENT_NS2 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	return $RET
 }
 
 testup() {
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=1
 	echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
 	do_test $CLIENT_NS1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -123,7 +140,7 @@ testup() {
 	do_test $CLIENT_NS2 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=0
 	echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
 	do_test $CLIENT_NS1 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -160,7 +177,7 @@ testup() {
 	do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
+	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, Y "
 	do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 }
-- 
2.47.1


