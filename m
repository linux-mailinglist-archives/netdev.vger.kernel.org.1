Return-Path: <netdev+bounces-258146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHP+GU5+i2kzUwAAu9opvQ
	(envelope-from <netdev+bounces-258146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:51:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE3A11E69F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A70D30151C9
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA838B7DE;
	Tue, 10 Feb 2026 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JkIiukWF"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470638B7BA;
	Tue, 10 Feb 2026 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749513; cv=none; b=Ur5r+5lsygFaMRDkYebjJ/DXN7LaTdN4TNZbiAkk0MsnwRerj4cyEqokqtvSAHco7IxOeoxaEBvFRj8Gq+9gi1/Oqf02VI0SAFqASCE+1di4q8k9dEixeNm5U0NQieQW2/i88SOINje5s0gNQ6bf7RYWRCC2NuKdak2pMR8KmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749513; c=relaxed/simple;
	bh=9qSWNqmZtl1eAid4nDqA9BtCZjbh+DXVBRur5Lnsbew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2+7g88XOjzeMnD1uEdnkwzOp8uBM8tiRWANI2TqTB34PBg+38txfM34WsfEWgSUMRcG/x8+cA3ehDKPUZy10utXw8VcM+6k3gqrKqbTqB79rHdh06e2sd1EfVRnC0ocFmQfZwogb35d11iseAnkwfkRvaxiyLyzG95QpK261uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=JkIiukWF; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=kvxXTq9rTsjJRgY8HpV206SkpT7OPYHYm1UHpG3IliU=; b=JkIiukWFLdJ6
	FowJ6KJU3y/ryYGTIDQ5nuGzh/UeElKuEt21ImeoAzqnaVpoSdjhLO5F0JVPxmd/RpiP52uBlhAgn
	pdLm+1z2oA3ftTr206csV4VJcbbvD74yGTgEdeYKOomjdspfvNHu9+01yKGH8RcYpYPMWAuzk7WNY
	Mb5jexgGmMBl6XEgmI/ieuvGF3X+l6tFiik0V1evQCv51WNlPKkmls4HGWWGjfj1ubPvKV0k3/0QX
	gQAk8efSt3cEwEjTX58uLHl+t3tNtjzQ0OP6o6n0uuDfITZ3FOhM1afAeLTavIbmdh6ddwdkdHDd/
	E+h+Q+YhPv4vHxwnL9mzSw==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vpsow-00DIAB-0K;
	Tue, 10 Feb 2026 19:51:36 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61AIpjFG480036
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 18:51:45 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61AIpj2E480035;
	Tue, 10 Feb 2026 18:51:45 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 1/3] selftests: forwarding: vxlan_bridge_1d: fix test failure with br_netfilter enabled
Date: Tue, 10 Feb 2026 18:51:27 +0000
Message-ID: <20260210185129.480015-2-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
References: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258146-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,virtuozzo.com:mid,virtuozzo.com:dkim,virtuozzo.com:email]
X-Rspamd-Queue-Id: CEE3A11E69F
X-Rspamd-Action: no action

The test generates VXLAN traffic using mausezahn, where the encapsulated
inner IPv4 packet contains a zero IP header checksum. After VXLAN
decapsulation, such packets do not pass sanity checks in br_netfilter
and are dropped, which causes the test to fail.

Fix this by calculating and setting a valid IPv4 header checksum for the
encapsulated packet generated by mausezahn, so that the packet is accepted
by br_netfilter.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 .../net/forwarding/vxlan_bridge_1d.sh         | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
index b43816dd998c..457f41d5e584 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh
@@ -567,6 +567,21 @@ vxlan_encapped_ping_do()
 	local inner_tos=$1; shift
 	local outer_tos=$1; shift
 
+	local ipv4hdr=$(:
+		    )"45:"$(                      : IP version + IHL
+		    )"$inner_tos:"$(              : IP TOS
+		    )"00:54:"$(                   : IP total length
+		    )"99:83:"$(                   : IP identification
+		    )"40:00:"$(                   : IP flags + frag off
+		    )"40:"$(                      : IP TTL
+		    )"01:"$(                      : IP proto
+		    )"CHECKSUM:"$(                : IP header csum
+		    )"c0:00:02:03:"$(             : IP saddr: 192.0.2.3
+		    )"c0:00:02:01"$(              : IP daddr: 192.0.2.1
+		)
+	local checksum=$(payload_template_calc_checksum "$ipv4hdr")
+	ipv4hdr=$(payload_template_expand_checksum "$ipv4hdr" $checksum)
+
 	$MZ $dev -c $count -d 100msec -q \
 		-b $next_hop_mac -B $dest_ip \
 		-t udp tos=$outer_tos,sp=23456,dp=$VXPORT,p=$(:
@@ -577,16 +592,7 @@ vxlan_encapped_ping_do()
 		    )"$dest_mac:"$(               : ETH daddr
 		    )"$(mac_get w2):"$(           : ETH saddr
 		    )"08:00:"$(                   : ETH type
-		    )"45:"$(                      : IP version + IHL
-		    )"$inner_tos:"$(              : IP TOS
-		    )"00:54:"$(                   : IP total length
-		    )"99:83:"$(                   : IP identification
-		    )"40:00:"$(                   : IP flags + frag off
-		    )"40:"$(                      : IP TTL
-		    )"01:"$(                      : IP proto
-		    )"00:00:"$(                   : IP header csum
-		    )"c0:00:02:03:"$(             : IP saddr: 192.0.2.3
-		    )"c0:00:02:01:"$(             : IP daddr: 192.0.2.1
+		    )"$ipv4hdr:"$(                : IPv4 header
 		    )"08:"$(                      : ICMP type
 		    )"00:"$(                      : ICMP code
 		    )"8b:f2:"$(                   : ICMP csum
-- 
2.43.0


