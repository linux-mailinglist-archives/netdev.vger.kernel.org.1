Return-Path: <netdev+bounces-307638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WnDhEKToVmonCwEAu9opvQ
	(envelope-from <netdev+bounces-307638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD02759FAF
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iSwTP0Xf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307638-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307638-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C786330FC92C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB2387348;
	Wed, 15 Jul 2026 01:54:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604739022E
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080498; cv=none; b=nBBq0W8BP0RrtIK1ZXwfxNaEEjuZIgykMJbugSqVqUodFRB/m9q8AOYeYhmT5EffHpM4uSOc/QMg2nDBymoJ1gXUCqAcT8edv2JthT0w0B1sZ+0g6qeEb7clx/3eK8gO0N8J32DIyYcss1vSEYMrElL2gcML0wdNJRRDht+s9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080498; c=relaxed/simple;
	bh=QNQN46jr8AgeT+M0xf+mVU4LpUPUrkqGcEjYCEmR+HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4OKxnXeuKFejiUlfeTu3V2Czz8IYq6Laua1YNfYzmSJ43S1vfR4+a2D+Rw1lE1TgaaR91mRPS8JxMK5TCLhPRXMdUMhPd6YNnlz4rhcmMvpIcR5HSdLT9cc/v47m3RG1H2mUavEGX4ndSEgkT9+qSmcDd2LXVTjnRRosm1cfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSwTP0Xf; arc=none smtp.client-ip=209.85.210.50
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ec3b429a3aso1288847a34.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784080495; x=1784685295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/0I1HYJ2xHf0BHOz9366yIszPgKtlusu4Q0Xz6+ags=;
        b=iSwTP0XfJjJ5bv5m5ei6Y6zlE+7+hQgkuvClbzkZ8LonccRKoYdhoBJLwJlo5jov82
         0x6kGLB2Fq/Qq8rYNN26xoNbyvGeKmaf1Mc1Uezj4sa5aqwGg+VRkMceGGHgaB6x5fDF
         8zZk0OO6pblzdC4BIMyqOXLRp0O6lNTmFfvLGj5vOnBXbGTy0TREDHApYOo1RSiyYxdz
         UJkUpeu/h99VV3IeoVygSJZcaFQlYJ8GzeMoE6Khp+8sX9mkWDdk+Ow5su5hFknsYoe+
         KF35hzud/OcJn/ks1h/vEDkKRV6j1QYRlkNI2SICz2LDCzh0Yj/B9f2oQfDj28FnyIAv
         kr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784080495; x=1784685295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/0I1HYJ2xHf0BHOz9366yIszPgKtlusu4Q0Xz6+ags=;
        b=VyaPEsGO14Wz3OIiDX8iKTX1HVUvGcfVmkvY+efm3ZR7BsnlMZ0xsaLtdDPTsN9NCa
         1xhWUqNI9IxtqhwCCj96+fo2CCMsEW3VyFpK6Jt+8mqTwCNWoIOWT81wyR6Jc6LgPSeb
         +FKzwzBC5CeA5Sck6atLI1iZz3srQJshlaK3o28VigzqlzfcP8ie/Y5PGQSAqdT0Ht9g
         4Evzy7Hh5SUQZ6+mTi+KJxldVWZHQaH6URFVBbTfDycGUS74oNhI4KKUfNAB0R1RrrRn
         LCQbUbH7ct4grsTkYkaDu6lyyYZjojJ6Xic/QC8wtFbgsPcpyrRt4EMNJw0MjY4CS/il
         X76A==
X-Gm-Message-State: AOJu0YxxvL8vDsyS8yLTgCBQeraYKFQJfJTAk25ONu5pSy0U5e4wy7GP
	Ewl+0MuqYBhSTM94P4IcWGwfumpEgIbeseANu7r9aXOp/QSSyjA66ioT7ZrEDcAnBRm0FA==
X-Gm-Gg: AfdE7ckDVBP8PI5DrdhBlAHmglJ2kF8+ZyRpkxJy0n8zP9WP7C8INeJxWm5DZd1JvuR
	pLp23Ptu1NoBjda81CTnB2GP0oHHwhJU6vIEbDtobyhMA97GSJOJHvznZxGWRfxU/TCLJqWDjgX
	0Tg9Rqk/7JX3KeEp1EoDuFNXq8mOklHbKSxpqMgKX/sZHjQbTXamUhiCZqe2s7X47p2Ovub79gv
	lKLvnn3/MfcWA4RQYi4nUWL8ensZaBgRd0sP+Z3nFKLLqnrP3ei2etlJcDZCB3wN1uUQ1ghT+88
	JFe9XTqA8xBdVmGnpI2KF7VVvc+X5ZUQuU+K9LVLzb2pmiw+v5uUcW39SDuVL3pwSC7SmKs323A
	avza6NCUNlq03ckEGmBxu1UiFFETLbFmSH/9ogiFtOrzwkkPZSuTNV3tqWT9KDk62uShKyHVHUa
	q6kH8JpGmfc1Dd8cJsfduVQk2RuA==
X-Received: by 2002:a05:6830:290a:b0:7e9:e19f:c015 with SMTP id 46e09a7af769-7ec423e1b9amr3680873a34.30.1784080495328;
        Tue, 14 Jul 2026 18:54:55 -0700 (PDT)
Received: from houminxi ([61.170.160.153])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262db2sm16331598a34.16.2026.07.14.18.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:54:54 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
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
Subject: [PATCH net-next v3] selftests/net/openvswitch: add SCTP flow key test
Date: Tue, 14 Jul 2026 21:54:46 -0400
Message-ID: <20260715015446.530018-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307638-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CD02759FAF

Add test_sctp_connect_v4() to verify OVS can match on SCTP flow keys
(sctp src/dst port).

The test sets up client and server namespaces connected through an
OVS bridge, installs port-keyed flows, and verifies:
  - sctp(dst=4443) matches client-to-server INIT
  - sctp(src=4443) matches server-to-client INIT-ACK
  - removing flows drops the connection
  - reinstalling flows restores connectivity

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 105 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
 2 files changed, 110 insertions(+)

v2 -> v3:
  - replace ncat with nc for consistency with other tests in the same
    file (per Ilya Maximets' review)
  - add wait for killed daemon processes (per sashiko review)
  - replace 'Ncat: Listening' stderr grep with ss port-based readiness
    check

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..0ec9c969cd0a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	sctp_connect_v4				sctp: SCTP flow key matching
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,110 @@ test_action_set() {
 	return 0
 }
 
+# sctp_connect_v4 test
+# - sctp(dst=4443) matches client-to-server INIT
+# - sctp(src=4443) matches server-to-client INIT-ACK
+# - remove flows and verify connection fails, reinstall and recover
+test_sctp_connect_v4() {
+	local t="test_sctp_connect_v4"
+
+	which nc >/dev/null 2>&1 || return $ksft_skip
+	nc --sctp -z 127.0.0.1 1 </dev/null 2>/dev/null || return $ksft_skip
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
+				nc --sctp -l 172.31.110.20 -vn 4443
+	local server_pid=$pid
+	ovs_wait ip netns exec server \
+	    ss -lnH sport = :4443 \| grep -q . \
+	    || return 1
+
+	info "verify SCTP association with port-keyed flows"
+	ovs_sbx "$t" ip netns exec client \
+	    nc --sctp -i 1 -zv 172.31.110.20 4443 \
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
+	wait $server_pid 2>/dev/null
+	echo "server2" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				nc --sctp -l 172.31.110.20 -vn 4443
+	server_pid=$pid
+	ovs_wait ip netns exec server \
+	    ss -lnH sport = :4443 \| grep -q . \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    nc --sctp -w 2 -zv 172.31.110.20 4443 \
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
+	wait $server_pid 2>/dev/null
+	echo "server3" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				nc --sctp -l 172.31.110.20 -vn 4443
+	ovs_wait ip netns exec server \
+	    ss -lnH sport = :4443 \| grep -q . \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    nc --sctp -i 1 -zv 172.31.110.20 4443 \
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


