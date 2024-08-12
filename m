Return-Path: <netdev+bounces-117867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1A94F9A1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D0D1C21D8A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B00197552;
	Mon, 12 Aug 2024 22:36:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53015C12D;
	Mon, 12 Aug 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502206; cv=none; b=uCL0plH5aVVJZDBq23YhWhm9EPiLXUOJ0AsqSB/1GMerJnIhtgQC3YTYR3Ygzi4S2shAHQmmyLFIOEhBRzO3q4/xNDBLk5zGgYhU30KGDkydW6BGc6HHGe+2jl6Z+9evJ9K9cy4bvq74GSGTQKtObF7/PIf5ZzKh/8keTirV858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502206; c=relaxed/simple;
	bh=zDJBhDhtdAttr6bD6Xx+fnzy6MREQDSWCK0Lhhbhe5k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6l4lXatLy7TMOHYxEkA7bVz1kV/yUhoUW4po4uelB9zWhNJe06dTnD2ibk6qtGDimuQo8pKBjU2NrAhpnzKT73+kAvib95rpJcD4t3OzVFCS/b0mUN+vtrN3l7ZxTR6Md/bLbJBketUbvvDwjc53y4jgYFwS0ieV0bwQYeYmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd66cddd07so32808095ad.2;
        Mon, 12 Aug 2024 15:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502204; x=1724107004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kJTXJ6jtU2DKRYKjnIVk+t7LGeS8/CPrgvmQD8N7Go=;
        b=DY/OS1It3dzOJWL92f1sqD00ZDzKgYEpdqlji9jiAAeF0q7rDMxCbcPCXwB+1jt1jA
         7swHSQYpyYcmvb1jy4dyQdV9eAr/3ftTyk3/uro4a/Eb7WhEsSsRVARd/U12bORTsRWj
         cE3/DT3fD2nWzR8avdi1MEPweANXl5hwIGNfhH9qcq5ztJRrQc9aF2Vf2uPht9nAon06
         7pAit2DaS81ci481VC84NZmChD/cFGvYjd/EPHlp2ilNVjLPJSiK91b38HV56W9JEIRY
         i302c/r/d5TtOhz9V9ITGJWiso1odoCBhaaonZlClTL7M9dsMzUvggNuzHVpLTQWeyay
         /12A==
X-Forwarded-Encrypted: i=1; AJvYcCVxiHK6wbpDhtxdmiWDr8VKHDE5Q7nCI6bry479FNDiEzXVMLyooUvpp9ixAy7JfNF3i+FFK4ebhN6m7M0mNgMF/9RFhgDSN9fZqqmpcQ4D1nO4mdfqvWvPbSYCjnJc/zik1jNQ
X-Gm-Message-State: AOJu0YyIYdlQIUsLJyLEyQrC2XhHocjf+CqpyKxvUPJgchkk5Xc/zvFU
	yitLV7Z/nHnVzTeCg2kdS7uejR3MBbTqwPCnw26bUF00yl2lLPE=
X-Google-Smtp-Source: AGHT+IEHbIoGQUa0fKLseh2OcMohaSp9zVg9hH2IznCSsCTFzjufpP5AHZkKqvnzzynMIuf4/zxK2w==
X-Received: by 2002:a17:903:24d:b0:1fb:5813:998c with SMTP id d9443c01a7336-201ca13794bmr21950645ad.20.1723502203989;
        Mon, 12 Aug 2024 15:36:43 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1b8417sm1700085ad.187.2024.08.12.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 15:36:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 15:36:42 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Message-ID: <ZrqOekK43_YyMHmR@mini-arch>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240812145633.52911-2-jdamato@fastly.com>
 <ZrpvP_QSYkJM9Mqw@mini-arch>
 <Zrp50DnNfbOJoKr7@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zrp50DnNfbOJoKr7@LQ3V64L9R2.home>

On 08/12, Joe Damato wrote:
> On Mon, Aug 12, 2024 at 01:23:27PM -0700, Stanislav Fomichev wrote:
> > On 08/12, Joe Damato wrote:
> > > Several drivers have their own, very similar, implementations of
> > > determining if IRQ affinity has changed. Create napi_affinity_no_change
> > > to centralize this logic in the core.
> > > 
> > > This will be used in following commits for various drivers to eliminate
> > > duplicated code.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  include/linux/netdevice.h |  8 ++++++++
> > >  net/core/dev.c            | 14 ++++++++++++++
> > >  2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 0ef3eaa23f4b..dc714a04b90a 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -464,6 +464,14 @@ enum rx_handler_result {
> > >  typedef enum rx_handler_result rx_handler_result_t;
> > >  typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
> > >  
> > > +/**
> > > + * napi_affinity_no_change - determine if CPU affinity changed
> > > + * @irq: the IRQ whose affinity may have changed
> > > + *
> > > + * Return true if the CPU affinity has NOT changed, false otherwise.
> > > + */
> > > +bool napi_affinity_no_change(unsigned int irq);
> > > +
> > >  void __napi_schedule(struct napi_struct *n);
> > >  void __napi_schedule_irqoff(struct napi_struct *n);
> > >  
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 751d9b70e6ad..9c56ad49490c 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -89,6 +89,7 @@
> > >  #include <linux/errno.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/if_ether.h>
> > > +#include <linux/irq.h>
> > >  #include <linux/netdevice.h>
> > >  #include <linux/etherdevice.h>
> > >  #include <linux/ethtool.h>
> > > @@ -6210,6 +6211,19 @@ void __napi_schedule_irqoff(struct napi_struct *n)
> > >  }
> > >  EXPORT_SYMBOL(__napi_schedule_irqoff);
> > >  
> > > +bool napi_affinity_no_change(unsigned int irq)
> > > +{
> > > +	int cpu_curr = smp_processor_id();
> > > +	const struct cpumask *aff_mask;
> > > +
> > 
> > [..]
> > 
> > > +	aff_mask = irq_get_effective_affinity_mask(irq);
> > 
> > Most drivers don't seem to call this on every napi_poll (and
> > cache the aff_mask somewhere instead). Should we try to keep this
> > out of the past path as well?
> 
> Hm, I see what you mean. It looks like only gve calls it on every
> poll, while the others use a cached value.
> 
> Maybe a better solution is to:
>   1. Have the helper take the cached affinity mask from the driver
>      and return true/false.
>   2. Update gve to cache the mask (like the other 4 are doing).

SG! GVE is definitely the outlier here.

> FWIW, it seems i40e added this code to solve a specific bug [1] and
> I would assume other drivers either hit the same issue (or were
> inspired by i40e).
> 
> In general: I think the logic is here to stay and other drivers may
> do something similar in the future.

+1 on pushing this logic to the core if possible.

> It'd be nice to have one helper instead of several different
> copies/implementations.
> 
> [1]: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/1473895479-23035-9-git-send-email-bimmy.pujari@intel.com/

