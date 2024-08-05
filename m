Return-Path: <netdev+bounces-115910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F748948559
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C761F23659
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 22:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE6155351;
	Mon,  5 Aug 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2QT01w8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624D16C69C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895999; cv=none; b=kaLjB8Ak8oSR6UqOMi+Hgph6Jai3T6wTptVB8oCFfaQKrFt+oUlWHiAgFR+aApFjclQrtD641EFLx46PAb/MDnFVFc72A5vfoIfPzlSX5hOa63H17dyOnWepHx3nmveudj5Mh1So8fykI0LOWPqJrp8ABqIypPUbDLL0hzxfEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895999; c=relaxed/simple;
	bh=MTqToAMAS5seAlMMjWcQa3foMmzJs1DT59uR3j5i6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6B2M+3JhH5p/oNVt8Ae1fjQhOwbuziw3ecKICgB7tZNoljpo90K7w+/3Vn3IWNPmf7xV5aAFJUB87p75eFyKpkqG8epboQDz7Rzw2/LuQgFzMGVEuJSqcvOZffpIvAnkRczoSbtPV40lEtlbWvJvIKMsQNRMFsB8/hxgoQob/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2QT01w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6732C32782;
	Mon,  5 Aug 2024 22:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722895999;
	bh=MTqToAMAS5seAlMMjWcQa3foMmzJs1DT59uR3j5i6t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u2QT01w8rOdv3ckwzWTgOdF5rY7Arf6Q52D5FfPWxFj8Tgc4cb91MI70FbN6ggKcV
	 exol07CahUZWOYBH+NmWhlGWeEd6pqwSQksKiwHxR/Kbh/YvsIk9MCUugkTIebZw7j
	 ZO9xKnLxlcNj9J1YeXggq+H5mwzzfHHiS0PlK7QpC3CHpPSFrefivL9+og4Q4iE+Xa
	 px8rWhrrv7A77J1NpUkCeFIAf0u2sq6DQmubAbDYymkq6zLJN0kuyOQL2PLevb4EiA
	 3xqwP5h3Imr8j3QoO02/CAleUcdF78MhtrVP3TfZly6+FEA6nZU9HXNJK8nOL6xJFP
	 0rFt2jk7LnAig==
Date: Mon, 5 Aug 2024 15:13:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, donald.hunter@gmail.com, tariqt@nvidia.com,
 willemdebruijn.kernel@gmail.com, jdamato@fastly.com, Ahmed Zaki
 <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next v2 00/12] ethtool: rss: driver tweaks and
 netlink context dumps
Message-ID: <20240805151317.5c006ff7@kernel.org>
In-Reply-To: <05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com>
References: <20240803042624.970352-1-kuba@kernel.org>
	<05ae8316-d3aa-4356-98c6-55ed4253c8a7@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Aug 2024 09:08:50 +0300 Gal Pressman wrote:
> >    The only question here is how to handle all the tricky IOCTL
> >    legacy. "No change" maps trivially to attribute not present.
> >    "reset" (indir_size = 0) probably needs to be a new NLA_FLAG?  
> 
> FWIW, we have an incompatibility issue with the recent rxfh.input_xfrm
> parameter.
> 
> In ethtool_set_rxfh():
> 	/* If either indir, hash key or function is valid, proceed further.
> 	 * Must request at least one change: indir size, hash key, function
> 	 * or input transformation.
> 	 */
> 	if ((rxfh.indir_size &&
> 	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
> 	     rxfh.indir_size != dev_indir_size) ||
> 	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
> 	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
> 	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
> 	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
> 		return -EINVAL;
> 
> When using a recent kernel with an old userspace ethtool,
> rxfh.input_xfrm is treated as zero (which is different than
> RXH_XFRM_NO_CHANGE) and passes the check, whereas the same command with
> a recent userspace would result in an error.
> This also makes it so old userspace always disables input_xfrm
> unintentionally. I do not have any ideas on how to resolve this..
> 
> Regardless, I believe this check is wrong as it prevents us from
> creating RSS context with no parameters (i.e. 'ethtool -X eth0 context
> new', as done in selftests), it works by mistake with old userspace.
> I plan to submit a patch soon to skip this check in case of context
> creation.

I guess we just need to throw "&& !create" into the condition?
Sounds good! We should probably split the "actual invalid" from 
the "nothing specified" checks.

Also - curious what you'll put under Fixes, looks like a pretty 
ancient bug :)

