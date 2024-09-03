Return-Path: <netdev+bounces-124505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E6969C17
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086292824A0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F11C9840;
	Tue,  3 Sep 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIsb0Jqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8F1C7685
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363473; cv=none; b=p2vTDB3qtmjQ8iiJvNYZNz5Kp12Fo23Tm92okCPF3Vb8Ndqp8zlqnmqL+bypMWg6Nr8CZsYi0vrBo6jJoAEqhx6S+aORPy7tSjaFDKvTtcsCAulk/3DIOmSo1qh6axuC5osMWJz1cY0s1O2LKFgfIbIhi8nP013QEIVTnGZtHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363473; c=relaxed/simple;
	bh=x/YI3l04SoX9OnKDr3EUad0uo/LJ+MH8GdJi3qwtZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlT9UcEDRVMgBJVeCwZkxjExjC3o8dX5Q3kDAdAzUhKT/yawAx0GwvAOBkz8sBZoUh/x7Yhe4rVhw+mDsLF0Yel+iVfMBIv9Ifsr7zF0uAFQ8r9TbufOwEfKWE6cTPgE/ZiPOsnoFCW3Ds0uXGg7yoJyNC2DvASOyQqh2Wxco0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIsb0Jqn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c5bab490so1395975f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725363470; x=1725968270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1w7RM6fNJKKtXoFmqBLMOVOwZprTx1XOAyQ7sitNqSg=;
        b=lIsb0Jqnwi6bhj4UL4vIPpwG0TfC/SpR+g3tv94Zy6n6w8D42kqJCm3zKKWXYyefHG
         F7WAAS/tElNg1o0+bTk0jJKGh6efAl6uyzMzxyq8C1sTzI4oMVKQca0qX96jc07Nl0F1
         viT2imWDdHAQEuWdwnaoFcre8peex6XADEDW9yinCSPKuasm3+Fb98XT78xPVnfGQWpX
         lwLY5qk+ksCYznvCJqaYnUrlxs8F4vVAzXO6mMQ4EELIdpbHXJ1n5oQ137Kb4UdXyfD8
         yh0YVqaLdPCUOHfMGd5hcOhj8Ev4o7rMoNZuqfZND2acZqdmont1MUGaVkueHIhBPMnt
         5qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363470; x=1725968270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w7RM6fNJKKtXoFmqBLMOVOwZprTx1XOAyQ7sitNqSg=;
        b=Y7xP38v3Y1LCeN80DDs7RdWV7H29xkg+r5/nveHGLjbPoHHf+hHo1U1dBCtUtydWqq
         ZGwZdnaSDQfl3HpqYUCsKLCAXYKpD9hyqH+byrEYWHCEKpGPq45KVfIQxTEpboAu+Vsx
         HhbFiLTCN6DjbD0ezpF/2jFVw3J/ajsRT+agGUz44v6R5AXa5RqD2aO58v7RPtEeeijY
         dy5+BSWIa3/P2+Ae2lQBXCxbUQvJQ5pcTKDUbgXoYztOKgkDwD6MsrC69IrGRNhtAwBn
         KfJpYxYK+18MIetmnETAz/BnyeXs/cRhDnK/Zgz2MmbW9MefNqEcK/H7nNDvXSyh1mPw
         TWVw==
X-Forwarded-Encrypted: i=1; AJvYcCXJZUp77NWJTvo1rZwD2x1NxF511MBTiisawvuIdCd9r0ft4hBNLBaQIzkSdx565ywefS4mo4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vc+w1LSe7/lmcsxwpDd9BLFPxXv+A16RwsmwZb01SGwu48ba
	ZPNwj0VpBu+jzHWzeT2LwzWCDb0tDRICCzjRFuxTY5YQhVkjI/H5fN0OkXABQ67QAd5y9MjRuK7
	c
X-Google-Smtp-Source: AGHT+IE7TUNkcWMj6FBm/rZSDEQFLpCvdG8YMggJ7DJ9B5jCIs6BBY8mt+IIA83FJSLSmQdcN7HRvg==
X-Received: by 2002:adf:b1d2:0:b0:374:c11c:5024 with SMTP id ffacd0b85a97d-374c11c5101mr5438542f8f.16.1725363470103;
        Tue, 03 Sep 2024 04:37:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df795asm168314565e9.21.2024.09.03.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 04:37:49 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:37:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Chapman <jchapman@katalix.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next] l2tp: remove unneeded null check in
 l2tp_v2_session_get_next
Message-ID: <d1f3b8e4-1a15-45a2-a1c2-c21f6f471190@stanley.mountain>
References: <20240902142953.926891-1-jchapman@katalix.com>
 <20240903072417.GN23170@kernel.org>
 <332ef891-510e-4382-804c-bc2245276ea7@stanley.mountain>
 <1dce7949-58de-ce8b-7123-3c2c2dfef276@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dce7949-58de-ce8b-7123-3c2c2dfef276@katalix.com>

On Tue, Sep 03, 2024 at 11:48:00AM +0100, James Chapman wrote:
> On 03/09/2024 09:02, Dan Carpenter wrote:
> > On Tue, Sep 03, 2024 at 08:24:17AM +0100, Simon Horman wrote:
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
> > > > CC: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Signed-off-by: James Chapman <jchapman@katalix.com>
> > > > Signed-off-by: Tom Parkin <tparkin@katalix.com>
> > > 
> > > And as you posted the patch, it would be slightly more intuitive
> > > if your SoB line came last. But I've seen conflicting advice about
> > > the order of tags within the past weeks.
> > 
> > It should be in chronological order.
> > 
> > People generally aren't going to get too fussed about the order except the
> > Signed-off-by tags.  Everyone who handles the patch adds their Signed-off-by to
> > the end.  Right now it looks like James wrote the patch and then Tom is the
> > maintainer who merged it.  Co-developed-by?
> 
> I'm probably using tags incorrectly. When Tom or I submit kernel patches to
> netdev, we usually review each other's work first before sending the patch
> to netdev. But we thought that adding a Reviewed-by tag might short-cut
> proper community review, hence we use SoB to indicate that we're both happy
> with the patch and we're both interested in review feedback on it.
> 
> On reflection, Acked-by would be better for this. I'll send a v2 with
> Acked-by to avoid confusion.

Signed-off-by is kind of like signing a legal document to say that there is no
stolen copyright code from SCO.  You don't need to sign it if you're not
handling the code.

Reviewed-by is fine or Acked-by is also fine.  Reviewers will look at them the
same way.

regards,
dan carpenter


