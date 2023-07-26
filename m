Return-Path: <netdev+bounces-21135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED57628ED
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F030C281864
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122351365;
	Wed, 26 Jul 2023 02:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8615AD
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957A2C433C8;
	Wed, 26 Jul 2023 02:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690340215;
	bh=CbLxxa3u8xJbX+yXwwYh9sNVab+LKsl8mbRxbBao4+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V7CmLC0tpxIzeUR4SXWl4mOegP7XX9J4Xo9XKyg/Bl2dUlXhMKI3vycvAEpeRxRYD
	 30rBvDson5HiHyCTJjR3tbyTD3TiKnxhix7K4rrbEgEvXFc4uq39Yh+5nJHoV1yOFd
	 wk0EY3tISmhpd3cbHfAATp02x9DFOjJUSRr5hR88P4OBzHbsBfR5eB9E+6YTmL2Kng
	 p3t7zUu0MzgcP1Dfas01UDW45dmCkD52xc4zQ/vCfnP5ZGA/wa8njJQtjl3Nn25DgX
	 cjLMoxJzWHbW6/UpJvQ9H9Y0Kww2K0Ykrvf9BIFpRyHV349TIMiVS03Qkh+HF7E2Rw
	 Czhl2qKVlMnaA==
Date: Tue, 25 Jul 2023 19:56:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, sharmaajay@microsoft.com,
 leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Configure hwc timeout from
 hardware
Message-ID: <20230725195653.2ed5cecc@kernel.org>
In-Reply-To: <1690177120-20938-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1690177120-20938-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jul 2023 22:38:40 -0700 Souradeep Chakrabarti wrote:
> @@ -825,7 +847,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		goto out;
>  	}
>  
> -	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
> +	if (!wait_for_completion_timeout(&ctx->comp_event,
> +					 (hwc->hwc_timeout / 1000) * HZ)) {
>  		dev_err(hwc->dev, "HWC: Request timed out!\n");
>  		err = -ETIMEDOUT;
>  		goto out;

msecs_to_jiffies()
-- 
pw-bot: cr

