Return-Path: <netdev+bounces-133744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49F996E2C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B75F28591F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47E2AD1C;
	Wed,  9 Oct 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReWbcZvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D7B18EAD;
	Wed,  9 Oct 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484535; cv=none; b=ZRpGkWSxFgrE3q05DjwNOwcQm/Vkx4t5lyhzEKnbUlAiRtskCYIIXMcQ/+3e0Itp378aHVpykNnNdblvAbfM92lCJXEVu9l8+cWpJKgdKiizJd4nqRG5mlwZYofkv6jI3lJC+5y7bOSJPey+6k5G9nDz59Wcat4LVyjU9IjWS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484535; c=relaxed/simple;
	bh=Mq5bnIHHkjxk/ai0sXp0RDz0fGxZm4gwe0mCN2r/AwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqzrMGaR5wEXYL9G2lARWI/F9+4gr5ORqXq0+2gg9GffSja/KN/XKMCd7Z24aKxUXHQCVmppuIoVTCC85AZHkQxDjHuVPe7K8FouidkHF0Ttmyn8926dSLCUNpk8y7gX8ckMLichw97g9R2hMSiFndSmvFdcn4mZ4rdFPOXU0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReWbcZvA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e27f9d2354so1694145a91.0;
        Wed, 09 Oct 2024 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484533; x=1729089333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE8w138OJh2+67SyRoXpLa5Q4XosqnHKS62oM+A/S94=;
        b=ReWbcZvAFh4tTq1j3nko+qQoZyd9kXiw+CR6dqHVIP/gvESBCjPowjKojzyNq4V7dy
         iC2xS7upxxRW7D9qd80liUKC04MCG7Xc+mK0hbEV7ZRxtw9/VzLIxrlBtWY+/dX3Ma+I
         RGba1FiMhjZMMWPNxpVeQU6hORFEaM3obD4qW8SmxlXrkHoJOcFWGA3kcB/e39yPP3WH
         d+iJvDZXcX/qmwsgONPwUK85kmuYb77rU/3dDKD0jCx9ytEhdzHooBNeGlD4AUob2t0S
         KwiXkiSn0BmG1+jmwA7Xg/9Jlx+XIJhTSP7N2EdBUjOgrYAYawI0Oww59LnYfhq2BkQC
         abhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484533; x=1729089333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE8w138OJh2+67SyRoXpLa5Q4XosqnHKS62oM+A/S94=;
        b=grYzO1gHS1Tihf5EsnvAITI58KyUnT4ijOQVSKskypG7jjE0TEisaCeLPCm5SwBeUZ
         Zex0MeyjYuJzYu0GtjbEVeBVTtT+YYI7KUK8fIOS4Liy4VVa6t6XLrcUowwd1BMyaT+b
         svF1srqLlbRtA0UaSmRpFSjtflwwBvAWV7ck6XcTK+4vLnvVAZ8l2yU0KlK2WjmgJGtX
         Atbi/+F3K2x5CrKZ/Rwp5Ehcu4Cg7r6m58Ky4Om1CKCA2p5ByAAq6H6HgWZu83xt1OuB
         Ahf7Oywe3K4oirGH+pFIZU0VTXHVqpZbkQfUbMd0oVIv0sGTU5WrNaHVVW6BituedEic
         RnFw==
X-Forwarded-Encrypted: i=1; AJvYcCWId93ha97znv70VR7AyK21fS20eAvGoH8EbgUnu2ENJi2UbXAFKNNpRLop3hVjKzSTl3yvZ3cHtNo=@vger.kernel.org, AJvYcCWwwRjqQ1br+FGgGTarX1IuMmT2Jh1QEIy9vM9a/p9huc7GIVv26IWebtY88ZYjV/RDjwVVS3ym@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDMg1pOq5PDgkEbvUPtulVzzwgR6pbR4lFHKZlNiRMWOZMsYI
	4GM3PRkkkmxDxAjA+hQluMEpxjHAPJqPES/rH0+ojsF13aZ7K6IrA8NzX+SDUgITPjEHDGPXhDk
	/hMdgvQfHcYE5utVkGclIZKBh+3w=
X-Google-Smtp-Source: AGHT+IHdkZaGC2dh3CpEOkff6JT6TMjx9kV42HT4uMaGHFi17K3oPaymgywwLQGumYgnDTG4Dpr+o1UECUabWOlp6G8=
X-Received: by 2002:a17:90b:33d0:b0:2e2:991c:d790 with SMTP id
 98e67ed59e1d1-2e2c6304845mr289387a91.8.1728484532922; Wed, 09 Oct 2024
 07:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-6-ap420073@gmail.com>
 <70c16ec6-c1e8-4de2-8da7-a9cc83df816a@amd.com> <CAHS8izPmg8CJNYVQfdJB9BoyE75qf+wrz_68pTDdYffpEWDQMg@mail.gmail.com>
 <20241008122820.71f67378@kernel.org>
In-Reply-To: <20241008122820.71f67378@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 9 Oct 2024 23:35:19 +0900
Message-ID: <CAMArcTX7qP6B7Evjv96kVNq5DFinaDOK=xq7OYXYXbhE+CrdPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] net: devmem: add ring parameter filtering
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Brett Creeley <bcreeley@amd.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, dw@davidwei.uk, 
	sridhar.samudrala@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 3 Oct 2024 11:49:50 -0700 Mina Almasry wrote:
> > > > +       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> > > > +                                       &kernel_ringparam, extack);
> > > > +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_S=
PLIT_ENABLED ||
> > > > +           kernel_ringparam.tcp_data_split_thresh) {
> > > > +               NL_SET_ERR_MSG(extack,
> > > > +                              "tcp-header-data-split is disabled o=
r threshold is not zero");
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > Maybe just my personal opinion, but IMHO these checks should be separ=
ate
> > > so the error message can be more concise/clear.
> > >
> >
> > Good point. The error message in itself is valuable.
>
> If you mean that the error message is more intuitive than debugging why
> PP_FLAG_ALLOW_UNREADABLE_NETMEM isn't set - I agree :)
>
> I vote to keep the patch, FWIW. Maybe add a comment that for now drivers
> should not set PP_FLAG_ALLOW_UNREADABLE_NETMEM, anyway, but this gives
> us better debuggability, and in the future we may find cases where
> doing a copy is cheaper than buffer circulation (and therefore may lift
> this check).

Okay, I will not drop this patch in v4 patch.
So, I just will fix what Brett and Mina pointed out.

