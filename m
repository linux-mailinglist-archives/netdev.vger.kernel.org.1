Return-Path: <netdev+bounces-210849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30743B1518E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54963172A8E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193028ECD8;
	Tue, 29 Jul 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dd5JqD9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709DA25761
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807420; cv=none; b=O/OHlT/ftRFFDTOrRl45R8v+roGFn6dTHSoiixVI2qfEZzq5BVEewP/+TFe0qiZSAtqEdW+zHlj0JKTrWBCKvsdQdIDHvxob6Mk2CoLJ8NJfBhU9InnEZxUScTqHlsRilhg6DhFri9edHHzLlz+616A7qMg22RmeNZSXz6SZBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807420; c=relaxed/simple;
	bh=FCIbFdYLhZ8dZkG1o/KAeU8utF5h4qy3DwecnzJGNEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6giwS/B77/3VOPSVbQLLp86ovMDi+qWUWjWi96hRXzSHNt0yz4Bd6Jcu5m2oD2/NPYZXHWg01yRHFvZNjCCY4fVbkfSbY6OK36mE1AzeriUitULAaTmrVe9r242f+eHMvGdQPNwOcWayJAAgeR611XA8vrYipwH8sD3djMzVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dd5JqD9M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e62a1cbf83so577982885a.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753807415; x=1754412215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+FQCzaL+5dcka0AyrYsOL9Mr5DP3w26SIvvkWKSxQM=;
        b=dd5JqD9MuJyfBwagAAgfT+/TwNmAxM6Cgy7/z5GvVu/obxxs/5Z7vQoVillT8k4rRA
         BVXsEwljaYIwW3VpZtySqX9YCA1SHoi/frtKa7GjGBhcUHCFoOCMkYbZre6ip3YJZ7zu
         kYrkgwyUpV3SiJcT93XJBiEQi4Hb7BbyN7W6gFaWJVTh3TWu1+Ff87BpTv8+zcNM8bR9
         j2jKGgjF6vtEyQtM41LWK+s9VMYTzNMbvPsSNfIPbbDjlTJSiHHhG7BuEuwl1EIMteAF
         xpDnjSeul+tovWX1BtW8XFuo02/bGPFztQsetz34bpwaW3qkGiYwZtzF7WlOEt6k9Osy
         LUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753807415; x=1754412215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+FQCzaL+5dcka0AyrYsOL9Mr5DP3w26SIvvkWKSxQM=;
        b=UNC65DlAUGrJ0Hh1YMYzpmLwKwATg5MdnBbFNwndebxrufhmcmvHDv7CXCKs4UjuMb
         b4gu+nuCFGeHLEMLiG2CfOgfXLNO1qITOsQGl0Bk7to+hIcEQMsF+req8EtHg3MbfahW
         MmQ1Uzg/O2Jswi15exWsvhhNOC0qxb0HDCzpM9/BUxXILXi6HdKLUAWWu/tw2PFGEhAY
         mznXCf1iIVCHZ5ag+PYQBCRwD2euQvVESQF4jm5wo7MLoZnMvWb2g0XUaktFuo73CPZD
         zE/4YaEMFHmv/tMIZSSet3qmF576aa/vwqvSi4IhlY7ezP777VEYeGbtvTkgMddzLEyX
         5z4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5TvuQ7OAmuckONZmmTt2ow1HkPkKRZ0mPIat4T9AtYoiEEnlwrOgouH8gP10AzWgZbLsYzKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8QifmrG6wh/oWsz0Sx9Nnlr7NEYkUMCmltEN+smsKxwscNzb
	TIUBluqrkmlVRUzB5FNXQz+QkVV7GCHfZU8xiuFCbJDayx7m+qYXwFQTla3S1Zd2zXw9IP78WZy
	2yp8rMg79Zfcse0ww6RGu/lfFWjxfH9OZUAdTDDTl
X-Gm-Gg: ASbGnctxSdIV89+4NnyX8ee0/0z7OZvi9CYCB7bLAHkKR+AzQmFTZO+v4G2+QPTf8Pu
	y65LpRakcJXelrJwBQq85mKBrRq/hy7+PXLfMQTDzVnYm7979mo8WV7xKnFsfLgp3jp8E57IFcv
	X1Z27767xjz7N2PrUmlhmpMrwVM1IajuSg0VcAvgVKw8QxPj8WUdbDj6WuU2dOJ3eIeUWRkyrA8
	ctqzw==
X-Google-Smtp-Source: AGHT+IGhY4SFPSW9Pbq6/3vmAAUhktF1lj4vRgGgJD6WtAT3Dz36TwNQnp0I26CyYbqhroSoft/o90tJ9vRNEPz4Mkc=
X-Received: by 2002:a05:620a:a509:b0:7e6:50f1:a871 with SMTP id
 af79cd13be357-7e66ef93f45mr10696185a.6.1753807414997; Tue, 29 Jul 2025
 09:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
 <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
 <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com> <6888f2c11bd24_16648b29465@willemb.c.googlers.com.notmuch>
 <CANn89iLXLZGvuDhmTJV19A4jBpYGaAYp3hh3kjDUaDDZJqDLKw@mail.gmail.com> <6888f5eb491ac_1676002946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <6888f5eb491ac_1676002946c@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Jul 2025 09:43:23 -0700
X-Gm-Features: Ac12FXyQBgKJQCYMujTKcIT7pCsVuNcY-zqNdElvzGKgf3xQlJPgHgRVR7ei2a8
Message-ID: <CANn89iKA9O1jsTjm+vOQqN7ufBJFod7oySUC=2G7wcV2cGTkSw@mail.gmail.com>
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in ip_output
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	quic_kapandey@quicinc.com, quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:25=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > On Tue, Jul 29, 2025 at 9:11=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Sharath Chandra Vurukala wrote:
> > >
> > > > >> +  rcu_read_lock();
> > >
> > > How do we know that all paths taken from here are safe to be run
> > > inside an rcu readside critical section btw?
> >
> > This is totally safe ;)
>
> I trust that it is. It's just not immediately obvious to me why.
>
> __dev_queue_xmit_nit calls rcu_read_lock_bh, so the safety of anything
> downstream is clear.
>
> But do all protocol stacks do this?
>
> I see that TCP does, through __ip_queue_xmit. So that means all
> code downstream of that, including all the modular netfilter code
> already has to be safe indeed. That should suffice.
>
> I started by looking at the UDP path and see no equivalent
> rcu_read_lock call in that path however.

ip_output() can already be called from sections rcu_read_lock() protected,
or from BH context.

The caller's context does not matter. I am unsure what you were
looking at in the UDP stack ?

