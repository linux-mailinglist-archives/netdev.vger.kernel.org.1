Return-Path: <netdev+bounces-154385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904199FD76C
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 20:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3945A3A2636
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9411F8EFB;
	Fri, 27 Dec 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXzn+cmw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E11F5435;
	Fri, 27 Dec 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735326810; cv=none; b=eWO5nDnxOq7GMpThCOiA2MW7WDg6eTak2Ai/9umU4X2TrPI1Ot9GyX23nHsPjgaNnQYuM8nuf9WOZL+m6DIiAqYVoTTqbQarSu4kqeCN9x6Mlx7kZy11sNsFm4Zp4cGBFpLPxQLtghZeulb94E1WYXZuhCbW7efvw+hLOQTHYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735326810; c=relaxed/simple;
	bh=4og5cusuksL3et2eQUdrURSINmvx22cQnYJbT22IPvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btW6q2I6/O/i3bLj8HKbf8OzUzGJWMny7eQv4MDwosqRyd/pIb9vPsTRE+dlY73ei7bKyEfmhb+kXLpBz/x+aDz9W1P4gid/8D+cye5yWZKwn3GeWq54M7D6q2+0ClrZt4Ano9sm0f/i7HfaCenaUfdshI30AbzCWQmhdIW0olM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXzn+cmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563A3C4CED0;
	Fri, 27 Dec 2024 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735326809;
	bh=4og5cusuksL3et2eQUdrURSINmvx22cQnYJbT22IPvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YXzn+cmwSeSIPqlwqr9logxgSm98JpEI1HQyWdRKah1/kNyM22cBomBYids1l43Xa
	 zo1q3Vofj/vy2eMPBqWZQ9pGVc+jyMIVqc9SDzC+Gl2HFjh9HNcrjX9B09WQVy/lDW
	 PI0tdXwFkaHKtXWqadZsOYOBoBZL6BsAbq7eCw8HHTdLfFsf43h705wu/2x8vAdYfT
	 xxUbzdZZWbgBLA1mqdsJtMqEWFXXlHiS47Fe0jY0np6OqfDDAMTvkHFebZxGCYUt/x
	 pZF6DvAN75jiS5GnSTGldWFHLLWfopnDd7vUH6aEyWiIcx7YyE36UTELH8gcw3mqlt
	 lMbp8sotKywcA==
Date: Fri, 27 Dec 2024 11:13:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Jie <buaajxlj@163.com>
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Liang Jie
 <liangjie@lixiang.com>
Subject: Re: [PATCH net v3] net: Refine key_len calculations in
 rhashtable_params
Message-ID: <20241227111328.540ced11@kernel.org>
In-Reply-To: <20241220082436.1195276-1-buaajxlj@163.com>
References: <20241220082436.1195276-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 16:24:36 +0800 Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> This patch improves the calculation of key_len in the rhashtable_params
> structures across the net driver modules by replacing hardcoded sizes
> and previous calculations with appropriate macros like sizeof_field()
> and offsetofend().
> 
> Previously, key_len was set using hardcoded sizes like sizeof(u32) or
> sizeof(unsigned long), or using offsetof() calculations. This patch
> replaces these with sizeof_field() and correct use of offsetofend(),
> making the code more robust, maintainable, and improving readability.
> 
> Using sizeof_field() and offsetofend() provides several advantages:
> - They explicitly specify the size of the field or the end offset of a
>   member being used as a key.
> - They ensure that the key_len is accurate even if the structs change in
>   the future.
> - They improve code readability by clearly indicating which fields are used
>   and how their sizes are determined, making the code easier to understand
>   and maintain.
> 
> For example, instead of:
>     .key_len    = sizeof(u32),
> we now use:
>     .key_len    = sizeof_field(struct mae_mport_desc, mport_id),
> 
> And instead of:
>     .key_len    = offsetof(struct efx_tc_encap_match, linkage),
> we now use:
>     .key_len    = offsetofend(struct efx_tc_encap_match, ip_tos_mask),
> 
> These changes eliminate the risk in certain scenarios of including
> unintended padding or extra data in the key, ensuring the rhashtable
> functions correctly.

IMHO the change is not worth the churn. Does any upstream code checker
/ tool prevent from new instances of this pattern occurring?
-- 
pw-bot: reject

