Return-Path: <netdev+bounces-117956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A20950100
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37051F2411A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3118953E;
	Tue, 13 Aug 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="BQi6AnwT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68217BB19
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540274; cv=none; b=cANLtodKe/4TkXQRjE5o9zh2aZQTTDoHckVutEUF+HMrvwxR2GmMYn88gnr38yLoY2bS6RBLVT3qJuH8+BCFt7HVaDCaeuk9NNtZoFtoS09ozPqovXYakaxqpVVGj64StQE5cxOKvxla9xGXXDA9l8uBDagyXHo+wULiKcCNNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540274; c=relaxed/simple;
	bh=hf38bQZuWM3dp+pnlJL9eh4Uv0Yip7KWObG1Cg7zjLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1ZRTzNwq0F9rc4lk412098ZztU2LQI+UDvpdv+ZwUjwN6RQalYQez3C4zzFFwWYE+nf22YWCJYuieeLAlNTcPUM6Wjt1Ir6e5n3x8X3ZifxequdvVSVhCvfBxa7WL+fwfIbnV54nIr0HnYF4Bup8Kf40hCEnbUcXRrV2L6XMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=BQi6AnwT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso5336965e87.0
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723540271; x=1724145071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJFdYK5G5aYcfJcV8ZQsQv/iO29PbtuZR/QhPd3XK64=;
        b=BQi6AnwTBkpXynqeaxIhGlTq9pEB+90HIF7G1QvxVmZdNXQ9xN+a7FRYWpVMjjX3yV
         W/lBhalqiJMILdURjwBbZgNnufqSp+gZJEJYAI8sbXV/wngDOdZJ+K0lhm/clyl9v4Rr
         cvGN74/d0yUlokXehzVHKRd7n+e3Q9t/SmmKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723540271; x=1724145071;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJFdYK5G5aYcfJcV8ZQsQv/iO29PbtuZR/QhPd3XK64=;
        b=b31qjBHqq8TK9gLBfdcZQDL5XaHPs3MmhiHV25r/+9WxRmCKOG7VmMwU1Guh2TStuN
         eZLQeJADnp9ZqJIyS/2VhoEsjmcK4f6wxwLFOrdVgNcXSy6KKNwikAgSSvTXU2b2u1Ef
         dVpAe0VVHGCoocgdBxIZR5JPZ4/z/yONsKe42uNncdyqU8xCxbC3sXUpSccwKRd9ORE0
         c5Ej2AhbOXAWSoI19NF8gdxojuDBHdqAs/ZF88INS8yvMsEX9Li0sNIkHc7Tm4p29ZY3
         i6BHGEfn994xV2yGzaGoXt1ulC2v6Q2IcYCokxm7kdaEiTDAWqRFY9g8v/RzY+pTMBz+
         Iywg==
X-Gm-Message-State: AOJu0YxDyHlHNH4F0BCZwnHkxRng62ekUyqhgzAk55dvHrXSsqpFtYbG
	Tns05QTH4MJC20QjA2UNKT7Q5IeqIWH0N6/6TR02fM+w93PFdx4oUjM7nxuB7Rc=
X-Google-Smtp-Source: AGHT+IGRBSscIpDOgFZkQD6PeQTFPL4bgN+hns3by8V7H3bQAYSZz5q4pbgfNyoVXlI+t2vwiNIQyw==
X-Received: by 2002:a05:6512:b86:b0:52e:f950:31e9 with SMTP id 2adb3069b0e04-5321364b9b1mr1803856e87.4.1723540271014;
        Tue, 13 Aug 2024 02:11:11 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37172483bd9sm1004993f8f.0.2024.08.13.02.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 02:11:10 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:11:09 +0100
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
Message-ID: <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>
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
 <Zrp50DnNfbOJoKr7@LQ3V64L9R2.home>
 <ZrqOekK43_YyMHmR@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrqOekK43_YyMHmR@mini-arch>

On Mon, Aug 12, 2024 at 03:36:42PM -0700, Stanislav Fomichev wrote:
> On 08/12, Joe Damato wrote:
> > On Mon, Aug 12, 2024 at 01:23:27PM -0700, Stanislav Fomichev wrote:
> > > On 08/12, Joe Damato wrote:
> > > > Several drivers have their own, very similar, implementations of
> > > > determining if IRQ affinity has changed. Create napi_affinity_no_change
> > > > to centralize this logic in the core.
> > > > 
> > > > This will be used in following commits for various drivers to eliminate
> > > > duplicated code.
> > > > 

[...]

> > > > +bool napi_affinity_no_change(unsigned int irq)
> > > > +{
> > > > +	int cpu_curr = smp_processor_id();
> > > > +	const struct cpumask *aff_mask;
> > > > +
> > > 
> > > [..]
> > > 
> > > > +	aff_mask = irq_get_effective_affinity_mask(irq);
> > > 
> > > Most drivers don't seem to call this on every napi_poll (and
> > > cache the aff_mask somewhere instead). Should we try to keep this
> > > out of the past path as well?
> > 
> > Hm, I see what you mean. It looks like only gve calls it on every
> > poll, while the others use a cached value.
> > 
> > Maybe a better solution is to:
> >   1. Have the helper take the cached affinity mask from the driver
> >      and return true/false.
> >   2. Update gve to cache the mask (like the other 4 are doing).
> 
> SG! GVE is definitely the outlier here.

OK, I'll hack on that for rfcv2 and see what it looks like. Thanks
for the suggestion.

Hopefully the maintainers (or other folks) will chime in on whether
or not I should submit fixes for patches 4 - 6 for the type mismatch
stuff first or just handle it all together.

