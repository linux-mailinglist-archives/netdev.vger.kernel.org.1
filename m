Return-Path: <netdev+bounces-147899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FCA9DEEE4
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 05:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4455B21864
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330DF12DD88;
	Sat, 30 Nov 2024 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiTduVvd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37697082D
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732939526; cv=none; b=J0OrDkp5l8hlAJAENvVUo+48Oqly8o5B4zo9zgbvLanCLU06KHX151WLiXyUYUt9FFPU+f933J9RWO4dTyModm4sa3g/Bwxj+XLwe2dd4Akt4uQ3Ijj0SgdJEh071Uu6FDW5s5d9Yh8BHwNpy9gMelbNhUUwn5vkeEIPNH4J8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732939526; c=relaxed/simple;
	bh=LZn6KdqSoiBCqS1umYc54TKCspbVNl7GuDpG6/It55M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa0SsKWJ0H9G8dHH0ChNtxBmgCRSNBJc2PzFU+/V56K6FKmd+1J1W8avHS6wNMk6KOW2RMH6tIVdZrXS5jxKbHxilB9R/mUwENvhL7WF+B9Pl2mg2VOJClcx82zJ2u4EvNYUCz1gWkP1l/NJ9ETU7xkO8QAKAu5HzW6SZFLAk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiTduVvd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215348d1977so15788865ad.3
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 20:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732939524; x=1733544324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbFW6fef9ULhS24mDauRdEvC3gSHvXwf8O92GnlNCGw=;
        b=RiTduVvdAdmwIolv0tMQW1IBtaNPcvvM8469PSPowpksCRsCbNmDWpzr4sYtCPSfiD
         oHHDQ10yj1uk0az+8K089FcSSGLWTcbHI/PLYSZGXG0hGmP3bpD9Q1/zcmmoLoJxZrpv
         65G8o0ExwFtnklIOykdd5JvdT/beUaK/jL3ZwZSbOr+igWSQpdm6BSIgKvZ6JegKvg6y
         fiKkXqYdSlVZOAzDAUlJ+8i3BrvEHsnqkfd7iOgzJ4P9HBKnX6PYSiLOtYAn27IXWjdd
         DTEMIkHzQFGrb+0CNaKmHfsFSH9sjgeJ4IxRIKY/EXUTTRYECOrw/hfo4A8I9OYgipBe
         mv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732939524; x=1733544324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbFW6fef9ULhS24mDauRdEvC3gSHvXwf8O92GnlNCGw=;
        b=JYYBS0GfwYMMFmNize57pS4+nY/vtDRCSvmelCnj+OW1DhFxKeturud3/YhVW9odk/
         LDB/dfiFZc3HCuNIjZQzy3wFbdL98krFAhfQToiQG/bZrHCBmRScUnU1jCeBITpjoyzL
         PXR5aMJeyJLWvbNfMFr6lN01bHh/yKGk01ZCRdsD8UdfBz4Y6FvWOBjsBOjCUXFvP3GZ
         IzGy9VIqm4wA0cEcBuIgu8fhrHdE26wFLoaspvI/0HZf+SNtvBc8brIzUUi1CBcsa8Rg
         gHDDM+6qUSWKCuGOLLZZ3lCEpW5ctqpoiktuI6B0+LOJPoStR5tGdAZ7zRcnb/Kc+sTy
         5QlA==
X-Gm-Message-State: AOJu0YwggoXdMuSmBcVqynxGPgyoLL8OXc2vnctUh0pdYPWJfoRILFu3
	k6yj0uooKzpmRY/ijricfjB78VgLSbp6oMP8NwuQ4YvnSvr6HyqaznzyMw==
X-Gm-Gg: ASbGncu8FGVIBNXGiyxrkJl/nNi2615OaC+ztD1C1QWjA2Hq/PYGcgodXGrZmX3smeL
	1r5WB75+I3ZfzqiXkOlk5WAWsjDC5jRKImbDadLj89OvdPBOrVkbkf4K9SeQEhlq2rbA/bQH+w7
	qj01NNWQICwkjMEOQLaJs3vkma0skVn4ccTWFfbvDxhdMRw9Xpfn+GmG24GQh2zsUrtTROHKo0Z
	5hhrwdJ8XfN0FfxSnykfu01Bf3RNH7FB9d7reOLMaEMUTihV4lh4rpYXC7cU6LhpMiw/EbL/vPC
	+FOf7hVr
X-Google-Smtp-Source: AGHT+IH1kujfFyxjsfIBqG3OnOd+NlLuO1wDEzN9GishEpjPBABHrcrocl+s3GrAKorD321zaT6SqA==
X-Received: by 2002:a17:902:e746:b0:20b:7ece:322c with SMTP id d9443c01a7336-21501858d58mr160113545ad.29.1732939523865;
        Fri, 29 Nov 2024 20:05:23 -0800 (PST)
Received: from xiberoa (c-76-103-20-67.hsd1.ca.comcast.net. [76.103.20.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152751571bsm35731825ad.222.2024.11.29.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 20:05:23 -0800 (PST)
Date: Fri, 29 Nov 2024 20:05:20 -0800
From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z0qPALhaNORMG8Go@xiberoa>
References: <Z0pMLtmaGPPSR3Ea@xiberoa>
 <Z0ptqDcLjrjqruQA@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0ptqDcLjrjqruQA@pop-os.localdomain>

On Fri, Nov 29, 2024 at 05:43:04PM -0800, Cong Wang wrote:
> On Fri, Nov 29, 2024 at 03:20:14PM -0800, Frederik Deweerdt wrote:
> > When `skb_splice_from_iter` was introduced, it inadvertently added
> > checksumming for AF_UNIX sockets. This resulted in significant
> > slowdowns, as when using sendfile over unix sockets.
> > 
> > Using the test code [1] in my test setup (2G, single core x86_64 qemu),
> > the client receives a 1000M file in:
> > - without the patch: 1577ms (+/- 36.1ms)
> > - with the patch: 725ms (+/- 28.3ms)
> > 
> > This commit skips addresses the issue by skipping checksumming when
> > splice occurs a AF_UNIX socket.
> > 
> > [1] https://gist.github.com/deweerdt/a3ee2477d1d87524cf08618d3c179f06
> > 
> > Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> > Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> > ---
> >  net/core/skbuff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6841e61a6bd0..49e4f9ab625f 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7233,7 +7233,7 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
> >  				goto out;
> >  			}
> >  
> > -			if (skb->ip_summed == CHECKSUM_NONE)
> > +			if (skb->ip_summed == CHECKSUM_NONE && skb->sk->sk_family != AF_UNIX)
> 
> Are you sure it is always safe to dereferene skb->sk here? I am not sure
> about the KCM socket case.
> 
> Instead of checking skb->sk->sk_family, why not just pass an additional
> boolean parameter to this function?
> 
I saw that every caller was dereferrencing an `sk`, but you are right
that that a boolean would be safer.

I'll resend an updated version.

Thanks,
Frederik

