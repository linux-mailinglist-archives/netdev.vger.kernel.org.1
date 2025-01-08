Return-Path: <netdev+bounces-156209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14032A0586C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1F81888BAF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7E1F8661;
	Wed,  8 Jan 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB1/DKmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786E38F82;
	Wed,  8 Jan 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332985; cv=none; b=UaXitMzrJR+EuLozHhZVDU3fsG5lf3ymI1rgGojyde4wSUm0FBZdXf/eQwn0fwwoI9wmO+I7RfUeX2Ec+5B6UdZltkdyxo2mrbfYNkYm0cawkQAWt/zU2FORSB+uGvjK7CsUD+AnKv35imT4O7wFlmGBvPAcD2nHxzPn4FU7Wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332985; c=relaxed/simple;
	bh=n3343TKglcR69VNYLWf8tkuZkakBn2fbH2AnMKXwHo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2p8uB9Nsjw6IDBAGQoroHcBmZslHxHfYrug3Sinh6inG1Kty0G61ftl1ZvmofHo2l9U9HMWmF/6Vfn/wEMBCaO94nxqnTwaKSGoj9qsQTLPevX2K0Vl7Z4TH9NWfkuJy47YOm9Cw3mkNn1pMk8+N1Ojdza4/cTTbuMl5Yc7chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB1/DKmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848E2C4CEDF;
	Wed,  8 Jan 2025 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736332983;
	bh=n3343TKglcR69VNYLWf8tkuZkakBn2fbH2AnMKXwHo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IB1/DKmc7Lla6vj23EIUBANC78ncAOyJzGq0vgUxn0n5N7rmJ3mVj0cqQ+niwza8S
	 BOn7dRoi8iOokvNHXCAnPnrWi6TAqjYPAQgCg1nBn/a6uj7Z7KfTN7x3cwMcaelrQm
	 B9NbmwxB47m48p5BU3w5AVLaZu8hD0/RTujxgVoccBpsdv08S2Jp9BxVqeW2EQlNOW
	 JXMvWEauF0dvA+58NDkJ6RJpHwg3qqFdpSRuM5E4OqOYSYWVZQAG/jw0beQkImpZew
	 nZ4t11AinlvzQ/HSuydupB9Bxv7pPYQwZCqN8TBwwbDl3OV/HHOZrrTGv/b0Us6G82
	 BqGfZ7BqCUSlw==
Date: Wed, 8 Jan 2025 10:42:59 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Justin Lai <justinlai0215@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] rtase: Fix a check for error in rtase_alloc_msix()
Message-ID: <20250108104259.GB7706@kernel.org>
References: <f2ecc88d-af13-4651-9820-7cc665230019@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ecc88d-af13-4651-9820-7cc665230019@stanley.mountain>

On Wed, Jan 08, 2025 at 12:15:53PM +0300, Dan Carpenter wrote:
> The pci_irq_vector() function never returns zero.  It returns negative
> error codes or a positive non-zero IRQ number.  Fix the error checking to
> test for negatives.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>



