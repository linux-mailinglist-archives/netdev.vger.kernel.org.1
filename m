Return-Path: <netdev+bounces-270947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GnUHSVYwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:23:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D830585A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 929853067724
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49B3DBD53;
	Tue, 24 Mar 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="I5D50hE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329638239E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343726; cv=none; b=YyASLhtTPq6kdYF90OkPC0TT66vMNLk9Z75DkATuCeUblYL6gi/ZjM7Z0AW4t8dG9sTroijHtsYdvNoO6yRSY9MbthAfGqqzdbLw1S2kVg1ql92RV4CWpirvNS5GqRvJhDqx5uuJgDWj/jek+wAQ6hS3jdnwk8VVntuNPMCDdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343726; c=relaxed/simple;
	bh=WvTodBSYGhJ9zcnSeSh7PqdQDKcu64SWFovudUmI9y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=px5n3WO9cf6s3nhRCookOSCMhC08sAimuU9IWCj9Hg7di9UIY2J2Agf5+rTWyk1cBF3VoM+8uj1iGPwxRsN+7R/UJK+rbSuMNzuJLBayimRzgcA3czNGj4MJ0MNFXVh2+lwJIHJC/WTibK3oh+1hl+qcmw/ATh9hOnP642UxBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=I5D50hE6; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so1462976a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774343715; x=1774948515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO5SS442aJosf9pm8N+OTooImSscKb80rw0TqiYVF5s=;
        b=I5D50hE6CGyi/yVV18rRcxsVVHJEbx7c/DzT6lrScu7ggQJV84r6bVcAL6UHQGvGCJ
         vmvcNn07YBpYdNNSwWk29upFI9KXWML04cGgrxMdObEjIdD/LctSR05kCdksbQuPkdcE
         Y03llbDVkwbVx1kTok2kKZ/lHnL25G+HEGtOJCp4By1wJ74b2+0mrn0m6a+g6ot8aIvd
         3F2r+l9tpv1Gk6F9r1GPGvPre5/StX3qOjOnmz4GcafvsTk7U0gEo0u4uTdPY4uct966
         ttDFMvMZBC35yq5m6ae8XgsTmB5NV6m31UcpR1cAUIb1mXNaoQzTpBvj9PkDCzzD3DRz
         Qq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343715; x=1774948515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FO5SS442aJosf9pm8N+OTooImSscKb80rw0TqiYVF5s=;
        b=ZDB8T95V6vJzr/aipR76hqe80hSgz92NNMhGoi5XtRMc0wbbUvaXdI25Ff0Q2ZHEdJ
         LcpwfvAMkfU+ZFrhg/dxFwIfz1FXzOCkSi8coln+dEGSEi62bwpMGzTGH90LX3MIYBdv
         IqWmNCMrJ+VH1AdD445OAPO9kmcfVgWs6bJ++JkI5g4yXsfscMW2MNqwQ5JM6iFcKTHO
         Wl3NoynMi2nYE9fidLkyQWB61u3JKvsuPkxnZJsL0z9vo9pDnWwOx9DgmmiURJAi//dN
         4IJWAGb2PV24ygbxp7AI5bOOFGce2HYOTFYVyl+W6HdYgtG+XDFgFZCdR1qAT4C36Sij
         MKag==
X-Gm-Message-State: AOJu0YyHoBv/VdVphth+HJVEVRWshSAL8Glf5r1LAN5F8HE6WWss4gAg
	bfFzMFnS4azzuNNyHEXWTRP036mIlDLRDMXyD8gVx9GJJLv69dnZkacrV/In8iso0TlLfPXt62k
	gIv47+b/XWhK3iPsnjqpQqa5IpEsxGI/rNlPj
X-Gm-Gg: ATEYQzw9CYZNKSLfoP/kS0aYVZoCqv9a8ytoifMdcrQ3FsFxPqIvvStKk7uYdrLIjwN
	zZuH8K8UGtxpkZfhIeA8ivCxYLGiI44aYoffp8UmmrsWrUE5Olil52B/CWA9dtfXxNhiF/RHS4Y
	fqkVB5qMFwYwdEx1gyrK3n4Kt0OpQ3Bo99yOjq97tBY25N6lA0bdCszeu+K/bJFir9OtUNtdvv4
	DrbtRQB3Wkve53u7dCNEUmfjLmYkxqC2wbWC5QJvFe6vPo6NdMJzMCOw7me3MU4/GwjIEbBwHzZ
	EftZnzUIN37wyKIvxQ4alOge8pi5k6AL5I9w7/kHjpfyNYOkxCmibTI0ILV4Ju8d7K2Sds0oyLp
	u3al65iFrvZo56GjCy1q+YElGPCc27XT1gI7tkPNgXIA8VpUr7r2sIQzVU/EJos2EfKpZzsDRwQ
	==
X-Received: by 2002:a17:906:59a8:b0:b98:411a:116f with SMTP id a640c23a62f3a-b98411a1ec9mr724824966b.2.1774343715054;
        Tue, 24 Mar 2026 02:15:15 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b98332dc73esm97094266b.50.2026.03.24.02.15.14;
        Tue, 24 Mar 2026 02:15:15 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id D9AEE1E281;
	Tue, 24 Mar 2026 10:15:14 +0100 (CET)
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
Subject: [PATCH net-next v5 2/2] selftests: add check for seg6 tunsrc
Date: Tue, 24 Mar 2026 10:14:34 +0100
Message-Id: <20260324091434.359341-3-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260324091434.359341-1-justin.iurman@6wind.com>
References: <20260324091434.359341-1-justin.iurman@6wind.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270947-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ED7D830585A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend srv6_hencap_red_l3vpn_test.sh to include checks for the new
"tunsrc" feature. If there is no support for tunsrc, it silently
falls back to the encap config without tunsrc.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 .../net/srv6_hencap_red_l3vpn_test.sh         | 109 +++++++++++++++---
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
index 6a68c7eff1dc..cd7d061e21f8 100755
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
@@ -345,6 +347,17 @@ setup_rt_networking()
 		ip -netns "${nsname}" addr \
 			add "${net_prefix}::${rt}/64" dev "${devname}" nodad
 
+		# A dedicated ::dead:<rt> address (with preferred_lft 0, i.e.,
+		# deprecated) is added when there is support for tunsrc. Because
+		# it is deprecated, the kernel should never auto-select it as
+		# source with current config. Only an explicit tunsrc can place
+		# it in the outer header.
+		if $HAS_TUNSRC; then
+			ip -netns "${nsname}" addr \
+				add "${net_prefix}::dead:${rt}/64" \
+				dev "${devname}" nodad preferred_lft 0
+		fi
+
 		ip -netns "${nsname}" link set "${devname}" up
 	done
 
@@ -420,6 +433,7 @@ setup_rt_local_sids()
 #       to the destination host)
 #  $5 - encap mode (full or red)
 #  $6 - traffic type (IPv6 or IPv4)
+#  $7 - force tunsrc (true or false)
 __setup_rt_policy()
 {
 	local dst="$1"
@@ -428,10 +442,46 @@ __setup_rt_policy()
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
+		local drule
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
+		drule="PREROUTING \
+		       -d ${VPN_LOCATOR_SERVICE}:${dec_rt}::${DT46_FUNC} \
+		       -j DROP"
+
+		if ! ip netns exec "${nsname}" \
+				ip6tables -t raw -C ${drule} &>/dev/null; then
+			ip netns exec "${nsname}" ip6tables -t raw -A ${drule}
+		fi
+	fi
+
 	eval nsname=\${$(get_rtname "${encap_rt}")}
 
 	for n in ${end_rts}; do
@@ -444,7 +494,7 @@ __setup_rt_policy()
 	if [ "${traffic}" -eq 6 ]; then
 		ip -netns "${nsname}" -6 route \
 			add "${IPv6_HS_NETWORK}::${dst}" vrf "${VRF_DEVNAME}" \
-			encap seg6 mode "${mode}" segs "${policy}" \
+			encap seg6 mode "${mode}" ${tunsrc} segs "${policy}" \
 			dev "${VRF_DEVNAME}"
 
 		ip -netns "${nsname}" -6 neigh \
@@ -455,7 +505,7 @@ __setup_rt_policy()
 		# received, otherwise the proxy arp does not work.
 		ip -netns "${nsname}" -4 route \
 			add "${IPv4_HS_NETWORK}.${dst}" vrf "${VRF_DEVNAME}" \
-			encap seg6 mode "${mode}" segs "${policy}" \
+			encap seg6 mode "${mode}" ${tunsrc} segs "${policy}" \
 			dev "${VRF_DEVNAME}"
 	fi
 }
@@ -463,13 +513,13 @@ __setup_rt_policy()
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
@@ -567,41 +617,41 @@ setup()
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
@@ -809,6 +859,38 @@ test_vrf_or_ksft_skip()
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
+	if ! ip -netns "${tunsrc_ns}" -6 route show | grep -q "tunsrc"; then
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
@@ -826,6 +908,7 @@ test_vrf_or_ksft_skip
 set -e
 trap cleanup EXIT
 
+check_tunsrc_support
 setup
 set +e
 
-- 
2.39.2


