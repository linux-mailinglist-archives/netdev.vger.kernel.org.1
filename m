Return-Path: <netdev+bounces-67923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E1845611
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CB4285144
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68015B982;
	Thu,  1 Feb 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNcHTb9M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA84DA08
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786093; cv=none; b=aph/knaIG3nQeiN4aAIGKBw0eQQlS6uhZxZcGtvFz99EuVDpMitTlu4aSabIHzru4+2010x+bvviRa5YenbIBODYWdmwLkz6qC6H73EW5CvQg2ARCSH4JXdSv4Ym76ifXJWIdPlqxBX9P8grm+yOaNtKDKT2LjJkfwPpjo+YwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786093; c=relaxed/simple;
	bh=xNtkPspHntdPzr5Ffe+NCRuOMeZlQuhk+sW72yxtl10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buslCInmvi43PW6bpwKEDwbrjD2+ffE9MUygaTxTcWaLkm8RxTlfmcihpA1QdsFpOVviwedXrUlAk1FAYuTFBwIxTbe508DXiJe9ZcGD740fHlwZr9velMi35EItfnTch21q9S1WqOOlC3vbrwpEz42WFsNGF96xn5ob6cj7lU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNcHTb9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706786090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiDecLcN2BTRdAt58EEG6kJUfd3Chl8AJw+RMy5FVHc=;
	b=jNcHTb9M5olVvbum9Ms29WMjgNCYZa3QhP9gcPJCYGTIEtjdTF9KQCFcJiLpaCrXw14A/I
	mQy6Yo/MMgs7jTiunYW/EffKUzAfnN9rlwpOxRGIVVpw3Sf7ZisidiWnLJQWNuHeWfsb8b
	sNChuo1dLWK+aq6Rfb4cd16cGmsKAh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Ot2T95ewNSq_ZpWsLUUTNg-1; Thu, 01 Feb 2024 06:14:49 -0500
X-MC-Unique: Ot2T95ewNSq_ZpWsLUUTNg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e40126031so4495115e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 03:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706786088; x=1707390888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiDecLcN2BTRdAt58EEG6kJUfd3Chl8AJw+RMy5FVHc=;
        b=A8nUMa2qcYKLOVbZ2utMwr5gJRiblj43UaHBNBfg0Kq4AChHCajCXl9X6r+l4t0yDZ
         QCaVkD3W1ZAQ63a6iRLSKfMFfH+oyg2Zq+tRGRNJjX44OlHPMgxCHYTRMpA7Hl2ZtaPn
         b1CYHpA4ydX6gXCDu4QZ1PljGj02b+HFI1GMUF4PFQXv00Cyh/aPm6egDZhBYaosPPmx
         0e8K3N5FMmUJP70VLL3vHLoMhhjwWqzrez8FPP96otEk2xUTtPMKHUEzd66Bh8y7WFGU
         Wtlge07ewTdDk4Sm9SnVaTC5bbiaJWDrrN5RaGWdFaoBCgy0bL+W+ZCpi5Xj426zABpm
         Xcfg==
X-Gm-Message-State: AOJu0YyQjFQwPQ3JkW4ZHlSmDy0tB6P6hmTRXbsBSEpvcTQ9NFNsoI0M
	hAjNZtvgd/cHPBXhdJcNu6qLMzDBLo6c+8N8IZM96SwPnt2C8F9mjtzogAn3O8doqXbsZXAr2ve
	5TuIF6eK07o4Aij9UF1la3gKgWxqXQBbTpdIbdXFFCulzP07/qDm6kg==
X-Received: by 2002:a05:600c:5491:b0:40f:bdda:161b with SMTP id iv17-20020a05600c549100b0040fbdda161bmr815434wmb.22.1706786088040;
        Thu, 01 Feb 2024 03:14:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHea0PMWNZLgqp91n+MArLou2EEZHsS958kLTP9wNKS5gnmEFiBSu7DyR4eE56La38gjZ4kw==
X-Received: by 2002:a05:600c:5491:b0:40f:bdda:161b with SMTP id iv17-20020a05600c549100b0040fbdda161bmr815412wmb.22.1706786087664;
        Thu, 01 Feb 2024 03:14:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGsvBn3OhhbBmCNVFqXtYs04VORLnSb8lXgTw6Wk4uiOW/TFobB2kQnUfL0UReSm0hWh/fCW/s0d+9dTMakfbeqRHmlLcWWKT4YYPWuahty3sgao6Nc87g84tQLDqWONAU7WT438Mu4uVHNS8r6rNjFZl8aehkTNM8d/C5QXhRhQ51gEwc+rvsJUmFuTW830nc7MEp3e80AZy5bti4ee4qvLCX5FfAK+DyvKiFNTP5y+3LUwDDVQIp7DZFINOifI6iC8GIxnLBIMwsMDrWuSgM0IYrDQaopOQxEQwls+OCFVYxvHTpyi+xnqnQ
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c260c00b0040d87100733sm4040135wma.39.2024.02.01.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:14:46 -0800 (PST)
Date: Thu, 1 Feb 2024 12:14:46 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
Message-ID: <Zbt9JmpDq3cAbq1b@dcaratti.users.ipa.redhat.com>
References: <cover.1706714667.git.dcaratti@redhat.com>
 <91b858e0551f900a415b2d6ed80a54d7f5ef3c33.1706714667.git.dcaratti@redhat.com>
 <CAM0EoMkE3kzL28jg-nZiwQ0HnrFtm9HNBJwU1SJk7Z++yHzrMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkE3kzL28jg-nZiwQ0HnrFtm9HNBJwU1SJk7Z++yHzrMw@mail.gmail.com>

hello Jamal, thanks for looking at this!

On Wed, Jan 31, 2024 at 04:13:25PM -0500, Jamal Hadi Salim wrote:
> On Wed, Jan 31, 2024 at 11:16 AM Davide Caratti <dcaratti@redhat.com> wrote:
> >
> > extend cls_flower to match flags belonging to 'TUNNEL_FLAGS_PRESENT' mask
> > inside skb tunnel metadata.
> >
> > Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>

[...]

> > @@ -1748,6 +1753,21 @@ static int fl_set_key_cfm(struct nlattr **tb,
> >         return 0;
> >  }
> >
> > +static int fl_set_key_enc_flags(struct nlattr **tb, __be16 *flags_key,
> > +                               __be16 *flags_mask, struct netlink_ext_ack *extack)
> > +{
> > +       /* mask is mandatory for flags */
> > +       if (!tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]) {
> 
> if (NL_REQ_ATTR_CHECK(extack,...))
> 
> > +               NL_SET_ERR_MSG(extack, "missing enc_flags mask");
> > +               return -EINVAL;
> > +       }

right, I will change it in the v2.

[...]

> > @@ -1986,6 +2006,10 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
> >                 ret = fl_set_key_flags(tb, &key->control.flags,
> >                                        &mask->control.flags, extack);
> >
> > +       if (tb[TCA_FLOWER_KEY_ENC_FLAGS])
> 
> And here..
> 
> cheers,
> jamal
> 
> > +               ret = fl_set_key_enc_flags(tb, &key->enc_flags.flags,
> > +                                          &mask->enc_flags.flags, extack);
> > +
> >         return ret;

here I don't see any advantage in doing

if (!NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_FLOWER_KEY_ENC_FLAGS))
	ret = fl_set_key_enc_flags(tb, ... );

return ret;

the attribute is not mandatory, so a call to NL_SET_ERR_ATTR_MISS()
would do a useless/misleading assignment in extack->miss_type.

However, thanks for bringing the attention here :) At a second look,
this hunk introduces a bug: in case the parsing of TCA_FLOWER_KEY_FLAGS
fails, 'ret' is -EINVAL. If attributes TCA_FLOWER_KEY_ENC_FLAGS +
TCA_FLOWER_KEY_ENC_FLAGS_MASK are good to go, 'ret' will be overwritten
with 0 and flower will accept the rule... this is not intentional :)
will fix this in the v2.

-- 
davide



