Return-Path: <netdev+bounces-258149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hx7OK9+i2kzUwAAu9opvQ
	(envelope-from <netdev+bounces-258149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:53:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1C11E71B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3780E3075A92
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D707399010;
	Tue, 10 Feb 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fj4L7dfB"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83439A816;
	Tue, 10 Feb 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749519; cv=none; b=sK7V9l4PTnsG9wB2uMBlZfPFGObh49EVTIMMRfBM/PA2LguM1/Cs7pIC3NY11RffYCqU2+fjFnys4qelhdrIIlS7oyPx3fdAzPoLjusowNOwzhC94u5KMCZJiR0ypVeKF0kS23r7MyZ2tMxZIdR3NDIrXm5pzWAmKEJ/dzDr96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749519; c=relaxed/simple;
	bh=i74Zuxfo66vmMqVjJGNwfc07THhDPoiG/0JuRpfvdq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQlG7QW5YleMOyvBDr9c+cQkQAVvIVokmAuiF49lrwsge071FOwqQcmrwuRb2YnTHC4xg+Bl5f4u3H7SWON5qEidaXyKfmrzDEhRpnxawCjC+XrMYNDA5pGLusCMx1HtvngCqSqGCq/p75RUHneDa9KcOxFhwX5g0DMB4qoG/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Fj4L7dfB; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=ot7Tdf4uDPS0aoShzU4t4fRC4FoKO2YRKcBiMOsi3xI=; b=Fj4L7dfBP/ZqkqDgrNv
	xCNHvsz099m40/5Ta0eUWaJJxGS1QZl2AqHJnDzz41g47nrVlj/8LMfWAaKER8jxhw9BHJuVE4Tji
	MoVzfDu9bxYxajatufewxL5OgZtST6BeIU2re8ao99hGWwPPsu2l7E5hvuyv0ne3jaNqbKniFgY6z
	olq9goozrIYFZcVBwXAn2m2VlSssPJrrIZ+QBLE46Jp5hc+AtOSxJDt5A7RpR29YDRWt4GwCMW276
	tHDZ79rJNdZj3BUNPDQZN1ybP6cYA10lY/HGN5jxOaayQtet9tK+IlBW7E29DlsmE4kYBE8tVYx5+
	ThYWasZSabKpb5A==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vpsp3-00DJs2-0O;
	Tue, 10 Feb 2026 19:51:43 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61AIpqXB480044
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 18:51:52 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61AIpq2m480043;
	Tue, 10 Feb 2026 18:51:52 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 3/3] selftests: forwarding: fix pedit tests failure with br_netfilter enabled
Date: Tue, 10 Feb 2026 18:51:29 +0000
Message-ID: <20260210185129.480015-4-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
References: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,virtuozzo.com:mid,virtuozzo.com:dkim,virtuozzo.com:email,pedit_ip.sh:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258149-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+]
X-Rspamd-Queue-Id: 8FF1C11E71B
X-Rspamd-Action: no action

The tests use the tc pedit action to modify the IPv4 source address
("pedit ex munge ip src set"), but the IP header checksum is not
recalculated after the modification. As a result, the modified packet
fails sanity checks in br_netfilter after bridging and is dropped,
which causes the test to fail.

Fix this by adding an explicit checksum recalculation using the
"csum ip" action, so the modified packet contains a valid IPv4
checksum.

Note on IPv6:
  The tests in pedit_ip.sh also cover IPv6 (test_ip6_src, test_ip6_dst).
  The csum ip action is harmless for IPv6 packets since IPv6 has no
  header checksum — it will be a no-op.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/pedit_dsfield.sh | 5 +++--
 tools/testing/selftests/net/forwarding/pedit_ip.sh      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
index af008fbf2725..310f96fb2274 100755
--- a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
@@ -156,7 +156,7 @@ do_test_pedit_dsfield()
 	local daddr=$1; shift
 
 	tc filter add $pedit_locus handle 101 pref 1 \
-	   flower action pedit ex munge $pedit_action
+	   flower action pedit ex munge $pedit_action pipe action csum ip
 	tc filter add dev $h2 ingress handle 101 pref 1 prot $match_prot \
 	   flower skip_hw $match_flower action pass
 
@@ -229,7 +229,8 @@ do_test_ip_dscp_ecn()
 
 	tc filter add $locus handle 101 pref 1				\
 	   flower action pedit ex munge ip dsfield set 124 retain 0xfc	\
-		  action pedit ex munge ip dsfield set 1 retain 0x03
+		  action pedit ex munge ip dsfield set 1 retain 0x03	\
+		  pipe action csum ip
 	tc filter add dev $h2 ingress handle 101 pref 1 prot ip		\
 	   flower skip_hw ip_tos 125 action pass
 
diff --git a/tools/testing/selftests/net/forwarding/pedit_ip.sh b/tools/testing/selftests/net/forwarding/pedit_ip.sh
index d14efb2d23b2..a53ee3b1ef67 100755
--- a/tools/testing/selftests/net/forwarding/pedit_ip.sh
+++ b/tools/testing/selftests/net/forwarding/pedit_ip.sh
@@ -122,7 +122,7 @@ do_test_pedit_ip()
 	local mz_flags=$1; shift
 
 	tc filter add $pedit_locus handle 101 pref 1 \
-	   flower action pedit ex munge $pedit_action
+	   flower action pedit ex munge $pedit_action pipe action csum ip
 	tc filter add dev $h2 ingress handle 101 pref 1 prot $match_prot \
 	   flower skip_hw $match_flower action pass
 
-- 
2.43.0


