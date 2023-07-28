Return-Path: <netdev+bounces-22146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14076636E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8B92825E8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 04:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C25241;
	Fri, 28 Jul 2023 04:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02D23AE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05737C433C7;
	Fri, 28 Jul 2023 04:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690519988;
	bh=a6mFzZKJFELbuphtWPOWmDItzfe0c4tThwAzTA5VSys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X25wLqWOG5aISW05AWlV++1uV4yqL1N9hw+IMFe1oX/qg+2VQnGsn3iQwF8oZMGfU
	 w7HHtc2/fgza/omvBexHTVf32bj/zraaXdwobaiYMx/YIn4HHFgOJnZRNAs+ZkjXKW
	 cRXcOCXNZnZ+OS/pc2bBnL4geqJXyKhaIEZ0oXTDOOlpaW0OFUtoNLA+uWRw4fQQYK
	 xmxwV7xB08XrJ4xHgjW37vC5ZXWyUg/lcJ2gNXdxlX3T6Tc1BZRsRAgC9s9eI6kI3g
	 LKxg80eBHyl2yzuoAEB3l/vLnobyu2bRpdiUCs1fTE9dm7sxL6uAMSAyVeDkibSF9g
	 1GYPYiryvBS0g==
Date: Fri, 28 Jul 2023 07:53:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Message-ID: <20230728045304.GC2652767@unreal>
References: <20230726185530.2247698-1-kuba@kernel.org>
 <20230726185530.2247698-2-kuba@kernel.org>
 <20230727130824.GA2652767@unreal>
 <20230727084519.7ec951dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727084519.7ec951dd@kernel.org>

On Thu, Jul 27, 2023 at 08:45:19AM -0700, Jakub Kicinski wrote:
> On Thu, 27 Jul 2023 16:08:24 +0300 Leon Romanovsky wrote:
> > > +	if (!ifindex)
> > > +		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
> > > +				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
> > > +	else
> > > +		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	return ifindex;  
> > 
> > ifindex is now u32, but you return it as int. In potential, you can
> > return valid ifindex which will be treated as error.
> > 
> > You should ensure that ifindex doesn't have signed bit on.
> 
> I'm feeding xa_alloc_cyclic() xa_limit_31b, which should take care 
> of that, no?

And what about xa_insert() call? Is it safe?

