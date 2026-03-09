Return-Path: <netdev+bounces-265623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H334AP/wrmnGKgIAu9opvQ
	(envelope-from <netdev+bounces-265623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252323C7DE
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CA1319965C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C13D5226;
	Mon,  9 Mar 2026 16:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DA3E5EC7;
	Mon,  9 Mar 2026 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072257; cv=none; b=AlFVG52CfGfxOz/zFBNOx07K5aAYKOvKkFDx03rPpEh2V+FVNx+b9/TCvA4eGVKVwQGY0LgnmvoxMinBSI9P13ISE3crUsdIisJdLIs/cHDI2b329GtdgRTG5f9g9mjyvfHhPz0r/NsvEgtLBDtC+/oDNOUqJOAzXxtCB72wG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072257; c=relaxed/simple;
	bh=YQIh3iNHCHXWcQVEVV2uLPxl6ztZn3Z0aolgOoSBPTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4MVxdTq8RqQhyhRZHNWSHHcJ09qa4HZ1yE7dCJ93Lp7rejF/MdUHllQ1xM+x1tmUvgKKLVsjMoK7z08orAUip5LyOUqYCeFRbYrRZbxz2AsoH9gPqn3tzAd9Ah3DmVWJJHTK2NA9rAo8K4/T4grRD4O0RWOzaL8921TWEmjOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vzd5M-000000005at-3Ohq;
	Mon, 09 Mar 2026 16:04:00 +0000
Date: Mon, 9 Mar 2026 16:03:57 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH] selftests: net: local_termination: test link-local protocols
Message-ID: <a085c707b3085eea58850f125c51a8868c5fb6f1.1773072062.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 5252323C7DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nxp.com,makrotopia.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.398];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[local_termination.sh:url,makrotopia.org:mid,makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add tests to local_termination.sh to verify that link-local frames
arrive. On some switches the DSA driver uses bridges to connect the
user ports to their CPU ports. More "intelligent" switches typically
don't forward link-local frames, but may trap them to an internal
microcontroller. The driver may have to change trapping rules, so
link-local frames end up on the DSA CPU ports instead of being
silently dropped or trapped to the internal microcontroller of the
switch.

Add two tests which help to validate this has been done correctly:
 - Link-local STP BPDU should always arrive at the Linux netdev
 - Link-local LLDP should arrive at standalone ports (and the test
   should be skipped on bridged ports similar to how it is done
   for the IEEE1588v2/PTP tests)

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../net/forwarding/local_termination.sh       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 1f2bf6e818477..9bc9d25e71368 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -100,6 +100,15 @@ PTP_1588_IPV6_PDELAY_REQ=" \
 00 00 3e 37 63 ff fe cf 17 0e 00 01 00 01 05 7f \
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
 00 00 00 00 00 00"
+LINK_LOCAL_STP_BPDU=" \
+01:80:c2:00:00:00 00:00:de:ad:be:ef 00 26 42 42 03 \
+00 00 00 00 00 80 00 aa bb cc dd ee ff 00 00 00 00 \
+80 00 aa bb cc dd ee ff 80 01 00 00 14 00 02 00 \
+0f 00"
+LINK_LOCAL_LLDP=" \
+01:80:c2:00:00:0e 00:00:de:ad:be:ef 88:cc 02 07 04 \
+00 11 22 33 44 55 04 05 05 65 74 68 30 06 02 00 \
+78 00 00"
 
 # Disable promisc to ensure we don't receive unknown MAC DA packets
 export TCPDUMP_EXTRA_FLAGS="-pl"
@@ -213,7 +222,15 @@ run_test()
 	mc_route_destroy $rcv_if_name
 	mc_route_destroy $send_if_name
 
+	ip maddress add 01:80:c2:00:00:00 dev $rcv_if_name
+	send_raw $send_if_name "$LINK_LOCAL_STP_BPDU"
+	ip maddress del 01:80:c2:00:00:00 dev $rcv_if_name
+
 	if [ $skip_ptp = false ]; then
+		ip maddress add 01:80:c2:00:00:0e dev $rcv_if_name
+		send_raw $send_if_name "$LINK_LOCAL_LLDP"
+		ip maddress del 01:80:c2:00:00:0e dev $rcv_if_name
+
 		ip maddress add 01:1b:19:00:00:00 dev $rcv_if_name
 		send_raw $send_if_name "$PTP_1588_L2_SYNC"
 		send_raw $send_if_name "$PTP_1588_L2_FOLLOW_UP"
@@ -304,7 +321,15 @@ run_test()
 		"$smac > $UNKNOWN_MACV6_MC_ADDR3, ethertype IPv6 (0x86dd)" \
 		true "$test_name"
 
+	check_rcv $rcv_if_name "Link-local STP BPDU" \
+		"> 01:80:c2:00:00:00" \
+		true "$test_name"
+
 	if [ $skip_ptp = false ]; then
+		check_rcv $rcv_if_name "Link-local LLDP" \
+			"> 01:80:c2:00:00:0e" \
+			true "$test_name"
+
 		check_rcv $rcv_if_name "1588v2 over L2 transport, Sync" \
 			"ethertype PTP (0x88f7).* PTPv2.* msg type *: sync msg" \
 			true "$test_name"
-- 
2.53.0

