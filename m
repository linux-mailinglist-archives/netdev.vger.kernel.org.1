Return-Path: <netdev+bounces-75804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7A86B3B6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7B028585D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A415D5A3;
	Wed, 28 Feb 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ALB9FPm1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB315CD6C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135450; cv=none; b=XRz0aUFTzaqA0yU76I4CrdBNMxLLOlyYpdMb6erfjnzJkoj8BN52PrwPwAtPIUlDJ6k+KsQH3yUmhTQQaBki2fJOe92RfmaurdTpndPoYeOcw3BfD2b6bG/pv7V/LvgU/2CxeA3HMwU3gzmJiLqWGhVZSJ/pv2hvK11fFx3f3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135450; c=relaxed/simple;
	bh=qw/lsb8EBSivANarcDEFfqbKUxGjNYj5K/tvppvuWZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnOtXQ8mKHGEO9b/pSJON9r951Pj1PvlIrRZIVS9MAZXb5l3C2ZUMRbMzzsWycC7iWuk+dXhi4dh6SuAU5baRHH7WxX+pJ08NhQh6AOHs0W1junyCP8Oo0aZG7S+R1DaVCrIdM05PpAqucO4c7ZXg8ABl9vo0j+mh5HwM0Tbv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ALB9FPm1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412b7bb0bd3so2060575e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709135447; x=1709740247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stUSePaurhatS3Ury/aUkVTpamNEr91HAAR49t8RyYY=;
        b=ALB9FPm19eHgFNlrkUfXdluebQpC0OgDT9EDSNdjq8RsduDOcUPUGFW5iOA1jRn7EG
         xR1nhRINm3Lb1KecynQB7Q5xQR6PZQciDi+5MY+ReTeXIdom+SuiXfbGPNwL7GipEE3n
         9qsUBnBpYPR1WLYJUJW/MnWIC0wpYRExnOoAV2nlImg4VaddrSe1qUZEUaa6F8A54L1J
         2THX0uSKnLBizbxB6XEMoBWmvZadhIZwHBYhOwWmGFdIAO4uRzZYV6qUhoOrzhwOSGid
         VuVduJk5paYNDXkkLGu79vSK8Cal/xcu6oaUeZUTgpUgNNODnULKwOzL4DgcMftw3qWB
         WRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135447; x=1709740247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stUSePaurhatS3Ury/aUkVTpamNEr91HAAR49t8RyYY=;
        b=nrMXM/BzvlKl5L7iclOSue8vzwuPw1cekDlfSLqOEa95OfrNXEVAML2iKlCbMAdBJQ
         aPEripmoutX9dsZtozDGapKC57/VwzzBIjUlb1AzOnSaJwoERMcS/FavXeYoz33LHZxA
         Tjz6VZhlfKt9qJCIgCAOiZaWK99BtpVB15Lf/EgISNqpMEEIXnoPdjRzk27Mc95xaqKQ
         fgn9Ige6qXkxvPfgJFGv+S3y2E3i6OVETiRU0SI5+73s6Qu5Z/zpv0LvFwSFptBMxZyp
         3T2A5eXVrF79b6p1GGN8BzFbMmbPC9DpjbQ+spaCWXMPSUy46oZsf986S2WhVkxz9PGX
         NqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuOTpJJA3OrHKCOC3zUEN66YFQ1DhECsTj6GfKiLR2cbv0H+U7fkoqQnMtp8oa9MTKOV68vhOmynPWCryWXd9DAVDSfcQv
X-Gm-Message-State: AOJu0Yxp+xT3Fr8ApPbgDXcqQNJHqyEBEFEpTRYsGAjn91GiFRk1+TAv
	i/9LYXsmz1HCe9Eu/Eb5RFd6oogiJ655plRelN9PfTDpVnHAZpAoWuK8iB83MDI=
X-Google-Smtp-Source: AGHT+IG0lOzeZ+/WxvUdFaRJkHfwlU5mdhNXZKdUzkPe8Pc39VME6SVEd3+lj1GdI3bR8LEZsQoyvQ==
X-Received: by 2002:a05:600c:4f4e:b0:410:78fb:bed2 with SMTP id m14-20020a05600c4f4e00b0041078fbbed2mr2843006wmq.19.1709135446576;
        Wed, 28 Feb 2024 07:50:46 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c230900b004129018510esm2401794wmo.22.2024.02.28.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:50:46 -0800 (PST)
Date: Wed, 28 Feb 2024 16:50:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>
Subject: Re: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Message-ID: <Zd9WU1bpoOlR9de7@nanopsycho>
References: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>

Wed, Feb 28, 2024 at 04:38:56PM CET, Lena.Wang@mediatek.com wrote:
>From: Shiming Cheng <shiming.cheng@mediatek.com>
>
>When rule policy is changed, ipv6 socket cache is not refreshed.
>The sock's skb still uses a outdated route cache and was sent to
>a wrong interface.
>
>To avoid this error we should update fib node's version when
>rule is changed. Then skb's route will be reroute checked as
>route cache version is already different with fib node version.
>The route cache is refreshed to match the latest rule.
>
>Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>Signed-off-by: Lena Wang <lena.wang@mediatek.com>

1) You are still missing Fixes tags, I don't know what to say.
2) Re patch subject:
   "ipv6:flush ipv6 route cache when rule is changed"
   Could it be:
   "ipv6: fib6_rules: flush route cache when rule is changed"
   ? please.
3) Could you please honor the 24h hours resubmission rule:
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr

pw-bot: cr

