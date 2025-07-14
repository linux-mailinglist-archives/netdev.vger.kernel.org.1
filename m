Return-Path: <netdev+bounces-206771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30EB04562
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF33A3B754F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0E926159D;
	Mon, 14 Jul 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0HRn8kQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE9239E90
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510100; cv=none; b=p3FuXxhvsdVNV7OY8keZlVchuTKLLQq9cbh26nXW0ImvAxdM4uKjMpNakm49+TcBR/SZ6Bm3WX4+5KjPrO2qrGv45Hkjfngt6gyne+9cTf8nTrHlkuFFLEIE5XIaLkwv7hDxk47IUjmBcKWVEGdhlPDClV+He86FGqIbG7RuZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510100; c=relaxed/simple;
	bh=WWDt5DMyUfsPsokGiHby+qjdoKckcUirisZ8YMgYvIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL0owC+9en23Y2h8bokw5yWOS6mPvVBX9NvkNfXbUXkZ+j8PZ2+QJjzU64qIa9LQL3kiEbRcjCh6QZsUMYMonTorkQnuyDCMbeSMk5hlf9PE4auxtxNoRC1/Uc7Y4hGmVgbW6/DZmWdDbH4obucOzZTelz64P+t1cfz7+ccdlu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0HRn8kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F3C4CEED;
	Mon, 14 Jul 2025 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510100;
	bh=WWDt5DMyUfsPsokGiHby+qjdoKckcUirisZ8YMgYvIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0HRn8kQ5oxDjqUXoQTR7LXzodryKtQb/4fJNzC6A7fCSmSwltYgGsHTlHbcsOt4e
	 F6l9biA3Kk8GokDGOoyb3W4kowDSutzoinefmZ6xWKLj7aeRJdk1+kGvuK6eSKY7nn
	 yfUBtBxzQ+G7I1hcPmJU3X7CggzSNZL1sBFVLl4zgsTxbT+lQwvJIjoDFg8YKzr6gT
	 Lr84f36TQsMdyGHq7FQD8az3OLfvYF67XorHwcLwBeqvJZggKI554WMZh4O1xszwKZ
	 9ZR4G5/T1gWyf2NqNRyMVPkIX1GeRtI/JQ/l/ZbEpdP8xjRCKB+6eCaFuXPVHLs58z
	 qRqx7+TnSipfA==
Date: Mon, 14 Jul 2025 09:21:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 05/11] ethtool: rss: support setting hfunc via
 Netlink
Message-ID: <20250714092139.7862e752@kernel.org>
In-Reply-To: <5686fbfb-4e47-48fd-93f9-25443aeb1d89@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-6-kuba@kernel.org>
	<5686fbfb-4e47-48fd-93f9-25443aeb1d89@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:10:20 +0300 Gal Pressman wrote:
> > @@ -617,7 +623,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
> >  		goto exit_clean_data;
> >  	mod |= indir_mod;
> >  
> > -	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
> > +	rxfh.hfunc = data.hfunc;  
> 
> What is this for?

WDYM? data is filled in by the GET handler. So we init rxfh.hfunc
to what driver returned from GET.

> > +	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
> > +	if (rxfh.hfunc == data.hfunc)
> > +		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;  
> 
> I think that this is a distinction that we don't currently make in the
> drivers/ioctl flow.
> 
> NO_CHANGE was specifically used for cases where the user didn't specify
> a parameter, not for cases where the request is equal to the configured one.
> mlx5 for example, performs this check internally because it can't rely
> on NO_CHANGE for requested == configured.

Yeah, no strong preference. We have to live with the ioctl path so 
the drivers will need to keep handling all corner cases. In this case 
I chose behaving somewhat consistently with the ioctl behavior (assuming
user space is well behaved). Otherwise if we move ethtool CLI to netlink
new drivers may forget that NO_CHANGE is a thing.

