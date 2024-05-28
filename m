Return-Path: <netdev+bounces-98534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC268D1B07
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9961F2198A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3316D339;
	Tue, 28 May 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+XluGIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AE16D312
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898956; cv=none; b=usjMz9NKta0PKUZ2KKZcIpOpoeqbp7pVbR5tY688H7dGymetKBcXDtBZqjdx0Rf+NX4ENpeULT2ulercwbRGUOcgQRn9RmPnTTXXx3G6NWNFQn2c12wrhblSpRomCEMyy+CX3N43Vy8bVNcxL4Yf1iS8sPmwsRe9Zsm3m0DSRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898956; c=relaxed/simple;
	bh=KV6XpCQHbohETVAnE3VjdWEmGWB3TWOcp6uyiJ/bZnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8URyWP7OGYZ0rF7bG7s7s8Su1lhKcigpdG3ibQ+Sa3IMMtRjXQSxhOWnvZpM+omhb+BklmZTNeT+pFqERC/o0fh9jzVl2BnGRv+xf0xzkuLXR6QEnM9/IyhGaGCzJuA3nOiB/geVD8rulUhNGRg1iRtRhgaZjcJsQAfaJFNEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+XluGIG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57863da0ac8so25612a12.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716898954; x=1717503754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV6XpCQHbohETVAnE3VjdWEmGWB3TWOcp6uyiJ/bZnk=;
        b=P+XluGIGPVaMeMhqrbf3Ki7XsxLqVGDYNdZRly8JoWtPQ8ftnLlrUdvPf2helKCec7
         /ft8jPBX1W5+4aKM4PZVLTmi6kKk1q+oIp6Kl81u3T0M8UfcqrDNtVyUDJwgI1fkgR3g
         J6yIBKSYQongZsA+S5bZfG6O4HlIjHvbakJ5P65IebsbypxMfnOaEjMvATLdMbcEQHoD
         GFUweKSCs2XPElPXbz8D1harsvB+qXFn3FHNqNyYk9m470g5lxUW7d+XCAsoNAsx/xYB
         gqhUNFV5pR/Ge45XJuK2pjj5yYPvoDP+0oyQvQ4y8XUttNtThDEvErZ8bHZYVaSWh6Yh
         vxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898954; x=1717503754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV6XpCQHbohETVAnE3VjdWEmGWB3TWOcp6uyiJ/bZnk=;
        b=XBMKGD5jn+k32Wb8Igy4bDuMI6aFeq+ggNFYaLeSRKQ68DDAOEbf8OsCHuMtuVvtB2
         KBO8J1G2zNByg6EUCwcxpJOe34OMlXA/wCSRBTLTzrsfrocIUprfDwR7o+olTDNGYi5y
         tcv7fC28FSx5JqgoDGKvsU23IVHIUJ5FNMoXVK791D0y8GtWQtVt/WYRO0TQ2yq9I/Uu
         3VLZsVx0Mq2j9/gze7jNk0M4Fpunvtxr6YTwYMEZrheukmip3m7brvZ2S7l86cJOW1SD
         40Hbm87xyj05B4AXSjN0WwOTHABNkACWUJak6iPT+jHbNLVSnFTRqGQfqB0Pi42nmon9
         42xw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/4dYFR3o4bWVJQPUq5pOOs2xKi7XYu68jd56JWl2V07E+9eadsVOCoIfzmRBZeYadG5prIyawM4hFHwGcdV5aCBgpeXb
X-Gm-Message-State: AOJu0Yx0ZChcwf0l613itUUQ7Lpwfc8vbx6BDloOEKd3AIkmt9Nw+wph
	om6BmPDuPrAKE2okSzcsVKGoh9xPOyW9gomdjHok9Gw6qOMY0PC6f/HSKThD12OyFDsmPKrn1ja
	teerkpUTrs31LstMw49OauKTpeRrHlqjYEmmR
X-Google-Smtp-Source: AGHT+IH1Gtm5F59Lm5I2SXsUJhjdETo+vxRbDjTlwIUhJpsam6VH9uP+WsbKqG+qCOz/gk2BSvwxdv7mmrEx1YLvFns=
X-Received: by 2002:a05:6402:1803:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-57869bd661cmr341506a12.7.1716898953322; Tue, 28 May 2024
 05:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
 <CANn89i+ZMf8-9989owQSmk_LM7BJavdg7eApJ1nTG6pGwvLFHA@mail.gmail.com>
 <cace7de5c60b1bc963326524b986c720369b0f1d.camel@redhat.com>
 <CANn89iK=oYdC=ezujf+QOWsbVEXDx1vLLV4Cbd8bJH+oU+RDiw@mail.gmail.com> <4f0819a7032c52349bba22ea767eda103be650c1.camel@redhat.com>
In-Reply-To: <4f0819a7032c52349bba22ea767eda103be650c1.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 May 2024 14:22:19 +0200
Message-ID: <CANn89iLKJ=-Ng6fUgr1LW+5+Y=kEsY2VM0VUgLMP-NicyCdAcA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 1:50=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2024-05-28 at 13:31 +0200, Eric Dumazet wrote:
> > On Tue, May 28, 2024 at 12:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >
> > >
> > > Waiting for Neal's ack.
> > >
> > > FTR I think the new helper introduction is worthy even just for the
> > > consistency it brings.
> > >
> > > IIRC there is some extra complexity in the MPTCP code to handle
> > > correctly receiving the sk_error_report sk_state_change cb pair in bo=
th
> > > possible orders.
> >
> > Would you prefer me to base the series on net-next then ?
>
> Now that you make me thing about it, net-next will be preferable to
> handle possible mptcp follow-up (if any). And the addressed issue
> itself are so old it should not make difference in practice, right?
>
> So if it's not a problem for you move the patches on a different tree,
> net-next would be good option, thanks!

Sure, these are minor changes I think, only nice to have.

