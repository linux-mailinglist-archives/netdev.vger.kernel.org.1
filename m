Return-Path: <netdev+bounces-229211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2DBD95E9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C05674F2267
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16C2D4B5E;
	Tue, 14 Oct 2025 12:36:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0030C371;
	Tue, 14 Oct 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445400; cv=none; b=CIH6ki/YlZhqRw40B3XvtxKS3nr6WqA034rTumCSv44tp8spW1ZGweIDccM+BZv/HpMTPT13aSYPqCDFlMU/ZiQbdjkkZStNRv3OuEvmfhYXLbr8gXocmXxrgCd0d1FDwHmW2XM74dDFY8tz72pZInWnqnQdZYna6wf8h0KPk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445400; c=relaxed/simple;
	bh=k/Tok6k6D/CdQpW7VbJVnHdNR0BBriLH6Ww7ZjTcrIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbvPHOH0fgUzpTp5YUDpPUaTxTMBPjzEYi8EaZHuGlcXWrBwgZ91VJ+I90xXUKeAPhD/1PR1O/U3C1SNTJWkYBGbuMGLCdX76Jyi2aUiAEqDFrMle8+kYdtwFdaiHs120NPumZpAE0K18cZChUFR5CImGoV8zvdycCJn/NnPu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id C29D98B2A56; Tue, 14 Oct 2025 20:26:36 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1] mptcp: fix incorrect IPv4/IPv6 check
Date: Tue, 14 Oct 2025 20:26:18 +0800
Message-ID: <20251014122619.316463-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When MPTCP falls back to normal TCP, it needs to reset proto_ops. However,
for sockmap and TLS, they have their own custom proto_ops, so simply
checking sk->sk_prot is insufficient.

For example, an IPv6 request might incorrectly follow the IPv4 code path,
leading to kernel panic.

Note that Golang has enabled MPTCP by default [1]

[1] https://go-review.googlesource.com/c/go/+/607715

Fixes: 8e2b8a9fa512 ("mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..efcdaeff91f8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -62,10 +62,10 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (sk->sk_prot == &tcpv6_prot)
+	if (sk->sk_family == AF_INET6)
 		return &inet6_stream_ops;
 #endif
-	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	WARN_ON(sk->sk_family != AF_INET);
 	return &inet_stream_ops;
 }
 
-- 
2.43.0


