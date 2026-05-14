Return-Path: <netdev+bounces-288105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKUKGblXBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9303547B50
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00088303B7EC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A13812FB;
	Thu, 14 May 2026 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gbeNdo8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A515145A1F
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800552; cv=none; b=b+E0oe2zQFUd1k0uOiL4nELIRD2RNbPNlc9YAnTxqLh6IaFCpMogLSNLQC+uAcNFCB8qMjJcjenZsSmoDHI/Mx8n/4oH18kJU4aeabKTJTnAzoVi4zEMA7XMiEuLuj0gJAMlgQ+iUUwCp306yFKXyZwjw/ZnEu68lCZfMGm80HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800552; c=relaxed/simple;
	bh=MtJHNlbiZerjdPEzOlj263GMPVJy10WoBSXyLLQ4UyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crPV3nCcfStbTpD8QPyYkb/qI0Fbz/NvLjqnC1E+SqIL72sZGs54npHzSYb26ZpyT9cK0SF0/SyTnmh/w4jvP3w3xlCEhfAo3wrVwqcVGK+IWnZSpKu4Zp99ntL6efyNMfNKCM9G3d4n6jEDmv7eahCeu36u1OZDgBP8g3z3bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gbeNdo8Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so100577395e9.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778800549; x=1779405349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqoRDlzgxB40s7RWtbhlam/wZ2ILK++oCwT7V3WKKyA=;
        b=gbeNdo8QG1aCXE7m8O44UomH2iz4583WE2KQB6K61nttTm0LW8fhMfwtl+u8MoTwvm
         f5VXpf0BNn5R5JeU4YvZ3+/RM2zpDiwXqCj4o6YyljD1iAmeeniOdUFWpv1CUPDjv/Fj
         u7ua3CJESJamqZN/sSjIUHr7Dysx9xstHz+zZxIHut2jpJwhBOeoMcmoIWPGPpsVez68
         oLNrk93ICLK2Gwd26LKwRMxkJ55RwSyHMdxp6QgTViz+6hNKVi4e+BpPsV2gXNfApJNN
         YSU9FkJpoh/9SzoOaahSRrGS8Me0YjYo9zzRrlOMl2es0NrLnuDY4CuiuxuXHph2e9xM
         nwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800549; x=1779405349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqoRDlzgxB40s7RWtbhlam/wZ2ILK++oCwT7V3WKKyA=;
        b=jBojQCyR4KYIb023zD2vwuMZ66cvgKogPEvGK1yV/1rz42tnsQMbTWV6qc4uizSHjd
         G/MwZzBs3Swi2FyqNxqjdIPOgPrQlFJZtmxedRh0O7fp5MWFIxsw1+61l5UPu39d5BSx
         UnnNcEQnwdf13DcB9XLkUzAu0gNtB8/czKaWBahHUiHKoiZlqOC58sY8XfKUUb+4Gzdm
         0e+q7CEoyHRjaG+hOzIpnbsy4YmfKRx8Nqzpubj8+hbfbi90KVDbiE5NLmjkv5OnB7/3
         7ZP1o/Id//nQ0YU2b8IMwrAkMxqkzfO1sTGQb6Qy1pqnbK1BjCA6XVIEmmQwkESKEjbB
         jJsA==
X-Gm-Message-State: AOJu0YzSIv66qkYr1LbgE7iVEfAH3Nnp7hzp43pA9gt00hD+ADXyTBYg
	fd0yAD2QvYqX0C0k1ybEjcFukbTHtkPQrJwzEKBc1eqx20DBAAVfdTTT5u3dET+4C13DPS0p//X
	q5aPdJnSetR4iTgkPDKP/BW1YfuGuFluGSKY8IM5GEJZ0l/iIS1MSD6syFG90gi76lIs=
X-Gm-Gg: Acq92OE28NZLdS2n+c5odBOg2+9+FafLbt5cxknQ/szgsF9KqnTxUtXFvcZoiY5vdYv
	2W5AkVSD9RKJIAunc0jK0gMXRBTedSmlMFLvt0pFXp0PqEPI7NphfKpiTkPDGQn5iItoR/A7WPO
	rXKG2OrDrTfjJJFHDrK7yxOoploDK5kPvU5oXuYLEPoiUe/Wrj5TR1W8Sds5LMWOSgZT9/CFup7
	0muy2PA0UvvnFbqO+CLkGFaxut9tBUm+JVlNnR8WKHVBg4mNrGFYc7s2379DKSJ3lLzgu+tYpuq
	XIhbNCXQKMjS7dI4eodUxfjlpIjHE9jDJkfdouOoRCTWT7qtNdMr/ubqRn/QIuMZfETwbjq1Yg1
	SRCwAk5Jy8rgErwa0SlYwmB2otS9Bd8npB77fKjrwcFTUBU9/Db4GNFtgSlWebBwFUbE28BOM4K
	46p2U7i/qvlL6DWG9aVQuQUfMcDmzxuPpOl1Vx0TLfpxtNJw==
X-Received: by 2002:a05:600c:8b75:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48fe6321cdamr17622285e9.21.1778800548808;
        Thu, 14 May 2026 16:15:48 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a628:d33e:601:ebb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39155855e9.1.2026.05.14.16.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:15:48 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/5] selftests: ovpn: reduce remaining ping flood counts
Date: Fri, 15 May 2026 01:15:40 +0200
Message-ID: <20260514231544.795993-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514231544.795993-1-antonio@openvpn.net>
References: <20260514231544.795993-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9303547B50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288105-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:email]
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

Commit 201ba706318d ("selftests: ovpn: reduce ping count in test.sh")
lowered the baseline traffic flood ping count to avoid flakes on slower
CI instances, however some instances were left out.

Apply the same limit to the remaining ovpn selftest flood pings that
still request 500 packets.

Fixes: 201ba706318d ("selftests: ovpn: reduce ping count in test.sh")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/test-close-socket.sh | 2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh         | 6 +++---
 tools/testing/selftests/net/ovpn/test.sh              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index af1532b4d2da..ec9a51bbf3c9 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -53,7 +53,7 @@ ovpn_run_ping_traffic() {
 
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		ovpn_cmd_ok "send ping traffic to peer ${p}" \
-			ip netns exec ovpn_peer0 ping -qfc 500 -w 3 \
+			ip netns exec ovpn_peer0 ping -qfc 100 -w 3 \
 				5.5.5.$((p + 1))
 	done
 }
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 5a8f47554286..7c1d56e9c525 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -66,7 +66,7 @@ ovpn_mark_run_baseline_traffic() {
 
 	for p in $(seq 1 3); do
 		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
-			ip netns exec ovpn_peer0 ping -qfc 500 -w 3 \
+			ip netns exec ovpn_peer0 ping -qfc 100 -w 3 \
 				5.5.5.$((p + 1))
 	done
 }
@@ -101,7 +101,7 @@ ovpn_mark_verify_drop_traffic() {
 	local total_count
 
 	for p in $(seq 1 3); do
-		if ping_output=$(ip netns exec ovpn_peer0 ping -qfc 500 -w 1 \
+		if ping_output=$(ip netns exec ovpn_peer0 ping -qfc 100 -w 1 \
 			5.5.5.$((p + 1)) 2>&1); then
 			printf '%s\n' "expected ping to peer ${p} to fail \
 				after nft drop rule"
@@ -144,7 +144,7 @@ ovpn_mark_verify_traffic_recovery() {
 	sleep 1
 	for p in $(seq 1 3); do
 		ovpn_cmd_ok "send recovery traffic to peer ${p}" \
-			ip netns exec ovpn_peer0 ping -qfc 500 -w 3 \
+			ip netns exec ovpn_peer0 ping -qfc 100 -w 3 \
 				5.5.5.$((p + 1))
 	done
 }
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index c06e3135fbef..9b5610837032 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -110,7 +110,7 @@ ovpn_run_basic_traffic() {
 
 ovpn_run_lan_traffic() {
 	ovpn_cmd_ok "ping LAN behind peer1" \
-		ip netns exec ovpn_peer0 ping -qfc 500 -w 3 "${OVPN_LAN_IP}"
+		ip netns exec ovpn_peer0 ping -qfc 100 -w 3 "${OVPN_LAN_IP}"
 }
 
 ovpn_run_float_mode() {
@@ -127,7 +127,7 @@ ovpn_run_float_mode() {
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		peer_ns="ovpn_peer${p}"
 		ovpn_cmd_ok "ping tunnel after float peer ${p}" \
-			ip netns exec "${peer_ns}" ping -qfc 500 -w 3 5.5.5.1
+			ip netns exec "${peer_ns}" ping -qfc 100 -w 3 5.5.5.1
 	done
 }
 
-- 
2.53.0


