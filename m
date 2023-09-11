Return-Path: <netdev+bounces-32747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930DB79A289
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 06:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D87280F89
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A791FB8;
	Mon, 11 Sep 2023 04:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F43185D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 04:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA63FC433C7;
	Mon, 11 Sep 2023 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694406963;
	bh=rG/sI+5ITI+pB89QHOpT9Yg4BxVB/RgnoEWfLQh/9KM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RRGxxhmnJnLznt/6vjDWWnS8t0Q8k6yVVDhGKSuxfiDTeIPjkDW2tNUUo0FXYH12R
	 JV8QYu7nmV4iI4esnvFkZdXjA7f1RmHwrF5ePfdmzZzdZL64I4f1+8jjtScnx1pGCa
	 BEpMo14VoUSBWKpIjBagH8WhY03Xc1Mc5wMkhz2xq7nQ6b0Lw0Vz08BO49+c1pSlXt
	 zfz3g5YUK9KGPcZTgsC3b6kQ7xWcDoRyuSPjjkfTyQJVWGjOe37f4kWqslQm0UmbsT
	 dI7mdTMGwidHsG5RNd3hiBNQ01aadVhbYZwQvR7NI2LDFF8PjPbYsrpkijzDwLIQ6N
	 czVX4xZbTKaOA==
Message-ID: <46139141-90f5-820e-2124-0c9fa80e755d@kernel.org>
Date: Sun, 10 Sep 2023 22:36:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net] fix null-deref in ipv4_link_failure
Content-Language: en-US
To: Kyle Zeng <zengyhkyle@gmail.com>, pabeni@redhat.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
References: <ZPqSfGGAwa1I69Sm@westworld>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZPqSfGGAwa1I69Sm@westworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/23 9:18 PM, Kyle Zeng wrote:
> Currently, we assume the skb is associated with a device before calling
> __ip_options_compile, which is not always the case if it is re-routed by
> ipvs.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> This patch adds a check for the edge case and switch to use the net_device
> from the rtable when skb->dev is NULL.
> 
> Suggested-by: Paolo Abeni<pabeni@redhat.com>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
> ---
>  net/ipv4/route.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



