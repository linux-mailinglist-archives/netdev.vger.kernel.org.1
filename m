Return-Path: <netdev+bounces-231902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C043BFE62B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335434E037A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055130597A;
	Wed, 22 Oct 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boW6afkY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9630595B
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171160; cv=none; b=gUlIu7RrAwekxnlMS49RrUvSzSp6NK6lx5xY/1pLQHTh20uyZ25w3qJiQEyFfTbRkRSq7sPjGZahGjDYODVQrAt6gggUeVMmS9ZJu3Kc0Mlta6DZ8h0f4w6LnbNIlxXaHXC/dwydzcb8WdrQ/bmPY026pDj6776d12iXymOW+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171160; c=relaxed/simple;
	bh=AIJALJq9EkMeNg6XdK1W0cNkmQC8F+8+odhi/bRT+oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTWJsRgBKoCbCBLslOoQGo8srfznLCDfKBmuknrUxXSyvGNJwWpK9ZvVxlu97CZTo8r+KWxIsJDZ933afeSMVC+Acjg+FvL7eo4E5yFXZNtnKA9JEsdL7HrIfGFySi2wo7huJaxwUUkhDNtYnkoUNLVaBWQkkMC8GQuW+oIxAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boW6afkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95159C4CEE7;
	Wed, 22 Oct 2025 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761171159;
	bh=AIJALJq9EkMeNg6XdK1W0cNkmQC8F+8+odhi/bRT+oQ=;
	h=From:To:Cc:Subject:Date:From;
	b=boW6afkYYcyeh0NRSzHCg7B53VPk4L0FPk4+kRarQDEe4hhs8Kz8bkP4EKi/6RSAq
	 mtrkqnAEfBNIXdYeMtNWHuM9HM0tuzzsXquF/CEchGbk+pH+QvjfcKDfdQ9r3av0Gq
	 3dOM1EA0weJbHOxZUT17O5Z0ybTcyI9axkVHZ/J3jW0X2ep4VXxpjeTtfXtP5Ax/JM
	 NZQPpaZQs/LwJ/Du/M1Qjoo1QiR7g0ZggOKjpFK5WRCWF4kmjPxtFLGyYQJMDLj3Lr
	 EYJ/cLYGyP7XbOnGm5QYHqlef8FBl5Zdr7+21eNUkNUhl+IF2qHTdISf3mmQCytxHj
	 bGmbAuPb3dNoQ==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next] tcp: Remove unnecessary null check in tcp_inbound_md5_hash()
Date: Wed, 22 Oct 2025 15:12:09 -0700
Message-ID: <20251022221209.19716-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'if (!key && hash_location)' check in tcp_inbound_md5_hash() implies
that hash_location might be null.  However, later code in the function
dereferences hash_location anyway, without checking for null first.
Fortunately, there is no real bug, since tcp_inbound_md5_hash() is
called only with non-null values of hash_location.

Therefore, remove the unnecessary and misleading null check of
hash_location.  This silences a Smatch static checker warning
(https://lore.kernel.org/netdev/aPi4b6aWBbBR52P1@stanley.mountain/)

Also fix the related comment at the beginning of the function.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/ipv4/tcp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e15b38f6bd2d5..b79da6d393927 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4884,22 +4884,20 @@ static enum skb_drop_reason
 tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
 		     int family, int l3index, const __u8 *hash_location)
 {
 	/* This gets called for each TCP segment that has TCP-MD5 option.
-	 * We have 3 drop cases:
-	 * o No MD5 hash and one expected.
-	 * o MD5 hash and we're not expecting one.
-	 * o MD5 hash and its wrong.
+	 * We have 2 drop cases:
+	 * o An MD5 signature is present, but we're not expecting one.
+	 * o The MD5 signature is wrong.
 	 */
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *key;
 	u8 newhash[16];
 
 	key = tcp_md5_do_lookup(sk, l3index, saddr, family);
-
-	if (!key && hash_location) {
+	if (!key) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
 		trace_tcp_hash_md5_unexpected(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
 

base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
-- 
2.51.0


