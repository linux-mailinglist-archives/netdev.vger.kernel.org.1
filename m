Return-Path: <netdev+bounces-91531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA658B2F8B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 06:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253301F22A1A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0A81207;
	Fri, 26 Apr 2024 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="teKyRFs1"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36A79C8
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106993; cv=none; b=acF6o/uhgyi6sGK/YVY0zYVPvSmnGIgjqa7p3aCHIEwp7w5P3PLAV1HoZHEteZGlvxGaMantYH5gXpRGUGlc5jQj+tKbFd6TTN/NpjckExMuUEYGGujubMcR+aLDNNqcbJALlt2AGap5gC4tawIlIDRalx36QL6lpkKOo+Q5JXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106993; c=relaxed/simple;
	bh=XbSeJ3hdAGmfMKir1pTayOE3EBrp/EGoWzg6EHPJAWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/6Jql7sSLGmVr86ydIravAwBYaqRjib3X7AR2Ln+3gmmlew9NSJ84Ciot3WVXW7epUoBg0h/c1F2N8OFy7O45a0/c8SGaStlJq9dXBQcT5jmaTlvVc25spnNoiLP0FmwOCaFaAz+goWqFgTb3o/4mNTQMbCbvLx1eDVjR+foNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=teKyRFs1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 139512083F;
	Fri, 26 Apr 2024 06:49:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iSE2EosUtysJ; Fri, 26 Apr 2024 06:49:39 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 807972074F;
	Fri, 26 Apr 2024 06:49:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 807972074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714106979;
	bh=vuCEfn74Gkny2j7SNPjhQ+ACi8tJHaE4a+ovuklTPKE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=teKyRFs1Swlk3SalcE3GYhLFaaGuEzXr7v7vEqkgYBjcp6CXy1OBGKVcNQXuviNkk
	 /LRnzwpoMxWXj8vLa/gQZ+LVmYuwPZEEy5jYLsswGCXNQHC1tUJIYhGpXahAika2Qk
	 6JXmbHeILbgxFUHdnnAmLkh6PrmyK+ykTF7b8dmok1A5l8MIr9yRW/uM1yAH/0Vcub
	 9SfoZxnINy24FwrwZSQT58YgSCE3QQ6fRxcOjuH1WJOWt+de/d8KMPKqhXPwk8iHg3
	 wWmrh66ZhqHWgyKPseYTBr4etgkMx2oOU7hY4HUrpwNAj9QzoC1Kf2f2McQs0AnBdS
	 e/aBfOSkCJHHA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 719AC80004A;
	Fri, 26 Apr 2024 06:49:39 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 26 Apr 2024 06:49:39 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 26 Apr
 2024 06:49:38 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 863923182C96; Fri, 26 Apr 2024 06:49:38 +0200 (CEST)
Date: Fri, 26 Apr 2024 06:49:38 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>, Leon Romanovsky <leon@kernel.org>, Eyal Birger
	<eyal.birger@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"Sabrina Dubroca" <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v12 4/4] xfrm: Restrict SA direction attribute
 to specific netlink message types
Message-ID: <ZisyYt6nO9QTf4WC@gauss3.secunet.de>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <718d3da5f5cd56c2444fb350516c7e5e022893c4.1713874887.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <718d3da5f5cd56c2444fb350516c7e5e022893c4.1713874887.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Apr 23, 2024 at 02:51:21PM +0200, Antony Antony wrote:
> Reject the usage of the SA_DIR attribute in xfrm netlink messages when
> it's not applicable. This ensures that SA_DIR is only accepted for
> certain message types (NEWSA, UPDSA, and ALLOCSPI)
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v11 -> 12
>      - fix spd look up. This broke xfrm_policy.sh tests
> ---
>  net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index d34ac467a219..5d8aac0e8a6f 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3200,6 +3200,24 @@ static const struct xfrm_link {
>  	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
>  };
> 
> +static int xfrm_reject_unused(int type, struct nlattr **attrs,
> +			      struct netlink_ext_ack *extack)

Maybe call that function xfrm_reject_unused_attr to make it clear
what is unused here?


