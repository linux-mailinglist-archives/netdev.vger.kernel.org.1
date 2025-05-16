Return-Path: <netdev+bounces-191143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71CABA2A7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9C64A8545
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DB2798FE;
	Fri, 16 May 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBhQiOH2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD26255E44
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419586; cv=none; b=IebrC07ydPrhlUcn2dFWK/9h/L1X8MxOok5BBH1UdW36mUELocMTi6OTjDYmj9sXIoaDTT6Mpuz4sz3v+RLjLJEYbcTT4bii2avb8davV5mWYUJVDU7qA02uMrZDapHFyANsk0xlUOy6yTrhdRmz/Y21sNcCyj6wZ68+xDPmYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419586; c=relaxed/simple;
	bh=tJ7YIAtE7EoxZl8QEWxoCzjLy7ASc0H8Ww+yLbLg/lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoPMNeSd4np/UTSWsZkB08kg3vQvQtOXzrwA3aWRDnhFy7EAl3S1DPBSjoM3QAjKGtw3lYybSXmgYE9Jp6cUKKpXFGsMA3S+Ej0IZlmnLNei59Svd6becyr/emFV1WCHmDJzvu1Wqd6N5lLdXfDiEdh8OMPS2zsZDwLv0n13xiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBhQiOH2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4774611d40bso27331cf.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747419584; x=1748024384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ7YIAtE7EoxZl8QEWxoCzjLy7ASc0H8Ww+yLbLg/lQ=;
        b=EBhQiOH2KPraXG/2+qzQCQWtp0sbXrlXEWCckGEX3Fr7pHaOd1WSc7P6u0O7M8Uj3V
         tAJTyLDIhMI2vxFSiSXIOjOvVfGoxtvJVzKtBWJuahnnHXFIM2ov0oToGTe3SkAgFrWU
         YDT5XePDMAbJnWj7sL/qeutQwOHFOnU3y7dQJ03j5vtGNkccRVU3qMzvspqs2aDrJEOy
         3MPfNf1C9V9MnP7QJgsSK4RZlWycJdyfl3fMoN5b2/pVMz+/R/ZcmFePUfCB1l6x8vdr
         s+EhMtdv+7zC38MyKbEBkNkC4YjoulczDaBfFFA0MzggzfoNgOroinTmg9xRn2ZJ4Qa9
         /sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419584; x=1748024384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ7YIAtE7EoxZl8QEWxoCzjLy7ASc0H8Ww+yLbLg/lQ=;
        b=Sc7U4WOCTMfLHYE/AYcFBItob4UgeHZFBSHs8N/kcHydPlYKsA1Bq1JYj8YRqoJ0RU
         7a0OW6hL5LJnMitgHoHTLSssLslCXl3KQYgtK+XUQwQixrhwFCbYx8o6g8R55hVD73JH
         EFV2rOsSpRpIN2lqtHdS6ZUjujQkg1lZvrevNsJxPpQxnsa01HxwJm+1P0EjMvdQRaWe
         eXeM30I7Hy5AaV5YLUj4pmey4nvKIKh4DhddnXt7De+UIZoqS+LefXqHmrgEbT2DzYl7
         IGFtY6Xy2HEaudXKCf2Pud7fDwxmiB1q85/vq5ZoLFldWaorYwsBRr4aU9Nkx9F5BXOF
         2iVA==
X-Gm-Message-State: AOJu0Ywwv3GI8oOuieSh4mNaSq758+W8/1WYlgVGmsKZ2FRirW89HMCu
	AQ7sEcERcNIpbJs63cD1mXiN85eNJMILrTSdnePFQWy3cTgur/z+1uPRFGAcjNvhcYUBdepwohs
	DhnIbd1215tz5lejL09DX//0o50Led6IRsRwIQJCY
X-Gm-Gg: ASbGncs6Cexfo57WSJpwXe8vihGvKc1i2xn+skXYyVrShs46AZhpA1VykkhrWDQY2ne
	R92fWgiefw66GCrz3Y30NrfqF/m0uWaWVAI0fWmZ/W/USusHBkM5/UbjeXpMXxLtIX8CjfqSbT4
	SOc+qjLcK6YPFsyRvfNB9ODK2muZTGkLXV51fbih3iyza4e/hZiNOAUlFRtrhTJgSO3Q==
X-Google-Smtp-Source: AGHT+IH/YcjxPjaWTFHg5OttoL041EYSiajQrOYey/besh0rkqKTz7c7ZmilRcnNRdGKAuzHyH60KgVbxm6XAQsJi5M=
X-Received: by 2002:a05:622a:48:b0:494:b641:4851 with SMTP id
 d75a77b69052e-495a13664admr63871cf.27.1747419583586; Fri, 16 May 2025
 11:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747409911.git.jgh@exim.org>
In-Reply-To: <cover.1747409911.git.jgh@exim.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 May 2025 14:19:26 -0400
X-Gm-Features: AX0GCFu2hXoSeLLlHSvvIRxhQsSctc4ES_5VsUpD7-rF6_xu0_bcrjgpr3OFHpg
Message-ID: <CADVnQymxsOGLnUfurhDLXNUaK4gpaYm2zTDEWRxy8JPqH6O6vg@mail.gmail.com>
Subject: Re: [PATCH 0/6] tcp: support preloading data on a listening socket
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:55=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote=
:
>
> Support write to a listen TCP socket, for immediate
> transmission on passive connection establishments.
>
> On a normal connection transmission is triggered by the receipt of
> the 3rd-ack. On a fastopen (with accepted cookie) connection the data
> is sent in the synack packet.
>
> The data preload is done using a sendmsg with a newly-defined flag
> (MSG_PRELOAD); the amount of data limited to a single linear sk_buff.
> Note that this definition is the last-but-two bit available if "int"
> is 32 bits.

Can you please add a bit more context, like:

+ What is the motivating use case? (Accelerating Exim?) Is this
targeted for connections using encryption (like TLS/SSL), or just
plain-text connections?

+ What are the exact performance improvements you are seeing in your
benchmarks that (a) motivate this, and (b) justify any performance
impact on the TCP stack?

+ Regarding "Support write to a listen TCP socket, for immediate
transmission on passive connection establishments.": can you please
make it explicitly clear whether the data written to the listening
socket is saved and transmitted on all future successful passive
sockets that are created for the listener, or is just transmitted on
the next connection that is created?

thanks,
neal

