Return-Path: <netdev+bounces-191035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590BAB9CC7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62312A0195A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433D24168A;
	Fri, 16 May 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1+TY3+2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCD24167F;
	Fri, 16 May 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400270; cv=none; b=lBAp64iHRIAZFRXhdlKIPSynBcZXRnbWtnwz+9+j9G2jxEzaYzuMypEeQipiJs5i1ejECpaNr7dRF2FZ2+uDxmEU5oDFbfr2Jczgz9IIMlxS2iR+ckEqAGTGZIy6YG35Byi37l8e1eJgkKa/QQRoGS3hzGfpxNcLmiS2FDRox7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400270; c=relaxed/simple;
	bh=CDLNoimx0vQw/PJHszEc6cc1jXi/roULCzRSmz61Cd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFhz/ywNMl07SlVFKF+ocl2HhuZP5qyX3tJ/b+Crj7oLbZoDxJ/t62PpygDM1GVz2W+1Jc2umDNuTEXlFiVmJDqiQNeybJs1wLe3/8HfhQRq+FQzRHwuVXwp53qeQxujzDN7KwldIfHYqc8+Nn/44H8pDBkrB0jtuC/GmK4e6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1+TY3+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5413C4CEE4;
	Fri, 16 May 2025 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747400269;
	bh=CDLNoimx0vQw/PJHszEc6cc1jXi/roULCzRSmz61Cd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1+TY3+2gaXVqmWEukihQjznIEvGIVbeSarhOyMbn6u3iYhIcfMU1R9TJmOpws15z
	 iA0rRV3OiEZO1KI/HGdCGUxuIGjMvy7VNw8Y0sT8z6GapsTFhbLmd/60eUD7YNNV2T
	 l55mUrB1h6wEpYqYVUASv/4jjA1NVFol2pRIZm7WMjhcdZvWnPI44gou1kuSQC07Gf
	 lQLG5NNnqLfOJELl0eF45Iyk7/4x3KaU7qwloDpIpS86oJiROkln2/g7wB1TjpjXPN
	 EmjnFFJcz5ytMLMNajtrpWZ3O7Gh9EJG8SuXnQw9tL7J5F3EbL6IX0Qo24apX2l5EF
	 EKBM7mOy/LfYQ==
Date: Fri, 16 May 2025 13:57:45 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 3/4] net: selftests: add checksum mode
 support and SW checksum handling
Message-ID: <20250516125745.GE3339421@horms.kernel.org>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
 <20250515083100.2653102-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515083100.2653102-4-o.rempel@pengutronix.de>

On Thu, May 15, 2025 at 10:30:59AM +0200, Oleksij Rempel wrote:
> Introduce `enum net_test_checksum_mode` to support both CHECKSUM_COMPLETE
> and CHECKSUM_PARTIAL modes in selftest packet generation.
> 
> Add helpers to calculate and apply software checksums for TCP/UDP in
> CHECKSUM_COMPLETE mode, and refactor checksum handling into a dedicated
> function `net_test_set_checksum()`.
> 
> Update PHY loopback tests to use CHECKSUM_COMPLETE by default to avoid
> hardware offload dependencies and improve reliability.
> 
> Also rename loopback test names to clarify checksum type and transport.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


