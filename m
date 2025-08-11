Return-Path: <netdev+bounces-212422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F375B20326
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED09418844D0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8AF2DEA8D;
	Mon, 11 Aug 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LMlj0QvI"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867F2DCBFD
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904032; cv=none; b=QUl6kJ7qj+Tc5j4g9gSSBUsS6vyqfbGRsvy20j19matecUHR4oszmB54mMLfzYlCGyY0I+sJ9q60Rd2LKvB+aZW+8PZEAc2PCNG1uwezGQt2kYtWXOowM1tefJT1v4YlxKQhalTonQNOYBE74o2SQiX33ExRO0LLmSm2S+a2cdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904032; c=relaxed/simple;
	bh=HKc9GR8P7O64SJe8/WARXl7XtReZ1qywyIh00EFH44M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTGqZYjunuvqs0KUYhBCkalnSZOiDw/BZRUYudSe0pO75W2JwR6Jdr0pGqVELiGyq5Ue1DulImfjtfIc9qUp3fIXPJt8DGIuSLsZ5SzWJmwHtWsoP2PvIFz0RVmBCsoqdhV2uDm+Y+HC1t7ffx+9JcXVPdmWISBs2lBgsyYBX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LMlj0QvI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BD2A020799;
	Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUKZATOzM2at; Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E7DCC207AC;
	Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E7DCC207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754904020;
	bh=e/Uylk2mGIbTdxxUHUeB+U1sqem4pp4wRsOSUlXAYek=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LMlj0QvI16z8G9ITvLtiThPzxa5OdfxKMTnyhfbkIBLFUOyxI2FJCcuhEBmpJtif4
	 zlgfozmJfTSGJHrXEwzrYeC/lMrOMc9MbLQEQCxmKrLwWVQot3s2dF2axJFZ8Dk9tf
	 elIwyJcdGuZSFVyyzUr/iTNvzA8PoEPsGrHDPhHXVy+K9+CIRg6IiDLX56XL9ORmDw
	 v4OB33mnEw/8LRL2eAr+JevyxSz2+pPNb+fPaHVsHPGBDTi2A4ThxZhqQ7N5XeBNfp
	 zFfmbsYdRgh7auvwOWMXSr/QMYXcHOVnoLRQjNfssIJ7bBapz0hKUmDPHgvT0qnuGU
	 /hz4baVLokrDQ==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 11 Aug
 2025 11:20:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 15BF3318406D; Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/4] udp: also consider secpath when evaluating ipsec use for checksumming
Date: Mon, 11 Aug 2025 11:19:32 +0200
Message-ID: <20250811092008.731573-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811092008.731573-1-steffen.klassert@secunet.com>
References: <20250811092008.731573-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

Commit b40c5f4fde22 ("udp: disable inner UDP checksum offloads in
IPsec case") tried to fix checksumming in UFO when the packets are
going through IPsec, so that we can't rely on offloads because the UDP
header and payload will be encrypted.

But when doing a TCP test over VXLAN going through IPsec transport
mode with GSO enabled (esp4_offload module loaded), I'm seeing broken
UDP checksums on the encap after successful decryption.

The skbs get to udp4_ufo_fragment/__skb_udp_tunnel_segment via
__dev_queue_xmit -> validate_xmit_skb -> skb_gso_segment and at this
point we've already dropped the dst (unless the device sets
IFF_XMIT_DST_RELEASE, which is not common), so need_ipsec is false and
we proceed with checksum offload.

Make need_ipsec also check the secpath, which is not dropped on this
callpath.

Fixes: b40c5f4fde22 ("udp: disable inner UDP checksum offloads in IPsec case")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 5128e2a5b00a..b1f3fd302e9d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -217,7 +217,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	remcsum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TUNNEL_REMCSUM);
 	skb->remcsum_offload = remcsum;
 
-	need_ipsec = skb_dst(skb) && dst_xfrm(skb_dst(skb));
+	need_ipsec = (skb_dst(skb) && dst_xfrm(skb_dst(skb))) || skb_sec_path(skb);
 	/* Try to offload checksum if possible */
 	offload_csum = !!(need_csum &&
 			  !need_ipsec &&
-- 
2.43.0


