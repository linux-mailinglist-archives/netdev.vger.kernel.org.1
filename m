Return-Path: <netdev+bounces-255242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EVBHUIGfWmpPwIAu9opvQ
	(envelope-from <netdev+bounces-255242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:28:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E94BE221
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 20:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6EC73082EE8
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54638A289;
	Fri, 30 Jan 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOffG6yS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A338944D;
	Fri, 30 Jan 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801098; cv=none; b=c6vpzwy9RjEQfJcxfq37X3cMzEE+LlygTOkNH9F1g4fKevGSCNEivlWvIebQiwru5B5RBRs11YNAlZjrDEdxR4ZY2FOAkJz0sAEm+sSqbeBa47+Wu0AR/5T6DEF5EFInxSCsGya9gswlYQZ0W3uqSQSufJJJse1bGzC/8ZC5dxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801098; c=relaxed/simple;
	bh=NYrKe3jSMM7YRKmWugfiByo4IRoIPSw7w1LnB+9W8sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS+TlzhFrQ3XROO+mBjgRmqfK0EH3kp6QMCKL601t6LHDmk7Y55OCIu3FqL9m9Q5VcJ7heumSlRLshHz+fkcUB75ch3dcQQ4Tzr5V250NO8cVLTUEAU6lIUjYjQHE92oiJFZ/YA4YWtoG1T8T2PjVusP8CW6IzMlGks9ugWn78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOffG6yS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57741C4CEF7;
	Fri, 30 Jan 2026 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801098;
	bh=NYrKe3jSMM7YRKmWugfiByo4IRoIPSw7w1LnB+9W8sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eOffG6ySIuakA/3fn6GKxx5l9aNw6miEHvNZQIBwlap3RvTL/EYEhHTVVUdm4benP
	 NbePk61TpDL5PQD54yI7AdywSD8vHm1b2T8STHKqhE+SYumQY0CiVf0pnf1sRiBPGI
	 hy1fHd+MEeMejYTs4ggHfECjzXTv6lvCEFYbrdWDdjeIKKtVTXLNfiRtgr6rnBtfFn
	 cBI+Rx5PVPnmLckWdMCuEBOjZVV6cIamvzO/vbJzCeuD6t7j3r3LoBeghmbtDd2wTT
	 l7h9ZQY0HKp5jB52w/s8OilLjxeuyFQxwRIA2M5A0RR4bK9lAYb0++MODYYr2j5mKR
	 bq5+vq8ve3d3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 20:24:29 +0100
Subject: [PATCH net-next v2 6/6] selftests: mptcp: connect: cover splice
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-net-next-mptcp-splice-v2-6-31332ba70d7f@kernel.org>
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8UGJgd2vetfhMEQYLqhsyCyu0GJ8G+zo8jWjkOXYN3c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJrWcuC999yWZed83Hy3P6bNX1M1+cwqty/1nfjxMZqD
 elHPoc/dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkYT7DP13Loo9v1A+tq/ih
 +1bTQOiExDeny56JrPfcJmyrvVUrdoeR4cgWietmq/rvHO+x8Zoz/7+y+E2OK+7F7+ftY6k/Emx
 wkBMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	URI_HIDDEN_PATH(1.00)[http://mptcp_connect.sh/.c];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255242-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mptcp_connect.sh:url,kylinos.cn:email,mptcp_connect_splice.sh:url]
X-Rspamd-Queue-Id: 18E94BE221
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

The "splice" alternate mode for mptcp_connect.sh/.c is available now,
this patch adds mptcp_connect_splice.sh to test it in the MPTCP CI by
default.

Note that this mode is also supported by stable kernel versions, but
optimised in this patch series.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 4dd6278cd3dd..22ba0da2adb8 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS := \
 	mptcp_connect_checksum.sh \
 	mptcp_connect_mmap.sh \
 	mptcp_connect_sendfile.sh \
+	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
new file mode 100755
index 000000000000..241254a966c9
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"

-- 
2.51.0


