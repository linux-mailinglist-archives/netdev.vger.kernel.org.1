Return-Path: <netdev+bounces-200559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7FAE618F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB61B7A63DD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906B283C82;
	Tue, 24 Jun 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="rwF9Q1CT"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3619D084
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758868; cv=none; b=WjVKGRMvkf8BppfQe2s0jnqP2YulJK5iOWy2GIzXFiTtkOPK8Tazt26Dq7mBu+awVPT9EfeT4uK1KoMPqpa4/nDAV/sKsAo3mSqa0nmJoIZ3jrUFYtevvaeuqDKM2zUvyhRw7Vbg1iht3A/HclHX3qwAIkGdlAHZLuIgh9HJv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758868; c=relaxed/simple;
	bh=uqkz9n3cXeZ8dWR3V7k1mqJrp/VlUn32LAcNLj9u9Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xv5oCWH/5O2l2gcj9Dj9WmgJkZYG57HOew0+3VgSe/OlpXGpXVv+LjIqbs0VUUAqhsVZPwzwETkh1lNNBF+mqEZiYoHa/ngeWjPVVLGyIp5kYcXlj/PT/ZYRnUfMhmC/Nq935rFHophuveoNRth9pDBVF4U+GKXAJ6y+kqtewcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=rwF9Q1CT; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0MA-00AXas-UV; Tue, 24 Jun 2025 11:54:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=mb24HdoCl0957wtvOLAlFVXDR/MMgGHlQT3zT4JrkPk=; b=rwF9Q1CTjfwpBGkV52UOkUhx5m
	7c+srA+xERSbc5QOrn6LO/ZDaAYZOtEbzyG7XTCiCN51Kcq+ZykOOSdm8Z7HKQ+H6qzLbWdzZXkC0
	HJBbN0J7cUpTmp2FMU0vgQCwu9KCoO/8Rs/e+m4JKLZvGHdYOUH31ijI1i9X4DwE//s/wNtqQlp1O
	W6vKznZZcVlAaaVR5MFA3vsFXCzdMdi7N+KKMEKgQn6fqnE6/9c0WL2JN9s5NIBrRXxde0fLP29xL
	O0CMZbnh80GVDcZ8Cm2FTgDMzY1d5nng/rhQ9gZYOR/BD+41FAUPzEA4SkJ5luwFD8edcheeXijJM
	l/nM9+hA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0MA-0002ZF-JM; Tue, 24 Jun 2025 11:54:22 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Lk-00FYQf-LG; Tue, 24 Jun 2025 11:53:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 24 Jun 2025 11:53:50 +0200
Subject: [PATCH net-next 3/7] tcp: Drop tcp_splice_state::flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-splice-drop-unused-v1-3-cf641a676d04@rbox.co>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
In-Reply-To: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since skb_splice_bits() does not accept @flags anymore, struct's field
became unused. Remove it.

No functional change indented.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/ipv4/tcp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 46997793d87ab40dcd1e1dd041e4641e287e1b7e..b6285fb1369d32541b9f7d660ca33389b7e4da61 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -324,7 +324,6 @@ EXPORT_IPV6_MOD(tcp_sockets_allocated);
 struct tcp_splice_state {
 	struct pipe_inode_info *pipe;
 	size_t len;
-	unsigned int flags;
 };
 
 /*
@@ -803,7 +802,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 	struct tcp_splice_state tss = {
 		.pipe = pipe,
 		.len = len,
-		.flags = flags,
 	};
 	long timeo;
 	ssize_t spliced;

-- 
2.49.0


