Return-Path: <netdev+bounces-96973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5698C8821
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B964C287F0A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97A1F93E;
	Fri, 17 May 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvafHAPk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DC384
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956445; cv=none; b=pWVCnU5IkVDDJXuv5PhRPik5UdwEj7iqXQsOPF9Usegk1BIJZmP9NCyV1JGOHujNEquDtY2aY/vo/fqvhq9MRZb9SLQN4anCMo4m3SliP3s5edJ8ACoJsc/hQfxA/++r+y/nSCVHKXszaOmFEYXzaAE1tz8jTwnTT08EIKu/6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956445; c=relaxed/simple;
	bh=01a5MXQ4SUek3WkrUjvzadT22IhxlkGIlSc4PkC0Tic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3xL8vfS4K255AqYgi5/GPjaXwS+vzde5dW2ziuj1eTMe/T49z7KuNc6z7IbWNMS3xSUPAFA67T+/x7Ir+3yEcAXyBmWn1ZXT0QffVYfaDvndzDc6Dbjg3Dxgt7oXvpvOFEP7qM+/KAyDIQRMZ9Idu7uKEQICsMnuCtu44ZOjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvafHAPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB36DC32789;
	Fri, 17 May 2024 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715956444;
	bh=01a5MXQ4SUek3WkrUjvzadT22IhxlkGIlSc4PkC0Tic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvafHAPkPxN5ZS6PukxwXlf8KA9z9qwLVusAmiqphV8jkuocQFOoupvsy1JdzvpGT
	 y2GsotbyXBDdsCj79SEyMnuk6OQq63KyyH3X5Bfjm/J5gTFRJZ2VRdgJFxlAg8+rpB
	 9S+uxk2tZAvgBQADu9SLqc1jVdRFt2wybWXvXpoU+Igs/uEIRKZh8j0L7lUFT1WDbp
	 puHCrJZu9/PLg5aOD9eTvOPk5b7q0CZZRf4Y/9cmIfEOBUZRkNnpmff193QSzRZxWo
	 xP9XQjiFBqD8CRc4zH8l95cUGF8RNWVe68jiUYR6FFFgRXbhH5i+QH+ZdlfuYxPa7P
	 AupTbkD2FR54g==
Date: Fri, 17 May 2024 15:34:00 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] ipv6: sr: fix memleak in seg6_hmac_init_algo
Message-ID: <20240517143400.GF443576@kernel.org>
References: <20240517005435.2600277-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517005435.2600277-1-liuhangbin@gmail.com>

On Fri, May 17, 2024 at 08:54:35AM +0800, Hangbin Liu wrote:
> seg6_hmac_init_algo returns without cleaning up the previous allocations
> if one fails, so it's going to leak all that memory and the crypto tfms.
> 
> Update seg6_hmac_exit to only free the memory when allocated, so we can
> reuse the code directly.
> 
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Closes: https://lore.kernel.org/netdev/Zj3bh-gE7eT6V6aH@hog/
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks,

I agree that this was leaking resources, and that after the updates to
seg6_hmac_exit included in this patch it can be used to unwind partial
initialisation in seg6_hmac_init_algo().

Reviewed-by: Simon Horman <horms@kernel.org>


