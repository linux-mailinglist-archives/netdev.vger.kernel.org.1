Return-Path: <netdev+bounces-300974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4SwhCgXrOGo/kAcAu9opvQ
	(envelope-from <netdev+bounces-300974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:57:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5656AD736
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=l7F0DdC6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300974-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C283006780
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17B38330A;
	Mon, 22 Jun 2026 07:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AD382385
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115064; cv=none; b=GMqm6pkZgdAA7lyJTtxhG8JuUmGWu0KKYhPAHGhRUdXE3uKEQRohff1CSMIQnmmg2PZjoRPt+jOEwy+GKV0+egZ/PNqwsYu5YGLxr8jQuWtUjX3QbbSx6vzJ9S4DDta8Ia6rV4QtP0wijqWOlEcLILXxMaQrXDhYVebFGWRBqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115064; c=relaxed/simple;
	bh=pDB8bRwa5c4hqHlB017KJXhmL/hh95hYL6PCKvrK8VE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtlJNcBcqHOt1MfRkrIOSydzD4TDAAjRiAWzztKhqrWpgKmAZLZtAaxt7enUxyAT5D2jUeMrn/koYCaYIfNrp6vrIEo83ODoXJWRKAxPHZvjtH/LKIEyNNXCjSQz548WtlnqjTJR4kBwo2hi0Z/E6E1nWd1p/JlA/oQtn80JmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=l7F0DdC6; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8EE4A2065A;
	Mon, 22 Jun 2026 09:57:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzR0Q-p25X0r; Mon, 22 Jun 2026 09:57:35 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E9E1F20684;
	Mon, 22 Jun 2026 09:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E9E1F20684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115054;
	bh=vOKrZJvVs8tI7WOCswnMiLK32BhFmQ5+gORKL72L4So=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=l7F0DdC6onaXykS6iIQJJjNqslr8j4HvmAU50eYEEacL6L+wc3nAnCr5b+4V9o/T9
	 jljQdI0R+WMCkJdCnju3woPNFhdaxpvUrkBNzmJHraBOzThcv/z2NxHI0RjOr3UeSZ
	 KyHRDD7uoR4br937Qjb0lD8LJ/JMN16MO6CkIhpHp6T3vFd6HBM0BnPJQKintdHCMn
	 ssMUD5UxFjxdEitA8w9jyuo0LbiSB6WhfP0iQBZpzMS/AxcujzkECP1NEJr5AXi2Vq
	 pgZVD55VZnxB0VnaAPw0llJewluSP2QTVrSOGqkqleUzVUAAHaBN1W1eD+3oyLm3KQ
	 +JXZLyuRQ9R2Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:34 +0200
Received: (nullmailer pid 30070 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/7] espintcp: use sk_msg_free_partial to fix partial send
Date: Mon, 22 Jun 2026 09:57:08 +0200
Message-ID: <20260622075726.29685-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622075726.29685-1-steffen.klassert@secunet.com>
References: <20260622075726.29685-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C5656AD736

From: Sabrina Dubroca <sd@queasysnail.net>

sk_msg_free_partial() ensures consistency of the skmsg at every
iteration, without having to manually handle uncharges and offsets.
This simplifies the code, and fixes some bugs in skmsg accounting when
we don't send the full contents.

Cc: stable@vger.kernel.org
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: Aaron Esau <aaron1esau@gmail.com>
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/espintcp.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index d9035546375e..374e1b964438 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -212,43 +212,23 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 	struct sk_msg *skmsg = &emsg->skmsg;
 	bool more = flags & MSG_MORE;
 	struct scatterlist *sg;
-	int done = 0;
 	int ret;
 
-	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
 		struct bio_vec bvec;
-		size_t size = sg->length - emsg->offset;
-		int offset = sg->offset + emsg->offset;
-		struct page *p;
-
-		emsg->offset = 0;
 
+		sg = &skmsg->sg.data[skmsg->sg.start];
 		if (sg_is_last(sg) && !more)
 			msghdr.msg_flags &= ~MSG_MORE;
 
-		p = sg_page(sg);
-retry:
-		bvec_set_page(&bvec, p, size, offset);
-		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
-		ret = tcp_sendmsg_locked(sk, &msghdr, size);
-		if (ret < 0) {
-			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+		bvec_set_page(&bvec, sg_page(sg), sg->length, sg->offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, sg->length);
+		ret = tcp_sendmsg_locked(sk, &msghdr, sg->length);
+		if (ret < 0)
 			return ret;
-		}
-
-		if (ret != size) {
-			offset += ret;
-			size -= ret;
-			goto retry;
-		}
 
-		done++;
-		put_page(p);
-		sk_mem_uncharge(sk, sg->length);
-		sg = sg_next(sg);
-	} while (sg);
+		sk_msg_free_partial(sk, skmsg, ret);
+	} while (skmsg->sg.size);
 
 	memset(emsg, 0, sizeof(*emsg));
 
-- 
2.43.0


