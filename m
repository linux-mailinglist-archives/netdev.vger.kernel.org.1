Return-Path: <netdev+bounces-165777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D545BA33585
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A6416678B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972520371B;
	Thu, 13 Feb 2025 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nADKsnGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AC1F8677
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413855; cv=none; b=Wv+N4/+C96MCrqC0hFH/4PlnZW4Qb7e6KA1Eb1od0TMIgqJVbtFRBpStycUXVSoYW4tZeHyeYtoPC0knKd6BBSQ89P73MewP+VvN+54trXuj/CTVK4FP6KV3AMtVa9TZJnkkREKVEry5F3QhZ3JR8aFwCioVjQOcSVqWKyEM5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413855; c=relaxed/simple;
	bh=3KbG0rv0EXu0QxjGBFMU3UG02Wnv1Kkg6coC9fllf3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq48fNnVJpCtPUZ4z3MvOf4VVFVpW5wYqr9HYScN2N8aWmwpgaaR1RaG70yD4L3C6R3L/bnuVHcTFJjFKvLR8mcvt0HG/ftsSMaPs4EA9pzANsSlyqElkxYGKuX6O7JBEWbfO1/g471xN3wXMm/sceHlVs3C5+RkEBAdHjyma5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nADKsnGV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so661705a91.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739413853; x=1740018653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XyFCzEj0jYxlqIuLfQmxuKNy4cLrP51qIiSmrXGX+ts=;
        b=nADKsnGV+iRnDapfn0ernMBPtj2d5tHaaZGqQUH6bf/CCUO7a6iLL5CI0/8w9MadGZ
         4MJgikt1GiNQz4a40fFhDL2xwsr6XWRJm4Qw4wRMNTjPnt7L3VoYNJLjXMXBvKIAYHAx
         I8I2SNYO0zVNd0oUZfgLFndjlHg0jeb3654sXhAB89UY0rTHtv/51gwBgNSQRrM8wdou
         Hbf2drAs3KZRLLnkrTbLue4IPVgFBSfgPpdrFf55iKZ79Vty+jtQ+XZxN9E2J4k41fNx
         w0D+V0rOIh4NZdb0QTqr+Q10Zfbbz8J04fclUBRvm9cHKNJxjkzLScnF+dXMZ79xbT6W
         zLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739413853; x=1740018653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyFCzEj0jYxlqIuLfQmxuKNy4cLrP51qIiSmrXGX+ts=;
        b=DKQKPjm8TaYfI9YZokrcX9UcY5uSyF+y4Jj0X4+cl4rMkn3C525onMhkGCLOioIec5
         bE++zPClB7gpT4pgkU8R20XoJKqJBlTMG5sWKHflBy6Z4ybo3lJXGkALapCymyXi05HT
         L0DzZ0hDRAePqye5UlbUbWLbW0PI0K3pF0PvyjHnlCrzRfMOuPfBQNvSsyhJZoGFWTPE
         q14MPJ1Var6R+RlLBFBLr4BGR61oU+s/by3LOIqoIBc0hlOMPpvLS4vQRQSuj33+mFbT
         KMK3f3mpywRvyrO7rEP+ML3jW9i9UujfnRwiCk1xWW50zHmipmt+jsoeV/GWUGMEPW4G
         vUMA==
X-Forwarded-Encrypted: i=1; AJvYcCUiUffCs7d22I7EwndcsmUEJYiIgjcPWN1kl98JIlrDHC8QFYRvdxtQ5k2GtxnLNRD7/Wk76gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvDbD3VKexeqeoaOrjxrStCD+mS2lpkdU9LvOyzD7a3ExmBBw
	WGaZN7CzK+3oeS6O7pO92P7gzqxzhPDoDWsnPDXbeXXl4l4WVdU=
X-Gm-Gg: ASbGncucruwTQIH+OtXwPFSs3JhOpRAc5eni0rE+alw39kyxsxHRDeQBkN31DSVWXiz
	jtxkuf0bfxl03cAToezpOWKZj01gwKtmUM3WL0oOp22d/Wrnn1R2p7GcRQPLpIkFdgsDI643P3W
	CIB/GJP957jVQHaTi3bpWxc8s+8FQqWlPcfWcvJKwPXAcVNdjbOiuqtgIFG4UTF5w5L6R3j6HqK
	gn1e6w9zh3bVuDmmw5WXeode3AHZTwuQf4nrNVH9N+YBKfzPBLCxFp3/hqtMPJN19bDBWJnmEVC
	UNRlibQoimz3vic=
X-Google-Smtp-Source: AGHT+IHFr1Drq7zZG754H5mTzThYlrVA+uinsxnl6IHqy/NBIi2U47T0kUbCqagZzUIZkgkb2n/c1A==
X-Received: by 2002:a05:6a00:2292:b0:732:2170:b68b with SMTP id d2e1a72fcca58-7323c001a1emr2626404b3a.0.1739413853405;
        Wed, 12 Feb 2025 18:30:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324276169fsm150224b3a.140.2025.02.12.18.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:30:53 -0800 (PST)
Date: Wed, 12 Feb 2025 18:30:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Paul Ripke <stix@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] ipv6: fix blackhole routes
Message-ID: <Z61ZXLdD4VQZFcBa@mini-arch>
References: <20250212164323.2183023-1-edumazet@google.com>
 <20250212164323.2183023-3-edumazet@google.com>
 <9f4ba585-7319-4fba-87e0-1993c5ae64d3@kernel.org>
 <CANn89iLiEcbnbMj7MdCTPsxoT3fHANALZ9LAAsG9T+sWcv-vew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLiEcbnbMj7MdCTPsxoT3fHANALZ9LAAsG9T+sWcv-vew@mail.gmail.com>

On 02/12, Eric Dumazet wrote:
> On Wed, Feb 12, 2025 at 7:00 PM David Ahern <dsahern@kernel.org> wrote:
> >
> > On 2/12/25 9:43 AM, Eric Dumazet wrote:
> > > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > > index 78362822b9070df138a0724dc76003b63026f9e2..335cdbfe621e2fc4a71badf4ff834870638d5e13 100644
> > > --- a/net/ipv6/route.c
> > > +++ b/net/ipv6/route.c
> > > @@ -1048,7 +1048,7 @@ static const int fib6_prop[RTN_MAX + 1] = {
> > >       [RTN_BROADCAST] = 0,
> > >       [RTN_ANYCAST]   = 0,
> > >       [RTN_MULTICAST] = 0,
> > > -     [RTN_BLACKHOLE] = -EINVAL,
> > > +     [RTN_BLACKHOLE] = 0,
> > >       [RTN_UNREACHABLE] = -EHOSTUNREACH,
> > >       [RTN_PROHIBIT]  = -EACCES,
> > >       [RTN_THROW]     = -EAGAIN,
> >
> > EINVAL goes back to ef2c7d7b59708 in 2012, so this is a change in user
> > visible behavior. Also this will make ipv6 deviate from ipv4:
> >
> >         [RTN_BLACKHOLE] = {
> >                 .error  = -EINVAL,
> >                 .scope  = RT_SCOPE_UNIVERSE,
> >         },
> 
> Should we create a new RTN_SINK (or different name), for both IPv4 and IPv6 ?

Sorry for sidelining, but depending on how this discussion goes,
tools/testing/selftests/net/fib_nexthops.sh test might need to be
adjusted (currently fails presumably because of -EINVAL change):

https://netdev-3.bots.linux.dev/vmksft-net/results/990081/2-fib-nexthops-sh/stdout

---
pw-bot: cr

