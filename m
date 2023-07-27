Return-Path: <netdev+bounces-21970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E227657FB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F991C2157B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C917AC6;
	Thu, 27 Jul 2023 15:45:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8218020
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B575DC433CA;
	Thu, 27 Jul 2023 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690472720;
	bh=0SecAsXwfzrfaIjxxt78ntu9Stad967pyygSa4VChUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NyP/wZLonwgTzsS+/+DxgIDA5K4fhJtuJLdYHeTn6Ps43ojM0lzBhM/6JZ6uTuyZH
	 aAWi9C+eSrhcPeS9KQuSAlRYU/TccIEWI3sK+G1fW1uQG+rzHcoy/l1gZSDE1UeHlv
	 GVdOCSVLsEK+a3G0R41hG3hTXEYtCAkanMxqag2JRH71Z5+Oizy08NoaEud5QyOx/u
	 oTn/gZhnEgkropCDp0RpnwRgEyEP1jrgy5X80gw3dwIk2uo2ZkAxmBwGYbtEpFJSRY
	 /QsmStFJJQi+72gwrWEoAVOzYNmjnaxyReb6FUzNyJB1kI4p5UD2NaLBOsGBzmBl7X
	 vWgZmJTbdq8pA==
Date: Thu, 27 Jul 2023 08:45:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Message-ID: <20230727084519.7ec951dd@kernel.org>
In-Reply-To: <20230727130824.GA2652767@unreal>
References: <20230726185530.2247698-1-kuba@kernel.org>
	<20230726185530.2247698-2-kuba@kernel.org>
	<20230727130824.GA2652767@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 16:08:24 +0300 Leon Romanovsky wrote:
> > +	if (!ifindex)
> > +		err = xa_alloc_cyclic(&net->dev_by_index, &ifindex, NULL,
> > +				      xa_limit_31b, &net->ifindex, GFP_KERNEL);
> > +	else
> > +		err = xa_insert(&net->dev_by_index, ifindex, NULL, GFP_KERNEL);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	return ifindex;  
> 
> ifindex is now u32, but you return it as int. In potential, you can
> return valid ifindex which will be treated as error.
> 
> You should ensure that ifindex doesn't have signed bit on.

I'm feeding xa_alloc_cyclic() xa_limit_31b, which should take care 
of that, no?

