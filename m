Return-Path: <netdev+bounces-293295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBUbBSxIGmrP2ggAu9opvQ
	(envelope-from <netdev+bounces-293295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:15:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE1F60AEA8
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63955301DED2
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA831715D;
	Sat, 30 May 2026 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsVcDVvh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3430C60E
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780107305; cv=none; b=maF1pTP0c17o73cbZW1ZOjjRRChRk71YBtSPEF2dpLnu/E1gBCvXa76pgNbdBa/xAAdhOPiC6xPejkb7a+nU31C9JWuOhas9b/BLVYRxP5S1KCgqrCUcfBNdB1JGyQzQr82ynTqZXZLQfqphL0Mf7Fj7HEI8lq0hfAngFix9zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780107305; c=relaxed/simple;
	bh=8+8eewby6tCNXhI7PtA6+ck9wTW1UcajL2XqbVrzwOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNbJoJxmwLfx5mdNrwhx6Oiwo85iBfxIax5fAhbxuBDzbyUZfjb9aiEDNRx5WmnMSaVaEpQLRjcO1JXkkHgUeMq1rYErgS+dNyYP3IPi7w2lGzGbw0U5S0CVrg79dbqxDQefGFL6AJdSkW0ptVqLf5Y6HMmgkfQacON0y+pLWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsVcDVvh; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304f590dd91so916796eec.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780107303; x=1780712103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6zD0KOajb7NsFpcEukeTlW8n3/6TkB9MtUuXmii4w4=;
        b=VsVcDVvhLGKZFJXp6ikisEkeXi3a4gdyWbkNNvNMpgwmNim4C+/100Nyf62HeiuBzS
         ONUt48CmSbTvqtjudX8RVYL8yaC6AulTgsQ9BtK13qB5qiqQmPEt/gKMXMUBVa8r+Xi9
         1QY1Y8ghdatlF68g2VIG3Gb4O/Ns5SRvUKiUkfMrohG1OSxa5qKaW7r/H245DRdHbhse
         rJ9E8nqzoBcCuGYASEklv3VWFaJToqTVjeqDjEf52xvqoTFf2siZXmU0nsSoepLncVie
         RxOthJz7PL3CejVTD/5SHZxMC+Fcymzozz38q1X//1Ch+jABhk+u+Ai6wdUdKDQ8pS2t
         Riag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780107303; x=1780712103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6zD0KOajb7NsFpcEukeTlW8n3/6TkB9MtUuXmii4w4=;
        b=gAI+AL85k2RBUxSrwAxjVkP5rTJc3CiDb4SrwBcFYpgsj36Sk3qHBMaWYytto/P9mn
         yKqBpXbsBQ3F1IFoee6Xq7Hb49pIikfHud6deez9Q7ODw5TG3S8QYbNSY8U+QRYIV4n+
         l4X89Ji4oGv2WxG5uD0vQeaQpTelklTsIGEqqlpwm8iOK8i9S75VASb6p6cXIoj92en6
         d59F18VhybICGre1XlABE7DTFmVrCfYnUJW6B5zxfT07cPeVgoe25GWWn6XBPzySfoNo
         p3uXyVj6yQOFVB0n/+Zn1AccKHb4tgpRwyXeogjXRz9G/XmuK3/uZDvq1p7TbLba9CA/
         jGBA==
X-Gm-Message-State: AOJu0Yx10V3BLKKt5BgLQnkzsr/F4fMC3vOiO02VXzCiKqz8rf6cjCsx
	DyPpVDOhUbInuiTMyaKBv2ZyhCw2kC3E2nSB/0TjOa1MhqDxUk7r9Ocu1KqTj3ZPYis=
X-Gm-Gg: Acq92OHrgIv0MFHLWjdPUbRYmUP2m93ULVi3tVkb9LyrY5XnUPudbubfkDnM4togHqv
	ebpMPl76rOzkWMzao70QvfJpMJ8qxV2isLGh3vZKw0MefH4rVgcrMMLJ0M6V7nygsMSxotN17CY
	473LlivsMHgFuDtfFcRg93aQtifSdUNdhkwwJEQN5Z2dUayf/Kfd3QghW5IOuvevjqhSvVc4nh9
	wIaPf5IrJPflrlUs+oIOnCDLk2N8VbOq6diaPPPv3EWcUf2RCp/shrgP5T1TwpfMZpDHzTzMb/y
	8dbjq1qs7TCXcj/a8yXDlfF+PXwtmKn6AOp1uE8ibxCF5zQOBt04LRzkzeeE2YlcjbbXqM857oq
	KxtY9cOv8i7hkPkJi74b4OjTdi+1PKvyuxI/8nRGqDdRPIGiFCdzpe5E6fcfHFDY3MsNT6ke46x
	XaA+gc8sRxZw8AbgI+qAEyJ8KOCtI=
X-Received: by 2002:a05:7300:724d:b0:304:bce9:25fa with SMTP id 5a478bee46e88-304fa525843mr1077488eec.4.1780107302753;
        Fri, 29 May 2026 19:15:02 -0700 (PDT)
Received: from houminxi ([64.118.153.39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c312csm3080012eec.6.2026.05.29.19.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 19:15:02 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	echaudro@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5] selftests: openvswitch: add dec_ttl action support and test
Date: Sat, 30 May 2026 10:14:43 +0800
Message-ID: <20260530021443.1734484-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,ovn.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EE1F60AEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add dec_ttl action support to the OVS kernel datapath selftest
framework:

  - Add dec_ttl nested NLA class to ovs-dpctl.py with proper
    OVS_DEC_TTL_ATTR_ACTION sub-attribute handling
  - Add parse support for dec_ttl(le_1(<inner_actions>)) action
    string, consistent with the odp-util.c format where le_1()
    holds the actions taken when TTL reaches 1
  - Add dpstr output formatting for dec_ttl actions
  - Add test_dec_ttl() to openvswitch.sh that verifies:
    * Normal TTL packets are forwarded after decrement
    * TTL=1 packets are dropped (TTL expiry)
    * Graceful skip via ksft_skip if kernel lacks dec_ttl support

The dec_ttl class uses late-binding type resolution to reference
ovsactions for its inner action list, avoiding circular references
at class definition time.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
---
v5: shorten test list description to fix checkpatch line-length
    warning (85 cols -> 78 cols with tab expansion)
v4: fix three new pylint warnings introduced in v3:
    - add docstring to class dec_ttl (C0115)
    - suppress invalid-name for class dec_ttl (C0103)
    - rename parsedLen to parsed_len in the parser (C0103)
v3: rename NLA class from DecTtl to dec_ttl (snake_case)
v2: use dec_ttl(le_1(...)) format, consistent with odp-util.c
    (suggested by Aaron Conole)

 .../selftests/net/openvswitch/openvswitch.sh  | 55 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 39 ++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 8cd5b3d894ab..a415e9dec8cd 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -29,6 +29,7 @@ tests="
 	tunnel_refcount				ovs: test tunnel vport reference cleanup
 	drop_reason				drop: test drop reasons are emitted
 	pop_vlan				vlan: POP_VLAN action strips tag
+	dec_ttl					ttl: dec_ttl decrements IP TTL
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -245,6 +246,60 @@ usage() {
 }
 
 
+test_dec_ttl() {
+	sbx_add "test_dec_ttl" || return $?
+	ovs_add_dp "test_dec_ttl" decttl || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_dec_ttl" "decttl" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 10.0.0.1/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 10.0.0.2/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	# Probe: check if kernel supports dec_ttl action.
+	ovs_add_flow "test_dec_ttl" decttl \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+		'dec_ttl(le_1())' &>/dev/null
+	if [ $? -ne 0 ]; then
+		info "no support for dec_ttl - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+
+	ovs_del_flows "test_dec_ttl" decttl
+
+	# ARP flows (bidirectional)
+	ovs_add_flow "test_dec_ttl" decttl \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_dec_ttl" decttl \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	# IP flows with dec_ttl action
+	ovs_add_flow "test_dec_ttl" decttl \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+		'dec_ttl(le_1()),2' || return 1
+	ovs_add_flow "test_dec_ttl" decttl \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' \
+		'dec_ttl(le_1()),1' || return 1
+
+	info "verify connectivity with dec_ttl"
+	ovs_sbx "test_dec_ttl" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	info "verify TTL=1 is dropped by dec_ttl"
+	ovs_sbx "test_dec_ttl" ip netns exec client ping -c 1 -W 2 \
+		-t 1 10.0.0.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail with TTL=1 and dec_ttl"
+		     return 1; }
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 3b6a26e265a4..3342e295293d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -388,11 +388,21 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_CLONE", "recursive"),
         ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
-        ("OVS_ACTION_ATTR_DEC_TTL", "none"),
+        ("OVS_ACTION_ATTR_DEC_TTL", "dec_ttl"),
         ("OVS_ACTION_ATTR_DROP", "uint32"),
         ("OVS_ACTION_ATTR_PSAMPLE", "psample"),
     )
 
+    class dec_ttl(nla):  # pylint: disable=invalid-name
+        """Nested OVS_DEC_TTL_ATTR_* sub-attributes."""
+
+        nla_flags = NLA_F_NESTED
+
+        nla_map = (
+            ("OVS_DEC_TTL_ATTR_UNSPEC", "none"),
+            ("OVS_DEC_TTL_ATTR_ACTION", "actions"),
+        )
+
     class psample(nla):
         nla_flags = NLA_F_NESTED
 
@@ -635,6 +645,13 @@ class ovsactions(nla):
                 print_str += "ct_clear"
             elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
                 print_str += "pop_vlan"
+            elif field[0] == "OVS_ACTION_ATTR_DEC_TTL":
+                datum = self.get_attr(field[0])
+                print_str += "dec_ttl(le_1("
+                subacts = datum.get_attr("OVS_DEC_TTL_ATTR_ACTION")
+                if subacts and subacts.get("attrs"):
+                    print_str += subacts.dpstr(more)
+                print_str += "))"
             elif field[0] == "OVS_ACTION_ATTR_PUSH_VLAN":
                 datum = self.get_attr(field[0])
                 tpid = datum["vlan_tpid"]
@@ -786,6 +803,20 @@ class ovsactions(nla):
                 actstr = actstr[paren + 1:]
                 parsed = True
 
+            elif parse_starts_block(actstr, "dec_ttl(le_1(", False):
+                parencount += 2
+                subacts = ovsactions()
+                actstr = actstr[len("dec_ttl(le_1("):]
+                parsed_len = subacts.parse(actstr)
+                decttl = ovsactions.dec_ttl()
+                decttl["attrs"].append(
+                    ("OVS_DEC_TTL_ATTR_ACTION", subacts)
+                )
+                self["attrs"].append(
+                    ("OVS_ACTION_ATTR_DEC_TTL", decttl)
+                )
+                actstr = actstr[parsed_len:]
+                parsed = True
             elif parse_starts_block(actstr, "clone(", False):
                 parencount += 1
                 subacts = ovsactions()
@@ -957,6 +988,12 @@ class ovsactions(nla):
         return (totallen - len(actstr))
 
 
+# pyroute2 resolves nla_map types via getattr(self, name).
+# dec_ttl needs "actions" to resolve to ovsactions, but
+# ovsactions is not defined when dec_ttl class body runs.
+ovsactions.dec_ttl.actions = ovsactions
+
+
 class ovskey(nla):
     nla_flags = NLA_F_NESTED
     nla_map = (
-- 
2.54.0


