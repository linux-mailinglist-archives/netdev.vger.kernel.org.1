Return-Path: <netdev+bounces-184828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEAEA9763F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B73C16C117
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240F298980;
	Tue, 22 Apr 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Gem/KGh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5882980A1
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351839; cv=none; b=Cj5YwXz1qY8mYFaoSn83wUsPuxxv23LeE/s5GIZPO4Yp3zi2U0Gq6pCqpqNPzlqVs/YA7/9gd1DzlYJ1110TtwBKd54KZPcMj593QZdZXS273OWOqOeodvr2zyG+eZsl5IVvTvepQzHEdVbGulayB8Lmu5zAQOjv+u1UYdMNQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351839; c=relaxed/simple;
	bh=WJHka7iuLuH68LfF4yXHtBMkrb9iSbcghMlX8jPOgoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDaFwWqbubYds0eUBHNwsFNDqs09+kPyaNW7VtB2AeZxfh621S/B3NbeOIGAz5V5+3dPGaBZ23/mKkgxIplQj5JSSSsJ7UgyVRDo07+rBt997ndfVK9rNBK+eSheIw7ZxQftoIaLekJ0zL2P6B7ZfjQRp68ree7cP3rHrKiN/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Gem/KGh/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso55427805ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745351835; x=1745956635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge0GHHTU91a+LD/T9F4eD36zKBwLZ5OWIWjjLI6NmxQ=;
        b=Gem/KGh/S+NrQs6GjEW2PDXZXO3bn0yjQV28GkByO4Ky0Aj1dZ08v3sq05Y4bj4lua
         SDmYdv9Y8R3BM9sdbn3wQvJ2ijxOop47wNxUtPMddnAu/Eq1vPzGyGJDseLlt+EzPwbT
         Fnk5D+8cyQv6ynwBZ1ckJNs4jfkVLq80aogFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351835; x=1745956635;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge0GHHTU91a+LD/T9F4eD36zKBwLZ5OWIWjjLI6NmxQ=;
        b=khKbFOr6E3vh8Apv0juHw/VL3IgvPbQacvIQGvRwbDzfCmWL4eo/X71EpMvgysNyQx
         2pJ/jXHNYj4UFl09lbhyRHrT6qdBew4TezzN3/RVSnAyOLBvD+B/hIdJz5XnpqKmlkIS
         VcTOxHwiY1GfcoLuy4eisMsRc1TJuzH1nDcwUtCPBXEdhOT6m/1GzBRQ84aM1lZLhb17
         v/JKkK7kN45bKrLrkiGPZhszsTji4ZArWjkK5JEVe04ITGzjorKotiPdxQu/giJH+FwQ
         OGt5ARndww7tySF1J0zDaP4WlHu7BlJ4BcGnSLyG26vREjORK3vl0Q4eOEy8wEeaEuo5
         Mqkg==
X-Forwarded-Encrypted: i=1; AJvYcCX4ichjrqAWM+fgWYaqzQOeIZATokM9YDlMOtAHH9GGsOh8bLjRBAsGf6jCeOgQ9QvbZXjtsn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlElCeOO0dtiyg/+6R3LLAQ2UXsZOX0qjA+2qSeg92GaDZS58
	KmIx/HcjuUPSSKua+5q0U0mAayDImlW3tIMn+OJHsPAMmDLUzm5XpeVRbitQ3JE=
X-Gm-Gg: ASbGncsbEuxj9s9mctQx0/WsUtOqgnllzdWqidhO/4tllev37SMVbQj98e2L2A78s3u
	zOQEsXU/dmJ/NocuTtPTeyq4+vINjXMlAg3GQxT4dTON/iNyf5fRmccp7nXMd6JSc0m2NCwryRC
	kHPpcm1ID3MGpGXijmKd4ZUAYVIhPeVSdT0dEOY1KT7kl0qMlCdEiRru5oakKi6TTMkH9mydxOZ
	KISEqthfLwOb6HngsrsyN1pLcxA39LWDnsdsv08gqsE4jArNaTf01T7iCHxCwTm739q3qRVxgIH
	imrrUADR8JVobbDzUy1M+9lenS3nAGcZayjxfq/kJQtIe8FjOgPyz08vPrImD+INWT02w8aeAOd
	v5u0n752wocMM
X-Google-Smtp-Source: AGHT+IGsNxArdxzOP9mnPCPC+VWbU2kO/sN+4A5DBzKZ/DV66j37lHSy3/MwCvWry4OtA9kofLS9Yw==
X-Received: by 2002:a17:902:ecc7:b0:224:1c1:4aba with SMTP id d9443c01a7336-22c53620d32mr233368065ad.50.1745351834726;
        Tue, 22 Apr 2025 12:57:14 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fe055fsm89414645ad.253.2025.04.22.12.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:57:14 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:57:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 04/22] net: clarify the meaning of netdev_config
 members
Message-ID: <aAf0lyGclY42Vux-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk,
	asml.silence@gmail.com, ap420073@gmail.com, dtatulea@nvidia.com,
	michael.chan@broadcom.com
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-5-kuba@kernel.org>

On Mon, Apr 21, 2025 at 03:28:09PM -0700, Jakub Kicinski wrote:
> hds_thresh and hds_config are both inside struct netdev_config
> but have quite different semantics. hds_config is the user config
> with ternary semantics (on/off/unset). hds_thresh is a straight
> up value, populated by the driver at init and only modified by
> user space. We don't expect the drivers to have to pick a special
> hds_thresh value based on other configuration.
> 
> The two approaches have different advantages and downsides.
> hds_thresh ("direct value") gives core easy access to current
> device settings, but there's no way to express whether the value
> comes from the user. It also requires the initialization by
> the driver.
> 
> hds_config ("user config values") tells us what user wanted, but
> doesn't give us the current value in the core.
> 
> Try to explain this a bit in the comments, so at we make a conscious
> choice for new values which semantics we expect.
> 
> Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics.
> Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
> returns a hds_thresh value always as 0.") added the setting for the
> benefit of netdevsim which doesn't touch the value at all on get.
> Again, this is just to clarify the intention, shouldn't cause any
> functional change.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/netdev_queues.h | 19 +++++++++++++++++--
>  net/ethtool/common.c        |  3 ++-
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index ea709b59d827..f4eab6fc64f4 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -6,11 +6,26 @@
>  
>  /**
>   * struct netdev_config - queue-related configuration for a netdev
> - * @hds_thresh:		HDS Threshold value.
> - * @hds_config:		HDS value from userspace.
>   */
>  struct netdev_config {
> +	/* Direct value
> +	 *
> +	 * Driver default is expected to be fixed, and set in this struct
> +	 * at init. From that point on user may change the value. There is
> +	 * no explicit way to "unset" / restore driver default.
> +	 */
> +	/** @hds_thresh: HDS Threshold value (ETHTOOL_A_RINGS_HDS_THRESH).
> +	 */
>  	u32	hds_thresh;
> +
> +	/* User config values
> +	 *
> +	 * Contain user configuration. If "set" driver must obey.
> +	 * If "unset" driver is free to decide, and may change its choice
> +	 * as other parameters change.
> +	 */
> +	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
> +	 */
>  	u8	hds_config;
>  };

Not your fault and not exactly related to this patch, but in general
I found it a bit confusing that the two fields are different widths.

