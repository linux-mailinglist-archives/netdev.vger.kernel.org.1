Return-Path: <netdev+bounces-47926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20947EBF73
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A38A28127B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208463D5;
	Wed, 15 Nov 2023 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK9BtimM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577263C4
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7630DC433C9;
	Wed, 15 Nov 2023 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700040504;
	bh=C6njI5GfsfbHSX6PlTamyWsg4v02QlUD8BMV6EcIvEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK9BtimMFM1PNtOHSVdfsjWRvDjR+3Pxsl8Putq9a7V6tpYZwEaMnUCvTII0fv43T
	 4PUpebbSpSMOXBsZYG97txWDJRR1RXgllbdYTeA6DLe83tYo3VRWlcz/RIRL+qm+op
	 /SIYG2Zum76DWgpsAnBr28sga5cqS43ojOoP8FphxFH7CmJWCZ4igdr12uQXmqYcoa
	 5u4uqrCvHxLnUTA77uBWnJqHmxYGbnVnjjSdN02eKNBlBghL8iH0bz1h/Rq9KBSQ/D
	 h80yCqYQz4zCYt4T94obL13AUjXMnSQa0goZDDme11BHzPdzXKvY6josg+muK9bp3N
	 aSGYzaXFDtOYA==
Date: Wed, 15 Nov 2023 09:28:21 +0000
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net] net: Fix undefined behavior in netdev name allocation
Message-ID: <20231115092821.GK74656@kernel.org>
References: <20231113083544.1685919-1-gal@nvidia.com>
 <20231113095333.GM705326@kernel.org>
 <dc40af68-80a2-4821-b674-12462086973b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc40af68-80a2-4821-b674-12462086973b@nvidia.com>

On Mon, Nov 13, 2023 at 04:01:23PM +0200, Gal Pressman wrote:
> On 13/11/2023 11:53, Simon Horman wrote:
> > On Mon, Nov 13, 2023 at 10:35:44AM +0200, Gal Pressman wrote:
> >> Cited commit removed the strscpy() call and kept the snprintf() only.
> >>
> >> When allocating a netdev, 'res' and 'name' pointers are equal, but
> >> according to POSIX, if copying takes place between objects that overlap
> >> as a result of a call to sprintf() or snprintf(), the results are
> >> undefined.
> >>
> >> Add back the strscpy() and use 'buf' as an intermediate buffer.
> >>
> >> Fixes: 9a810468126c ("net: reduce indentation of __dev_alloc_name()")
> > 
> > Hi Gal,
> > 
> > perhaps my eyes are deceiving me, but I wonder if this fixes the following:
> > 
> >   7ad17b04dc7b ("net: trust the bitmap in __dev_alloc_name()")
> 
> Thanks Simon, you're right.
> 
> Should I resubmit?

I guess that it is not strictly necessary,
but it might be a good idea as I imagine it makes things
slightly easier for the maintainers.

In any case, thanks for confirming and with this changed (somehow)
this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


