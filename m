Return-Path: <netdev+bounces-155785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D2A03BFA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513F87A2B85
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FF1DED66;
	Tue,  7 Jan 2025 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZtkPhxYC"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30F19ABCE
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244886; cv=none; b=eCN8QVglstKHisvScnLmV+ZcanRAe97d45EONZjOMKes9oG0WP+KDiPBoobh0IoESn6vHKZxm8vUQxu+hd6xlTMCgRIX59F/VObtg/i2XR46neztVjW60HZoXvGeXigIJfIbL+TTk83a7AwjOpVnkJzElk405CqplT3JXmja/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244886; c=relaxed/simple;
	bh=r7vAfx/plOlmdfYpDJIjrGp3Zq4uimfd6nJYGeCGi0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCxNO2SFU58Jrx9GRm2FUPjbCQMs84XPV4dqkHrptZ+4O/2VyE7Fyg9KD6totd1q1Khr3QX0GBwLRXn+FjcZkHO6lY282rpmXQyZ5PtxlxOWArA46OML9NIpWjyiZIozyL0rql9cpn0szZwq01CV0zkonEbl8xfmuhn2N7aPYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZtkPhxYC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QGPRRjjx3SxaA8ZhNuT90GMHahk+vHkRfocGVUBDayQ=; b=ZtkPhxYC2J7sHl6CrGW5FG+JRV
	meNhFpEYk8Vn94uZZX4EXGOlee+yYwXa9Gm30zNUVyDzGJxsoqud2VVQ8MSAFSsmeZil2nCHk9044
	hhZ7uolSxKvE3kb+lQfougxEcMUzwR0cMre4rH/X93F3C8y8NI0Msg0+puyj/C0xDR3xUNMdDAUYa
	tc4dBrwcP1EDlJ0adbmyYn3TATJVfMS7uUx2oeHhlBe0dOd9k1xjIF9u7h8V4wg1GH89ZKYg+Qu9I
	0pDMYHcs9ipEJNOmP9sVgIPpBV5P4aefev7rLbGHLcbT9LyDzEWbuBh7SnyXWxsv0PPBimhhh92cn
	1aEkVEFA==;
Received: from 26.248.197.178.dynamic.cust.swisscom.net ([178.197.248.26] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tV6bg-000IuO-Cy; Tue, 07 Jan 2025 11:14:40 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: edumazet@google.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset
Date: Tue,  7 Jan 2025 11:14:39 +0100
Message-ID: <f459d1fc44f205e13f6d8bdca2c8bfb9902ffac9.1736244569.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27510/Mon Jan  6 10:45:39 2025)

This is a follow-up to 3c5b4d69c358 ("net: annotate data-races around
sk->sk_mark"). sk->sk_mark can be read and written without holding
the socket lock. IPv6 equivalent is already covered with READ_ONCE()
annotation in tcp_v6_send_response().

Fixes: 3c5b4d69c358 ("net: annotate data-races around sk->sk_mark")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a38c8b1f44db..c26f6c4b7bb4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -896,7 +896,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	sock_net_set(ctl_sk, net);
 	if (sk) {
 		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
-				   inet_twsk(sk)->tw_mark : sk->sk_mark;
+				   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
 		ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
 				   inet_twsk(sk)->tw_priority : READ_ONCE(sk->sk_priority);
 		transmit_time = tcp_transmit_time(sk);
-- 
2.43.0


