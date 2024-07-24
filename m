Return-Path: <netdev+bounces-112878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E8293B955
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E322283CF6
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF213DDBD;
	Wed, 24 Jul 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQLrXnC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5A13A40F;
	Wed, 24 Jul 2024 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861699; cv=none; b=UO2FXxd/T9UGKNj52PQxIustm9EJxcv2258Ap9XOKkFQ81QSwZkaukXejcS7XNWYcmPnJFxc+6Cj1ylEeDKvqZaV6PnaS58TAAabfrmaaYGcLw047Wdi7DE0nK4IKOjsFxQvOMLYhqkR6MJ/o7+8mXJ0Ts1KFGrxwXgeE0jLRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861699; c=relaxed/simple;
	bh=8q7IkJjxtzb0aTmQe0EXlGIpImkJtuK206xkJPqHA3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BULn8SLYUOlBN4Ea2tNKIM9FPq6QohMZrmhv3xivF0kAmr8nCMlav7ytSdwaasl8ZW0pmiLWeAiPPeCXChXElqaxSvIeHxsznF3g0GWioViLV6U9DacVphtjIoCPFPiRn3pU9QoTEXDJYMFmPrW7T2UWFB4cKGQiwwzJJ4jLeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQLrXnC1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so44952266b.2;
        Wed, 24 Jul 2024 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721861696; x=1722466496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8q7IkJjxtzb0aTmQe0EXlGIpImkJtuK206xkJPqHA3E=;
        b=IQLrXnC18rdXbBivvYIFYC2vU9yMtR2zhCVJDj4/gDZL/vO7Yysgd8ZNAZCDVzzAxO
         Hq3qjU+DJU7O8+772G1O2fkh1w6u0ENONT9u/DOHsIY1oQ62EpPwby46y61EKP7NlzH+
         1P5wQVZV2IgQwnPfG1tkrQE14a24+GtzTJQrsYDfCyt/dYnmELC0WzlNmHoHOnalXilM
         iVme1SDTd7XrRP4zoOkyMqgbsNHa4iwb17jhWAvWs924gnSAqa3sQT3EIbwC8SNGXiXY
         M0Kg65zJXha0D9fzA7O1Oia/Bnr2cMzEvPjafLmz2wtfi43ptCjK436LXzWzRU3DCe2w
         vxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861696; x=1722466496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q7IkJjxtzb0aTmQe0EXlGIpImkJtuK206xkJPqHA3E=;
        b=cT9t4ydE6qAvvZLMyVbp0LgNnmCrtQz0jeJuKhgcsrpt4rNBStDMDf7ZvzLUNBt+aJ
         IwAzD6c8CU//RQoOgxZRS97Qykb+RELewVEaUPwUgPknmqBVJCYCwOcA3uZxnYfwa00o
         Ovt5aYyYJ6SFnXVDkvOcj6FTQf3vscigNYfirsFwwENVKb+5uuVLcUdvDtyczL0o2o8b
         Ly9sQFK/5DqPBkgjM5sSENLtbpAEZ6g6gbzXQuWJpGVDRG4/yh22V1FG/CraSSCXg9N+
         Bqj0E+kdJ6ZjBquKJ+4L/arzvH4+7jjT9WvHYQ8MYb4YJTalTTQXCWuMuNhHxmIHJa4M
         gS3w==
X-Forwarded-Encrypted: i=1; AJvYcCUMKN0ew1MoOVlvnLcKZ1f8Ei41OXQfds3S+ZEV/76fWiSEHg41ILLIiNW09fGyMa0PN2TrAHEiXi7bBGAU2W5iA6NwQDX1hB6nZCl4
X-Gm-Message-State: AOJu0YwXgRS0vEpKzW7S6Yq80HcVog/LctYv2eTaH9IQmVT8s+c5h8Od
	ApfIoLVws2X1Qrg339QelCfUiNmDgaJoO5k4C6QZNhQciJz7RXf6T3iv++1B5ym10RpELBusqGE
	cvOP6NnB1tDz7MrFD3Sxz5zJ9LODS8eDK
X-Google-Smtp-Source: AGHT+IHCATzoVX1ibTZlJdNaGcDiy9mq8ZX+68bRfy/aSXImYudAml2L0A/lT9DYNh+QIRmIZt+vM6U6vxZ8gHif3qA=
X-Received: by 2002:a17:906:e4f:b0:a6f:8265:8f2 with SMTP id
 a640c23a62f3a-a7ac4f40e11mr48161966b.37.1721861695779; Wed, 24 Jul 2024
 15:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
 <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
 <c20dcbc18af57f235974c9e5503491ea07a3ce99.camel@sipsolutions.net> <0042d3c7d695ed7b253ccbc7786888dc3b400867.camel@sipsolutions.net>
In-Reply-To: <0042d3c7d695ed7b253ccbc7786888dc3b400867.camel@sipsolutions.net>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Thu, 25 Jul 2024 08:54:44 +1000
Message-ID: <CAAvyFNjipHCvhy0=1T1JDFAFFUDvL_wOVFFGpdyNqY_SOVNfgQ@mail.gmail.com>
Subject: Re: [PATCH net 1/4] net-sysfs: check device is present when showing carrier
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 19:42, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2024-07-24 at 11:35 +0200, Johannes Berg wrote:
> > On Wed, 2024-07-24 at 01:46 +0000, Jamie Bainbridge wrote:
> > > A sysfs reader can race with a device reset or removal.
> >
> > Kind of, yes, but please check what the race actually is.
> >
> > > This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
> > > check for netdevice being present to speed_show") so add the same check
> > > to carrier_show.
> >
> > You didn't say why it's needed here, so ... why is it?
> >
> > FWIW, I don't think it actually _is_ needed, since the netdev struct
> > itself is still around, linkwatch_sync_dev() will not do anything that's
> > not still needed anyway (the removal from list must clearly either still
> > happen or nothing happens in the function). This will not call into the
> > driver (which would be the problematic part).
> >
> > So while I don't think this is _wrong_ per se, I also don't think it's
> > necessary, nor are you demonstrating that it is.
> >
> > And for userspace it should be pretty much immaterial whether it gets a
> > real value or -EINVAL in the race, or -ENOENT because the file
> > disappeared anyway?
> >
>
> All of which, btw, is also true for patches 3 and 4 in this set.
>
> For patch 2 it seems applicable.
>
> I do wonder if ethtool itself, at least ethtool netlink, doesn't have a
> similar problem though, since it just uses netdev_get_by_name() /
> netdev_get_by_index()?
>
> johannes

You are correct, patch 2 (duplex) is the one where we panicked during
device reset. I thought to fix the other "show" functions in advance
while I was there.

I will revise this and re-submit with only the necessary patch.

Thanks for the review, it is appreciated.

Jamie

