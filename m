Return-Path: <netdev+bounces-192825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E6DAC1517
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BF63B4A4F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E929AAE5;
	Thu, 22 May 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c628loJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E261E7C2D;
	Thu, 22 May 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943669; cv=none; b=CJXghSO2bdVl2YhBqkVMZHNs54mZaMsU/pG6eJpfJm/0/mO7p0RmswRsKD4aqM4UJ9ndkEhbzxA0Evdz4hfy7QAO68lMPuRF6kWuCEjB8ecP7GLZ07MwGbtay7US0JuyQXjWBhZ31jUnSVGmNOSSTS6CgnOnpPY2yk7uiiO8yBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943669; c=relaxed/simple;
	bh=jE7aWTubWuL4OocYR+UjHDF6yquzclFCXFwXH1jpYDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR2F7WmLT3lqC6+qhu6dWAIUiklvQK3lbyeVR4y8t31csvO5FnQGF2IMR7qOHQgq3Sa0bwTWGTjLOZa8lwlVNZBMV24qnCEAjDDoGsPX+m7ypzz0YG7pLLKuj42dUN8108kpbn04gfEvDXgcDwtyFb+abN2Lnny/lw07le0Lr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c628loJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9BBC4CEE4;
	Thu, 22 May 2025 19:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747943669;
	bh=jE7aWTubWuL4OocYR+UjHDF6yquzclFCXFwXH1jpYDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c628loJJr//eIGr1L0uU8/lULP3/wQwlf//1KgrVWLbe+3XRGpqwj/Uwaa3AVOIFw
	 hmbUbdxfR4fasCM5pH7H/+IH+hOK6OfhNN51GqfeikaZNHFOHnNzEnukNbXsIDiIlK
	 d6uaWnbAHllxHaW/TQHnd6RKH4Gq4aDmek0Bu5FUnNQCOAz2l/JwLrs9TNF3SGwmv7
	 uJMkz+R+ZqouyktX4wwYejidFWduTryYcuP4c8WVqYTtWZ9p8ceriw6QiaaTlwfbHa
	 3Tx4K9Us7BeFmit78gBhD/XPevLK5f01Fuz0NvV8erfvFDdHAmkpLRLn+2d0+PSpqB
	 1TnPVRZN2X+WA==
Date: Thu, 22 May 2025 20:54:24 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [net Patch v2] octeontx2-pf: QOS: Perform cache sync on send
 queue teardown
Message-ID: <20250522195424.GM365796@horms.kernel.org>
References: <20250522094742.1498295-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522094742.1498295-1-hkelam@marvell.com>

On Thu, May 22, 2025 at 03:17:41PM +0530, Hariprasad Kelam wrote:
> QOS is designed to create a new send queue whenever  a class
> is created, ensuring proper shaping and scheduling. However,
> when multiple send queues are created and deleted in a loop,
> SMMU errors are observed.
> 
> This patch addresses the issue by performing an data cache sync
> during the teardown of QOS send queues.
> 
> Fixes: ab6dddd2a669 ("octeontx2-pf: qos send queues management")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> v2: Push the change to net

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


