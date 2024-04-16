Return-Path: <netdev+bounces-88368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D88A6E58
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E871F2342F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D712CD91;
	Tue, 16 Apr 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt34q4aB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19D12BF14
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278009; cv=none; b=GJaM1kFCugeBBy3wXJG9gAaSBrBG8/lpLvR8biHGMhPfA5T03yoL4MjWa9c/dHxg6OIUBhFSt6hHPOoN/CtH1tHMR5jbZ+9nzd85wrBr7gWxbhJ0WsH12d9cyjsym1WOD/bLwJ0nbRjun1oRzXmCKmWf2xQ4AzdAVoN1goQynHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278009; c=relaxed/simple;
	bh=mhwbcjqLrz5XXdHAHG7RO7Vg4LmFPW8936lZlOYOXoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si49qaWbC6p2kGpqfeViZ+GzNiJhOZiGjKw4xv1dmf9E7odM+eJXTgl/Af7GylO3HK9pYXtm8O6Ie4SShK1Irmo1b6FfXqz8bR5B70FB67/c/iDHU1R7FsDSI7lSJ2xMLGG3NHgJcqNXgiL7FcUzX5ece+7CS/3cwHehA4bOwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt34q4aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE21FC2BD10;
	Tue, 16 Apr 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278009;
	bh=mhwbcjqLrz5XXdHAHG7RO7Vg4LmFPW8936lZlOYOXoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dt34q4aBcI5vx2JLLMv9oIAmJgt5ClnRjP6xTFUPPIq2QtMxGMoPvxtc7KtkbW4OE
	 r5ppMb1MaPd7mwmbc9CGyqBSKsegpqFlWCZgnzmPOag5KS/o3Uwlevfnj6A5OllSc6
	 EkUTkB5NNjSPVSV8b0KjoCRvAPyLV4I7Wy+T8pwnJSJ3ksdzrCM+rDNe1et2n58lR/
	 /KyPuyBlfx3osKRhuJzRSwQuLh1UU3sFaoVPCPiUOtj065zrfc+MPDWVLrGtiPhSw2
	 IfRpTuLqFUuKlfFORKOsIr9W89D1zYImFUjwP74gqPCT865YoSEWGxUlBWuDjsM7En
	 cFQdNSgVVXjvA==
Date: Tue, 16 Apr 2024 15:33:24 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Tim 'mithro' Ansell <me@mith.ro>
Subject: Re: [PATCH net 3/3] mlxsw: pci: Fix driver initialization with old
 firmware
Message-ID: <20240416143324.GP2320920@kernel.org>
References: <cover.1713262810.git.petrm@nvidia.com>
 <449181a5ed544dd4790ae4d650586436848007cd.1713262810.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449181a5ed544dd4790ae4d650586436848007cd.1713262810.git.petrm@nvidia.com>

On Tue, Apr 16, 2024 at 12:24:16PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver queries the Management Capabilities Mask (MCAM) register
> during initialization to understand if a new and deeper reset flow is
> supported.
> 
> However, not all firmware versions support this register, leading to the
> driver failing to load.
> 
> Fix by treating an error in the register query as an indication that the
> feature is not supported.
> 
> Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
> Reported-by: Tim 'mithro' Ansell <me@mith.ro>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


