Return-Path: <netdev+bounces-191158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CDDABA497
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D91BA2B9B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581227FD44;
	Fri, 16 May 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDMK3I8b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC727EC9A;
	Fri, 16 May 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426613; cv=none; b=hO58BjzZrobL8PthOMYduA/ZJuI7I0Niw3GGIttGCGbNw86WC/HUb95RU0MrRVRkU2Fe8DY+U2bugHUR0/UCJThB1DqWWFU4o734z6LVJ7vpmK0/W6BP4UUxT5IjQQq1bAxD4LXinCRDZfSjWT1IlzTdtyy9CH0V3Lp/yn2e8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426613; c=relaxed/simple;
	bh=qFF0calRyniBymu6pWsXocIvfCO34tQjr8bYALVmbiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/95dYemKqGpQuqIDmLRjuySNH2eCL6mQNlT1fSp6uHTg8hJtYAgllK4pMbN4RynQkwLMqQtR7of3pYV1FlVYCJTN9XnbjPNJLH9Nmq6nJWm4vmd/fAYdVxljerVs9bEa4Sk2MlQgo4PrWa9LU3pTG9+3WDM6i3+1nUG3qqCiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDMK3I8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE39CC4CEEF;
	Fri, 16 May 2025 20:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426613;
	bh=qFF0calRyniBymu6pWsXocIvfCO34tQjr8bYALVmbiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDMK3I8boQcEejsRxDXJqTCEi6T4NZujXSDb8t9AIK+MZRlbYhD3Q3i0JcvQ2i9a4
	 HQdPz0NUy9EfbG6BkA+/E8iuD0Du+Oz4UVjW1LAGNO7+H/aWiQulL1g5wLh4fZZHo0
	 U8sF3hxac5XF5SjsZ68pT4NAxk9COp/6sDC7XSrUJy1RDfSKH6MA59HND6URRtXfCn
	 hXLyjzc0kVoUK7bQSz1z98GhrIOYaLQlijZUuiApAoY/ltvuq+pwFumQNFUFr4g0DS
	 9GSVbeznufmWECsVbsIMFTd6Id0XqMOe+M3VHbsB4a1FTInVFGc+pPvWrRCQPdfkW3
	 oQV/mFrSP6Cag==
Date: Fri, 16 May 2025 21:16:48 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: airoha: Use dev_err_probe()
Message-ID: <20250516201648.GJ3339421@horms.kernel.org>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <bb64aa1ea0205329c377ad32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb64aa1ea0205329c377ad32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>

On Thu, May 15, 2025 at 09:59:38PM +0200, Christophe JAILLET wrote:
> Use dev_err_probe() to slightly simplify the code.
> It is less verbose, more informational and makes error logging more
> consistent in the probe.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


