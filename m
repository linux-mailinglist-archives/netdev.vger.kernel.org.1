Return-Path: <netdev+bounces-281807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sItIA/Wh8GkQWgEAu9opvQ
	(envelope-from <netdev+bounces-281807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:03:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D777F4847AE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BD3C30F3395
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CE3AEF43;
	Tue, 28 Apr 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIIKIkPS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1F3AE6FB;
	Tue, 28 Apr 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375413; cv=none; b=BbZkQpvuOLjxviZ5kDCnInuhg4QLZUp/o8NXDZ6eKe1A2AAu0eb5kmnL3f4tYmGmHlIxIRDaybfMKBkkibj0vE5p9RBjkHxPxFxT/20HioGQf2XwY8gFuQOY4XUdugpxrs9nA3xgM5nmag7Y3dlPwBV7mMSwM0rmSu98ddSps5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375413; c=relaxed/simple;
	bh=0q4Kb+0MtHIIchjg9qK9s2IuUDQ6rf+FF6oXl0WBVmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=npP8M2qPHn04u3eMi7WoM3VHC5w2eYnia7ZB6NkyEPmAqURMNkFs5AsklxhBu9R8Muz9c3tv1Tb1xFmt5JTcpLjYfYykVu2uodGcz6KcC+Xjsh0mkCSk6I9j7N91jSbGSz+4vawT3yLme9hFKjtWVYe0gfgCZPZJWVCtpiHD678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIIKIkPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C410CC2BCAF;
	Tue, 28 Apr 2026 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777375413;
	bh=0q4Kb+0MtHIIchjg9qK9s2IuUDQ6rf+FF6oXl0WBVmY=;
	h=From:To:Subject:Date:From;
	b=rIIKIkPSZyEBpy6xqFgqCLsKAMYmHP+bJRi99K7hDkUHKZ+uGXAO1uPw7nEDkzMT3
	 FhsCzeY1q1BqO0SJ3GSw82aFXOSqBnjjItWVVL6y/3BrDvfPKd5195NBz9ELgyQCJ1
	 m1Up0rixZ/1LHFdgz0IDxI7BvafCAjx9dnhQcDIpge2GuTEokTm5NyUbKkX0Do4/u3
	 CeN/xFu6x8wWtB4pharQhrac1nnjRtXZM37EZQOlGTrUSx0nqXs865aRQmKSq1cYmB
	 n4N4xWNawnlexPolvXTy72ib+G8JHrJuKedzmailigyhzAFnuVyWduduAgdfdHGp2j
	 IxPb/xl7NstLw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nfc: llcp: fix use-after-free in llcp_sock_release()
Date: Tue, 28 Apr 2026 11:22:46 +0000
Message-ID: <20260428112254.2514924-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D777F4847AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281807-lists,netdev=lfdr.de];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

llcp_sock_release() unconditionally unlinks the socket from the local
sockets list.  However, if the socket is still in connecting state, it
is on the connecting list.

Fix this by checking the socket state and unlinking from the correct list.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/nfc/llcp_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index f1be1e84f6653..feab29fc62f44 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
 
 	if (sock->type == SOCK_RAW)
 		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else if (sk->sk_state == LLCP_CONNECTING)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	else
 		nfc_llcp_sock_unlink(&local->sockets, sk);
 
-- 
2.54.0.545.g6539524ca2-goog


