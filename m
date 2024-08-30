Return-Path: <netdev+bounces-123620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B26965C65
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8891E286F1D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21E16F8F5;
	Fri, 30 Aug 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ihlintis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178E14BFB4
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009112; cv=none; b=eNTGksEff8LUZ35cVUQVhJQREE0DsxLMazyfcGG+SKh6SuQyl8JURtYkOpzvW7LgYho9rPq4CyK6VeO0zG3h6x5JA6JYkRasVvD8HNXK2FrlNDIa3c8WQQWUxdE6ddSzHnc4OhB56FtoBEsOEansqj/TKcvVPRCtiLV3TXp2GW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009112; c=relaxed/simple;
	bh=igLzx2P0Q4BgBJmWMG/pQIW1Bb2R24MK63C6ZHYhZ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVg2qdVz6guIdav0mivVLYOBGIHnkSnk7i4W07RfFjeTfdIrBcjwF60tby/BjJHOkW7Q67MJsxC/TsRoCV8nE2F4dBVPipLeZctHln0pOcnoTaxxyM2mgPMDJETwlt4gxhjXzW38FGrxyk1eF6k78Iit0kxSGZYU1lp102llIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ihlintis; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8692bbec79so186773366b.3
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725009108; x=1725613908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5lDscXgU2uTbYqa6eX5eVtj+iysBlWQWYTiB0pjzBI=;
        b=ihlintisZ1REv6+h6eqQrPacH2/FO3SvHPF8MMLE+WEJAOWp6yrDhu7LkR9WOOu3e/
         P05jISfY+9lM1bqBOdfNHK7bIxUXI/2tt7nKV9S1OC/O9oEGMO65IQz2xoIBif8szzaZ
         e0UtRitJjinTAT1uVJNcRYcTkUmo2gLJnNiIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009108; x=1725613908;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5lDscXgU2uTbYqa6eX5eVtj+iysBlWQWYTiB0pjzBI=;
        b=iP2K8pS2qzCRyXkeQueJe3G1vmGgNpUI3rVkpI9t87Kq0hX8yGyN1ktRX6TYQczjIK
         0/JbvIzQDwPyw2Luasxay1R2uBnm5tXgbiW4JmlsyWOsruk4cY/ii+KN30JQBkU3oVz1
         m/3q3COg551VBsV9Gxyb202aNxgyCzxgapPOd1fLJvX3OLRBLkDPvilpefYSTgck5KPo
         oUC6kMtvZ4RdEkpRNO3aIg1cObPWQPPnF2YDlO6iSkyRcR7RoPaFXxhgM2U8HqVlfSNB
         Gdufu3oGQD9X9y7ZqBTNkGPimJrsikgiUN7QbCRPoyRLajumfnSVJAxWeDeI+qwsiKZV
         vtoQ==
X-Gm-Message-State: AOJu0Yzcic+D0RzXB8AsKEsAr/r5x2ClztyqnJIozyGS+A/rUvXpfwwe
	xdNrcS7myPxixij7lNKUnA4UqPHE591yrCatawZeBabME2PykK2C3512U9+d9Ho=
X-Google-Smtp-Source: AGHT+IHJQMx/x8KHQOkFY/Rqx1AATh18wd1F4wEQExCNS0KwBHiMh6MWLWKnRCiTfdznaeK8Qa/X5A==
X-Received: by 2002:a17:907:72c7:b0:a86:a30f:4aef with SMTP id a640c23a62f3a-a89a35dee4cmr107185666b.22.1725009107351;
        Fri, 30 Aug 2024 02:11:47 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dacb2sm190338566b.183.2024.08.30.02.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:11:47 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:11:45 +0100
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <ZtGM0QH5lme625-L@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-2-jdamato@fastly.com>
 <20240830083641.GI1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830083641.GI1368797@kernel.org>

On Fri, Aug 30, 2024 at 09:36:41AM +0100, Simon Horman wrote:
> On Thu, Aug 29, 2024 at 01:11:57PM +0000, Joe Damato wrote:
> > Allow per-NAPI defer_hard_irqs setting.
> > 
> > The existing sysfs parameter is respected; writes to sysfs will write to
> > all NAPI structs for the device and the net_device defer_hard_irq field.
> > Reads from sysfs will read from the net_device field.
> > 
> > sysfs code was updated to guard against what appears to be a potential
> > overflow as the field is an int, but the value passed in is an unsigned
> > long.
> > 
> > The ability to set defer_hard_irqs on specific NAPI instances will be
> > added in a later commit, via netdev-genl.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >  include/linux/netdevice.h | 23 +++++++++++++++++++++++
> >  net/core/dev.c            | 29 ++++++++++++++++++++++++++---
> >  net/core/net-sysfs.c      |  5 ++++-
> >  3 files changed, 53 insertions(+), 4 deletions(-)
> 
> ...
> 
> > @@ -534,6 +535,28 @@ static inline void napi_schedule_irqoff(struct napi_struct *n)
> >  		__napi_schedule_irqoff(n);
> >  }
> >  
> > +/**
> > + * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
> > + * @n: napi struct to get the defer_hard_irqs field from
> > + *
> > + * Returns the per-NAPI value of the defar_hard_irqs field.
> > + */
> > +int napi_get_defer_hard_irqs(const struct napi_struct *n);
> 
> Hi Joe,
> 
> As it looks like there will be a v2 anyway, a minor nit from my side.
> 
> Thanks for documenting the return value, but I believe that
> ./scripts/kernel-doc -none -Wall expects "Return: " or "Returns: "
> 
> Likewise in patch 3/5.

Thanks Simon, will make sure to take care of this in the v2.

