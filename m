Return-Path: <netdev+bounces-142490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6859BF59E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544DE1F2293D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085D9208972;
	Wed,  6 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNTLc3Ni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67D20820D;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918995; cv=none; b=Sk4a9yHm3o4mciER59gnguqWkF2bP5uyS1GNj8GJwSCzTDz0vQVWngo93B67C/ZB2r+CZ6QJMhAsQeE3/a5AYyC04j49uqPeFQrQROSLTe3RobTJ1npeZDzWnRIIbCGgESQGsJWIQa8CQN+3lI4A75RcHaL1iClP7BogJjA7wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918995; c=relaxed/simple;
	bh=jLZjmYe2kGX8q5Z1lMDdOYCXLxA2nQXAkgTbQtibyss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJmyUvFKe3D4lIShgtu7s5SIm8US44euELD16Y6w3KjPMFoA4FbNTjRIABa80VR0Rfu564bmk+eMqaJfFHkO7XSFd1G3QlzggNNWwiHw5Zx9mYgMoa8f3BLeCUIQM/oakXFMspBrbJYuN26sfXPPJqWc8Bl6YAcPv8QRRaKRPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNTLc3Ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 868CFC4CED2;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918995;
	bh=jLZjmYe2kGX8q5Z1lMDdOYCXLxA2nQXAkgTbQtibyss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NNTLc3NiiL8R+ns6+jELxr/HgX8MKL3u/BSgwz3r95H0D1PJarlhju8bJ0tKbXZH2
	 mKJ4BGHUUlmLXCrC+Ja2pbA652nzOqFrhh5H+7rgiOms6aI5uOcy9ldEgEM2pt7zpG
	 7FJx+PO2kraJltT0I7/RbROMIJY/PKTR31021b0zc4Jn5VM3ObZncVlzSG4v1tC6l9
	 OdIAox3UJDwaDHHm8QwR2tacNnGcWD9qJa2VHIS5pd5JFFLDJTox4dbW1Q6hwq83X6
	 kFHPxbl4oreEZVZNITQ7XTvKuUw/SikqdwFSTQEm5a1PpNRs+NJ98o86eQOEqPII9o
	 ycSgcQ0KQCtEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1D7D59F62;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:16 +0000
Subject: [PATCH net 3/6] net/diag: Pre-allocate optional info only if
 requested
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-tcp-md5-diag-prep-v1-3-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730918993; l=2351;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=fOCy3J49s/tDFSTizx6qbQKYeByBMBjOxYu/MDJO9nw=;
 b=2O5F1B9EZzEGVdrOCj2HomQpsZZzVQgWcK2OQNqsSIt8ApYIeTBk6eILHN1WF072Om+eeraJ5
 QUK9xiYVjVnArf7LvqgTk0a7p39cA3kBkwAxQ9IEe4ea6jHcrE1bJQi
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Those INET_DIAG_* flags from req->idiag_ext are provided by the
userspace, so they are not going to change during one socket dump.
This is going to save just nits and bits for typical netlink reply,
which I'm going to utilise in the very next patch by always allocating
tls_get_info_size().
It's possible to save even some more by checking the request in
inet_diag_msg_attrs_size(), but that's being on very stingy side.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/inet_diag.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ca9a7e61d8d7de80cb234c45c41d6357fde50c11..2dd173a73bd1e2657957e5e4ecb70401cc85dfda 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -102,24 +102,31 @@ static size_t inet_sk_attr_size(struct sock *sk,
 				bool net_admin)
 {
 	const struct inet_diag_handler *handler;
-	size_t aux = 0;
+	int ext = req->idiag_ext;
+	size_t ret = 0;
 
 	rcu_read_lock();
 	handler = rcu_dereference(inet_diag_table[req->sdiag_protocol]);
 	DEBUG_NET_WARN_ON_ONCE(!handler);
 	if (handler && handler->idiag_get_aux_size)
-		aux = handler->idiag_get_aux_size(sk, net_admin);
+		ret += handler->idiag_get_aux_size(sk, net_admin);
 	rcu_read_unlock();
 
-	return	  nla_total_size(sizeof(struct tcp_info))
-		+ nla_total_size(sizeof(struct inet_diag_msg))
-		+ inet_diag_msg_attrs_size()
-		+ nla_total_size(sizeof(struct inet_diag_meminfo))
-		+ nla_total_size(SK_MEMINFO_VARS * sizeof(u32))
-		+ nla_total_size(TCP_CA_NAME_MAX)
-		+ nla_total_size(sizeof(struct tcpvegas_info))
-		+ aux
-		+ 64;
+	ret += nla_total_size(sizeof(struct tcp_info))
+	     + nla_total_size(sizeof(struct inet_diag_msg))
+	     + inet_diag_msg_attrs_size()
+	     + 64;
+
+	if (ext & (1 << (INET_DIAG_MEMINFO - 1)))
+		ret += nla_total_size(sizeof(struct inet_diag_meminfo));
+	if (ext & (1 << (INET_DIAG_SKMEMINFO - 1)))
+		ret += nla_total_size(SK_MEMINFO_VARS * sizeof(u32));
+	if (ext & (1 << (INET_DIAG_CONG - 1)))
+		ret += nla_total_size(TCP_CA_NAME_MAX);
+	if (ext & (1 << (INET_DIAG_VEGASINFO - 1)))
+		ret += nla_total_size(sizeof(struct tcpvegas_info));
+
+	return ret;
 }
 
 int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,

-- 
2.42.2



