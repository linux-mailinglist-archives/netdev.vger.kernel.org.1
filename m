Return-Path: <netdev+bounces-286721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOBsO9f7AWomnAEAu9opvQ
	(envelope-from <netdev+bounces-286721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:55:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AE511A37
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7621930E9EEC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2240DFAC;
	Mon, 11 May 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cebHIjI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E440B6F7;
	Mon, 11 May 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514419; cv=none; b=Ec1CQneYGS6xC/By+0yWyfH1keKycV2WkwvoNwKzUnaQ2+T2RoiXUjoWu20WvS/5PnjqD05QlqI8nOCm9NUIstSSRpKhsnk89758NhlzhZRBkF88Qu57So2q+BGpjpn4hb8CjZZhjTpO4cia7xjBSLkM2IZ0MDCXpucwQgP7VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514419; c=relaxed/simple;
	bh=HAqn1a+1m/18t3HW1mWpO6nHBtvV4r5btqoAhjlEJO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riuuAVFcZEthe2vRDHcoGz03CSV/5W3+UmhO6gwBdy4o9R73uBK18ddcrQQ3tB9nThrwz9WoLWsNf3IkehqLCZCD5Usr3GlgaeddqhRqYF+yuhcwhD9/LakJ96Ew6sjAhhEIFTKfKNx9Q3xhAHpJx/1ykQlMnP/xTOcThnb7lR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cebHIjI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E93DC2BCB0;
	Mon, 11 May 2026 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514418;
	bh=HAqn1a+1m/18t3HW1mWpO6nHBtvV4r5btqoAhjlEJO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cebHIjI1t4M/EePTm+I+Z7Dddz+1w5O5adBufhmTu1EuL2twaemVcQejgv7d0k60l
	 ntbDVawsKFkvbNUd3Xu2MhfsBGTOOhfBGwjUpLrfHr1KWWAocJ/P+16TWK1fBLlK/G
	 D8n8H183GtPC/ZZTpR82SXxqFf7mrWOzf0NGymUp25y+xm6WwONu6ijCdJ8D61LM23
	 3F9pe9k7HQuTWbqdCU5ceSiJq7bioPJ7paNL7/keomMjXAmzeki6JLuQ3npurl8+PO
	 b5/dNZj894Da5gmU2nqAymNy9GJQPdMMAGq3e3oA7L0b9im+xjiJHyBIBSwzA0lZn0
	 odk7nlrWKl8RQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 11 May 2026 17:46:29 +0200
Subject: [PATCH net 3/5] selftests: mptcp: join: cover ADD_ADDR tx drop and
 list progress
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-3-5ee57cb2b7eb@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
In-Reply-To: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumaze@google.com>, netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Li Xiasong <lixiasong1@huawei.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/orNxmenZ9vHQomKpdCaVKJWq+BaFJUdd4uWduQYZew=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIYfz5lm/XdbW0ZL9fRlqsxqfwSib/av78vMdjQXFa64
 dqSj8F3O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaS9J7hf+bRsBKNzQIT1q69
 17jdoTaUzfnarW26a36Yz25MrN/65QTDP7X088uv/pmYqs200XKz4CNOrX8TI6arnE58wraMfU3
 kFz4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 788AE511A37
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
	TAGGED_FROM(0.00)[bounces-286721-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Li Xiasong <lixiasong1@huawei.com>

Extend add_addr_ports_tests with IPv6 signaling cases that exercise
ADD_ADDR tx-space shortage when tcp_timestamps are enabled.

Add one case to verify PM still progresses to later signal endpoints
after the first one is dropped.

This covers both failure accounting and the non-blocking behavior of
the announce list after a tx-space drop on pure ACK.

Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..5acd12021e6e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1828,6 +1828,22 @@ chk_add_tx_nr()
 	fi
 }
 
+chk_add_drop_tx_nr()
+{
+	local drop_tx_nr=$1
+	local count
+
+	print_check "add addr tx drop"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$drop_tx_nr" ]; then
+		fail_test "got $count ADD_ADDR drop[s] TX, expected $drop_tx_nr"
+	else
+		print_ok
+	fi
+}
+
 chk_rm_nr()
 {
 	local rm_addr_nr=$1
@@ -3278,6 +3294,21 @@ add_addr_ports_tests()
 
 		chk_mpc_endp_attempt ${retl} 1
 	fi
+
+	# first signal address drops, second one still progresses
+	if reset "signal addr list progresses after tx drop"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
+
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
+		run_tests $ns1 $ns2 dead:beef:1::1
+		chk_add_drop_tx_nr 1
+		chk_add_tx_nr 1 1
+		chk_add_nr 1 1 0
+	fi
 }
 
 bind_tests()

-- 
2.53.0


