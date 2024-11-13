Return-Path: <netdev+bounces-144424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DCC9C72D7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0357FB29E4D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE0202F80;
	Wed, 13 Nov 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjgJB78K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C8200BAB;
	Wed, 13 Nov 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505611; cv=none; b=bIJwJ20b02tErPj0GzWa91dCzcXHQalxB1YBA66FxL/gZf+ZbEfV7Yd+D9DgNL3/TSoDE2kQvXdVOfK99jqfzUtSmlFnUfHYS/n93rBB8CUAyf4kRPXjMPGFxHmuNh+iBP6eI3ICIIw3R4D5ph3mDfUXV3sEYvPqjzTYBb3rfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505611; c=relaxed/simple;
	bh=izp2MlyIVIIQ9RDNiFC4tvd+Sli8WWME9SOgY+FcnlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od0N0afnxqLgzZj8T/J6AtLvUKJE4HMSZ8ga7kfebwpcnoUiK7msv4Iw2O18mRhFauVLJvhAT0Fps80oZm3iCLl2Ei+uZIo10jVvYmMgoVQSVD5Z5K8rOSbADPwQrnE2btYLybc0qQgfEzdVZCEhhpkzdc60D57L7JSP4ATzpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjgJB78K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55423C4CEC3;
	Wed, 13 Nov 2024 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731505610;
	bh=izp2MlyIVIIQ9RDNiFC4tvd+Sli8WWME9SOgY+FcnlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjgJB78KucJLpAZOCftPasYX1sIRdUm16VeVW3DXKV+Ug2pZRm7CL0WvLUXQVbtet
	 3UXsTYs1E+2g430AoZqit6bcU/rEm+1dlpRNM2E0zJDcbD6TiH0MZtBEXF6EbQ/kRo
	 vPo7BV0nIcMJGBx8GvYobSPjqiXDUuUDVIcirT4bQCHuZ9wmX77qXeCH5xuGcMAJO5
	 m4eUL5rG+vHt5tf/9Imv25JmEUsizEIC+46dDBJdIsoslxGK1Z/TJruCwcPCc3bB17
	 KJZmhxs7OhA9DFv1TGNFX6dSbcDvStbytfZi7EYWJQaJ7snf2kw94z4CWVRh95U+Vn
	 pBdK+ED50dhxA==
Date: Wed, 13 Nov 2024 13:46:45 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	sedara@marvell.com, vimleshk@marvell.com, thaller@redhat.com,
	wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
	konguyen@redhat.com, einstein.xue@synaxg.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeon_ep: add ndo ops for VFs in PF driver
Message-ID: <20241113134645.GA4507@kernel.org>
References: <20241112185432.1152541-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112185432.1152541-1-srasheed@marvell.com>

On Tue, Nov 12, 2024 at 10:54:31AM -0800, Shinas Rasheed wrote:
> These APIs are needed to support applications that use netlink to get VF
> information from a PF driver.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V2:
>   - Corrected typos, and removed not supported ndo_set_vf* hooks
> 
> V1: https://lore.kernel.org/all/20241107121637.1117089-1-srasheed@marvell.com/

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

...

