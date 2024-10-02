Return-Path: <netdev+bounces-131242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BE98D976
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CD3B24BB3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE241D12FF;
	Wed,  2 Oct 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/kySAcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EC1D07BA
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878013; cv=none; b=SYFV0SD3Klh9f8ZV8F4sa5/9kVKCHbgbUWZ6PAda7qV18B0VLp4IKVE7HHpW1o0liYIfHJCgilX3EHeFhK9CjDGGpVOKDXZXbj21t8+jwtsB9T6rd8V8l0om3+2FgUPdjMUDFfTIsXkwvOQRe5FoDSfpu0QNyMQMic8/mevbg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878013; c=relaxed/simple;
	bh=Fh6rKC3S3btJcAWcrNdS0E6/fXhESc85nRi7rge6CEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndmHi+3USucZJD4/LOyiaC0ZV9wFSK0X44+nRonENPkrrnBNAP4fp1Cbn4/m+rFIfbrOJ2vyyil8RIgM+ZSjpi6SLDrHED/aShjsXfivNua3IgrN68yy9ZI7XTHImMIjvvZgRP8o481quGkUpt4Kw9Emtp81zcws8Cn4E7CEruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/kySAcV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c88e6926e5so4441965a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727878010; x=1728482810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycWKe7ZnPME1606lWNA1NG3LqqUtV88DDy2wuflUiFQ=;
        b=o/kySAcVMyjkbhl6kclx1PctU61FU2K0dTLvUaAwkkseImXzGiEIludZKEp2SW07A3
         Z+elTeIjH17F+zy5VB1lrWQjfTB50x1EwvU75cebtB23DCrMYL2ftaEt7dzOCHV9YCYP
         7GIB0SUJNCdoSHHTtivn41H+btQJIdN7cSSjypi35Pr58iLtqoWO0+HCtvBmgEA6pkrp
         GDd+823e31ha9wiu5hRsJopWmcIkoJx95g3bDHujZI7fYkJSdDvEDMyyO3LZVCpN41Jb
         NJ7YxqHZEjzxOtgb9MfNbAT2QxeyltoKD2A4YuY4oDlREUYHRQT7wYmnz6uiyvyPiMDY
         nbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878010; x=1728482810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycWKe7ZnPME1606lWNA1NG3LqqUtV88DDy2wuflUiFQ=;
        b=d/6bS3i4GmJ3rqFbLQrN0IKUglDxDr7VJJQXGc2Xv91YM5+PC1L1FoKnEtN/vZ4qke
         vl6XW5ofnBwBJpX4sbOlLKpapBF/kI9zSTHYjy7mjXDwVSLjJgqCVx8rL1dO7LrCRoy9
         5VEo3A0wV0/Ako+9Kh/H/uerixxjbD93dMTCOylIbnbhW8sJXyGs4nIguFhIa67/IqV4
         7m7CxtfmdM1oYbQJAPfgwDZbIQzcORoWxF3hBl6dKYITcghBOZjZQFO+wkWIFizzmmFe
         choPpjBhuBVP+AwP0UjyhuFCECe+QunqYpfsdqQIkPyaSAsN09RDrKb8mIihzosBIFW+
         6JLg==
X-Forwarded-Encrypted: i=1; AJvYcCWHgk2OhD5F/klknMrICK/A4mz7HARvqR9CKxkP86UALL6yAvSjfrI9y2kv3tafgvTZSM1Ke9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFTvLa6Yh3U0lD78m0TFYVNWhBXniE9YO28SVK1CwuHkizx1O
	On4f8vfkXl5XRCsWMn046rqC9/UmkaKdx5Dl8HTDWl1Y0O375VJ5w/ULlkIqPJ0jt8iqWmvLh0M
	Mdm8E2kp0Wc4nuy49IfG8p7WlqFfVpD+XAzFu
X-Google-Smtp-Source: AGHT+IFEpvKEGYAZ5zRXiOzP+idu3sFTlx+kdgSbMC+V3cvGdTVsi51sV4cHBuhSaRQNpTiLm9IKWBTZsSMnaLD5hOY=
X-Received: by 2002:a05:6402:4409:b0:5c2:8249:b2d3 with SMTP id
 4fb4d7f45d1cf-5c8b1b702abmr2672361a12.26.1727878009795; Wed, 02 Oct 2024
 07:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930152304.472767-1-edumazet@google.com> <20240930152304.472767-2-edumazet@google.com>
 <20241002064735.5b1127ab@kernel.org>
In-Reply-To: <20241002064735.5b1127ab@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 16:06:36 +0200
Message-ID: <CANn89iLzR5PY+7s9r_wFTNfS73jYsLvqj=vaT5jYvbRcxCve7g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON
 device attribute
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 30 Sep 2024 15:23:03 +0000 Eric Dumazet wrote:
> > @@ -1867,6 +1868,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> >                       READ_ONCE(dev->tso_max_size)) ||
> >           nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
> >                       READ_ONCE(dev->tso_max_segs)) ||
> > +         nla_put_u64_64bit(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
> > +                           READ_ONCE(dev->max_pacing_offload_horizon),
> > +                           IFLA_PAD) ||
>
> nla_put_uint() ?

Yes, I can do this. Some backports hassles for us with older kernels.

>
> >  #ifdef CONFIG_RPS
> >           nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
> >                       READ_ONCE(dev->num_rx_queues)) ||
> > @@ -2030,6 +2034,7 @@ static const struct nla_policy ifla_policy[IFLA_M=
AX+1] =3D {
> >       [IFLA_ALLMULTI]         =3D { .type =3D NLA_REJECT },
> >       [IFLA_GSO_IPV4_MAX_SIZE]        =3D { .type =3D NLA_U32 },
> >       [IFLA_GRO_IPV4_MAX_SIZE]        =3D { .type =3D NLA_U32 },
> > +     [IFLA_MAX_PACING_OFFLOAD_HORIZON]=3D { .type =3D NLA_REJECT },
>
> Let's do this instead ?
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index f0a520987085..a68de5c15b46 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1975,6 +1975,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  }
>
>  static const struct nla_policy ifla_policy[IFLA_MAX+1] =3D {
> +       [IFLA_UNSPEC]           =3D { .strict_start_type =3D IFLA_DPLL_PI=
N },
>         [IFLA_IFNAME]           =3D { .type =3D NLA_STRING, .len =3D IFNA=
MSIZ-1 },
>         [IFLA_ADDRESS]          =3D { .type =3D NLA_BINARY, .len =3D MAX_=
ADDR_LEN },
>         [IFLA_BROADCAST]        =3D { .type =3D NLA_BINARY, .len =3D MAX_=
ADDR_LEN },

+2

Thanks.

