Return-Path: <netdev+bounces-133799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0399713C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DF728264B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF91F4730;
	Wed,  9 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XoVKaUu0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFA1F4707
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490429; cv=none; b=T3VTAuclcpN4lFrQNVN4MWYDxT0X7ghHzPoYG3DX2U6+r3NeaMpz9mJw+lcDSORHL1LzRjG5YVtT7Q3ko5H4biVDm8bpYwCoNVb2PNNLM1e+bNqsFpOcIjqRE0eOrTIkusM8HMaHAOBmbP1u2nzaUPYwSrzmlXZUe81v4GpiD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490429; c=relaxed/simple;
	bh=qRDhwbKc4gqUv4odZFgBRE0svDDR1jk8/VJtFT5BLpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHz+WqqlPS0MHUCoSbFbCqWMwu8ZhWlcXVUU5ZqWWL5eVrxqsXo5UyXeC6HWezg8LlE+qPwK3FzgqQBAluf3V96+n6KLr7SwJIOFvmmVj4XjA/PbILf5j6sCRUniFc6xPvrjEekw6xcStRdPNh1eAGPdzaCbt6RX3mX9k/ZqH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XoVKaUu0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71df7632055so4156143b3a.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728490426; x=1729095226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I33A6jYeY45I8ALsp4gxb0eFudKjIyGKk+ralmB1OTU=;
        b=XoVKaUu0G1Rst4uSlyRoYXVfFtnrboa/r9k4ROZ3JBauitnIZwVtHZcheD4q55SBNs
         nJq1dqNOghuDvZW44ATEXNHUfykrfxu9tuqTPPxzKE4GqcNvr3f56+YAWR1ueV+arm7u
         WOa5nnVRCG0A7ylr0cUrcg80l/fgCzjtnl8C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490426; x=1729095226;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I33A6jYeY45I8ALsp4gxb0eFudKjIyGKk+ralmB1OTU=;
        b=Rag5Vho63G04DUbTFVJ9RUewx7ru/LgdIfcDjea4jV8OuWtwQEWV0pjznAcC0RVibN
         zqrIpRuM1l1gRaM0AvzFKxzyoGov0B7yohQqT2Q5RV8eZL1X8H5EfWDeGDm07YiOMlEQ
         HAm3npaiEIDBkTk7bnSYoFyd4EFfrx6FLbdF1cId8uZF32QDguRu1Bm3vUowYJuGFFKR
         PlToHG89rTSpvNK3tAAOIZ5wc7/pvxyKc7Nt7FyBAw+dXOGnpJf+917MKzZsY1jdkYcy
         31sYR7ApO8xIel4iv6JOyr8LvfXqaBEAHS0RVuwmyocKHlTiWWubIKuVURIXFk2jlXtP
         SZEw==
X-Forwarded-Encrypted: i=1; AJvYcCWwAXi99GaB3FpmXmrO0aV1HWZ7Pi3Nll0zuisbZKvPZIATrKCLxH9y0wfkwBe8Ft2s/GsaItU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAUU4gPsuDvXHDeQMOli4AffuIcgLm4UYaS3axPlfgjXfV22A
	cTDnPic+I2tf+AOFGp2cWEPDBeINhc5irNLTCk1UCBiA/88eXqncKyEMVpAVKog=
X-Google-Smtp-Source: AGHT+IE+LFDDXBBvy4teY9len83ORvaHirPjVhFZMIZBw5XnRw0clMLhZarJLPm7Q34wgwkMUTUgLw==
X-Received: by 2002:a05:6a00:2d83:b0:71d:e93e:f53b with SMTP id d2e1a72fcca58-71e1dbbc1cemr5337089b3a.22.1728490426111;
        Wed, 09 Oct 2024 09:13:46 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbba1csm7968933b3a.33.2024.10.09.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:13:45 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:13:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH v1 08/15] net: add helper executing custom callback from
 napi
Message-ID: <ZwartzLxnL7MXam6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	io-uring@vger.kernel.org, netdev@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-9-dw@davidwei.uk>
 <ZwWxQjov3Zc_oeiR@LQ3V64L9R2>
 <6e20af86-8b37-4e84-8ac9-ab9f8c215d00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e20af86-8b37-4e84-8ac9-ab9f8c215d00@gmail.com>

On Wed, Oct 09, 2024 at 04:09:53PM +0100, Pavel Begunkov wrote:
> On 10/8/24 23:25, Joe Damato wrote:
> > On Mon, Oct 07, 2024 at 03:15:56PM -0700, David Wei wrote:
> > > From: Pavel Begunkov <asml.silence@gmail.com>
> > 
> > [...]
> > 
> > > However, from time to time we need to synchronise with the napi, for
> > > example to add more user memory or allocate fallback buffers. Add a
> > > helper function napi_execute that allows to run a custom callback from
> > > under napi context so that it can access and modify napi protected
> > > parts of io_uring. It works similar to busy polling and stops napi from
> > > running in the meantime, so it's supposed to be a slow control path.
> > > 
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: David Wei <dw@davidwei.uk>
> > 
> > [...]
> > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 1e740faf9e78..ba2f43cf5517 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6497,6 +6497,59 @@ void napi_busy_loop(unsigned int napi_id,
> > >   }
> > >   EXPORT_SYMBOL(napi_busy_loop);
> > > +void napi_execute(unsigned napi_id,
> > > +		  void (*cb)(void *), void *cb_arg)
> > > +{
> > > +	struct napi_struct *napi;
> > > +	bool done = false;
> > > +	unsigned long val;
> > > +	void *have_poll_lock = NULL;
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	napi = napi_by_id(napi_id);
> > > +	if (!napi) {
> > > +		rcu_read_unlock();
> > > +		return;
> > > +	}
> > > +
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > +		preempt_disable();
> > > +	for (;;) {
> > > +		local_bh_disable();
> > > +		val = READ_ONCE(napi->state);
> > > +
> > > +		/* If multiple threads are competing for this napi,
> > > +		* we avoid dirtying napi->state as much as we can.
> > > +		*/
> > > +		if (val & (NAPIF_STATE_DISABLE | NAPIF_STATE_SCHED |
> > > +			  NAPIF_STATE_IN_BUSY_POLL))
> > > +			goto restart;
> > > +
> > > +		if (cmpxchg(&napi->state, val,
> > > +			   val | NAPIF_STATE_IN_BUSY_POLL |
> > > +				 NAPIF_STATE_SCHED) != val)
> > > +			goto restart;
> > > +
> > > +		have_poll_lock = netpoll_poll_lock(napi);
> > > +		cb(cb_arg);
> > 
> > A lot of the above code seems quite similar to __napi_busy_loop, as
> > you mentioned.
> > 
> > It might be too painful, but I can't help but wonder if there's a
> > way to refactor this to use common helpers or something?
> > 
> > I had been thinking that the napi->state check /
> > cmpxchg could maybe be refactored to avoid being repeated in both
> > places?
> 
> Yep, I can add a helper for that, but I'm not sure how to
> deduplicate it further while trying not to pollute the
> napi polling path.

It was just a minor nit; I wouldn't want to hold back this important
work just for that.

I'm still looking at the code myself to see if I can see a better
arrangement of the code.

But that could always come later as a cleanup for -next ?

