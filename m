Return-Path: <netdev+bounces-144995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C889C8FD8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1E283719
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E019993D;
	Thu, 14 Nov 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fCshlLjo"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF418D642
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601805; cv=none; b=Ny8TqEE7x8a9Db0gyI93hbREaxvsV8LP0bR7XdT4a5zwIj8zGq/pr/ix6zYTpdriv+3nVnjMj3ja0x5tz8/5shz15PJ8xz0TEhQHvpU3hBWB93XDGk3mVBcjCw2xfr+P9CFByw/5SwYEmSPmPiJLcgOnOSIVwv/d0M6X3p0UyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601805; c=relaxed/simple;
	bh=ObP0AXaJyyTXd8EoLLmhVvWFbfu8qzFlNNmiMR9vngM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVDnVHFYDkGpn099aC5/TbSj1Xk9A5V4GqMvz1PJzAGdI0l+AcdMUUIXCJ8CHAXDAqzEFgH6JzVDkE3Pw6w+CJ3OykzKq/f/jEegVWdkqZU/VWjh8ICYlKiSYpvqIpNaVkaEqjOr6etMCqEeH22+wXlOMkK/pUiy+KNGeZxS04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fCshlLjo; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <432d0d80-59f8-4dc4-a55b-5ec9e2222728@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlF4X+K60k5JAu3T6QASjp/2MwDrnEXjvnmcroVS47A=;
	b=fCshlLjoHnGasBwXGbZWXetjfCV9JMMy5fuHc+bZADnNSnHmiWBB32JieNSJn9r63c4E6y
	89ygQZSeXJf3rmV/YQ9Jr/ybRLUzO/FXxGiNiej+0IT9kPHOYNwYurPYAUO8xdZ6vDbyHt
	nY5+VrMWcXnz+CQbddgNgPP6uTndmKo=
Date: Thu, 14 Nov 2024 16:29:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 5/7] enic: Adjust used MSI-X
 wq/rq/cq/interrupt resources in a more robust way
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-5-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-5-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Instead of failing to use MSI-X if resources aren't configured exactly
> right, use the resources we do have.  Since we could start using large
> numbers of rq resources, we do limit the rq count to what
> netif_get_num_default_rss_queues() recommends.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



