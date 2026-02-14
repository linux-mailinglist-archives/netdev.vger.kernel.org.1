Return-Path: <netdev+bounces-258690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I8ZJDYtkGm3WgEAu9opvQ
	(envelope-from <netdev+bounces-258690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 09:07:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6D13B592
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 09:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3444E301A919
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8449283FCF;
	Sat, 14 Feb 2026 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b="Huo1g6C/"
X-Original-To: netdev@vger.kernel.org
Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48949271464
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771056421; cv=none; b=sJkixxtGq4dprWHFWzG6xd0Iw++KwNm7biIu7iGOeCEpl9/IlqxhmkbFjO4h+QdxVMXL77Getul6WynyYnTn/MX/tKee1MTKv/KozLT4UND18ZNj3UeLBCHa436FV0ZEGFoEktPxj6imdGLF0t7Iltb8MIYA1vjNzxZFAPh0CnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771056421; c=relaxed/simple;
	bh=FDKHFxncRn13iDTcrsQ2kzNlmIEbXmK1dizXIA5zyjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt6bYrnEGswLLI8V8Jh9+d8i/5rh+/XMrMzoDYtwlqs8cVsHgxH7syFW1PTO+GgnDdAUVGfPVdGTX/DO0Ii4VKjdLoze1Q5Xy8FL+/vNYh9vh7ILkFgospArwRLBXm4kORqjPyns62JSiPf2ABdBVtjyGikZziIi8O5p+MyFeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org; spf=pass smtp.mailfrom=sphalerite.org; dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b=Huo1g6C/; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sphalerite.org
From: Linus Heckemann <git@sphalerite.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sphalerite.org;
	s=sosiego; t=1771056410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ndp31Nq0BrH5gpGv+1gDSXPSLt/ARY5/16E9fsEEUs=;
	b=Huo1g6C/7WEn8fLQXf4oWj6vN1gdSzCfOLQYhQVJqBnhQwXaDb0VI7sSb4uoCtVFFSr+i5
	zlbyqa+KMQg98L5pH1Is1c4d4vwNOuYMC9f5WHYdbyW5og5kkHVCWIC/PWyMNXCE3EcS66
	ZHWYvYvhzG88gCzOLDt7DBIhVvNnJlQ=
To: edumazet@google.com,
	liuhangbin@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	eric.dumazet@gmail.com,
	horms@kernel.org,
	morikw2@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com,
	rbm@suse.com,
	Linus Heckemann <git@sphalerite.org>
Subject: [PATCH v3] selftests/net: add test for IP-in-IPv6 tunneling
Date: Sat, 14 Feb 2026 09:05:54 +0100
Message-ID: <20260214080553.1317672-2-git@sphalerite.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sphalerite.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sphalerite.org:s=sosiego];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[sphalerite.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@sphalerite.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,suse.com,sphalerite.org];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ip6_tunnel.sh:url]
X-Rspamd-Queue-Id: EFF6D13B592
X-Rspamd-Action: no action

commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
__ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
(and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.

[1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/

Signed-off-by: Linus Heckemann <git@sphalerite.org>
--
Compared to previous version:
* Added DCO as requested by Jakub
* Suppressed output of ping and the expected-to-fail `ip link delete` cleanup invocation as suggested by Jakub
* Added `set -e` as suggested by Hangbin

Not sure about the etiquette regarding the Tested-by line: Ricardo
tested v1 of the patch, I guess I shouldn't add it to a respin?
---
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/ip6_tunnel.sh | 44 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/net/ip6_tunnel.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 45c4ea381bc36..5037a344ad826 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -43,6 +43,7 @@ TEST_PROGS := \
 	io_uring_zerocopy_tx.sh \
 	ioam6.sh \
 	ip6_gre_headroom.sh \
+	ip6_tunnel.sh \
 	ip_defrag.sh \
 	ip_local_port_range.sh \
 	ipv6_flowlabel.sh \
diff --git a/tools/testing/selftests/net/ip6_tunnel.sh b/tools/testing/selftests/net/ip6_tunnel.sh
new file mode 100644
index 0000000000000..fe081a5218199
--- /dev/null
+++ b/tools/testing/selftests/net/ip6_tunnel.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# Test that IPv4-over-IPv6 tunneling works.
+
+source lib.sh
+set -e
+
+setup_prepare() {
+  ip link add transport1 type veth peer name transport2
+
+  setup_ns ns1
+  ip link set transport1 netns $ns1
+  ip -n $ns1 address add 2001:db8::1/64 dev transport1 nodad
+  ip -n $ns1 address add 2001:db8::3/64 dev transport1 nodad
+  ip -n $ns1 link set transport1 up
+  ip -n $ns1 link add link transport1 name tunnel4 type ip6tnl mode ipip6 local 2001:db8::1 remote 2001:db8::2
+  ip -n $ns1 address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel4
+  ip -n $ns1 link set tunnel4 up
+  ip -n $ns1 link add link transport1 name tunnel6 type ip6tnl mode ip6ip6 local 2001:db8::3 remote 2001:db8::4
+  ip -n $ns1 address add 2001:db8:6::1/64 dev tunnel6
+  ip -n $ns1 link set tunnel6 up
+
+  setup_ns ns2
+  ip link set transport2 netns $ns2
+  ip -n $ns2 address add 2001:db8::2/64 dev transport2 nodad
+  ip -n $ns2 address add 2001:db8::4/64 dev transport2 nodad
+  ip -n $ns2 link set transport2 up
+  ip -n $ns2 link add link transport2 name tunnel4 type ip6tnl mode ipip6 local 2001:db8::2 remote 2001:db8::1
+  ip -n $ns2 address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel4
+  ip -n $ns2 link set tunnel4 up
+  ip -n $ns2 link add link transport2 name tunnel6 type ip6tnl mode ip6ip6 local 2001:db8::4 remote 2001:db8::3
+  ip -n $ns2 address add 2001:db8:6::2/64 dev tunnel6
+  ip -n $ns2 link set tunnel6 up
+}
+
+cleanup() {
+  cleanup_all_ns
+  # in case the namespaces haven't been set up yet
+  ip link delete transport1 &>/dev/null || true
+}
+
+trap cleanup EXIT
+setup_prepare
+ip netns exec $ns1 ping -q -W1 -c1 172.0.0.2 >/dev/null
+ip netns exec $ns1 ping -q -W1 -c1 2001:db8:6::2 >/dev/null
-- 
2.52.0


