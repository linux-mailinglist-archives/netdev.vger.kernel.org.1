Return-Path: <netdev+bounces-78883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D5876E08
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 01:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607EBB21E9B
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ABD7FE;
	Sat,  9 Mar 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO7ECHUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA59627
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709942671; cv=none; b=m3C8RQMHVcDzi2zkjjnT/NKJY3pMw6PnM09TUmAIw1A1eV+4mh+Ep0pBf5TMGmyClxEi2YZNeSjlIs8kQIg0DhzVcmDyWdwiJHwF6ObxPm1J0ei+9+Ybo2o+afbQgxS2HETVDpcOLTBVmy2jikOwAUA4321JyuHSi/4jqkZV2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709942671; c=relaxed/simple;
	bh=vxsATqgNsPjCEnUG9U3rsV4Pk5K0jSUVYO72o5X1hR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw3OKOV6ylgnFah+tAFbMXDhn9x5Fs8Su8sPh7cu44Cf1kf1jZp7OXTc67KAV73s/I+L6j+IMjW2rSP63BWcp90bbw+6RDPBYqOqHf8tb74b3JKON3rAI3rLo7TnZtiadskxvXQ99jhjYspW8CFo0ioTK7NutLzJq4SvNiu+Yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KO7ECHUh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a36126ee41eso365929166b.2
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709942668; x=1710547468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ShLjDVt5TyNUjC5WP0bvmBKt0Z3sW/nw5eC5/Dqk7k=;
        b=KO7ECHUhfUqCYSwFVKfZtIP6UNKf0a1LJaJDi78f5ohgFd9h9HcFUBfvAP/ww33e60
         HU0ev6JJBmtV0d2muXR315uwwb+ZJ21nM6ZDHnt1lqH7pZjXYN3XEXeX5bzO7fTW66v8
         CiiTHAC2Gi6FqG58JlGH9aMghNxMJ8tJjXI8RZiAxqIlrtW6IeH6LhaCS9KZAl3DHQmA
         ngtEnNF92TseMMLumcfFJQkkPflgR5YBEHQm74yaUYrZ3pX6/Vl56U2EkPrLRj8Bl4iD
         bE+6QxbjM6TjzbXjYIGBkFP7M7esAgXxMSEpzyuTDgrAyLnQSMo+HJk/ehHcXhAmTMPd
         36Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709942668; x=1710547468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ShLjDVt5TyNUjC5WP0bvmBKt0Z3sW/nw5eC5/Dqk7k=;
        b=WZOd1etTqK/a3VUb+6lVCdIPak3uakXsmFHz15+/s9xbdO7sb0jaL2yzCzuv+e2H0e
         AzHc1Jj0sKJ7Kf89KwtVeXIWoCwhpWvcDTnESbEPzE8asykwjNHElMOlwRE+ZbgfWXV2
         kiwmRiXBkxAWMen4w2v1dGDLvEyfz4BRN4Nt+tXp+n/Bcxyn7sFZzUJE802pGTLbARRo
         n9z/I+wSdMSRrYwRtpawWmuPdIlCQYuGaPnkY7nHFaxakq4489s5Xiejmkh6dH1IUPLL
         kTS80LH24p3Z5cIL98Gwl+kBIkSEzx9nL+RgpF7c0XmC7SE3LI3qVOanvkV2RcgM7q4s
         NqOg==
X-Gm-Message-State: AOJu0YwhM9FrdANA3Q5EoAsPRAiSmt6ZOGkWzISTZdYeMT5D1RpXgFTC
	aicVDTn02VwajMlHZlg6/GLMnGd2QL1mPrHOWyNwr90+1usb42ykM+J3oeWUcwOt/WWqLNuFKfe
	Sue9HM1auU20whrBvgVl6P4N5n6NdBQftNR4q
X-Google-Smtp-Source: AGHT+IG5/WtGgOurdPyTTfUyg5tMClwiuIy0cwYe/KflW92nffNonl5K+8vLpJQoMoKsScc0PQSkwR4ssZrwckgzolI=
X-Received: by 2002:a17:906:5cd:b0:a45:2b2c:8968 with SMTP id
 t13-20020a17090605cd00b00a452b2c8968mr114204ejt.20.1709942668151; Fri, 08 Mar
 2024 16:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308204500.1112858-1-almasrymina@google.com> <8adb69f3-b0c0-42bf-b386-51b2be76cbb4@davidwei.uk>
In-Reply-To: <8adb69f3-b0c0-42bf-b386-51b2be76cbb4@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Mar 2024 16:04:14 -0800
Message-ID: <CAHS8izOm18Rv7QJfpKmquEgf74PvqZeY4zBnyG73BVFDbCvWmw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool recycle check
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:50=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-03-08 12:44, Mina Almasry wrote:
> > The check is duplicated in 2 places, factor it out into a common helper=
.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > ---
> >  net/core/page_pool.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index d706fe5548df..dd364d738c00 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page=
 *page,
> >       return true;
> >  }
> >
> > +static bool __page_pool_page_can_be_recycled(const struct page *page)
>
> Could this be made inline?
>

Looking at the rest of the static functions in this file, they don't
specify inline, just static. I guess the compiler is smart enough to
inline static functions in .c files when it makes sense (and does not
when it doesn't)?

But this doesn't seem to be a kernel wide thing. net/core/dev.c does
have static inline functions in it, only page_pool.c doesn't do it. I
guess if there are no objections I can make it static inline to ask
the compiler to inline it. Likely after the merge window reopens if it
closes today.

