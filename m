Return-Path: <netdev+bounces-128332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C993C978FD0
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF181C21989
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE221CDFD9;
	Sat, 14 Sep 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXsLhkbd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5B76046
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308336; cv=none; b=Ys1K33dqQ1X+Hz2mSGR1oegtUSn+izQl2kZ8W94tqrCaLa/czhsslUg9JDuC4Z7YlHy4NmGow61jRyqOE2R99Po54b8PYozTysmMFIiVLIiPZLlYjwLOVa72f1oW6it+LtdOVQe65gCtIa9wKzpRFCYUEo/dQcw8DgDpWxw3qOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308336; c=relaxed/simple;
	bh=uyUo2fF7wfyuRfSxg2fJMYfWzcWgmdiUEo5RMmlO/3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz/E2bpAG9N9cSHZfiA4PkkXFffsBe7dIOJzujUe8+wm3ZmgKh8AirpSD4Q2xScSY0J6Xm56LDJ3Uh5/ZFtZJ/tyAArg0qQbXowWty50zJ58bpRovcsvxUZkBaOHg4d97X482stnLS5OFo11IeOMz44IZk+WjUJ9NfyZOQ86ugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXsLhkbd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86e9db75b9so427039866b.1
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726308333; x=1726913133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQaP07kUjh9Hh3Vx1aYpBskYDsvr/ETiwaom9aVLxSk=;
        b=QXsLhkbdUv3OzkynxfeZvpleBXmyOxG55sl10ZgoZC6KcgEjo0cXvfKprt5kMCBcVf
         W8yLamK04g+xLBsK0hrhEvGxWRnW0BvRMfp21Xv1kfMYOU7/onrZNl4HKwmN/A9Q0H12
         saa5Ge5TWuMRYChA7wOW32FapGrIy/EOyUEd4G17AGQ7N3UYf2jr0+t5Y5uOttISSD0k
         h4/LDQ+kus4J0/x9bNMIVGWZoy3QsxRtMRYxTa/bcPu5f9CW8oiou14RUDZJccqW5Zcd
         JQ8rxask7Sr+ei7cY9Mt8ZHtJES1WYDrQkVdCyf+2BZblvBHYHJAetDN1fB7I40YRJKy
         P6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726308333; x=1726913133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQaP07kUjh9Hh3Vx1aYpBskYDsvr/ETiwaom9aVLxSk=;
        b=qdfsbiuNnJJLxdRxsjUkxePPiEi7XV29AuDKy/zKJY8bzKHOELG08tS115cJJUWtrg
         iy6FbZK9nei6HN3arZVbLOjM/5/UnqXa8kMnq/Z3Nu/p4xL3SlGm9Nq6ZQWy8JkDDEdb
         ijOfuPO7u0fXSr+amCfa9hwcPUUqIQ0ANqulBQ7kYgDG+PBIIhmzC9pqmVQuiZH7MoxH
         kmpMe2kcHbwazrH7CDVlSo373e/twFng3WKvBIlRM07wicCRlynb8kyCBnkxeOH369aX
         wp/p8xj8USXtYpsKA6tsV0ECeJNV2X7EU0NIPun5kcbklvKiDfq4GEzoaVjMKeG7h31S
         Qo9w==
X-Forwarded-Encrypted: i=1; AJvYcCWfTRJmVq9DGvou8PMzk4EB+nbJjcC8Dzg1lZujAZXZVEzyVff7JUE5694DF2ZlRFXwkRrv64M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyBev/TFmTltkIO+3Njnx6xzTtGG+yEWnstNeRA4oKEVGG67o
	A7QAl/kHsI1H64u7QYk7O0OHtS0iWAfggI8uUkOyL8ISIhZMBMy518Bjdq9x378=
X-Google-Smtp-Source: AGHT+IFUGe/YZnTvrPrKTN9LdMp4s56tVPxGhPOwQHgiH6EffJdxr/Zlk+uPLUhxjZOYMNerF5RjBA==
X-Received: by 2002:a17:906:478a:b0:a8a:8c04:ce9f with SMTP id a640c23a62f3a-a90296eabbemr942716766b.52.1726308333391;
        Sat, 14 Sep 2024 03:05:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm61912566b.33.2024.09.14.03.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:05:32 -0700 (PDT)
Date: Sat, 14 Sep 2024 13:05:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Su Hui <suhui@nfschina.com>, jmaloy@redhat.com, ying.xue@windriver.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: tipc: avoid possible garbage value
Message-ID: <f1279370-a127-4946-8c46-cc89fd2a90a6@stanley.mountain>
References: <20240912110119.2025503-1-suhui@nfschina.com>
 <20240914094244.GG12935@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914094244.GG12935@kernel.org>

On Sat, Sep 14, 2024 at 10:42:44AM +0100, Simon Horman wrote:
> On Thu, Sep 12, 2024 at 07:01:20PM +0800, Su Hui wrote:
> > Clang static checker (scan-build) warning:
> > net/tipc/bcast.c:305:4:
> > The expression is an uninitialized value. The computed value will also
> > be garbage [core.uninitialized.Assign]
> >   305 |                         (*cong_link_cnt)++;
> >       |                         ^~~~~~~~~~~~~~~~~~
> > 
> > tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
> > is uninitialized. Although it won't really cause a problem, it's better
> > to fix it.
> > 
> > Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing")
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> Hi Su Hui,
> 
> This looks like a bug fix. If so it should be targeted at net rather than
> net-next. If not, the Fixes tag should be dropped, and the commit can be
> referenced in the patch description with some other text around:
> 


It's one of those borderline things.  As the commit message says it doesn't
really cause a problem because cong_link_cnt is never used.  I guess if you had
UBSan turned on it would generate a runtime warning.  Still it also doesn't seem
intentional so I would probably count it as a bugfix and target net like you
suggest.

regards,
dan carpenter



