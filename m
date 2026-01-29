Return-Path: <netdev+bounces-254900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEjSBAm0e2neHwIAu9opvQ
	(envelope-from <netdev+bounces-254900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:24:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE08B3EFD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A301302BDD0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27615324B3C;
	Thu, 29 Jan 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntlPkeaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03142315D31;
	Thu, 29 Jan 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714651; cv=none; b=Mj2vlUCHb1Ih0gsu0yxtH3O2zYkHOiZnEJ19cNJUfLfmTSGH/AhhnLxUoWM4hZpjscAFKUBPvGY4HtN9EemleX5gMSZKhR2qOp/o1vEQpTbPIZsBB6DP7Sund1my82QDwna42aWo+nmYRhfBxG+lDMhGtuA2sSUlJFDvqI1/usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714651; c=relaxed/simple;
	bh=NYrKe3jSMM7YRKmWugfiByo4IRoIPSw7w1LnB+9W8sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npu9LH2ESZwNPEt615cvl3uEjwcjbLN1D5w7bJXH+cC169qgrmhfGFZ4QkEr9kSb/wQGaD6W9X3p6qi0xaKRDilwO4VGrnXDvBt40XFRpcFvz1Tpqrh//zXOJsPe9rxuMwmBGvWt7frtoIL6WxWeQZI/s8//o1HJaFTc+HK9cKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntlPkeaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3188EC19421;
	Thu, 29 Jan 2026 19:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769714648;
	bh=NYrKe3jSMM7YRKmWugfiByo4IRoIPSw7w1LnB+9W8sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ntlPkeaSTCbyRku81zy+RjJ2WscgFB5SDW/kpckO/CaKkZf0pZgTeRr+gR19NFLjt
	 DLa1plmFTt+WQy/7TEJ17M58ArZ9X89OosZoxj009VLNApSfJJYsDuN1JWl4slt/mv
	 vXS4f1G49wQlE9A4EhsV+DGJCY9CgMi368r7G4sf6hR0rgo8k6Xs79RfBpR6j3NvzL
	 sAr8w4auI44rPqcYOwJCwx4r+Oe/dHxQ7JcKOwsI2v3dJMZGXKr7MtghqpZtLYKWYx
	 unX5posTJOx1Zd7mUOJCvj8wZD2a/vRgRMqGUIH5XSBs7DDW1C5FYWE3z/kfKe+dig
	 ca/6ABF2LFlCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Jan 2026 20:23:39 +0100
Subject: [PATCH net-next 6/6] selftests: mptcp: connect: cover splice mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-net-next-mptcp-splice-v1-6-994cac40daa0@kernel.org>
References: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
In-Reply-To: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
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
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKrNx/pYfuYbus4x+zeqeTM7OMxVzUnPP9xmPNxlfIuz
 g0fS62udJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk+3GGfzpKRV8UjG9N+ZqT
 tL5iNduzZZ51N04c3aTodPeCkLlp4hGG/7V5Uwv69Bsf8xQfZdnTMJ9d5fXck+ct7p6JfxTfFCJ
 wlhsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	URI_HIDDEN_PATH(1.00)[http://mptcp_connect.sh/.c];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254900-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mptcp_connect_splice.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,mptcp_connect.sh:url]
X-Rspamd-Queue-Id: 7DE08B3EFD
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


