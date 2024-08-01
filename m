Return-Path: <netdev+bounces-115108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59894530B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A69D284F97
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481014A0A3;
	Thu,  1 Aug 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf5A9C1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC9149C5B;
	Thu,  1 Aug 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538484; cv=none; b=i752c7+Asvz7IlqJGM0jAzI+gOip6CbV4VYMOOCVHsMTUQvL+Yd4VBjteqY6ZgUE61KGEIcdqvqsvc8379WL+6j6zTafsKpuw1LBRkhrrYrhcH7IWDH2xTFrNML1+Vkc+gzTKa1xqxaMAU/ulXw0C4H1MT1+bSpjBPSVY7QH1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538484; c=relaxed/simple;
	bh=UK49MbLUbLnrieCuVSTPNVycuS+pxFT9xdjPPKMEcl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKMxoozDDdLfoUJ9CoI44TN7gHUhofN+OyFh7oS1tdJ6kwBHGt6vYj08Yd+fPnbXoBsdS6Knl3Yld9n6arVYJd3pWW/YFEj6rB3+CQjQdo8gdR8oOFW6dGiGX/EnGElG/otPbqRWKdEpGPjJ6fnyFYomS+vFfiAWUxyPFtYFxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf5A9C1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD5CC4AF0C;
	Thu,  1 Aug 2024 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722538484;
	bh=UK49MbLUbLnrieCuVSTPNVycuS+pxFT9xdjPPKMEcl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mf5A9C1IHVR7nkQv0FpoHU/q22xk639/6LITRgfFdiyz574cQd9p5edWE2CcAsJGS
	 EL0RtYlz8+CWbidcXxXCtMAAxZhr5McK15teR865sI7USVvf2U7fPIoMZhbUJzsbY0
	 tLjt7Ib9Iw/hEt0ICzm0Ihxc5TDLXdpkeHqi58AVbK+/gZi+wjM/LJkjv/24EmXvdS
	 ChMhz0lA/xvJyAepVQGW3eXdTbBguFFViJorFpDcOsbq+3MvMBhm+6WIL9K3B13g+8
	 pW3Q6cFH+mIkk91F/T6dplLwpTt8qrQ12PfXQJ2DZlh2aP1kemFE323N0pH28VP08l
	 UcLyeY828vU5g==
Date: Thu, 1 Aug 2024 19:54:39 +0100
From: Simon Horman <horms@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Shigeru Yoshida <syoshida@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net-sysfs: check device is present when showing
 duplex
Message-ID: <20240801185439.GA1967603@kernel.org>
References: <52e9404d1ef3b11b1b5675b20242d3dc98a3e4bb.1722478820.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e9404d1ef3b11b1b5675b20242d3dc98a3e4bb.1722478820.git.jamie.bainbridge@gmail.com>

On Thu, Aug 01, 2024 at 12:22:50PM +1000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal, attempting to
> read device state when the device is not actuall present.

nit: actually

     Flagged by checkpatch.pl --codespell

...

