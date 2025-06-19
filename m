Return-Path: <netdev+bounces-199401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD53AE0284
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DD31BC4C30
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E6221FC1;
	Thu, 19 Jun 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfABfO1X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBE2045B1;
	Thu, 19 Jun 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328374; cv=none; b=axbEcMFtzmtgk+HrO83S0V6lvO/sggNeDr8nrNDg2HHaQ4razeTWuYJgN6W5Shelbgj3rZeYKtYw2Re5G1IgvFYm0YU3JzK5pV7MFmhwO62HW67pA1chaJsbEwziuc0R8be43lIM1IdP3BOJPUJYO9HSWQu5+mTpIUYZz3T9GYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328374; c=relaxed/simple;
	bh=TFp8r10SI9qs2FkfzjhWNknAgkyWJ+OG/4m+bbmfhzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6GpdS6sB7qsD2qgmHr/4xXt3UdpO25YN10iPC9u/DXuUD1IQTRI4UpKAhF4qjrxv9Lj5dFJvojCuZ/Lf8wxsU4vrXvkqidVXpmKFoT/DGz4tRbcJgjKJ84cfex95qN9puL33QoSVg1Ss/E59noLV9ShIdq8qXX+gLDUfW/uLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfABfO1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FBCC4CEEA;
	Thu, 19 Jun 2025 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328373;
	bh=TFp8r10SI9qs2FkfzjhWNknAgkyWJ+OG/4m+bbmfhzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfABfO1XIqtf7KGj/5ngqcFzZKbitq+SeZIVFHF2gZUGBoyNcNayUNwFQMm5x04IX
	 +Ii+ev4k0tjABdat5ReX41nuK7u7thzwEjcS5a7I49OrseK1ztIRmJUTn/NVR467yG
	 kUPS75ydQ7srPjtgNFvFtw0yR9+7X4MaN1spsNgLVqIkLDJZJEgEtQz8xlbT12DDPY
	 2hwuxd69bb1wDs9vLdAHADsYJlqa/qS1nP47T9f77eT8MdrEdZsC1oxjLMdG/kIpUR
	 ojXC3nTupjkK/rY7qxt+lCg+Vm4qnob1nZsXdwm3aL/24Zuo08RpghdmPkr5rt54d9
	 e4pLtUqQgCj7Q==
Date: Thu, 19 Jun 2025 11:19:29 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	jv@jvosburgh.ne, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH 2/3] netpoll: extract IPv4 address retrieval into helper
 function
Message-ID: <20250619101929.GF1699@horms.kernel.org>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
 <20250618-netpoll_ip_ref-v1-2-c2ac00fe558f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-netpoll_ip_ref-v1-2-c2ac00fe558f@debian.org>

On Wed, Jun 18, 2025 at 02:32:46AM -0700, Breno Leitao wrote:
> Move the IPv4 address retrieval logic from netpoll_setup() into a
> separate netpoll_take_ipv4() function to improve code organization
> and readability. This change consolidates the IPv4-specific logic
> and error handling into a dedicated function while maintaining
> the same functionality.
> 
> No functional changes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


