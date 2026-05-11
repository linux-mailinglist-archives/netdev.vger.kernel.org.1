Return-Path: <netdev+bounces-286593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH2eIWKzAWr2igEAu9opvQ
	(envelope-from <netdev+bounces-286593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F950C218
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5459B301D33B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0B23D9021;
	Mon, 11 May 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ebgfSf75"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E573D47DC;
	Mon, 11 May 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496124; cv=none; b=O7krW7J13sCXm7hd3YnZtSVZwamfjKtymvlooZFrle8SlqmOtw/YuYGgvTmpjq/wJfnxTiV3izQTkX9Af/qwsO4H3RuPI/9D6nw5LiWBA5Fl15Kkyvhbfjv63pPqNxacT3JyTTD9dErgh02rDUKp1BcRcz3E0c/BLffOGUOaY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496124; c=relaxed/simple;
	bh=h6zSdtN9jQgMR/YPfbG1OygHwk4VDPpboHdb0JfjOWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYoCdXQQoQGn1K7RNDc5Bphm3OnIKGPYMWapYATdp3U3h1cUmhroE6dKf/I2ptAQxXaWGU3GpV8Dj/ORg4HsK35OV2UrkziGO06Cq48RXaO7tgK580iLgLxRyRN2rdyveS7vfO5zKrgg2fFHqlz73TftRyWoWtZD6j2SXCDzBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ebgfSf75; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=1XedRuOdFDTkq6Iy8V1E9JuuU/kZM1EoPconoc3Ujuk=; b=ebgfSf75t+3LGt5JtkJLFQygEr
	L5wj4gWS37lANmsYO0OChJ5WiVfKQ3/yCdTb5uUPX2/bym7Den7I8SxdNVyGB/jDxdyPLX59q9V9j
	wrcCS47RI5S8s4CTL9zFfJnP6OhVJbU06lENAvFXBjrZygq5LcpqsC2mZXz08XdItN+rEkTlWw3N2
	6yeqK7isue4IqWXAcdCqTbnZgyyPEQ2JcwN0SXTiuiypjmzrJofjEkhzSAFP9PUOUdfz/sPgVjbV0
	P5Qc/hvOTNTqKZTS712+0QwlDjg3vY99Baq+DvR3NB27W1HSCUV4KA+IW/xxgQ11PZSfHulb93b7o
	MQBSRxUg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5I-001XeG-1S;
	Mon, 11 May 2026 10:42:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:46 -0700
Subject: [PATCH net-next 1/7] Bluetooth: hci_sock: write the full optval
 for getsockopt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-getsock_three-v1-1-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
In-Reply-To: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=leitao@debian.org;
 h=from:subject:message-id; bh=h6zSdtN9jQgMR/YPfbG1OygHwk4VDPpboHdb0JfjOWE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvxpCu685LY0M+x+JGeNiNeOAEmTcLxOpM6
 sUTKNcfLriJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 bdBED/9BQMslx5J3oS7A5NvTjE6ZYWguJWBxVtl5eXMXQgx+pnQxR54Z+7FLncjY5zaHdOnITnS
 m1dP4wc3jmkIhRPkqkgX2DCpZIgi6TYXarTJX1kh9gaRyy51HHLWnzECgR0iYtPJsPJTE8Cvc9c
 VFaic+w1TS0CSWzrCIUEr6avlOVs6/w2Aoqj5BhJLorhCZEC+JDfWaM8QIqDLwegqOJXGVKxctk
 Pbxsb0Td7VPbZBwsWZKwEbeuChZ2hDyxaPRyZSgl7HG2EHihq04JFzi/tDqMGht2lTX9+Rbmvjy
 3+SZLwUZwi02gzVmLb3JHXVEiZacpRGYpQkg79UpvPL8E2EPHCzco/JUtZUraL8USYZGZqU7upN
 WSIoc2Bpr30+8Vp/ZOw2+PHS1g1nu2YI0DeQgQo5fwuZ2nb6ydQ+XD6VF1uFXf7HEeFIIfUrOXf
 v3EndpdHewsw8+krLTJUydrQ2qwU2WBNF8G0HbsPvgUgQ4SSl73AhL7OWRk8rd4qzhvurCMNsEQ
 ZCCymxitGayugT4iMWah9JSFJTSa3BWkh778goeheFDHuBoDz9VQVKlEI4pyoZlwMi6OrTAFCJo
 v8amTK0SDOoVhFufhpCDDu+sn6zCx4pt6sQ18gJAda+OaW+aG60MD2p/eaUuZ5C4C8/9mevhmu4
 kF79nw+2DD5zFDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 1B9F950C218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286593-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In hci_sock_getsockopt_old(), HCI_DATA_DIR and HCI_TIME_STAMP both store
their value into a local int and then call put_user(opt, optval). Because
optval is the function parameter typed char __user *, put_user sizes the
write from sizeof(*optval), so only the low byte of the int is copied to
userspace.

The matching setsockopt path reads sizeof(int) via copy_safe_from_sockptr,
so userspace passes a 4-byte buffer in both directions but previously got
back only one initialized byte on the read side.

Not sending this through 'net' tree given this bug is mostly invisble,
given opt is 0/1, and the last byte is being properly copied.

With this change, the upcoming translation to .getsockopt_iter becomes
mechanical.

FWIW: This behavior appeared in commit 1da177e4c3f4 ("Linux-2.6.12-rc2").

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bluetooth/hci_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0290dea081f62..1823c06ba8940 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2088,7 +2088,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, optval))
+		if (put_user(opt, (int __user *)optval))
 			err = -EFAULT;
 		break;
 
@@ -2098,7 +2098,7 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 		else
 			opt = 0;
 
-		if (put_user(opt, optval))
+		if (put_user(opt, (int __user *)optval))
 			err = -EFAULT;
 		break;
 

-- 
2.53.0-Meta


