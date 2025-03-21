Return-Path: <netdev+bounces-176723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C58A6BA2C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4A33B0A7B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67B2253FC;
	Fri, 21 Mar 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4o7oInH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCC2253A5
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558053; cv=none; b=HFEeYFRbKnaBF3Nf2Jp8wAFe8wi8tVOTcAM8bNPVRjOjmFn2iGV3wG6BuyOR/pCsxo2LpHFMwQwpgtUG7PoKmgEWsNrWI4FesnDRmYN71H6OouPdmFQQa4IFXeW7TtCerkzJgA2P7SpP9bkdOBrlpyrS/vom8YQUN//L0E+aA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558053; c=relaxed/simple;
	bh=U2JOwp6DtMRFNez4QN0EOTJDgdqZLD26FV2M2V2Rcv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsHfSUMkttfaBcVP6h+qTdZ9SvAlhSOGJTrK3QTDXAlaehhp3UHE6+V+BRb8bftX8aPL+0R+YghZXbZfiRQUHxH0Xl/9mT9yib+GMJGUWG2mKrpTZ/QO4TpNDKf6ZkblXdvvG8gpga25BaszrDXxJYkd+8l411iv9FY8DP4TCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4o7oInH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHBUmN4exdzS6O8/31aKZhVk/RfP+2gZKpXatuGkios=;
	b=Q4o7oInHJWnmW3lvQ8rTe9EP/tawddJOZDVp2Cofplc62M/O7F1swM+79kpDnbiD3CyWWW
	gxqx92gvUmJqYQFZg5DiZSfh7aA4VLTHBnUqKfr7oa5W1VpNFRV5ptrFfvL/h16lMOuV9t
	i6ofz3xsdXS5bd6FHuExqUKyWWakaA0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-FRbyv0jtPn2r4BP-Tg-goQ-1; Fri,
 21 Mar 2025 07:54:07 -0400
X-MC-Unique: FRbyv0jtPn2r4BP-Tg-goQ-1
X-Mimecast-MFC-AGG-ID: FRbyv0jtPn2r4BP-Tg-goQ_1742558045
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A866F196B356;
	Fri, 21 Mar 2025 11:54:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 884CA1801762;
	Fri, 21 Mar 2025 11:54:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next v2 4/5] udp_tunnel: avoid inconsistent local variables usage
Date: Fri, 21 Mar 2025 12:52:55 +0100
Message-ID: <0d33ffb4f809093d56f3ebdffd599050136f316a.1742557254.git.pabeni@redhat.com>
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

In setup_udp_tunnel_sock() 'sk' and 'sock->sk' are alias. The code
I introduced there uses alternatively both variables, for no good
reasons.

Stick to 'sk' usage, to be consistent with the prior code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/udp_tunnel_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index c49fceea83139..aa9016619c25a 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -90,10 +90,10 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 
 	udp_tunnel_encap_enable(sk);
 
-	udp_tunnel_update_gro_rcv(sock->sk, true);
+	udp_tunnel_update_gro_rcv(sk, true);
 
-	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->sk))
-		udp_tunnel_update_gro_lookup(net, sock->sk, true);
+	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sk))
+		udp_tunnel_update_gro_lookup(net, sk, true);
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
-- 
2.48.1


