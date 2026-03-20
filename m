Return-Path: <netdev+bounces-269923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCxqJNRTvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:04:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C22DB85E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0473011F27
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9663A6B9F;
	Fri, 20 Mar 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ZsKtRKbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACC3BBA17
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015204; cv=none; b=tlw07W9p4ohlq0TLt777tXzztPWautQWvqazmR5CFZQuQJ3JO/C5npzZ0A9xA9dV3tBG07JrXIQEXfOUL/YgVom5qTFB6rG8VJ3wJnQxv/Y3Uf2+jCN1HBKecdaef/KM7k4Qz7L50dK8fKFtBRCwZ7Dz8ehUVmoY+pwpg3V1vCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015204; c=relaxed/simple;
	bh=dBwaCSZBdDssZVKTAnmoq01jrdQrKsOdNu8j6J0fJeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAaowuN1kWHHJJ6XEmZRyLxvc3UAv1I3H25LnmAtWqNcLZHkX5MFJyHY/Xiis6vvJdHDt5I6NXm1aqRZqar4qvQWjY+59J8pPnjpKz2zhCl+BPYsVFs48YSNHT24Fn/k7QtcvitoZQ52qipnJbyPizgsTztESOM+57dX7vqR/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ZsKtRKbB; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so16268815e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015196; x=1774619996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaGQ7bAe7Qv2bP6EwvdVuCN6lWQ/fgqQXKLbW79lSys=;
        b=ZsKtRKbBlLU/O5DiCycBOXWDeR2VAUfKDSwRAE0vsdD9rUqHrKBlZKGg8YpAWj0nZ5
         kPgfKcsdTktAf1lh6QaV2VoS8ZLJNXAEx64vxikKU0KHMmibOBfRldW9OGRtqpL1BUjW
         L25n3D9A9N7VTK4ntboV5Jwdq0v0CwaAk5xZk/kX7f7GoNbHlB1ECZWAIvdrbI6fEtIT
         4vnhcGssDhaN9HoHxnreYS3sto1sQq91EYllWUr0ZtPAhfTmtG/+TYclovP5K1mecNRt
         d+2qDsXek/p3lzrHPHPagCW6ChMshHM073/UaMIH/HP3MFoojfRYiInim6MOJpzwmevB
         0B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015196; x=1774619996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZaGQ7bAe7Qv2bP6EwvdVuCN6lWQ/fgqQXKLbW79lSys=;
        b=AHnYkcfltwCO2XrCB++T5dBHtZ5TRQYsU7sUYnzb9rhcX5b5Udlb0OAZy73TXV/1Q7
         /Jg3dJTw0rJYxVsT68hPiOBmCWz4Sebc9W5q0KcDyhrHd4aZPjk2KcGr7IUah+TcvEqA
         Eq4rLtZxcqAhjbYtxEnlhsTJFxveg0kyuMH1Zs+P6LzQU0QmWR7L+9MEawiOohVw2Y7z
         4fcYoGGXhexCp4fulMkFWFlB6gHBPOcuf/dqn7+HnghXipaMOg4Abc1RfkRoa/gub/vy
         hS0bdXW49ahizW4eKOOrdnI2/y0nHW616NQAHsrZ+0u08RQOwZDqUyU2+QuhsNTi90wy
         A6EA==
X-Gm-Message-State: AOJu0YzSmRejrjTMGPazVL+GSYRvoavpEcf3TQr+bHZF9mWTpGYk7s7i
	nx4QghMBuMP7Sd/sEJLngC0w7WNeN/VZ/GVQKbuyB27/5wPTPiVev9SWZ4FWvDsQ4uMvO43IDqd
	OOWzXvuFHn24F0PW85Oyl/jlFtgXzOh6vxkTT
X-Gm-Gg: ATEYQzxdsn75iLiP9PLGKtFsQbyHqX1f1uKIV0zJN6jTOT4ckgiFpEzwZi9pFcBcE5D
	SMPpbtDPttAXv+oNO4sOR1e8whLcTXVjHtes7Tx4zHnTeEnh3iJClHcWXUcbe3yzp+uxtBzLQt0
	8ZK65PtsPg7fNVOXRzSizfAdRtaFUNk1vCQUTALlTZ0DaNeVQcPwZTaw2OPlha/dk/aVHxzREzs
	by3bYNdWtB+ggE6Z7jBChjbOoNqN6Yy9XjJBm0fdgAKQj2MZZ8mYWiIIT609/R+mSzSpfXuAYO0
	NpVkCojtlb0AYZYrxo0TySa+XCw8nSXwKOcZl8dmKbvuJy1yR4oXOVA2jwayrZSWiVP8j2pXP5Q
	VNAjJqIJpti2pqlFwgEfSYaCVAuUuUQuO/GzJ6cTRKOI+S/sRbdSNB6DbGm8ABdaAflVE4htvbg
	==
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id 5b1f17b1804b1-486ff01efcdmr47257075e9.32.1774015196335;
        Fri, 20 Mar 2026 06:59:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-486fe7e3b16sm1152305e9.6.2026.03.20.06.59.56;
        Fri, 20 Mar 2026 06:59:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 387321C273;
	Fri, 20 Mar 2026 14:59:56 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 2/2] selftests: add check for seg6 tunsrc
Date: Fri, 20 Mar 2026 14:59:09 +0100
Message-Id: <20260320135909.1729313-3-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260320135909.1729313-1-justin.iurman@6wind.com>
References: <20260320135909.1729313-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269923-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.931];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,encap.red:url,srv6_hencap_red_l3vpn_test.sh:url,6wind.com:dkim,6wind.com:email,6wind.com:mid,encaps.red:url]
X-Rspamd-Queue-Id: 0B3C22DB85E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
"tunsrc" feature. If there is no support for tunsrc, it silently
falls back to the encap config without tunsrc.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 .../net/srv6_hencap_red_l3vpn_test.sh         | 95 ++++++++++++++++---
 1 file changed, 82 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
index 6a68c7eff1dc..a6e32279a1f7 100755
--- a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
@@ -193,6 +193,8 @@ ret=${ksft_skip}
 nsuccess=0
 nfail=0
 
+HAS_TUNSRC=false
+
 log_test()
 {
 	local rc="$1"
@@ -345,6 +347,14 @@ setup_rt_networking()
 		ip -netns "${nsname}" addr \
 			add "${net_prefix}::${rt}/64" dev "${devname}" nodad
 
+		# A dedicated ::dead:<rt> address (with preferred_lft 0, i.e.,
+		# deprecated) is added. Because it is deprecated, the kernel
+		# should never auto-select it as source with current config.
+		# Only an explicit tunsrc can place it in the outer header.
+		ip -netns "${nsname}" addr \
+			add "${net_prefix}::dead:${rt}/64" dev "${devname}" \
+			nodad preferred_lft 0
+
 		ip -netns "${nsname}" link set "${devname}" up
 	done
 
@@ -420,6 +430,7 @@ setup_rt_local_sids()
 #       to the destination host)
 #  $5 - encap mode (full or red)
 #  $6 - traffic type (IPv6 or IPv4)
+#  $7 - force tunsrc (true or false)
 __setup_rt_policy()
 {
 	local dst="$1"
@@ -428,10 +439,40 @@ __setup_rt_policy()
 	local dec_rt="$4"
 	local mode="$5"
 	local traffic="$6"
+	local with_tunsrc="$7"
 	local nsname
 	local policy=''
+	local tunsrc=''
 	local n
 
+	# Verify the per-route tunnel source address ("tunsrc") feature.
+	# If it is not supported, fallback on encap config without tunsrc.
+	if $with_tunsrc && $HAS_TUNSRC; then
+		local net_prefix
+		local nxt
+
+		eval nsname=\${$(get_rtname "${dec_rt}")}
+
+		# Next SRv6 hop: first End router if any, or the decap router
+		[ -z "${end_rts}" ] && nxt="${dec_rt}" || nxt="${end_rts%% *}"
+
+		# Use the right prefix for tunsrc depending on the next SRv6 hop
+		net_prefix="$(get_network_prefix "${encap_rt}" "${nxt}")"
+		tunsrc="tunsrc ${net_prefix}::dead:${encap_rt}"
+
+		# To verify that the outer source address matches the one
+		# configured with tunsrc, the decap router discards packets
+		# with any other source address.
+		ip netns exec "${nsname}" ip6tables -t raw -I PREROUTING 1 \
+			-s "${net_prefix}::dead:${encap_rt}" \
+			-d "${VPN_LOCATOR_SERVICE}:${dec_rt}::${DT46_FUNC}" \
+			-j ACCEPT
+
+		ip netns exec "${nsname}" ip6tables -t raw -A PREROUTING \
+			-d "${VPN_LOCATOR_SERVICE}:${dec_rt}::${DT46_FUNC}" \
+			-j DROP
+	fi
+
 	eval nsname=\${$(get_rtname "${encap_rt}")}
 
 	for n in ${end_rts}; do
@@ -444,7 +485,7 @@ __setup_rt_policy()
 	if [ "${traffic}" -eq 6 ]; then
 		ip -netns "${nsname}" -6 route \
 			add "${IPv6_HS_NETWORK}::${dst}" vrf "${VRF_DEVNAME}" \
-			encap seg6 mode "${mode}" segs "${policy}" \
+			encap seg6 mode "${mode}" ${tunsrc} segs "${policy}" \
 			dev "${VRF_DEVNAME}"
 
 		ip -netns "${nsname}" -6 neigh \
@@ -455,7 +496,7 @@ __setup_rt_policy()
 		# received, otherwise the proxy arp does not work.
 		ip -netns "${nsname}" -4 route \
 			add "${IPv4_HS_NETWORK}.${dst}" vrf "${VRF_DEVNAME}" \
-			encap seg6 mode "${mode}" segs "${policy}" \
+			encap seg6 mode "${mode}" ${tunsrc} segs "${policy}" \
 			dev "${VRF_DEVNAME}"
 	fi
 }
@@ -463,13 +504,13 @@ __setup_rt_policy()
 # see __setup_rt_policy
 setup_rt_policy_ipv6()
 {
-	__setup_rt_policy "$1" "$2" "$3" "$4" "$5" 6
+	__setup_rt_policy "$1" "$2" "$3" "$4" "$5" 6 "$6"
 }
 
 #see __setup_rt_policy
 setup_rt_policy_ipv4()
 {
-	__setup_rt_policy "$1" "$2" "$3" "$4" "$5" 4
+	__setup_rt_policy "$1" "$2" "$3" "$4" "$5" 4 "$6"
 }
 
 setup_hs()
@@ -567,41 +608,41 @@ setup()
 	# the network path between hs-1 and hs-2 traverses several routers
 	# depending on the direction of traffic.
 	#
-	# Direction hs-1 -> hs-2 (H.Encaps.Red)
+	# Direction hs-1 -> hs-2 (H.Encaps.Red + tunsrc)
 	#  - rt-3,rt-4 (SRv6 End behaviors)
 	#  - rt-2 (SRv6 End.DT46 behavior)
 	#
 	# Direction hs-2 -> hs-1 (H.Encaps.Red)
 	#  - rt-1 (SRv6 End.DT46 behavior)
-	setup_rt_policy_ipv6 2 1 "3 4" 2 encap.red
-	setup_rt_policy_ipv6 1 2 "" 1 encap.red
+	setup_rt_policy_ipv6 2 1 "3 4" 2 encap.red true
+	setup_rt_policy_ipv6 1 2 "" 1 encap.red false
 
 	# create an IPv4 VPN between hosts hs-1 and hs-2
 	# the network path between hs-1 and hs-2 traverses several routers
 	# depending on the direction of traffic.
 	#
-	# Direction hs-1 -> hs-2 (H.Encaps.Red)
+	# Direction hs-1 -> hs-2 (H.Encaps.Red + tunsrc)
 	# - rt-2 (SRv6 End.DT46 behavior)
 	#
 	# Direction hs-2 -> hs-1 (H.Encaps.Red)
 	#  - rt-4,rt-3 (SRv6 End behaviors)
 	#  - rt-1 (SRv6 End.DT46 behavior)
-	setup_rt_policy_ipv4 2 1 "" 2 encap.red
-	setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red
+	setup_rt_policy_ipv4 2 1 "" 2 encap.red true
+	setup_rt_policy_ipv4 1 2 "4 3" 1 encap.red false
 
 	# create an IPv6 VPN between hosts hs-3 and hs-4
 	# the network path between hs-3 and hs-4 traverses several routers
 	# depending on the direction of traffic.
 	#
-	# Direction hs-3 -> hs-4 (H.Encaps.Red)
+	# Direction hs-3 -> hs-4 (H.Encaps.Red + tunsrc)
 	# - rt-2 (SRv6 End Behavior)
 	# - rt-4 (SRv6 End.DT46 behavior)
 	#
 	# Direction hs-4 -> hs-3 (H.Encaps.Red)
 	#  - rt-1 (SRv6 End behavior)
 	#  - rt-3 (SRv6 End.DT46 behavior)
-	setup_rt_policy_ipv6 4 3 "2" 4 encap.red
-	setup_rt_policy_ipv6 3 4 "1" 3 encap.red
+	setup_rt_policy_ipv6 4 3 "2" 4 encap.red true
+	setup_rt_policy_ipv6 3 4 "1" 3 encap.red false
 
 	# testing environment was set up successfully
 	SETUP_ERR=0
@@ -809,6 +850,33 @@ test_vrf_or_ksft_skip()
 	fi
 }
 
+# Before enabling tunsrc tests, make sure tunsrc and ip6tables are supported.
+check_tunsrc_support()
+{
+	setup_ns tunsrc_ns
+
+	ip -netns "${tunsrc_ns}" link add veth0 type veth \
+		peer name veth1 netns "${tunsrc_ns}"
+
+	ip -netns "${tunsrc_ns}" link set veth0 up
+
+	if ! ip -netns "${tunsrc_ns}" -6 route add fc00::dead:beef/128 \
+			encap seg6 mode encap.red tunsrc fc00::1 segs fc00::2 \
+			dev veth0 &>/dev/null; then
+		cleanup_ns "${tunsrc_ns}"
+		return
+	fi
+
+	if ! ip netns exec "${tunsrc_ns}" ip6tables -t raw -A PREROUTING \
+			-d fc00::dead:beef -j DROP &>/dev/null; then
+		cleanup_ns "${tunsrc_ns}"
+		return
+	fi
+
+	cleanup_ns "${tunsrc_ns}"
+	HAS_TUNSRC=true
+}
+
 if [ "$(id -u)" -ne 0 ]; then
 	echo "SKIP: Need root privileges"
 	exit "${ksft_skip}"
@@ -826,6 +894,7 @@ test_vrf_or_ksft_skip
 set -e
 trap cleanup EXIT
 
+check_tunsrc_support
 setup
 set +e
 
-- 
2.39.2


