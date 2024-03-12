Return-Path: <netdev+bounces-79358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F845878D7B
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563F028247D
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC33BAD2C;
	Tue, 12 Mar 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyT19u4d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E4B641
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213978; cv=none; b=U/TrnDqFnQsHiNKNyPJhrKXfF+2Mft1iS9FnNNYbfRoRS+ttRJMMAnoaIFHxaGdJ4bst9X4cGW2ltjnmWmeLJsYTJKzUIPj2v7noKnBr65uZSUirn0GLHF/sptlpJEtOQgYXKXfzNaLuNU+oqqJ6AoKsntE29V5QcZbjqEBj5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213978; c=relaxed/simple;
	bh=oq7gPV9XMF5+iQaVrkdpanrpivGhGPf5S0ym3VDEdCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/zD5bKLT2g6LIbd50HSh42Hfr4MLsX7G4Zan7hEHuQTslnsYYcv3be3wFzF5oi6pzo2P8Q01I8ARnGCNlzON6kDgZ720xEwJidGE0vpzOo46VpATREsviKgx70fZEi4e21HxAY2mX/shC4iqvO4tzvfDx688jb1PWq0m69YbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyT19u4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA614C433F1;
	Tue, 12 Mar 2024 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710213978;
	bh=oq7gPV9XMF5+iQaVrkdpanrpivGhGPf5S0ym3VDEdCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uyT19u4doaCiNX0p2dXogiDilqPJN17T9e/g5lg3nfF82u1qKhuaH6NM74OjEZruC
	 6WNR1VHVK5ya0znvJkzwzaaxsb71IaAF1IXT98kqpmwaISh1Q1Yc4dDAZAzLxa+vYF
	 ySuXzY/dCwuptrODLbalu18ws/KzgjJzFMt0sNIQ1XZIsIi2WOXA8kFTVj6ogZGCqs
	 yHlqDQ1HNZP3OY7Nvp4Bt7xkZHzzEn7fbC4Ewf88WYVzGESfKZ5MjttpAD31hYxvWR
	 nK9C9rt8cBwNlIVhPMUvJXgyBczEWTD2eXAGKyxzayqkP4sNLDuNbubKNLC8V9/g4U
	 Q/F/5XWTFt5mQ==
Message-ID: <0e2f2512-20d1-483e-9a35-482386f6503e@kernel.org>
Date: Mon, 11 Mar 2024 21:26:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] nexthop: Only parse NHA_OP_FLAGS for dump
 messages that require it
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20240311162307.545385-1-idosch@nvidia.com>
 <20240311162307.545385-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240311162307.545385-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 10:23 AM, Ido Schimmel wrote:
> The attribute is parsed in __nh_valid_dump_req() which is called by the
> dump handlers of RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET although it is
> only used by the former and rejected by the policy of the latter.
> 
> Move the parsing to nh_valid_dump_req() which is only called by the dump
> handler of RTM_GETNEXTHOP.
> 
> This is a preparation for a subsequent patch.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * New patch
> 
>  net/ipv4/nexthop.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



