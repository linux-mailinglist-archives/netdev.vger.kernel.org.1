Return-Path: <netdev+bounces-170793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391CA49EC1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29A2173DBB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2126FD9F;
	Fri, 28 Feb 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuP/mmEf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936726A0DB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760094; cv=none; b=sJIMdQRXL8SnVR1WVjvF9knTTYLRUVoF5rDcKfFsdzlIadaF72X4dQsSJDweMyS+QxnjTOGDr8nzLCz/hPLDaXQUTznA3xu00d2gwCpINEMa+/w8qsaKL1yHPPLutPaknfFk93UwuXPWRMOZmP22Mvgg8HmBvYenj1zNWyKZvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760094; c=relaxed/simple;
	bh=rNH+Y236VT+IG+O9V1w36N5rgSkIJ8RhfYYGa1KcAXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6EkHK6+imudGPcoV55j8oyEEnPpyBG/L4pMZ3PROITsjNsT/3BXnVdKGqTLebRnu5naQVyWdC/+OydmPX6NY/BSxUOpPeihQS7yc4c4+pgsuuQDnFZIye6QMPXmk5Z9KsxFcJFzcbfoBi9Tm2aFsOH7yay55+AF60C9jHc0/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuP/mmEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCEEC4CED6;
	Fri, 28 Feb 2025 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760094;
	bh=rNH+Y236VT+IG+O9V1w36N5rgSkIJ8RhfYYGa1KcAXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iuP/mmEf+ERr3ZtuXNxDvcopPRqw5tSB5AoM8mNCY11XpeUs3fa+v2c+OiGAX/eK5
	 2H6UM69SKLI6q9Oo1Y5qa/LnYFchYLeicygl0S+dw2M14vcEKnVTzR8/mnj6f+kD0f
	 /ibjMn4g3ypb418uwXXwuyx+tx4YpN4uZCaGGb8yklMduSUPqr289+vLnKFDIRwJls
	 chSOSlLAMQCzevnNjpZVZQtzNVQ2ibjNLDe2iNVfX+0lC62dirocUGv31ULsOGtdjL
	 5V5PijJUOwt+1Axs14Aj4N+I0sFdIdi3OaA/yGE7J9JmY1JKUMGN4xhExQ18PfJRVw
	 ii8Hh5YSg9Tsw==
Message-ID: <7801d1bc-ff7d-4a83-9e56-4890132ba738@kernel.org>
Date: Fri, 28 Feb 2025 09:28:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ipv4: icmp: do not process
 ICMP_EXT_ECHOREPLY for broadcast/multicast addresses
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250226183437.1457318-1-edumazet@google.com>
 <20250226183437.1457318-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250226183437.1457318-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:34 AM, Eric Dumazet wrote:
> There is no point processing ICMP_EXT_ECHOREPLY for routes
> which would drop ICMP_ECHOREPLY (RFC 1122 3.2.2.6, 3.2.2.8)
> 
> This seems an oversight of the initial implementation.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/icmp.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>


Reviewed-by: David Ahern <dsahern@kernel.org>


