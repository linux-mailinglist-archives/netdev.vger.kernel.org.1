Return-Path: <netdev+bounces-160641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC73A1AA53
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968981688E7
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3273219D060;
	Thu, 23 Jan 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CzDIwPrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E101BC4E
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660510; cv=none; b=COui0Qfn31xinywYjlyQ2BSxKuuiV1mhV7jKUMRWyUvtkMOybQxFBs/W/xGARicG1WiERHLrI67r2TQVGjpAozJvaO8Aozik6KrSO9pFIEuujX0V75w7oezo9CDCBU5HbMYCqsP1yPbtxgtHeIQZbu46g/YWAo+v1SXUgesGU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660510; c=relaxed/simple;
	bh=jSxGbIeuK0BQTLuGqtoPdHuiGBZaDDjr2RGh/rcenp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/qLB9QsEiC2bP+M6BSUvy7AIB17cfGEfnk3ptRMjFz7vD5KJpQVMv5vyfmmwrMFnLxRWtFSWFtRdYGTDP7i+MB0wsOAWuGFK2HuFr8G6ofsW1KI6Q9G3Yl9XVT2L6+HogvlAWdOAMioyIfFk6zA63++PW0kthCqAdkXwbK+MoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CzDIwPrl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21628b3fe7dso22840135ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737660507; x=1738265307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKSMGBTjadOJ4VDIZc+QO+zb8RTG8n/S2QkYxKJfkO8=;
        b=CzDIwPrloKThcdDISUimqU258zRipUeB4QVg+MGp0gjZs/hbDvd9GSC/uGyCYxLZ5k
         XKXCjM7wvWON0CT2+EuKwO89Ag/w9GcIc7TIE3kavF7VqMdlOFmTUasYeLNvdM0zwaWl
         sz7RheCSmpK04XsYCT2Z4ekazDUwy5Mc0pusw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660507; x=1738265307;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKSMGBTjadOJ4VDIZc+QO+zb8RTG8n/S2QkYxKJfkO8=;
        b=TLVSDvgLGeUvKSRZFkO1AwLN1XQ5xEE9fF3yxTUKya45EbYHN3oXAb+rskfcthm3Ju
         Lx11R7PRXw6CwSj9U4LsZW2ydzkyAdcW4gTK+FZb3tjCdNwp9itlSWUnGVCy4wJLPI/1
         0Yl8tSQZ+L0rSXPQDTDpjwe6PIhIk7cBf5vOK4AFYUDae0RrcpPR2TXXmigMzkQ08iO2
         2xpU928SIZ31ZyzEuo+B1xsUU33OKZPdonKGLRvxcG8561TK0oxo0pDCg4dupvfFcX1o
         m6noD4EPI3QCb1FgM4Q6IlozBb41V3RkSEWA7lPgJEgnmzcBI/tXelE4TisjbDHAezpR
         xtZQ==
X-Gm-Message-State: AOJu0YygIEF1mifhn3tJKuhlI6XydTXSIlWpAyeAcMCyUiY94S+mSh5i
	3QU7HrPk3BG8+LC8c2HmfFV9maih+ax7FK1TMqLdFQ13XvKsVzRzQ1zo7xm7Dqk=
X-Gm-Gg: ASbGncsFr7AmgxgwSDo03NtEN2IZhOnZOpH/XYhcO3iDQgVjClLwaik94eeqJE3EGsJ
	Aj1kc9SPwe8fXLvQ423BwMNmsFeHmpR5zYXwLC03QErRdGjC6Jyp9Ua0GH221C9ZUhL7UF6RnWp
	o8IEoRpJfOurhphN3NGByGN7o7ihsu3TLH4d5IVO9j06BsDDWIqRsZpFx6b+09KtlLqeflDce5E
	QbbGbR/I57P+OG5V+OMme3R9fIji9nkVUmBGIVYdHvbgro9t83v1TcuznZSCojxMb2PMFg0GAgx
	wjgHrCqNzEbb+6YKltTmUjBXY6e418vhFL0KCwjNoE/Z3Qs=
X-Google-Smtp-Source: AGHT+IEubu9AdSDBuPgbBe6xyKegk7df8UxI964eqYegV8p/KlH2pZuqJ+bfRr+mhcSVHCdBhdXr0Q==
X-Received: by 2002:a05:6a00:9296:b0:72d:4d77:ccc with SMTP id d2e1a72fcca58-72daf94857emr35659747b3a.6.1737660507547;
        Thu, 23 Jan 2025 11:28:27 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b7262sm311632b3a.71.2025.01.23.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:28:27 -0800 (PST)
Date: Thu, 23 Jan 2025 11:28:24 -0800
From: Joe Damato <jdamato@fastly.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	shayd@nvidia.com, akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	David Arinzon <darinzon@amazon.com>
Subject: Re: [PATCH net-next v6 1/5] net: move ARFS rmap management to core
Message-ID: <Z5KYWAshgRL2GbX2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	David Arinzon <darinzon@amazon.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
 <20250118003335.155379-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118003335.155379-2-ahmed.zaki@intel.com>

On Fri, Jan 17, 2025 at 05:33:31PM -0700, Ahmed Zaki wrote:
> Add a new netdev flag "rx_cpu_rmap_auto". Drivers supporting ARFS should
> set the flag via netif_enable_cpu_rmap() and core will allocate and manage
> the ARFS rmap. Freeing the rmap is also done by core when the netdev is
> freed.
> 
> For better IRQ affinity management, move the IRQ rmap notifier inside the
> napi_struct. Consequently, add new notify.notify and notify.release
> functions: netif_irq_cpu_rmap_notify() and netif_napi_affinity_release().
> 
> Acked-by: David Arinzon <darinzon@amazon.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index fe5f5855593d..dbb63005bc2b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6862,6 +6862,141 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
>  }
>  EXPORT_SYMBOL(netif_queue_set_napi);
>  
> +#ifdef CONFIG_RFS_ACCEL
> +static void
> +netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
> +			  const cpumask_t *mask)
> +{
> +	struct napi_struct *napi =
> +		container_of(notify, struct napi_struct, notify);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int err;

I wonder if this generates a warning with some compilers? err is
defined not used if !napi->dev->rx_cpu_rmap_auto ? Not sure.

> +	if (napi->dev->rx_cpu_rmap_auto) {
> +		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
> +		if (err)
> +			pr_warn("%s: RMAP update failed (%d)\n",
> +				__func__, err);
> +	}
> +}
> +
> +static void netif_napi_affinity_release(struct kref *ref)
> +{
> +	struct napi_struct *napi =
> +		container_of(ref, struct napi_struct, notify.kref);
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +
> +	if (!napi->dev->rx_cpu_rmap_auto)
> +		return;
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;
> +	cpu_rmap_put(rmap);
> +}
> +
> +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> +{
> +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> +	int rc;
> +
> +	if (!rmap)
> +		return -EINVAL;
> +
> +	napi->notify.notify = netif_irq_cpu_rmap_notify;
> +	napi->notify.release = netif_napi_affinity_release;

Maybe the callbacks should only be set at the end after everything
else is successful, just before the return 0 ?

> +	cpu_rmap_get(rmap);
> +	rc = cpu_rmap_add(rmap, napi);
> +	if (rc < 0)
> +		goto err_add;
> +
> +	napi->napi_rmap_idx = rc;
> +	rc = irq_set_affinity_notifier(irq, &napi->notify);
> +	if (rc)
> +		goto err_set;
> +
> +	return 0;
> +
> +err_set:
> +	rmap->obj[napi->napi_rmap_idx] = NULL;
> +	napi->napi_rmap_idx = -1;
> +err_add:
> +	cpu_rmap_put(rmap);
> +	return rc;
> +}

[...]

> +void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
> +{
> +	int rc;
> +
> +	if (!napi->dev->rx_cpu_rmap_auto)
> +		goto out;

Maybe the above if statement could be extended to be something like:

if (!napi->dev->rx_cpu_rmap_auto || napi->irq < 0)
  goto out;

then you can omit the irq > 0 checks in the code below, potentially?

> +	/* Remove existing rmap entries */
> +	if (napi->irq != irq && napi->irq > 0)
> +		irq_set_affinity_notifier(napi->irq, NULL);
> +
> +	if (irq > 0) {
> +		rc = napi_irq_cpu_rmap_add(napi, irq);
> +		if (rc) {
> +			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
> +				    rc);
> +			netif_disable_cpu_rmap(napi->dev);
> +		}
> +	}
> +
> +out:
> +	napi->irq = irq;
> +}
> +EXPORT_SYMBOL(netif_napi_set_irq_locked);
> +

