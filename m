Return-Path: <netdev+bounces-145260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CEC9CDFCE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD39B251A3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569F1C1F2A;
	Fri, 15 Nov 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fPgH5r2J"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3811C07F7;
	Fri, 15 Nov 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676997; cv=none; b=awnjzxPaSBgdiC9cPhvmgG9BhWwx8KoCmnYEMd7A92DsOLVrNE7U9orBLpE63xpzyd2Wxpk10XXORZpSH1zmXd1XJi9oTwgOmHEqd+mdTaIUnx+oDfxeIo2rWhYzFV3CBEWKDGiFsR0eaq/vCKHUJdw1vLULzLiCur92Tbvwz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676997; c=relaxed/simple;
	bh=0t2lqAe28O+eiT+ButThphxuJ9w0b6ln8trcE7E75Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxiZH1RNmN74xNU4UeR+ebWRv0a/AydLfPMDha6d1yxuVA3ae1pwal2LCmFxmi2Xb4xDBL6dY8pay1TMQPDIUNApuxf5TeKjnWrz2u/tFVZjZ2exajzQNiTw85GdE+n0DP/1rBC0Cqku6keZpDNwUcfHBCItsjI61MUugrDZwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fPgH5r2J; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHu-007sXj-7c; Fri, 15 Nov 2024 14:23:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=yEAHZcj9x7QiEAELm24qDgK2tLaXM0KZDTbbkayZg0U=; b=fPgH5r2Jx89R8BBQH05g5o66kF
	7fhoIGGhPBCNZGE8wCuHCCsU5BxVStujTUy2cN4kMpQqRmMs0lA2rrqfQoOwUcLDVdULzkMk4nEAE
	/6ctcX0T04Q8U4FeKTielmeHCMHbBIRp/aFSrmWrZtnppitEMkhjbD7TZ6kmfMCRo+LOu1TK3rWAR
	r5gQQu0VroDcXk66Bq83E1Jmrp04ELdbXLqZMMylrL64YRy7GsGfZ1ht+lI90F7HL7V0mOMqVjc80
	sWpmcZAcU4BAfJFBglWfq5Sc+wt3PVX14/4oLeRb9X6S1pqzkOTqn4t1aWvzezWCX5XGkMYdNZQRd
	ofkrGrFQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHs-0001oE-Lt; Fri, 15 Nov 2024 14:23:00 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBwHj-00BIK5-JE; Fri, 15 Nov 2024 14:22:51 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 14:21:42 +0100
Subject: [PATCH net v2 3/4] rxrpc: Improve setsockopt() handling of
 malformed user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v2-3-9b1254c18b7a@rbox.co>
References: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

copy_from_sockptr() doesn't return negative value on error. Instead it's
the number of bytes that could not be copied. Turn that into EFAULT.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/rxrpc/af_rxrpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index f4844683e12039d636253cb06f622468593487eb..dcf64dc148cceb547ffdb1cea8ff53a0633f5c06 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -702,14 +702,14 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 
 		case RXRPC_MIN_SECURITY_LEVEL:
 			ret = -EINVAL;
-			if (optlen != sizeof(unsigned int))
+			if (optlen != sizeof(min_sec_level))
 				goto error;
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)
 				goto error;
-			ret = copy_from_sockptr(&min_sec_level, optval,
-				       sizeof(unsigned int));
-			if (ret < 0)
+			ret = -EFAULT;
+			if (copy_from_sockptr(&min_sec_level, optval,
+					      sizeof(min_sec_level)))
 				goto error;
 			ret = -EINVAL;
 			if (min_sec_level > RXRPC_SECURITY_MAX)

-- 
2.46.2


