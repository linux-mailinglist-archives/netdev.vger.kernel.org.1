Return-Path: <netdev+bounces-65208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF49839A3A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BC3293AE8
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78E85C49;
	Tue, 23 Jan 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBa9glMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1907F7EE
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041392; cv=none; b=U0sR74jHdG61muYnW1akd63GqgywEYGSONo87mbZCs0gA/+CSvj9LiOBgFJps7tmmhuIdgTK3t8+4kan6vyKwE/gnNbPaevt0TNtsyI3x/ABB7wEgtAkFyHFoZco6EQHv3eX2013CetY88DI6glDIaA4sFCI2enbVHJwyTHQJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041392; c=relaxed/simple;
	bh=BqASrS5v3yWPEFqu6y4zqCpxrbcAoTDrMMa4rh9P/3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHO4zPcNScuvL/UrrDkbF2kJ0/lykYIvs1SYGPz04CMT6wHSQkKypOD9gREiJQmNL9ausMo6ou/CuDNyni9DBevZHsEkoBcLyjlhjEkgpv26x5+UiLCfa0mvTSpfpvzkNR7XO0XLVIRTrtqBKgtCvx4DC3TRxaCtLt+8KHjS2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBa9glMe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6869233d472so9618966d6.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706041390; x=1706646190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqASrS5v3yWPEFqu6y4zqCpxrbcAoTDrMMa4rh9P/3k=;
        b=oBa9glMehjeCvDo7oZQGymSPQS7/NtdX4hKaU7M34xtkws+Q8TZe15GDIAigIygl8f
         cow+XzyoNsZWOIlusEtfYSVe88AHV33mCpvC4nEWPPQam/HHiMdeUBvCIE5Chut9Qqs+
         U9m5LF+TFtGNL2lyq2pTwmueGgQQkrYLCU1xDVnDessVG7D3hyQVs/iD0VlFyDjtuDzu
         zPUiKdO/eCqyfGAxexBKfK7BX9gXNWLW8iPYOu9278S1cXi2oiNT3W9mExmmUUDy0fGk
         7tdATct7EsOP+tORAp1Np6U/qEMwuyhLpIxHNng7n4KuJI82XjtMSytQJrTrx23pA9kr
         gqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041390; x=1706646190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqASrS5v3yWPEFqu6y4zqCpxrbcAoTDrMMa4rh9P/3k=;
        b=hhfQai8FkQ5+uVGeNbt3wvuqjUT0SMXof/ssbIs3eZqEJ3Wk7SvtejqncZJKI9pK26
         aJpmcFed8SgdGgNPI3nDDH8XFkYA8lghRONAODrIQNRo4wnzNs47L4M+J9dYjgJhh6DF
         myaeGzRbAIDRGPvrbJoBDXE3vpFqJibMF0tVavhF4Exr83zduSEQaNnQmsms/NMEr/WF
         QXOpT33SdtIonMis0Fj4doHIuXJ1kMCISZOE/y7MIUxBQKSfGm7irGd4EuZdrpzOFlPv
         ZVCbgk8HS0hzfF1NAz5XwRxobPxQSaQgswNAffg8dhjDB06zNStpf0wZMMSba+7ra6Z0
         1vqA==
X-Gm-Message-State: AOJu0YxWZugvjbbp2t24zHkS4Ufk4U235nRR+4ID8wSoUbGIpF5d1Mwf
	DnPnvsZ1/IOblby8sJ+KCSmQ9WMefKvcnxZOMvC1MtSwOEKtBeGpPdE/dHAxDiB0heVgNn+bWpg
	mIxR6uQ4otB/dPTXp7l7jCWjoPGr/5N4KqiiL
X-Google-Smtp-Source: AGHT+IHna79NyELk6+Fcq8hQsna4nxAc71AjuZxgFc8fjxggfR6bowcpQplSGGfvUlte/zTh8cgBUo2A+JI1lpmHDZE=
X-Received: by 2002:a0c:da8d:0:b0:681:80b2:262f with SMTP id
 z13-20020a0cda8d000000b0068180b2262fmr1319326qvj.107.1706041390167; Tue, 23
 Jan 2024 12:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122175810.1942504-1-aahila@google.com> <20240122175810.1942504-2-aahila@google.com>
 <20240122211357.767d4edd@kernel.org>
In-Reply-To: <20240122211357.767d4edd@kernel.org>
From: Aahil Awatramani <aahila@google.com>
Date: Tue, 23 Jan 2024 12:22:58 -0800
Message-ID: <CAGfWUPzuXi+j=JE2Q3ZZ-MCfS84Y9Om5smB9C4Qn9Fq7RLY6=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] bonding: Add independent control state machine
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The compiler will know what to inline, please drop the "inline"
> use in C sources in this patch. It just hides unused function
> warnings and serves no real purpose.

Understood, done.
I have dropped any inline reference coming from C sources in this patch.

On Mon, Jan 22, 2024 at 9:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 22 Jan 2024 17:58:10 +0000 Aahil Awatramani wrote:
> > +static inline void __disable_distributing_port(struct port *port)
>
> The compiler will know what to inline, please drop the "inline"
> use in C sources in this patch. It just hides unused function
> warnings and serves no real purpose.
> --
> pw-bot: cr

