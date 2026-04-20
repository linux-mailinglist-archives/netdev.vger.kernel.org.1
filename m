Return-Path: <netdev+bounces-279867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E5FG15q5mnBvwEAu9opvQ
	(envelope-from <netdev+bounces-279867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:03:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6F4326D5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BE67327C2EC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5534DCD7;
	Mon, 20 Apr 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF9138Jv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912E34DB59;
	Mon, 20 Apr 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701987; cv=none; b=oNCEmqVSAGIWZ7OljN4l7tVVQT/2s6Lf9I/V7xKWE3aefIpiZGXIIZfBHXN+SBpisWqL8fM7HzdifZA11SQUXbl8Z9stq/95ja8uSQb4SJdb670ZFvFuK6A63GklrmW3r2DiF/8eu0+Xpc1sD0dW838zDOkJxuadNP7x6a+QfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701987; c=relaxed/simple;
	bh=K5hYUkvpx0JvIf4K9J3AgSbV6rLHDnsmtS5j96WoZks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjtYFttH1eCnyQl/FEsHhBDrhZY1y7J6Q3QikSO9cTP2F6nyfcn6KIQIgzQANdCPq7xSXbXgsjWBGxJT+Y+zQbbN69ya67ANoez8Sbq48Hs+dIlKYdpiFYLjMBxm3ANH18epCGbCd7CiiINZCkaJZskPswUWFL5vJHq1rLeyWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF9138Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBC1C2BCB4;
	Mon, 20 Apr 2026 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701986;
	bh=K5hYUkvpx0JvIf4K9J3AgSbV6rLHDnsmtS5j96WoZks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fF9138JvlQgjW/+EOzNdAgyhvTukxN1y++UiqAUENJ+Op6nOJFjHBEBLU4zfwvUV9
	 OhqjrkjMBM8PghKqcz2or1TNGvKewvgaNGb18Zbg33xOnrwcK/w0iwSA+nBU2PD6Rs
	 234OzaqRJQPgC0/XuMcbThuxa+UtEo+h0HbEBniKkhIIC9bA5hbPbA2YKezFOoNoIS
	 3H3zBxwD2ve//1MOih3iOgRbyfXi8vaz68y7DF+QJk8Gqz69RisK1TGdRs5iVL2dbK
	 cfJ63b67xvUqn+vPsYSuRr/qdzkYaOb18xCDzXrDjK8wEiKFeggsh39b1Z6fzjfy32
	 uJpz2m0Lj9leQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Apr 2026 18:19:24 +0200
Subject: [PATCH net 2/2] selftests: mptcp: add a check for sndbuf of S/C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-net-mptcp-sync-sndbuf-accept-v1-2-e3523e3aeb44@kernel.org>
References: <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
In-Reply-To: <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JuWXrIR8z0Kdry9exlX5cPLEP3UA7EoY3hwK/Q5Akok=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKfBUlrHgiMqarw1p1+aZnSxYUhMf/kTnv11XSFhZ/5e
 2Gpm01/RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETstjMyNH9Qami6GqFnva+h
 mkM0uDQpYsb9nVafnwpe73yxJzXeiOGfYUqhp1SZz2K+6YuFfQpz8hkVLPqKctbu6briXJrh8Jg
 HAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279867-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,diag.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7D6F4326D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gang Yan <yangang@kylinos.cn>

Add a new chk_sndbuf() helper to diag.sh that extracts the sndbuf
(the 'tb' field from 'ss -m' skmem output) for both server and
client MPTCP sockets, and verifies they are equal.

Without the previous patch, it will fail:

'''
07 ....chk sndbuf server/client    [FAIL] sndbuf S=20480 != C=2630656
'''

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/diag.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d847ff1737c3..27cbda68144e 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -322,6 +322,33 @@ wait_connected()
 	done
 }
 
+chk_sndbuf()
+{
+	local server_sndbuf client_sndbuf msg
+	local port=${1}
+
+	msg="....chk sndbuf server/client"
+	server_sndbuf=$(ss -N "${ns}" -inmHM "sport" "${port}" | \
+			sed -n 's/.*tb\([0-9]\+\).*/\1/p')
+	client_sndbuf=$(ss -N "${ns}" -inmHM "dport" "${port}" | \
+			sed -n 's/.*tb\([0-9]\+\).*/\1/p')
+
+	mptcp_lib_print_title "${msg}"
+	if [ -z "${server_sndbuf}" ] || [ -z "${client_sndbuf}" ]; then
+		mptcp_lib_pr_fail "sndbuf S=${server_sndbuf} C=${client_sndbuf}"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	elif [ "${server_sndbuf}" != "${client_sndbuf}" ]; then
+		mptcp_lib_pr_fail "sndbuf S=${server_sndbuf} != C=${client_sndbuf}"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	else
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	fi
+}
+
+
 trap cleanup EXIT
 mptcp_lib_ns_init ns
 
@@ -341,6 +368,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake"
+chk_sndbuf 10000
 chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"

-- 
2.53.0


