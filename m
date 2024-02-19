Return-Path: <netdev+bounces-73023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BB85AA21
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03121F23898
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A064594C;
	Mon, 19 Feb 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1yLuCHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3441C92
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364380; cv=none; b=YgOpneSbwSkW0OiYmmvU1YPEF2ndl34WV061JlD1qXwHId80yF69cb2dN3eiOL/e0hElZC+x4OhQz/NMGBlcar1IFkk9079oIU7GkZ+kVUHt+Ae4tB4I9J0IEGSo9Vra3eA/oEjIkPXMBmx3T+1qLaghwaNEevvSW7vwzUn3Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364380; c=relaxed/simple;
	bh=k7fb7JFpTOdHAmyMHVCnFg2E6iek+WcpA4jRy1JitYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poqjqb1BAlRmguTtolgsrDMXkkveZPxV2ieR+mYBfkGO6jrrTA+zYkbSVhxiSOHsSlmUK5HIkrMQGyp0i6hNu1efD1nja81KSHR+1KBd+tODNQHOPsg1b1W+Ci8o80CwI7o5YYIQDgKqvY/sgV3cjkCOF5ZVY8+D5CL8ai7r3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1yLuCHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9F1C433F1;
	Mon, 19 Feb 2024 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708364380;
	bh=k7fb7JFpTOdHAmyMHVCnFg2E6iek+WcpA4jRy1JitYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1yLuCHgvNCfZsfW7aNBYIgbPMBK3+6EalV1XmoArqpd9NW6EK7KsGo077TNKP9WA
	 k3F6UmY++iP5Zja6D9liy5HmqlxTjrVwfqP0rntERaDdlOW1ZetODcvS+FZoGkHSSM
	 i/U0GLXMEW91hFNBL32AxCWqmktO29pa8nx4xR4WnD7gXBJQWuzEMjjgQr/ZBB8PcG
	 ISE8tjLCt7Po3FMsY4EmSmLSYNNRaWU9UiKmL1s5fEwJn+fG2NEzwa1WBge+rdR5oa
	 7u73sEEeDH4uqntHuHW9CT4saHCtBx+48xefdDxrQSwDJsAmk0npTIfHff0jDV1AyN
	 dittqlKVZfTcw==
Date: Mon, 19 Feb 2024 17:38:05 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com, toke@redhat.com, jwiedmann.dev@gmail.com
Subject: Re: [PATCH net-next] net: fix pointer check in skb_pp_cow_data
 routine
Message-ID: <20240219173805.GK40273@kernel.org>
References: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>

On Sat, Feb 17, 2024 at 12:12:14PM +0100, Lorenzo Bianconi wrote:
> Properly check page pointer returned by page_pool_dev_alloc routine in
> skb_pp_cow_data() for non-linear part of the original skb.
> 
> Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
> Closes: https://lore.kernel.org/netdev/cover.1707729884.git.lorenzo@kernel.org/T/#m7d189b0015a7281ed9221903902490c03ed19a7a
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


