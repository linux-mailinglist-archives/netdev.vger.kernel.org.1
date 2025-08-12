Return-Path: <netdev+bounces-212911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189AB227C0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B595678D4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592E283CB0;
	Tue, 12 Aug 2025 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mTpyTLd9"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FE283CBF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003422; cv=none; b=HPsH1rSA8ppGyesg337ed04O2iMRR3t/e1TqBV7S0y+G44KWbAoY+LDuvEx2UzLrq+urUA625fAlf5ImRb3okaZ80PIVI4SOX02X2cmDLq1p6XqK0kSv2KzyptYJnqCqxj6sGmfs1O6389MbnTo6jtRRLmYSR6CqETCI0dUitrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003422; c=relaxed/simple;
	bh=NmJZRF3omiQfQ6m1CN0UX/QZqQn/fJKRC6tEWJljr2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQn3jIHTWIy0riqRfaWSipgcUmTHlLAqm9HqZe071iKO6FrkH5PfTB7zgs0wxazdWGMCP15yuMaDvyD46yF4FhIiWVPODbEqvlV04BtKST+CpG3+xXlPYCtHjtsIETIe35SQB/cUquMkw0wmy0ja7WgQ1BYmj46uaqGEap0LiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mTpyTLd9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5bf50cb2-31c6-4391-a09e-a73fd84fe051@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755003418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZsC9AivrW4iHKq1tw3pD8sQbjlniC4kKIeOMQmHCUo=;
	b=mTpyTLd9rOqOwxBG3jDELNOMGYiKnrXsvFT8FQKPBaho1sW8KJGjEWsT+nHeumOrt/UGlj
	ftJgLfc3FxvbluIGv3xh2BgI+C7cxl3CE6CeTDt/gB7VjH1LmKf7LdDgHgR/gVntxZIiTb
	H201zn27yGGc4d3rkbmNeqSdvShtaHU=
Date: Tue, 12 Aug 2025 13:56:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] devlink/port: Check attributes early and
 constify
To: Parav Pandit <parav@nvidia.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Cc: jiri@resnulli.us, Jiri Pirko <jiri@nvidia.com>
References: <20250812035106.134529-1-parav@nvidia.com>
 <20250812035106.134529-2-parav@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250812035106.134529-2-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/08/2025 04:51, Parav Pandit wrote:
> Constify the devlink port attributes to indicate they are read only
> and does not depend on anything else. Therefore, validate it early
> before setting in the devlink port.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>   include/net/devlink.h | 2 +-
>   net/devlink/port.c    | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 93640a29427c..c6f3afa92c8f 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -1739,7 +1739,7 @@ void devlink_port_type_ib_set(struct devlink_port *devlink_port,
>   			      struct ib_device *ibdev);
>   void devlink_port_type_clear(struct devlink_port *devlink_port);
>   void devlink_port_attrs_set(struct devlink_port *devlink_port,
> -			    struct devlink_port_attrs *devlink_port_attrs);
> +			    const struct devlink_port_attrs *dl_port_attrs);
>   void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 controller,
>   				   u16 pf, bool external);
>   void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 controller,
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 939081a0e615..1033b9ad2af4 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1357,17 +1357,17 @@ static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
>    *	@attrs: devlink port attrs
>    */
>   void devlink_port_attrs_set(struct devlink_port *devlink_port,
> -			    struct devlink_port_attrs *attrs)
> +			    const struct devlink_port_attrs *attrs)
>   {
>   	int ret;
>   
>   	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
> +	WARN_ON(attrs->splittable && attrs->split);
>   
>   	devlink_port->attrs = *attrs;
>   	ret = __devlink_port_attrs_set(devlink_port, attrs->flavour);
>   	if (ret)
>   		return;
> -	WARN_ON(attrs->splittable && attrs->split);

After this change there is no need for local variable and the "if" block

>   }
>   EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
>   


