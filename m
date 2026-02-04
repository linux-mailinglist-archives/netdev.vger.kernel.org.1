Return-Path: <netdev+bounces-256777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FKuLEF7g2nyngMAu9opvQ
	(envelope-from <netdev+bounces-256777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:00:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D07EAB13
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D808C302DBFB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80385346FA6;
	Wed,  4 Feb 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIvZxaBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FA346AF2;
	Wed,  4 Feb 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224275; cv=none; b=U/TliRUPQANi5ghtvIondKwGylKNgVR1kNbJOOIeKo4f6t3gSgR9dn09/gZzFsExL+ks6c3rvMsSP9hd6J/b0L2jNLw4cvr57ml7/LtPMdX1Xt2PmC5qB3AIZRpBgs5PJPMmBLlC93H1cYkDYz4dPd+rId4v/nfHcLfWEuvRXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224275; c=relaxed/simple;
	bh=1zfybBZwVsB3HlU8u8Zo9i/xyLjeozTzroCm71b7qm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHK+531JtSBZmd625gxqRv5OGCTNR9CJZeWlG7fRejXfFcDGd0BrPZprff4cxM5qU0ZRJJdaWKDCVh34IMKuzH7ZC+UvZT2DZHGd+9GhOiKgKb8NgDTOD9KSgt076pmx3OuXCxhvE890+YFfvIW4bzE/OPGnJETc/OIR38FtaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIvZxaBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDCFC19424;
	Wed,  4 Feb 2026 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224275;
	bh=1zfybBZwVsB3HlU8u8Zo9i/xyLjeozTzroCm71b7qm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XIvZxaBvol0eCnYqMTn/MRmMybWNNsHgsd4NaBClWDHWN8lP+KngAQJ7qdrjTte4S
	 huaH8t4AIQLLKv7h6OtExepK/UdQFBQfAC9Hi1YfGqMCF96/CR5gDnmrf6Npiuvclu
	 pe+BtCxjN1YQIxrk2oAD28Mw+amTvgfujHsakihk+P37G4jeVlbwwa/61Otsa2IBy6
	 qRpWNTG2UqboYpWFhC/LnBHu7gYBFF/tqbSfjLnd3iPg0yot8cK0LT29lTQ81AE/Qb
	 hDUj2wJhx38uES8n7+1yHdFzEsW7KHassmbJsiokE6O3j6ei2ax/UZB/DWSNkiOWUJ
	 kcSYbQGMmM6rw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 04 Feb 2026 17:57:28 +0100
Subject: [PATCH net 4/4] selftests: mptcp: connect: fix maybe-uninitialize
 warn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-4-cb559fb6b50a@kernel.org>
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
In-Reply-To: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1zfybBZwVsB3HlU8u8Zo9i/xyLjeozTzroCm71b7qm0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbq9oYDdOP3f4xTcxiHsvne0rLUramaSw01L66csbVd
 ZM55qS5d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk+FFGhtuPfnHe5F7dr/P0
 3dJFGY63ZHN63Rucdp9bsaGOpVBO2YThnwHXm/e/9hlPV+S/GnZ5Dm+68JIj23Y67yqcrfjvjZf
 PFU4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256777-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58D07EAB13
X-Rspamd-Action: no action

This warning can be seen with GCC 15.2:

  mptcp_connect.c: In function ‘main_loop’:
  mptcp_connect.c:1422:37: warning: ‘peer’ may be used uninitialized [-Wmaybe-uninitialized]
   1422 |                 if (connect(fd, peer->ai_addr, peer->ai_addrlen))
        |                                 ~~~~^~~~~~~~~
  mptcp_connect.c:1377:26: note: ‘peer’ was declared here
   1377 |         struct addrinfo *peer;
        |                          ^~~~

This variable is set in sock_connect_mptcp() in some conditions. If not,
this helper returns an error, and the program stops. So this is a false
positive, but better removing it by initialising peer to NULL.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 10f6f99cfd4e..24b4abac8687 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1296,8 +1296,8 @@ void xdisconnect(int fd)
 
 int main_loop(void)
 {
+	struct addrinfo *peer = NULL;
 	int fd = 0, ret, fd_in = 0;
-	struct addrinfo *peer;
 	struct wstate winfo;
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {

-- 
2.51.0


