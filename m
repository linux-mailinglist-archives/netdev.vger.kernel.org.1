Return-Path: <netdev+bounces-109906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982B92A3C1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92A7B20F42
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEC137757;
	Mon,  8 Jul 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljZHzZp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BD1E515;
	Mon,  8 Jul 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445872; cv=none; b=kx4p+U34Cb3NhOihJf5W002/T9EyMIBlchunL+aTNB3IjVqDzCOl4jrBpRlffVcbAeGZ4JNQhF6NJG9JS8o2dezHYRjb++LS6OukmY40ywxZIEQHXlU1e6OZtSeBXc0hx4UGKfJA3e30AwzMtK06Twfow0PykWyJylX0slybmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445872; c=relaxed/simple;
	bh=cbvwfZUwkX84LTkEjnJDsDR9xDx4OQCdfydbXNTR+Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K47u2DPALvc0xLwViI88i1Cw+u5h1JDa8AYMLkDlgQw3oSz0meh30uBLhqi6tTGP+UMoedWylsyWr/I7vZRw8TNCq/cqD6hOWjVcXSQNizDjgUlAAY+snLap7HZWsgTpIe8AimdqydXeK9gVke6FpohKBPCmm/sOtUYfYd3NtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljZHzZp/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so11297875e9.0;
        Mon, 08 Jul 2024 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445869; x=1721050669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKb3q0Y7TytSgi4aTS4oA0BDYeL9S2seeAThCNboSVY=;
        b=ljZHzZp/MoOUjjEenfBEwsUM928UCbhKnCMWgBHSnLP8m0BlSdTyJVqi720tYrccMv
         R8A7i2H2AMfW++3NYDLzAIemXP6G/N7iVSrJo8QuddOualkMQn4MZGPbl2HsyZOyiQpF
         QofHrlw9J5UcJECKkyyKOTY9FTzRest7IBUUbwuzNiCCDObOEsAL8BSNHO+yuGeiruFJ
         gOFtjPGMLayVukr/74VxWBP809zOF2b3/P5Gk6Uz8zSTZSYeMGkGGQHYSs13vyEg4kvg
         nXRUwcwQTMLm1FoCQ77ASGOQGoX42n/t/GN/2tL9ySTdBGPWj+88jUhXn956u4GDRvP1
         Dj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445869; x=1721050669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKb3q0Y7TytSgi4aTS4oA0BDYeL9S2seeAThCNboSVY=;
        b=XPoO9WG7yqZ03P3kQPDrWMjgOfoMRaH0uD6Cp/PyLT+RO5qBfylAU6Z9oZ9xrOuxSI
         ykf9gvIdVtTNa/ERCFC1XMroiWs/xr9i3+2FyHuZRVayRNnbmnTNVDIAi5g+kI8qCdoG
         QVMdXTlijYhPcXbMz1vosOSdCE+HNwJ7GN5q0JWkYpmy1gvnXvTI8eR5dmnAib/NGvGv
         t8xnA3jjLkRbgv8VWs6f2laBABB9XK2Whl5hdPOqHxxIRZS9cABAF3XBVNTzKJFtLMWC
         88EeHqzyG5ujcVRRQ9gtWesfx5p6FToErREXHkcf9TyByRuRWdJmVDPWfnmrG7yHMFeI
         Uc2A==
X-Forwarded-Encrypted: i=1; AJvYcCXdTbKCiF0Eq7NDgX+sD9usS6Z65yVznR7Zkf39mVDQynh8WTawIGdiwONE3gGR7IVfZEuS0FV5LH+oR+YOdYHQmJg6j2SSFhMJelSQeG7IwCAglr5an+RhiLp2C3h9Y9fES1Z5
X-Gm-Message-State: AOJu0YyCKOIthw4hS0yNnsWBicFR+yhltcpVkLEppeLA19BbZFSlhiWe
	ybs592UCjvHQLVatF+PGiViLJgTjo1L6t+P1PJR0bNPJnN0B/Dzp
X-Google-Smtp-Source: AGHT+IFf2CtPfnw+MM5W8B/XjYd7ZO0yJR0wUNYpiS0Y2kF7RSShvAnNhhqjkbjraPsAS3o4pFs36Q==
X-Received: by 2002:a05:600c:ad0:b0:426:61af:e1d3 with SMTP id 5b1f17b1804b1-42661afe258mr37880785e9.31.1720445869053;
        Mon, 08 Jul 2024 06:37:49 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-426615876bbsm85539585e9.6.2024.07.08.06.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:37:48 -0700 (PDT)
Date: Mon, 8 Jul 2024 16:37:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kuba@kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <20240708133746.ea62kkeq2inzcos5@skbuf>
References: <20240624162128.1665620-1-leitao@debian.org>
 <202406261920.l5pzM1rj-lkp@intel.com>
 <20240626140623.7ebsspddqwc24ne4@skbuf>
 <Zn2yGBuwiW/BYvQ7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2yGBuwiW/BYvQ7@gmail.com>

On Thu, Jun 27, 2024 at 11:40:24AM -0700, Breno Leitao wrote:
> Hello Vladimir,
> 
> On Wed, Jun 26, 2024 at 05:06:23PM +0300, Vladimir Oltean wrote:
> > On Wed, Jun 26, 2024 at 08:09:53PM +0800, kernel test robot wrote:
> 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:3280:12: warning: stack frame size (16664) exceeds limit (2048) in 'dpaa_eth_probe' [-Wframe-larger-than]
> > >     3280 | static int dpaa_eth_probe(struct platform_device *pdev)
> > >          |            ^
> > >    1 warning generated.
> > > --
> > > >> drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:454:12: warning: stack frame size (8264) exceeds limit (2048) in 'dpaa_set_coalesce' [-Wframe-larger-than]
> > >      454 | static int dpaa_set_coalesce(struct net_device *dev,
> > >          |            ^
> > >    1 warning generated.
> > 
> > Arrays of NR_CPUS elements are what it probably doesn't like?
> 
> Can it use the number of online CPUs instead of NR_CPUS?

I don't see how, given that variable length arrays are something which
should be avoided in the kernel?

