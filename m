Return-Path: <netdev+bounces-243039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF43C98AEF
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92C43A4503
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C9D336ED8;
	Mon,  1 Dec 2025 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7CoOFSm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C51DEFF5
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613013; cv=none; b=dH4uQzFZPCjw8G6WkWeW9W3g3o7nMzKWxH15EwQlNFTM8+Zhq44dkZkNauA8HBqvZ/O1SQVIkJRnqPigbRBxRq+bTnwaLnGOJKkr17UFs8ZnAGRUCXwe9Ti5Zm/F4KRu2yZIHmXfb36nd2c16xto2TOhviuQkFXer+202xeC38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613013; c=relaxed/simple;
	bh=zN2y/z/FLR101s1pU+CdIArxbLoEEx4SEWyMarOA4iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onsTCcyseQY+AOm2r+pbTxFaucNgiKVHfF1eyUQ2blXXaObMB4lbSXKD27WPEO1Pl/mdR8L/cJO8egZHymqhlFIkctswygSaiSWOqAT5hGWgcch4idHVZBDvf45CE2UVVlqCnHT3Ow6yp0ARgYUo7sCjNFiDDYwCnRiucf8oKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7CoOFSm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2e5da5fcso1208080f8f.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764613010; x=1765217810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN2y/z/FLR101s1pU+CdIArxbLoEEx4SEWyMarOA4iE=;
        b=a7CoOFSmUrb5leNpUEfLPaQYxp0ei+mZNF2sBdwLVe11dV9gtqHEjJLIEa5zip0Abw
         xVcqmbl0o+U0XzLsnTxnV+eBwJT9PnTcI89vXvEhkjfRgPyCSeojG+O3WLOFQQmeoYJ6
         LLacAVYupotmiWEULWr7g8ibR/G/KduAKYFu2zOJmTyRmoQdpxf7G4ZJKkuq2mEb5Zt/
         N7qKqgWDtlBLjJv5bf+rvqREtc4v9KyYKhK7YH/TIjLUQS6gN9ggJyrMOYkbZ6mpGQc7
         Gi6xosbhqCf8PJMpqw58SUEmWamd9JPRM3kIyyGN5R8KfI7GWlu1i+rKNzKzDxQHqyUr
         av5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764613010; x=1765217810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN2y/z/FLR101s1pU+CdIArxbLoEEx4SEWyMarOA4iE=;
        b=hJSvDHko1aBOX2iB1XIRoUoGEq7rCkwLVBUmUO5O83aeCaKboMjkFpBGhX444fjv2I
         2BhdlQabca7tqd3eUR4P9u2bOHsfWk8UfgHPJwhgcv5P17X71iwJPOqsyZVHJ66Y6MFh
         BovM6z5+rL7XfsRQkx3fXT7zQXW5c8jrJf71XAtJWTu1ByoTOtcHFTbe/Jd0YPpKOW9l
         yHsJkPS++Im3dGkR5vhj6ho6MF+wdwwNUgsBSzEsglg/Kd5Y4GyHKDoBVMrEyWKgn9dD
         BsKKsFw2Scwpc9vTDwjwPVJgWUN90qKcYLYaHpCUK5szpiQlTumxcdWjJrW2OxDcFBjw
         4czg==
X-Forwarded-Encrypted: i=1; AJvYcCV9hsz96cks7CiVWhHEVkGpJZtoIfvTo1BotaxOjRq6WXt90r0v9F8rlAENWNhdbjaKA+R9jXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMC6Y5b8vGrIqU2/KB7KEJhy8CEgdoRMxMQvrDMPCtaRgxQYNh
	djol5x0qP5IGaFexEVegO2yGEnxnwVvhOfd5ES19yaIZFewdgPj2gRLXPgmGATVaCyAhyks2/MU
	7vkU3hHPr2PspsUPRu9b/tYAbfk/h2dkwL/nd3XSX
X-Gm-Gg: ASbGncsW2bIA29Tn3NdmNfCLC32YvMAPLDjZ6vyHBEvnBUdQtKIftwxPLFsQLwvhiK0
	qOgRZYyuidLZQWs/5ALmgHlb/JAvFVNmats/H7yDkQbBzWhN6PGoJGnJl6J3I31Wx5SxVZx2yON
	QKgXs1AV/K3wSWL9b9vVessm+sJ6ky8FR0mu4UN16NBbyGBy99DZwS4tuGUEhm6X/RvaV8DHUrG
	0Odd10gXQKFSCtysM3G1XEn+h/Lh6Azvyg7tUR8yMrNUC5ckmrmkAT9YBWN2uri2a6HqeE9Hepn
	dTidog==
X-Google-Smtp-Source: AGHT+IFUNh/62lWymMwnD0ceO20kO6c+MsX0lXg7R68ZCtqrUXp8JPq5Nswihtn71kcpOB7VGOyxhx8iOQUJbM1wmas=
X-Received: by 2002:a5d:64e5:0:b0:42b:3963:d08f with SMTP id
 ffacd0b85a97d-42e0f23179fmr29597230f8f.26.1764613009961; Mon, 01 Dec 2025
 10:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129095740.3338476-1-edumazet@google.com> <willemdebruijn.kernel.e4c6aa98a939@gmail.com>
In-Reply-To: <willemdebruijn.kernel.e4c6aa98a939@gmail.com>
From: Kevin Yang <yyd@google.com>
Date: Mon, 1 Dec 2025 13:16:38 -0500
X-Gm-Features: AWmQ_bkpl41I4gOMYV73-ckdOo-Y5nRXQwX5zvL_fLyG6IJuhhicXrqGizTBujc
Message-ID: <CAPREpbYM+P6gD94ZTNZ+bHBT9=7vz1t8z+Ts_CS72-j3FeodNA@mail.gmail.com>
Subject: Re: [PATCH] time/timecounter: inline timecounter_cyc2time()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Yang <yyd@google.com>


On Sat, Nov 29, 2025 at 12:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > New network transport protocols want NIC drivers to get hwtstamps
> > of all incoming packets, and possibly all outgoing packets.
> >
> > Swift congestion control is used by good old TCP transport and is
> > our primary need for timecounter_cyc2time(). This will be upstreamed so=
on.
> >
> > This means timecounter_cyc2time() can be called more than 100 million
> > times per second on a busy server.
> >
> > Inlining timecounter_cyc2time() brings a 12 % improvement on a
> > UDP receive stress test on a 100Gbit NIC.
> >
> > Note that FDO, LTO, PGO are unable to magically help for this
> > case, presumably because NIC drivers are almost exclusively shipped
> > as modules.
> >
> > Add an unlikely() around the cc_cyc2ns_backwards() case,
> > even if FDO (when used) is able to take care of this optimization.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Link: https://research.google/pubs/swift-delay-is-simple-and-effective-=
for-congestion-control-in-the-datacenter/
> > Cc: Kevin Yang <yyd@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Yuchung Cheng <ycheng@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

