Return-Path: <netdev+bounces-127504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECD975981
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FBE1F21E97
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE61B3B2F;
	Wed, 11 Sep 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPK/J+EQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2141B1D53;
	Wed, 11 Sep 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076118; cv=none; b=ssOXaKfDHlK9ClLPTqHkgaejBeeJfZ3Lj8ubUl6OJH5pYtRVeX/Ead3Xqc0VQjqttL4x7lIlGeDEV3t0odWbRkdeUsRj8Nh1USgkbPDn4vDN5TBjQQuWwnHRvGLYmIFH909w9rkgx7WNKzlFOnuX6t1qOD6XUuLc/YlQYdhDAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076118; c=relaxed/simple;
	bh=Z4RVgfc5uHKs7ewVUL3u0mqgjSdExBkQE4ZzvPPNM5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9oVWXwKYoQZy+3VAFcMBofZ2TNaTGjD8geU+PNrFxuMcQVMw77vGMuP5PPNWRZ6AZyNrlPgM1lNbjZ6S4082q+5fwd70Bd80d7vkM+PFZ6qHA+XrMdZdmFaav5Wq5SAwqudmW7zXdy9LERon/ErzfCKKiGMSpRbiK7WlEkX16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPK/J+EQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso60342a91.0;
        Wed, 11 Sep 2024 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076116; x=1726680916; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=slfxIcfnsrGD+CeYSsnObbjpdIHxz53HhKI3kduoLEY=;
        b=cPK/J+EQau6FahuieOmxcubVDZYNgotd6LTTOSBH/D+WUs6EdVbdKuIr9Iz7c9O4+j
         Kzts/gsxOV9vUlf1K40nB1eIl7dU5brbYIfuJDjzTt6u6T36w4mUiV+jk/txsCemgs5N
         V5TKUfdwfi+jG4Cm66USHeA7K++LZt8ardmjyuO+JYXG5RFwB7EjCwt42F2ACOcZGZRt
         b+Am5/6wlJdKJhYdBEsfIgVqeCUZNrC9kPFzxuE6a6PXv9NGv81zYaWFTKymK8UZ3ONc
         h0H79OL5tl26Hae+hrY+2+Cf0/vjruIfJD2l17ursOM+DVY1Yzry+xcjYAHNU5oyxJM9
         ZiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076116; x=1726680916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slfxIcfnsrGD+CeYSsnObbjpdIHxz53HhKI3kduoLEY=;
        b=WG5c2k43UJO/bz9WBAjvngpHdNXFwV2jbCnFGPPPZB5uJUbf4M41cVlXoriFeMlL1m
         SEfdCMVcf6iwUSbTh7ZbeOqxyRCXZAMP9651+6oZGZwYg3xr81setGymNr1lQkZRByYD
         SLBJ1EMCZGh+s3yrXqddlTHqve8RUzCj3NfBUP8TL631Ubr6kCHpnPeYGX1PYy0pzQ3u
         c6pWoBBoJRjWBVsK7I5LBX/Ydo5Kk01XEwKg6VC91OldyVj0fBMpSdPP7AhQzx28/HKh
         QCpC1gJb/8tvr38MGPeZ4H2wqe+eRatzhOI1LoxtKIz+UHLbZlmfXF+TiLCD7aESDh1K
         SGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp2qM6rmimpNnqEfCx9vOguyXbEGM5L9dkyk1tDE/OVyQ7uvcvchHi4+UlZldD22BlXFmnTywt@vger.kernel.org, AJvYcCWTOURQhs8nfV7zhxAox137xdaW5ySBmvzgUfc9Yh5jAcN8j1ebWV2TVoyGYw1TUdUr/TsYIz3pqxnizfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8FpcfWawmLL05ztI1YRHckMaLnr6o/ZaIvje0a5Z6e1q9A36
	OWmTxniiEyCgonRnnHJEoV17pszXyVT4Jc6ozALx2+rt79E/xsNG
X-Google-Smtp-Source: AGHT+IHB6rEJGL8SWENnyEiintq4ISgz+q0Q2o1uadwr5fMKQVeIwdubqRhVHM9q03qTAhf1Fxbmhg==
X-Received: by 2002:a17:90a:66c6:b0:2d8:8252:f675 with SMTP id 98e67ed59e1d1-2db83087f69mr4222854a91.39.1726076116216;
        Wed, 11 Sep 2024 10:35:16 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:6166:a54d:77fb:b10d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12bcd5sm10799795a91.53.2024.09.11.10.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:35:15 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:35:14 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuHU0mVCQJeFaQyF@pop-os.localdomain>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
 <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>

On Wed, Sep 11, 2024 at 07:15:27PM +0200, Eric Dumazet wrote:
> On Wed, Sep 11, 2024 at 6:58 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Wed, Sep 11, 2024 at 11:12:24AM +0200, Eric Dumazet wrote:
> > > On Wed, Sep 11, 2024 at 10:23 AM Qianqiang Liu <qianqiang.liu@163.com> wrote:
> > > >
> > > > > I do not think it matters, because the copy is performed later, with
> > > > > all the needed checks.
> > > >
> > > > No, there is no checks at all.
> > > >
> > >
> > > Please elaborate ?
> > > Why should maintainers have to spend time to provide evidence to
> > > support your claims ?
> > > Have you thought about the (compat) case ?
> > >
> > > There are plenty of checks. They were there before Stanislav commit.
> > >
> > > Each getsockopt() handler must perform the same actions.
> >
> >
> > But in line 2379 we have ops->getsockopt==NULL case:
> >
> > 2373         if (!compat)
> > 2374                 copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> > 2375
> > 2376         ops = READ_ONCE(sock->ops);
> > 2377         if (level == SOL_SOCKET) {
> > 2378                 err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
> > 2379         } else if (unlikely(!ops->getsockopt)) {
> > 2380                 err = -EOPNOTSUPP;         // <--- HERE
> > 2381         } else {
> > 2382                 if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
> > 2383                               "Invalid argument type"))
> > 2384                         return -EOPNOTSUPP;
> > 2385
> > 2386                 err = ops->getsockopt(sock, level, optname, optval.user,
> > 2387                                       optlen.user);
> > 2388         }
> >
> > where we simply continue with calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
> > which actually needs the 'max_optlen' we copied via copy_from_sockptr().
> >
> > Do I miss anything here?
> 
> This is another great reason why we should not change current behavior.

Hm? But the current behavior is buggy?

> 
> err will be -EOPNOTSUPP, which was the original error code before
> Stanislav patch.

You mean we should continue calling BPF_CGROUP_RUN_PROG_GETSOCKOPT()
despite -EFAULT?

> 
> Surely the eBPF program will use this value first, and not even look
> at max_optlen
> 
> Returning -EFAULT might break some user programs, I don't know.

As you mentioned above, other ->getsockopt() already returns -EFAULT, so
what is breaking? :)

> 
> I feel we are making the kernel slower just because we can.

Safety and correctness also matter.

Thanks.

