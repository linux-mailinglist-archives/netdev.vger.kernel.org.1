Return-Path: <netdev+bounces-126524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28843971AB4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD041C22479
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8E1B86DB;
	Mon,  9 Sep 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="naziB8M7"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE31B86DD
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887994; cv=none; b=NPw/Fn9veYrlmwN+3g74gMSx6kobwlgCS57uOPok21sngKyO83xwBNVkDUI7ch6x/kGKgbP5zspzTU9g+swRMP5cZ481J+v0pZYg4aVc2RfowQBEh7uiVAFZ/nTtwWxo6pcVyW9tU/Dx4S66tFSFfN5YGDrpdcbWB54AOL9ZYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887994; c=relaxed/simple;
	bh=ZZN3+8MAx1lGmOGj2FoWKzy+1zPEf2Z/i8qwko9JIdY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na6fNBiDtgSOsBzl4pjDQ3VN2hqq0e4DcbQEZl7opzYZk2h9yfYPH+omT1eDlGW2NarjVccazA9IV9lVNIOdfqEyUHMbu2Ymu9X5wcbNzI3IOCD25/4IUrHzbPOHwmfbqEhuTO+nfiVJ+jIXpQPk2o29Kr/hALRBX0yBy7UM5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=naziB8M7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 35F1F20754;
	Mon,  9 Sep 2024 15:19:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CYJSJ-XUqa1a; Mon,  9 Sep 2024 15:19:49 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6CE662067F;
	Mon,  9 Sep 2024 15:19:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6CE662067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725887989;
	bh=tKTjoG9/+RAMBHafTIrSU6FuQjl3MSmJpDEFESh2Mso=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=naziB8M7XeLJHIKmAc5Eq6jrnXgyHQPu+w3zKt7yfPlsQreiEl2j7KZ/RLx2idmta
	 aa35LALRaXndc71WJRnsQ21L16QydnKsLcqCikc6tYxuR+HhatN3uu8Z16AXsQwgMT
	 BIsuWMCbd6Eln+smESa/uYCX38eGSTHDl3NL/ZdhxhpAR7FlTUNrmzVie7UP3p7NkW
	 uYmbfdRxc0Qw5WboQn9fybPEuaOwbfNSCtztmNMflcmvVfQdwtemnUFiwYgbsXVVqG
	 cgTkoIs0YYPwW/oUMHGhRdZUt4AkLyNNvbRRgmenNXircwOfFAfxDq0jes2Hsk6TdI
	 HjhW77S1WjBnQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 15:19:49 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:19:49 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1F3EF31842DE; Mon,  9 Sep 2024 15:19:46 +0200 (CEST)
Date: Mon, 9 Sep 2024 15:19:46 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 09/11] xfrm: policy: use recently added helper in more
 places
Message-ID: <Zt718gLRZfBKAiaE@gauss3.secunet.de>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
 <20240909100328.1838963-10-steffen.klassert@secunet.com>
 <20240909105954.GA19195@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909105954.GA19195@breakpoint.cc>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 09, 2024 at 12:59:54PM +0200, Florian Westphal wrote:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > From: Florian Westphal <fw@strlen.de>
> > 
> > No logical change intended.
> 
> This patch is bogus and needs to be dropped/reverted or following
> patch:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240829-xfrm-restore-dir-assign-xfrm_hash_rebuild-v2-1-1cf8958f6e8e@kernel.org/

I'll take both patches and resend the pull request.

Thanks for the heads up!

