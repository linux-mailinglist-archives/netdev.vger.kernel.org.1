Return-Path: <netdev+bounces-67669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB484483E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3B4289FE1
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E77381D6;
	Wed, 31 Jan 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmQybhTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF203E48C
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730490; cv=none; b=diysXdcaYXMR3wBNsRDUQdIrPjxcnVEWizm20Y2guUnczKKOYmt2Is6Bv+Our+UJsDmCVozorzwfllyKU09QYj/bnGvRUT4sdzPv4qCWFlImykOkOJd/rtdLuDWi9BBu12iaE7XLvOkKJGl4mgjMiT4sjHn8mWHNJCgoZ/5f208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730490; c=relaxed/simple;
	bh=v6IyS65UmOwWuHfGu0R3AwUbTzwQNDbBk1zsTQ3tUvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qByHnKqbdfa230ZHxTa+iSfCQ2GbR2TE2mlzOQci6EtQl8dzA49WcHuBPEGL1zhM6sRZcWNXdNse7z/n22RniZQXOEH28KYDBxx8EbFO4rdeQXyyYHovDRy/Rp32S+ai3RZk+aiUtYm/ndmnxrrd2KLiHF02Z6qMnhRvwoh8m5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CmQybhTQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so66382f8f.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706730487; x=1707335287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3W3WmdQOuZ9gFrB01n/LDgjODhZBd6lgS2FBrNLnj1Q=;
        b=CmQybhTQ3DOdIHzgIi3SkgqB1pQUiiAZoiYBe30KyujkZPVuDFkygfBID8esmMtpLs
         zLsTcMEJH7lrlcmDeA44k/I82eCKTv3Uc8KWrEZWnasH9VRjscIcdF6jD3X1FwF7EcYV
         jhosMGGC11j3M+2wzEbA/34U+Rdy/755N7aIb9ggMBXnHL29H5umiunMt3E6iy7SA1Gy
         DbqZsiap7wrZMR8Ugyuwx8lPXXx9IIXyVo/hE4OyBUCdK3VvsYBKyOQTMBLCfA5Bd5gz
         hAuQxjBjj7M4KbTAnv/4atYuK+tuqFXak0ZdIv04y0+OrGLAWnTyunzkBCc9eeD8EYta
         8ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730487; x=1707335287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W3WmdQOuZ9gFrB01n/LDgjODhZBd6lgS2FBrNLnj1Q=;
        b=p7gVXr3KfC+VJLt+DIdwhgPSOKbiKLc+xrGXfWTumqjPBtdQHAwlGeugIaQa0w+PTR
         Dl5nWqgzPdVqkbZUuVJyIigBN/YiVDM0epj3mtVnokBfzxLK/sP3YKPV7dp/kUYki4a+
         8zt9ZN1O/srGV/jdmQIqxdXab8+WcnII+sSi1RIWY+F8X3PG7e5WZVsUol1a2HpbLQR2
         rhuafZlel9vvELdsgxCnMBVvaozA52QzeSKMnCgCZbFJy6HPJ6eXFoRVjFPP4EW8RigX
         K/tZ1KW7BN68ustsYzZsdev8NKQH5UzOYGoQgqoOEDtnXMt2AI5zc/RnBCCBsFF/NRsC
         QTTg==
X-Gm-Message-State: AOJu0YwjmGPiGCS57AGJfvMG0V4/Cq7Hf4WITYZX2hWR/1J8/X9SPab3
	8Eg22YdQ75jxTdonuwRLcd4QeNMs8NIHNFDpLtBjROLZvFaSXOF7j48yCyU/a84=
X-Google-Smtp-Source: AGHT+IF2klwXDsI3DPNemlmHIQMcC4G+atQ+RPbdB9H9wcxpDSrnQ5xlU0mUYhpKGL78gpMkDAtFsQ==
X-Received: by 2002:a5d:64ce:0:b0:33a:e839:acc7 with SMTP id f14-20020a5d64ce000000b0033ae839acc7mr2640834wri.14.1706730486837;
        Wed, 31 Jan 2024 11:48:06 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id r6-20020adfca86000000b0033aed7423e8sm8896447wrh.11.2024.01.31.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:48:06 -0800 (PST)
Date: Wed, 31 Jan 2024 22:48:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <c973a8fc-2baa-49e8-9c8f-fd63ef348f92@moroto.mountain>
References: <4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony@secunet.com>
 <71c2d6bc-ab8d-4fa0-9974-d4ed1f6d8645@moroto.mountain>
 <Zbqhy8U-o2uL2_us@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbqhy8U-o2uL2_us@Antony2201.local>

On Wed, Jan 31, 2024 at 08:38:51PM +0100, Antony Antony wrote:
> HI Dan,
> 
> Thanks for reporting the warning.
> 
> On Tue, Jan 30, 2024 at 01:36:28PM +0300, Dan Carpenter wrote:
> > 
> > Hello Antony Antony,
> > 
> > The patch 63b21caba17e: "xfrm: introduce forwarding of ICMP Error
> > messages" from Jan 19, 2024 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	net/xfrm/xfrm_policy.c:3708 __xfrm_policy_check()
> > 	error: testing array offset 'dir' after use.
> 
> > 
> > net/xfrm/xfrm_policy.c
> >   3689  
> >   3690          pol = NULL;
> >   3691          sk = sk_to_full_sk(sk);
> >   3692          if (sk && sk->sk_policy[dir]) {
> >                             ^^^^^^^^^^^^^^^^
> > If dir is XFRM_POLICY_FWD (2) then it is one element beyond the end of
> > the ->sk_policy[] array.
> 
> Yes, that's correct. However, for this patch, it's necessary that sk != NULL 
> at the same time. As far as I know, there isn't any code that would call dir 
> = XFRM_POLICY_FWD with sk != NULL. What am I missing? Did Smatch give any 
> hints for such a code path?
> 

I wondered if that might be the case.  The truth is that this sort of
dependency is too compicated for any static analysis tools that
currently exist.  Smatch tries to track the relationship between
"dir" and "sk" as they are passed in, but it will look the relationship
information when we re-assign sk.  "sk = sk_to_full_sk(sk);".

So what we do in this case, is we just ignore the warning and if anyone
has questions about it they will look up this conversation on
lore.kernel.org to find the explanation.

No need to worry about trying to silence the checker...

regards,
dan carpenter


