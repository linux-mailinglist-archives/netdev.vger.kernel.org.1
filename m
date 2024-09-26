Return-Path: <netdev+bounces-129964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783D987382
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 14:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750E11C22686
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E73177992;
	Thu, 26 Sep 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRoqJKeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76914B94F;
	Thu, 26 Sep 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353510; cv=none; b=ltZjDO+P1RMsJ23tkdCXkEV2jK6qJ1gDglYW3OE7dCllRfpEB1P6uWBMehTCAawmDSopp9jz5Q80bAOgkMMeWQ4D+kbEC/CzYvU5wg9KodxyHfP3rifEwBYVal0OL4VZxjHMpFTffevsmc3XWnnzIQNFlVx1FelBQxQReCBJFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353510; c=relaxed/simple;
	bh=FnqH38wRAkVp3EZR3XksgSm/cQELxvlbKSkl27m+g20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrI0NnIqohl5V5jJwyEHcjK/BmOic3dA8Xin8vEVFFWBDesgpNc/rSUzpXVCOYHDxVxFWiN1UAhhS9B8cCQtPZFSHe9X8pWDEQvY3/Gu0IQfhGrd3WpPVL7/4CIHEhUQk9DtjMlR64ade4499xMCG++IvRIFYfMKPjqCMnNPeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRoqJKeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596EC4CEC5;
	Thu, 26 Sep 2024 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727353509;
	bh=FnqH38wRAkVp3EZR3XksgSm/cQELxvlbKSkl27m+g20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRoqJKeqZQKGjYxZGqI+vXuvVmUsFs/uWMQSD4pgi6db0n9u2XseKMBWB3qcwNAZ0
	 iY8Eb+72VLdlsYSNbPPS5pMY3Wfh35+MU0bdqVN3njTHi22TYwn4dh/BXpWiykq6++
	 39z6hC8sayZlfcdcD+ZkA10oYlBXGIKSGDnGxk16N1K67PXTvRcIAII0f/BVdP/1Bh
	 Ew3kiL9yFjLwbKm7jxOFf+9/Q9IQ+1Vr0ZMkCOBUAoXXy5J38VGsUHTr9wocW8rQCA
	 1USiosNVW9COTIIARgdc+VKRPCEvl0eWAIWsf+Yy+oxan9YmABPyoG1Xb2DQslMS/F
	 VL/abInkJlKxA==
Message-ID: <e314597a-a779-473d-a406-b233efad2e23@kernel.org>
Date: Thu, 26 Sep 2024 15:25:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Julien Panis <jpanis@baylibre.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/09/2024 12:50, Dan Carpenter wrote:
> This error handling has a typo.  It should i++ instead of i--.  In the
> original code the error handling will loop until it crashes.
> 
> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

