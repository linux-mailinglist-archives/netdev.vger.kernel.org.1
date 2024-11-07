Return-Path: <netdev+bounces-142687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5AC9C0073
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740A62832B8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9151D89F0;
	Thu,  7 Nov 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Bf1v+lZL"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F519F120
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969538; cv=none; b=Yxmv+pQQkwbr5vbPDLd/eEBJPdfDZBcl3kxFbm/O3PcHxMYzL5nByeqZUVxkdPKRarWv2RBj83m+lmBosNIdYLk1Q3qtUTGyJfJvm9WH/wyLWn4w2rUqrVDxxvq4mHPJMAoDKZExuj4miQ16PkFmqq+LH5B4dIv8a0Km17TGfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969538; c=relaxed/simple;
	bh=z2m0yQ39mxp1iW3yOY/1ew3erLQ66Xjaw5p+CVA3sss=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wiktsm/6MsOzoCK5Lhaq2KFM1Sj6kSTK++7tgmOIZxawsOEoy9a0Tyz+8nb5dZFPO6cNdkOcofIy7BIE3tmxPvLazUqPvjF/XNug/lGVX4PmXlcTQ4MgHvLpVLIIsrr0nJVNK93/MqkQsJ8Hm9qXJwvrOvOui3gqMAm8vsogZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Bf1v+lZL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8A81120891;
	Thu,  7 Nov 2024 09:52:12 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JF58LXooQ9Uz; Thu,  7 Nov 2024 09:52:12 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EB760206F0;
	Thu,  7 Nov 2024 09:52:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EB760206F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1730969532;
	bh=Wu9nU1SDFbMwMTiC1SQ1jA2OGdg1x14odyOnJ5eb6Po=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=Bf1v+lZLr5SlMCMZw/31QbXWT7nOhVuSggV1jLLfPJ6olm5zYMOOem3IgNfY3dmOj
	 D8AaA+jq0bsEogJImUN3j0BKw1vDkAbvPn9tHO91WShn8FgrmmgyeRCzQqUkrtP4FQ
	 lljss+bTOXH+ar1eWhIryu8uBH+Ma1lF6QD/bJ3Opdowgw2DhPQN1Bq2PiHa8FMuNg
	 +Zk3tDQR0USsE7T6F85RLzvF1D3+cckzuS61pUzk2MUNlOtT21gUyREJjOVnO3xWD3
	 JVZrvUBQ4qaHJgwovMsBPHBlygLZLhrrpbxHfOGCitRzDrK9Lv9xV/pcckYUghqeYQ
	 kK5kwuHADsZYA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 09:52:11 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 09:52:11 +0100
Date: Thu, 7 Nov 2024 09:52:09 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: <antony.antony@secunet.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <steffen.klassert@secunet.com>
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
Message-ID: <Zyx/ueeoeBdq/FXj@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20241104233251.3387719-1-wangfe@google.com>
 <20241105073248.GC311159@unreal>
 <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
 <20241106121724.GB5006@unreal>
 <Zytx9xmqgHQ7eMPa@moon.secunet.de>
 <CADsK2K9mgZ=GSQQaNq_nBWCvGP41GQfwu2F0xUw48KWcCEaPEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADsK2K9mgZ=GSQQaNq_nBWCvGP41GQfwu2F0xUw48KWcCEaPEQ@mail.gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Nov 06, 2024 at 16:14:36 -0800, Feng Wang wrote:
> Antony brought out an important function xfrm_lookup_with_ifid(), this
> function returns the next dst_entry.
> 
> The xfrm_lookup_with_ifid() function utilizes xfrm_sk_policy_lookup()

would the output packet, looked up using xfrm_lookup_with_ifid ,
match xfrm policy with "offload packet" set?
When lookup is in the xfrm device.

ip xfrm policy .... offload packet dev <if-name>


> to find a matching policy based on the given if_id. The if_id checking
> is handled in it.
> Once the policy is found, xfrm_resolve_and_create_bundle() determines
> the correct Security Association (SA) and associates it with the
> destination entry (dst->xfrm).

If the output packet got this far, dst is set in skb?
And when the packet reach the driver dst = skb_dst(skb);
dst->xfrm is the state?
If this is the case  why add state to skb as your patch proose?
May be I am missing something in the packet path.

> This SA information is then passed directly to the driver. Since the
> kernel has already performed the necessary if_id checks for policy,
> there's no need for the driver to duplicate this effort.

Is this how packet offload would work? My guess was in packet offload
policy look happens in the driver. 

