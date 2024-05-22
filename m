Return-Path: <netdev+bounces-97551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A78CC182
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB28B20C15
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149613D891;
	Wed, 22 May 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIKMHMYJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDE13D63A
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381869; cv=none; b=gX1IAEwOCouUrLa1Na0YE/y89o3xAcY8IjoBZmqxso5TvMCIwGILfQ33JBcwG8rp+3HMY/sQx1r6HTz2wz//n5BSJ1dEOn2/gGgF6BuSRzKTrg60NG1LWgLr6+tA19Hr4VS3b5+T0XKR5Wg9cF/pZzC0D/hMo5J+QHYmeA3TIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381869; c=relaxed/simple;
	bh=hv7ttEAWx2wfGlD1BH9EMdflvLncJPZUYadyFztFW7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYIz0StlPqNDgAj4GbkpcKNgMNg3PviWbzW6ITomSk2CCBc9NuhRoi2Y3ZolvQ58xvzfKXlIVAXvd8GzUKHpKYdWV3U5PuwJbmeE5O86NTkm7MtGWxmgQ3/stbIP57HrXBJIWUcCQ2YhiB1g/XkLTMo6Za17MlsVbdvS5pkEmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qIKMHMYJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eiJqOSCIoYUspajUNS1YTnFgXOLA6Ql9mO0cVO7HeTg=; b=qIKMHMYJuR7S5xYb2olVyxpZTX
	WUCMJvZ5Hldgi/7vALmNuZ3UON2VyMFJWKojrrj3J0dnioXEYrAE/+cc820xBkUQdxabJrwqXkikX
	NBcbL5a8MvWwusOO3EV/xKmGxENtyGyAbr5RPtl+4pRFVQz9fV/SIBkuZCXb60s2EL+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9lKS-00Fp0k-3b; Wed, 22 May 2024 14:44:24 +0200
Date: Wed, 22 May 2024 14:44:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
	Michal Kubecek <mkubecek@suse.cz>, Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk2vfmI7qnBMxABo@shredder>

> > So right, the function returns 512 for SFP and 256 for everything else, which explains why SFP does work but QSFP - not.
> 
> Since you already did all the work and you are able to test patches, do
> you want to fix it yourself and submit or report to the mlx4 maintainer
> (copied)? Fix should be similar to mlx5 commit a708fb7b1f8d ("net/mlx5e:
> ethtool, Add support for EEPROM high pages query").

Before you do that, please could you work on ethtool. I would say it
has a bug. It has been provided with 256 bytes of SPF data. It should
be able to decode that and print it in human readable format. So the
EINVAL should not be considered fatal to decoding.

       Andrew


