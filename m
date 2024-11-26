Return-Path: <netdev+bounces-147464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6F9D9A8D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE63283292
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E11D63DD;
	Tue, 26 Nov 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POnOapE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB81D63C3
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635636; cv=none; b=SWtT9vZct7rGGeceoErd7kfR3lrmECbJbDalOWu42IjXlAJ5+zAWvMgLCoRUyexU/tf2tAj3teNQZQqBJtAzaWEsxk5mrXELc2hXYxz3GDtc2hcEBSQj+s6NfQLgc7b841H8vCK5YH/lbCdONJQV/Bhk8PmozEeM8/X1SPMqVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635636; c=relaxed/simple;
	bh=GsxQZX6ChCDBsrQvD4bRIQZJjRTrq8m+RnBIH/rBaQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mH2d34pD3DUCFH/MKmJx9OwLY1UOxDwhMLNV/wDksP2GaslJMK4PeEQJl2HwwRICAe1gnwW3XO8DyS+O1A2EGWkfaXSXzhxKEvwLOrft7gCKeomMzQJ6jBFrfF0D4bUIfHafSi+VFqX7kAH4qx/+FxSIhYwc2MYR2MvgHd8Vw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POnOapE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BDAC4CECF;
	Tue, 26 Nov 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635636;
	bh=GsxQZX6ChCDBsrQvD4bRIQZJjRTrq8m+RnBIH/rBaQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=POnOapE2GBXmTvENUjJTeudNEiz4OoFw+JwqvsDBXqfPHyIU/L13xdAWVBbJq1Wip
	 Hx/Yd0PLi/2LaP+GZnkvZOWKTCWqj0iHAPa4pNpLOAclO4xpodg9VcGoUEJIiATi93
	 DnDjriwb1q1XZigF/uYIzHa1xF2AFdLNyHJMSBX2R9Hv5b2M9rdThI+8i3BLeP0YrP
	 uejIcACOxsx0qe/T8tRYL8VUJWuRcSt5xdxHCKJTEk4zT46Naknk7g5YYwHzlotkB0
	 V73S/bqalQxzAw73OyoiytmMRHgh93XhyK31eKeER1evIHxKUExHhfrQaVN18LAESE
	 jBFITR1qA3yYw==
Message-ID: <431ec831-259e-49a6-8b58-7da993332fb8@kernel.org>
Date: Tue, 26 Nov 2024 08:40:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 3/3] ipmr: fix tables suspicious RCU usage
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stefan.wiehler@nokia.com
References: <cover.1732289799.git.pabeni@redhat.com>
 <79b93747474203aa83fdf84fa9a94181c6a6cf36.1732289799.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <79b93747474203aa83fdf84fa9a94181c6a6cf36.1732289799.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 8:40 AM, Paolo Abeni wrote:
> Similar to the previous patch, plumb the RCU lock inside
> the ipmr_get_table(), provided a lockless variant and apply
> the latter in the few spots were the lock is already held.
> 
> Fixes: 709b46e8d90b ("net: Add compat ioctl support for the ipv4 multicast ioctl SIOCGETSGCNT")
> Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/ipv4/ipmr.c | 42 +++++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



