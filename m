Return-Path: <netdev+bounces-257980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPTdN7Evimm3IAAAu9opvQ
	(envelope-from <netdev+bounces-257980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:04:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41567113E90
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E057C301F300
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D02E764D;
	Mon,  9 Feb 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b="YCgOkDNN"
X-Original-To: netdev@vger.kernel.org
Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305620DE3
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663854; cv=none; b=tDHChWa7v+2bqOnx4PNvi3MJrtcFEkJNWcwtDuozWRPpLCc2kdguYl3/ShgwT0t1A3oa3QGvW38uV07IaOGHObSMqki4OP2ogKZaHFDpWZ/2kyql7mONTPi643CMJ5ySLcmYOqW+JbXRXnlp/JPQMwJ45UPLvszk1jB5tdkqQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663854; c=relaxed/simple;
	bh=4WvYbNgWmzxEk2+3eQyHicHsmfsCW0v2jYdsjM8bx84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mf7PtiwUGoApOXhdSH+THvGI5i6fGidYhFU48aKYVXX+/r9DDxHAPCa7TNujfnZaDArcV5Ae3DtFS6dHYDeeDYRTfPvzcW7Jttwo1A7zlYQMxEn4oOl5faH0LAu2cbJ5htZdq507nIh8YYUZ9V4xyDqsKvDE1QYSS+7kYrFTPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org; spf=pass smtp.mailfrom=sphalerite.org; dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b=YCgOkDNN; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sphalerite.org
From: Linus Heckemann <git@sphalerite.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sphalerite.org;
	s=sosiego; t=1770663845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FJVcZIWspUyrDyDkwhEbEHeEU7XOTOwn4/TUDnfV/tY=;
	b=YCgOkDNNkmObSf+Jo5STVhTm1j5LnIQhjIxHGCHAr17iFQw5ooueecnAk8okPkSqHpo0dw
	MkLJShPkA0Zynp2UDRpNgsOL3WZCKK5GPlJxuS2bLuWWZulprA09mUuwgEiKkiZqj0IYPf
	8lhpSQHius0WMsJxWWCWul5ormZHjDQ=
To: edumazet@google.com,
	liuhangbin@gmail.com
Cc: davem@davemloft.net,
	eric.dumazet@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	morikw2@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com,
	Linus Heckemann <git@sphalerite.org>
Subject: [PATCH v2] selftests/net: add test for IPv4-in-IPv6 tunneling
Date: Mon,  9 Feb 2026 20:00:09 +0100
Message-ID: <20260209190008.139099-2-git@sphalerite.org>
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
	R_DKIM_ALLOW(-0.20)[sphalerite.org:s=sosiego];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,sphalerite.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@sphalerite.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sphalerite.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41567113E90
X-Rspamd-Action: no action

commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
__ip6_tnl_rcv()") was fine in and of itself, but its backport to 6.12
(and 6.6) broke IPv4-in-IPv6 tunneling, see [1]. This adds a self-test
for basic IPv4-in-IPv6 and IPv6-in-IPv6 functionality.

[1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/

--
Thanks for the review, Hangbin!
---
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/ip6_tunnel.sh | 43 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)
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
index 0000000000000..4886618fd2689
--- /dev/null
+++ b/tools/testing/selftests/net/ip6_tunnel.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# Test that IPv4-over-IPv6 tunneling works.
+
+source lib.sh
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
+  ip link delete transport1 || true
+}
+
+trap cleanup EXIT
+setup_prepare
+ip netns exec $ns1 ping -W1 -c1 172.0.0.2
+ip netns exec $ns1 ping -W1 -c1 2001:db8:6::2
-- 
2.52.0


