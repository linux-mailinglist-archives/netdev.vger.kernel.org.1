Return-Path: <netdev+bounces-301053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DQpxCJ0TOWrUmQcAu9opvQ
	(envelope-from <netdev+bounces-301053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:51:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC1F6AEDF2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iMyAkRTT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301053-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301053-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 513D83023307
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60E288C08;
	Mon, 22 Jun 2026 10:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287225A2DD;
	Mon, 22 Jun 2026 10:45:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125154; cv=none; b=c9vzCcAjkClOyLYnr0MxUEKmK4SZ25ihf/KUGTlAOXEOxPjAww3Y06B4uZTNwsmElQ0KKmzMPm6jvHj/Q3uByCbVbvNvduRbmuT8fUemrhbiBDYx9dneoKyXVOND/zHXeAfPER3vF9oaNHipysUkTQTPS5xr/eM/ifbedeQnVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125154; c=relaxed/simple;
	bh=VNvrtxoaG5emAwKov6TZiEf5xy1ZkFNWlEUcXAj737A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rptcXUL5FPbajmk051Xq/AzafAND9li+hEYMo/CM2km79JNczhmvMTFLNIugjeNWKxQ+Tcj9BOo5amZ0ljegB1/nmX2YGWOhNga0AIM2pUhjkq/5fwPA+Iz2lNMsotNH/aazqHSZGIevy2hKnqgSztmWQj0tr/aN27ufvMtm+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMyAkRTT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C2D1F000E9;
	Mon, 22 Jun 2026 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125153;
	bh=YtkPB6i0OvwV1lSTcqmCxooTBK1I0ZwQwnbBpJV8564=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMyAkRTT0g6B+mY3jolDy6vdeFQNrpJ1Y3QrG8k5PwlMTjcN+qHIF9iM80NOLHlmY
	 DInkHYlF8O2bnciY0LFKHSQ1PHMuMIx6QgHo92TXN99Gck+CDMpZbZ1goEzFUmFaR/
	 rJl1vVYfq2II8S78Jhn+wyVNq2otuPq+n6m+HxGjznf2maF0vRk8/lZLapb0nf+Civ
	 BITyJS7pKSQWeORWGaP4YoMm2peErFpYG5RuN2KpUKUHoepY95n9uzp0X00lFc5epL
	 d56XJ9IFGb2zh4l5JzharQrXnAU1y+KoiUX6rTNRgm1/9Lv/NrAgBvyAyZUKUYbedN
	 beXtbuUQ0w9+w==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 17/17] selftests: mptcp: connect: use espintcp for ulp test
Date: Mon, 22 Jun 2026 18:43:37 +0800
Message-ID: <b3f8cf142bf314d3611df4cdf4df01ef511d33d7.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301053-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC1F6AEDF2

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config          | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..f48bd5183fb3 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,7 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESPINTCP=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESPINTCP=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..299a7a02d6f5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -285,11 +285,11 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 	if (buflen > 0) {
 		if (strcmp(buf, "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.53.0


