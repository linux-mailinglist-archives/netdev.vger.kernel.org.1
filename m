Return-Path: <netdev+bounces-192666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78467AC0BFF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7F050123C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850228BA81;
	Thu, 22 May 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faF+67+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4928B7ED
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918279; cv=none; b=Og87xUXO9MkoPGKFLwq7tLQE30qvuCDcB7ry1FBRKIjbOzg4WRDBsjpyrs4gY/zoD95Jht1v3UiTE+1ngfORkvoDgwAaKISF5XraQfQ9sFENxf6UzQVU7+gymIZE+zAXsfgIT1XG/TF8Oj71Ht5XNo0aTTpUVoQg34I3owhaQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918279; c=relaxed/simple;
	bh=CROuMDdYdYryj+aokFS31eCQQs9M+xXZOuUVFeEr3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5GEPZ4yf4pYF5h39QCAz2MT5l3om0ZBC9yrKCJOXgc9OmTlnz4wZ07IJ7cTBCuleQsdaBIpTd0Gr/rppAOObRxRYrGrQLRZBMFHSjjk5h9u4q+0Gp06I1BCm/TYUv8qdzKEc+DOy5W9dBzEg/A8XRQkZk5eIZB7q6NeYB9rE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faF+67+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF2FC4CEEB;
	Thu, 22 May 2025 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747918279;
	bh=CROuMDdYdYryj+aokFS31eCQQs9M+xXZOuUVFeEr3cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faF+67+rxvSWj/jdBzBKoaF7/Jhjns+SXNSM2clToGRGVwvqsxtEhQPG0AvZUuBre
	 4F4c0sKWSaOeVKpagwVGwLdQapHRwxYCikLZogcWb/izUni4yTuImWZCWiHGEqJj0o
	 Kp8yiy0G8QdxttIcjmjZRhlcwb243AobNDH5kyXWkbVaN/Ku5PGczDOkLQYfa10rXN
	 Ndd2tjSKzrLcUw9O3nbPWvXRbYFg+RQK3OJ7h5090pwb1ybps46DD5QFgxRvEnPt5e
	 +xUD8FxYLmxj2huQuOJKWEr5SOmp1Q+kM7BtlfwW0RbIdTOEjHLVPrxZFoRV+z19f9
	 TNFRr4xrMuLAw==
Date: Thu, 22 May 2025 13:51:14 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net PATCH v3] octeontx2-af: Send Link events one by one
Message-ID: <20250522125114.GA365796@horms.kernel.org>
References: <1747823443-404-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747823443-404-1-git-send-email-sbhatta@marvell.com>

On Wed, May 21, 2025 at 04:00:43PM +0530, Subbaraya Sundeep wrote:
> Send link events one after another otherwise new message
> is overwriting the message which is being processed by PF.
> 
> Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>  Modifid to wait for response at other places mcs_notify_pfvf
>  and rvu_rep_up_notify as suggested by Simon Hormon and Michal Swiatkowski.
> v2:
>  No changes. Added subject prefix net.

Reviewed-by: Simon Horman <horms@kernel.org>


