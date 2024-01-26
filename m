Return-Path: <netdev+bounces-66134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A9B83D75A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BA029AFD5
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D965BBE;
	Fri, 26 Jan 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ufE9pHk7"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBF224D5
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260277; cv=none; b=Z5W1Dvf4arfaApTHHfCI5SftjP3CVI11cr75BB5dIn1iuvfCbGalmMMebL4jZvkVWsbYf4ODovj4TyVcvLrX2Zv+0FEeLKSH/HgxgXAKeRhmLFSsrDhN5PF6u52lkfs8PZ10vv+FDfQZswTcA77T79oAh4kGAa9/Zl/TdoAClZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260277; c=relaxed/simple;
	bh=6DpCG89qD1AciY2+GlkJzCkS/2MWkU0XkJ9Cu3X1mEg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMoBTuvnYmBTA9NB0L4dxMdBmwPR/2Vz9Xz6I81CiYSDg3R7DUJ3ZHDUPS0kR0Twq8m+bTz6NhzOAitY2+hR46YLr1eHM2ro2ZEmXqWIfubanxRylWGopLHQp+9mLc+48irgr+dvRnkyTmNUakFrDgMn/qFwI6uzjJ+9o+YMI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ufE9pHk7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 474BF207E4;
	Fri, 26 Jan 2024 10:11:06 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKD1h0JNjQ6i; Fri, 26 Jan 2024 10:11:05 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9C9B8207BB;
	Fri, 26 Jan 2024 10:11:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9C9B8207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1706260265;
	bh=zQCB5LTO4rPGkRZOxtCS+hE6fRlQaNQZpuuYVhN5l28=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ufE9pHk7qJ5Lrp0wZcsZzLKmcID3N1fYNPBM0WfWfDLuSaFOITLRn5MYV1vngn56y
	 3bkmYkU7ge+PqcZYD582UZX0kavdw9di1SszJA1uzwEaD8M0K2GRQGnaIvajCzqmZG
	 knac9Z3BDdq0ZZdLNLpeBih7Eyhm/gopf+CteE0AtlxbQs0s1dMJEDwgsyjnD96tWN
	 MqTXXc+WpV5icCUMZhnKxeDZjXznhimBXkRN27vRdKmflxWQ7ukshzvCOuasfQK6c4
	 2wr5eHMtl76K5SfmbP1Ph39dPktGqwOsDHm/Z5DrPiAzL06TNyLWFN1NbFn92TC9v1
	 fiGmY372/ud+Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 97D3380004A;
	Fri, 26 Jan 2024 10:11:05 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:11:05 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 10:11:04 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id AF9DB3180842; Fri, 26 Jan 2024 10:11:04 +0100 (CET)
Date: Fri, 26 Jan 2024 10:11:04 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <devel@linux-ipsec.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 ipsec-next] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <ZbN3KK0vcy37A5y1@gauss3.secunet.de>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <1199c5a30dd3f73ac02b0ac00775354304b1e692.1705663529.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1199c5a30dd3f73ac02b0ac00775354304b1e692.1705663529.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Jan 19, 2024 at 12:27:42PM +0100, Antony Antony wrote:
> This commit aligns with RFC 4301, Section 6, and addresses the
> requirement to forward unauthenticated ICMP error messages that do not
> match any xfrm policies. It utilizes the ICMP payload as an skb and
> performs a reverse lookup. If a policy match is found, forward
> the packet.
> 
> The ICMP payload typically contains a partial IP packet that is likely
> responsible for the error message.
> 
> The following error types will be forwarded:
> - IPv4 ICMP error types: ICMP_DEST_UNREACH & ICMP_TIME_EXCEEDED
> - IPv6 ICMPv6 error types: ICMPV6_DEST_UNREACH, ICMPV6_PKT_TOOBIG,
> 			   ICMPV6_TIME_EXCEED
> 
> To implement this feature, a reverse lookup has been added to the xfrm
> forward path, making use of the ICMP payload as the skb.
> 
> To enable this functionality from user space, the XFRM_POLICY_ICMP flag
> should be added to the outgoing and forward policies, and the
> XFRM_STATE_ICMP flag should be set on incoming states.
> 
> e.g.
> ip xfrm policy add flag icmp tmpl
> 
> ip xfrm policy
> src 192.0.2.0/24 dst 192.0.1.0/25
> 	dir out priority 2084302 ptype main flag icmp
> 
> ip xfrm state add ...flag icmp
> 
> ip xfrm state
> root@west:~#ip x s
> src 192.1.2.23 dst 192.1.2.45
> 	proto esp spi 0xa7b76872 reqid 16389 mode tunnel
> 	replay-window 32 flag icmp af-unspec
> 
> Changes since v5:
> - fix return values bool->int, feedback from Steffen
> 
> Changes since v4:
> - split the series to only ICMP erorr forwarding
> 
> Changes since v3: no code chage
>  - add missing white spaces detected by checkpatch.pl
> 
> Changes since v2: reviewed by Steffen Klassert
>  - user consume_skb instead of kfree_skb for the inner skb
>  - fixed newskb leaks in error paths
>  - free the newskb once inner flow is decoded with change due to
>    commit 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
>  - if xfrm_decode_session_reverse() on inner payload fails ignore.
>    do not increment error counter
> 
> Changes since v1:
> - Move IPv6 variable declaration inside IS_ENABLED(CONFIG_IPV6)
> 
> Changes since RFC:
> - Fix calculation of ICMPv6 header length
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Patch applied, thanks a lot Antony!

