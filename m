Return-Path: <netdev+bounces-188771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55118AAEA7F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30345209F4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B228AAE9;
	Wed,  7 May 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="kjohLqk3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCC2153C6
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644162; cv=none; b=VzGRuQpBywaBiBD727M8vjEbyEtG+xY9/GvmwV6uNlzMxtWq1ekDS61HULWJnr7wxZ8BNtopDbs/4V0hNCezWvU8y5VIVYg1fI2zh3RBsxaBufdtnKPyj6KjVC4GuaR2vaIDwwrX7WxvpTgR66MgNtyjDSL2KGDHyv2c9M+Do6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644162; c=relaxed/simple;
	bh=E+AoTI6AEzaIVytC4yUBD3tmkyMH7vTCWBn6u6ygv2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLAD0ZhEyMepLIK/wEQ+ONiD4/SlfjC1xv8XFrmyEc1rjTPHBcp0aIYrUQw2VzHdKkXS1J1gdwOLOYt3ey8Abuh4hwawNGrNqFcMwOnsgSv2sjTgWlXHEib2VM9n9u7HIFDEomZyjxZ4elSbsCm9XsCNrqKvvkWQV0hxg/V3hbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=kjohLqk3; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=axdkU3N89IieTs+fzfiUS4RZlz5P10S7/jt8Ic3ozns=; t=1746644161; x=1747508161; 
	b=kjohLqk3/ELv9E26USZFQ1t7tYlS/HSeC8UFBDCDaBtdrEzuWnLPwO2CrtIBnMQKatEc+cQXT6y
	FMq1OhNTuaMfH1y97RV1DCvrDPvnJ9r/STsiar3Z580OIIlpAzpyVMc2AZXU6DEiWziMiKDShOREP
	lpmaTnYIjAY5HXPPj/vJ/Ypcg9aE8eq1iKpEYwc0qxFPIPnfAyYmCqjv+jVGxr2h7qUtGmDQ54CYv
	ltFbSZkvcfPRuSYwQp5R0VKZcVyAEK3JV4LH9Uzh4o3z1HM6+v92NeyBxAoFT+0RhhCq+zGQP0qi8
	1Ct7j6QfLBngXF47dYQv8vgiEGlE/SVcjWKw==;
Received: from mail-oo1-f42.google.com ([209.85.161.42]:47221)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uCjvz-0004zK-OE
	for netdev@vger.kernel.org; Wed, 07 May 2025 11:56:00 -0700
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-601f3674116so85937eaf.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 11:55:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YxnOSS6Ul5Qu+oDot0aHNgNkG2K51Ve670eSLJfYDxKeyVLCvog
	BKnhM7zRSmx4+ptF31ndwx1tu9Bo4m0kktkZarMOI/NREJ6xXElpIlFC+6oC8sm1d+jrZj3LJmf
	9NtXeJqFKdftwePcuhkawutwdR/I=
X-Google-Smtp-Source: AGHT+IHqg+gKpGpZbJqG9/d5qOHjRgLOU9nE2CNFomUW2GDN46JalVveIfoyOaeZjYO4+mXN4HUeQQgfskeqqbsQZHc=
X-Received: by 2002:a05:6820:210e:b0:601:af0a:20c0 with SMTP id
 006d021491bc7-60828d18492mr2825237eaf.3.1746644159154; Wed, 07 May 2025
 11:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-9-ouster@cs.stanford.edu> <a6b82986-52df-4d51-b854-a2eb5842a574@redhat.com>
In-Reply-To: <a6b82986-52df-4d51-b854-a2eb5842a574@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 7 May 2025 11:55:23 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxbtj7x78KYNBWoZaCHbOf39ekeHQUX2bMZsipXUCau_Q@mail.gmail.com>
X-Gm-Features: ATxdqUHov-YsTCgU0cqk95UJZNawJPqJv2xTFUV3IFd7dOD3F4vERVrkyZ2QOnU
Message-ID: <CAGXJAmxbtj7x78KYNBWoZaCHbOf39ekeHQUX2bMZsipXUCau_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/15] net: homa: create homa_pacer.h and homa_pacer.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: d568c20fab0e2ccae07d583947984559

In Tue, May 6, 2025 at 7:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:
> > +     /**
> > +      * @link_mbps: The raw bandwidth of the network uplink, in
> > +      * units of 1e06 bits per second.  Set externally via sysctl.
> > +      */
> > +     int link_mbps;
>
> This is will be extremely problematic. In practice nobody will set this
> correctly and in some cases the info is not even available (VM) or will
> change dynamically due to policing/shaping.
>
> I think you need to build your own estimator of the available B/W. I'm
> unsure/I don't think you can re-use bql info here.

I agree about the issues, but I'd like to defer addressing them. I
have begun working on a new Homa-specific qdisc, which will improve
performance when there is concurrent TCP and Homa traffic. It
retrieves link speed from the net_device, which will eliminate the
need for the link_mbps configuration option. Hopefully this will be
ready by the time Homa upstreaming is complete.

There are additional issues that the qdisc will not address, such as
VMs. VMs raise a bunch of complications for Homa, because Homa
believes that it sees all of the traffic going out on the uplink (so
that it can pace properly) and this isn't the case in VMs. Again, I'd
like to defer dealing with this.

-John-

