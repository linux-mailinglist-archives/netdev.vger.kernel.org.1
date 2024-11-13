Return-Path: <netdev+bounces-144537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35279C7B8A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3F81F22569
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2C206074;
	Wed, 13 Nov 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U86QQTlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49785206046;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523628; cv=none; b=Gch73r4gyPoHIJzd+qEQhAA26tKQt2bGm+31M6HTy4Oc7MxEF13djj3gD70c1T6x0DHaG9kQnO21oyCSfsDUVlycMWOVnXOBpyAZgMZAZbp+UzTzD79WA1wJDJHXG1Rg7O9P2sLLjd+NAk37J9lFRBAl+Acz46AHHtJewlhdFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523628; c=relaxed/simple;
	bh=jLZjmYe2kGX8q5Z1lMDdOYCXLxA2nQXAkgTbQtibyss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRVZ9ilvvoH3Jx0YdPJnxhg7dt/4SA7fsxNJqvKHvpgDXUoGCYmzr0IKWSMZYNhCE0QmOzWkb6P3n7od4lOVz72621DRfkrEhBZbRwuTGrwnty2pdLPKQxa0FiooasB4d9tgXAtMTRzT5D6h7W0XS1bNUfOoxuNWOGMF484dFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U86QQTlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6515C4CED8;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523627;
	bh=jLZjmYe2kGX8q5Z1lMDdOYCXLxA2nQXAkgTbQtibyss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U86QQTlFvXq64shhNhTSfkgliF1a7OP8y7xeI1/14tSfgtIR8tF/cg/9kyclS1OnM
	 HiojNmcRVTduTPJMCRnG2oKFVGzN0qBFu/SUuTCxMYZFAeBNHaupaVbWUg64ejIrNm
	 /6M2HZ96d8e1/R77OWBvLKw4oxdo9NarPXUBuy+QjXHs0DyxS6EYeb9zjhK51R0WFn
	 hzA4aWZIBORBM5QoYZnuzzEjg54Mx2fSgfdCQPOTlXB4216PRu7uMnT8l4NSqBLjEC
	 cI1gkBfXOKjaJMB6LqRJ5rOgMln44BR+zE4LQKwCxt8FiqyYAtmvwo+PWfEzsTro0e
	 GFvoF9Q5wXbgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B4D637AC;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 13 Nov 2024 18:46:42 +0000
Subject: [PATCH net v2 3/5] net/diag: Pre-allocate optional info only if
 requested
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tcp-md5-diag-prep-v2-3-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731523626; l=2351;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=fOCy3J49s/tDFSTizx6qbQKYeByBMBjOxYu/MDJO9nw=;
 b=xHWPnxmlAgxsfd16AJPEx1EnW4uGj4R/JjEmmfgnBzL3Hmkc30GZ5vPzYF6SdZsjvFPghqpLk
 qjfKBbuQiiSBHYODhtp73IeEqO2X3XNzJ1QisAQRqUcu+NuWwZxmLDL
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



