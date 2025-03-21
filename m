Return-Path: <netdev+bounces-176724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBFA6BA2D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2D817E1CC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D942236FC;
	Fri, 21 Mar 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOh72Shn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50712236F6
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558060; cv=none; b=VlXvPZVuXXDQNTtAKKoKxfFpiwtor2QjE+BMsXac/uOSDdVZl9sIGKTjnPk/zwskv9b9YmfwHZkGe/ZrEWoROaX49QRVPjE7uI3ob73KCd/6DgHMQxOalgpD09KziiXpE8fv0auklGGbt4WgQg08R3q1anQhiIrXMll6cB7nwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558060; c=relaxed/simple;
	bh=pdywwyIayKogf87oN//uzTnfLtqQGG6KsOSsoVWgr+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADipmr+OFQTCrHGfle1lUFNt+FGu1+MAvjc1peRuW8ZI1dWPRFGxy8WZEz/urlD5+s1vtiNLgT9kPcZ2Ns/xb5rEjMO91dmnpOPglJERzQTwtCwikSRORIByTIYS59uxizIR6vfdEXWpz0s7nPf12Hp4IQgmAEzVz1i9H8umwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOh72Shn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbletQxslZ4D1Q6oiKeS4bSsCigDnk9bRZm0p5ktGSk=;
	b=TOh72ShnG67PqNZgYtId4L+wd+pXLq8KshcTL5hpBZsLXRbCdWzBh06+IHocX4QRlX1bYM
	5JNs8DOOfJVkj9jY/OtuuJX8iYHu9jPMiv/aZqD0TResb1D8yEb433kAoz69EGipxrn1qw
	Q7ck+b+DrN9TyHVr+p1tH4m1Sw2ymXw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-h1ql678FNASf6wjYfLBhKg-1; Fri,
 21 Mar 2025 07:54:10 -0400
X-MC-Unique: h1ql678FNASf6wjYfLBhKg-1
X-Mimecast-MFC-AGG-ID: h1ql678FNASf6wjYfLBhKg_1742558049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 753AC196D2CC;
	Fri, 21 Mar 2025 11:54:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44D95180175A;
	Fri, 21 Mar 2025 11:54:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next v2 5/5] udp_tunnel: prevent GRO lookup optimization for user-space sockets
Date: Fri, 21 Mar 2025 12:52:56 +0100
Message-ID: <e22492f139a67c34c639737cc54b3a57a8c78ef3.1742557254.git.pabeni@redhat.com>
In-Reply-To: <cover.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

UDP tunnel sockets owned by the kernel are never disconnected/rebound
after setup_udp_tunnel_sock(), but sockets owned by the user-space could
go through such changes after being matching the criteria to enable
the GRO lookup optimization, breaking them.

Explicitly prevent user-space owned sockets from leveraging such
optimization.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/udp_tunnel_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index aa9016619c25a..2326548997d3f 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -92,7 +92,8 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 
 	udp_tunnel_update_gro_rcv(sk, true);
 
-	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sk))
+	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sk) &&
+	    sk->sk_kern_sock)
 		udp_tunnel_update_gro_lookup(net, sk, true);
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
-- 
2.48.1


