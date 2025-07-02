Return-Path: <netdev+bounces-203492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EEAF61E6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E587481F6E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995A221F06;
	Wed,  2 Jul 2025 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIMkEC5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F92F7D0E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482482; cv=none; b=hHsx1K48VgV9EiZPgNjKmmpf54q/6SmqlTrALQwDAMUo5H5/g+ub1IBS4rbgiZd7GeO3nxC9NAIJY5NvmTRhC9Evc2kb36dHsj+Afhg4nHL74Q+Rc5HnVlX5JxBLhL2Ol4SH3yyhgz/lRe0EruuXPsm7tuTD9obsoQCkWgnBYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482482; c=relaxed/simple;
	bh=quIAjYMuPEIO1zIz0GrnBCfQd5cktHROxHqyLW5ZhGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJXt3B8CS/xpbMk7CYJaC176znVtrkvJL5HaiHMaU+vq/EixpbS/jA0hcu2Kbpv5yxG6+zCus+wLyEqHha6abl3onzfYuQt+ObDXdflGmV4RvhIz6hmwIn8NY4Ue4NTtLDVdwa7YWYVNl0JCpEXaUOvf2NtmjyGtosadGIk+b/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIMkEC5Y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so4492283f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751482479; x=1752087279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CttkZ8TYVl79XRNJLBq0SOIeL7s8esZfQlxWt1KMrh4=;
        b=SIMkEC5YRXuxiqiipNfDeKWkwOWTMe+Ugsgu5fSQqAVUgy4K9FrzqnzbxFfz9DNJzg
         VZWTFHHGPIRzkfI0ziuETlWSnosgjUEs39v2FWUtIsfiFE7uQCyu9zPvyAd3sWR9uUFH
         6ZVa8tecsD7KfnN68G0OMtgJXybRw2yPi3mdWC6bfWyDd8sbGI414QkjNs86UH20OFYN
         kocEfeEk1WdILgQz7wKBLobC49HKsKND1meNyniM6/oJfn/3bnB7qkPJEXOaisJkLoB8
         9a9IDuI3aDkAr71MjCm5IwDUPTEvm/97/UazG+9lq2oPkon++gENJMxX60KT/ntc+nAo
         3pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751482479; x=1752087279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CttkZ8TYVl79XRNJLBq0SOIeL7s8esZfQlxWt1KMrh4=;
        b=Sh6wajKV1mnbGkj3jGtLT00o/thea8uxdsCfJHHDcOmP65QyOLjWFSeefVGup3zexI
         m4D92u37zQPTEr6uzs9TEzx/joO+X5MPeAjvPgwFeSYRc9kjxReYRPgWWlIzsQdp9hlq
         frJTdnq/0+0OxgUcG9KaJmeLUEAPx6qBq/tQMtRcjgZYn7P6QZY6o3obJqpg4N1rGEnu
         U8lP+gIpwOj4/aVFwmAkAEhbvmmisEMbAbvxBFqS6qYaQnmXcjcwkH1Z5bXVN9i7gkyr
         VOYO6+yL5NUAzF/AE8EEnPs9DPhnpqNPfwq5uAXj60etKzS4nSPQ8Qxf/QCQZMDkIEBN
         3XGw==
X-Gm-Message-State: AOJu0YyzdPoMLTWvexC/yK41EFt+j1WgfXJEzNHsknVskprY3kfhNL8J
	S5swZhfD9QZZFc1tfvyHDZpH7vr9qjXWJu62qeG7SEQrhQVHstaMllSV
X-Gm-Gg: ASbGnctWlXcPvpGMJD3c0gm4eunyzcKDu7BK5FQWCg2D8eKp2mlzrIP8oA64h3WFkJd
	Me7Xot52jJ5pxw/J2G/GoNYHe+wn6XCSGwjfCHRbHK0eojoQDxeej6E7dREBcTK+Qc5ojzGJTO0
	AG3bZUBKX6h+9TGG30FIIveAFW1dmdrPLxSBgMsjkxs/lltR795B3JHpbZ8NOoLlH8l8KqeoAmA
	r2PCTWjosQMYysbTyBD0jD85Zq1DjoimDl6vc+SLAT1LVkpPJPJvszhg7SbrTUjlewt3XflTGUr
	C7ky4Zla3F2X4MoUVWv9MSXkFOSnM0I2VeEnQ1nsKaVfNNjRTm0NuB23k+c+1qmnlcA+iH+TElU
	825HL77d68PceWHhyJkMt03rxQ/TT7ESxsYCSGv53m5JdL95qgA==
X-Google-Smtp-Source: AGHT+IFCRXoUcoWtmK7HNUdHj9DQghUlH505WzM/zebPT6YrBjyBDwYXGn7mL8n7ren84Q0XwgcBkA==
X-Received: by 2002:a05:6000:20c4:b0:3a4:d4cd:b06 with SMTP id ffacd0b85a97d-3b32d4d10d9mr167582f8f.34.1751482478607;
        Wed, 02 Jul 2025 11:54:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa5easm16402928f8f.26.2025.07.02.11.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 11:54:38 -0700 (PDT)
Message-ID: <11d9b133-0e98-4fb9-9290-40d8cbb08fa6@gmail.com>
Date: Wed, 2 Jul 2025 19:54:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net: ethtool: remove the compat code for
 _rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, gal@nvidia.com
References: <20250702030606.1776293-1-kuba@kernel.org>
 <20250702030606.1776293-5-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250702030606.1776293-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2025 04:06, Jakub Kicinski wrote:
> All drivers are now converted to dedicated _rxfh_context ops.
> Remove the use of >set_rxfh() to manage additional contexts.
> 
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
...
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7ee808eb068e..ee32d87eb411 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
...
> @@ -1670,7 +1668,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	rxfh_dev.rss_context = rxfh.rss_context;
>  	rxfh_dev.input_xfrm = rxfh.input_xfrm;
>  
> -	if (rxfh.rss_context && ops->create_rxfh_context) {
> +	if (rxfh.rss_context) {
>  		if (create) {
>  			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
>  						       extack);

A few lines after this we have
	if (ret) {
		if (create) {
			/* failed to create, free our new tracking entry */
			if (ops->create_rxfh_context)
				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
			kfree(ctx);
		}
		goto out;
	}
AFAICT that 'if (ops->create_rxfh_context)' guard can also go, because it's
 only false in the compat case.

> @@ -1712,37 +1710,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
>  			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>  	}
> -	/* Update rss_ctx tracking */

This comment applies to not just the code being removed, but also the part
 below that (if(delete), else if (ctx)) that's retained, please keep it.

Other than that this looks good.  (Patches 1-3 look plausible but I don't
 feel competent to review those drivers to the level of giving tags.)

