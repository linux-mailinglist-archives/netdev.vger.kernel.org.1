Return-Path: <netdev+bounces-99580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC38D5638
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F85282B3A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99117C7B7;
	Thu, 30 May 2024 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeGS78uD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF374D8C3
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111570; cv=none; b=KpJhe2NX90tvR62Rq20OgHh84oNIvfOKH+5ZSilZyg0f04zFIw1O4GLPLRadR3CbSIk8aWB1TNCb7oivLcFlPIpjvgE/UaiX+PGvd6QiDC4VOT/h3LuZMN6ctcUr+xnwoB+oJtTYk73n6XrS2EgHOywN7KkIcvaVjN5QXy+Vyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111570; c=relaxed/simple;
	bh=y0XU/59H1CEVT1+tFYZG3lHPRnSsqJEGSq2wXQcHgD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItPSfNxywmRJ8925gCJndLZp3L+/K9L7I4Rtwj+mEw2GdoYTR4tjA4S5hrFMqSN8nwvo51XDbuqbUpctDGsfT8gAGFOkjpvyeXT9dJUCPQQSnDJpDImhXVfBYUODWVM3OzkQpxK+f8a1lWygGrX36IwFP4Jvy3nj06pPjNi9YLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeGS78uD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1819C32786;
	Thu, 30 May 2024 23:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717111570;
	bh=y0XU/59H1CEVT1+tFYZG3lHPRnSsqJEGSq2wXQcHgD4=;
	h=From:To:Cc:Subject:Date:From;
	b=AeGS78uDhjk1DUkyx0UeQpnslHcxNooegg3RbbZ9IuloqoMNe2zVAKN84ib2qwlNf
	 Vooh3q1rdXLKjWQPM+PNcHmc2/WpvMa37ucOw+XHB+AfnR4qD/a7Jday8Iv22C6CTF
	 zxUHDqaOVb2/6XWtOcKHn2i0SkOLtDf1oEK8Gy/3XPzfWl23EolsRAAS4A+PY42rUr
	 F2EgpKZNOFvYriq5O5M4wZ6ST9u0Dq6ZnA+1Cio7USs2O4dsiHk1OJAlS3kfEAnfK2
	 eIasTbhnXpBdXmgpwelRXdU5urZWRCul8CzaIZATqKXUIcggB2Y7V7hWj5SkSEwpwl
	 qMq83w00NBE+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>,
	dhowells@redhat.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: [PATCH net] net: tls: fix marking packets as decrypted
Date: Thu, 30 May 2024 16:26:07 -0700
Message-ID: <20240530232607.82686-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For TLS offload we mark packets with skb->decrypted to make sure
they don't escape the host without getting encrypted first.
The crypto state lives in the socket, so it may get detached
by a call to skb_orphan(). As a safety check - the egress path
drops all packets with skb->decrypted and no "crypto-safe" socket.

The skb marking was added to sendpage only (and not sendmsg),
because tls_device injected data into the TCP stack using sendpage.
This special case was missed when sendpage got folded into sendmsg.

Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dhowells@redhat.com
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
---
 net/ipv4/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 681b54e1f3a6..4d8cc2ebb64c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1165,6 +1165,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 			process_backlog++;
 
+#ifdef CONFIG_SKB_DECRYPTED
+			skb->decrypted = !!(flags & MSG_SENDPAGE_DECRYPTED);
+#endif
 			tcp_skb_entail(sk, skb);
 			copy = size_goal;
 
-- 
2.45.1


