Return-Path: <netdev+bounces-99271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA11C8D4414
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC7D1C210C5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB851C5A;
	Thu, 30 May 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHm+LZUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FA256A
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039591; cv=none; b=ixpYdl2xrsbl3CieqtSo6yssng9PX/Q3qmeHV7Xnxq29vTjgdblBy1mL+JBfdOwkiNJeXgeFwQfTuo1N/Sqe02SIMoWSkXGIUvrtMefB0WuH0cCYYpptzyK8tH31261AWS+VorjqhhYl8XGeerLjXu+q0iDJcft4adkkDS0PYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039591; c=relaxed/simple;
	bh=gsNJ5T/uD9Xj/aHogYPzXYqxlgJ6tSm8kd9BWdAqBKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYwDTAf2QZw3b4Z0tKE8HoWHLuvUUTprpxvzMnym2eB96zPxf/kdryOCj8ZBm1jw3m667eaxePOpnp+XrDrVKEO+mjFMyG0aCIo+qOjU6GNjJn2T5OZsQli9QKA3XvfPeW3Rf/okFCxFzjTmPvHZmj8ByosYWoYles+fHe0vi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHm+LZUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBE0C116B1;
	Thu, 30 May 2024 03:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717039590;
	bh=gsNJ5T/uD9Xj/aHogYPzXYqxlgJ6tSm8kd9BWdAqBKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHm+LZULUY0+3qSz1mtpS+78iV/XeuzOVMdXG+Fbkn9S/CbvTjLLXTd3ytQNKDGHI
	 I4uwY7vo9nvENgOpWOWyCvPj/+tpCmOJHiBbSlL9wdltakW8WQ6A1JjX1J8q6qiKCX
	 /2sqPDWKzOEWsAThyp9Ko39pERsZO7lDjIttFlhV0TeVS+PNHj6OMB+TjmXiI9tKVf
	 LmCDbKHxovBF6cAydM1bdrhQJB/yva9ixECmYTgcU0kxvSlw2AcgPcgvW5J2Rs356s
	 HlDAhErEo4eMoQcZCxyNXuucm2EAVp3CABvZM/WMNZQj/OC1y8X1blSI7g7U93SShS
	 J1LHeVB2mfwow==
Date: Wed, 29 May 2024 20:26:29 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Yoray Zack <yorayz@nvidia.com>
Subject: Re: [PATCH net-next 13/15] net/mlx5e: SHAMPO, Use KSMs instead of
 KLMs
Message-ID: <Zlfx5Rq-eru82XXj@x130.lan>
References: <20240528142807.903965-1-tariqt@nvidia.com>
 <20240528142807.903965-14-tariqt@nvidia.com>
 <20240529182316.1383db91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240529182316.1383db91@kernel.org>

On 29 May 18:23, Jakub Kicinski wrote:
>On Tue, 28 May 2024 17:28:05 +0300 Tariq Toukan wrote:
>> KSM Mkey is KLM Mkey with a fixed buffer size. Due to this fact,
>> it is a faster mechanism than KLM.
>>
>> SHAMPO feature used KLMs Mkeys for memory mappings of its headers buffer.
>> As it used KLMs with the same buffer size for each entry,
>> we can use KSMs instead.
>>
>> This commit changes the Mkeys that map the SHAMPO headers buffer
>> from KLMs to KSMs.
>
>Any references for understanding what KSM and KLM stand for?
>

Not available publicly. Simply those are two different HW mechanisms to
translate HW virtual to physical addresses. KSM assumes fixed buffer
length, hence performs faster.

