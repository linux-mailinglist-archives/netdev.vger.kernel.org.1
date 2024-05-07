Return-Path: <netdev+bounces-94006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BA8BDE96
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332121F25699
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6315FA73;
	Tue,  7 May 2024 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCdguLDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880D14E2EC
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074568; cv=none; b=MR5v2kbMB+fJCjaL3RuwhNbOCD3zuZEzfVYdnoqDwzmquvlP7Xan8+qgnC045ld8kJSZSTpZ4mUNaOT56wm11/ycsDkw5d6oE4dFmgSVUyQ70At/xM92KjvNdhJOcP41JcRnT0eGaXO2unWlzWabkMACTIkIPlK5IvjJVlOyaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074568; c=relaxed/simple;
	bh=ZAeaMrZteNB3NlZkTAK003eJX9lvaY6HSlGKOaAlDPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofGGyY9T10L/B7Nvv3hsTfx8uYMmS3JXUJrk5bskL9fjZ2Mv+KfX6nV+TbZzh/URJ6dLlFwSW56eQ97xfn/R7s0mn9foj3rinLxHB6CDUY/O0AY1wM+CcrZLud1qDwDEdoByOuN5hFKsOGLO1xokJxqaWUskVM6vINpY2rWzh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCdguLDX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso12766a12.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715074564; x=1715679364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAeaMrZteNB3NlZkTAK003eJX9lvaY6HSlGKOaAlDPM=;
        b=hCdguLDXpgwz4sJZWqT5u+/0Wm054ca1SB69okOYkoQ+bezsXJ5a/TMQwGUNl2fenu
         gEL7lV3JiPVIZ6F9p8affJlwGCalnGBWFPoUidhqe/gfDrDUfnOqGGXdF5wm0hxPmV4R
         Gi1pMMhqDA7pfcTnGyW4mBlsnuB3nclKMTokzj6kFyRp9R1iweEgS4giOCzMCsnkuCkX
         mLJ9Bp6NKNTK5aDv9P4ailAat8IvO8tyitEJIWyFxyqEWJ2M5MWTzVZFrMfkhdjQ3jXy
         UxA/us4pLkljRxwoKGlAvgY7PEInKwfCLwUZRVupTwa7k7lwgGITNnkDIZS/kRbNTn35
         4pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074564; x=1715679364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAeaMrZteNB3NlZkTAK003eJX9lvaY6HSlGKOaAlDPM=;
        b=ryApkaeygPfNO7WYE82Kc32CgjFfKyecVeZs4LqkAsAgNetKFbLR7k2qUpp6ievtPZ
         +Xt+w4btn3uqxJk0jq7/Y5QZlAjL7gE7D6tRId1cw32OiTRs7WN2FxIrlPidUxRcYiD1
         B1rDFTHdUnyRG2m0fSyYhtCnyjYJlOB1uAEg9qrAjK5HZV6hCuRGzYXMJ3CGkC4OwmWy
         qdzbXEX8mEjL8RHIQPOvomWLYrPpAT2PX/DE91LBmMPH6iv0/rPco4o+4zSNjTrESsvw
         cPzTnq+2c0cMFTkx8xmbKsTMzT+xAPBowMPq2/iqTtGDvCxrRegXWCiOCYrcccOLEBgp
         J1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUmmE+C5a7KsKJnoXq8o/Pwg1OyVKtIDfQqmgFPPDmirMwt6U9b6PYAYYVVHp/2zZCj0zaI/TEK3i4sovyv85tr9048QeEQ
X-Gm-Message-State: AOJu0YzB2mKksgynpQKFkjNF715IlMsF9i4AlqsJseuAfbioZvdavmSC
	1oOy4/8uXMGrHeCWyR4Y0Q0YWOQbXGwQ7QydIuvIptPr96m+1oVdCwMFK/KUmp2elKwo6jJBYnK
	BgLcx+eNzfernIRLixJJRoCtciJmR/sW7pdy2
X-Google-Smtp-Source: AGHT+IHZE4vciL4/9SVV5ScUAuxzwNbjVbt+yPBuRXhXMGlBZn15u+i805sS1u8KDUhTguJlh7Ypdr5zjGHD/EKq6uo=
X-Received: by 2002:a05:6402:6d4:b0:572:25e4:26eb with SMTP id
 4fb4d7f45d1cf-573131c667amr111253a12.7.1715074563400; Tue, 07 May 2024
 02:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com> <20240503192059.3884225-4-edumazet@google.com>
 <20240505144334.GA67882@kernel.org> <89e0117a970a56bc2de521bbc6f13dfe03b33373.camel@redhat.com>
In-Reply-To: <89e0117a970a56bc2de521bbc6f13dfe03b33373.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 11:35:52 +0200
Message-ID: <CANn89iJjP2c73jNveuCNuPsbp0tbH_zp3ciwF7D24_BbP8qV0g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] rtnetlink: do not depend on RTNL for
 IFLA_TXQLEN output
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Sun, 2024-05-05 at 15:43 +0100, Simon Horman wrote:
> > On Fri, May 03, 2024 at 07:20:54PM +0000, Eric Dumazet wrote:
> > > rtnl_fill_ifinfo() can read dev->tx_queue_len locklessly,
> > > granted we add corresponding READ_ONCE()/WRITE_ONCE() annotations.
> > >
> > > Add missing READ_ONCE(dev->tx_queue_len) in teql_enqueue()
> >
> > Hi Eric,
> >
> > I am wondering if READ_ONCE(caifd->netdev->tx_queue_len)
> > is also missing from net/caif/caif_dev.c:transmit().
>
> I agree such read is outside the rtnl lock and could use a READ_ONCE
> annotation. I think it's better to handle that as an eventual follow-up
> instead of blocking this series.

I missed Simon feedback, sorry.

Yes, we can add missing READ_ONCE() as follow ups.

They are all orthogonal.

