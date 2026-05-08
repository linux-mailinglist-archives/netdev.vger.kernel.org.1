Return-Path: <netdev+bounces-285948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJtFOfAh/mmunAAAu9opvQ
	(envelope-from <netdev+bounces-285948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:48:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA44FA30D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC0D2305C597
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD0421EEE;
	Fri,  8 May 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxsXy9OU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D19421EEB;
	Fri,  8 May 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262045; cv=none; b=KX8LWU41VCn8Qw6HDyw9CeVzm+hCq2N4fD0+TiXbTlDplu5r8m2yT3YPCHWIOMy9w05OYfxg4VWxSZZNGEzsfvtgDPNJAAUqZTjklZF31KIs5aWgAk++6C8XTcT20ZJxavqBwcHIIuXpH5fPfbKDrer8pgrOEvtDtjsLYV3Fil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262045; c=relaxed/simple;
	bh=325C5AQXZLCkra1M3X28PDkJPHJO5DOfdGSOM4n3fqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZw4YAq1foBMnChiQIOzR2u2cg070PwV9xor7szHsavajiazM9cjyu5B6hYXYihbwegjIFtd1IOc2y9brTXwOHUppRXB4mAuxa1ROKTaRdakr+w+s0OpoHBspO51kbfWVhQBkDHE2hD9hxKfR6y9TcbQZJn3k72F0rRzP7edkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxsXy9OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D9CC2BCB0;
	Fri,  8 May 2026 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262043;
	bh=325C5AQXZLCkra1M3X28PDkJPHJO5DOfdGSOM4n3fqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RxsXy9OUY3PKH34jfATIN07hmB8BvAvUgeS6Ipi/VG+8jKX/iiNOh6hMXAUJcU4v/
	 344KFqM50FSM0UuypiQYqhhiTze2NXoSTEKMs2qUcCWI+SRTd85vQijx1q3cf2KNGT
	 qXa/cRD01lt48m3LDeeEBgxBe4KpehrvUtLfq/Xk4/Eiu9lWyxh0pFYqDSOP2Y8lMm
	 kxQ0eathffirhwC+qb24dBvSc4/1Ot+Ew2GVOKc7RWrd07W+EEuCGbdoqfjIYWaUDm
	 n9W1//nhtj3pKCZPnPys8/CrpYMXykilidHEk7LyLYsYhbVvPksHh7lkyTcFpgt0tQ
	 +7JHB1Fq4Z7SA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:53 +0200
Subject: [PATCH net-next 8/8] selftests: mptcp: pm: use simpler send/recv
 forms
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-8-c84e3fdf9b6a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=325C5AQXZLCkra1M3X28PDkJPHJO5DOfdGSOM4n3fqI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KbC1n7UOl00PbwpT5Na99bIo5ojLYW/V9N4IB4PtR
 X9msj7oKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMjs6Qz/FGyECj0OfZ2o/8d+
 30Svjb7aNbs3bjhSc9rc6UfjXoGrpowMZ15sd5v6ynQy86orqcdPTJKzvf7tjsk/91TRvbW/4q3
 1uAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 44DA44FA30D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285948-lists,netdev=lfdr.de];
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

Instead of sendto() and recvfrom() which the NL address that was already
provided before.

Just simpler and easier to read without the to/from variants.

While at it, fix a checkpatch warning by removing multiple assignments.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 99eecccbf0c8..78180da1efcc 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -217,8 +217,6 @@ static int capture_events(int fd, int event_group)
 /* do a netlink command and, if max > 0, fetch the reply ; nh's size >1024B */
 static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 {
-	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
-	socklen_t addr_len;
 	void *data = nh;
 	int rem, ret;
 	int err = 0;
@@ -230,15 +228,15 @@ static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
 	}
 
 	nh->nlmsg_len = len;
-	ret = sendto(fd, data, len, 0, (void *)&nladdr, sizeof(nladdr));
+	ret = send(fd, data, len, 0);
 	if (ret != len)
 		error(1, errno, "send netlink: %uB != %uB\n", ret, len);
 
-	addr_len = sizeof(nladdr);
-	rem = ret = recvfrom(fd, data, max, 0, (void *)&nladdr, &addr_len);
+	ret = recv(fd, data, max, 0);
 	if (ret < 0)
 		error(1, errno, "recv netlink: %uB\n", ret);
 
+	rem = ret;
 	/* Beware: the NLMSG_NEXT macro updates the 'rem' argument */
 	for (; NLMSG_OK(nh, rem); nh = NLMSG_NEXT(nh, rem)) {
 		if (nh->nlmsg_type == NLMSG_DONE)

-- 
2.53.0


