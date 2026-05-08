Return-Path: <netdev+bounces-285945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PifBZYh/mmunAAAu9opvQ
	(envelope-from <netdev+bounces-285945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:47:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5BC4FA2BC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9B530E2AF3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC8410D2D;
	Fri,  8 May 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaAuDJL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6A413236;
	Fri,  8 May 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262040; cv=none; b=nFMeogymOmOfGuA8yX21vGsapaSptc6+r7fScfBz06w4v4jANE5NtMOJK26URGdVsFWd6+J9DTdbBUs22cCqVMb7VeAn6pGxs+WU45d5tIvz/hYWiaTDG4XCAS3eh4tn9fPO2/tMA/VGcucATj21ws1qrQCP8GLxmBIVV6PN+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262040; c=relaxed/simple;
	bh=JEJPS1+boQOCZ53oINqHyPXexdvauP9zSb2cgQldesM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eN5e/jq281IHHS0Xuk0Z1AV/n3ZP5J0GfI791Xnr1JFIZux4rtP73lZ9Xvmz8jIIBYycBrlBOGy6CFSq7Afcge7ECe2dVVEYrqEzadYcqkajPTOhuDKOYdva0f+0On/z0Y4/6YcWvN2nCLFyjpRaRQ4pVinfsMwiuMXXascM/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaAuDJL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48D9C2BCB0;
	Fri,  8 May 2026 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262035;
	bh=JEJPS1+boQOCZ53oINqHyPXexdvauP9zSb2cgQldesM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CaAuDJL4Fkxkmhwkcrw5a0fb+rhxCsjt9ropvf0UQWrACe3yGt+JBAYU3bj15EBIm
	 WEUg9FaXUgammdTkHTaPR805bM7wzMD55evKzXIKdFTE6K6Li6mObKBZJzcjQup6zW
	 Z35E1iRQ1wGds5Vgmq7KqkYj1g7P/7SNGgHfErf2BaZGKmoVZVWQQ+JYM+ZesvX2Ga
	 CDQ/9bQQk4Gs6QQKso0lgQ7vFuy6AUHuN02jlrQEolIy/4ZFtK1C7P6ytCLO15anek
	 OlmGfIXAVZi9uW01UagtRDmOKbgcJwarhpRXGjKaIBGmw+pqZP2bmvIHjtjJq0R1iO
	 rVpqTQILabIJA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:50 +0200
Subject: [PATCH net-next 5/8] selftests: mptcp: join: allow changing ifaces
 nr per test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-5-c84e3fdf9b6a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JEJPS1+boQOCZ53oINqHyPXexdvauP9zSb2cgQldesM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KTCr8y5e/WBr6u4ZC463J85Y63q5dltXVVnQ1KO5J
 SFSB7fkd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkGxsjw5TYRI+Lzj7bGhMF
 FvhIpj5/tuGSep+KBWv/Tr5dqs9KZRj+1z9cU64hLjMr7J2E7d2I9L70k4Jvy4s337uYsftyzKd
 JfAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 5A5BC4FA2BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285945-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

By default, 4 network interfaces are created per subtest in a dedicated
net namespace. Each netns has a dedicated pair of v4 and v6 addresses.
Future tests will need more.

Simply always creating more network interfaces per test will increase
the execution time for all other tests, for no other benefits. So now it
is possible to change this number only when needed, by setting ifaces_nr
when calling 'reset' and 'init_shapers', e.g.

  ifaces_nr=8 reset "Subtest title"
  ifaces_nr=8 init_shapers

Note that it might also be interesting to decrease the default value to
2 to reduce the setup time, especially when a debug kernel config is
being used.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..28da9df797ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -63,6 +63,7 @@ unset fastclose
 unset fullmesh
 unset speed
 unset bind_addr
+unset ifaces_nr
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -146,7 +147,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -165,7 +166,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done

-- 
2.53.0


