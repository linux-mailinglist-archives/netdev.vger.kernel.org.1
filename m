Return-Path: <netdev+bounces-162791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A045A27E66
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F9F164885
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17F218EA2;
	Tue,  4 Feb 2025 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gSTVVN/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E91FF7A5
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709012; cv=none; b=D5/ZQebbJJJtGecgpnieUNGwO1KEs4o6prrpSLURwHkzij5DE0bc9XbEwz7dFg/I43M/RU4GLkb2IjFlW7WNXUaONKnBCZEY3zvG3eG7BewtrpkkSGzHcKtMz4kG1ZTjm/y5tBquaR2fsJdV/9xzE3Tt5N+xKF4wGYi4D75TzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709012; c=relaxed/simple;
	bh=Gtl8Igi4WlywiA+dzXoZ25GBSfMTXE8y4Y2SGZ8Egrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/dbZJsUaV/6AskTWD4xQFsIAvCYgQXGHogQMu+D6Ozqzqy/c3L0NOzi+lt3inDn7cy14KUvyGh20IU9MBNr5dC40c1D1dRN+9tawqzO92MCLNpOGnPt7vMXqtKLQQWL9D1XSKFhvtLkvDOszFzKXUerCHiExxbWIBdbXUXBFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gSTVVN/q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f0bc811dbso3675045ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738709010; x=1739313810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj+FrDqAZ6eREnqkCMCmvMCbAqmY9GTn137zHVuvgyU=;
        b=gSTVVN/qynLstwMpUKdCEcAjwdf1pC2pDz9/m4zoD4gdgyFASMAH9cp6l9sKVea94+
         TmhouBGbXuRKL4olrCVohQ0UAZuUwHMtw9Ffjbwzt++B8NJXrwHp+SCiEz7y8ZuAtJ6C
         r61i9zGGAXXX5srg6AHIKDJXqjPkUOvde44vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738709010; x=1739313810;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj+FrDqAZ6eREnqkCMCmvMCbAqmY9GTn137zHVuvgyU=;
        b=d8GilefD8NhVK6avciwjqvQ6N8JZKTMQRKZlVcmXhn4wIsHmQv1Psp9z614tkBg1EZ
         l2wa2T90LhNPCdDi3l/MwRJvZ793Z3EICaDBYUvJ1Nfi/Xw4wxgn5eHHf2dIAZjduEIS
         D6odSN5roPjZW+Atmu9mkFWGixITP+AgGMOu78IFhyt2Hd43zcgoXg9xsKJiL/QMY9gJ
         0faVZ5tkYKA4hGEW0shRbryU0aP8lA9CZTRyUiXZkjP36AwpAktkAQp8qkve1QUsuHY7
         bcKx0Y+10c3ZTgKm0cUDQFU4JOzsa453L2IZCaYImwnan/lxhy2PydHuWQQV/+5bMzdO
         NleA==
X-Gm-Message-State: AOJu0Yzttsfbr1t/CJUz0X4RniiQPCv1d8SaaQuFYJ34nMCmjBHuomdb
	PnKK93k0TeXi8Zln2CDnOdWyRo08X2wjtG3QV0HXxwfOWnHWKPpExv2u/VZIYlklfAbAwFwtlxu
	z
X-Gm-Gg: ASbGncsn03jJh/8O3LNvhLK4GOKDfa3cewvLQQMKneZPbUEsz/9w5y1iwcUEwttmlMv
	l6RsWURBJWii7h7Zq6xNtUwzNwS2bzaibAIsBnk/TX28tnkJeHY209cpIk8HbZtlriut1Ur5yXh
	IX7yJwLigtyWM6v3MZMhv7xPUP4vwpVO+matb3QE8rB43b+6VpSYZXH5ysm6n3IwHCMEIxmS4bR
	BT9t5f2dWzR3MJsQp3RgVp+orwTxQX0vRa29mQd6Avwze1VCBQApT1fJb7JXn1JmM97AHjh+IlI
	NDMn8e0PbG/Hd/S3LKtAIrqYa+OcGBiVkQVQzGXLMyL8SYVB2nLNHRJepQ==
X-Google-Smtp-Source: AGHT+IHLvX1dDdiS2RfLnxL7zTZTGdoNfW2b0QcJx6cyMgrRNPER1Nn1XvyIVU1RrBXU5JhG4RklBw==
X-Received: by 2002:a05:6a20:d818:b0:1e1:ad90:dda6 with SMTP id adf61e73a8af0-1ede832f594mr1163714637.20.1738709009758;
        Tue, 04 Feb 2025 14:43:29 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bfdasm11286156b3a.16.2025.02.04.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:43:29 -0800 (PST)
Date: Tue, 4 Feb 2025 14:43:26 -0800
From: Joe Damato <jdamato@fastly.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	shayd@nvidia.com, akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v7 2/5] net: napi: add CPU affinity to
 napi_config
Message-ID: <Z6KYDs0os_DizhMa@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
 <20250204220622.156061-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204220622.156061-3-ahmed.zaki@intel.com>

On Tue, Feb 04, 2025 at 03:06:19PM -0700, Ahmed Zaki wrote:
> A common task for most drivers is to remember the user-set CPU affinity
> to its IRQs. On each netdev reset, the driver should re-assign the
> user's settings to the IRQs.
> 
> Add CPU affinity mask to napi_config. To delegate the CPU affinity
> management to the core, drivers must:
>  1 - set the new netdev flag "irq_affinity_auto":
>                                        netif_enable_irq_affinity(netdev)
>  2 - create the napi with persistent config:
>                                        netif_napi_add_config()
>  3 - bind an IRQ to the napi instance: netif_napi_set_irq()
> 
> the core will then make sure to use re-assign affinity to the napi's
> IRQ.
> 
> The default IRQ mask is set to one cpu starting from the closest NUMA.

Not sure, but maybe the above should be documented somewhere like
Documentation/networking/napi.rst or similar?

Maybe that's too nit-picky, though, since the per-NAPI config stuff
never made it into the docs (I'll propose a patch to fix that).

> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  include/linux/netdevice.h | 14 +++++++--
>  net/core/dev.c            | 62 +++++++++++++++++++++++++++++++--------
>  2 files changed, 61 insertions(+), 15 deletions(-)

[...]
 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 33e84477c9c2..4cde7ac31e74 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[...]

> @@ -6968,17 +6983,28 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
>  {
>  	int rc;
>  
> -	/* Remove existing rmap entries */
> -	if (napi->dev->rx_cpu_rmap_auto &&
> +	/* Remove existing resources */
> +	if ((napi->dev->rx_cpu_rmap_auto || napi->dev->irq_affinity_auto) &&
>  	    napi->irq != irq && napi->irq > 0)
>  		irq_set_affinity_notifier(napi->irq, NULL);
>  
>  	napi->irq = irq;
> -	if (irq > 0) {
> +	if (irq < 0)
> +		return;
> +
> +	if (napi->dev->rx_cpu_rmap_auto) {
>  		rc = napi_irq_cpu_rmap_add(napi, irq);
>  		if (rc)
>  			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
>  				    rc);
> +	} else if (napi->config && napi->dev->irq_affinity_auto) {
> +		napi->notify.notify = netif_napi_irq_notify;
> +		napi->notify.release = netif_napi_affinity_release;
> +
> +		rc = irq_set_affinity_notifier(irq, &napi->notify);
> +		if (rc)
> +			netdev_warn(napi->dev, "Unable to set IRQ notifier (%d)\n",
> +				    rc);
>  	}

Should there be a WARN_ON or WARN_ON_ONCE in here somewhere if the
driver calls netif_napi_set_irq_locked but did not link NAPI config
with a call to netif_napi_add_config?

It seems like in that case the driver is buggy and a warning might
be helpful.

