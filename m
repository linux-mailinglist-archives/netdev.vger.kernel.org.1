Return-Path: <netdev+bounces-71002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EE85187C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958A81F22447
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA753D0C8;
	Mon, 12 Feb 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIY8e6DP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE743D0BC
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753187; cv=none; b=PnWB6lMDO1kbN4qx7uTXVX5kLNbtIXERnKxGaIRM4ILcwO/9M7gjvxkQ50nfRIUkvyktOKgJAyzOptJLAP9r3HKP6xIp77oHqdG3wHZsTObEOe9SjNxc7/2iLO0YHCc15WdF9Srz1K5sGfgMjicRYmI48vaX8hjQd7njGV0uFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753187; c=relaxed/simple;
	bh=6RiZCefVt2n6bgnlm+EOiDWlwqDJF+Q0MENxRtUIYGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEQjzYBzLvR6ue68nFSN293GvTp+LfXsPIiHcQALo0+04pipO9N1IB7Y6zLcstTbayX7/wgfiEnviLVRv5ibLhzDM9Q+bwiQo2YcqReSZgxlysS6WXWhesELCJSaLazTxFWeNK7me4engLRvp5bqia6Jgb57OIeogu43V+ywYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIY8e6DP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so5022580a12.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707753184; x=1708357984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX+btzn7cDsip3eTseHdN/NGww6dZMDfdwP0hcNtjNY=;
        b=hIY8e6DPXL+9K8Jpuxy8cZQYH4sDrFo/fzJwYkcVNYq29sb2lozeWne7yDHA/lvnw+
         whuporI5MMJ4A6gNdpsrmphHW6jdS2br3nXf/QzNFgztUi91EZvULNoJ0UPsuCkv8bWY
         YByCUYdvRtz9CnDz9H8rXTH6djhW4g0xTV+NhgJVMfCZzM602+c+6U6DJmv0MdrQSY78
         F71R4uPFWhNxigw1WF3OTTKP+IkvufP581RzkpZ5ZpImeGf2pva5cjh0b9ickdaTBjAJ
         SgiqX41oJXCdxZeT+qV0+7HDS52Lf2JafwUvGrhRbR+tVMkMCemsXMpGqZTbWDN5pKWN
         rS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753184; x=1708357984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX+btzn7cDsip3eTseHdN/NGww6dZMDfdwP0hcNtjNY=;
        b=Wa9AkmeesEd9ML6HrHTw6xLclq/0ajo+i6r5ihoFfTRTInqPWot1tyk6FAXPb6L67U
         dKGtd8r8VWZ2yANSBRSow63WF+7ucrlMURHCEeJXZnbeKv1dkXzpfnY6WXHhZJc9+p/a
         PuaTOnEtRWL4T4JEJuVIspB71QrmYdMKA7mQEJyF03o8yqLawdhQGtOvTvj61onD3j+v
         lZSkhK4uRX9+u/SC1zL+kiaV6ckdi5LPJviCIO5E0nvjvl1705AX242ZdjsogG5hhQqT
         vsURKXiVCNxlOVmj+0C9deJ4jw13OMv2brQRAwmXAjboPojhfYs1CH8x1fkm7ERAg9/U
         etfA==
X-Gm-Message-State: AOJu0Yw5EOJv1YH9yzl5dGsuN6q5Ys7O/3QBT2FF/j8bPFVwM+mtIfVW
	+FG71lVodQlfXHuLXty3EHZUwa4FY0kIdrejXPgDTq9HWALNE7TIrc2iaB9IWoPoiCrnXMoNl/C
	LcSDq6RPFCv38WX29f9g0/tLUhWQ=
X-Google-Smtp-Source: AGHT+IETARYpiOpaANCJMWD0+qWbEvLzaCkHMQGzak7LV4VXNa7g/flv1Tjuhk2XWEBiwe+UzZY5pG3BY6tXOe5Bhg4=
X-Received: by 2002:a50:f617:0:b0:561:9652:5637 with SMTP id
 c23-20020a50f617000000b0056196525637mr3527162edn.37.1707753183618; Mon, 12
 Feb 2024 07:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
In-Reply-To: <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 12 Feb 2024 23:52:26 +0800
Message-ID: <CAL+tcoDFGt47_V8R7FkDN8OD-mj8pY41XysoGY7dpddo08WHMw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Mon, Feb 12, 2024 at 11:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Feb 12, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
>
>
> >                         if (!acceptable)
> > -                               return 1;
> > +                               /* This reason isn't clear. We can refi=
ne it in the future */
> > +                               return SKB_DROP_REASON_TCP_CONNREQNOTAC=
CEPTABLE;
>
> tcp_conn_request() might return 0 when a syncookie has been generated.
>
> Technically speaking, the incoming SYN was not dropped :)
>
> I think you need to have a patch to change tcp_conn_request() and its
> friends to return a 'refined' drop_reason
> to avoid future questions / patches.

Thanks for your advice.

Sure. That's on my to-do list since Kuniyuki pointed out[1] this
before. I will get it started as soon as the current two patchsets are
reviewed. For now, I think, what I wrote doesn't change the old
behaviour, right ?

[1]: https://lore.kernel.org/netdev/20240209091454.32323-1-kuniyu@amazon.co=
m/

Thanks,
Jason

