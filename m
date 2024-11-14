Return-Path: <netdev+bounces-144996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59C9C8FD9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4185B2820EE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D817B500;
	Thu, 14 Nov 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bt1MfwmS"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B596166F25
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601921; cv=none; b=kk/AHHgOgEm3mE1nwkpL4inFZ3SHMCwDzJZkS2kqqs8zq3Nm7W8aoHi4QtC29S8SV/b66tgVyU/+ZLrJi1oJnRptsUGprzDk5ZzUbcXcE2nGj+YCcmQmFM/IzKz+yYvf4d3sDm4gW/vIaNiOMmctet3qU3aFAy1LJc+tOnqUnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601921; c=relaxed/simple;
	bh=IKS3bmOd44a6RC5WgGwK8Q039x8HkDeJIMgqsfsmBJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrqEUp3TUSDrdOhphu4xlEH28vn4XT48jXAl3Mt2nwKSPyXhqgJOKiKustBWkDqXMsVQYVT5JgkjkPtLhFJ3Uf0FJNhHKEA9ZKSCd4WYrSVlHFmaQ3X/K0lEr5hneC2I7NUppuSHlkaVsVojT7invgW8KVv4j+oddIFJnSW1ZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bt1MfwmS; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f6455a1-c4e3-4565-8f64-819cf5dca340@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXMmXM+7CbkyC1m7f735GVNn5/bfFpCZqMplZB8tKF4=;
	b=bt1MfwmSyOwR/6JH6lJp7dG+szURo5/Yxf2hVchJNVJsSOIbRS7ZcLjATavYI/u/jz0mfY
	v6ngmIRL57albHB6v+w3nXk7q8q1SyfsmO6PHcwzxXweQk8jfSCiza44vF4d8nsmDovHTy
	beUsCfCtg5shp3URiWfNWzejuXm5zc8=
Date: Thu, 14 Nov 2024 16:31:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 6/7] enic: Move enic resource adjustments to
 separate function
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-6-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-6-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Move the enic resource adjustments out of enic_set_intr_mode() and into
> its own function, enic_adjust_resources().
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Oh, that's nice clean up of resource management code, thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



