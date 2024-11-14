Return-Path: <netdev+bounces-145099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C99C9626
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0473EB25755
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5D1B395E;
	Thu, 14 Nov 2024 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DG491V3g"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE011B393F;
	Thu, 14 Nov 2024 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627212; cv=none; b=jW2cME94FFKcTnSSuY+FZK57xkruJ4GymEcNRgwc4tj1HaWDad9gMXajY6SNExB+/ux1YiaBx5WAjC5v+UqBTxUqDKL+iy7RAlRK2MSQtIbmE/boBA9DyA2C+YBStzqFOgzYWZX/h/R4IwM7QqX33stz3BriVWj4e9ujOrZdx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627212; c=relaxed/simple;
	bh=0t2lqAe28O+eiT+ButThphxuJ9w0b6ln8trcE7E75Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHYDOBG+maBRnJBKJMxl6BnvCS/GLxG0d+LbnnKIzgv9hz9YbJW2L3j4a35nK2NAklFOJTZ5o7FOOwEf9bKJMpFJYMe6Lt8XsmudYJLyJhQYMn5zL7zWtnriAwOge2G6p+djc0t3//4OnQB964HdWOz5rjGCBVRYVIlmBjbCf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DG491V3g; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKt-0066RS-9p; Fri, 15 Nov 2024 00:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=yEAHZcj9x7QiEAELm24qDgK2tLaXM0KZDTbbkayZg0U=; b=DG491V3gKGqdS0OL7wlCbQxWu7
	AcFBfpnO2phhrXvLHwqwnYrd5cW/99UzFQj9535wQ0cVSEnC2Zgvhe5M9I+uQmmTj6L236CVXwLUs
	3lYsUF5meZeinlsCN6zSoGQ1prgwbqg4L6/tmn0k5dRBr/wr4pUP0F1I1CXEfgN54Lt8+0ray4x5N
	XRH8zIDvJxZp0l/vWfoKRE5CNn+IS811Yu8NFZEkeCaodJgomEHadGTlbfYm6QB4n6R2utIP9Ted1
	IsO3OTd1Bts7z/4tCw4vuB3+p0ADqEkZbC34xUy5aRDO8S109k2N5/5Utr2Ws/zoQgK7Q++u1OZA4
	y3IuzsZA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKs-0005mx-Tx; Fri, 15 Nov 2024 00:33:15 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjKR-008nXm-01; Fri, 15 Nov 2024 00:32:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 00:27:26 +0100
Subject: [PATCH net 3/4] rxrpc: Improve setsockopt() handling of malformed
 user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v1-3-d183c87fcbd5@rbox.co>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
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


