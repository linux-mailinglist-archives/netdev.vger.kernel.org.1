Return-Path: <netdev+bounces-171229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19576A4C060
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B793A690A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AA41E86E;
	Mon,  3 Mar 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJOLw+Is"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96693BBD8
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005073; cv=none; b=Bs7HLPrFrf3ne6wX3+T6e4MhY6WRDYe2YP51QWwCTK89DZl1KoP9uKhAUi9O6rp7Hws37j3t0LL8uki0JbXEiYyn8ykNEADTjPZmy0rD13Wo/XVCWw7jZna1KFPNH8gvbGxOpwQ3qJk/g0hPw70UYxrO7m9m5XUMijCSfDHZLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005073; c=relaxed/simple;
	bh=hvzCGzLHJ5+9mefdTG+as7ckHiF0aJJCrB7QfXjbYhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMkWGiwLadL9uvZz3CbwbBL8K3qX/RD62wDJCOrJFjf0VlU4AzG0jJ52EqbKNvJgI2Aqd3TV0yaUjV9fBJWbuyrBmL34F5oe/VhvMIcsOQbcjo25Y9oTqI49zWdIVarOczQLEY80GryutBELHVuVtNrkoANAZkRj2W3u2GhkzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hJOLw+Is; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaec111762bso804719066b.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 04:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741005070; x=1741609870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSJJX56zDhVqdKCOO7Zb5p+mglB7JczLAGdABH1H3qk=;
        b=hJOLw+IsUrNnZTKYKUm1ijs5+5uPMjfxS8edDvmQIpJTOjIw+T14b79nXT7cdX64Tg
         rdAmCnl/j7jd77m4d9EGxYgyv9Pyfc3+KT1iWGACekt8lk+361i64fWdhKd4W6/pyXr1
         9k75YqhiQJyJHmWAqSc1wxxqUsPSRsVDcWsJww+kExmvaORG8oRGSQyWR94vWfhcaB7n
         WvIx9apzWKzsff2JHp80YFDqM6o3X0xX2oO0plk6z3gEaigJNpMjVy65oSRlW+i4k358
         jItD+Ki2sA9mlbzqxAHFczfPdlmadddt7Mz8pPIXQ1Frk1GubqzogvrP/FDPed7dzPGt
         xXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741005070; x=1741609870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSJJX56zDhVqdKCOO7Zb5p+mglB7JczLAGdABH1H3qk=;
        b=VASdq3wEE8oiK2cVZVvlg0Xx+2rxGcgT4HxEo7u7hy8w2yKpTWpat7uzkNprDqsLda
         hZQsop4SCjTcbWWwvS4taJo/KsHZPO0k3+dyhWme2GYwyTaacYfFvxDKPrbvJoEblgbt
         Tura3iACal9zOGD6ouLwF4HGJl4tuwBjbZ+0mr42NLCsFB6zFGkKSD/wMYtNk+ZMg9Vi
         3K0AShyiRAT7I/JZbhaEzHefFvEFS8Z5RF/X18Y0Qz/DRQZ4bnr8UD0hwsK//4Y6aA5s
         nCntrzBwlIvJZGfQTzcYlyqCpErtZwx7QOLvzyW5t/pjB093+xbjZoOIve38aqikmEOU
         7ItA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7KwyN2/KkGomUHOA6blqdhsmwP9SpO4adRni9Mm7wX7SmPTZ8gmAYpW0Xrx/05rvzdBsf3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvrbOG9FKjr2KAXZualsrCRw4ZoYnfioJ57uaQBk0OdBRXomR
	HhfWhW1eV49wuycrN5xf45vvb6PfUK9BNa2fR6lq0HsjrkAd0aFKTWYFbUEYkcH052nBdkGwCCe
	M
X-Gm-Gg: ASbGncvV989kN9YzEkF9yDUTG6qa/nPCXCPw0xE26sJG/og9hbYmqej2UB1saWmt3Cc
	irPiwQZA3VWroql0lRmT4xgN0+fqLKqb0HAcbGtjeMxQAofDRxSe/V9jydqZR6WvmCfsVZmWrxd
	ZirO65mlx9qT1x4vkRawSynqcLINDsvabCtl0elYcOv00XrRsL6IpA2saXHr8XThiGeYCgu5YK5
	5KnXamYcbqVPRtfJ1DeVJreUtR4BzEeIPDPdkklmu1lo8cs7bz4Xyv8k5zYs/yRV4+ugFph4qBh
	SOPRnqhprDv+1uxJGLf7oosIIa78FQlQAPKkndOj/2yhni1rYA==
X-Google-Smtp-Source: AGHT+IHKV3lYMhfvx47Xr6aO9kD/bZ1DuA4juAnVEFf9awkbWhcDx/dzkyGXXFqyty1Heield7dhvg==
X-Received: by 2002:a17:907:3e21:b0:abf:5e61:cde with SMTP id a640c23a62f3a-abf5e610f47mr976414466b.46.1741005070029;
        Mon, 03 Mar 2025 04:31:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf17fa4a4asm762647466b.92.2025.03.03.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:31:09 -0800 (PST)
Date: Mon, 3 Mar 2025 15:31:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	matthias.schiffer@ew.tq-group.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, glaroque@baylibre.com, macro@orcam.me.uk,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth:
 Add XDP support
Message-ID: <2c0c1a4f-95d4-40c9-9ede-6f92b173f05d@stanley.mountain>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
 <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>

On Mon, Mar 03, 2025 at 05:36:41PM +0530, Malladi, Meghana wrote:
> > > +static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
> > > +			struct page *page)
> > > +{
> > > +	struct net_device *ndev = emac->ndev;
> > > +	int err, result = ICSSG_XDP_PASS;
> > > +	struct bpf_prog *xdp_prog;
> > > +	struct xdp_frame *xdpf;
> > > +	int q_idx;
> > > +	u32 act;
> > > +
> > > +	xdp_prog = READ_ONCE(emac->xdp_prog);
> > > +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > +	switch (act) {
> > > +	case XDP_PASS:
> > > +		break;
> > > +	case XDP_TX:
> > > +		/* Send packet to TX ring for immediate transmission */
> > > +		xdpf = xdp_convert_buff_to_frame(xdp);
> > > +		if (unlikely(!xdpf))
> > 
> > This is the second unlikely() macro which is added in this patchset.
> > The rule with likely/unlikely() is that it should only be added if it
> > likely makes a difference in benchmarking.  Quite often the compiler
> > is able to predict that valid pointers are more likely than NULL
> > pointers so often these types of annotations don't make any difference
> > at all to the compiled code.  But it depends on the compiler and the -O2
> > options.
> > 
> 
> Do correct me if I am wrong, but from my understanding, XDP feature depends
> alot of performance and benchmarking and having unlikely does make a
> difference. Atleast in all the other drivers I see this being used for XDP.
> 

Which compiler are you on when you say that "having unlikely does make a
difference"?

I'm on gcc version 14.2.0 (Debian 14.2.0-16) and it doesn't make a
difference to the compiled code.  This matches what one would expect from
a compiler.  Valid pointers are fast path and NULL pointers are slow path.

Adding an unlikely() is a micro optimization.  There are so many other
things you can do to speed up the code.  I wouldn't start with that.

regards,
dan


