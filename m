Return-Path: <netdev+bounces-128230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F47978A0D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4252813D2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6114A09F;
	Fri, 13 Sep 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H48mRVG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D4146D55
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259667; cv=none; b=so1E8RboEwDPuUywYzjQCQHGl7W+ndBLmNI9Rodwl9+ERo0IeVOiKg0Y2D3df1wTFp2sJ7omf+GFmuaqkBVGy6zBlEZbjOwQ5Hp97tSTVgfgo0u5lGsL8Prr2ZoyhXdBiow3gMXVtbB1n8Igt+XnX4Q81TjvSUOSXwBNTYLiHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259667; c=relaxed/simple;
	bh=Yc7EHIaVGQiLnVonX53UWTTkCQKdH7Ml5XLYjHHZrN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaL38k72l7FbcO7PXS6ZOjZwGAY5wUYQKzIngZTJhrLUPK9rfln4EODbaYlkxshm1sIvxn2yJ8bfUVoNdDju8RV6d9nj+6AMVhP9AXXO4q0cSmU8rZH/mCLoBybnuNARYXtuCqUsQrzmDQHu3Dol/VlYBpsGCLoBPAqdmz9cBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H48mRVG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB2DC4CEC0;
	Fri, 13 Sep 2024 20:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726259667;
	bh=Yc7EHIaVGQiLnVonX53UWTTkCQKdH7Ml5XLYjHHZrN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H48mRVG0vgu092i9KHYWR7HpuLfRWVIF8UtFiG41vPGZjnTeQ+Fb1yxmQOVKZBYhc
	 BWlYQ8Q2OK5kQ61uCG2ZBdwaUHGMbjlHV5jxDrjwLtKqPg96NzNy5NAmJQhkQNjecV
	 /oUgb4FBDZ9cy5ZO5d0L00MNjnhiczibTQd5imXU5OCCahFqxbczlqn4/1NqUbuhmS
	 0q2zHOLK24EaitXRSygJ6HMLzZESfy5OE+ASvLuboFaWFH1bxlLNS9VlNRi8DZmUrq
	 vR/blYHjNYKQu5lEOXRucBxH7GFub3iAP8aKqg51ggmdYGyfa/Do7NLGMovqjbt9Be
	 QuJ2+4qBZLGhQ==
Date: Fri, 13 Sep 2024 13:34:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Sudheer
 Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <20240913133426.0f7df2b3@kernel.org>
In-Reply-To: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 12:38:28 +0300 Vladimir Oltean wrote:
> Several drivers regressed when ethtool --show-rxfh was converted from
> ioctl to netlink. This is because ETHTOOL_GRXRINGS was converted to
> ETHTOOL_MSG_CHANNELS_GET, which is semantically equivalent to
> ETHTOOL_GCHANNELS but different from ETHTOOL_GRXRINGS. Drivers which
> implement ETHTOOL_GRXRINGS do not necessarily implement ETHTOOL_GCHANNELS
> or its netlink equivalent.
> 
> According to the man page, "A channel is an IRQ and the set of queues
> that can trigger that IRQ.", which is different from the definition of
> a queue/ring. So we shouldn't be attempting to query the # of rings for
> the ioctl variant, but the # of channels for the netlink variant anyway.
> 
> Reimplement the args->num_rings retrieval as in do_grxfh(), aka using
> the ETHTOOL_GRXRINGS ioctl.

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks for fixing this! Not sure why Sudheer didn't.

