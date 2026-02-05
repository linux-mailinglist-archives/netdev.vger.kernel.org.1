Return-Path: <netdev+bounces-257270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCRnFa7VhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:38:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F62F6075
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2263092E04
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF62FAC0E;
	Thu,  5 Feb 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGl+MAbt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635042F5A29;
	Thu,  5 Feb 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312880; cv=none; b=SixAfNjamZD5f4/gaCQoAqRYGgva5PX0JompFpHFpAQQGt2AaM2nwFQ0D2hp3dYF3Rn7aACA28cDj/35IqIpyGLequ+X5w8DV3UerVHU0EgnbPwI/KvVxqx1j/4FiUMR12f+pq5HD/GSWCdOu3pfl4uiq8ChOWXA/Ji3FfEHGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312880; c=relaxed/simple;
	bh=vipdnvkq6uyreagW24yf/YuCiyUEI9cmZmP5NDb9Fq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1lakSBfJVaY+/4CyA8EbdD0rU8a0cyAJ9zLcrvcLL2KEzVysd9KZ1c7IoxoqZYWK+6ikIHZnO9bWhng9v7pskKoidXeW1FdH7b/8Uin1CVFmM581U/YgZS5eTFOv/QRneC4bPmMz6iPh0IMNumBrrGuMTWSxwUhA1ShTSHTSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGl+MAbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469FCC19421;
	Thu,  5 Feb 2026 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770312880;
	bh=vipdnvkq6uyreagW24yf/YuCiyUEI9cmZmP5NDb9Fq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CGl+MAbtRgM3FmcVYWNHtB5eKwzKhhOi9HJOl+cUC7Zvc7VpzuWz79r4fSuBmX1US
	 e4Hzb2hSMoXTxqS8qMdpiBM2tX7F9dClO5OTXkZnP1pVOXEcB9FWhDd2awaKFvT6FK
	 +ktSdam/PYeoCZglWtLHDxcqL22PIY+eFe+IqgrT625uyIJ3zOe5yWohwhGKY0hi7W
	 s1e0ohNmClRNl8KOp2kN0b2s1PNC0lpJFInkM5fFMT8wCVDVW90iWEL/DpplMqsH0T
	 Q+rlw+hUO2R5oir9otS2PAyY5hD/n/czynnR3mEloCiNg4ADFnKvXZ1hTZ2+Rqvdi+
	 zpuohGpovZ2tw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 05 Feb 2026 18:34:24 +0100
Subject: [PATCH net v2 4/4] selftests: mptcp: connect: fix
 maybe-uninitialize warn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-4-c2720ce75c34@kernel.org>
References: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
In-Reply-To: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vipdnvkq6uyreagW24yf/YuCiyUEI9cmZmP5NDb9Fq8=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGmE1KTIIUtqIJ4+1J4/ew7GrKBSZPUzop1jEqgvyfLkHNVq6
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmmE1KQACgkQfCLwwvNHCpchnQD/ehpj
 2DTWtEcxaDZb4zWrIjXpZQaLyebh1NrE0FaRSlcA/24rLaJmG/2YhrPpGutdwbP6MwlJ7Cco9kt
 di/wvztoI
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
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
	TAGGED_FROM(0.00)[bounces-257270-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A5F62F6075
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
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
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


