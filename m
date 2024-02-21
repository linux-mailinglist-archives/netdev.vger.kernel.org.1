Return-Path: <netdev+bounces-73846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A07B85ED68
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 00:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68E91F21699
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291012D765;
	Wed, 21 Feb 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ImwxpPA5"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487333062
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559425; cv=none; b=NxDEiD6yrko3blH6peu4TtfAzasktA5JcJsVmEKHSb38WxvSJis3L1D46KHD6NZtm4tS3taS5QbCQyHpcwcaCnJLH8pVcwsmf337SqSAqBI78M7PpheBwGaeKkuvqa7/+qVKEJREpBUtPTgPbkfn34306XEwVYZy/VxFGSpaaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559425; c=relaxed/simple;
	bh=GhBPuCw5qrqcglNtr0ExmKn9i7WbFG7QvnOWWLkVxkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QR2AlfjIRVxopHc8QAmjT+BPK/14j97HOvwujAz3XeUMjiJpIpnvseYa0OidpwPmPIFwhfgUVpXktGyAdpGdJOMAIppRU7UtHOuQk0zFeSHrlVCfmUF3ujarnGQMfTe9VaLZqBvYCgnajpm8AGqhr+XNV2FSLZFnUtN4UeHB3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ImwxpPA5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E544520075;
	Thu, 22 Feb 2024 07:50:15 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708559416;
	bh=GhBPuCw5qrqcglNtr0ExmKn9i7WbFG7QvnOWWLkVxkU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ImwxpPA5LvZmoY2oyUTGbdZ3Apa7FmOXSYhw6XIHxwfSDEusAKkelE9hS/Ui6f64i
	 k7xY17hvC5bDza/D4AIVRRJn7i4/cFBfqLAMkehPyORpE6Cvq2GvVTNDfefl9+3HgN
	 9ypP5auqS9FQDJlyEDPA4e8/u0QdN0cGiZqEM1A64IwsA49E9qiFSgln6uD2Wv1Tc8
	 JCY5XirZdBN6/KprWlnKoC2yOXzOj59Er0VVQn+T8VxLB5KogrFIRNxfgDvoUd05Cr
	 Q3lr7ucyTer6CpDPgSHJBfG//yw9emqGn4E+jE9xPbJb//qe1euaofY+jZbZBnaszp
	 0bMaSqqu4kdag==
Message-ID: <53c8a1bcb404045bdf8eb471349e06b52ed13c13.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: put sock on tag allocation failure
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Date: Thu, 22 Feb 2024 07:50:15 +0800
In-Reply-To: <20240221143300.0ddec4a4@kernel.org>
References: 
	<ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
	 <20240221143300.0ddec4a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> This patch is good to be applied, right?

Yep, all good on my side!

> It got marked Not Applicable in patchwork, not sure why.

Also not sure what happened there - I hadn't set that myself, at least!

Cheers,


Jeremy


