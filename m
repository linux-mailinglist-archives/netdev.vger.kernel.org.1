Return-Path: <netdev+bounces-145193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D279CDA3B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3912728323A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F116BE2A;
	Fri, 15 Nov 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OdQJcorf"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9F52F71
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658161; cv=none; b=uCz0KjWroqEZ/q1N5WZtjIENQ5jRfb/kw0EOw7Gv7dqFyd49YWFAT7aXfFN81uF9r8HwMlcQHb9y+HjzDdnoA0xt7t426XjQnKi+sM7AmY+oGP4IzW/qTCmgMbOebSYF5P6x/i4kc2c+nBLQC6wayICOVnuCs3QfUh64PoglTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658161; c=relaxed/simple;
	bh=vDGbtaSbJWBWF9eSM+5kMzpoDXlI8L1MmNv0AxCiabc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQpM+TkidPqOQuQzvdnxc/T7pPpj83eQcZa7jrF0NrzKakuqOLmenlehSDhvF6Q9mzTd5fDkbUSkiTV1gIuiH+bS03mQXf5bnoqV0rBcdU3UnOAma6tSNTRxCH58H1l0k+q0CJqjdFwlHNJZsc/Dru5LLPuj4VbuYzac0wHO13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OdQJcorf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4C3112085B;
	Fri, 15 Nov 2024 09:09:17 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnaOuHD0lKha; Fri, 15 Nov 2024 09:09:16 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BD3D22085A;
	Fri, 15 Nov 2024 09:09:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BD3D22085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731658156;
	bh=XSd/EPOGaiOKeIAhWnh/hYdXdlgOSjGiMbPVV//nlL4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OdQJcorf06ueXPJpb7QFqLVSKcC02IjQJhiicSSXPQEFafkpwIar+HlZhNfXIpgu4
	 OmO06e5oHEgCq4gfB7fyX2SSGFiD6wgcA9XJZzkQfUoN3hmrkf1/40vPx5tdpGRkc6
	 lRM/OQ8i2xpZzqkskFXd0ku35d0d1H2v5r8OlNG5qrjCWi0OMOOkxptVyWuOaxFbdm
	 06+RZiQ+JTkn1/FCvj9Q8dMDxuMsXeacL7zReKiABZdg+InXaqHm6C8KkHQYMl/Wxa
	 BhMtQvAMk0CGSxdM08z5H2Af/9/LLTjbRZ6bNBvN5AGFPLsYnr/0oel09A2GkIlWBk
	 7aAzOmgQrCyPg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:09:16 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:09:16 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 42C553184210; Fri, 15 Nov 2024 09:09:16 +0100 (CET)
Date: Fri, 15 Nov 2024 09:09:16 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH ipsec-next] xfrm: Fix acquire state insertion.
Message-ID: <ZzcBrIVEQcX1lhLu@gauss3.secunet.de>
References: <ZzXZ0BaL9ypZ1ilY@gauss3.secunet.de>
 <20241114181138.GB1062410@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241114181138.GB1062410@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 14, 2024 at 06:11:38PM +0000, Simon Horman wrote:
> On Thu, Nov 14, 2024 at 12:06:56PM +0100, Steffen Klassert wrote:
> > A recent commit jumped over the dst hash computation and
> > left the symbol uninitialized. Fix this by explicitly
> > computing the dst hash before it is used.
> > 
> > Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

This is now applied to ipsec-next. Thanks for the review Simon!

