Return-Path: <netdev+bounces-189283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51306AB175C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881AE526641
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6F21930B;
	Fri,  9 May 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GfHPwlVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DD21C163
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800871; cv=none; b=b9VBQk0gerHkfoqtl8Hn4BSzm9KR4FjbUYLRoYPCDsd+EK4lVvGRF3M1g/LQaNu0c+R5fiJn1flxZt2nlneR5bouUerSCZnprM8YqekflRi9Ja03IDcgcGDCmB1quwR+7avgASpsNQDpkvKz76fCiP4Ax6YnslxekLKGxUbsQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800871; c=relaxed/simple;
	bh=KLg9PbqTE2osO5nDPT9TSoefHmidLJnAfLOurHu0c7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqRqKt2fx2ELtA/hXqdVUzn3dHpCghxRIQ1KSxOYhSTk4rInlykf3uDd5ho/4dhUvWM2y+DVcho6x7OS+hRjAoUSLci8OQ8C+0Og+m42QzlLMKTB+eYYk/qBRbCF/A9n8/+S8K0Gn0VCMbHZf0Bd3RUtn4a8W9LeyayCVwJ5HmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GfHPwlVy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf680d351so18984925e9.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800866; x=1747405666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3z6EIG7WwyH4DMs3KBFF5OpR2FOeKdf6UzQp70TJxA=;
        b=GfHPwlVyKNVnHsgU1QF0nSIjQdz/CyqsNfJK8cg4Bv1PUVuoYxOMJRzz7GhO/4/sny
         c66zd9EF5gFD1bZScFOBEom4vJ96MEOK/kA9cp7xbaMUxO8UWGAFdECLzJC3ysa0XUKl
         HFjXZ80+vfcX7gF2isg6xGzONWCbjU+CcwqJI30z8n2T10jBYgg2tOlQQJDbEKYgd3Z9
         Ur7AP2qWF8DqaXsANVCsviK3MxG8KTrqMuJcbAXndMqRPObYtiaH6N59ii8syOwV6zoH
         f64Br9T08PXqzOKxHKlHtb0mBlZ8TlfAOhTD7MauuCq621j/4DT9fYvCy59GVaEJe2op
         kBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800866; x=1747405666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3z6EIG7WwyH4DMs3KBFF5OpR2FOeKdf6UzQp70TJxA=;
        b=lnPnX/uMOED16IhW0AlXLe87TDTmIfRtzFVOZ/CI3CHtMlnPc95ffYyIAXeF1KFkrM
         wz56SHWEfUL7buEOkINM/6/5FYlZx2STpvnjzU8QfvDP4DRTP0FD7XUoz71buryKfYgH
         rlnU9tOAbzA3qlU3Do2IMRqL1zv67hlk6bCw4V6I6mZE3iCkNxjGLu+owwd9FZ9ZpTlD
         iq8wg91aDZNA5gtmMQu9CPNBL8eoJb3eOJylLB+PJ5Txdq4eSfzyShI2qCl2/NOMeNdf
         D5V5B25I0WQvCgHqQ38ZNkcOfvLfD3LHfQkbSUM6ijmi7SsgxOrSHss7hCq5zYHwlYju
         E+wQ==
X-Gm-Message-State: AOJu0Yx5MV5qauR1Q+eQoFD4HIvdoEOa9DANWD4EAzzdBLa1aIo5FO6B
	2moWdTkDJuILOx7Qimr/c82EYaFwZRzGhjSibuDYuUyFeYQIeq416fUEZ2TznuhX4mBo4v1QNod
	PCA8gCxa/TYKY29Wo7VmtyYEB68RhL386Wer5AobMLHoU0AZI1CrAzZeDuVPW
X-Gm-Gg: ASbGncv3dXS/7WGgbGs6hKSl2bBJcOqzQww5qS9NxwxoQC9uJnvIwDZznBSIsJTnC8o
	gkr3nEka00Cwyp1hdaE5XqlottM3esKadLLsAEj7bmIZQmAhC1PCSPSY43stCVjQp9dK7DPba5g
	YngOIhH9zArd9vdHlcWMaGkHhngI7qj3r2fQTinUyfCrWwxW26tXcw/2EaSYTYqAByU2c1LJX2D
	l0XJ7mmjflTD0HZvq5vdlh/IbuFZHjqF5SHJxzwmv52rbnoSIdB4huitOqRNTkGgtBEmf4lIsQp
	WZsumOxjTEuaLfkbeOBdBHnJIRv+oLFxG9UKLIfWdoQhdWpKzosprtwKrp2b2S0=
X-Google-Smtp-Source: AGHT+IHQsJVeyqTHvL0T+uzCyHqwO3LxSWArqvWkx/F6W3eHEYveK+1RAJknC1WeuYdFpgJR8dafTg==
X-Received: by 2002:a05:6000:40da:b0:3a0:92d9:da4 with SMTP id ffacd0b85a97d-3a0b98fcdc4mr6438782f8f.6.1746800865904;
        Fri, 09 May 2025 07:27:45 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:45 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 07/10] selftest/net/ovpn: extend coverage with more test cases
Date: Fri,  9 May 2025 16:26:17 +0200
Message-ID: <20250509142630.6947-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To increase code coverage, extend the ovpn selftests with the following
cases:
* connect UDP peers using a mix of IPv6 and IPv4 at the transport layer
* run full test with tunnel MTU equal to transport MTU (exercising
  IP layer fragmentation)
* ping "LAN IP" served by VPN peer ("LAN behind a client" test case)

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile      |  1 +
 tools/testing/selftests/net/ovpn/common.sh     | 18 +++++++++++++++++-
 tools/testing/selftests/net/ovpn/ovpn-cli.c    |  9 +++++----
 tools/testing/selftests/net/ovpn/test.sh       |  6 +++++-
 tools/testing/selftests/net/ovpn/udp_peers.txt | 11 ++++++-----
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 2d102878cb6d..e0926d76b4c8 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -20,6 +20,7 @@ LDLIBS += $(VAR_LDLIBS)
 TEST_FILES = common.sh
 
 TEST_PROGS = test.sh \
+	test-large-mtu.sh \
 	test-chachapoly.sh \
 	test-tcp.sh \
 	test-float.sh \
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 7502292a1ee0..88869c675d03 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -11,6 +11,8 @@ ALG=${ALG:-aes}
 PROTO=${PROTO:-UDP}
 FLOAT=${FLOAT:-0}
 
+LAN_IP="11.11.11.11"
+
 create_ns() {
 	ip netns add peer${1}
 }
@@ -24,15 +26,25 @@ setup_ns() {
 			ip link add veth${p} netns peer0 type veth peer name veth${p} netns peer${p}
 
 			ip -n peer0 addr add 10.10.${p}.1/24 dev veth${p}
+			ip -n peer0 addr add fd00:0:0:${p}::1/64 dev veth${p}
 			ip -n peer0 link set veth${p} up
 
 			ip -n peer${p} addr add 10.10.${p}.2/24 dev veth${p}
+			ip -n peer${p} addr add fd00:0:0:${p}::2/64 dev veth${p}
 			ip -n peer${p} link set veth${p} up
 		done
 	fi
 
 	ip netns exec peer${1} ${OVPN_CLI} new_iface tun${1} $MODE
 	ip -n peer${1} addr add ${2} dev tun${1}
+	# add a secondary IP to peer 1, to test a LAN behind a client
+	if [ ${1} -eq 1 -a -n "${LAN_IP}" ]; then
+		ip -n peer${1} addr add ${LAN_IP} dev tun${1}
+		ip -n peer0 route add ${LAN_IP} via $(echo ${2} |sed -e s'!/.*!!') dev tun0
+	fi
+	if [ -n "${3}" ]; then
+		ip -n peer${1} link set mtu ${3} dev tun${1}
+	fi
 	ip -n peer${1} link set tun${1} up
 }
 
@@ -46,7 +58,11 @@ add_peer() {
 					data64.key
 			done
 		else
-			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${1} 1 10.10.${1}.1 1
+			RADDR=$(awk "NR == ${1} {print \$2}" ${UDP_PEERS_FILE})
+			RPORT=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
+			LPORT=$(awk "NR == ${1} {print \$5}" ${UDP_PEERS_FILE})
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${1} ${LPORT} \
+				${RADDR} ${RPORT}
 			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${1} 1 0 ${ALG} 1 \
 				data64.key
 		fi
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index c6372a1b4728..de9c26f98b2e 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1934,7 +1934,8 @@ static void ovpn_waitbg(void)
 
 static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
-	char peer_id[10], vpnip[INET6_ADDRSTRLEN], raddr[128], rport[10];
+	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
+	char raddr[128], rport[10];
 	int n, ret;
 	FILE *fp;
 
@@ -2050,8 +2051,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			return -1;
 		}
 
-		while ((n = fscanf(fp, "%s %s %s %s\n", peer_id, raddr, rport,
-				   vpnip)) == 4) {
+		while ((n = fscanf(fp, "%s %s %s %s %s %s\n", peer_id, laddr,
+				   lport, raddr, rport, vpnip)) == 6) {
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			peer_ctx.ifindex = ovpn->ifindex;
@@ -2355,7 +2356,7 @@ int main(int argc, char *argv[])
 	}
 
 	memset(&ovpn, 0, sizeof(ovpn));
-	ovpn.sa_family = AF_INET;
+	ovpn.sa_family = AF_UNSPEC;
 	ovpn.cipher = OVPN_CIPHER_ALG_NONE;
 
 	ovpn.cmd = ovpn_parse_cmd(argv[1]);
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 7b62897b0240..e8acdc303307 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -18,7 +18,7 @@ for p in $(seq 0 ${NUM_PEERS}); do
 done
 
 for p in $(seq 0 ${NUM_PEERS}); do
-	setup_ns ${p} 5.5.5.$((${p} + 1))/24
+	setup_ns ${p} 5.5.5.$((${p} + 1))/24 ${MTU}
 done
 
 for p in $(seq 0 ${NUM_PEERS}); do
@@ -34,8 +34,12 @@ sleep 1
 
 for p in $(seq 1 ${NUM_PEERS}); do
 	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
+	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
 done
 
+# ping LAN behind client 1
+ip netns exec peer0 ping -qfc 500 -w 3 ${LAN_IP}
+
 if [ "$FLOAT" == "1" ]; then
 	# make clients float..
 	for p in $(seq 1 ${NUM_PEERS}); do
diff --git a/tools/testing/selftests/net/ovpn/udp_peers.txt b/tools/testing/selftests/net/ovpn/udp_peers.txt
index 32f14bd9347a..e9773ddf875c 100644
--- a/tools/testing/selftests/net/ovpn/udp_peers.txt
+++ b/tools/testing/selftests/net/ovpn/udp_peers.txt
@@ -1,5 +1,6 @@
-1 10.10.1.2 1 5.5.5.2
-2 10.10.2.2 1 5.5.5.3
-3 10.10.3.2 1 5.5.5.4
-4 10.10.4.2 1 5.5.5.5
-5 10.10.5.2 1 5.5.5.6
+1 10.10.1.1 1 10.10.1.2 1 5.5.5.2
+2 10.10.2.1 1 10.10.2.2 1 5.5.5.3
+3 10.10.3.1 1 10.10.3.2 1 5.5.5.4
+4 fd00:0:0:4::1 1 fd00:0:0:4::2 1 5.5.5.5
+5 fd00:0:0:5::1 1 fd00:0:0:5::2 1 5.5.5.6
+6 fd00:0:0:6::1 1 fd00:0:0:6::2 1 5.5.5.7
-- 
2.49.0


