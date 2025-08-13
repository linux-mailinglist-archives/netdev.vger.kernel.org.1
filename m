Return-Path: <netdev+bounces-213474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70371B25358
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 20:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3D1C84925
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811212FF145;
	Wed, 13 Aug 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G6hlxSL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE784E07
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111233; cv=none; b=DOMMOzhbdlggy+Gm/zGvoBWHeFhIXKA1OeiyfhopNU6KgRRGWdndGHOkpZ5oPWyepWLh8m4NuIGWW0a2OMjdREvx7kThPiFkCmg4L3e36dYvqcxD0ufVr8d6rG1wyG40JTWWZMnqhPbvGM1MFoq337XQ5jwxp0OzSyGTtK32xIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111233; c=relaxed/simple;
	bh=uAIoi3oE2JAfmyQClW7OLg6ZQbAytpR40I4ZrK0A/Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrLG2xlA22hI/WlhoxsCalxhwT4MTARJGhnMYrAt0WsQrq2rO6nrW6NOkeX5p325pqEAon1r/vpQto5Lc+DcOcMQnWebI3JlAWdEnClblv3U5wu01WXUjWpsX+SLtwmPSUCgzp8ohjL2Y9B4zbYsWkoYMc1fqk8fmAF8glr6Q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G6hlxSL2; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-435de7d6d05so119257b6e.2
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755111231; x=1755716031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TqjUBMBvz3ge0UrPwf2mXPDOUtrqy+wU9/W1Le4cwc=;
        b=G6hlxSL2o7oP+USDyuTE1+DfucCYUV/oR/xRPvpSuryts1PEjeBdXWypG9hllHxrxN
         szFvxMauu1JjuCctWPWR+w71Xgt5T4xGEZPoAPrbdjUCbiVoOfRjREiSC40eAGaa7IqN
         PUrZSESwTAOW4OSOFOnYL9DWOc1NAfZFg3wXIgfHk71zXrrZWF/xm8VFZN1jjj3guRhu
         w1ymHQfzBWI7ye+kZUOYlKGKyZBV+B3oqmRyhZgW3t5Zb25UgtkhsFiYhOu7/cwf2P8d
         yjlRwIGfEWZ67T+PmKlPOVGYL3OZlqe/LqgOdT6mUxH3eDE+Qyyg9XxlaSqLifqVzTjv
         tkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755111231; x=1755716031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TqjUBMBvz3ge0UrPwf2mXPDOUtrqy+wU9/W1Le4cwc=;
        b=UYp/F+85hUZD6I13HgWyjfgY/28saCe2qGkOcNqXQU5qQ0GhI/Kh7br+EOlpK4yHj0
         jmctMoQsG5u/daKhI8fiREDjbtDDI99XhAbpW1jEmvDUImBdo9U2ZF3TkYjjozr9AilF
         IJirULBaf0CPV6ukgeLjeAIvRCAryQ6hcpebje2e/LthEb0IH0IYOu9PcoCHGPRchfa6
         XAe8j+Di9EIBsvTczNQ/OQNWfxlHTPkbpZ+nBJZyShhZ30+POlLUpGCNUpWOyDMHfwdB
         xKe4MGkXVzAFsoZq/sG7lUyEK/xvNDmPhQPfcbS+fSuh1v3SKKfGwbO/TMKIH5Qoj6h7
         St+g==
X-Forwarded-Encrypted: i=1; AJvYcCUkPTLsBX+Vhi/Lr1M1dHMDCo36vqf1O3LXXYjUPjLyrvqIK86ZEquOtsRGiVOqVaaSmvi4hY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaS4m2tklte2K6ZGMF8gp2i3hiNIpv4dtlpm5dH8nv7VFp+OeU
	L6DsFHBx/b45LE966JHoVDBiCd3WnK9jXZpAuYNYWZTltBWBwvHcYqDeRgzJXMdjU04=
X-Gm-Gg: ASbGncvddnyW3cpf/iW0t91F+snU6WBT6oJ5OqhHL7KToKxHKPnpRI3taHEo4ySqg4m
	AmXrxIwpldF8c2TBvKj754mxOMBb/dM81Sp6vswbT1Ftmt91AQmzSgDrArIPmDkFgHjVBdA2prK
	E5Vy+mgP4AmpaEN5xZnB4yWyPolJBnkelCzdIXpZhfPomeBUgUYCaCXlD0jwOk8b2npMPK3lyvL
	sKOpRdQUBzvcnJv9bACfl3BT/+Hn4fUnmiOtKUiaeAhZd1jmF2nxguh2Ici0RdYAd6lAlHv4xyq
	HVp6UltJrijfhS4TQH1xb3P9Vvcm4hFBspf0/tP+R4GNh0a8eOI0XMisCHsXEY/+H5l1p5tLlgq
	eX4S0
X-Google-Smtp-Source: AGHT+IH+cxAc1P0YpSjpT5GkMD6yTAL+x39p48U9fLHRa1UvuKJNiSxTcXqK8YDOSg3Bw6mNwWToXw==
X-Received: by 2002:a05:6808:f03:b0:40a:526e:5e7a with SMTP id 5614622812f47-435df7c035bmr175396b6e.23.1755111230876;
        Wed, 13 Aug 2025 11:53:50 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::f:384])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce85684csm777268b6e.18.2025.08.13.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:53:50 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:53:48 -0500
From: Chris Arges <carges@cloudflare.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com,
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Rzeznik <arzeznik@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <aJzfPFCTlc35b2Bp@861G6M3>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
 <aJuxY9oTtxSn4qZP@861G6M3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJuxY9oTtxSn4qZP@861G6M3>

On 2025-08-12 16:25:58, Chris Arges wrote:
> On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> > On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > > 
> > > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > > index 482d284a1553..484216c7454d 100644
> > > > --- a/kernel/bpf/devmap.c
> > > > +++ b/kernel/bpf/devmap.c
> > > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > > >          /* If not all frames have been transmitted, it is our
> > > >           * responsibility to free them
> > > >           */
> > > > +       xdp_set_return_frame_no_direct();
> > > >          for (i = sent; unlikely(i < to_send); i++)
> > > >                  xdp_return_frame_rx_napi(bq->q[i]);
> > > > +       xdp_clear_return_frame_no_direct();
> > > 
> > > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > > "no_direct" fussing?
> > > 
> > > Wouldn't this be the safest way for this function to call frame completion?
> > > It seems like presuming the calling context is napi is wrong?
> > >
> > It would be better indeed. Thanks for removing my horse glasses!
> > 
> > Once Chris verifies that this works for him I can prepare a fix patch.
> >
> Working on that now, I'm testing a kernel with the following change:
> 
> ---
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 3aa002a47..ef86d9e06 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
>          * responsibility to free them
>          */
>         for (i = sent; unlikely(i < to_send); i++)
> -               xdp_return_frame_rx_napi(bq->q[i]);
> +               xdp_return_frame(bq->q[i]);
>  
>  out:
>         bq->count = 0;

This patch resolves the issue I was seeing and I am no longer able to
reproduce the issue. I tested for about 2 hours, when the reproducer usually
takes about 1-2 minutes.

--chris


