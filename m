Return-Path: <netdev+bounces-142411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213BB9BEF6A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F6B239BB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D31DE2B2;
	Wed,  6 Nov 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SQcKbXmB"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BC537FF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900878; cv=none; b=AmfzCZNUYeP+mNW4PnVa4ChoqsmRIPatLRQAFThonhL/n3dYe4RbS0GzvYkSwL9VoQNoelc/B1f/cLKowNsLhvJDcgmDosSl+8ON6RH+eiferZx0ywBU3n9VhWTgJcHj9s9zgVZxVHBBP/+pDIVGoWniFIdY6V1UKgHGDPmmQfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900878; c=relaxed/simple;
	bh=Ggdj3BuI/wbLqNWlQYpvbMkVibNxUZh7cfTH8MV2F0w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxKW+yAU1eKZWyMA+wsh5xRfBf5MuksuZ65215TDmfR5b3XxdejFulJwv2wp3AWoxKSvEXfEqIcLIg7pc/i2GG8pWYlXAA75F9urRt/lJ/qEtXTu2dzROQVK6n2yk3tm0qJjbhb6DTb0YpUOf2/o9kKjrOeGdS+gTfeUO0Kn3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SQcKbXmB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 51BFE207C6;
	Wed,  6 Nov 2024 14:41:19 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnJ2KJ2eYDXI; Wed,  6 Nov 2024 14:41:18 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7F14A208A2;
	Wed,  6 Nov 2024 14:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7F14A208A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1730900478;
	bh=hm6BczDzPS7AnYZcRBqZEVMVG504oeIY6Dl8hSNXXNo=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=SQcKbXmBGuWrJ2je5TFrSy/WDUR6m16coQRN3mCcRXYmnBBoQubstsnH5ZZIc/tzJ
	 bR7upwgcn8c4N5vHBOJzd/4b/rDcEztdjQCrzF++hy1mCVLQGvvUOsQwlwTLx1X0ch
	 i51bBRTVD0fi9P0Iyz4Js/B5KPDG9vkHZCeOYWQH1YmOrIhd0gvtXHd4wk4KkKGMgl
	 owOVsZ06B1jR+VMHjM/WLqcTn0sH9sJSOk9p+88W6ofCo1te8dASHaZUk2I2VLuVv2
	 eUfZHI3L6BSiTLAONKV7vbs7YimhBK6YzDa54CB5hF1ZhhWKPoR2bLWQfQ+/p2Bepx
	 QqXe7UjEBgu2Q==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 14:41:18 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 14:41:16 +0100
Date: Wed, 6 Nov 2024 14:41:11 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Feng Wang <wangfe@google.com>, <netdev@vger.kernel.org>,
	<steffen.klassert@secunet.com>, <antony.antony@secunet.com>
Subject: Re: [PATCH 1/2] xfrm: add SA information to the offloaded packet
Message-ID: <Zytx9xmqgHQ7eMPa@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20241104233251.3387719-1-wangfe@google.com>
 <20241105073248.GC311159@unreal>
 <CADsK2K9seSq=OYXsgrqUGHKp+YJy5cDR1vqDCVBmF3-AV3obcg@mail.gmail.com>
 <20241106121724.GB5006@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241106121724.GB5006@unreal>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10


> On Tue, Nov 05, 2024 at 03:41:15PM -0800, Feng Wang wrote:
> > Hi Leon,
> > I checked the current tree and there are no drivers who support packet
> > offload. Even for the mlx5 driver, it only supports crypto offload
> > mode. 
> 
> I don't know what to add here. We already had this discussion for more
> than once.
> https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> Let's me cite Steffen:
> 
> "There are 'packet offload drivers' in the kernel, that's why we
> support this kind of offload."
> 
> > If I miss anything, please let me know.
> > Since the driver only requires the Security Association (SA) to
> > perform the necessary transformations,  policy information is not
> > needed. Storing policy information, matching the policy and checking
> > the if_id within the driver wouldn't provide much benefit. 
> 
> You need to make sure that policy and SA has match in their selectors,
> and IMHO you can't add support to SA without adding same support to
> policy.

when a packet enters an XFRMi,  xfrm_lookup_with_ifid() is called? 
What does that call return, incase of packet offload? 

My guess is that call is returning NULL and that is why Feng is trying hard code
state here? 

I imagine the policy may not match because that policy has
offload packet?  May be this look up need to handle packet offload?

> 
> > It would increase CPU and memory usage without a clear advantage.
> > For all other suggestions, I totally agree with you.
> > 
> > Thanks,
> > Feng

