Return-Path: <netdev+bounces-115109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF6945312
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DB81F23997
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E71465AB;
	Thu,  1 Aug 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sckkLcPN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B96149C5B;
	Thu,  1 Aug 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538654; cv=none; b=cDCojqCaCVXGAk3uQonDjtZ2tK8ytSdWHvaDREv981blSO/YxiDrVjFA4QOttL7vnGGVaUUUA1JU8Y9pGiklMLxHD/XG29Ul+Mpi3HTvs8hvY1MfRj9ajYTrBRRQgT3QLcApulRy2/D8gg6HxYMlytbldbauOzsXwkfEGHLprWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538654; c=relaxed/simple;
	bh=ESTm2u01Xsh4vYF2KoXB7xfioIZDNUAM2fpcoXzOAzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4HVqb8YPxbWW4VgalrsOgZkbgubqBj3xof9JNlulWTZXgZbzHUk+/EEJpDxnskggvBnOVKi5YTyzWyJV6+rX7uaeH2yLFq8UIqkgPuaO0dcJHzJmCXRkKUjrNvkra2WR7aM7b2lmjwh8bUhjOMGGfey/fWcK6jKOYS/rQ3KchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sckkLcPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1916DC32786;
	Thu,  1 Aug 2024 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722538654;
	bh=ESTm2u01Xsh4vYF2KoXB7xfioIZDNUAM2fpcoXzOAzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sckkLcPN/By5o/yXDmyXaqy9G6osCUgoHDsPhkHA2xC7Og/onDUB5C1o19bPnBVNY
	 y+Xidcnqg//p8O+Kt0ze8tn4t9Hck3WgOrzOKDpfbtyW17Y49X+DXQSMWkJdbIKEKu
	 PVjrV9RpphgQq6DoryMPY11/7+72ZPGuCyPoskg2Hw3JsPZBh4vnEiY7T3grFHCT7H
	 +sxtNoqqMUaHZP2ShTdzK8Zr3677cTxC5yIfmDXpr1i03H58bfmmFrcQ66EE6mAfXO
	 2VdXbdK5hVjY4OmfJShIJLaKDVmKrAeDBy6mcEs8hQZJlufqkJzDySgMSc5wkXiZbV
	 dOEjphWLB+gcw==
Date: Thu, 1 Aug 2024 19:57:29 +0100
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: vitesse: implement downshift in
 vsc73xx phys
Message-ID: <20240801185729.GB1967603@kernel.org>
References: <20240801050909.584460-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801050909.584460-1-paweldembicki@gmail.com>

On Thu, Aug 01, 2024 at 07:09:10AM +0200, Pawel Dembicki wrote:
> This commit implements downshift feature in vsc73xx family phys.
> 
> By default downshift was enabled with maximum tries.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> ---
> This patch came from net-next patch series[0] which was splitted.
> It's simplified as Russell King requested.
> 
> [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-10-paweldembicki@gmail.com/

Hi Pawel,

Unfortunately this patch does not appear to apply on top of net-next.
Please rebase and repost with Russell's tag.

-- 
pw-bot: cr

