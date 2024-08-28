Return-Path: <netdev+bounces-122684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE019622D5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EE42827AD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896315B13B;
	Wed, 28 Aug 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vprztl8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73E156872
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835257; cv=none; b=Hd4pMZm8ghmr0oDEqs6WSvvOUcLA0sPPl+qg/Lr9vVJJ5FLVuV2FhiPBfmngQip44p6uyz9GQqP+kcbUsuLAc1yF6ZivF72I5QIMu0CUe4bcMpuneIL6MghG/JVztlab3u/rJ06TzzZHZqtA8J+95o5ixXqdfIrsueMpMsO4sXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835257; c=relaxed/simple;
	bh=ZJ/J7m6i+8KbtJqj1FMAwGA+Bmxy4Lpbs/RVJWh8Vgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6GwHm6uOLC3sQV4nqO9SET2FXwDOQ2jcTl+jUwccci2QJuWt58G5iBAX6eaz8qIDkR073ay2Sy/bFqR7hcJ1cSk3Wq2OPL+OOK1+LsWOkSPmXcpgzKCUpCkNiKPwp3dr7O7LtbPcB3VZvbelbdEec64qRUQjoxxtQFaExIo/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vprztl8/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371ba7e46easo3747620f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724835253; x=1725440053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQtjr3ZsIIcSu1rCSe254P3JWX2H8aBnGOcApocErl0=;
        b=Vprztl8/nigFe59LCJ7rkABx13cVc27gwIZbJlLh63FvHvV8i//HIEY200G1ygM1yW
         MivszpVAzJL2vbokuZBHsR2QVJE9G3TY+lthYV/KySHC6qmtTIZxS05W5nfQagO2N8ID
         /kAzGBrSyrUt0/zC0q7h1a6rS0pXcygLQA8KWvn8OiM5SakfWc6p1WgHR0b+b8VT1r2y
         qzZFBozJ83oimU+iGsVBPrRzJfEZgU6JF45oXLKWD9oFe0YJn/GZXkI7jGJLVWL02dwq
         wYeMErSLXqJc9bauqYok1fS4xQMCsHOadnz1dBcchnhow1qPU7jhnKHKiYc3q+cc+rC2
         WVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724835253; x=1725440053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQtjr3ZsIIcSu1rCSe254P3JWX2H8aBnGOcApocErl0=;
        b=qo9dmzUheARFKgoQKPFiaGRNt8eCdenYh9ca7yJtrdOq8MzlNXeoawOvxureccSF8Z
         hipjoWJCw8B57iZSa3sVu7gceVxIjlYlbEAwtYcqSTqOFznCwWUUj7kQgnmeNebmPyQY
         BC2K0G0NVw0aiYReJv2J8vRXjTTldeyUEAnlOJsS4Yqnd/HY6XUrtGGaFAmMN2sr5VxO
         51nB0Vzonx5jwdvFP6zL1LPjHTM2AbA1kB0ZoikkA3AID7+q03VVBdL8IrwQll3BvQ4E
         AB+H+4kFVeGaHTAq1P3PheTvwQm4F2c9doKqPzyx9rU4gPqGxY9LD2I/+VaL1Fi5kmt+
         QXvA==
X-Forwarded-Encrypted: i=1; AJvYcCWosdAl414+/SZJD4nOnc9VTlSxtQK7INh+Wyosw8jzq5dHOBZaxT7yJtgNZRc33egur/ozdyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLMeqdgMK37qdZ5B9YFxar7cSsYivPOQhzFwxBnxzEIPhy2zG
	8uj6PXVi0Uos4p86oBYwJXXZVdKWfofJ2RFFNIg1u7SGYj5Vpz1QddxgIXaaeX0=
X-Google-Smtp-Source: AGHT+IGr3JPJmC+vbozl+aEANHfCdvcBvynQALLAOIYsAcPYx4SVws2LzUK1Yn9Ipf6EeFPGVzxiQQ==
X-Received: by 2002:a5d:47af:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-37311840ef8mr13595292f8f.13.1724835253222;
        Wed, 28 Aug 2024 01:54:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63b11ecsm13978265e9.26.2024.08.28.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:54:12 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:54:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ralf@linux-mips.org,
	jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
	linux-hams@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: prefer strscpy over strcpy
Message-ID: <d5525686-aefc-439e-8c27-d41a2ee2eb69@stanley.mountain>
References: <20240827113527.4019856-1-lihongbo22@huawei.com>
 <20240827113527.4019856-2-lihongbo22@huawei.com>
 <a60d4c8f-409e-4149-9eae-64bb3ea2e6bf@stanley.mountain>
 <7fd81130-b747-4f70-978c-7f029a9137f3@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd81130-b747-4f70-978c-7f029a9137f3@huawei.com>

On Wed, Aug 28, 2024 at 03:43:30PM +0800, Hongbo Li wrote:
> 
> 
> On 2024/8/27 20:30, Dan Carpenter wrote:
> > On Tue, Aug 27, 2024 at 07:35:22PM +0800, Hongbo Li wrote:
> > > The deprecated helper strcpy() performs no bounds checking on the
> > > destination buffer. This could result in linear overflows beyond
> > > the end of the buffer, leading to all kinds of misbehaviors.
> > > The safe replacement is strscpy() [1].
> > > 
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> > > 
> > > Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> > > ---
> > >   net/core/dev.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 0d0b983a6c21..f5e0a0d801fd 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -11121,7 +11121,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> > >   	if (!dev->ethtool)
> > >   		goto free_all;
> > > -	strcpy(dev->name, name);
> > > +	strscpy(dev->name, name, sizeof(dev->name));
> > 
> > You can just do:
> > 
> > 	strscpy(dev->name, name);
> > 
> > I prefer this format because it ensures that dev->name is an array and not a
> > pointer.  Also shorter.
> ok, I'll remove the len.(Most of these are an array, not a pointer)

s/Most/all/.

If it were a pointer that would have been a bug and someone would have
complained already.  :P

regards,
dan carpenter


