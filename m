Return-Path: <netdev+bounces-281005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHuvFduM62k+OQAAu9opvQ
	(envelope-from <netdev+bounces-281005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AB5460C9F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 826FA3008093
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5231E820;
	Fri, 24 Apr 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IIslq6yL"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91F78C9C;
	Fri, 24 Apr 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044694; cv=none; b=ZZ6gGZxSUcyvsWTjLEQQQog8ilwBSAG9X0qdCyhIseBIo9SX4WWsPpR5iSu5Wkdr5vmtWKJbXkMG2y5GOY6L3r6OzvHLI1BxNIm1ciY7NwgyJA0jl0zyU4sZOCWOwtp2p5tcHulj8C2mqYIhQaMhAyqZ0qykk1cvqoNfyWIAaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044694; c=relaxed/simple;
	bh=3HzOGWPVD9l+Z39MN570g5qRFFqQa0VcnYpa0ZzfrDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YsD4gKjWxj/nYBYUiNeymkUt+XKwWLA2wQwhKvJ9nYgL3kZ490YBxtP3/fXuUfkMCGfUBRB+h7BZoSqcA617y/WJyePH0mk1dP1pAlXF0uCNmAosYD9J3JIsoVv3ooYvUUvu4WjKrYU5/FLrTYCIaTn8jrWSuYHXlc+mcopaR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IIslq6yL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=i9bJYBiYJbGZAYwtJkfIVM54rCO1rb/ZEIOc49bK8H4=; b=IIslq6yLCHl9c76QRgnx10KVyb
	GcRTKfZ5N1tfUIgLNo512dbhx8mq60/f2taXj+KM94S+L1TPi4vEoAGypP6u8sqnCYSikilE2q0fz
	UtlL9CTyDKMyjG6X9zYcX5nOa1L9YMjYZfRnNBnmJxYjyVoqvyulwkEzqYiGn26s3gfo+VTR+qfgj
	SeIdKzSgW+3D8FaZo8ySDJNhKt3ZROaCYms+S11Xl1z1uTlgxinKuC2k5gJpO0HsUvZ9aoVAh03V2
	qmrSeaNdopjyJWL3opleC+bfTneFgn+/SHBYMTZ6mr47PcpB1BnCgWsURt9DSXWTk+eHTA8sOYtX5
	VegzABWQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wGIV4-003Ggi-0q;
	Fri, 24 Apr 2026 15:31:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Apr 2026 08:31:16 -0700
Subject: [PATCH] netpoll: fix IPv6 local-address corruption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-netpoll_fix-v1-1-3a55348c625f@debian.org>
X-B4-Tracking: v=1; b=H4sIAMOM62kC/yXMTQqDMBAG0KsM39qAjSGmuUop4s+oUyRKYkUQ7
 y6ty7d5BxJH4QRPByJvkmQO8PTICO1Yh4GVdPAEnWubG21U4HWZp6nqZVfOOaPr8umsLZARlsi
 97P/t9b6dvs2H2/VX4DwvAkKXUG8AAAA=
X-Change-ID: 20260424-netpoll_fix-88842a798663
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, clm@fb.com, 
 gustavold@gmail.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2671; i=leitao@debian.org;
 h=from:subject:message-id; bh=3HzOGWPVD9l+Z39MN570g5qRFFqQa0VcnYpa0ZzfrDA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp64zKRfCMQXAECH95j3oQzhA3UZZm37udE0kHZ
 r2wz3sKkSiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaeuMygAKCRA1o5Of/Hh3
 bVS3D/4iCZQmkXmKHEUGtMH7G9B+nLjO14nSPQ6AX9zFvgY9LfIMsaGESq7QUvPJqeCEXX0t5tY
 c7k/ZKJ9SgL4kKD04oRsyL2k82fGlc2JvzCe9tIZ+itPGWKqWEjoT+ROuB9S5UeV3L8RhQSsEEX
 fIIgwKILF57av8ph5bfeUKuW/7AVxiT//q7/UYw0x7ntB7Fk4SCXoBYZfGwqiWsQ5yhSC+71mgS
 U0bI0PKaESDBh4PLqaxqSaqWy4mAroiITdDSyrhd7DPW530z1w7b0//UpeZZvKEpqdvFjqyFOk7
 j/1iELaFtEYrmMACeiw960PTNNXBaEcb4zqcGrUhmblCb8alaF1I2DLyAI7Ek/60TUqjrhdoU8Y
 jYpZhKpIDxwLp6uktVowHz6BDl5gqZ52lUSBn02dynPZgNuTJ8zTK5K3wHmMXoFbBB5dft7t9w+
 lc0Kzf5DdsurPBcHHBD+9bFkrLh1jYJ6n2FCVPGy8iR9SinPbSTKrpKfIlhNWu0fPiwuEVhj1Np
 +NT7CZuQcyYQygcvtzfuZHZkX1bRKUDHshhMd36eZm6c6OLdkAKtFdv9/cforznSmIKOVz0JjKE
 yRg8GBgNMF3G4v4WaqNudJovEWK1xe734j7YDd5MlMBZVK4vLD9q70qjCxFA7qVoMH3nHolptW1
 yh5J4Ko/uh82JdA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 59AB5460C9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,gmail.com,meta.com,debian.org];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

netpoll_setup() decides whether to auto-populate the local source
address by testing np->local_ip.ip, which only inspects the first 4
bytes of the union inet_addr storage.

For an IPv6 netpoll whose caller-supplied local address has a zero
high-32 bits (::1, ::<suffix>, IPv4-mapped ::ffff:a.b.c.d, etc.), this
misdetects the address as unset (which they are not, but the first
4 bytes are empty), calls netpoll_take_ipv6() and overwrites it with
whatever matching link-local/global address the device happens to expose
first.

Introduce a helper netpoll_local_ip_unset() that picks the correct
family-aware test (ipv6_addr_any() for IPv6, !.ip for IPv4) and use it
from netpoll_setup().

Reproducer is something like:

  echo "::2" > local_ip
  echo 1     > enabled
  cat local_ip
  # before this fix: 2001:db8::1   (caller-supplied ::2 was clobbered)
  # after  this fix: ::2

Fixes: b7394d2429c1 ("netpoll: prepare for ipv6")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
I've found this problem while using Chris' new AI toy (kres - Kernel
code RESearch agent), against netpoll code.

https://github.com/masoncl/kres
---
 net/core/netpoll.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index cd74beffd209c..4381e0fc25bf4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -704,6 +704,23 @@ static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
 	return 0;
 }
 
+/*
+ * Test whether the caller left np->local_ip unset, so that
+ * netpoll_setup() should auto-populate it from the egress device.
+ *
+ * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
+ * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
+ * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
+ * doing so would misclassify a caller-supplied address as unset and
+ * silently overwrite it with whatever address the device exposes.
+ */
+static bool netpoll_local_ip_unset(const struct netpoll *np)
+{
+	if (np->ipv6)
+		return ipv6_addr_any(&np->local_ip.in6);
+	return !np->local_ip.ip;
+}
+
 int netpoll_setup(struct netpoll *np)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -747,7 +764,7 @@ int netpoll_setup(struct netpoll *np)
 		rtnl_lock();
 	}
 
-	if (!np->local_ip.ip) {
+	if (netpoll_local_ip_unset(np)) {
 		if (!np->ipv6) {
 			err = netpoll_take_ipv4(np, ndev);
 			if (err)

---
base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
change-id: 20260424-netpoll_fix-88842a798663

Best regards,
--  
Breno Leitao <leitao@debian.org>


