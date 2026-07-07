Return-Path: <netdev+bounces-305267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yg2LGd92TGqykwEAu9opvQ
	(envelope-from <netdev+bounces-305267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 05:47:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17185717219
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 05:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g5QYT0VT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305267-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305267-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B343023A68
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 03:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C443191C8;
	Tue,  7 Jul 2026 03:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FE42088B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 03:47:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396055; cv=none; b=eJ4FTcEM8K3HuIFT7woa8Q9FaknsMh/o7VTF6KDAgXmEMWY6vnXiTShNcC/Z9bJrizXhn9dRs7nQaC5PjJHjMRaHrfzsjKCOAm1SnkOUtj8IkMv0daSu6z0HxB+EQgVl9qlep0VO/Bf3UZl/38ZaxHQvZfaLzxcyaT1Lr5Hl9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396055; c=relaxed/simple;
	bh=bIpel2MisZarxPESn/8XO7PTy6ZrPetEUgx8Jkn5Qic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzYXVkVVJY041/CCu7jtXxRcEZvmqTYxdHJ1Kb7seFCok9j+aavhuJ9SVv3zcn2ZNAI0b7YoKRFWhu/TLyc0pLlq3oR2NDjMPczIWxUKLhBX3HSc/dwd0yECuP8LRB+cdbfkaghOHEK6FQ8PwzWBZXMh9F0e2hPOzMABdF0+gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5QYT0VT; arc=none smtp.client-ip=209.85.217.50
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-73a75f251a7so1142342137.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 20:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783396052; x=1784000852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7eoG/lm2vamJEnKh3aUV46HcL7smzTZx56E3ZGcUYAQ=;
        b=g5QYT0VTkobFNkhLAvT+n3q8rKdazVZJ1hK14hvFaapSWuAeR7PrmyJVcYMpNEtKsG
         BurxxjOAKFPMsBW8yi51nRsbKwP3jEFta1pJDghdQJCDzXX7k1aZGyMFcrtAIS5L+KsF
         eDncPMPuDxk1tQEZ4hRP8tSG8fUwwvzIxwwks+LMduTg9Tdt1CE0bx+A3jSofGHIrXw8
         pG+CHp6HC8r0Zdx4PWnjwkHT5IW1gcrHoglDfQ11wbjCiZUb+UJ4pC5Yd2v0H3BsAR+t
         yom9ertYNW3iBjfRvnCCMVYZbIWXLn6Kl6pEJrAynnwyLOiBxH4G4GY3JgB6q4/07DEC
         R67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783396052; x=1784000852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7eoG/lm2vamJEnKh3aUV46HcL7smzTZx56E3ZGcUYAQ=;
        b=nW7Jer5gmiKHT5v+NTaI5YzjZpxbGoQK1wIRevuTQB4664f6h0jnIeIR7nhZWrjt9v
         MQsXx6JHc8UOFC6bM0V60QY7IBJh5/Izjfi/rygNmL9Q9BikegQeEtanF5LFsYSrt4XD
         4OQa8mJBaTK6wYpjE7PM0JRu7cZCMzhlBLLASDvK8CMQ9+OddsiCRQtN2F9UdKPjh4/9
         wvYNfvhhByWOWAoDK/kf7h1ZeziTswYXZNQsjdQYnfbai+ZR6F9iUy34PHd9nY2vX5yW
         +WRJfkE651KbQlPrGzARVj9/nBFwVITOLtkGoErCnQy//rdc5/29KFX6J1A7NmDVlOKg
         6yKA==
X-Gm-Message-State: AOJu0YxMGS6DS6iUCR8+Z0WHfViyNkmRLfEqh9mYPChIVMgabb1jy4Kk
	azrCSVVtCQEtDDaNZ6ZZ3jVpvpqpyrbd7AvntPHr8rYBn1rSDLf5YHbBpBPEzhckG28=
X-Gm-Gg: AfdE7ckFbuZwhQa67pgrMA0YvP3LtKPKg32XatROUt//p2DPTAmQ9udWaZY0QylNIFA
	wKO+rtjE4NGt7Hca9WR7CLWYl6/TXF1R6aRSWdi5R6MiHV4QO5aJ3oXTqSniDNpChnfiwDdETIP
	DVo8ZCCO7U7bISM45IkLfaG/qvM+L226CcdwJuG8bD8cjaL1uB1QVY6cbXMLQHZR51qXD0BkGpN
	juQAxibRe8sNkqGHIEUK9WVhdmeg3hjSZD/MYc6yhCQb9JEgC1WPkG+D42vYnvQVTknwNFAFcy2
	mR6NhqzJU7ANSX4ftfpYfKfdP7W37SMeulQunUMUOxmsBsEfy/W3SdxyoXgb3b5ZF1o7XP66Ltd
	z7+USFiAMJyC/rIgo1SQh4HjETheihm3OjHxPJnx9q/XUPJXaNVafu7t+V0Z/QqCB0vV1QbsUC+
	ulLHV6jvd7HxuLmw==
X-Received: by 2002:a05:6102:6898:b0:631:2dc6:2f5c with SMTP id ada2fe7eead31-744b7853919mr1736452137.0.1783396051770;
        Mon, 06 Jul 2026 20:47:31 -0700 (PDT)
Received: from houminxi ([61.170.226.21])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73e19f3f781sm6597392137.2.2026.07.06.20.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 20:47:31 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v2] selftests/net/openvswitch: add SCTP flow key test
Date: Mon,  6 Jul 2026 23:47:18 -0400
Message-ID: <20260707034718.2717982-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305267-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:i.maximets@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17185717219

Register OVS_KEY_ATTR_SCTP in the flow key parser so that sctp()
can be used in flow specifications. The ovs_key_sctp class already
exists (with src/dst fields matching the TCP/UDP siblings) but was
not wired into the parser, so the token was silently dropped and the
kernel rejected the flow.

Add test_sctp_connect_v4 exercising the SCTP flow key with
port-specific matching: sctp(dst=4443) for client-to-server and
sctp(src=4443) for server-to-client.

Wait for ncat readiness with ovs_wait instead of a fixed sleep so
the test does not race against ncat startup. Use grep -c on the
listening message to distinguish between successive ncat instances
that share the same stderr log. Kill the previous server before
respawning to avoid EADDRINUSE on the SCTP port.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
v1 -> v2: replace sleep with ovs_wait on ncat listening output,
          kill previous ncat server before respawning to avoid
          port conflict (Aaron review feedback)

 .../selftests/net/openvswitch/openvswitch.sh  | 102 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
 2 files changed, 107 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..9c364eeb2ec2 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	sctp_connect_v4				sctp: SCTP flow key matching
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,107 @@ test_action_set() {
 	return 0
 }
 
+# sctp_connect_v4 test
+# - sctp(dst=4443) matches client-to-server INIT
+# - sctp(src=4443) matches server-to-client INIT-ACK
+# - remove flows and verify connection fails, reinstall and recover
+test_sctp_connect_v4() {
+	local t="test_sctp_connect_v4"
+
+	which ncat >/dev/null 2>&1 || return $ksft_skip
+	modprobe -q sctp 2>/dev/null || return $ksft_skip
+
+	sbx_add "$t" || return $?
+	ovs_add_dp "$t" sctp4 || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "$t" "sctp4" "$ns" \
+		    "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	# ARP forwarding
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' \
+	    '1' || return 1
+
+	# SCTP port matching: dst for request, src for reply
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4(proto=132),sctp(src=4443)' \
+	    '1' || return 1
+
+	echo "server" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				ncat --sctp -l 172.31.110.20 -vn 4443
+	local server_pid=$pid
+	ovs_wait sh -c \
+	    "[ \$(grep -c 'Ncat: Listening' ${ovs_dir}/stderr) -ge 1 ]" \
+	    || return 1
+
+	info "verify SCTP association with port-keyed flows"
+	ovs_sbx "$t" ip netns exec client \
+	    ncat --sctp -i 1 -zv 172.31.110.20 4443 \
+	    || return 1
+
+	ovs_del_flows "$t" sctp4
+
+	info "verify connection fails without flows"
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' \
+	    '1' || return 1
+
+	kill -TERM $server_pid 2>/dev/null
+	echo "server2" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				ncat --sctp -l 172.31.110.20 -vn 4443
+	server_pid=$pid
+	ovs_wait sh -c \
+	    "[ \$(grep -c 'Ncat: Listening' ${ovs_dir}/stderr) -ge 2 ]" \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    ncat --sctp -w 2 -zv 172.31.110.20 4443 \
+	    >/dev/null 2>&1 \
+	    && { info "FAIL: connection should fail without flows"
+	         return 1; }
+
+	info "reinstall flows and verify recovery"
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4(proto=132),sctp(src=4443)' \
+	    '1' || return 1
+
+	kill -TERM $server_pid 2>/dev/null
+	echo "server3" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				ncat --sctp -l 172.31.110.20 -vn 4443
+	ovs_wait sh -c \
+	    "[ \$(grep -c 'Ncat: Listening' ${ovs_dir}/stderr) -ge 3 ]" \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    ncat --sctp -i 1 -zv 172.31.110.20 4443 \
+	    || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index e1ecfad2c03e..7cfc29ec7e59 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1982,6 +1982,11 @@ class ovskey(nla):
                 "icmp",
                 ovskey.ovs_key_icmp,
             ),
+            (
+                "OVS_KEY_ATTR_SCTP",
+                "sctp",
+                ovskey.ovs_key_sctp,
+            ),
             (
                 "OVS_KEY_ATTR_TCP_FLAGS",
                 "tcp_flags",
-- 
2.55.0


