Return-Path: <netdev+bounces-79246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0DE878703
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4971F20F69
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA352F80;
	Mon, 11 Mar 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0ybz5Ks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0832482E9
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180621; cv=none; b=BQLVeN/v7/kw44nzWrWXYvvrbLo7DeQtRCfFJ7i4+eJ6mG9tF9+QrQ/1o+y2+mWhVLIhhEHr35+SqAww5pbYLCQt8nUB4XODAwq2XoasRwi7YJRklhXDUIhYK5IgDSAsGATjwahGiXplw3qX9K6dVFwHShnN9AY4UTgL5skgzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180621; c=relaxed/simple;
	bh=XMzYCRYWcrB+uv4NCmazwB0RR8w8I5XwQndJm6b+RKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpBeBjb53g8S51Fih74rJy0sbjjCQR/uqmFdxgRT4or1DU0ZTV1O3xTJL0RgrhuzQgXE1aZIxp4GGGaL0jnRvhM+VMwy9MxGaPUr3jaEFLGDSzEvpKuPNBCrDkCj9FA5PXCz/wZaGJMuryctk5fwnYHTGZjRRh9sZlDXj2mGjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0ybz5Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE45BC433F1;
	Mon, 11 Mar 2024 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710180621;
	bh=XMzYCRYWcrB+uv4NCmazwB0RR8w8I5XwQndJm6b+RKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m0ybz5KsVordlIrhjPbWBbvDET4HoziY1gccbHW3xy5raQ5nf3GWlyJVABkeDrBUA
	 NWc+ccI1V2V/PJ3IXSXkBWJoWY5dQqdtafO+BeDygWMyxJerEAdW/+gCfe3Omp6Hu0
	 dj8yTSf0VCr0/5w1E2CPNgWWBTlWrXgUSyHf7+FmCfeoKgjmFgoAWm059G4wOqnULX
	 QA11WkYrVwhaYTmdU+Lzn9Ea3/ig8G3QaElhBR1XBdxQ4lvXjCojdD+7/VkH6+Slfu
	 DSlq26GsF74UBzTKqbEuPix1ApqfJlSg6qMoyhYC9dChOG86dFxovx7KhdZnU7r6Il
	 WMor8oGMmdbmg==
Date: Mon, 11 Mar 2024 11:10:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] devlink: Fix devlink parallel commands processing
Message-ID: <20240311111020.24f46bbc@kernel.org>
In-Reply-To: <20240311085726.273193-1-shayd@nvidia.com>
References: <20240311085726.273193-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 10:57:26 +0200 Shay Drory wrote:
>  	devlinks_xa_for_each_registered_get(net, index, devlink) {
> -		devl_dev_lock(devlink, dev_lock);
> -		if (devl_is_registered(devlink) &&
> -		    strcmp(devlink->dev->bus->name, busname) == 0 &&
> +		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
>  		    strcmp(dev_name(devlink->dev), devname) == 0)
> -			return devlink;
> -		devl_dev_unlock(devlink, dev_lock);
> +			goto found;

there's no need for a goto here:

		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
		    strcmp(dev_name(devlink->dev), devname) == 0) {
			devl_dev_lock(devlink, dev_lock);
			if (devl_is_registered(devlink))
				return devlink;
			devl_dev_unlock(devlink, dev_lock);
		}

simpler, and also no change in behavior (in case some impossible
race happens and we have 2 devlinks with the same name, one already
unregistered and one registered).

>  		devlink_put(devlink);
>  	}
> +	return ERR_PTR(-ENODEV);
> +
> +found:
> +	devl_dev_lock(devlink, dev_lock);
> +	if (devl_is_registered(devlink))
> +		return devlink;
>  
> +	devl_dev_unlock(devlink, dev_lock);
> +	devlink_put(devlink);
>  	return ERR_PTR(-ENODEV);
-- 
pw-bot: cr

