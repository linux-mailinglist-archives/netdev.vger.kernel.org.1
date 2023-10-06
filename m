Return-Path: <netdev+bounces-38456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D557BB010
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4E3571C20753
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE00139B;
	Fri,  6 Oct 2023 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF+HI6VZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFA111F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A142C433C8;
	Fri,  6 Oct 2023 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696555830;
	bh=B2TsXLrI9UAB9Ml0sIzQQMIT8UztV4dk/20wpkEztbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hF+HI6VZ6MyjrXj/aXjXE93X2QFfWlH2dp+0l2preGTMNnUcLTWVCWegJpT1OFNvh
	 oW7yBHAamnoyTaNO0vgXhev62gyu1IpV5IPFVFKRH9dQTRiSh/Nn5eh/klwFxQD5+A
	 wO4vXyL3KsYPYPXiWFZm44m12gGTPZJQJSUTeBGvJKzKWinBm4Ghbh8X1Y4h9skqV3
	 Cj3pht/W+qIGvpSrCZsvzE8cNUbSqdxOBGBghQh87LJIqEwO+nm1vDL8nrBEzjpBFU
	 8RFl8kC2nKGKSTNfSQ3TB35SDj85TEq7N0hoPmKrqtGUSa1E98I0lvCd2YuAOeORfY
	 wiS7gp9VquQEw==
Date: Thu, 5 Oct 2023 18:30:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231005183029.32987349@kernel.org>
In-Reply-To: <20231003074349.1435667-1-jiri@resnulli.us>
References: <20231003074349.1435667-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Oct 2023 09:43:49 +0200 Jiri Pirko wrote:
> To fix this, don't take the devlink instance lock when putting nested
> handle. Instead, rely on devlink reference to access relevant pointers
> within devlink structure. Also, make sure that the device does

struct device ?

> not disappear by taking a reference in devlink_alloc_ns().

> @@ -310,6 +299,7 @@ static void devlink_release(struct work_struct *work)
>  
>  	mutex_destroy(&devlink->lock);
>  	lockdep_unregister_key(&devlink->lock_key);
> +	put_device(devlink->dev);

IDK.. holding references until all references are gone may lead 
to reference cycles :(

>  	kfree(devlink);
>  }

> @@ -92,9 +93,8 @@ int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
>  		return -EMSGSIZE;
>  	if (devlink_nl_put_handle(msg, devlink))
>  		goto nla_put_failure;
> -	if (!net_eq(net, devlink_net(devlink))) {
> -		int id = peernet2id_alloc(net, devlink_net(devlink),
> -					  GFP_KERNEL);
> +	if (!net_eq(net, devl_net)) {
> +		int id = peernet2id_alloc(net, devl_net, GFP_KERNEL);
>  
>  		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
>  			return -EMSGSIZE;

Looks like pure refactoring. But are you sure that the netns can't
disappear? We're not holding the lock, the instance may get moved.

Overall I feel like recording the references on the objects will be
an endless source of locking pain. Would it be insane if we held 
the relationships as independent objects? Not as attributes of either
side? 

