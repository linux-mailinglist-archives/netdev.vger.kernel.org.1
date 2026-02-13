Return-Path: <netdev+bounces-258612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNijNA4lj2lNKAEAu9opvQ
	(envelope-from <netdev+bounces-258612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3231364DC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82FDC3073D91
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15036074D;
	Fri, 13 Feb 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vcx5qEIk"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4135E556;
	Fri, 13 Feb 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988774; cv=none; b=tXztPDA5yq9CwElP0yx6W40XG1OReCyRsZxo7Cz1C5/mV6st/I6gBGRjFSXIH3jWIaKoe95YYwQsLPI98gDmhVaZO8lWtHIN0+Aibg97Hf4x2mgXTS7BfkxvbPLUomMzSXxGlBdMG/PcEeoj24yc00UR7d5GyL0V6+54J3A6Mi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988774; c=relaxed/simple;
	bh=zsFmpWRix+LX588rlGbg6RBUWzdhefraJWHeWfHLV1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bItmAaG1HWqhyxbuzOGuZyLnvxVd2lodr5MvfGMHaDRGPu2OlAnnB9JSHYEdhkpch1AVbJbwoHKDD7YEA0cQufGYEcGmmh+V8c8p4k9RRhtEetMKeW95eELAOXyMXi2uerxCMjMjPnz0KpSB3t1WvWrEKrG8MeOadDCi9hqheq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=vcx5qEIk; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=piwRbugQuOmQuGtJk8tRpvV4jIE0EEmGxdDcUHa7eBo=; b=vcx5qEIkAXrS
	YE3sK4gNDRaXMxbJfLFNNfEkcluDoIBYMdiE6TfGKjYkK+CGurjlUPi5rXMbgZrjDo5VD8HNJzaiO
	9hxNeghRJQejGf2L1uxUinF6jhCRsngM/GOGaYV88m9xZDWota5RDxvQG2UdrPQgX8K07jh4mq0dp
	1x3oyn9z4RJ+sc3/uHMu933GUyf55MxK13tQeJ0vAg7KD7bbqwdslawPv9FJcV6PhZ+BDkfUufs9c
	LBXpN2AnLqPv6toGmyfS9Xwlg8RJBsdl+k9MO/YrrSsknuJwBLiR4HdJYeRJouMkcyyW5gF9z2G+Q
	raDkh1JlNYfIM/DapxaB8Q==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vqt3q-0014Lj-0R;
	Fri, 13 Feb 2026 14:19:18 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61DDJLDR043380
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 13:19:21 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61DDJLRU043379;
	Fri, 13 Feb 2026 13:19:21 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v2 3/3] selftests: forwarding: fix pedit tests failure with br_netfilter enabled
Date: Fri, 13 Feb 2026 13:19:07 +0000
Message-ID: <20260213131907.43351-4-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
References: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258612-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,virtuozzo.com:mid,virtuozzo.com:dkim,virtuozzo.com:email]
X-Rspamd-Queue-Id: 4B3231364DC
X-Rspamd-Action: no action

The tests use the tc pedit action to modify the IPv4 source address
("pedit ex munge ip src set"), but the IP header checksum is not
recalculated after the modification. As a result, the modified packet
fails sanity checks in br_netfilter after bridging and is dropped,
which causes the test to fail.

Fix this by ensuring net.bridge.bridge-nf-call-iptables is set to 0
during the test execution. This prevents the bridge from passing
L2 traffic to netfilter, bypasing the checksum validation that
causes the test failure.

Fixes: 92ad3828944e ("selftests: forwarding: Add a test for pedit munge SIP and DIP")
Fixes: 226657ba2389 ("selftests: forwarding: Add a forwarding test for pedit munge dsfield")
Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/pedit_dsfield.sh | 8 ++++++++
 tools/testing/selftests/net/forwarding/pedit_ip.sh      | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
index af008fbf2725..eb2d8034de9c 100755
--- a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
@@ -98,12 +98,20 @@ setup_prepare()
 	h1_create
 	h2_create
 	switch_create
+
+	if [ -f /proc/sys/net/bridge/bridge-nf-call-iptables ]; then
+		sysctl_set net.bridge.bridge-nf-call-iptables 0
+	fi
 }
 
 cleanup()
 {
 	pre_cleanup
 
+	if [ -f /proc/sys/net/bridge/bridge-nf-call-iptables ]; then
+		sysctl_restore net.bridge.bridge-nf-call-iptables
+	fi
+
 	switch_destroy
 	h2_destroy
 	h1_destroy
diff --git a/tools/testing/selftests/net/forwarding/pedit_ip.sh b/tools/testing/selftests/net/forwarding/pedit_ip.sh
index d14efb2d23b2..9235674627ab 100755
--- a/tools/testing/selftests/net/forwarding/pedit_ip.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_ip.sh
@@ -91,12 +91,20 @@ setup_prepare()
 	h1_create
 	h2_create
 	switch_create
+
+	if [ -f /proc/sys/net/bridge/bridge-nf-call-iptables ]; then
+		sysctl_set net.bridge.bridge-nf-call-iptables 0
+	fi
 }
 
 cleanup()
 {
 	pre_cleanup
 
+	if [ -f /proc/sys/net/bridge/bridge-nf-call-iptables ]; then
+		sysctl_restore net.bridge.bridge-nf-call-iptables
+	fi
+
 	switch_destroy
 	h2_destroy
 	h1_destroy
-- 
2.43.0


