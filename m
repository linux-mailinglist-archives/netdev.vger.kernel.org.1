Return-Path: <netdev+bounces-257831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zBghGx6jiGl1tAQAu9opvQ
	(envelope-from <netdev+bounces-257831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 15:52:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B35108FC5
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 15:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3403300CC32
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB9C30BF58;
	Sun,  8 Feb 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b="SanwMKJc"
X-Original-To: netdev@vger.kernel.org
Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE02BE625
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770562331; cv=none; b=AQqcyW9q6nmC6C84X9+XLhNMqZIaqBTvFtMvRFyHxP8/kYcfH33QIfXSenOnaT8PFrUjIdsEn+rcHzZBQ47Lrishk8Xwu7Nd9f72i6zy02K4zxPptrI2LXwS5BtiHrv+o6KX6tGoOMOM8N4duDNWa5PZqPW1BHnFcbEY59JysQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770562331; c=relaxed/simple;
	bh=0GFHpJHeQA4xgRgC/eddXmbmlTAepY6nfLARfumGHZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7PYfNOYCwOOQ48pwyIvvkvSFslxHL1MPq9ep+KAXdRuvW3vNa3qRUZs7cI0p1ev4n0CR1Bcv5oUaISdu6iaTBdwzdtLYW2oBdGyvYUtzv17fInQcfbg2CTHOxxZvOZPSX3iYPcm6XOG1oyYta1yNUhtay+nt7Z2iwk18f5HuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org; spf=pass smtp.mailfrom=sphalerite.org; dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b=SanwMKJc; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sphalerite.org
From: Linus Heckemann <git@sphalerite.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sphalerite.org;
	s=sosiego; t=1770561968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8agyu74u1TuCSvxzsqVi4rOHN69kwIiRIbDoVuRnFJE=;
	b=SanwMKJcO1jnk7dZsVR226fmQzCVHMk7xp606Nj8mABKsIimn4S3ZEQ6DCBDp92x8HWZje
	K3DIjk4fgi5TGQfD5zE3ExIJtdacyVD8GBXALWscPqAG3lSn0/zr98Ryiv53eTROoMHBqV
	Q2wDLdjx0fBDKP7LeSK1XCs+yiYZGHU=
To: edumazet@google.com
Cc: davem@davemloft.net,
	eric.dumazet@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	morikw2@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com,
	Linus Heckemann <git@sphalerite.org>
Subject: [PATCH] selftests/net: add test for IPv4-in-IPv6 tunneling
Date: Sun,  8 Feb 2026 15:46:04 +0100
Message-ID: <20260208144604.1550582-1-git@sphalerite.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sphalerite.org,quarantine];
	R_DKIM_ALLOW(-0.20)[sphalerite.org:s=sosiego];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,sphalerite.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257831-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@sphalerite.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sphalerite.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A2B35108FC5
X-Rspamd-Action: no action

81c734dae203757fb3c9eee6f9896386940776bd was fine in and of itself, but
its backport to 6.12 (and 6.6) broke IPv4-in-IPv6 tunneling, see [1].
This adds a self-test for basic IPv4-in-IPv6 functionality.

[1]: https://lore.kernel.org/all/CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com/
---
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/ip6_tunnel.sh | 41 +++++++++++++++++++++++
 2 files changed, 42 insertions(+)
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
index 0000000000000..366f4c06cd6a3
--- /dev/null
+++ b/tools/testing/selftests/net/ip6_tunnel.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# Test that IPv4-over-IPv6 tunneling works.
+
+set -e
+
+setup_prepare() {
+  ip link add transport1 type veth peer name transport2
+
+  ip netns add ns1
+  ip link set transport1 netns ns1
+  ip netns exec ns1 bash <<EOF
+  set -e
+  ip address add 2001:db8::1/64 dev transport1 nodad
+  ip link set transport1 up
+  ip link add link transport1 name tunnel1 type ip6tnl mode ipip6 local 2001:db8::1 remote 2001:db8::2
+  ip address add 172.0.0.1/32 peer 172.0.0.2/32 dev tunnel1
+  ip link set tunnel1 up
+EOF
+
+  ip netns add ns2
+  ip link set transport2 netns ns2
+  ip netns exec ns2 bash <<EOF
+  set -e
+  ip address add 2001:db8::2/64 dev transport2 nodad
+  ip link set transport2 up
+  ip link add link transport2 name tunnel2 type ip6tnl mode ipip6 local 2001:db8::2 remote 2001:db8::1
+  ip address add 172.0.0.2/32 peer 172.0.0.1/32 dev tunnel2
+  ip link set tunnel2 up
+EOF
+}
+
+cleanup() {
+  ip netns delete ns1
+  ip netns delete ns2
+  # in case the namespaces haven't been set up yet
+  ip link delete transport1
+}
+
+trap cleanup EXIT
+setup_prepare
+ip netns exec ns1 ping -W1 -c1 172.0.0.2
-- 
2.52.0


