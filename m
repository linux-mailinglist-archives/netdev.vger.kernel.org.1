Return-Path: <netdev+bounces-262356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ9wGKujo2mRIwUAu9opvQ
	(envelope-from <netdev+bounces-262356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 03:25:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68671CD8A9
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 03:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E392A3516D8F
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807172FDC27;
	Sun,  1 Mar 2026 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A4g0gTbk"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119C2FE577
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330562; cv=none; b=OTp6A02jjRmyymYKPu5HDdUnSQCqiOo1PDOmAOSqHyJbOct3z8ZFl8QK63EU9dMxjhl4ktyS5KEQC2IFFvyoNIrJWRd+gEveWhlWwmhbNTSKpCLJFnDL7BM7SzGasQkR4u0d7gt9OnYfDJRLKpZSUIKdIw/k85kNdhurOr0OnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330562; c=relaxed/simple;
	bh=Kdg7Xf8W1Cmbmj0cjpTRVWbmr3wrfz0FHa1eGLUS4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrHIHeGxJiTgNaI1m6K+PnCNQCYIPmgbwdTa+068Wccs5OKRyBWuzEsuiwCgZl01wPkTXH+CSlSswypxUbrxoEQRIwZABcTVZQlWynLtos/1cFqUQYVxVVL9mzt9HZiGyInnU/FSXqZBZA3wTiAhz2cMoIxBVGhkvP8QhbGcpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=A4g0gTbk; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=01eX58DYYoF4zbyQXiM2CCggLRdSBFTsTJlkXC7cPSE=; b=A4g0gTbk5dlo
	f0nmr/r6zigMNmvllTv5gUilTp+A2zf7veiNjUtKJUATngEfEcY/Rn0khrUcYOCL93j33FVBQEEDq
	NJTDNIevIEpTTkVzs1Rm52AcixSdC6CPU3HLasew9raoucMipU1YIjZNSvfWCOdqtsx81vEy8V/en
	MS/pPH3YwknoUJDrbqsUUBdRzr+wMhnyM1EMJ3LJ+pHAuavuBa8gr1zMlyvzTufgHWBrqR7BCIS1t
	P0Z+WvS3axeK3e9BeAjbtE/uSgcTDPl7SCLgUUy0BENOCxgZvUH+cL7RCUj6c0UEjSQU5Z+dIdlcl
	qw/K7RGGdYeU35GfQblqhQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vwVsS-00CZeA-01;
	Sun, 01 Mar 2026 02:47:09 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 6211lDgb454254
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 1 Mar 2026 01:47:13 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 6211lB0i454253;
	Sun, 1 Mar 2026 01:47:11 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Nir Dotan <nird@mellanox.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net] selftests: net: forwarding: fix IPv6 address leak in cleanup
Date: Sun,  1 Mar 2026 01:47:06 +0000
Message-ID: <20260301014706.454243-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262356-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B68671CD8A9
X-Rspamd-Action: no action

Several forwarding tests (e.g., gre_multipath.sh) initialize both IPv4
and IPv6 addresses using simple_if_init, but only clean up IPv4
in simple_if_fini. This leaves stale IPv6 addresses on the interfaces,
which causes subsequent tests to fail when they encounter unexpected
address configuration.

The issue can be reproduced by running tests in sequence:
  # run_kselftest.sh -t net/forwarding:ipip_hier_gre.sh
  # run_kselftest.sh -t net/forwarding:min_max_mtu.sh
  TAP version 13
  1..1
  # timeout set to 0
  # selftests: net/forwarding: min_max_mtu.sh
  # TEST: ping                                                          [ OK ]
  # TEST: ping6                                                         [ OK ]
  # TEST: Test maximum MTU configuration                                [ OK ]
  # TEST: Test traffic, packet size is maximum MTU                      [FAIL]
  #       Ping6, packet size: 65487 succeeded, but should have failed
  # TEST: Test minimum MTU configuration                                [ OK ]
  # TEST: Test traffic, packet size is minimum MTU                      [ OK ]
  not ok 1 selftests: net/forwarding: min_max_mtu.sh # exit=1

Fix this by adding the missing IPv6 argument to simple_if_fini in
all affected tests.

Fixes: fed926d4f64c ("selftests: forwarding: Add IP tunneling lib")
Fixes: 902280cacc03 ("selftests: forwarding: Add resilient multipath tunneling nexthop test")
Fixes: 54818c4c4b93 ("selftests: forwarding: Test multipath tunneling")
Fixes: e035146d6560 ("selftests: forwarding: Add multipath tunneling nexthop test")

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/gre_multipath.sh        | 2 +-
 tools/testing/selftests/net/forwarding/gre_multipath_nh.sh     | 2 +-
 tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh | 2 +-
 tools/testing/selftests/net/forwarding/ipip_lib.sh             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index 57531c1d884d..397422cd5aea 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -72,7 +72,7 @@ h1_create()
 h1_destroy()
 {
 	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
-	simple_if_fini $h1 192.0.2.1/28
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
 }
 
 sw1_create()
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
index 7d5b2b9cc133..c667b81da37f 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
@@ -80,7 +80,7 @@ h1_destroy()
 {
 	ip route del vrf v$h1 2001:db8:2::/64 via 2001:db8:1::2
 	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
-	simple_if_fini $h1 192.0.2.1/28
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
 }
 
 sw1_create()
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
index 370f9925302d..d04bad58a96a 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
@@ -80,7 +80,7 @@ h1_destroy()
 {
 	ip route del vrf v$h1 2001:db8:2::/64 via 2001:db8:1::2
 	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
-	simple_if_fini $h1 192.0.2.1/28
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
 }
 
 sw1_create()
diff --git a/tools/testing/selftests/net/forwarding/ipip_lib.sh b/tools/testing/selftests/net/forwarding/ipip_lib.sh
index 01e62c4ac94d..a5c23a28d50e 100644
--- a/tools/testing/selftests/net/forwarding/ipip_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ipip_lib.sh
@@ -151,7 +151,7 @@ h1_create()
 h1_destroy()
 {
 	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
-	simple_if_fini $h1 192.0.2.1/28
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
 }
 
 h2_create()
-- 
2.43.0


