Return-Path: <netdev+bounces-145026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30F19C9269
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F6B2841DF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2B19F115;
	Thu, 14 Nov 2024 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="lkmqC5Ym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72319939D
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612463; cv=none; b=LaoR7CBX8mwCp6Y6L9gKmM+lY1x4dbW+CXB8DGq2cdk/LRexlM405MRQuQgQbrHqtuFXIcE+46sAuNmoH1GmQuDvt6gdUSyUQFlxA+LsJUz7DmPHmDzCnV6TCyAJoeM4e6EW+bpHv2ecF9gAZFa0nAqwaZlueL5VXAbY9ybVeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612463; c=relaxed/simple;
	bh=txcz9rml5UlukCVS1D+ITLftMxjZTir6dwyu0ic8vgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1YymavPX1L/C9dMeyo+p+bQ2Ud1PL5OovyVLyW+i1ciw2xBV4RToimztZmhA9kECc/hv00CeIHhNjzfqfRCvJBRppQOnIuUatzPZWIONgyOmUi4nZLVOVSu66dI0Kb0bvenqKGwb/RSpW7GnZJXznDUBKFBYU+YbxwjEpu+IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=lkmqC5Ym; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so1326037a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1731612460; x=1732217260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeniB389OKvN5zEj18bT2eYMneg20P17C1/p3gN89l8=;
        b=lkmqC5Ymx6d3saVpOtEWzHv1FucT57O8Ag67el/sfpPgk5EOvJYm3BD3HmwfyRuBBS
         vP9Zgk6NTf00bk/GvcYeS1rtxCWYpzzaTCni5rBKUukfeBPWJfSlSFPX5fDTOUdznqbR
         sU1PMlrIYyVPOZWcXpwr0mnK+mOPKPRGybkhVQKM6q2hPxj4TMyqlhidAh2y7zWKpZ4s
         EAIJP8BpoTzJNFTgUXWAk1m5wFda0g6c8SbRxzWFHuFMzahHlRtZ0+9Oats6c0GDFECl
         uRWCq5ale12V4Iu+2V75nqhFWeBVJdm6qHvfju5s/r1dqlXPTJQsDVjvYN8ZsW4JpfIL
         8BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612460; x=1732217260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeniB389OKvN5zEj18bT2eYMneg20P17C1/p3gN89l8=;
        b=f2C6FcG6gsYWwk87DNlyYAw37/A13o4iSCfawX1ZQKfF9ts21HaYBxZN6G5D0hmZBf
         exQ+2cztNZDDFfayMd/LICyw//9aQqUFiVV2Muk2WH7q94ezs6N84lH6c0qWDN6yvWXS
         EcG8T9Eeka/7nU0ogrUip9hXqulzj+35mQMk0+gV5qBsnWzOZYWd/wXdD5yW1WSWb5v1
         RC8CiDVCwNfJBVkPc3tNYutYHttTXqNUj7SV71a9CZTauTqCJc2LR3L7dQs/NO4kmR0t
         02q0tdjXZRJAjug6PPDB9ZCOBeHEpi8Aa+/HCNmXCwkZ1KgU//i6UblYY0j5g867G3PN
         QEHg==
X-Forwarded-Encrypted: i=1; AJvYcCX/EXdbGIQGrzQDAsY6RancqXlSP1exTVJbzmLT3Fj+QvcOHvvAawK+9worw/hKP0CG7g/d6+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aXAdgFZlDxpLM8C07GXL64+N6y4/+vYFaOTPUnkV0H3rUY9l
	dBtVUk9Hu9pSa9HnIrUu7biw2L487PHmDGDRFKdUUNUilAfFTQyxvBPGedRBCwMRYZP25y09HM3
	snsBXoqW5Dr5elV5OjT0ibLsLqQxjOhEFM7iPbA==
X-Google-Smtp-Source: AGHT+IFSQszniN+RtUbvA9KWKxINe1wk8KIYUXCCO8l/ucVV+qEreHHvFvj2XdwHBbQri+4d2NNe/piuHj9oJNb3iSo=
X-Received: by 2002:a05:6402:2792:b0:5cb:dd06:90d5 with SMTP id
 4fb4d7f45d1cf-5cf77eeb2acmr3116704a12.26.1731612459509; Thu, 14 Nov 2024
 11:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112233613.6444-1-everestkc@everestkc.com.np> <20241113105939.GY4507@kernel.org>
In-Reply-To: <20241113105939.GY4507@kernel.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Thu, 14 Nov 2024 12:27:28 -0700
Message-ID: <CAEO-vhFzEo12uU7EBOb6r6J7Ludhe4HNNGvfN71fSDQRmR16pQ@mail.gmail.com>
Subject: Re: [PATCH][next] xfrm: Add error handling when nla_put_u32() returns
 an error
To: Simon Horman <horms@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 3:59=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Nov 12, 2024 at 04:36:06PM -0700, Everest K.C. wrote:
> > Error handling is missing when call to nla_put_u32() fails.
> > Handle the error when the call to nla_put_u32() returns an error.
> >
> > The error was reported by Coverity Scan.
> > Report:
> > CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
> > returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x-=
>pcpu_num)
> > to err here, but that stored value is overwritten before it can be used
> >
> > Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling=
.")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> For future reference, I think the appropriate target for this tree
> is ipsec-next rather than next.
>
>         Subject: [PATCH ipsec-next] xfrm: ...
Should I send a patch to ipsec-next ?
>
> ...
- Everest K.C.

