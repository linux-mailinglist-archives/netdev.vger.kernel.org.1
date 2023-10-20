Return-Path: <netdev+bounces-43089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3857D160D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DE91C2106B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB4208BE;
	Fri, 20 Oct 2023 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at+VTJtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C522324
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 19:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8EC433C7;
	Fri, 20 Oct 2023 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697828510;
	bh=nTx/W/92XN6pkmt3zmCga9EKjwgfnj26//5Z7IUrGhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=at+VTJtpX9Dw0tP0AUTRHUshXeYTUNB6zfKopqnsNGM9kOE+ywuMYPmTQxPH/Pyy+
	 aSCj+JOWKd6/6bnURdCvMMlpTvWpX4UXxZ5IgPHJ2RH3Q0INmbwFQzb3tdbB0goV7R
	 cZvhx/YpZHvXWT9Q6QmS4MfkuClKujyOadQ8yZERB/xKdnRrFwT0eOnENGQwkvGC8i
	 oMwRh+RXhg6f/rgcq1vQwA6VcXTOnAfaVaUDgUJJzE7sNFJVBKQ1sYX84UMn6f3JRc
	 RrryjxiQ25SQImsqcYN+4ggpNlato4FKsaFndBcXvnKlN+Ba1ekk5kwowmgnnAdnFb
	 X1/TqwCketkpQ==
Date: Fri, 20 Oct 2023 12:01:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au, j@w1.fi
Subject: Re: [PATCH net-next 2/6] net: make dev_alloc_name() call
 dev_prep_valid_name()
Message-ID: <20231020120149.3a569db7@kernel.org>
In-Reply-To: <ZTJVeUJy9WhOgiAU@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
	<20231020011856.3244410-3-kuba@kernel.org>
	<ZTJVeUJy9WhOgiAU@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 12:24:57 +0200 Jiri Pirko wrote:
> > static int dev_get_valid_name(struct net *net, struct net_device *dev,
> > 			      const char *name)
> > {
> >-	return dev_prep_valid_name(net, dev, name, dev->name);
> >+	int ret;
> >+
> >+	ret = dev_prep_valid_name(net, dev, name, dev->name, EEXIST);
> >+	return ret < 0 ? ret : 0;  
> 
> Why can't you just return dev_prep_valid_name() ?
> 
> No caller seems to care about ret > 0

AFACT dev_change_name() has some weird code that ends up return 
the value all the way to the ioctl and user space. Note that it
has both err and ret variables :S

