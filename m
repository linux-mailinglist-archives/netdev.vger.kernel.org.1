Return-Path: <netdev+bounces-87031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9538A165B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B161F22808
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4114D43D;
	Thu, 11 Apr 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQTiGcEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234D1E526;
	Thu, 11 Apr 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843888; cv=none; b=hRlaFksL6yphdH2QgdUTvXlCG1EqXZbRqMr5a46TztVsNaz3/cj+ftRSHoHFpcJiIjeBUWVrfwqSVCZvtRaT+X2x52jnqR5vv60bs78hhbFX3kVhSFx3kksvHbC2tHreg9oOjh8Ptw2GemuXN1Il/SE7IiTP5YFaPfy5Dv89lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843888; c=relaxed/simple;
	bh=EkFAkZl6Mqm1RMJLa1ve/+JRLnko3CjF21aBW9Ldi7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5yn8ZrSDCVNHQ7loI9uV21I3UeXv4hIFgSyyquXt9Jn5+ME5sifiEBvZnk75LBdUsQhzYByeMYy1H24du3wrTpWFwLNcuJpvonfCbJvdZx1DEYjkAfFTIDuJXYYdxEq/0kHFKJoXkZNEWRgQcvCjIwMg+t+OIyPfuBmut4luzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQTiGcEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FF5C072AA;
	Thu, 11 Apr 2024 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712843887;
	bh=EkFAkZl6Mqm1RMJLa1ve/+JRLnko3CjF21aBW9Ldi7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQTiGcEPoiDO5/KhX/ljS9VEBwK2bdXbhfjwUjCmBjyK7eU31bXHDbI0Nq4w2ZPXF
	 BkFuIu6m00BoA2EkszwPxkvP4wXrKe/Yg1lq0A1sdnje5aperD06L9T3Uw2lRLqAQA
	 wD9Lmc08WFxQA1dTEl9v/Ebb5l+6ACUw2Ztd45BhSuUg0vx6+Da2moE6AM80QM3S/3
	 GM0+FQwlXMdMpxUnL5NG02ntaX5O6dT7vz7uIwCw5KQTqght+Oy/fpyhLLvbRhSoa7
	 qF10qezf8K9hgrVZ5MyggjHkU9dXC7UycdlHUu0ueJwlqd/nIYbGSH3Uc/l1n+RmwY
	 H6i4b1kjddiSQ==
Date: Thu, 11 Apr 2024 14:58:03 +0100
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/4] ethtool: provide customized dim profile
 management
Message-ID: <20240411135803.GM514426@kernel.org>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
 <1712664204-83147-2-git-send-email-hengqi@linux.alibaba.com>
 <20240409184400.4e5444f3@kernel.org>
 <a07d16d9-60cf-4263-abd5-a1adea0959ad@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a07d16d9-60cf-4263-abd5-a1adea0959ad@linux.alibaba.com>

On Wed, Apr 10, 2024 at 11:13:15AM +0800, Heng Qi wrote:
> 
> 
> 在 2024/4/10 上午9:44, Jakub Kicinski 写道:
> > On Tue,  9 Apr 2024 20:03:21 +0800 Heng Qi wrote:
> > > +/**
> > > + * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
> > > + * @skb: socket buffer the message is stored in
> > > + * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
> > > + * @profile: data passed to userspace
> > > + * @supported_params: modifiable parameters supported by the driver
> > > + *
> > > + * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.
> > unfortunately kdoc got more picky and it also wants us to document
> > return values now,
> 
> Will add it.
> 
> > you gotta add something like
> > 
> >   * Returns: true if ..
> > 
> > actually this functions seems to return negative error codes as bool..
> 
> This works, in its wrapper function its error will be passed.:)

Ok, but I think that in that case the function should return false on error.

...

