Return-Path: <netdev+bounces-98887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE448D2EE6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE6B1C22D07
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540F167D9F;
	Wed, 29 May 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bajK/+0p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF2167D9E;
	Wed, 29 May 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968977; cv=none; b=hqWKy3CABJYUdoGoKkvIUF6Ozaiv6YLogRmM5yXIW7Ax4qH5qPwQr/OmQgy9bHLrgaq4wvAyYm4S9G2UWYU3fG36aMbPphuJKlXpGPg5z/D5OyC9mzqOHtMzOlzv8z31oOuE0MIgHKaqzySi6gzUyWBLwPfFe+YG5n4l1f+Wv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968977; c=relaxed/simple;
	bh=iRrzuW5gl8yFeLhm9/8b6kcavTj407d0J1PCnAsKZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnkscamtuuTQ3IvBu8mzj7rtFu0jyfiLUo8/SkHXmvHZDqyEyVhj61BsIBYsd+sSF3Q13kiA12HJ2HD/balkHWENWxBcRMEqi8i3nM2kda15mZbOmxSqembV2GVbCTmWVbkdQkbER0RoHR6gq1j+LMiQpwXwlCfPeVoq05EC/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bajK/+0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8256C32781;
	Wed, 29 May 2024 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968977;
	bh=iRrzuW5gl8yFeLhm9/8b6kcavTj407d0J1PCnAsKZLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bajK/+0pKZEFnQX+bpQSYduuO5DzTagGCOA8RHpXVpaYsaGaj2+Gy6H8/2Z3L6OaD
	 g4qFhjncrOfd7K5tunnruic+NuvghBwdqwNd/tIFdvy9vmLr5UD3p5aMwG1+MJEyOA
	 l2LX+hMSMw/Gi7sLUrrx9ArW8GUbGK/sNE9zyllYaxHufK9NX8hr9Si1Dzj2JvJtcv
	 MnbMlmepd91w+yuwelRTNOmmDSbBTvt36XK1MabAPA7bWbHFdoxnKjEDxHviZvIWsg
	 N05TOqvhM0n6zuHWkQ/C3GQF282mRsmtj6bKrLAfbCNhtupU1w84tyeoBo2vgYd+j/
	 fB/CgVMpM/2TQ==
Date: Wed, 29 May 2024 09:49:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	pabeni@redhat.com, stgraber@stgraber.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: correctly iterate over the target netns in
 inet_dump_ifaddr()
Message-ID: <20240529-orchester-abklatsch-2d29bd940e89@brauner>
References: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>

On Tue, May 28, 2024 at 10:30:30PM +0200, Alexander Mikhalitsyn wrote:
> A recent change to inet_dump_ifaddr had the function incorrectly iterate
> over net rather than tgt_net, resulting in the data coming for the
> incorrect network namespace.
> 
> Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Closes: https://github.com/lxc/incus/issues/892
> Bisected-by: Stéphane Graber <stgraber@stgraber.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Stéphane Graber <stgraber@stgraber.org>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

