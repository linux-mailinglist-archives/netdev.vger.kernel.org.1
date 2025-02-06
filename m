Return-Path: <netdev+bounces-163604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B14A2AE80
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5015160ACC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6178239565;
	Thu,  6 Feb 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwuXJQoo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F874C8E;
	Thu,  6 Feb 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861621; cv=none; b=KXPdNtH3mBNnBpmRtqYWnTnd8kLxqjhuoewp3ogUFSnf/xg4kCwKS4VcpEEY/EHvyFTe5UkC2dsMzmNdq/EOOP2LoPSm7Dseh3KQhKWvxjtsrKvHErt2N1M1mrDik//NIKuB5EYDGUHtK+IKYr6Z+EFKnXpdwI6AAdsXOdWVFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861621; c=relaxed/simple;
	bh=0kk5EfgJcoV/YnLA0/m9y1CLQDc9MWJdcdbuMFNZn4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Opqc1Nfsf2V0vpQcVv4E02tU7kQicmXyFsoyJCB8JUxFkzCWylfpJ0KP8jOpIqMmng36t2ijLK5bZjdaSmX35H5oEwMxaCBMcCtgD6Pbbq2oU8m715E/18Py1lOuwehS3mO5ztI6ymc94kfbKGiWD6be4Eo0aa+gg2wfT5ws87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwuXJQoo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab6fb1851d4so230056866b.0;
        Thu, 06 Feb 2025 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861618; x=1739466418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+WojvuQOXgdMwuk0FbVWp823RIAXjccdAGX+eYPfmw=;
        b=SwuXJQoojvrOc7kAOODQ54du14YApb/9+NIARK4SdYMxN3JBmu2IamYSIDh5MXuIQv
         MdjnjgzMSioCgiybAGIPExN5X2CXVOptFc9sOqpCZCZSyfX/mRkaY+GrYxGjMAJ6FtLZ
         YH2bPwbRLuIZ8ALPLwsPyhNxLeFm9DhSElp58x47wqIYaYsSLLP0Ju9lZH4FC6Rx1VIj
         isG8UHhuu5oERVyvWAdi6+s1w6WXs0zpuL98MhM6lVFoRq3S74Qs/AOmH6DKjYhHI4De
         o6tr83KMAb1X2rGRumo8UV7z8l6BSFvVw4tqRZ//gbvwa0eLFwreT0sgVqHSEDio/fh1
         WxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861618; x=1739466418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+WojvuQOXgdMwuk0FbVWp823RIAXjccdAGX+eYPfmw=;
        b=XtJIevM36oz0xW7Rdl+frbOubwiS4AWXpnkSnRHLBpc7wxxW1WW3EG792aQhr9FIZ+
         PF1+MMAcOI5gCdrfrX95mkW+3p52AG/e2wx+J8yYYUGhCJYXbpTC9mcB/HgAOOxW0Ok8
         TRm6kQmURGXZMdd15S2of++S8vg2TYdDaZDeeLmNNUUbbtp3WtnRp4WvFPoVW8YsErPz
         nRoLA4MiSru9BqTVA9dO58rW2/wuJc8MCnClnJXRa36wMMx+TKuGTguUuJGB8REnL5g8
         LdlC0Xp9LN+ihXmMzdtPh40aNEEr5A3EBuJ1uJ5caAGWpZXdh+zN8yw9OLBi/ZrXT9DK
         HaQg==
X-Forwarded-Encrypted: i=1; AJvYcCVSIvLFLg6DUjSEJJJyz9eJiwGaj84BaGjMco4PK7QlNQ+SC5/ERnKQ9rqc9/eUFhFV3LjXuKKl@vger.kernel.org, AJvYcCXXvrM1whCh76t7W4n8mFjfLrD5PT8dbqgd8T9dsrwRj+Y+/e7guiQz0vefA7ZaOD5sJ3fI2D21N5hrgOeg@vger.kernel.org, AJvYcCXcNuAwsyqlZOYGXpZrFvSG3T3j0lISS0tbyAYBKdfQHdY8Cdi0Kwj8azDbopxSEluQ7Hu2t/c2DfxZGGhQ1bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkpk9b3tpzpiv+o1tGh1oKPyTc1PCflOXOiX7OiZKBaEhJipUi
	a5A8KUjX/X7eShvUjgRPZZoJtAgB3Lo5dJG602z2oO+fU+9RsiE=
X-Gm-Gg: ASbGncv6APpF2h4jzoXJYEFgrVMqkCZ/iWflwvPn/q5z06pOKMrODtSdK9d4ZcB8zyb
	Wj1n08N8BBll0Fju/WO57bcdBDmJFUtKcSxIMDhM/Tdc3qR8Xy74u5pBr/Ov7iC4NGSnfGtDXsP
	riuGsnhx6zW1WDowuCxkPyv7deYl92+G3ChqdCEC2XfmB8lTbR1CwLtGgbWDY2IR4B3BlkHHUe1
	QguwVgxThaK0FLSLuqC5sX4HvNUOcOR8/pCE2a3wHtON4Ld7uK2ABhWEZCYgf5D/DoGM9mVyJjf
	5Q==
X-Google-Smtp-Source: AGHT+IHYqtAGtHEQqeORbbkVWIWAYhFOaZj8V5aDzbyZG5IIIutbmMKbPa+/C2jnRxaFK469D27GJQ==
X-Received: by 2002:a17:907:1c0f:b0:ab6:726e:b14d with SMTP id a640c23a62f3a-ab76e9d8cb5mr481473866b.23.1738861617771;
        Thu, 06 Feb 2025 09:06:57 -0800 (PST)
Received: from p183 ([46.53.254.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e70e7sm127281466b.87.2025.02.06.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:06:57 -0800 (PST)
Date: Thu, 6 Feb 2025 20:06:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: less size_t please (was Re: [PATCH net] xfrm: fix integer
 overflow in xfrm_replay_state_esn_len())
Message-ID: <3c8d42ca-fcaf-497d-ac86-cc2fc9cf984f@p183>
References: <03997448-cd88-4b80-ab85-fe1100203339@p183>
 <1ee57015-a2c3-4dd1-99c2-53e9ff50a09f@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ee57015-a2c3-4dd1-99c2-53e9ff50a09f@stanley.mountain>

On Thu, Jan 30, 2025 at 07:15:15PM +0300, Dan Carpenter wrote:
> On Thu, Jan 30, 2025 at 04:44:42PM +0300, Alexey Dobriyan wrote:
> > > -static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > > +static inline size_t xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > >  {
> > > -	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
> > > +	return size_add(sizeof(*replay_esn), size_mul(replay_esn->bmp_len, sizeof(__u32)));
> > 
> > Please don't do this.
> > 
> > You can (and should!) make calculations and check for overflow at the
> > same time. It's very efficient.
> > 
> > > 1) Use size_add() and size_mul().  This change is necessary for 32bit systems.
> > 
> > This bloats code on 32-bit.
> > 
> 
> I'm not sure I understand.  On 32-bit systems a size_t and an unsigned
> int are the same size.  Did you mean to say 64-bit?

It looks like yes.

> Declaring sizes as u32 leads to integer overflows like this one.

No, the problem is unchecked C addition and mixing types which confuses
people (in the opposite direction too -- there were fake CVEs because
someone thought "size_t len" in write hooks could be big enough).

The answer is to use single type as much as possible and using checked
additions on-the-go at every binary operator if possible.

Of course one bug could be fixed in multiple ways.

> If you look at integer overflows with security implications there is a
> 5 to 1 ratio of bugs that only affect 32-bit vs bugs that affect
> everything because it's just so much easier to overflow a 32-bit size.
> 
> aab98e2dbd64 ("ksmbd: fix integer overflows on 32 bit systems")
> 16ebb6f5b629 ("nfp: bpf: prevent integer overflow in nfp_bpf_event_output()")
> 09c4a6101532 ("rtc: tps6594: Fix integer overflow on 32bit systems")
> 55cf2f4b945f ("binfmt_flat: Fix integer overflow bug on 32 bit systems")
> fbbd84af6ba7 ("chelsio/chtls: prevent potential integer overflow on 32bit")
> bd96a3935e89 ("rdma/cxgb4: Prevent potential integer overflow on 32bit")
> d0257e089d1b ("RDMA/uverbs: Prevent integer overflow issue")

This one is good demonstration why BAO is better:
https://godbolt.org/z/14ofdfvhc

> 3c63d8946e57 ("svcrdma: Address an integer overflow")
> 7f33b92e5b18 ("NFSD: Prevent a potential integer overflow")
> 
> > 	int len;
> > 	if (__builtin_mul_overflow(replay_esn->bmp_len, 4, &len)) {
> > 		return true;
> > 	}
> > 	if (__builtin_add_overflow(len, sizeof(*replay_esn), &len)) {
> > 		return true;
> > 	}
> 
> This is so ugly...  :/  I'd prefer to just do open code the check at
> that point.
> 
> static inline int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> {
> 	if (replay_esn->bmp_len > (INT_MAX - sizeof(*replay_esn)) / sizeof(__u32))
> 		return -EINVAL;
> 	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
> }

You can't open code if you have something like this:

	X = a * b + c;

Second, the code is now effectively duplicated, once in overflow check,
second time in actual calculation.

BAO and BMO may look chatty but they're doing the right thing.

