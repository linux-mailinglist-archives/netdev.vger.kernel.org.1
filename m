Return-Path: <netdev+bounces-70167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8484DE96
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4487B1F21BFC
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9D6A8A1;
	Thu,  8 Feb 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9199IHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D56A335
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389226; cv=none; b=GZG+WzgQ9tETW/+eopW7N5dG83EKeJM9HM9ywd4shS/FhV1Sfso88Kgum3jHjPY6aeEA8UgcgkaM0gbhJp1o4yqVHU5978ts84CmaxVqa6CGdUzlIjnlZRYujjLBUhdxnKw+sK70a9CrxjoremNFHhkgMKTHQa+CWggjqnMXAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389226; c=relaxed/simple;
	bh=sPqmIJG0j0Uvrtvc2UIvS8rx1hAClYJBsgbyABemMpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYGMu3clLpEb3+q5XTDA4kYW2lvu0cMBrcXgGKLdej1abRpSGVzNxPRTI/5aLmivQPeKnWh+rEiajlSkIiTOMR4gabV3VT7tJcSY2mFBTWKbapWHk4yrhYO0ks/9DfsnGe8TrZSUYkZN93kHfu58+TlRF+poQkgoGnolNVliTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9199IHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8277C433F1;
	Thu,  8 Feb 2024 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707389225;
	bh=sPqmIJG0j0Uvrtvc2UIvS8rx1hAClYJBsgbyABemMpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9199IHza2HfLtJsyzAbJ18admPXPU3144BdmYC+e/ReX9WePUpmSYTjcuFbQuIjC
	 3hVYZURLW3bZARH1YuG6vCmxGNtH5ucIoZ+q02Mr2ENTTt2aCbK+oP0LZfYcZ69XwL
	 3gTLpKPLvo37O7k5ERr1PBtFHgwer4ptn4flr9kWQfXxmjkwCWuWqprhy7sm+8/zGH
	 8wIgej8BYwDHBsJePSMPe5dbvlbc59Uq5qmjlY2v/6yip0dQmdcXCQ5Ud4IAyA7gI8
	 RXSOGB8AxJwx1WnuyWa4EqEF1nBRVVui7TaFWFqZLaen3c0ztBCtAJUGrIxUvCp+ob
	 v42RS4V8GEGHw==
Date: Thu, 8 Feb 2024 10:47:00 +0000
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@lunn.ch, vigneshr@ti.com, jan.kiszka@siemens.com,
	dan.carpenter@linaro.org, robh@kernel.org, grygorii.strashko@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup
 calls in emac_ndo_stop()
Message-ID: <20240208104700.GF1435458@kernel.org>
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206152052.98217-1-diogo.ivo@siemens.com>

On Tue, Feb 06, 2024 at 03:20:51PM +0000, Diogo Ivo wrote:
> Remove the duplicate calls to prueth_emac_stop() and
> prueth_cleanup_tx_chns() in emac_ndo_stop().
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Hi Doigo,

I see that there are indeed duplicate calls,
but I do wonder if this is a cleanup rather than a bug:
is there a user-visible problem that this addresses?

If so, I think it would be good to spell this out in the commit message.

...

