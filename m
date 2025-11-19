Return-Path: <netdev+bounces-240191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 669ABC71501
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3A6C12C0A0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF1314D2F;
	Wed, 19 Nov 2025 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="hvsFicVn"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D52C178E;
	Wed, 19 Nov 2025 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592158; cv=none; b=bqpsdxLUJGLhkPYQQ5aFbLpDzdl2IZMhDisVPuhTONkEGhz9+gRsPe8xDjCcc4biG2ExYW+UxqTQt2sUaFFeOYGjUphkWF7emA8L3EREYv0E/PECSUPCvWBmiQ7reWJC8ECtllnf4fNi9l/tRINSM6Q4Uu17E4fs01Jz87UUDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592158; c=relaxed/simple;
	bh=/88llFjR+aW+sKimOPnEFHk+cZxtJ0WQo1sV7i/jqyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KxP9R3WLtJLmvdaGCJAJV+w4xchyWKWDQYVuF8YFZTi2kw5pp3GRC9bR8hMjQkFI0/b43n/bnk6LpKljC845mU7imEfat1oGpILNTVHrce/oE1E3s+AoAtf8ITMgZelTRDE7BjKUj31Hq4hhanjRj32yKu3EKM2g/HZP5swzVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=hvsFicVn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsk-006ks8-OU; Wed, 19 Nov 2025 23:42:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=yHVSmeGdA9+Qmi1v5uWkOlHaQm/+UGKct/GaarfRyAc=; b=hvsFicVn5RMO7/y5voskYgS44h
	L9lC1HCvmHl3qGjSylT6IZsHmcy9DKwyM18j8Zi+85p6ChAyfSEkpNeEFOxu8qwUiE0Hxm612urJ1
	cQ0JIK6wT/S3x6qeUe4IZ3rSw2nLwh9bdqSs77iSCw9Yav6kYi/2lbZIG4BqDZahOj/3XvTAcFPjU
	OKoh0aE/YxDLhoyOmWoEI+VIeA3ullbFfuWzyRjVnWzxyZb2L2DKb5rBQ74qgn9QUKa0CCx/23KzL
	uJS1QMFE+YXGO6SAP2PQl8HWzwrhfKLE054TEFyBtxKLIi6IbMycYy50R5o1Rh4YTj/hJYylCcJwu
	ilkZArtQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsk-000057-Er; Wed, 19 Nov 2025 23:42:34 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsY-00Fos6-DI; Wed, 19 Nov 2025 23:42:22 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 09/44] ipv6: __ip6_append_data() don't abuse max_t() casts
Date: Wed, 19 Nov 2025 22:41:05 +0000
Message-Id: <20251119224140.8616-10-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The implicit casts done by max_t() should only really be used to
convert positive values to signed or unsigned types.
In the EMSGSIZE error path
	pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
is being used to convert a large unsigned value to a signed negative one.
Rework using a signed temporary variable and max(pmtu, 0), as well as
casting sizeof() to (int) - which is where the unsignedness comes from.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/ipv6/ip6_output.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..6fecf2f2cc9a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1440,7 +1440,7 @@ static int __ip6_append_data(struct sock *sk,
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
 	struct flowi6 *fl6 = &cork_full->fl.u.ip6;
-	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
+	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu;
 	struct ubuf_info *uarg = NULL;
 	int exthdrlen = 0;
 	int dst_exthdrlen = 0;
@@ -1504,9 +1504,10 @@ static int __ip6_append_data(struct sock *sk,
 		maxnonfragsize = mtu;
 
 	if (cork->length + length > maxnonfragsize - headersize) {
+		int pmtu;
 emsgsize:
-		pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
-		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
+		pmtu = mtu - headersize + (int)sizeof(struct ipv6hdr);
+		ipv6_local_error(sk, EMSGSIZE, fl6, max(pmtu, 0));
 		return -EMSGSIZE;
 	}
 
-- 
2.39.5


