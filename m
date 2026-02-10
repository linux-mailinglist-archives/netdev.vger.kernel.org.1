Return-Path: <netdev+bounces-258148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJeTEI9+i2kzUwAAu9opvQ
	(envelope-from <netdev+bounces-258148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:53:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72011E6E5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A30D306A317
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1AE393DDC;
	Tue, 10 Feb 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PiMhhJuQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D6B39448B;
	Tue, 10 Feb 2026 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749517; cv=none; b=FgK8d3trczvF9LwOOWv1LVSEOLnVYoSZL6fE4e00X+MNRCKsVsGJA24ysII5o/W8f2CvXJ0W6TK/LIstf8LNuyLkjaRISLZ31ex4bOw8z73icOO2+/zciBZ7bUQBcFEB/vRZN2jAVFhEqiBXEzRpPuTLiVRks1xM2EKkWgqmED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749517; c=relaxed/simple;
	bh=E0PbZC8PEYwiRCBXwi6xK0GwQ4bGRsWMgQpxNYKH6NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eocgQ4C1xqLX+HCNyoOvYq/IBM6flezVQMvzPoV5YQVU1K9zCbP4Qhzt2c4g9sMu5ozne+scsjJonfUOxHfSkRb3otYbW1A6iAWhQC/phTo0PBILiN1hbQ4QtqrREXe78T+kEuIQ8SqFMx9CIXnPsobRYZG7GboSOuH5qzlP6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=PiMhhJuQ; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=GcQUDSAjUqO9ChaaBwPRlImvElsS6HbUiMepA5nvobY=; b=PiMhhJuQjuZEjYZxgd3
	f/YLoRzbz1AmFvJwk8ootRuQw1fBq2f4cgpVC/rwJvMh/u4PwUYwWmRzePgv6r4EqBJRvHnbqEPt8
	7rjgbNT2+PHz+wnouPBHfp28NTE2ftuahWKDeoaDEqvqJUVzWvLdeoFt5qmMxSFI8DDoPRXwmBcll
	mI5Rr+ixjIIlwmEM5S0McuhL/NrfLAJVpOgFWEVKOTntz5yNiY1Bvj7+KY3d/hTlQA4heyuPFyKUe
	YtB476Gf4PbTCkNzh1CyQAwQU93g06uVi6xDY8/BJIzozt0UtjZ/VW6wM6Z565lC/O9k2s/4Xa5Kk
	vuSZoFUixIN8UHQ==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vpsp0-00DJJB-11;
	Tue, 10 Feb 2026 19:51:40 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61AIpnRh480040
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 18:51:49 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61AIpnh4480039;
	Tue, 10 Feb 2026 18:51:49 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 2/3] selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with br_netfilter enabled
Date: Tue, 10 Feb 2026 18:51:28 +0000
Message-ID: <20260210185129.480015-3-aleksey.oladko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,virtuozzo.com:mid,virtuozzo.com:dkim,virtuozzo.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258148-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+]
X-Rspamd-Queue-Id: AF72011E6E5
X-Rspamd-Action: no action

The test generates VXLAN traffic using mausezahn, where the encapsulated
inner IPv6 packet has an incorrect payload length set in the IPv6 header.
After VXLAN decapsulation, such packets do not pass sanity checks in
br_netfilter and are dropped, which causes the test to fail.

Fix this by setting the correct IPv6 payload length for the encapsulated
packet generated by mausezahn, so that the packet is accepted
by br_netfilter.

tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
lines 698-706

              )"00:03:"$(           : Payload length
              )"3a:"$(              : Next header
              )"04:"$(              : Hop limit
              )"$saddr:"$(          : IP saddr
              )"$daddr:"$(          : IP daddr
              )"80:"$(              : ICMPv6.type
              )"00:"$(              : ICMPv6.code
              )"00:"$(              : ICMPv6.checksum
              )

Data after IPv6 header:
• 80: — 1 byte (ICMPv6 type)
• 00: — 1 byte (ICMPv6 code)
• 00: — 1 byte (ICMPv6 checksum, truncated)

Total: 3 bytes → 00:03 is correct. The old value 00:08 did not match
the actual payload size.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
index a603f7b0a08f..e642feeada0e 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
@@ -695,7 +695,7 @@ vxlan_encapped_ping_do()
 		    )"6"$(			  : IP version
 		    )"$inner_tos"$(               : Traffic class
 		    )"0:00:00:"$(                 : Flow label
-		    )"00:08:"$(                   : Payload length
+		    )"00:03:"$(                   : Payload length
 		    )"3a:"$(                      : Next header
 		    )"04:"$(                      : Hop limit
 		    )"$saddr:"$(		  : IP saddr
-- 
2.43.0


