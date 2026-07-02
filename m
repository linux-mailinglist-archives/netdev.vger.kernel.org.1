Return-Path: <netdev+bounces-304020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i8yIFwMcRmp9KAsAu9opvQ
	(envelope-from <netdev+bounces-304020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75636F48F9
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EX4m0bpx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304020-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430453039CBB
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A853C4540;
	Thu,  2 Jul 2026 07:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74C3C415E
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:49:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978579; cv=none; b=uYJrx5Wwd9buXEN4wdCkimHpDcC9RSBei1LxPfWLxDKLHPgeOShG3L/fEh4LUE9seDv9TF7x+5V3Fvj4biTFcVri7s3Yr/Ulh+D2RogdLOGVT2C7/Q8Ew4vM8Z15F++s7n4AB4Z4qgdVQY8f3eCCytX6rEk5q/1MsIB2XY2F93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978579; c=relaxed/simple;
	bh=5aY6jgDGxHHuKKofEbdBbN3i11i7tJ7gyBsJWfhgjYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9P67Leh+mGS4wkGmbVnKqe0sIlS/tS48qCXHzj8qACzOMnoaZ6GmafS4gEZKUx78UiV0ScFo3IQFo3A/98DgXtvQgOegzV929pKQKOyNQyP/8w8d8gulxQjZXcC+2FSgeoOOA5WU2QXIjWZI4ysue+5nvPhNMa9C1bJ0QhpukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX4m0bpx; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80dd4766206so17239447b3.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782978575; x=1783583375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dNM3gzN7WGtyObjROoTO4V+/DlyZKbxSjH6yLNERms=;
        b=EX4m0bpxQWZ/juNcvvXLXkKF234lViBrLwwWbMNOdHL1AomnlmAqIzQYyfx1EBdcwv
         EVE9EG1uaA7kYXJjh1qCjOO36mC85Wpewr31iB7+3vqFl9yEW0lfF5UOYZvxNF3Qh0fT
         Vq0ItcxxbUNjHwPgPAqv7hlMBoJlCyq9dy6CP8wVhyYiMcoW0kufGV0F5TQFOd7xOpE6
         9+ab+n+KXUH+P6ybuVgtwuDoiaN57NHbyNwaDJFsmUWbt35wLU3HGiPnIcuZqQubzF6q
         aECRKLwtQu0psrWEvqmBiLid/k/tA7YbKPRUQ0g89Gh64JYPjWA8woMcdzwRqhSi/WCv
         ueBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978575; x=1783583375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dNM3gzN7WGtyObjROoTO4V+/DlyZKbxSjH6yLNERms=;
        b=qAEOl+ATtUofj56kTFXI+qEratEJFlWJhbERN7TN3jdudaxMWqUFsgfVSNOC1wqgGY
         q9o5MEmyA0G397U9V2Bc6ISrJT8gxVxLGUsTwHdpq5GbmP5lKFaKY8r6UEhZLUOfRAqY
         Bj+a/4PUF5nL1urpKAhtSomz/MIr+BZBDUAho9IQgopVaxwM1ee9VknD9ugN9SlBzT+1
         Qt20MnbFRu943tKs3WKUNOXohtfkOOYw4Wz33q2Fsd4eXuQHpqqef9QLusklp+74NEN/
         eZzk9aUkJXjkjnDHDB602dwkZJ6cKKpifbVRUuuMR7nfqOmRk0jhHbgaaEko6e4TBh2u
         K6yQ==
X-Gm-Message-State: AOJu0Yzf76mS4uI7b0gL3lRBfMIZ5lZzZOxxYalHaCJYcFWiqkxoXYDJ
	AsmerTJD2q6aelAabjWqCK0txlLi/nastKlNO7WcHOw7GP2igdEVwRjamhJOSw==
X-Gm-Gg: AfdE7cmgVjRvWWOa5WMzXBYtLzFTJZiuwBnxrupJl3K9THBK2jGah3sZWlWApmTvUmd
	haOG8UELU2Q7a1pXBw3qWKqUCNyRcdYm5mKHXQ+f8+ygMudiXzAp24miil028kLXtOWfROvIMZM
	0s12GQuhoO8hzb9znp07LwkvAr3fPpk96VA8QMPj6WQjw7a7iWN1QXE2+cP2N2zeljICPRxRe7E
	ngn8OIP6cpUNNR7jK5JaUds/B4/YHKPyLwCiTfZ/Ll8opT51xhHNT9QDYC+pWzfRiivuWiV+7PF
	7ChD3102DsxXLAXZ1FOZRQiTnP5BBNOvNuFCYbrd7ArvcDiy9hh/S823hxHzCnhZQtbQ4YNIcCJ
	tG5lKa7kM0+NJbprS/FF1sTtLLgyENEcVLNId3WFSSg9O5FW3V1MuO0NwrHpVu3ZTCrXGViiMN/
	gC3Xwa
X-Received: by 2002:a05:690c:670c:b0:7f8:7e50:638d with SMTP id 00721157ae682-812eb1790c2mr60976337b3.47.1782978575064;
        Thu, 02 Jul 2026 00:49:35 -0700 (PDT)
Received: from houminxi ([23.133.88.228])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144af52bd6sm9417827b3.28.2026.07.02.00.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:49:33 -0700 (PDT)
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
Subject: [PATCH net-next v3] selftests/net/openvswitch: add output truncation test
Date: Thu,  2 Jul 2026 03:49:26 -0400
Message-ID: <20260702074926.1174810-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304020-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A75636F48F9

Add test_trunc exercising the OVS_ACTION_ATTR_TRUNC action. The test
verifies truncation limits in four steps: reject trunc(1) and
trunc(13) which are below ETH_HLEN, confirm normal forwarding works,
apply trunc(14) which truncates packets to the Ethernet header and
verify ping fails, then restore normal forwarding and verify recovery.

The kernel requires max_len >= ETH_HLEN (14 bytes). trunc(14) sets
OVS_CB(skb)->cutlen so pskb_trim strips the IP payload at output
time; the receiver drops the runt frame and no echo reply is
generated.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..f75ee723415a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	trunc					trunc: output truncation
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,92 @@ test_action_set() {
 	return 0
 }
 
+# trunc test
+# - trunc(14): truncate to ETH_HLEN, strips IP payload, ping fails
+# - trunc(1) and trunc(13): kernel rejects below ETH_HLEN (EINVAL)
+# - restore normal forwarding and verify recovery
+test_trunc() {
+	sbx_add "test_trunc" || return $?
+	ovs_add_dp "test_trunc" trunctest || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_trunc" "trunctest" \
+		    "$ns" "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 10.0.0.1/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 10.0.0.2/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+	    '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4()' \
+	    '1' || return 1
+
+	info "verify connectivity without truncation"
+	ovs_sbx "test_trunc" ip netns exec client \
+	    ping -c 1 -W 2 10.0.0.2 || return 1
+
+	# trunc below ETH_HLEN must be rejected by the kernel
+	info "verify trunc(1) is rejected"
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+	    'trunc(1),2' &> /dev/null \
+	    && { info "trunc(1) should be rejected"; return 1; }
+
+	info "verify trunc(13) is rejected"
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+	    'trunc(13),2' &> /dev/null \
+	    && { info "trunc(13) should be rejected"; return 1; }
+
+	ovs_del_flows "test_trunc" trunctest
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	info "add trunc(14) forwarding flow"
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+	    'trunc(14),2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4()' \
+	    '1' || return 1
+
+	info "verify ping fails with trunc(14)"
+	ovs_sbx "test_trunc" ip netns exec client \
+	    ping -c 1 -W 2 10.0.0.2 >/dev/null 2>&1 \
+	    && { info "ping should fail with trunc(14)"
+	         return 1; }
+
+	ovs_del_flows "test_trunc" trunctest
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+	    '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4()' \
+	    '1' || return 1
+
+	info "verify connectivity restored"
+	ovs_sbx "test_trunc" ip netns exec client \
+	    ping -c 1 -W 2 10.0.0.2 || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
-- 
2.54.0


