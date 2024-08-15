Return-Path: <netdev+bounces-118954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39E6953A5A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095DF1C21ED2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71D41C65;
	Thu, 15 Aug 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="cQ9iDyoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15F38382
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747838; cv=none; b=mry8yb++xzk3avLCYJIuMcqvPEfB/DAXem9x7XEVFbUyZTwGvPJ/g+HogiNIwEY6MQuGHKduQ64mXmLEHhMXh6rckt7+EfaIjfRRfn3k16H+P0WQo7zX/p/i02XfiDasQxM8xdhNOO4zmx+rh3ulPHf9CyCPNCjVzhPR+QN2OEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747838; c=relaxed/simple;
	bh=8LjPKraHXp5zhGfGSqxGXzTCXOFnT5d0sZOcmMR66rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flK9qBE0oVRyXT8s3s2j2AV/Nf0b1cvy3sczAZRNL9POjx1gghijCvl24KN/EQba6SojQVfdQkhlMIyk821349EZfZJE6HWgf8ujxitPlm1txwpfFNQSyrOZEuKsZJueeK5nmp/I8aXwga/jJHvCK0WFVydsY+sVAZLaeGreXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=cQ9iDyoA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1641641a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723747835; x=1724352635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LjPKraHXp5zhGfGSqxGXzTCXOFnT5d0sZOcmMR66rs=;
        b=cQ9iDyoAsAFJDa/EOzRRedXMVL5XqSdmFaBhENqJf8aguHWFB7AUggXMoCfa2xpm4i
         UsB42ZSFXW8k9gp8y4KF2koK9y5vlDlO/rtLK5Lw4ZdPV5dkL6YAgs2YLjfcV5pz6Yvc
         eikak3yRN0uKLIEAblZ0EKPAvgpgcQFjfpCJpt5FEmkQi13dPUkBTJUdrhA6yA06yM9R
         IIWu9kuIkBlfCojTlauJS0pioc/w5IVqteyfo89drcRJxcylVF/JipfWvZRlaeYt9rXv
         5Au2Yis7YV/JJdFZnRSrgBJKluAEkztfKcbTcrMfl8y3to33gasH4foC397KG2aOZ2jQ
         6QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747835; x=1724352635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LjPKraHXp5zhGfGSqxGXzTCXOFnT5d0sZOcmMR66rs=;
        b=EgiXD3EroYgYNS+JgqYWclTj94M65nuENB0NwCfZ5gJh7K3Gh5f9Hc4jC6OlB2T2+W
         x2BWauOyJyqLw7yh3JUfpaO2jki0Ju8Xl+kd8HLvLr5u3YplXMzvR5m0pZJRDmZ+3QCt
         2oDT4Q8qfsSueiBy9fZ6lb5/1BtjjAYlfdWekZ9nTJKWrv0UAFsk2bls1wFARJNbvo5l
         adJmyohM+59/NMFXWCsxEeJ0OKONiq3XHB/dSvv+zKpb/T7PneDDp5+FRvMx3fY5r/Id
         hNwQm8/dG+gO/OsdWdLcZb+JLAuhKjZN8EsO1hU0PMdh4I/TO5k/aJD2CmhRsS/GAMlh
         aoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhugov0hALdJYp7cmTtCGMMu4WiNR32jTSNJzNBHr6Y59E7gtIzQjyPDAkCwhqoqYd3hxZKsBJ2AS4vyYt2uuLRS5EXr8a
X-Gm-Message-State: AOJu0Yz6Yl+EUgj5VsqcgOQeCCSKUVCi6JgP2/zNZ6rH/v5f9heJonM6
	Jwq9g1S/tTIcFOFYBu5AQnHJcae4A7YTa6vW1wnJfIbwo0oIGQ7KESFr5JgzjFKsItsgd9RjzHW
	IubjIgNOgsnxZhrdEpQeHKHuveGryfJvybaoB
X-Google-Smtp-Source: AGHT+IFKXXPAyUCTZ9X6Ob5IOhluoh01/bMw3qZhzV8hIkSPDVvBnqI4ktbAzM+XGGiVjn/GhZ4WcPNxFf581VUe+aY=
X-Received: by 2002:a05:6402:388e:b0:5a1:eb48:2b9a with SMTP id
 4fb4d7f45d1cf-5beca776fecmr223733a12.25.1723747835040; Thu, 15 Aug 2024
 11:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <20240731172332.683815-2-tom@herbertland.com>
 <CANn89i+N2TGk=WjyUyWj=gEZoYe2K2xYPw+Nn2jb-uDf3cu=MQ@mail.gmail.com>
In-Reply-To: <CANn89i+N2TGk=WjyUyWj=gEZoYe2K2xYPw+Nn2jb-uDf3cu=MQ@mail.gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Thu, 15 Aug 2024 11:50:23 -0700
Message-ID: <CALx6S36HFR2TnxzHuf8x-76VSBTbEZDF2pJEpSp400PWBS83xQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] skbuff: Unconstantify struct net argument in
 flowdis functions
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 6:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Jul 31, 2024 at 7:23=E2=80=AFPM Tom Herbert <tom@herbertland.com>=
 wrote:
> >
> > We want __skb_flow_dissect to be able to call functions that
> > take a non-constant struct net argument (UDP socket lookup
> > functions for instance). Change the net argument of flow dissector
> > functions to not be const
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
>
>
> Hmm... let me send a patch series doing the opposite, ie add const
> qualifiers to lookup functions.

I had done that originally, but there were a lot of callers so it was
pretty messy.

Tom

