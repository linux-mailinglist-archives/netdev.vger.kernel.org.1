Return-Path: <netdev+bounces-124041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E1967672
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50221F21A8C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C115FD13;
	Sun,  1 Sep 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccyg+JlG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8F14C584;
	Sun,  1 Sep 2024 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194088; cv=none; b=gDy0gZqkyRq0xsHAnn/Z/9R3kYXLWCSpUot3cY4eMje/Z65asTXA/gqMaJ6UFugYzr0PN30zhma+B5lhfaunZtJcsQujR4pe/bysm4IU4ehy3Dm9wo2WCtLWMzlilURcLZHYpHa+Y1IVHUMR1WZrZI+GEARwpjpwBZAy6yzX6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194088; c=relaxed/simple;
	bh=Mfrkqy8nCR4qBcPv26bU+4nMRhGQNDrjwdhSky4WDHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnmBeiG3dOUe7fetGs9OlinIF2+7fih843lwguRe2o3j2FfyvGvIafZMBL/vs+3xi/4SFKAGO9QR3o71uMt8MXzSOtDarfYysjVwX+uHPXJVQ9G+zsWEEvFiaqz7SFOvq/lBP3t6kVO7X2669h3zJFEjBO/Wx2LFU3DfvGCwXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccyg+JlG; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e13cda45037so3362102276.3;
        Sun, 01 Sep 2024 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725194085; x=1725798885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL5B4n70vsKEIT0EtRxJjamgVdGMw0i6gTWws9MRdIM=;
        b=ccyg+JlG6yFrw53jqIZO3uhPaAuYUyvKClh9Pchl1AhSTaJu/ui14Ne2ZxfIvt73Hq
         NKEY0TbfAulGagNh6q+p1ej2RLeKgnm1qiqaQHxjUy+SRVImOfqwyVZ3caHfvM5QJndg
         IxAwsqQxGL1+UmHxd6KHAWTxJPe7JexT1Vh8XFJ99AKdb/bdq3lOgSgUMwYfOT7zFbyw
         ZMHmPXIP0KN8+mkrRxU9bE3z2kdfpcH5SsFc3NetpV63/d9dq9/ELIrMYVXmR6NWAmxC
         1fWjoioUBIudbIm6hEgnshP+M2CmMZk4HvKm8AWfAfM/G3ZElYJ8nfXJK1ozRF9tPJqk
         Uaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194085; x=1725798885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL5B4n70vsKEIT0EtRxJjamgVdGMw0i6gTWws9MRdIM=;
        b=JK5z/0CXaQLtWrYablC/v1dBFbXs0OElaDAtQMWjUiOux+QGwM0ULueOqvj9VtYLkk
         K27GTZ39XOnDBcI0AOj0HrMOozpA7m/vwMZntUyr9IrRaUX2+WYQ+fmHsWFsVFXgsxaZ
         YHd6VMeWvvokpmYG07UGjNLo+fE4kOTa4zSaR7DUWCOf19YjYKHqgbxpMqU1D+fwpTXr
         VY8/vtpyNz//GvE0YVIcIr05xm1XX18PGf6lFolP0kuUYGuP6qwY3r9dIFE+PLUCMizn
         hbL6aGbHaF7f1UlIpSYdDNFHdW79g+zoqhKWakjLDBlr9jx2ZruWpC+VGMpkDNmN7G+n
         uG/A==
X-Forwarded-Encrypted: i=1; AJvYcCUH3vorYvyM4DkkK7QD7myVJkz8KCLQx/ygqzhkKhhHGBlKLLL8R4HIVlNsi30U6oNJp2LNcdgP@vger.kernel.org, AJvYcCVu49+czEV5tT32uRt/7yBXWuq9FfdEEO4rKSb902iFOD2YdPOKMICoxm2ZqwsR0ZmVvOBISgorW9EGjrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdKDBa+SJwM/icr8U/zzu8f6dmoJj8PHQ6u99anlRgVaFEK5n
	eintiwZv5sg9I/GAwUCljFptqa8iXgiby8Ftzuo9JTkxC5KpfPKqVUi0iEATi41vVHtJ1+cGr+0
	LIZfkEf+Thv2+GaWmRRk7PgbClsN/X1N6
X-Google-Smtp-Source: AGHT+IEsB79xkVB75828P00nBGMf82NCH6tIaMrt6kz+MB7Gse3G9Bj8wOFcSN7Z7LparZwxWOMa3eb0GD4G43JZGEQ=
X-Received: by 2002:a05:6902:230b:b0:e0b:43a0:3ce with SMTP id
 3f1490d57ef6-e1a7a1a8b85mr7604996276.57.1725194085217; Sun, 01 Sep 2024
 05:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-3-dongml2@chinatelecom.cn> <06ff49c5-10b0-42dd-946c-388f5cc3a1e1@intel.com>
In-Reply-To: <06ff49c5-10b0-42dd-946c-388f5cc3a1e1@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 20:34:46 +0800
Message-ID: <CADxym3Y7GVQzqXqiHV9JEWPOrSad0c1aggctfcT1WX+cic3Mmw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net: skb: add pskb_network_may_pull_reason()
 helper
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:45=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Fri, 30 Aug 2024 09:59:51 +0800
>
> > Introduce the function pskb_network_may_pull_reason() and make
> > pskb_network_may_pull() a simple inline call to it. The drop reasons of
> > it just come from pskb_may_pull_reason.
>
> No object code changes I guess? Have you checked it via
> scripts/bloat-o-meter?
>

Not yet. I'll have a try on it.

> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/skbuff.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index cf8f6ce06742..fe6f97b550fc 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3114,9 +3114,15 @@ static inline int skb_inner_network_offset(const=
 struct sk_buff *skb)
> >       return skb_inner_network_header(skb) - skb->data;
> >  }
> >
> > +static inline enum skb_drop_reason
> > +pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
> > +{
> > +     return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
> > +}
> > +
> >  static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned =
int len)
> >  {
> > -     return pskb_may_pull(skb, skb_network_offset(skb) + len);
> > +     return pskb_network_may_pull_reason(skb, len) =3D=3D SKB_NOT_DROP=
PED_YET;
> >  }
> >
> >  /*
>
> Thanks,
> Olek

