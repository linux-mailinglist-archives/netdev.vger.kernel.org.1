Return-Path: <netdev+bounces-190690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F56AB849A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8047A8631
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E6298C1F;
	Thu, 15 May 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TrGeVJ3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF8298C14
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307675; cv=none; b=Yt3AXBMzcinWYiKRExXLEOpVmCIN5RL4Klf7xuGUgyCViOC38C+K3cPtXoFpN1yBZVnDEvryO/he1yVuE6/qCSjzzCgTTEuPJ4TqlQKm2u03gfa4NH7QAMp7JW172rZgIGTTTuDixuUPOcn3yq6vXbbduL0eXmTV+EUou164r5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307675; c=relaxed/simple;
	bh=KLg9PbqTE2osO5nDPT9TSoefHmidLJnAfLOurHu0c7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s288jhn15JUnHfcjt12VDEflDu2edVwgY4toTGMTuAf8aoLhQ1fBxxbe3LYGXJEEz0Oq0tPtDysnsTkKSajWLcUAECQGyTLyaEZfBXw5jS2z4anOm28DJ9PdV/6bOf/sE7ZzGjLwNt5o2VNn0useNPgTnRGvAmEL9ld3Whi0pEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TrGeVJ3p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so9823305e9.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307671; x=1747912471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3z6EIG7WwyH4DMs3KBFF5OpR2FOeKdf6UzQp70TJxA=;
        b=TrGeVJ3pEfAAk5AAov5yhfnJU4gXxgCJeHbZa4SzmO2p/IFEUSKp4feMgnHQYOvdbY
         qzgC9RUonM3VM1eejtsiq23aUQeNl429NLjxDVpQsJ0zNI0hRlT8iCZRmRovU1Amf+Ur
         JZ1I4traCtj6BDsRVQY1Jlh/l2DNA58RyGpen/fQLda22gbHvtKvKq5UGW8NRWdn4b8W
         ZwZxw83AJ3bFDZXzSYRyBo6RraJdFJArJGMPmYphcrOBedPMeOzYesGyB7lRXoA+VC2V
         GSQ7by3KZqzLD7GQhbQUB7TVR1X5surQ1L3iOKdsj36I89xOFGqxRYLHs2LoGt0Pc5tV
         b1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307671; x=1747912471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3z6EIG7WwyH4DMs3KBFF5OpR2FOeKdf6UzQp70TJxA=;
        b=v3kaoP//A/qHNNohiKuEhOLbIOLJy7bGN5ynk3rd1dBiDWWpEVEXcxwYpX2bYRMDw9
         lcOF5rC+xoiaZ0IOpaPNkW/pIu7AjEH4l/2za5HgpqdWzFo5JoUIIgUITHlPPVQ/ivo9
         Va0QE2wWPugc4qNhJ6B4TzklJaaH6WSKnhdO4LcuayrUaf/3uIQlQX3yAbWe6l60FVse
         fCPNDHOHvYRXEfUn1g0YOK6CRNC1uuImH2s8R938Cs9QrUWz1jAIZHy7np/YcZPrTxE2
         6Xnkcq+xmm/8SxcDjNDILB6PsSX10Nj9V9rI9cHA6N/Ntb2sFnw76zkRmFvup6m/U/5M
         RI8w==
X-Gm-Message-State: AOJu0YxHtzsiGIrCZeLbL7bTQF6itkgMFNrTu4O5gnaKCq3Y21NP24ml
	MrkJvX9zHy/0qkvblYH/Y7WAHeQok7M93aLU+qRIqAanuV8t5q5QMmFkVg1/NDHHou/wmoyoTSK
	a/j3dPZeCzCuUc10dAxpkb48ORya5Ne3rR6zpZ26SP3CwRFDNQP3e2y3Daui6
X-Gm-Gg: ASbGnctxK21X9g7fucvX/gt9qQV+8Ls4ALvDmiceFBGJZW7FOvr1Ncy37wHTD14oyhg
	BYlIi32c+Yq1NUDBhK5P8SCYNo2dAInbJIRWWBwPdujngZVj4YR/MI+1Qx58YH0Nfr7dilmQBLD
	G12lqoGnHupmaEXcZX8c3cqMhKsoSk7Vvl6Ab5s1Lo4K1f5mcSekXqnhd3BrISIzbfc2m117HDa
	kpj25xdvQwhgb4sKML6LUDUhSigoXGQzEwx2XY+CTlKlGdFwBHm2QXGrbMufUDk3sE7lGJzrAd9
	76v/T0QLwfi1hMKzFvdTKb4hQDbrZpEvgsIO4NMlJibZ63srCd5MlDr2Ybyt0cblXbwelGgyUtA
	=
X-Google-Smtp-Source: AGHT+IGz72n1TAJH/qgLUff3a2qmzO5rKOYrAfHdEQ0e7va1Je6HD8ngbXY631TDUiT5c2CYw5l7kg==
X-Received: by 2002:a05:600c:3d15:b0:441:b076:fce8 with SMTP id 5b1f17b1804b1-442f20e73e8mr69491515e9.14.1747307671288;
        Thu, 15 May 2025 04:14:31 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 07/10] selftest/net/ovpn: extend coverage with more test cases
Date: Thu, 15 May 2025 13:13:52 +0200
Message-ID: <20250515111355.15327-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
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


