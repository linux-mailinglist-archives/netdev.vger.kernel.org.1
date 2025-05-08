Return-Path: <netdev+bounces-189065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E835AB0347
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D763F4E41A9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7E287509;
	Thu,  8 May 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVQ9mllU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D332874F6
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730656; cv=none; b=rKLvsHH5hri23bi2Z2X8EHPXpY4FrLyVtVIqdQ/sU3s7Cmmb+hwsRZAc3EA8/1Rbbi6Rb87tNeEAVqA10GUiy10geKyJp5PgdNp8+OvIb/oz/t33yhPigD2J6+HkyASG9R5SVuorN6siYZADr5w64dauhE91sgLEOu3f9QkYGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730656; c=relaxed/simple;
	bh=mPxzEvpDQEZvOj4sJ+OIkyzRtmek8dJbjmoY0y7pUyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkvFwLU+sK37zS37+Ol/IINBnobPY1M3jRgDuxtiuv2d6c9AvkYwdr32Fvo/93A4PadwA55y/WW/NMPzowGYiZjZQ4RUY4gJvGZ38InogZqmiFkqhb/J3eZjpB+LnpC0MazrYa3eEO0kW84XMTzE2mCdCq0/bDc5jFvzoeoGJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVQ9mllU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD04C4CEE7;
	Thu,  8 May 2025 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746730655;
	bh=mPxzEvpDQEZvOj4sJ+OIkyzRtmek8dJbjmoY0y7pUyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVQ9mllUtAAV0ioTC012in7PRxqQZIpBCX93tgKpR47W5sKJ3gEiU74xLFqT6OUgF
	 RqqsfFUb8/LvXWfy7ZV4AulO/1GKn+LvTdLLebyIQFTG0agPvRTR3H2wcM15eI1YIv
	 wsAEE6u4wA27wSA7e87TAnlEhb+30hGvO5K2CdkOtVxgAmCCD1N2hwP9QVeyqbhXvh
	 c+CdEW3bkj/zNiTRjUqavI2UGSYHYn2sktAzu/iH+yDgoDLzF9NHnIO9f1G4eAKDVv
	 kOhe5ClUGOGqS8BMiTGORpoQhgte0AJ3dHI8d5rj+tpvCJuMnirixWb2vDJmFoZd/v
	 68Pfx5dmaVCNg==
Date: Thu, 8 May 2025 19:57:31 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf: Do not reallocate all ntuple filters
Message-ID: <20250508185731.GO3339421@horms.kernel.org>
References: <1746637976-10328-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746637976-10328-1-git-send-email-sbhatta@marvell.com>

On Wed, May 07, 2025 at 10:42:56PM +0530, Subbaraya Sundeep wrote:
> If ntuple filters count is modified followed by
> unicast filters count using devlink then the ntuple count
> set by user is ignored and all the ntuple filters are
> being reallocated. Fix this by storing the ntuple count
> set by user using devlink.
> 
> Fixes: 39c469188b6d ("octeontx2-pf: Add ucast filter count configurability via devlink.")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Hi Subbaraya,

I am wondering if this is more of a but fix or more of a cleanup.

If it is a bug then I think an explanation of how it manifests is
warranted, and the patch should be targeted at net. If not, the Fixes tag
should be dropped, and the patch should be targeted at net-next.

...

