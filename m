Return-Path: <netdev+bounces-76342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA7986D57F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F8428995D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543514405A;
	Thu, 29 Feb 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JeQWLYaZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEC16FF4E
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239355; cv=none; b=vES8OP1Yq7607JAt3PlOFshPjtdsGGHLKBixOZYY24Jfdpf63m6pS+HZGLsNpbRkQXxFnM7n69F714C8OIPRcUyAsMo+GbnEO6jFyFXG1JnWvrcJXxaIdOjWOFMnqxy1iGB3N7MyBFJ43zjYzWVM2oOK0luOGs9/ZX8zObmBAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239355; c=relaxed/simple;
	bh=AVaRvENjI1FocEMSJmRuRcxcAz5F56D3DWlPaQOOwus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb5BzCy/k2n/KjOYLyXuniWlGQwEOT3OW1agPaVIVPNohi92RFWHdLVrCA9BkzE44ECDn1hx3i89QfJj5uh9trImfWo3q/66YDsSm9OyRDmOjB2xfq27BGhDis4yGecdNSeSi5Gd6gCZyF3IQx3UPflMdSa/UTe/rrgkXvrPMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JeQWLYaZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0aef1308-89ab-4360-b1d0-f02b82b56bf4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709239350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snJzf/AqOBQ7RXAlzVnG3S7res3RqhanWErcNaLggZ8=;
	b=JeQWLYaZ+1UuOS2o8Xa40m4aCYrJyN1jwnwWk3qUoAYgXZDEbxqipYsmJmcBDK5dhSO8Jp
	RxGuxbZB1VQPcSCPL6iKbKkl4ige9nORHudvb4NjTQdU6wvv+j4OfQrDDn/fm5osshHnYK
	L3hxeTndDHmrRC04+k9lu+LMMWZfDOU=
Date: Thu, 29 Feb 2024 20:42:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: fix build failure due to
 rcu_dereference_check() on unknown type
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us
References: <20240229190515.2740221-1-kuba@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240229190515.2740221-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/02/2024 19:05, Jakub Kicinski wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Tasmiya reports that their compiler complains that we deref
> a pointer to unknown type with rcu_dereference_rtnl():
> 
> include/linux/rcupdate.h:439:9: error: dereferencing pointer to incomplete type ‘struct dpll_pin’
> 
> Unclear what compiler it is, at the moment, and we can't report
> but since DPLL can't be a module - move the code from the header
> into the source file.
> 
> Fixes: 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()")
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Link: https://lore.kernel.org/all/3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Sending officially the solution Eric suggested in the report
> thread. The bug is pending in the net tree, so I'd like to
> put this on an express path, to make today's PR...
> 
> CC: vadim.fedorenko@linux.dev
> CC: arkadiusz.kubalewski@intel.com
> CC: jiri@resnulli.us
> ---
>   drivers/dpll/dpll_core.c | 5 +++++
>   include/linux/dpll.h     | 8 ++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 4c2bb27c99fe..507dd9cfb075 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -42,6 +42,11 @@ struct dpll_pin_registration {
>   	void *priv;
>   };
>   
> +struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
> +{
> +       return rcu_dereference_rtnl(dev->dpll_pin);
> +}
> +
>   struct dpll_device *dpll_device_get_by_id(int id)
>   {
>   	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> index 4ec2fe9caf5a..c60591308ae8 100644
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h
> @@ -169,13 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
>   
>   int dpll_pin_change_ntf(struct dpll_pin *pin);
>   
> +#if !IS_ENABLED(CONFIG_DPLL)
>   static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
>   {
> -#if IS_ENABLED(CONFIG_DPLL)
> -	return rcu_dereference_rtnl(dev->dpll_pin);
> -#else
>   	return NULL;
> -#endif
>   }
> +#else
> +struct dpll_pin *netdev_dpll_pin(const struct net_device *dev);
> +#endif
>   
>   #endif

That also works (as well as void *),

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


