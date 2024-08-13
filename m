Return-Path: <netdev+bounces-117972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502C9501EE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5965A1C22104
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C89199EA5;
	Tue, 13 Aug 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="E5wf1B8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02B19412F
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543395; cv=none; b=WHkmDJLuTrWsV/cGyqofFldVfpWA35HlHE+W+2j7KRt2iogtWRRQAEDlo1zisuTjdYVx5nKF9fZ03GYMYUW/HKp7Z/PcCH2H1yDnKeMzr++rBPTyyfXgccyzQAH5fKFf774UIVGIMOSRvLPP2kLMGO0i82VffG04XgY43iSDL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543395; c=relaxed/simple;
	bh=6hHxBTF20IAqMcrcWgWzdAZWnXVDz98qQ4rdoPVmnc4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4/k1RFLcIMlGaeN/xODOon64HOCBpsTV0vCJK03aUOJy7wil0blsONluAZ9CK+In+FZWihQZufdApVJ+nPFjqIXivg18epX8x9CV+ic3PqGsSEFSMEA7pAvmjFSR3yGQpOq6bpMfCAY7QJuux95A2Hps8xmnL8SdrFaTjaXaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=E5wf1B8F; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428178fc07eso36562805e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723543392; x=1724148192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T04SXkyqQZxIqmQoVlUZ/CBkiEUBgtICNJn27Tj+HX4=;
        b=E5wf1B8FAjtnaBuf7THonqU71JA7t9Nl73QoWTn7t0uDww52MjyP/tfdsZsXMwSjnY
         YDtgsa9JxAHTZhVTPAAYRu0C3EEn45pfPXGGYkTG4ra7PMR5oJupSq9EYCfiiANoqqBI
         DW4+1qnlC9rtF3f4Ip9nXItAaRvht3gvg2d9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543392; x=1724148192;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T04SXkyqQZxIqmQoVlUZ/CBkiEUBgtICNJn27Tj+HX4=;
        b=qxq3pCekQlXxVtKqHY7+PbtLl4k4voyXQjrufRdOwbAi3ODKibxf68ANYYTpv8mbGt
         hK4eEmgXDLuhjsWBKAivI39E6bzp7FJ6BPMN0nlTOl7AwFv7AhBFaEp33fn67jcfgHW0
         RY3BljIpflNvgfxyYcR2NRjHRFi2g7ZVmBxpW4FDE6a5dqDBOTfYeTA58vdpre1dDlJc
         qOWOWVfCrYRm8Tf4rhXwPWA5T9IRShvfX4Wrlf2ptjeQ2Y+dRKU8raHFTaE+eNkfIWYG
         OKTZ2von4Wyp8t/0dM2O8mNH+VD0bDJTHfeIxhviImNlckXLw0mrAK5nDMUUxw84iQcQ
         5NOg==
X-Forwarded-Encrypted: i=1; AJvYcCVZdtdZ26e+sijHhueuhTMV/yCfXLtzHAMxQ9VyzzhgeT2x8I+BY+5ec93OJ7Hgtt/HuChKiyOfqrB+2AIx4h/A6+Y+qbc3
X-Gm-Message-State: AOJu0YzbFCfXtj1S8LfC4+gtTU6Ki4ryN1LQdVlhXOH+Hcyr+d9pEEcj
	OuBKHUYBdyl3nBuGDfa+269qHhGDvBGZlQJDn3DcgftLuXCNyRgbpNXIiWipQHHWQiNn2L5iwgj
	mW6w=
X-Google-Smtp-Source: AGHT+IEVxsJQrPna8BnBBYWvsnS69mNeRLqPL9TBeudC2bV7VmS8DrvjKf95gf3mTw2by5VUOuVCKA==
X-Received: by 2002:a05:600c:198b:b0:426:618f:1a31 with SMTP id 5b1f17b1804b1-429d48a5287mr22432755e9.34.1723543391613;
        Tue, 13 Aug 2024 03:03:11 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c739083sm211899095e9.18.2024.08.13.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:03:11 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:03:09 +0100
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Message-ID: <ZrsvXQ0FGAdtgUaQ@LQ3V64L9R2.home>
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
 <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrsjLS8wRcYL3HxQ@LQ3V64L9R2.home>

On Tue, Aug 13, 2024 at 10:11:09AM +0100, Joe Damato wrote:
> On Mon, Aug 12, 2024 at 03:36:42PM -0700, Stanislav Fomichev wrote:
> > On 08/12, Joe Damato wrote:
> > > On Mon, Aug 12, 2024 at 01:23:27PM -0700, Stanislav Fomichev wrote:
> > > > On 08/12, Joe Damato wrote:
> > > > > Several drivers have their own, very similar, implementations of
> > > > > determining if IRQ affinity has changed. Create napi_affinity_no_change
> > > > > to centralize this logic in the core.
> > > > > 
> > > > > This will be used in following commits for various drivers to eliminate
> > > > > duplicated code.
> > > > > 
> 
> [...]
> 
> > > > > +bool napi_affinity_no_change(unsigned int irq)
> > > > > +{
> > > > > +	int cpu_curr = smp_processor_id();
> > > > > +	const struct cpumask *aff_mask;
> > > > > +
> > > > 
> > > > [..]
> > > > 
> > > > > +	aff_mask = irq_get_effective_affinity_mask(irq);
> > > > 
> > > > Most drivers don't seem to call this on every napi_poll (and
> > > > cache the aff_mask somewhere instead). Should we try to keep this
> > > > out of the past path as well?
> > > 
> > > Hm, I see what you mean. It looks like only gve calls it on every
> > > poll, while the others use a cached value.
> > > 
> > > Maybe a better solution is to:
> > >   1. Have the helper take the cached affinity mask from the driver
> > >      and return true/false.
> > >   2. Update gve to cache the mask (like the other 4 are doing).
> > 
> > SG! GVE is definitely the outlier here.
> 
> OK, I'll hack on that for rfcv2 and see what it looks like. Thanks
> for the suggestion.

Yea, I just did this for rfcv2 and it looks a lot nicer/fewer
changes. Will hold off on sending an rfc v2 until the 48 hour timer
expires ;)

> Hopefully the maintainers (or other folks) will chime in on whether
> or not I should submit fixes for patches 4 - 6 for the type mismatch
> stuff first or just handle it all together.

