Return-Path: <netdev+bounces-87399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A588A2FB7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E55285D37
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCD84055;
	Fri, 12 Apr 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVr8x489"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EEF1DFD9
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929433; cv=none; b=GFuO/C7pb7PQ9kY4VVJnNNLHytOFI5c4NakB5hyUCVqlaod2192QYSsrd11NkNZeCvAw0iYi9f+Dow5bp2IdDLFpwkte4rTHzCJtc/ZGGhYxU6IqTEmeXCxk80GbqTPrPemytnbCrgojPP8RM5UtdUS1yHOxFRy9vyNx6sSiVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929433; c=relaxed/simple;
	bh=dF3eJ7YSdc3pkfuCWFFSxSO1ufS/WVDvVIDW12VPJks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftOgzLAAxSCU10sb22OWWuk1K46FgP3dHM2izK7Ra2j/ls6/dusltoWnhmCelBlF2KLVS/8bNdgHMyPoOytYxNog/cUg7rONI0qtjxwuko6KebMOdGOXMQZtEOaFXn/2GhkGA0hPy7QzC2zxjtLoVc+95JBFq+nMghJySGdppW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVr8x489; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B3C113CC;
	Fri, 12 Apr 2024 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929432;
	bh=dF3eJ7YSdc3pkfuCWFFSxSO1ufS/WVDvVIDW12VPJks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVr8x489yiDCrpT83Y5EVsOEWx0CDRIWJ8nAPpt9u5sLIm5TxBqxfXPGCY1djuj/q
	 YC1k/DoAI2eknNOquKagA8Kq67cl8I+jCoZzfdLdDSrctJieChdAnWHJTP6Qpn7o/D
	 P4t598Ht0lKLu8ZfOKlxXnukTGG5xXhFLSn3p/RclXgB3tTaJ6/1xUCq66JANKp/Vn
	 5ANg+rRAicxrbx+RtGeIaO7hHGv1LT68BMYS8Oe16OR+Ro4bX9cRqao6iZQ6e2eY8M
	 43GkGCR2yvkgt83x4bLhXjpnLn8F+KM4WK21BMrpJOU+RXHWnUO2tnnAJlCs58ShMb
	 xLaCKc7gsoyAg==
Date: Fri, 12 Apr 2024 14:42:17 +0100
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH ipsec] xfrm: fix possible derferencing in error path
Message-ID: <20240412134217.GR514426@kernel.org>
References: <2a5c46f3ae893a13a9da7176b3d67f3439d9ce1c.1712769898.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5c46f3ae893a13a9da7176b3d67f3439d9ce1c.1712769898.git.antony.antony@secunet.com>

On Wed, Apr 10, 2024 at 07:27:12PM +0200, Antony Antony wrote:
> Fix derferencing pointer when xfrm_policy_lookup_bytype returns an
>  error.
> 
> Fixes: 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/f6ef0d0d-96de-4e01-9dc3-c1b3a6338653@moroto.mountain/
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Reviewed-by: Simon Horman <horms@kernel.org>


