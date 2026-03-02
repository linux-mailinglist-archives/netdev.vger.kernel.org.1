Return-Path: <netdev+bounces-262679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAoSGrmipWngCwAAu9opvQ
	(envelope-from <netdev+bounces-262679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:46:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F9B1DB1B3
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF83430300FA
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB12798F3;
	Mon,  2 Mar 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JP9GFH1J"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58633FFADF;
	Mon,  2 Mar 2026 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462480; cv=none; b=lHvX6VYYNWjKedYju1stMrUenbVSyGAQ0NxTA8JvPrZz/T3IXxeHDDdld6Q5JT61UrZgiRieXDQE2Ju4aUI8+e39L+qQIbCHGW6qoJlIbeeV8mXQ1eJrPPUTp898Z+evQN2EgjOL3N9jWjVSgtUOA6Tpaz7phEUKhFUI7J7Fmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462480; c=relaxed/simple;
	bh=gUtBimJLIFo6sIA9f0hJB7P71LFYZn4wPVh7PIdBYGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K96uJ/K21e37Pvn0BY7+kcMpcZNAM2sHiKn+wSFUyhZy8O0OKMFRKtaK3Ypeglr69aMk6H+2jLaGxXSD0WBCG03L88wsvQ9kpn6qaFNRuePFq6Oh635OHU8WK/xTCtcmCtgh1Dd/Kjr86FsXEnCAd4jxBtqJUjva1vJtAfNZ618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JP9GFH1J; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=6G25lhpEJo6nNMrx0cNvKtFHnOheQyRYCZz/rYYTiWg=; b=JP9GFH1JG7HS8WcfafZ9KbRbsG
	e60S4iPYIAI4JdNSTW+TJJ48J4Vp0j4m411bXOPpqOBSfIf42rfysBD+v75ehIrI1massOhohZUua
	VonDNT6+jKFpzd5d1b0Ykz7nSi6M8phTeZt6UaZU+uEdOBELQ6HjD8UHGZhUmXbjzYHkFeZrsuSmQ
	pC/PvfvmWHTjW1d2Ri7qNs10tDzfEPcte6+PAuNUrTpizE4PvDrWulssCFzPccMlX0Pl/M+5c6z1d
	H9InSgJpXIE7s0zgDSRn+9E9t8st02MtH8/jxvYQU3i6Sms4ZVYEnzCauwzbPwjOkzmTEIsykZfoe
	/McUvbWw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vx4SO-00ETX5-Fd; Mon, 02 Mar 2026 14:41:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Mar 2026 06:40:39 -0800
Subject: [PATCH net-next] selftests: netconsole: print diagnostic on
 busywait timeout in netcons_basic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-netconsole_test_verbose-v1-1-b1be5d30cd7d@debian.org>
X-B4-Tracking: v=1; b=H4sIAGahpWkC/yXM0QqCMBQG4FcZ59rBmqG0V4mQ6X5rEWexcxRBf
 Peorj/4dhLUDKFgdqpYs+TCFMypMTQ9It9hc6JgyDvfudZ5y9CpsJQXBoXosKKORWDbro9zwiX
 26UyNoXfFnLfffCWGWsamdPuLLOMTk35jOo4PG/4lRIUAAAA=
X-Change-ID: 20260302-netconsole_test_verbose-367afde9a7d4
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=leitao@debian.org;
 h=from:subject:message-id; bh=gUtBimJLIFo6sIA9f0hJB7P71LFYZn4wPVh7PIdBYGA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBppaGEUIubXetIwMN8yAdPidt9eqi5YMJK3tF2z
 F0AD2q8XFmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaaWhhAAKCRA1o5Of/Hh3
 bWzbD/9yODDQMaTErk/dXpdr3gyNTGNM7geS+H1LyCQHmZOgUr6EI8x5tPQBYRI68B7COrCRYAE
 S26QEhNCeN1Dnz7dYWHjt9zMyjoQONNWVuiqWO3lxr88F8rjZeJBYHqoT+R2YPbTDQgcBEaIeua
 +RxXPPYZUl47HVIQa8E/fMqALWlbd6b4YkG2Dzq8JR4+XuDGvVlpackbvzLbwoly33eKMYr5POx
 s+pwBQkctz4gWCNWVixfBXlrJxJG1kS9ATD4hSECxVltdxvzXqYBC/fgf9q2SAj+3jH19pqs5AC
 eFEnBbNZS5VsN+HzR2jieB4DSwF8hvyox/A8ByBIttsVLPjDreEiRC7MB3PZN6XusthtfvRdzS5
 a4DyavZ/5BJtNZSBD1kLQUSSZVf5mZvq3ysS7yOgMft0O55IwCba0HgXysYhYdVlfcmqpm8Al47
 8CcdPjfKnPD0r12R5VeVeNotn2fVCzTEp7X5f6cxHkzypDd894NgEiWOn0V2JTm4o41YMWQTYUi
 nYxg4SC/8bvddpSNHWiwiVPrZSvEvMq5ijVvQwCruXyarlbU77ACySYp7kpribYdpIeLNJOyffl
 1jGxSAHSeWvBGM4F23Be/o6bKXQN15PrhbJnhrOYiG37ZMudKs0MxHpLwbQICCwmVSiAMaZhCXr
 Gr+otGZ2QISKxlA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: D1F9B1DB1B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262679-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The script uses set -euo pipefail, so when busywait times out waiting
for the netconsole message to arrive, it returns 1 and the script exits
immediately without printing any error message. As reported by Jakub,
this makes failures hard to diagnose since the test reports exit=1 with
no explanation.

Handle the busywait failure explicitly so that a FAIL message is printed
before exiting. This is how it looks like now:

	Running with target mode: basic (ipv6)
	[  167.452561] netconsole selftest: netcons_QdMay
	FAIL: Timed out waiting (20000 ms) for netconsole message in /tmp/netcons_QdMay

The remaining silent failures under set -e can only happen during the
setup phase (netdevsim creation, interface configuration, configfs
writes). So, it is not expected to have any silent failure once the test
starts.

Note that this issue might be less frequent now, since commit
a68a9bd086c28 ("selftests: netconsole: Increase port listening timeout")
increased the timeout that _might_ have been the root cause of these
random failures in NIPA.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh b/tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh
index 59cf10013ecd5..7976206523b2c 100755
--- a/tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netconsole/netcons_basic.sh
@@ -58,7 +58,11 @@ do
 		# Send the message
 		echo "${MSG}: ${TARGET}" > /dev/kmsg
 		# Wait until socat saves the file to disk
-		busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+		if ! busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+		then
+			echo "FAIL: Timed out waiting (${BUSYWAIT_TIMEOUT} ms) for netconsole message in ${OUTPUT_FILE}" >&2
+			exit "${ksft_fail}"
+		fi
 
 		# Make sure the message was received in the dst part
 		# and exit

---
base-commit: 01857fc712f6469cab9cc578120cdc80f1c2a634
change-id: 20260302-netconsole_test_verbose-367afde9a7d4

Best regards,
--  
Breno Leitao <leitao@debian.org>


