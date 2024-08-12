Return-Path: <netdev+bounces-117849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F194F8C2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644741C21E4A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369F18E051;
	Mon, 12 Aug 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B0+ww9Wb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76816C684
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496917; cv=none; b=o082Mw2bJzWRhQ3AKdu9q4dOxXCSZX5UEXVrVyMcQGn5rljFN/vIDkAOPJojgYC/PkhnIyrk7LEfDasQUU3TShMsWNCUuD71h+Qa3S6Iydk+Lofhg70QMSK2ZshGjww3bu8WpYrtG7EQH74cHiDzRr/UQmelcMs+56r+kPpsge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496917; c=relaxed/simple;
	bh=W1j6mxgO+OWXOSW8quovb8phRVwHFPHleTW66KQazt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjZtNDIBKyo1gbKLN8sZU0O8ipuS7KUNk2xD3W1t8d5SkbiN2Jsqa+CgOcZ9dRrYFqFE7KpLD+6GO/3X4cVQ0Kfc/DYJHbQSqqF+KIjzoQRi9kYukv3/jxJOdhpZAxm3Q0w8BRfIs5XYsG8pFeW4MCRuk42CrmTwecaij/Zi+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B0+ww9Wb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367990aaef3so2740757f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723496914; x=1724101714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXxGMbBOPPH8HthklYAuFR2OvHxOblud4txreS4dB4I=;
        b=B0+ww9Wblkclo3IU9KGYLwmoJij8fM91x2GJ6nXhNt1Dyf+bLTePo3Kgbsgz7Y0AWp
         YY/GsI5ZcRYNE1rvCYzD6qMsjjsjeS5hTk/asdatmA6w6tPbpBmBG9l8KsJS2qrK2vem
         mOSUzwbBypI5SDPY5Vjgpgr8YU2AcYPrLfqfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496914; x=1724101714;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXxGMbBOPPH8HthklYAuFR2OvHxOblud4txreS4dB4I=;
        b=Ikd3J0q0ml8JFH9rJKL+pcsIcLs1V5Er/rK0KAtbpW/wmA2dmiN61r7uksOckFx5MC
         Dp8Is54rxgHPHH+LfXUDxUGKFcvM4mmke9LTg/3TS+c7rMJqUPf3LNbvaaF4ayav3Zd5
         4Cs4qNP6zlyoICIKAjLZt8VLVmE+GK5MJsCs6/7HSE63AZBiGfQFwCPy/EvCXb3pWxeR
         2sZpTxB2TTUUt3P1RaXJRTYm8hKbQRr00g78SP1Oys7Lu9FKmXo3HvO85FZJPQQr+xTc
         p0+GKsWBNxD7RzxWYdwxYkOH80x28AOPXMc5E1oyZ/rzFocEdSL8g7dbTGGNLWxlSsv6
         /6rQ==
X-Gm-Message-State: AOJu0YwRNhewTmQKQPALhSYgGcopcBVoLGnBk3tCqKCFVUg3YCfDaVo7
	+tdRgxH4QD/45mYBNBw5JZweFn8fVF8IfG7bD5YqTdDS5tRGn40bjjwLVo7ziLA=
X-Google-Smtp-Source: AGHT+IEs7Ev3jSDKRJahcvnGUdBue9AS4LnjGb1uNGOWDMhCwVgpNVcgvw2oV2TKnykYxJghiIWFRA==
X-Received: by 2002:a5d:6e88:0:b0:367:94a7:12cb with SMTP id ffacd0b85a97d-3716cd290c0mr1247820f8f.43.1723496913881;
        Mon, 12 Aug 2024 14:08:33 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:48e8:39fe:5408:4e74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2accsm8436017f8f.90.2024.08.12.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:08:33 -0700 (PDT)
Date: Mon, 12 Aug 2024 22:08:32 +0100
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Message-ID: <Zrp50DnNfbOJoKr7@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240812145633.52911-2-jdamato@fastly.com>
 <ZrpvP_QSYkJM9Mqw@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrpvP_QSYkJM9Mqw@mini-arch>

On Mon, Aug 12, 2024 at 01:23:27PM -0700, Stanislav Fomichev wrote:
> On 08/12, Joe Damato wrote:
> > Several drivers have their own, very similar, implementations of
> > determining if IRQ affinity has changed. Create napi_affinity_no_change
> > to centralize this logic in the core.
> > 
> > This will be used in following commits for various drivers to eliminate
> > duplicated code.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  include/linux/netdevice.h |  8 ++++++++
> >  net/core/dev.c            | 14 ++++++++++++++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 0ef3eaa23f4b..dc714a04b90a 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -464,6 +464,14 @@ enum rx_handler_result {
> >  typedef enum rx_handler_result rx_handler_result_t;
> >  typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
> >  
> > +/**
> > + * napi_affinity_no_change - determine if CPU affinity changed
> > + * @irq: the IRQ whose affinity may have changed
> > + *
> > + * Return true if the CPU affinity has NOT changed, false otherwise.
> > + */
> > +bool napi_affinity_no_change(unsigned int irq);
> > +
> >  void __napi_schedule(struct napi_struct *n);
> >  void __napi_schedule_irqoff(struct napi_struct *n);
> >  
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 751d9b70e6ad..9c56ad49490c 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -89,6 +89,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/if_ether.h>
> > +#include <linux/irq.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/ethtool.h>
> > @@ -6210,6 +6211,19 @@ void __napi_schedule_irqoff(struct napi_struct *n)
> >  }
> >  EXPORT_SYMBOL(__napi_schedule_irqoff);
> >  
> > +bool napi_affinity_no_change(unsigned int irq)
> > +{
> > +	int cpu_curr = smp_processor_id();
> > +	const struct cpumask *aff_mask;
> > +
> 
> [..]
> 
> > +	aff_mask = irq_get_effective_affinity_mask(irq);
> 
> Most drivers don't seem to call this on every napi_poll (and
> cache the aff_mask somewhere instead). Should we try to keep this
> out of the past path as well?

Hm, I see what you mean. It looks like only gve calls it on every
poll, while the others use a cached value.

Maybe a better solution is to:
  1. Have the helper take the cached affinity mask from the driver
     and return true/false.
  2. Update gve to cache the mask (like the other 4 are doing).

FWIW, it seems i40e added this code to solve a specific bug [1] and
I would assume other drivers either hit the same issue (or were
inspired by i40e).

In general: I think the logic is here to stay and other drivers may
do something similar in the future.

It'd be nice to have one helper instead of several different
copies/implementations.

[1]: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/1473895479-23035-9-git-send-email-bimmy.pujari@intel.com/

