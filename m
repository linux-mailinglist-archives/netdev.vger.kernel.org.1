Return-Path: <netdev+bounces-131534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B41A98EC8B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEA11F236B9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683D149DFF;
	Thu,  3 Oct 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+nkZU02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7201494A3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949184; cv=none; b=LKAY1SUguhjRQSTgwt5mgOAFvdDPlzYtai+8zozVhUAdMkgvYgj0YYr/V4F+zuLd7sTZhi012TOdhvTIogQV6Lf6FaOY0JDE1vK7kKuZ3aHljEGiyXrd+DwnXoGHsNcTpttesOmIdUscXOSCuN7fzReVSt0rt5gxuABECNuVQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949184; c=relaxed/simple;
	bh=/Sk3U6pyBtyz+hrt6dasUawv1k8RpidN6fHcgtfd378=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clA6/49NuZ4yYrhB99FBmMW6wwmLbzq/oZR9SlWVItrKRuNpJYaeiVGlT0jDa5uTWTsVJe5DY4jW6FHVZHKzRSfFjPKvk1mVqwQH4tlV3xVsjSzb05BPpGfSbbldEbTt1cfirfkvAYmUdrcHTpi9X8i60IeHxeoAH+86cSmyFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+nkZU02; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so1035227a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727949181; x=1728553981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuNENCOcoM4O+VORTRJUkG56ComF2bgwmNHY8Je039o=;
        b=y+nkZU024y7DC26Y3eQHNKGmVXTzDDnzVSCSWiJp1aQrfJEw/N+mKnkPiNacVv3u4h
         7PnLbJPl+qZT5ab2XWCDMSzkfHaSPjXzULfemVUV2eU7yFfu8rL7DMOXXfecD5Eoa/u4
         VUQuPuQt4toGZrExtmKyywaJPFMtEcF5mT/LO/QhvNjzc9hmX3Tm1yxfzNdUDhRsCbyS
         G6ZCNIzkppah2Pc80n8838ETh63T45Hz5Da4FsVyOUdwGT/H+yrcIYcV5udyQrhLB7CW
         m7DYKYqAltSoCJgYEecDwHvFNIG15W65OHqkrp3hFgQrVTTruBKgDSi8+WohkrMxC8fj
         xoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949181; x=1728553981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuNENCOcoM4O+VORTRJUkG56ComF2bgwmNHY8Je039o=;
        b=URigsXoJ6iTdVL/Guyn6W72NpwQrIYX4IIb6voa1Kf+i/w2HgTtY98yG5R8YaLWP7f
         CRWHEr/3orL2bwMwiihDwJFGg+yl2Myql3R8NlMZVFoBoyx8Ds66Ju8s1tpcfzWJzJOR
         weBu9hiDkijJE7xvD6QFTcxCmRZt4g5mJsbzdy/p/pi59pZnZi+YrZSEtEpkabnoOGbe
         n2yS8ul15nLrwYnSzI9rGVwT+w0uIBbmeFh9l2Sr/leDCctCU04XBDj3q1LCrMazmINh
         BYybMeyLHPZ/Et+eBGkuvdL7HlM5SgBdUAKdHYjLn2XeErVefc/D86RsHSaSVq8qyJ05
         T6aw==
X-Forwarded-Encrypted: i=1; AJvYcCUNGSf0mGcfC+OcUczS/TWiu/1pQpVFplWxTx08TNVyWwFMgWK+FwL49wNLRCkqTLlHgTaq5Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZR/rf5ShDnzaMIDldH9HdZWWhs+Q/DhcRV+lK9LY51xEm0JGR
	/wBUAkAW7WJBdTrBT91gqON25G3yZXPl0qBPoE3WHYk+2mE7IjX2EhvDIZKl5IiWr/pwFDWaR52
	0CErbL0AagVuq/tevbR09VvYDJjkG4UZT5wA/Bd/GOq2yZOPIlQ==
X-Google-Smtp-Source: AGHT+IEJ6RhtVvY/jkQPzlilhUoy/TSaqms4s9aSOqjDfMF2DuOmcvSVZZTgDIX+G508omfXxSKyYJRLNDoVwFM3OGE=
X-Received: by 2002:a05:6402:40cb:b0:5c8:77a5:d480 with SMTP id
 4fb4d7f45d1cf-5c8b18ad3aamr5315469a12.1.1727949181254; Thu, 03 Oct 2024
 02:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002151220.349571-1-edumazet@google.com> <20241002151220.349571-2-edumazet@google.com>
 <20241002174130.5e976cad@kernel.org>
In-Reply-To: <20241002174130.5e976cad@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Oct 2024 11:52:46 +0200
Message-ID: <CANn89iKQ2M3ZPn2gYQ+aTr8NeGZcXC6AMO=vH7ubDReOVV4pWw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON
 device attribute
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 2:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Oct 2024 15:12:18 +0000 Eric Dumazet wrote:
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.=
h
> > index 6dc258993b177093a77317ee5f2deab97fb04674..506ba9c80e83a5039f003c9=
def8b4fce41f43847 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -377,6 +377,7 @@ enum {
> >       IFLA_GSO_IPV4_MAX_SIZE,
> >       IFLA_GRO_IPV4_MAX_SIZE,
> >       IFLA_DPLL_PIN,
> > +     IFLA_MAX_PACING_OFFLOAD_HORIZON,
> >       __IFLA_MAX
> >  };
>
> Sorry for not catching this earlier, looks like CI is upset that
> we didn't add this to the YAML. Please squash or LMK if you prefer
> for me to follow up:
>
> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/net=
link/specs/rt_link.yaml
> index 0c4d5d40cae9..d7131a1afadf 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -1137,6 +1137,10 @@ protonum: 0
>          name: dpll-pin
>          type: nest
>          nested-attributes: link-dpll-pin-attrs
> +      -
> +        name: max-pacing-offload-horizon
> +        type: uint
> +        doc: EDT offload horizon supported by the device (in nsec).
>    -
>      name: af-spec-attrs
>      attributes:

Sure thing, I will squash this in v3, thanks !

