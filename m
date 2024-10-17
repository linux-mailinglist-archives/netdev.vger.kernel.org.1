Return-Path: <netdev+bounces-136481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49129A1EC7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893A6281C86
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E941D959E;
	Thu, 17 Oct 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RunjBtwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221931D2B0F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158412; cv=none; b=lVS7xoDnjKM7ry7UEqoi3yLEJIEtqOObmS8/In4gb0WEJSZ6ZXhyV+rej4ev1FmGsMzKlHq1oPa165ObpN8QqUSCeHI2ax/wlUbhehrvvCoNvA/4geKkvPqKjhbamfS51NMIMFVQM1p8HT8tR3A6BgC/7QW9sO+2DkzwLY4rY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158412; c=relaxed/simple;
	bh=1l8hI66BGVLNc+0kzZVbfU84Dxmxiv7JAX14gknBPXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2MgVW7toGrS5mkGXrrTPJAxBk7ac4AeiClpaD2bzcPGcmKOiHQihd1BJ5KfeA2PWpnmxpOlHwXtjFEiRqGjZKeCAWDOY2GJ0DGlYfqengWip8exehfxbwKC/Vv3u3vxdhIQ3A1D+Mer8cHU42dqt7mkEvqZ9GRLe4i6tFRLMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RunjBtwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEEC4CEC3;
	Thu, 17 Oct 2024 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158411;
	bh=1l8hI66BGVLNc+0kzZVbfU84Dxmxiv7JAX14gknBPXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RunjBtwWZFKjU4cpcc9GYOC/09k2DNOxKoHJD9jCr9kEz41PwnOYc7wOlRddVBdCx
	 ZkEpiCBJBp/TPoZeGvh4TRChbDhbJ3SY1l1Nk5UXutK7Z7/Vl10OgiJYa0usulGww/
	 HBJa35cgjuxF7JnpBmKODqbs6gvX9jleRHUlUj1i66zLu8Y4ZKfQamUtvWLfAobyZg
	 6k68fpLag9s7qlWUBFxg2SoOhz2f5tmiZk83nsH6Swd2QdsNKCJaQbZBvSZ3DNkGK2
	 3MSB6Yj4GnB2DA6QgNtOAey5zGazu6J38FLX9akjiiUiuFVHBECkSiAkag2AZvvLXA
	 Vmk2qS+nUqvrg==
Date: Thu, 17 Oct 2024 10:46:48 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-next v9 3/7] ixgbe: Add link management support for
 E610 device
Message-ID: <20241017094648.GB1697@kernel.org>
References: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
 <20241003141650.16524-4-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141650.16524-4-piotr.kwapulinski@intel.com>

On Thu, Oct 03, 2024 at 04:16:46PM +0200, Piotr Kwapulinski wrote:
> Add low level link management support for E610 device. Link management
> operations are handled via the Admin Command Interface. Add the following
> link management operations:
> - get link capabilities
> - set up link
> - get media type
> - get link status, link status events
> - link power management
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


