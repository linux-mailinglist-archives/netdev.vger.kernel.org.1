Return-Path: <netdev+bounces-209146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D764B0E790
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A902D3A4D45
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44E156CA;
	Wed, 23 Jul 2025 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0elZRU6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFA2E36FA
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230105; cv=none; b=XO9NF8Yw3+do/0Obnc37Ns8zasTnUu3WtN6ljA9Q3udRtqMSLXsSF2c/bkP5+DYuijSXDD+W7vZV7qFFd2xCXoJXqTFaon9AUQ1q8HX50vj9x9LJyaBtsc+MMJHmuHzxCVXBfL/dr7uC2JM1oKgdYcQWZkxX906t5Y9VoAZvuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230105; c=relaxed/simple;
	bh=3B8oGYKqxq6bN7oLyibAlFmYoaYKpNAqyo5dpnbQaMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3SMIlcIeEckMay6JptyWgxjaPEEnh1zg9pl8jYSVVJEXYAglowlm8n51+1BCOi0YhvsECqdBrS3BnFx54JVAKNEbrlbMcrPxI57j7cJsW7cD6KFZDrnB/PpVOAdHHlHTAzg04pvx9L/8AGqifsBthhy+twhLPOsAv6bJD1pRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0elZRU6b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237f18108d2so85045ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753230103; x=1753834903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKou5T6jjhYJRS+fJK+c9beYVAJB+czjecP03lKrYoI=;
        b=0elZRU6b2C/kT5531PK55w/2+uFUu/odm7SY4j7OZiQdID5bqOQuW3O1ZmnTgzVprW
         +P/UgDkvDExaCyEEdonTRFvoHX8Y7Mc5jWX7yy89SG8aGNvZ+LF6jHiPTQoStUvZ7vfd
         p9nAoS/t/L6QS77K8KIaf7WU24U4C43Xzj8CaQ2alN4vfV14A2Em231CWhVsO0DOIY/C
         uA+OmYSLBKmKHPS9NX/MXzHOTraqVTvK7KmI+gBkSTQ1FQi/6RB0yQ9uVymeBU4vbFad
         Mr4Y6DsyrCjeXoEMwTLBdj/lmlFaVf155U359uWdaK8agdcdmwx8RSUUhGL3qhSU/YJU
         Wz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753230103; x=1753834903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKou5T6jjhYJRS+fJK+c9beYVAJB+czjecP03lKrYoI=;
        b=FurueGhWLqU8qxoI0WOQUwqi5cyuPbtlTOklgvcV6ky6QkUK+QayiIvF+Yg0Q+IugC
         pGgXDYi3PCWyoo3vt4dyaxxntiKBa3FVttOQgkHUVnymsS8mjmex/bQ9IseQbSbncgkK
         UEPZmLyu0EY1q8XgkD04tJpjXG9sJVzSxgth2QABAJLeYTrq6IyzAHlWud/bHLKjYH9E
         nTgnBl4GSH29U3hVyoZLcK02BgJgd6QHyrGcNOR+qJiiS7tz3R+Pm8dWy2ro3nVDI38W
         0bF5XIff1r1DjJ/BSawPGUT81lX1jxIeU/jUNNSKRGtHhQLKIVegVf/HNdkhSp820caL
         ZCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxSB3/ngec9HtNHYnRXDvEmKGbA4uXJOM78aYJs8M5B+zM75cwmVbQOS0huxGOqWPVL9LbBKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBR546f8G73qXwiR2rHWdSQWuOFXa8mwqRpyz4iGwcRFN+HgJ
	XXD/cg+53OSqq2l/nE4gqZG89/lzmrxTrXX1Y5VeOScM8VvGxGuXVEJu0k+2o4rY+zS5ZfdJNNS
	TnE/srmH89Ml/o2irNWmuMHhcS7xb1BpoZ+qVdkNa
X-Gm-Gg: ASbGncsMSq4bxPWsuU5bgarkfnQ/HKmw+qN87C65kUklwErFOoVw7n00fqRWkVTPHWG
	6WnBUbB78dk1WVlyLrjR6f5cc3x2KrBgx8nbNZAG12Ct2PRMXQ7aypWsQaEjedzYZlsAv2zv4J3
	NZpA1wGmQnYiYj5BxHN21odo9uFKw+EtiGNNkMxtC5AI27/fzLpNijrhmn/3a/uSauEndlPG1gc
	bn8+iX7J4dAwD2/sXfkKZSCNvPKiClGbtxsHw==
X-Google-Smtp-Source: AGHT+IEQeZCIdHi0V+DxkoGGF7AcjDGNzwBvFMVANikWrcAQmVDZA5TsZEnDj8p6ca3Zasw3IP1ScDSpHmGAdnw62vM=
X-Received: by 2002:a17:903:2304:b0:234:a44e:fee8 with SMTP id
 d9443c01a7336-23f98dde4f0mr803645ad.27.1753230102498; Tue, 22 Jul 2025
 17:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722030727.1033487-1-skhawaja@google.com> <20250722030727.1033487-2-skhawaja@google.com>
 <CANn89i++XK3BFzk4t4bvKeZtqXT-FUCaY_5SkSTOeV0AGNDdZg@mail.gmail.com> <20250722154127.2880a12e@kernel.org>
In-Reply-To: <20250722154127.2880a12e@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 22 Jul 2025 17:21:30 -0700
X-Gm-Features: Ac12FXzE3uP6ATwWT5gYj_NDqhtm3-2ZD50GXEXbyjXOBHc2HRRab6luXwealg8
Message-ID: <CAAywjhTgBCrSQ9EhaNgoXYaKtqWn0Ks+8=nXo_-rnCU_hV4irw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/3] net: Use netif_set_threaded_hint instead
 of netif_set_threaded in drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 01:21:58 -0700 Eric Dumazet wrote:
> > > diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/driver=
s/net/ethernet/atheros/atl1c/atl1c_main.c
> > > index 3a9ad4a9c1cb..ee7d07c86dcf 100644
> > > --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> > > +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> > > @@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> > >         adapter->mii.mdio_write =3D atl1c_mdio_write;
> > >         adapter->mii.phy_id_mask =3D 0x1f;
> > >         adapter->mii.reg_num_mask =3D MDIO_CTRL_REG_MASK;
> > > -       netif_set_threaded(netdev, true);
> > > +       netif_set_threaded_hint(netdev);
> >
> > I have not seen a cover letter for this series ?
> >
> > netif_set_threaded_hint() name seems a bit strange, it seems drivers
> > intent is to enable threaded mode ?
> >
> > netif_threaded_enable() might be a better name.
+1
>
> Cover letter or at least a link to where this was suggested would indeed
> be useful. I may have suggested the name, and if so the thinking was
> that the API is for the driver to "recommend" that we default to
> threaded NAPI, likely because the device is IRQ-challenged.
> But no strong feelings if you prefer netif_set_threaded_enabled().
Yes. You suggested it, but I am changing it to netif_threaded_enable
as it maybe is more clear.
>
> Since this is a driver-facing API a kdoc may be useful:
>
> /**
>  * netif_set_threaded_hint() - default to using threaded NAPIs
>  * @dev: net_device instance
>  *
>  * Default NAPI instances of the device to run in threaded mode.
>  * This may be useful for devices where multiple NAPI instances
>  * get scheduled by a single interrupt. Threaded NAPI allows moving
>  * the NAPI processing to cores other than the core where IRQ is mapped.
>  *
>  * This function should be called before @dev is registered.
>  */
+1
>
> Since this is just a hint the function should be void. No caller cares
> about the return value anyway.
+1
>
> BTW I think we should delete the debugfs file for threaded config
> from mt76. debugfs is not uAPI, presumably.
+1

Do you think I should send a patch for that with this series? I was
planning to remove that separately.

