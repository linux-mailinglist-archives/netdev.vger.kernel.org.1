Return-Path: <netdev+bounces-91593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2AD8B3216
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE4F1C21255
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A613C915;
	Fri, 26 Apr 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="AO5ZLfjF"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2414293
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119185; cv=none; b=J3KecCKFwNaTRJo5blfihWYuD5zHl+M1Z3Nl4aU7oqLLTUUuRD5u8jC+Bsxv33OKQMi4Jn7x1jYO+owWzjWkr12f3kulQUXrSOXzfoleuT6Fkct9HV9zfwg510VtxdHj+xOt/xjImvxwh/Ec2jWuVGNCY5lDGJ9YSL5f4cacVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119185; c=relaxed/simple;
	bh=c6VRLJPp/4jZOqH/dlpkGx5osSz9dKhT2FMWS3WTX2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCaUyrV13RsKCl2IZIoO4RbwXlCXNPxNYLc0XO9rePEOEJBP6pTT1WEs6QW7DYyuwvIAEhummkNfQBAedAHp7JLxAdvzgaUz+Wnkbo9RmfR/Aq1OyVBY2Qltr+MY7hg99SG+gNqF6OVo4ylYQOR8W/0HL15nJ/v0K3eGC99zMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=AO5ZLfjF; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: a38760ad-03a4-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a38760ad-03a4-11ef-836c-005056aba152;
	Fri, 26 Apr 2024 10:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=tbf/KYmDHZM+S/pkYVfdlKKNsDHA5SNUYGhE25ggmCM=;
	b=AO5ZLfjF2o4jBFJmsKrNqTBA1VRCoGr+SSn7YPKdr/zYdewA9ttdzkBz78LR6VZum+jixmBcRMPMW
	 /GE8Clg5bq1TTadmANCY0zn44cajpFvpbhqYXgCtf1082bccaeZz4JPilshvpEKfb5lo6MUR9aTanT
	 NWJGR3Qb4pxjzKOk=
X-KPN-MID: 33|elPe8iV/CJ+h15hIP5rRQFcepOze/+ShPEZ7Ju22YZhj0G5dXwrupnSu7LgCYQe
 fsIOuY8F9NQ/uEFb7oZ53roaNFgrVliZ9+ceqJwYi8GY=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|dzh+neos4vfBtn0tagIZGRMEFNsDu5vrP91a8iVGRTUD//nMeiOk7hhzAQYKiKx
 28CDEcMuPw4JfggBVhif4ug==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a315032c-03a4-11ef-8d63-005056ab7447;
	Fri, 26 Apr 2024 10:11:53 +0200 (CEST)
Date: Fri, 26 Apr 2024 10:11:50 +0200
From: Antony Antony <antony@phenome.org>
To: nicolas.dichtel@6wind.com
Cc: Sabrina Dubroca <sd@queasysnail.net>, antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v12 3/4] xfrm: Add dir validation to "in" data
 path lookup
Message-ID: <ZithxsHLhPw1ZVHM@Antony2201.local>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <f7492e95b2a838f78032424a18c3509e0faacba5.1713874887.git.antony.antony@secunet.com>
 <8ac397dc-5498-493c-bcbc-926555ab60ab@6wind.com>
 <ZijFmMDST_ksUUnk@hog>
 <80f3257c-e214-41d2-8b40-b29af32310aa@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80f3257c-e214-41d2-8b40-b29af32310aa@6wind.com>

On Wed, Apr 24, 2024 at 12:04:12PM +0200, Nicolas Dichtel via Devel wrote:
> Le 24/04/2024 à 10:40, Sabrina Dubroca a écrit :
> [snip]
> >>> diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm_proc.rst
> >>> index c237bef03fb6..b4f4d9552dea 100644
> >>> --- a/Documentation/networking/xfrm_proc.rst
> >>> +++ b/Documentation/networking/xfrm_proc.rst
> >>> @@ -73,6 +73,9 @@ XfrmAcquireError:
> >>>  XfrmFwdHdrError:
> >>>  	Forward routing of a packet is not allowed
> >>>
> >>> +XfrmInStateDirError:
> >>> +        State direction input mismatched with lookup path direction
> >> It's a bit confusing because when this error occurs, the state direction is not
> >> 'input'.
> > 
> > Agree.
> > 
> >> This statistic is under 'Inbound errors', so may something like this is enough:
> >> 'State direction is output.'
> > 
> > Maybe something like:
> > 
> > State direction mismatch (lookup found an output state on the input path, expected input or no direction)

This is better. Fixed in v13.

> > 
> > It's a bit verbose, but I think those extra details would help users
> > understand what went wrong.
> > 
> Sure, it's ok for me.

thanks,
-antony


