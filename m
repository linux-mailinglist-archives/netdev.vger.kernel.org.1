Return-Path: <netdev+bounces-244336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED633CB5127
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C588301D0C6
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1DA2DA76F;
	Thu, 11 Dec 2025 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BDgY/ZJb"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66019F115
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440525; cv=none; b=KVMkX32c7fNo/pHCNP8HyMSMbaBxLv0a75+WqOxkGLZlGLAd4rigBq6lxk3bNNpSpbLDw70RjEFpoGT5d+2T5UcZ0AEujceNjYTLro05sZHzzW5ofhtiin3PbYXGD1dfB4BfyYSO9H0leDWUDbRYVLHGwbX1yeOBrPZiaF2/eLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440525; c=relaxed/simple;
	bh=9YUoGES6Q6gLE7PkVm8xI0vIfok8ZZk4luxfTqwiCNs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4L51KG7KqFOv6rmGfNpUHZgfnHKfthK/qxIlzFp/Pj26u48vkSCNpHtEdoegDyNa8IPSA9YtYYhABjERlpFJmTMEeewxAhQC5dSE2l+2kcgV/ycBBCEefzu/4sKXlBcIzf1IzgWWpaUWQPc1wm6vAjqS8aXPXkr0Aij4wYyr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BDgY/ZJb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BBF6B207C6;
	Thu, 11 Dec 2025 09:08:34 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SC9CocH1pqDe; Thu, 11 Dec 2025 09:08:34 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2AF11201C7;
	Thu, 11 Dec 2025 09:08:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2AF11201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1765440514;
	bh=cXfUpaCSPUyioaCJOiOH9rGd1KvT5n7mgyZ9enK2orc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=BDgY/ZJbDs/8OsmH+SINkKxX7SE7MQJ1YoXcvRb0fXAduonUPEmYGnBC8Pe6tFTar
	 FL45aIDBKT4utjdRQt+Phf7X4fyZo1UzApKU6+dT7li9J2OOAjiQl4u3jtpMtFllGY
	 AbtxZvyaV6ZmBHYhRCfCCoRgkybMRu4WF+axNQiP64khBDzddtwKdn96IAA1oMhGx0
	 0wiD3VfhpMRi7dPvY8wSs8mQ7+YtrDCTQHNcelKs3bZ0jb06BA8GHnoRNEsLHbJ/M/
	 ZcBTEg3pyc6nzRuyX48FzNj1Zo2qxypVPqPaVlPClSqHxn3n380CcP43nQoheMmAmk
	 a2SHIYRbVtEBQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 09:08:33 +0100
Received: (nullmailer pid 2784501 invoked by uid 1000);
	Thu, 11 Dec 2025 08:08:32 -0000
Date: Thu, 11 Dec 2025 09:08:32 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: Re: [PATCH ipsec v2] xfrm: Fix inner mode lookup in tunnel mode GSO
 segmentation
Message-ID: <aTp8AI8qnXlIwFGV@secunet.com>
References: <20251120035856.12337-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120035856.12337-1-jianbol@nvidia.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Nov 20, 2025 at 05:56:09AM +0200, Jianbo Liu wrote:
> Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner
> protocol") attempted to fix GSO segmentation by reading the inner
> protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was incorrect
> because the field holds the inner L4 protocol (TCP/UDP) instead of the
> required tunnel protocol. Also, the memory location (shared by
> XFRM_SKB_CB(skb) which could be overwritten by xfrm_replay_overflow())
> is prone to corruption. This combination caused the kernel to select
> the wrong inner mode and get the wrong address family.
> 
> The correct value is in xfrm_offload(skb)->proto, which is set from
> the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
> is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
> or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
> inner packet's address family.
> 
> Fixes: 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner protocol")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>

Applied, thanks a lot Jianbo!

