Return-Path: <netdev+bounces-127961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C29773B0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70D0B22F5C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E61C174C;
	Thu, 12 Sep 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vfs2330D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147319259A
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177147; cv=none; b=NNtz1uQIC+W3hiZTAgzumQjAy5CyUVla0FGp2wc0jTxmgCXKX6+45tP1zHSg33RGpRDWNlYypYP0iQhd4O8+NL6MsDgV1vrSodCr/4NdreVTvhrXLpgdoOVydOWkvZnbFFQqDB82DGYczFFk+BMMIRwUZdnikgE5blX2G7/SFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177147; c=relaxed/simple;
	bh=4Z3y2ExjN+sfTTdyRG0DobCkSSROnQTal3/BbxZMT9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmIksZnFXA10Qlk+o/b8cu76oC5IVCfngafQ3gMd/9XvjBMPkKyW4lKxLM06JAC4QgoowK+AQrWRAAOnu6BfuocxFPaBjckZLLE7nCbsZByoToFS3+2sRsmlGVvHKVgd+mEk3fBhOWYXYO610b/kqYjLEvDBLKTgwXKWcuUTJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vfs2330D; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49bd221ef66so515054137.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726177145; x=1726781945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnUGUKViCW+3BbsFSQi1k9zreDMxoTLJCm+OUAY9KGo=;
        b=Vfs2330DNJLq5xxxuyFZxGs3WNFutnpK40tzMZWQmWVEW3SlXjEoNQY+83ncFFP8AL
         VtPIKa5W+jTlDZivm4/B01taHcY1psLA7U2zgECcxQlqDyODTD2Nt0N1JweEyDnfXeyu
         Du1prOVsF2+tpJevfSU3nXj9tJwO98i2Er+9mqXFNCieK2TWFB3kc4u3eMsbeBXdaafw
         nrrgVayxzf9c7Srfzdb4WX1FViw7Ic1a3lJPvui3PxtnOPi8nh5fkddMtCpAvMhFveTC
         RAqsXdPu7Tv5vkjxBWH9t7VRAiKw4d/PMuWi0+/2ylsNun4Ig8+7dadL7FmDKJ80Q1tE
         bDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177145; x=1726781945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnUGUKViCW+3BbsFSQi1k9zreDMxoTLJCm+OUAY9KGo=;
        b=rWigbIzPLdhbuKzP4WWiYa3Hm+YSVgBeCGYjb+7Oa209ZmG8hlIZCXqbkrM6vVNARc
         jB5tftc30gtcprtJhxw3uFs2MbpMw5OTzzsvxIS88bRcCJDET9dtvNSpl/HQElGGUZwT
         KzAde9b7fknZqt0rmVUJUKRvXdvjkjCGrBcxUHJMESXPrAeP6Pa0izd6aVUVw/s+dTbn
         PT5enBfpp867JP+udBwVW8pHAgViAdyJeFdfpModCFIBFbKaCQ7Sj2N9bMCdenxhNcz2
         lRqNJN7r68z+K3VaT/ATrPHJeXbqTNwOGRAKjuBKlu10A0LqaqOub8C7l/Z9N9fAsiNl
         PDsg==
X-Forwarded-Encrypted: i=1; AJvYcCW6TGwDvEJtQvLr1a+ihRuXmqQy6ttxl21MmbmuAQbqlg1E1I1q7yI7dlyIh6nwWrsXUKGV6FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9bTeGAMfmsPlR5ekOrFsrB8vPupxXOQ/c7QzIenSPkHug96q
	7szy6MmyxLnPahRVXq5ST/izwAZe5zb3ysqIykkQnbExtbhbXdeleiuhwwih5r4FbMFf+dykvC9
	1qfpMkm6VYf3+xzYhAfmKQ3V+sMqqVporFOpF
X-Google-Smtp-Source: AGHT+IE9lzQsVM3OtKM1DDO5bp6YhBv9ztTqMYR0Z4axeHZ0pxVhuPDcMiTJqM5GQZoQwIGD5+xxoKWGH0xp0FCEwsY=
X-Received: by 2002:a05:6102:3750:b0:494:3a01:e340 with SMTP id
 ada2fe7eead31-49d4147e662mr4516160137.6.1726177144959; Thu, 12 Sep 2024
 14:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912110119.2025503-1-suhui@nfschina.com>
In-Reply-To: <20240912110119.2025503-1-suhui@nfschina.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 14:38:53 -0700
Message-ID: <CAFhGd8ruRrZM0Q2Z0UJdf98gKvtP64H2k08gvB_=97pWs4p8cA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tipc: avoid possible garbage value
To: Su Hui <suhui@nfschina.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, tuong.t.lien@dektech.com.au, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2024 at 4:01=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> Clang static checker (scan-build) warning:
> net/tipc/bcast.c:305:4:
> The expression is an uninitialized value. The computed value will also
> be garbage [core.uninitialized.Assign]
>   305 |                         (*cong_link_cnt)++;
>       |                         ^~~~~~~~~~~~~~~~~~
>
> tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
> is uninitialized. Although it won't really cause a problem, it's better
> to fix it.

Agreed.

Reviewed-by: Justin Stitt <justinstitt@google.com>
>
> Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing"=
)
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  net/tipc/bcast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
> index 593846d25214..a3699be6a634 100644
> --- a/net/tipc/bcast.c
> +++ b/net/tipc/bcast.c
> @@ -321,7 +321,7 @@ static int tipc_mcast_send_sync(struct net *net, stru=
ct sk_buff *skb,
>         struct tipc_msg *hdr, *_hdr;
>         struct sk_buff_head tmpq;
>         struct sk_buff *_skb;
> -       u16 cong_link_cnt;
> +       u16 cong_link_cnt =3D 0;
>         int rc =3D 0;
>
>         /* Is a cluster supporting with new capabilities ? */
> --
> 2.30.2
>

Thanks
Justin

