Return-Path: <netdev+bounces-72918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E385A203
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07EF3B24A48
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BD2C1BF;
	Mon, 19 Feb 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSkclN9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DF2DF9C
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342364; cv=none; b=paVaOUBKk/fgYF7GQS5TIWHxDrpdWJP6LE8fzSMqwAS9yOmBGgx0o+wpeZ6MaGRvR+wo7lFClkOWELFAIEhcy6GKve8UYtdMx0ypcQ+GHx9PMFOReY9UiL9NTJ6Z6/eZ7FImXAVtwCaNQtAEf54JiKTCjxFIal1PL6+a8yCRi78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342364; c=relaxed/simple;
	bh=zjYDXGbCJ3OE49yAqjUdDc1yFyZlqeC4ED7QJ5NUxww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt8G3KOwzQE+FgeGlCjKP+8xT0OsPiLZca0bR6aUuc2G4TR+0jVR2nNsrtcVOusRG5zYwfWVbvzmabA3+JCRieT71/okTQgmMvfjUX0mMXkhFIX20lMl16TvmbpXJEGbRNHJCDNK5eFhihRke4UgIPvoXEV1RaaV8lxHFcjwUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSkclN9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1290DC43390;
	Mon, 19 Feb 2024 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708342364;
	bh=zjYDXGbCJ3OE49yAqjUdDc1yFyZlqeC4ED7QJ5NUxww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSkclN9ZNJGPp9OqOmFfUHM4baq1Jl3x4JlhyFTluidBZhZPx8wHrZOvJsrdgOMDD
	 LXiD8ZNA6E1bZnIqoCwoH/QePvd1Y8cbD6mXcs1rgG0BYQDUxmwmooGlsjwRLn7XG1
	 gXxSe4uu3l+As4t83DQNuC/ZmClvIgcC8mXZQLGLwXR5RqxL5QzHyzGkA3vAXFiHw+
	 N5HWMDrSuyAhQIcS0gclmWbJ9yLFsz4pOVo7Izfg4EAWnxwrAoXvTKfFQ0TgiGwMOM
	 b2QBd6GFJtxoCZ5Ee9mXc0q6UCqYXvt7zpBzcNF832/TvxxOlphJhtBQ1dHn8wnKx0
	 F18/gwOI8EYuQ==
Date: Mon, 19 Feb 2024 11:32:40 +0000
From: Simon Horman <horms@kernel.org>
To: kovalev@altlinux.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	jacob.e.keller@intel.com, johannes@sipsolutions.net,
	idosch@nvidia.com, David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCH] genetlink: fix potencial use-after-free and
 null-ptr-deref in genl_dumpit()
Message-ID: <20240219113240.GZ40273@kernel.org>
References: <20240215202309.29723-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215202309.29723-1-kovalev@altlinux.org>

+ Jiri Pirko <jiri@resnulli.us>
  David Lebrun <david.lebrun@uclouvain.be>

On Thu, Feb 15, 2024 at 11:23:09PM +0300, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The pernet operations structure for the subsystem must be registered
> before registering the generic netlink family.
> 
> Fixes: 134e63756d5f ("genetlink: make netns aware")

Hi Vasiliy,

A Fixes tag implies that this is a bug fix.
So I think some explanation is warranted of what, user-visible,
problem this resolves.

In that case the patch should be targeted at net.
Which means it should be based on that tree and have a net annotation
in the subject

	Subject: [PATCH net] ...

Alternatively, the Fixes tag should be dropped and some explanation
should be provided of why the structure needs to be registered before
the family.

In this case, if you wish to refer to the patch where the problem (but not
bug) was introduced you can use something like the following.
It is just the Fixes tag that has a special meaning.

	Introduced in 134e63756d5f ("genetlink: make netns aware")

I think the above comments also apply to:

- [PATCH] ipv6: sr: fix possible use-after-free and null-ptr-deref
  https://lore.kernel.org/all/20240215202717.29815-1-kovalev@altlinux.org/

- [PATCH] devlink: fix possible use-after-free and memory leaks in devlink_init()
  https://lore.kernel.org/all/20240215203400.29976-1-kovalev@altlinux.org/

And as these patches seem to try to fix the same problem in different
places, all under Networking, I would suggest that if you do repost,
they are combined into a patch series (3 patches in the same series).

But I do wonder, how such an apparently fundamental problem has been
present for so long in what I assume to be well exercised code.


Also, potential is misspelt in the subject of this patch.

> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  net/netlink/genetlink.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 8c7af02f845400..3bd628675a569f 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1879,14 +1879,16 @@ static int __init genl_init(void)
>  {
>  	int err;
>  
> -	err = genl_register_family(&genl_ctrl);
> -	if (err < 0)
> -		goto problem;
> -
>  	err = register_pernet_subsys(&genl_pernet_ops);
>  	if (err)
>  		goto problem;
>  
> +	err = genl_register_family(&genl_ctrl);
> +	if (err < 0) {
> +		unregister_pernet_subsys(&genl_pernet_ops);
> +		goto problem;

The problem label calls panic().

As noted elsewhere [1] there is no expectation of recovering from panic(),
so there is no need to clean up here.

[1] https://lore.kernel.org/all/CANn89i+TNVtk8UT1+2QeeKHR-b6AQoopdxpcqcbNVOp9+JYSYw@mail.gmail.com/

> +	}
> +
>  	return 0;
>  
>  problem:
> -- 
> 2.33.8
> 
> 

-- 
pw-bot: changes-requested

