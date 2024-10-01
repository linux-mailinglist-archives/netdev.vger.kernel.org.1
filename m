Return-Path: <netdev+bounces-131090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC7898C98D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCE1C21DBD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308181D4336;
	Tue,  1 Oct 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiktXhOL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D9154C1E;
	Tue,  1 Oct 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826020; cv=none; b=a4Z4BrYT6/Vlzuv9Qv6umvq2sKwkz9WWKPl8yA9C6Rnv1UhekhCxkO+CelofMuiK2L9vgDQVQu/9u11M/sl1HQwEac1h/ckfw03f+bs123irLrKkHVST02NscpAaWMr5SVRXKVxKkJwlSzJavBpJeUJUil0W+clVjx5UvtFsgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826020; c=relaxed/simple;
	bh=oc4kNUZ++rknNxqXtF0a2vDuKMODdIXTpIm9ZcHkuzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLcYKMZ47tTiv4kmEbpEEpchmTqF0xqHYn4CfylhTQkadIZ8UwgDl6Z+x8fkLF5bJaUHWNOmnIZDmvtNw7MIGJjX3bsaxtNrBQ+4Jx+vDStWgex1e/BWq7GL5qZjuPq9eA1F/AfrSkJ0wb76c1C9iPCfo7S/SAv+iSxPTn7Jf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiktXhOL; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6c3f1939d12so50404457b3.2;
        Tue, 01 Oct 2024 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727826017; x=1728430817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0X80NBZlHnDD0IDxB7pOrLRtZHi6Jy8U5IUp10MYLg=;
        b=WiktXhOL+RIAzGN06WlLPgZKS4CPlqLOMXMw42JN/tCbNdGd/dOPjq027aELrYbyeQ
         wcM7C04qbiLoShNZ0+kU8oRMdkauyBcwKjoYg+aFuIQNw0Zn6O8ZGN7eOrF6OO3eNI44
         R1G4008CVk/8Rt7PzGe5t7QCugec0m8WWleFft2Zl0n91D8MlPfyP5eNC8znRAs7A//3
         KpwlRn/OWsl6mOmC3inFVTBEGfitggLv0r6T0eg5rKjRSrt1Y304FMrW1xjoOlJPr0K3
         l76EEinikTE1rJaa4oZciI1AQLEu/9WIBolyV1NE7DTM1tMmJO3qt6nxdVO1uDtDaaMN
         Ra/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826017; x=1728430817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0X80NBZlHnDD0IDxB7pOrLRtZHi6Jy8U5IUp10MYLg=;
        b=AHUdoFrX9x4TOP+BNzrd7BAZda+BzXvrlLzDB5ScFZAH4Ykd4WiJsuub2e8Urxd3CY
         vKGtMeBOzvmnD5X8GELparE4smK4QQelxWJ5BbsywSftMXzYpAEc6kQNBqsGXQspNuL1
         evsvcwF5d1iMB7cpmEh7vH0iBVvPo+vajjZMe2fAhXTvX6k88fBMUh7P+N32ht1PugeE
         DLpSvNE4hoc65shDgfQ/Ws4hBO3AX/zG473QE3OBDzXqjQsD9BpYHrGPYzzlZPRIZikT
         3OkpiBTWlppDXL8A//9DQZ93h1NymPb9j307Ezj3OE0mijuuLKWH5qovV8hYvWW8AEc5
         08pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU61rDtnGT99IU2Uoe2hjHU3kRrD8l9TaYL3wHQZ4d9Iiw+lGu1eeeo86BDE+MOSI+KOXTjDZ1PifH2ciA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlHOlmhpH2W+x7antIx/YBJ3LKcD/njqDBJfss/A0kdpMIqNS
	+IlsO3QlO3BpfYSINHn/nvF7PKXQW3hUkjNfAjGDvRX/wfnlob743fQR30r/m9nINeMZl8etLTL
	utySulwNtLRDpg014fjVxm9VCkyA=
X-Google-Smtp-Source: AGHT+IF5e2/JC22BacACIpQzksx5oEpq4czIcpQOl4BwBE//2qAxlW1B3NyBMtKwH+aIZjvN4MWUCiM8lJynFGSn05c=
X-Received: by 2002:a05:690c:6d92:b0:6af:fd49:67e0 with SMTP id
 00721157ae682-6e2a2e336c2mr14355587b3.46.1727826017587; Tue, 01 Oct 2024
 16:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001184607.193461-1-rosenp@gmail.com> <20241001184607.193461-2-rosenp@gmail.com>
 <975e614a-f37a-4745-90a2-336266b21310@lunn.ch>
In-Reply-To: <975e614a-f37a-4745-90a2-336266b21310@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 1 Oct 2024 16:39:52 -0700
Message-ID: <CAKxU2N-b2SsORrMbXnf-ezqR2TG+pyuMtEx5+wdX7z07oA8iqQ@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 01/10] net: lantiq_etop: use netif_receive_skb_list
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, olek2@wp.pl, 
	shannon.nelson@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:40=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 01, 2024 at 11:45:58AM -0700, Rosen Penev wrote:
> > Improves cache efficiency by batching rx skb processing. Small
> > performance improvement on RX.
>
> Benchmark numbers would be good.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > ---
> >  drivers/net/ethernet/lantiq_etop.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/=
lantiq_etop.c
> > index 3c289bfe0a09..94b37c12f3f7 100644
> > --- a/drivers/net/ethernet/lantiq_etop.c
> > +++ b/drivers/net/ethernet/lantiq_etop.c
> > @@ -122,8 +122,7 @@ ltq_etop_alloc_skb(struct ltq_etop_chan *ch)
> >       return 0;
> >  }
> >
> > -static void
> > -ltq_etop_hw_receive(struct ltq_etop_chan *ch)
> > +static void ltq_etop_hw_receive(struct ltq_etop_chan *ch, struct list_=
head *lh)
>
> Please don't put the return type on the same line. If you look at this
> driver, it is the coding style to always have it on a separate
> line. You broken the coding style.
I'm using git clang-format HEAD~1 on my commits. Something to improve I gue=
ss.
>
>
>     Andrew
>
> ---
> pw-bot: cr
>

