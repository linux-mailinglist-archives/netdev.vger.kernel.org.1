Return-Path: <netdev+bounces-68097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E556845D47
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04DC299C47
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A15E201;
	Thu,  1 Feb 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i575lqAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A65A4FF
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804955; cv=none; b=BmCQz/ul02YwHRIr9SjzsC8p7x+wZvmqrUPyNZXLsqH7y2UYXmJByOAB0EOtGMgpnr/O3/M5PPX9q7B9N4UKTF1j/jSJC6P3nDDkRmjRm7AO+BCi4x9cgeE90eANg7cyVdxyyWHGN48HF476x4H2tydmSPX2uyv/xgMEABn3uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804955; c=relaxed/simple;
	bh=S3AjnrNIx5BKudNt+FuYiHFiKF3Aoog4fHYyZ72OBkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU5Sw+RJ29qjM9AI3rysaChrnEIn0XuwmqZO1vixG43qkgWNtoswE2J3BuV3UKR7V6jSBMh2RRDpaCyl17GQbNYJOS7r7/sVUKdd2rydfa9JWys4Mbf3yuHx/O+F7crQdW3lyP4oFknAvhrma8iCcqH8S5kTLw7AVAtDXhE/fvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i575lqAk; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-51124db6cf0so1184584e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706804951; x=1707409751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNllvtHZDHAWtrtv2nUVEGYjjg2CQe0uH6p+qaHk/zI=;
        b=i575lqAk5QpDzdnJ0aDRfnljghLoEZOwTIjOuhc6P8MNrZAvfZWbJDEpYAlPSo+e9e
         +FaH7abrJYJiWt9t9Iw6SrvnGCW11PwLuo5/exDBphoBu2XJwBtqH6lHXAMMaHRAp2uV
         SC8Vf7TfZdimenF1RDv6q9TX+vCuWP7aPhyRe3PUmUKuaOuU3DswUUf/omnYoiUT+BsW
         OkeUut4u44o5HrpbEuEpC83sqn0471KFa+y6DzBGdxTHwTSgn2E3hVJO06YOz8sPd2TZ
         S5HZ2kuKy4UqvcWrLz7quOrTaEqgeJYwd029VAblQca5YLKyk8viYx6Ro9DyDpHWuyic
         vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804951; x=1707409751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNllvtHZDHAWtrtv2nUVEGYjjg2CQe0uH6p+qaHk/zI=;
        b=Sv7m7isE5g0iM5aXG6ZskL1Xyzm3AJhN4E/whYzfFb+nvXN2YGXphG6JNl5sMbTH40
         vMddRLuvB0KBWp5KPK2fqOEfnFFT22qRrukQHblUzLLRhvLecJW8iq6EToBKoqutxlGH
         bS1nW54lBlqUe0TSSezCYB+/DRq+w9Dv/iR/9k7wh9uqGYptPmy/7rexJ6N3mjf6krsB
         iRkJX7S9tVEFwLn151nKVdVeeKTirtCfJyXLv6MEu9P/XjOPTVRp/cHRURMaXP32RdgP
         R12+y0aHBXerhNQP6cDkdBPkvG3o52dWzvzktg3MikMhMjFPhpie2d77lhQfuEURnkDb
         DLBw==
X-Gm-Message-State: AOJu0Yyl8Lai/5Npfcv61C7ACHI7rRZTKAl64GLCNGagYStc4VRYaDTm
	l8cSFlR1DDcm2+brHchGfifBfAnzbLMDa9dfBc/WflbZtgMIx86E3fu9WXDZTGM=
X-Google-Smtp-Source: AGHT+IFpHJ9fDp3l9urMIz13d5uHrF2tLGi6nIvV59bVO5ddL+GvcU3faJHjeQ/t/EVxkT02aIk5Hw==
X-Received: by 2002:a05:600c:3151:b0:40f:aabd:b83 with SMTP id h17-20020a05600c315100b0040faabd0b83mr4429255wmo.13.1706804501869;
        Thu, 01 Feb 2024 08:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5l2dL8cK1cAB4grrA4V4D/XQXZKGpCwYEEgqMb5x2x4dcX8OR4UqDUNJHrfM/Iutif0muo/x0eAIkmpruVJZnVcs/yVyLqxI39v/alBmjYu2llkaZleZKNi4BNcDVCYzYsTDzuhgU/2EuwOjDZRJgMh8qO/us6VAOPZmnRo6b+n8aBxRVekETd5nBmkVhPgTvzDNc+cgtUoS4hGm3ef41cvU0uknmWbOvNYRMhr90Tw+0z6qHoGbYHnGj0JxhGFn5LnFDw2US/FhLgUITymjqLP1zAZuOLkSzweUB4SQworFLPUb64QcjksWzyPVI+hDEEDCXhPjUkJklVZ18BlRXw+iiv+Kyx0YTRI6g0oRH9nWI1SmaWKiC+OEZYhN2jkPtrvHzuuwxD3EzfixyEg8RJdwl/k034Il6jb83p5xV6j8keHt/nFByX83dtqLhVMqzG27njGZHXKGkc+YvoLDGVl0=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b0040fa661ee82sm4903623wmg.44.2024.02.01.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:21:41 -0800 (PST)
Date: Thu, 1 Feb 2024 17:21:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Aahil Awatramani <aahila@google.com>
Cc: David Dillow <dave@thedillows.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] bonding: Add independent control state
 machine
Message-ID: <ZbvFEtQskK3xzi6y@nanopsycho>
References: <20240129202741.3424902-1-aahila@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129202741.3424902-1-aahila@google.com>

Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:

[...]


>diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
>index 43be458422b3..95d88df94756 100644
>--- a/drivers/net/bonding/bond_procfs.c
>+++ b/drivers/net/bonding/bond_procfs.c
>@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file *seq)
> 			   (bond->params.lacp_active) ? "on" : "off");
> 		seq_printf(seq, "LACP rate: %s\n",
> 			   (bond->params.lacp_fast) ? "fast" : "slow");
>+		seq_printf(seq, "LACP coupled_control: %s\n",
>+			   (bond->params.coupled_control) ? "on" : "off");

Hmm, I wonder how it makes sense to add new features here. This should
rot.


> 		seq_printf(seq, "Min links: %d\n", bond->params.min_links);
> 		optval = bond_opt_get_val(BOND_OPT_AD_SELECT,
> 					  bond->params.ad_select);

[...]

