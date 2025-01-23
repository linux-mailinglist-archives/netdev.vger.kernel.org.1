Return-Path: <netdev+bounces-160650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE05A1AB1A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20237A28E4
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EA41B424B;
	Thu, 23 Jan 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="j7rXEkjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08884156F21
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663640; cv=none; b=XBonkAnSaV/xnzCJEQQ8dNI7WkbOXZ8st5adt0BE2zJZyS/umGhO5WplVPEgn4E7icnBK03T7iFSbAdIT9R4CF7gIMUV/025zF6EpPpx9GVJ6S0e2fUx1n6Qxw6ATSAO7WEP3Z6b3TkQyhYmo0pUfb14zpsbWTTntkC97IZ9sOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663640; c=relaxed/simple;
	bh=JpZk763GRNCKNUJRjotRPzNiO/3ojqiNhAdrKYLa/3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o559XHgjOXx5/u/rpVD6t2GHJYWTF6Cf9u3ysyrXRV0Ny9HmcpOmYhZ/nZmg63fOzMFa90H2hk5kTHrzAFp/kfpGDpXBGZQFaPivjsupoApQgj5omD1g+sbhrdWFCrCPrrvr8wuZa45+VnD1h4BrbciUNvgAfVA4RwJ7WUFQ4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=j7rXEkjl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso2044615a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737663638; x=1738268438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB1t1DSHYe/kIJpeHgsnuq5QN3rT3/xSpDRas/TVl9Q=;
        b=j7rXEkjl0scfXd5w42Ko8vISOU2GEkACDW75PCES7vmfE1i9uSIoGWkV4kL5ns8HRT
         zkRDhO0QJyxgm7XfOGl5i2RZdvG2xBLg/7W6PXyBgmTzWqXrD4tJ5gkOsnBIspH1yPhj
         kKhaSrlFyoglzf1mHgas2aIn4nAxvWVTbf/bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663638; x=1738268438;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KB1t1DSHYe/kIJpeHgsnuq5QN3rT3/xSpDRas/TVl9Q=;
        b=w3AmAO86VUT44CYkeOfO11pfbZSnT3Ms2f1ckJ8xdzkxdtdLFRKQBR3IwuPc/Mii6l
         vtR059hSi2uiq5QUkQVCR3IK5ZEw4VpDwXe3rKMV9XVpB/bRAzI0YjI3mSZGU+sNMkOw
         9+b4Z2RP6zN40museQrxJl4C4DGfOsnWD2c/0XCspWsHfoh/rIga92tW1FBCs8fZ/2KO
         HdjPT9McSdSMpWyjCy2wIuaFtY25jP47bHj8xfb6NmfikyqdJCKSaegiRi2JBE5NqxVj
         HQZHSiSj5+9vBcu/qCwe4RPCpLWlK48zadF25DUZ5yOqI0mjAipGLmLXcdJFdHQ0jELG
         BaNQ==
X-Gm-Message-State: AOJu0YyyWDjRbXzr+nm4u5bM7eww2wIc0Bd6mq6Z1rpDHIiZsSgZ9fQc
	EafjhIf7ZAyp/3w0LjoOYq4MLtFaTcDFvEC7phpihwTxvV78z32VGRnsxelH6p0=
X-Gm-Gg: ASbGncuiauml6yDGlhoTyUyyyhdWzgH6q+QPouhSh2bj4q0aGP7lzuXVm+oN5GYP2iW
	DJy9XY5+k7LIYpL/cueIX4fRGOjDWFO6UtSl5Z3dX8qNv7lw+FSEx4nzf65x3VH0dlE5p3mE1e4
	aXnISatk2w4mnnEKqOTBOMF4ue0eJQzmewkwi1r0UVzafUHGrfgFdDwGtdz6TlU39maQb+3XGUX
	P+8vk7XwPRXWkVbyH7me20sLx1Lc+kqPVxnYHCU1/Y/WPn4UTafo8ZjiGrMiacj2mXHTBL5IzL7
	BnlG2QcjDEU/84rHq2wMmq5SWQDjh8ti6XzAYWN6+FxUQzM=
X-Google-Smtp-Source: AGHT+IGWiW4fruTXQaig8VlUH68P+LvfxTOjfstapyawpwKg0R4SlaMZKhcLWLkqA4bHRKxUrinKdg==
X-Received: by 2002:a17:90b:540b:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f782d9a1c9mr34516067a91.34.1737663638298;
        Thu, 23 Jan 2025 12:20:38 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6b315sm127868a91.26.2025.01.23.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:20:37 -0800 (PST)
Date: Thu, 23 Jan 2025 12:20:34 -0800
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
Message-ID: <Z5KkkldrWpw8wayS@LQ3V64L9R2>
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
 <Z5KYWAshgRL2GbX2@LQ3V64L9R2>
 <414c773d-5b7b-44b8-82a7-da49168ee791@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414c773d-5b7b-44b8-82a7-da49168ee791@intel.com>

On Thu, Jan 23, 2025 at 01:13:10PM -0700, Ahmed Zaki wrote:
> 
> 
> On 2025-01-23 12:28 p.m., Joe Damato wrote:
> > On Fri, Jan 17, 2025 at 05:33:31PM -0700, Ahmed Zaki wrote:
> > > Add a new netdev flag "rx_cpu_rmap_auto". Drivers supporting ARFS should
> > > set the flag via netif_enable_cpu_rmap() and core will allocate and manage
> > > the ARFS rmap. Freeing the rmap is also done by core when the netdev is
> > > freed.
> > > 
> > > For better IRQ affinity management, move the IRQ rmap notifier inside the
> > > napi_struct. Consequently, add new notify.notify and notify.release
> > > functions: netif_irq_cpu_rmap_notify() and netif_napi_affinity_release().
> > > 
> > > Acked-by: David Arinzon <darinzon@amazon.com>
> > > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > 
> > [...]
> > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index fe5f5855593d..dbb63005bc2b 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6862,6 +6862,141 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> > >   }
> > >   EXPORT_SYMBOL(netif_queue_set_napi);
> > > +#ifdef CONFIG_RFS_ACCEL
> > > +static void
> > > +netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
> > > +			  const cpumask_t *mask)
> > > +{
> > > +	struct napi_struct *napi =
> > > +		container_of(notify, struct napi_struct, notify);
> > > +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> > > +	int err;
> > 
> > I wonder if this generates a warning with some compilers? err is
> > defined not used if !napi->dev->rx_cpu_rmap_auto ? Not sure.
> > 
> > > +	if (napi->dev->rx_cpu_rmap_auto) {
> > > +		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
> > > +		if (err)
> > > +			pr_warn("%s: RMAP update failed (%d)\n",
> > > +				__func__, err);
> > > +	}
> > > +}
> > > +
> > > +static void netif_napi_affinity_release(struct kref *ref)
> > > +{
> > > +	struct napi_struct *napi =
> > > +		container_of(ref, struct napi_struct, notify.kref);
> > > +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> > > +
> > > +	if (!napi->dev->rx_cpu_rmap_auto)
> > > +		return;
> > > +	rmap->obj[napi->napi_rmap_idx] = NULL;
> > > +	napi->napi_rmap_idx = -1;
> > > +	cpu_rmap_put(rmap);
> > > +}
> > > +
> > > +static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
> > > +{
> > > +	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
> > > +	int rc;
> > > +
> > > +	if (!rmap)
> > > +		return -EINVAL;
> > > +
> > > +	napi->notify.notify = netif_irq_cpu_rmap_notify;
> > > +	napi->notify.release = netif_napi_affinity_release;
> > 
> > Maybe the callbacks should only be set at the end after everything
> > else is successful, just before the return 0 ?
> > 
> 
> I believe this is needed before irq_set_affinity_notifier(), OW we could
> have some racing. I can move it there if you like.
> 
> > > +	cpu_rmap_get(rmap);
> > > +	rc = cpu_rmap_add(rmap, napi);
> > > +	if (rc < 0)
> > > +		goto err_add;
> > > +
> > > +	napi->napi_rmap_idx = rc;
> > > +	rc = irq_set_affinity_notifier(irq, &napi->notify);
> > > +	if (rc)
> > > +		goto err_set;
> > > +
> > > +	return 0;
> > > +
> > > +err_set:
> > > +	rmap->obj[napi->napi_rmap_idx] = NULL;
> > > +	napi->napi_rmap_idx = -1;
> > > +err_add:
> > > +	cpu_rmap_put(rmap);
> > > +	return rc;
> > > +}
> > 
> > [...]
> > 
> > > +void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (!napi->dev->rx_cpu_rmap_auto)
> > > +		goto out;
> > 
> > Maybe the above if statement could be extended to be something like:
> > 
> > if (!napi->dev->rx_cpu_rmap_auto || napi->irq < 0)
> >    goto out;
> > 
> > then you can omit the irq > 0 checks in the code below, potentially?
> 
> I am afraid I don't get this, the checks below one is for the new irq (could
> be valid or -1) and one for the existing (nap->irq).

Ah yes, my mistake; I misread the other half of the if statement
below. My apologies.

> > 
> > > +	/* Remove existing rmap entries */
> > > +	if (napi->irq != irq && napi->irq > 0)
> > > +		irq_set_affinity_notifier(napi->irq, NULL);
> > > +
> > > +	if (irq > 0) {
> > > +		rc = napi_irq_cpu_rmap_add(napi, irq);
> > > +		if (rc) {
> > > +			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
> > > +				    rc);
> > > +			netif_disable_cpu_rmap(napi->dev);
> > > +		}
> > > +	}
> > > +
> > > +out:
> > > +	napi->irq = irq;
> > > +}
> > > +EXPORT_SYMBOL(netif_napi_set_irq_locked);
> > > +
> 
> Thanks.
> 

