Return-Path: <netdev+bounces-102470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06159032AD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C7B1C25412
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AC17164D;
	Tue, 11 Jun 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TUWVfUrF"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70429171664
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087548; cv=none; b=Y4yo2fXU1YSRuDqclGYgLoiTWArDAkZ9Vf7MNCF4NPa4Vu39eaFGMuRoSD32VNae+iGhLCajVHDemJcWIMlPMaRmH1//ZAHYR4p52rIyT6CEbbIKl0kcY1o70c+sIljOpDBkUSmABRIdu6euk67CT1ztEBv56wk0gQ1HblohpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087548; c=relaxed/simple;
	bh=eR6z75LRE5wLhPIBO9KiGUfyFRPEC+bl+BpPHUEkSGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSyNPB19EsyuyJvQxyM5bGRU0FZq+u41XnoYIV6NnRqkYA1g1PHCQSOkhs5n+BFp9/pDvwtrG/MCFs+Wnr3QfvEOKBnAMkIHFElStR0uB5XwL65dvs0+UIT3w4aUXr0V0XU7Tps6HO6yGQvAEthuokU7nc03PsY13V/SNRxAJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TUWVfUrF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 671432074F;
	Tue, 11 Jun 2024 08:32:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eStO_n5YYLpp; Tue, 11 Jun 2024 08:32:22 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CA1DF206F0;
	Tue, 11 Jun 2024 08:32:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CA1DF206F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1718087542;
	bh=RZAnyRuXN0aq5mS5rGLV6RGfSNv08D4yQBwbJSWLfNk=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=TUWVfUrFDbPyN/WwvYekYut9k+JAQ0jkfyL60HCQtbdrg8Gm1BtUeSJ0XSPTGgllh
	 umnHgWLy3JfwAcEiQgBJBzFprNYqvpjLUGOI8rY4TKxsGHYZ7wruDZbVswLIKGIkaj
	 GL/LcfqDAfyEoAoP49u4N03tNA4Yutt1oiZGw/feqYDmlcBJvD6ydhKwpCz2GUXs19
	 2tzNAE24o588xJZQEokWF8ePu+pqmREjKhtv4hptLlLE0/J1FFCmc0ZO8g105ocVJV
	 kYgmljBWmvmqq7dA8hek3Z+rYBpqboHSs0Bl79JaMorHIn51oGw8OAiamY4SE+QkAO
	 aY1ROkvMO65oQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id BDB7980004A;
	Tue, 11 Jun 2024 08:32:22 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 08:32:22 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 08:32:21 +0200
Date: Tue, 11 Jun 2024 08:32:15 +0200
From: Antony Antony <antony.antony@secunet.com>
To: <netdev@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Antony Antony <antony.antony@secunet.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
Subject: [PATCH ipsec 2/2] xfrm: Log input direction mismatch error in one
 place
Message-ID: <50e4e7fd0b978aaa4721f022a3d5737c377c8375.1718087437.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Previously, the offload data path decrypted the packet before checking
the direction, leading to error logging and packet dropping. However,
dropped packets wouldn't be visible in tcpdump or audit log.

With this fix, the offload path, upon noticing SA direction mismatch,
will pass the packet to the stack without decrypting it. The L3 layer
will then log the error, audit, and drop ESP without decrypting or
decapsulating it.

This also ensures that the slow path records the error and audit log,
making dropped packets visible in tcpdump.

Fixes: 304b44f0d5a4 ("xfrm: Add dir validation to "in" data path lookup")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/ipv4/esp4_offload.c | 7 +++++++
 net/ipv6/esp6_offload.c | 7 +++++++
 net/xfrm/xfrm_input.c   | 5 -----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index b3271957ad9a..3f28ecbdcaef 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -56,6 +56,13 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET);
+
+		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			/* non-offload path will record the error and audit log */
+			xfrm_state_put(x);
+			x = NULL;
+		}
+
 		if (!x)
 			goto out_reset;
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 527b7caddbc6..919ebfabbe4e 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -83,6 +83,13 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET6);
+
+		if (unlikely(x && x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			/* non-offload path will record the error and audit log */
+			xfrm_state_put(x);
+			x = NULL;
+		}
+
 		if (!x)
 			goto out_reset;
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 63c004103912..e95462b982b0 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -474,11 +474,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
 		x = xfrm_input_state(skb);
 
-		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
-			goto drop;
-		}
-
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMACQUIREERROR);
-- 
2.30.2


