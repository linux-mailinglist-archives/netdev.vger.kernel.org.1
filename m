Return-Path: <netdev+bounces-258610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iENDMvAkj2m6KAEAu9opvQ
	(envelope-from <netdev+bounces-258610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:19:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7491364B0
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96631304706F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254835F8A6;
	Fri, 13 Feb 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WzQW+k/s"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00923536B;
	Fri, 13 Feb 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988771; cv=none; b=l/UvKuIe4Sc+FmqUgsloj7R7xmbVuwwE5DAKu1phnMVPdETXHJdDnd1nFYZmWf1nZfz33GRNRm5FLm+GiH1YKBCcObNs4KPmgj6ntx8QMB72yB1cXpYwpqUTP3ObN1WOK81dHvzhRBV2aBWq5asF8Nme6MZdWcL7+1dY+cT8818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988771; c=relaxed/simple;
	bh=vZzuCDwXSBbJSRkdH+RytmQj0C3INjcJ1OcEAXtUvpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYFNiwIi6zggd0nK4UBzTWei5J3wE7765V7v3qxM73SyOiAv4UmJmWD3xBfcZNQugr3ct9g0vUQjQemScNmA48i+L8oKfXIcCiyGg2BggIxDQmTPeLYj9Krph6yI5dk7WC5Mq1RJMbWMxo37PObk/YM7zd56ZsrUzmXcbSgQE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=WzQW+k/s; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=mMzKmUnXIqEs0GkFahmVZ4wldSpKVM7NEynNeSohp+s=; b=WzQW+k/sfsO6
	LLZkQQpHpPSnuJECdDkX1DUp+CbVW1G3cyR4dOitqhSLaco9T4hwf9ItVeMkzW4sgO1hgpS0IDmb0
	Xp3VI/cl2jFEYZrPq8GDjUBh6OIv81WQJBcp9+t01SA+54kuTY0q2ESrabdbYWGxbEt4kcQodx5g2
	y5/uN74FU/BmodNFx0AWEnrHmu+EW44vL4tX0l9KmTFrq1lSFxneVG6wfwCIaKYGAV8V3/cZfw6Ha
	mcRAx5uFwjaYpLauf2+eSaB5Xc0P8FRcfSLzqHQ/RqQiqBF1BhwRjRhB5nP8f0ntOFdw/CH2iWlUB
	PoZeGUyA0Km4NnUZ7oop6g==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vqt3h-0014LK-0j;
	Fri, 13 Feb 2026 14:19:09 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61DDJCKk043372
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 13:19:12 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61DDJCBo043371;
	Fri, 13 Feb 2026 13:19:12 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v2 1/3] selftests: forwarding: vxlan_bridge_1d: fix test failure with br_netfilter enabled
Date: Fri, 13 Feb 2026 13:19:05 +0000
Message-ID: <20260213131907.43351-2-aleksey.oladko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258610-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C7491364B0
X-Rspamd-Action: no action

The test generates VXLAN traffic using mausezahn, where the encapsulated
inner IPv4 packet contains a zero IP header checksum. After VXLAN
decapsulation, such packets do not pass sanity checks in br_netfilter
and are dropped, which causes the test to fail.

Fix this by calculating and setting a valid IPv4 header checksum for the
encapsulated packet generated by mausezahn, so that the packet is accepted
by br_netfilter. Fixed by using the payload_template_calc_checksum() /
payload_template_expand_checksum() helpers that are only available
in v6.3 and newer kernels.

Fixes: a0b61f3d8ebf ("selftests: forwarding: vxlan_bridge_1d: Add an ECN decap test")
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


