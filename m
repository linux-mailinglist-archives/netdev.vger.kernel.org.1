Return-Path: <netdev+bounces-303855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X2RZO9iKRWruBgsAu9opvQ
	(envelope-from <netdev+bounces-303855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B26F1ED1
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b=EygoASXU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303855-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303855-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08632300E03C
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FC34750D;
	Wed,  1 Jul 2026 21:47:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3237756B;
	Wed,  1 Jul 2026 21:46:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942420; cv=none; b=XyQZOf7HJ0DwcvfLyJiSE8jM9EsPBeNVZZjogabAb+LisqTXHlgCytil4Cn2KnCoo35AnfyTA3fwWUwCWgPXGG+e+9ZDP+VgL40jCIa44Bp2DVsefj8KnbHWb4iYJ21CLcyOQv2jSiBWm9uEXKiNUWq2AgCY8Ez2Ar94us+t+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942420; c=relaxed/simple;
	bh=yFUEjwhl2NIdpfCyDuedNJKNrijgvX6qhZVNVGk/55U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on55H7CQFijcDytLlEwFFbq5yVX8Li8Hz13oaIo29O7lQw3qi/FLU8U0hPL8oqdsTQu+SFf0mI5FR0AfolImXiiUwDZHjQTMIH2NTgUR7kvpQZrniV5cN0E2KKjzwhr/ryu+Cvoob0n90VpA/Y++Dox6esV9x4ngHTGG/1h2qB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=EygoASXU; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1782942415; bh=yFUEjwhl2NIdpfCyDuedNJKNrijgvX6qhZVNVGk/55U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EygoASXUDWnbyNP3tHPl4FFhKIc5B+TFsXqIjeDiHAPYo///5Y+LdDlNULxPIrO/9
	 ibVPMOC/IXkpm6tIGd9Fvpau5cdvh+9wSmScOK/m3+1WVzo5mXeiB+6GxXEMFRzkb6
	 0hlwE92hDOE5dhDQzgYh7xQx1IuDQsyQk7I/unWbRQqJVKmvCOd3KjwGDcf/xd/YL/
	 7+yU3YVVYW/Qo/JDekKQ4055Qw09HtzpnRPl1UHQp+RPHy++TZO/q0WZMpUD3RIiVG
	 Pj1RVyeWQ4/ZsWf740EcT2j+21li5Es3qA04o2+FxFBT8oF9yKGWBgBQlaqE6Y84wr
	 hG9z/93xRaZyw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id AD38A126545;
	Wed,  1 Jul 2026 23:46:55 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 1/2] landlock: fix TCP Fast Open connection bypass
Date: Wed,  1 Jul 2026 23:46:27 +0200
Message-ID: <20260701214628.33319-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
References: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:hexlabsecurity@proton.me,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303855-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[buffet.re:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E1B26F1ED1

The documentation of the socket_connect() LSM hook states that it
controls connecting a socket to a remote address. It has not been the
case since the addition of TCP Fast Open (RFC 7413) support, which allows
opening a TCP connection (thus, setting a socket's destination address)
via the MSG_FASTOPEN flag passed to sendto()/sendmsg()/sendmmsg(). The
problem then got duplicated into MPTCP.

Landlock did not take it into account when its TCP support was added,
leaving a bypass of TCP connect policy.

Ideally a call to the LSM hook would be added in the fastopen code path,
in order to fix this generically. But connect() hooks are designed to run
with the socket locked, unlike sendmsg() hooks.

Closes: https://github.com/landlock-lsm/linux/issues/41
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 security/landlock/net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index cbff59ec3aba..46c17116fcf4 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -351,6 +351,14 @@ static int hook_socket_sendmsg(struct socket *const sock,
 	access_mask_t access_request;
 	int ret = 0;
 
+	if ((msg->msg_flags & MSG_FASTOPEN) && address && sk_is_tcp(sock->sk)) {
+		ret = current_check_access_socket(
+			sock, address, addrlen, LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			true);
+		if (ret != 0)
+			return ret;
+	}
+
 	if (sk_is_udp(sock->sk))
 		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
 	else
-- 
2.47.3


