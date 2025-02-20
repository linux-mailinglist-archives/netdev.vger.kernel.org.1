Return-Path: <netdev+bounces-168314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24EA3E7D1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76FE188F670
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF04264F99;
	Thu, 20 Feb 2025 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="I7wdbQYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946C264F90
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092015; cv=none; b=fDpLROiiDJRFTmcnfIVy1h24z7AVBlbAn0ik58x6QAkUtPUsxmbwzjGtkWxZ8mtVoKvAkl5woHxWkyNcR7HUyiKP9H+2mHCG8QbIJo9mdgqeAZOylGQTgySWFrFR2ZhYazG17a1n+v2eAQ/QmY/SO78n2GBMNisGNniu5V4UaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092015; c=relaxed/simple;
	bh=/hJcOZBAHHavmddBKgJPkm4X1qFWj/NslqMbiXXVZ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIRRHxI6ethGBOe/v6ejQnfDN94vDhTUDz6WyatFYw1T+vSLTTA4rW9Pyo/ACY7TTHwkXj0k5GFyBf01CEnaikjVAxoGw+OVpxV2hbphwSFYTna/MnCN80TrcG9GG9RJSRuz+yHRf1xABVRzwRhR1db/7o4605i18i0ES3fNKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=I7wdbQYt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e65a00556aso12208216d6.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740092012; x=1740696812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBGqa2XZdc+hGPTxNPbMoXCNOiu958Ou4ZNuSWdOAFA=;
        b=I7wdbQYthcIJw7EKcqR22AgSFN4s7BG4VIXppCk4IjqjMHfARE3b5XjrXlXxSHcPiJ
         Kb2B6dDbKJBQXFv/YKRYifJPKDf9Ktfu+zYbs50r3B7d44ySDArPz8PE8tXCCVW2DQke
         3obOuXQCY6ct0nTiV5U/RRFFrWQT7mOvCQ/Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740092012; x=1740696812;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBGqa2XZdc+hGPTxNPbMoXCNOiu958Ou4ZNuSWdOAFA=;
        b=e4MakPmwBRvraioqPg+CW2R6/AHcD5DSJtNA9JV+BREKq7nx2oeLm9cWbpMdA4e+zh
         elW5XUQHOoc1Lw+4W44Rj8xqlSLywwHBvLbpyXap330Oc5V9WgVoSUSOMSEJhiERMUKH
         5jP+TmSCOZqpuaSRcJiEAQE0/jqnuEs2FEjURGT78e46gsSIXrEyTkU4T+ON+uIt0aFe
         I2i1QLFyjXajRX+bop0zsDjegZDh9Pq+/5QuFsxAqO/2rrx4SXASzaPwZx60KGs/bpiB
         JgQpSiLrgBGm05rMxviSIbf/x/wrS3cfL88V2v4nxQG+tvm9ZG0QT5DZhB3kWDuqCGM1
         9VWw==
X-Forwarded-Encrypted: i=1; AJvYcCUwiEggO+JVaP5I7ntqkImZddabQkZ5zWEbLj2iAfiWdC0iACwmo45AYDOqm9QyCvXElB+2nRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uUKawOiFUJZYv8JEV4qjNrLCaYmUv29j/sGZJSZ8uGHvLBqp
	Un9KdkpxqaVxpUtOZpQrxzCp5Hu3KhhVxWlscF2tEB8Z3ZwlsJm8PDeNVv/c0Tg=
X-Gm-Gg: ASbGncsXkoCv+5jwvdQDCGLBKOc1rnXoSkfa0KRTzej10lt0ZsFrufiCuvkR+wMwc/b
	ml6tbe8vdtjqz9NlJWvg1iVyRkwxd8CwnvXBmFjDJU7yfS6TJh28A3ZCKzK56i4dP81QnDjy1s3
	kwmBdUABB865TAXebH1ytSN+M5+zEUXiI+9E4HH0it1z7AG8ngOue/5l+rRJG6X5d3nqXmqnbTO
	oXk+yp/I/Zl1T2z+FAH/UjwO342wh/pE1haYXU0WA7kEO1mU6Nl1qNe22p1kw4pt4sVgx6SrpQf
	8l+ok2zJER1UvQBtpfLbCawaEDjnl588l78G6DuOJ4CKVN51Pnx2ww==
X-Google-Smtp-Source: AGHT+IFgXNlQIrOhx1tnzTt+LP5yDZ/o+Vq8GS8yckRpRh4VssYlsX4N7FGzjAWlqEKURRvZcQHc2A==
X-Received: by 2002:a05:6214:d4e:b0:6e4:2e00:ddc1 with SMTP id 6a1803df08f44-6e6ae9ffd75mr14848766d6.40.1740092012172;
        Thu, 20 Feb 2025 14:53:32 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dafeb39sm90892046d6.95.2025.02.20.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:53:31 -0800 (PST)
Date: Thu, 20 Feb 2025 17:53:29 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 1/7] selftests: drv-net: add a warning for
 bkg + shell + terminate
Message-ID: <Z7eyaUB_LUET8uS8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-2-kuba@kernel.org>
 <Z7eDF2lsaQbWl0Yo@LQ3V64L9R2>
 <20250220131059.66d590e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220131059.66d590e0@kernel.org>

On Thu, Feb 20, 2025 at 01:10:59PM -0800, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 14:31:35 -0500 Joe Damato wrote:
> > > +        if shell and self.terminate:
> > > +            print("# Warning: combining shell and terminate is risky!")
> > > +            print("#          SIGTERM may not reach the child on zsh/ksh!")
> > > +  
> > 
> > This warning did not print on my system, FWIW. Up to you if you want
> > to respin and drop it or just leave it be.
> 
> You mean when running this patchset? It shouldn't, the current 
> test uses ksft_wait rather than terminate. The warning is for
> test developers trying to use the risky config in new tests.
> 
> > I am fine with this warning being added, although I disagree with
> > the commit message as mentioned in my previous email.
> 
> I'll edit the commit message when applying. Unless you want to dig
> deeper and find out why your bash/env is different than mine :(

No, no - no need for that much extra work. Just wanted to mention
for anyone following along or who stumbles on this in the future
that my shell is bash, is all :)

Thanks again for the work on this.

