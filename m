Return-Path: <netdev+bounces-285946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMneC1Qg/mmInAAAu9opvQ
	(envelope-from <netdev+bounces-285946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4254FA173
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 387313065270
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193F42189B;
	Fri,  8 May 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsmaZYqU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7F413233;
	Fri,  8 May 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262040; cv=none; b=Rc6xPbJrKReuqYbYbWVqAOLqrXPxBpMd/pMNzPIa3tlC66XTlyd5sszlYZsAgy1O42n4W+3PI6oxyZv0IIt5eJsWLFjAKv8Mio4/QAD245Ots1JrMjLudzNicV/Z/E9wfzTDcKFo4E+YUcHIVmPGeAHRPG8Yx+ixS+EOw9i9ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262040; c=relaxed/simple;
	bh=5FVfWYuoGz0Zn8Q8SR3RXtzYK9TljuG6iDQtTi1S4Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLTbh8eJeeplyXSApTfhZZn8jajd+v5MX7DRsvrAww0Q2rtmQ4UxL+celiyvUSQw4DvxyLGYE36zZdhI1qUOtdhHr6EnoU7g+/8aXeihK7xYjh0WqvYVGrmzgWZqgLC7D6E6GflAh16fIClu8rbwS2cg+9JDm8R1eSNduirl0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsmaZYqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B8AC2BCF4;
	Fri,  8 May 2026 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262040;
	bh=5FVfWYuoGz0Zn8Q8SR3RXtzYK9TljuG6iDQtTi1S4Rw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XsmaZYqUGADB8RL34v86lYYhQZvJqQSqBskMhPYDmMDYXmBI2q4B2KamHZxqnyLlN
	 1tlVxOMJRbaV96OeWOsL/2Fq8Rv6oYH/NAq+yydj4zIwzebfu/lKdg7oTXMNvXsV7E
	 haHY6d2l8o0pe0XGRnEMtOsKKsObayF7PQfteTdC9Zp8vrvPQgFUB7TEAFd1g8+24T
	 xurwuySHsAKyhIuX6TaS70kNiRRHcKozLA/qynYwp+tWHZhy51ZpstKWbQORYWLv5N
	 FMQs5a5npmdib1TYdVKIPsD2DXNTKchExnNchFt0uCV4Mwj+N5NAxC6twbDLkcbWsk
	 mPiiXnzfPovoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:52 +0200
Subject: [PATCH net-next 7/8] selftests: mptcp: pm: validate new limits
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-7-c84e3fdf9b6a@kernel.org>
References: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
In-Reply-To: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5FVfWYuoGz0Zn8Q8SR3RXtzYK9TljuG6iDQtTi1S4Rw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KbAyLtr9ebpv9ua/ZyZWPL8mJbRkc5/S9bp5wgoL4
 2KtBeU2dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEIJ6R4fY+hnvf94fOfKO1
 e8U5rftLF2w/tvykT+du4b+Ped0DQ9wY/hkI2Lru15/KIFzB6ZF19lfWZT4mpeRTz2x+Vy9crK3
 8kRcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 9F4254FA173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285946-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

These limits have been recently updated, from 8 to:

- 64 for the subflows and accepted add_addr

- 255 for the MPTCP endpoints

These modifications validate the new limits, but are also compatible
with the previous ones, to be able to continue to validate stable kernel
using the last version of the selftests. That's why new variables are
now used instead of hard-coded values.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 56 +++++++++++++++----------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 04594dfc22b1..21bfe1311f11 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -66,6 +66,15 @@ get_limits() {
 	fi
 }
 
+get_limits_nb() {
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'
+	else
+		ip netns exec "${ns1}" ./pm_nl_ctl limits | \
+			awk '{ printf "%s ", $2 }'
+	fi
+}
+
 format_endpoints() {
 	mptcp_lib_pm_nl_format_endpoints "${@}"
 }
@@ -164,6 +173,7 @@ check "get_endpoint 2" "" "simple del addr" 1
 check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
+add_endpoint 10.0.1.2 id 2
 
 add_endpoint 10.0.1.3 2>/dev/null
 check "get_endpoint 4" "" "duplicate addr" 1
@@ -171,25 +181,29 @@ check "get_endpoint 4" "" "duplicate addr" 1
 add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
-for i in $(seq 5 9); do
-	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
-done
-check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
-check "get_endpoint 10" "" "above hard addr limit" 1
+read -r -a default_limits_nb <<< "$(get_limits_nb)"
+# limits have been increased: from 8 to 64 for subflows/add_addr & 255 for endp
+if mptcp_lib_expect_all_features || set_limits 9 9 2>/dev/null; then
+	max_endp=255
+	max_limits=64
+else
+	max_endp=8
+	max_limits=8
+fi
+set_limits "${default_limits_nb[@]}"
 
-del_endpoint 9
-for i in $(seq 10 255); do
-	add_endpoint 10.0.0.9 id "${i}"
-	del_endpoint "${i}"
+for i in $(seq 5 ${max_endp}); do
+	add_endpoint "10.0.0.${i}" id "${i}"
 done
-check "show_endpoints" \
-	"$(format_endpoints "1,10.0.1.1" \
-			    "3,10.0.1.3,signal backup" \
-			    "4,10.0.1.4,signal" \
-			    "5,10.0.1.5,signal" \
-			    "6,10.0.1.6,signal" \
-			    "7,10.0.1.7,signal" \
-			    "8,10.0.1.8,signal")" "id limit"
+check "get_endpoint ${max_endp}" \
+	"$(format_endpoints "${max_endp},10.0.0.${max_endp}")" "id limit"
+
+if add_endpoint '10.0.0.1' &>/dev/null; then
+	hardlimit="no error"
+else
+	hardlimit="error"
+fi
+check "echo ${hardlimit}" "error" "above hard addr limit"
 
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
@@ -202,15 +216,15 @@ if ! mptcp_lib_is_ip_mptcp; then
 	flush_endpoint
 fi
 
-set_limits 9 1 2>/dev/null
+set_limits $((max_limits + 1)) 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
-set_limits 1 9 2>/dev/null
+set_limits 1 $((max_limits + 1)) 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
-set_limits 8 8
+set_limits ${max_limits} ${max_limits}
 flush_endpoint  ## to make sure it doesn't affect the limits
-check "get_limits" "$(format_limits 8 8)" "set limits"
+check "get_limits" "$(format_limits ${max_limits} ${max_limits})" "set limits"
 
 flush_endpoint
 add_endpoint 10.0.1.1

-- 
2.53.0


