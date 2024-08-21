Return-Path: <netdev+bounces-120571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5558959C8C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BA11F22FD4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A67199944;
	Wed, 21 Aug 2024 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSZtHfRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B6199945;
	Wed, 21 Aug 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244942; cv=none; b=VhIBlseI/pufUtgiy0bHMqAM/6KXK9ENke7pn0f7evx2IKgHygICxQ5gSb6Y5Rv+sxkOO6MSMQh5KYG1vfqjugREXBGwAjkLEDsHXtTimBcSBWVh7yasYQJV5g/tb8ev09uL3yikeFPq0zwjPXwynGT8NxpmgWVgAVpbX1l3rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244942; c=relaxed/simple;
	bh=JOKbt8xKR5Izj5ooNPCDHAGa5qvdb3wy3pAiSOqpSsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAP9cEzxvWhMRv4HvPoCVe0lIT8Nc8gSYLP7W+1BCFrV1qI413VRBLhlhnRg7u52hx9e82Hd7BzeNlo7BjKO2/BX9tPfMgFXcn1SgrSIBJ3aV2xpddu1bF7K0mpWCQ2bAHodoKNVcBR9nHUC4RnJso38Fxl1f/xoaJuSgcU5RBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSZtHfRY; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e13c2ef0f6fso4967591276.3;
        Wed, 21 Aug 2024 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244936; x=1724849736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMXs6xVmn8sixvLxYUQEmixapt75ZvWc1eWKXQGmuWM=;
        b=HSZtHfRYx+wKMORTMH88QuHL/6ot0ftL/BG73gG0khWSUJSzB2pEUgg+I7kduCwyS0
         h+WeRcuObMpqGTGq1HTZhgVDh4HNtYWK2Aeld3fIvaBA4VutXzcryFOdj5wPUYw/3QWA
         rx7UPftH/RelkS/f5Yqbd4lZ6zx5NG90of/0ICpeNYgHqhZPWs2sIK2s51+9GnNCpD0I
         /+fdFE4Jb9JwQa7Ts/FmsQq8rIv+eGU46s2r0MDyhnEhY3MCKr/mPgJQPim6n+92K9Ts
         tV9RfsaanKwOT1pA2XunaSaj/a2NTUyeoEL2fOnrVJrHufruAPjCB5lLXv74eTNdQpOX
         /F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244936; x=1724849736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMXs6xVmn8sixvLxYUQEmixapt75ZvWc1eWKXQGmuWM=;
        b=Fi229ock66Gqwvcdq0ebO4dCFjwVFkOOOb9tPmER3xNnxH6Pbro6cUiJcVIsNR7zv9
         0SuwEv+1W8QAS92PF//BjbIavNr8dRb2XxJYj5qcOOcuQ9OrjMX7oKH49JnFaNw9F5uf
         fEvL3cHhkXUtxcOKF2hVkOw51FAuXkX6BJb1ykyew7ZaXoEhJ2jUSfDlSGYuq+sa3PFN
         NmTiIFGb4+klYgqph9cnU5S+YNI2pIzYwByygg4DVwn5iU34jF91sJqN2djFBMq2TM5l
         WgGLIc8bZ8+TImyrwbiowxs0Kwjv08oGmSC7mMuJKZDH/nAjXou+QjDWy8xaIvSFzflP
         f7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3AtiBZz1BEFUEO4mzEiROZx+Lx2c4Nc32UB3hoj7fg1InFZ17ofwUzCVkR+fEytGmoCP6hug4CTW1Rcw=@vger.kernel.org, AJvYcCXxpyV8ViiK/KFPJUpFJ2o0oXyKvsp2tgrAHNCdSKMca7lsIzWyqqVxRKjM6juDKXI4WJIqFpcr@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZX/0g+/je2rhR3dcJx9PC5rcNKR8MNWph828WUc9g1VKPNkw
	7+5rUeOg4zZuSbWva80774osaphl/GbQ1FnuL1kNCVi6lG/nCKgB4hrlMWnQOc2L5nVOK5NPEue
	shxshrM9ip1oi96mwyeYyFy+kiU4=
X-Google-Smtp-Source: AGHT+IH3jeFbD6w5kk393jzgQ4ipfByENSz6uo1/HAt4AhKKSb8xj/8nULtdIaYchy0KPYrOkX+rgVzaZzvQnqSWKng=
X-Received: by 2002:a05:6902:2191:b0:e13:c24f:5beb with SMTP id
 3f1490d57ef6-e166642e842mr2116012276.26.1724244935977; Wed, 21 Aug 2024
 05:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-3-dongml2@chinatelecom.cn> <ZsSLB8pJInb7xbEc@shredder.mtl.com>
In-Reply-To: <ZsSLB8pJInb7xbEc@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Aug 2024 20:55:32 +0800
Message-ID: <CADxym3a4gSszZvJea-WikdquvCfVUMbMVsX_C+zdNqc2t=TGJA@mail.gmail.com>
Subject: Re: [PATCH net-next 02/10] net: skb: add SKB_DR_RESET
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:24=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, Aug 15, 2024 at 08:42:54PM +0800, Menglong Dong wrote:
> > For now, the skb drop reason can be SKB_NOT_DROPPED_YET, which makes th=
e
> > kfree_skb_reason call consume_skb.
>
> Maybe I'm missing something, but kfree_skb_reason() only calls
> trace_consume_skb() if reason is SKB_CONSUMED. With SKB_NOT_DROPPED_YET
> you will get a warning.
>

Yeah, I use this macro to avoid such WARNING. And I'm not sure
if we need this patch now :/

> > In some case, we need to make sure that
> > kfree_skb is called, which means the reason can't be SKB_NOT_DROPPED_YE=
T.
> > Introduce SKB_DR_RESET() to reset the reason to NOT_SPECIFIED if it is
> > SKB_NOT_DROPPED_YET.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/net/dropreason-core.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 9707ab54fdd5..8da0129d1ed6 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -445,5 +445,6 @@ enum skb_drop_reason {
> >                   name =3D=3D SKB_NOT_DROPPED_YET)                \
> >                       SKB_DR_SET(name, reason);               \
> >       } while (0)
> > +#define SKB_DR_RESET(name) SKB_DR_OR(name, NOT_SPECIFIED)
> >
> >  #endif
> > --
> > 2.39.2
> >

