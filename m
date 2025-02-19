Return-Path: <netdev+bounces-167767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDACA3C27E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996B13AFEE4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4E18C008;
	Wed, 19 Feb 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEwKX5Xk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4543595B;
	Wed, 19 Feb 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976464; cv=none; b=HXpkEZQHd0qChTn80Ni31BEY+oB61X05CJq7uqpZirn0OA8ZPZalW2Js3VV2wvjaXFdc0rdeewZZ7NJqv3a7s9l8SoxEgMga4bBCHv2RzmvyJ4usGcLi/DqHJlBxNZYUtPB+DPi9k0nD6Hqt5cLVvQSE8jGBIWowmJsj27pwHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976464; c=relaxed/simple;
	bh=PWf83lHH1CbX7g4OE56Q3tOSzAlGY69s8uTYqC4rU/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjQazhMmrZiassMRlw0R5wZ9c8zkLitJ9H7euBizIPf2FD/O69VQgCo5L5GN0XKPatlHnfE3+QoOuKrS+D0HzsiwG6fl25AKCLpo+ORPh71k3XpVeLTnP6zTiTN+MGxsWCMqhL8Z5ZkBeVQYTZCd6fFGSu08n0ZRqre2nWNAmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEwKX5Xk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso13665118a91.2;
        Wed, 19 Feb 2025 06:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739976461; x=1740581261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5dsTYe1UcGt3x043SagaFh0jmczJ8yiUGL829wJKMw=;
        b=IEwKX5XkeyPY87Cv8L+kv0M+MOCAtkxKznNLZEYFKQP2RjWSUQvdvDJKbm9J59m5ZP
         FfsswcgiYCIkmmUIlQXEnPi+UjdmthgsqBh8auNtUpXZk4zkSpfupGHlOzTodjnH6OZ3
         sMeaLIWP96KG6CdugB7qcTq5+eB4u7AwgcwSl2z9CKrzrof4ObMpnWQPhG46K7/lRZ2E
         MzGF7tnADOz9c6gCVkx6ucll392eAOf5vpmhqcaL6mRKGLW21JuJAVq/eHQGTbJALTYW
         mG0PXoyNvCrT3FKdnKBaWElsnLnDFET/0EHk+aQ+VZz5KUnHDrLJ7oXRzM7JWyA68PHK
         ewvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976461; x=1740581261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5dsTYe1UcGt3x043SagaFh0jmczJ8yiUGL829wJKMw=;
        b=OSHOz/RF7DssACIYqYskNAkImN2+zQ7dGxH7ZGaEPNKh5hfFECBFwFnlT9hBldMv2M
         GXKJw/lO3HvqP6AiMayg929lZUaPpx983ORwsgDyY40yQOEod54BuJINWvALQ3BeHVtt
         yRYeaPWUAq3+9gnvwMZdzmUsd5Nyido3rNqDUSduk8PGt7fnX7Irf/QZ1Q1ZGtcNuVDO
         04wEbjSTJw5V3XA8AcI3Is9tc157q/HHkN+qv/mLg4W2cUp8KU9IS/NzDY3DeHbEG7k6
         t6uGAo8Vz66zL+9/RQa8jUGRhbt+/85oE6eGMRjiiiz7aBG9oTc0LqHY2V2QR22w+ezS
         ES6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3kbfx21qDYkFuqmRd8IxgQyR7NGYETfjeID074nnH2dRyj2gmoWPVW0H7Q5oQVYGbQj1NChmRlJvNKx8=@vger.kernel.org, AJvYcCU4qDAKu9ROdPAVkBs1ybq/k4eyZo+bZ3H0AnREpe2L4j+6loqzatkxZIr6L1pSwb2qLwtrbUVo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ALDd/qQL6cacWYnOVjB0s8/hEj2A4g+fEC3p/nmZ6FmnUxCE
	4ZleeP8hZ+w9okyjU4J+IxNLYp7J0ZwPHGUisQlmLMquc/W41ERc+vXoQixhmuTOwiID6tJOoxn
	RG91iP9fvOn2L3zEg8dRyaJDjDB40g0ZSnUs=
X-Gm-Gg: ASbGncu8vzjeh/Y0Lu83HNvvqZdpxYsWXrk9niKBde/TRfC0LtYeRxBAyHcZgy6O1Be
	gxpVu44QOEAO7dzEu9gQRIiJYem/kpK00RbfGMFY8BDm3q2JPcMYbuezAzqZpSMo44INGPmEavK
	8=
X-Google-Smtp-Source: AGHT+IGTm0/gDlwx71/Xw2OaMGDWR52C7tQCBQxrWVSO50CktdLR2VUPQbyX5z4L6RKXGSIhm5JkjyP9Mkosm9D0Eks=
X-Received: by 2002:a17:90b:2241:b0:2ea:83a0:47a5 with SMTP id
 98e67ed59e1d1-2fc40d124c7mr28768178a91.4.1739976461283; Wed, 19 Feb 2025
 06:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116160314.23873-1-aha310510@gmail.com> <20250117102920.GI6206@kernel.org>
In-Reply-To: <20250117102920.GI6206@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 19 Feb 2025 23:47:34 +0900
X-Gm-Features: AWEUYZnAUIyaru8MWqDKgk3-dUJ-t4E7Nz19GBkUaFwkxF4Klji97LxCaNQiA3k
Message-ID: <CAO9qdTEmgdN2CyAJGyeSXMKbM1uZDRwZ-6vGu_ft4uHsNjgCqg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sxgbe: change conditional statement from if
 to switch
To: Simon Horman <horms@kernel.org>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Jan 17, 2025 at 01:03:14AM +0900, Jeongjun Park wrote:
> > Change the if conditional statement in sxgbe_rx_ctxt_wbstatus() to a switch
> > conditional statement to improve readability, and also add processing for
> > cases where all conditions are not satisfied.
> >
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  .../net/ethernet/samsung/sxgbe/sxgbe_desc.c   | 43 +++++++++++++------
> >  1 file changed, 30 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> > index b33ebf2dca47..5e69ab8a4b90 100644
> > --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> > +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> > @@ -421,31 +421,48 @@ static void sxgbe_rx_ctxt_wbstatus(struct sxgbe_rx_ctxt_desc *p,
>
> ...
>
> > +     default:
> > +             pr_err("Invalid PTP Message type\n");
> > +             break;
> > +     }
> >  }
>
> Hi Jeongjun,
>
> I was wondering if it would be best if the error message above should be
> rate limited, or perhaps the callback enhanced to return an error in such
> cases. But that depends on where sxgbe_rx_ctxt_wbstatus is called.
> And I'm unable to find where the it called.
>
> I see that sxgbe_rx_ctxt_wbstatus is registered as a get_rx_ctxt_tstamp_status
> callback. But is the get_rx_ctxt_tstamp_status callback called anywhere?

Hello. Sorry for the late reply.

I still don't know exactly where sxgbe_rx_ctxt_wbstatus() is called. What I
do know is that I can't find a function that calls this function within the
Linux kernel. When I wrote this patch, I thought it would be good to refactor
this function, so I wrote the patch, but I didn't know exactly where
this function
was being used. I think it might be a function called from an external
kernel driver
written by Samsung itself.

Regards,

Jeongjun Park

