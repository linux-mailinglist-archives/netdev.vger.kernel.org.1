Return-Path: <netdev+bounces-304054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NhITHugtRmrALAsAu9opvQ
	(envelope-from <netdev+bounces-304054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC96F530D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CGW8nOdr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304054-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304054-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE89E31AA4FA
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BD47D930;
	Thu,  2 Jul 2026 09:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED447AF66
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:09:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983358; cv=none; b=r2AALssDWr9AkXEUiD/4vi1ybNdJ1dRvego8Ek0ARWRJ1fAHtVnwHEkc1KIe9NrF+j+0i7+tiyxHU6Z++W98WF1/8a40t8aFQ2N/ZaJko0hu6z/sjp9SMJVvmki/itMSruufADANG0k/QsSL22XrCCQHysSFG5ji/vOeL2hVF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983358; c=relaxed/simple;
	bh=X8BM8CFdrVr64i5oR/ogrqx0u/nHaSGxTJtuTfxxlCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOtd8oCaboeSymW7+sLZ3m0IZGVMSni/NSHlRhmi6h1XqUcRZxKJv3/FEna+FpTnAMXJ8bw/Q0eNK448ofh3gKj/yx/tmwKcwR3FWTMxwRmnYsaRqihgk2wZDXFfvMqfOp1u2Uoghw8sCNgSO4TELXp1KvyD2GhJSwi7YWXjk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGW8nOdr; arc=none smtp.client-ip=74.125.224.42
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664b05d408bso1447225d50.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782983355; x=1783588155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyfsxJg+kjzT4zTmiCCR7ZMxnpzzdi+ueWMGl0wz2n0=;
        b=CGW8nOdrNkl5R9l5ocBfKVrULkoa1PCL7fFWTBpOFIpF8jRFG3ecIG9h9VQkshfbHt
         VW+xr1xiBuManQLIvQUx0psc6YJennW8Q9XVCZkyeeAre+44TCySgg4Vo49QyLCgDlRS
         jcb3e6DKSoSY9FToWRxz10zUwluDAx8/rYXLdMgKYF952S1Bpyzz0EEZw3ihR6UN/EiP
         A0e580izNddzHEqTddancua21f1vF3QxIzPSweSd7kpc3sC0MZh+U/JjTg8yQblXG8Z6
         H5KXnQyGVRClmjRgRY2KrzGb+emW+FhffxUJIYOGfATNck0OnBBTxilSssA+CbPtVEE9
         4+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983355; x=1783588155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyfsxJg+kjzT4zTmiCCR7ZMxnpzzdi+ueWMGl0wz2n0=;
        b=EB2Dn0KnF7Ji/uFTuV0OLLlmfwvIx8mk0WueP5BupfWBEFTQuzXD3NytwD+iLTaKH9
         XYQ9R6hdh8CiBgR0vw7i+/ypGaBAkdsBMV5/KXlpcK5w4a6pGlGerpFZ/CBzb8M9UZLx
         8oA6n6q7nZ5tAK6rS1zMMG/bfvAvpX6vzIWEkDsjnk4KKsyf39LiBJW8py7yuRqaWM+l
         +hoKpKAtRL1yt+WwNN2KR4v4uiOM/KNiqHx965bg5wfWU7RMWNFaVwFAtvAM0Bchk/vn
         +qMpRmvfEMRxpNAopZ0GLFXQ2wXFkEps3DXk6K6yJ5l2U3Chy9f6dAdG6zjnw01tu7Iw
         9uJw==
X-Gm-Message-State: AOJu0YxYHzwgk5XOUztho450ROho04zq8NtzDOy9r/muBrLp0h3jYD2J
	yw9IUOuR3TM5HRLv1G+ZkcjPbKpca8mhEb7M7M68VvEphCE991LpFI1TYLYnYxjR/MA=
X-Gm-Gg: AfdE7cnkl5gjzKjLnDyQYx10EdWv5wvJ4wj0xseMEjnPd/zPN2ATQvZ0/gIFlWqSgMX
	H7XyeY/x5DKNn+VUE+DdavYfV/0n2IEgyrhwCimgjRtv3Fh/TU+cwoKymiiUs20PPYWCwwAY6cC
	/GZSRX8sILDut9ykah7PD75O0IQbMDn6YgyfXnSSX6j1YDiOdjaYEVxi+hf1BrY05rbQYGJ6YfQ
	Db9+85g8TqCDOJZQL4BzI2T2tv9veWo7Pcx+O3FPgzAq6+cW8h9AW2vCEYI2u2UwHLjhqn01kQp
	G5aqMynMoBvljOE/obtozIEBs2ekcCe9C3qq/2i10WnFe31XtnlY37HbhF6G7aNbCidh59vqHY5
	fpAHSRgI60JmXdG967r4JdQI1rV0zf/R0u/ybo4JhO4QcrXq8AmTEHLDdgOPcDhcgAQxa0QkoFC
	qWkuXirUWlL7w0hQ==
X-Received: by 2002:a53:ac83:0:b0:664:d671:bff4 with SMTP id 956f58d0204a3-665915ae8e7mr4442469d50.4.1782983355137;
        Thu, 02 Jul 2026 02:09:15 -0700 (PDT)
Received: from houminxi ([61.170.226.21])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66624026c3asm837487d50.13.2026.07.02.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:09:14 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests/net/openvswitch: add SCTP flow key test
Date: Thu,  2 Jul 2026 05:09:08 -0400
Message-ID: <20260702090908.1253688-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304054-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:houminxi@gmail.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18DC96F530D

Register OVS_KEY_ATTR_SCTP in the flow key parser so that sctp()
can be used in flow specifications. The ovs_key_sctp class already
exists (with src/dst fields matching the TCP/UDP siblings) but was
not wired into the parser, so the token was silently dropped and the
kernel rejected the flow.

Add test_sctp_connect_v4 exercising the SCTP flow key with
port-specific matching: sctp(dst=4443) for client-to-server and
sctp(src=4443) for server-to-client, mirroring the SCTP four-way
handshake direction. The test verifies connectivity with flows
installed, confirms failure after flow removal, then reinstalls
and verifies recovery.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 92 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |  5 +
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..dd4d0b3bcc23 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	sctp_connect_v4				sctp: SCTP flow key matching
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,97 @@ test_action_set() {
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
+	sleep 0.1
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
+	echo "server2" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				ncat --sctp -l 172.31.110.20 -vn 4443
+	sleep 0.1
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
+	echo "server3" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				ncat --sctp -l 172.31.110.20 -vn 4443
+	sleep 0.1
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
2.54.0


