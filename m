Return-Path: <netdev+bounces-208660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5DCB0C994
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF41613DF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2682D7813;
	Mon, 21 Jul 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJmQ7m+0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B32135AC
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118478; cv=none; b=jmffczYNu5t0uHA3gKQ5/qe/VLSeBOR663tMYwcMrDsZYYYFgFL5Q2ZEoS8jRQWlHasLwimna7e7f8wB3Xfq+yvvrgrTCXSi4/4fbvYeVBZwlrq+WZdrL/MImX9XGwOEmteX5rakvQ7KqzDmkDtyeTK9iru1XY2D3HXKDDmmKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118478; c=relaxed/simple;
	bh=oI+83+W4oozQ8EHmlpoBZiy3lMrSKUK4EzNWOf/BIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcugMD1Fi3PMAFKeXIN6BcAKz43hW6Y6VJVeXmwbM4m+G3whIy9QA+40wOZUqdRdyrrqQrcO9jTeJi5nBrjpN0d1XxQtv0t9aHAZ9p0Ahl1om5oDJeCaCyVXzaVXDbuzV9RiU+qCG8RGltg8J3f2Cm3jAN5IZ67BVxCKqvOBuCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJmQ7m+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753118474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhdEmQSDbCt7QBX8iC6DLnRD97GE6x+SallBwyKuccU=;
	b=CJmQ7m+0PF4H9OMGcD/FUQWLh6hGcU2QWIAabir1yyYlioRWJUQOkulq3i+GxkGURk1Fr7
	HAucjpkco3qMI2j0KQZgoOHSblssZtChSlj9lsmkdql4A+FJgcX9lluE8auTF5hgezoUX5
	7FyBRW+Zh+QpY8ajoYybmxhZw0y9E+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-y2gAl8j5Pe2PUN-QdSkkOw-1; Mon,
 21 Jul 2025 13:21:08 -0400
X-MC-Unique: y2gAl8j5Pe2PUN-QdSkkOw-1
X-Mimecast-MFC-AGG-ID: y2gAl8j5Pe2PUN-QdSkkOw_1753118466
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDF101800EF2;
	Mon, 21 Jul 2025 17:20:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A6371800D82;
	Mon, 21 Jul 2025 17:20:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH v2 net-next 1/2] tcp: do not set a zero size receive buffer
Date: Mon, 21 Jul 2025 19:20:21 +0200
Message-ID: <20c18165d3f848e1c5c1b782d88c1a5ab38b3f70.1753118029.git.pabeni@redhat.com>
In-Reply-To: <cover.1753118029.git.pabeni@redhat.com>
References: <cover.1753118029.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The nipa CI is reporting frequent failures in the mptcp_connect
self-tests.

In the failing scenarios (TCP -> MPTCP) the involved sockets are
actually plain TCP ones, as fallback for passive socket at 2whs
time cause the MPTCP listener to actually create a TCP socket.

The transfer is stuck due to the receiver buffer being zero.
With the stronger check in place, tcp_clamp_window() can be invoked
while the TCP socket has sk_rmem_alloc == 0, and the receive buffer
will be zeroed, too.

Check for the critical condition in tcp_prune_queue() and just
drop the packet without shrinking the receiver buffer.

Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - do not account for truesize, check for 0 rmem instead
---
 net/ipv4/tcp_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 672cbfbdcec1..81b6d3770812 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5549,6 +5549,10 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
+	/* Do nothing if our queues are empty. */
+	if (!atomic_read(&sk->sk_rmem_alloc))
+		return -1;
+
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
 
 	if (!tcp_can_ingest(sk, in_skb))
-- 
2.50.0


