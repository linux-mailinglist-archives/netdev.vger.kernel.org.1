Return-Path: <netdev+bounces-125528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ECE96D883
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53DE1F27A06
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096719CCEC;
	Thu,  5 Sep 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfgyL8CO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DC19CC01
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539208; cv=none; b=POj5OqdT3Hm0RF+vfhZUr+pPev6AkVDJJ+thDJ7ZzFS3Huu9ic1is6uTrhpS7Kf1sKt/BMuNnHYqV8S9EBuzxrINOuirTZHd2WVFk9dw6PzKylFewEWu6lFB4zl/5jx40leMwIQmYb7MED6+2ytQjoiR3ZVjPU9fSRHUQYPqLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539208; c=relaxed/simple;
	bh=Ulbjne2nv3r/DUq80hrK0TxRzXcuxZ6zEX1IS9jDaZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfA4gXklZnPneu/XiOPHF6Zqxfk7CEf/OjCLfhCjuKqBmnsaLf4nnaffObHanhoaFoLdxkGujVK4e4nch6NnKeLTyhA62AsxOG2hfPRTFpMP5yiq27mmb40F4qHZM1YeJJVnYc4wGdsAJ0gjQJNDo0eDBCIBju5pZWETgMCtrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfgyL8CO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a16c53d3cso101875466b.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 05:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725539205; x=1726144005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+ufKFXr2B22JJ9sxZky1jE8Ur2RdXBvQiMNeTfDrrI=;
        b=XfgyL8COA/KqAJ27rbZ+AWu6lkWfdcZQ1u+FBFtlNozKIjuaxDTLYicDQJnbcwrCWq
         kmeO0lXfVa+8MOLqEdQStMUYQCSJcPkiGd7zRQCtRJ8DDntbn0Kn49DA5lOhfSz7D34W
         bjp8H3JsH4dCp804sUXoUT7XQS1ntdmUMHI49grL0FioDf3DEbUXO0q+Ca3DlRmisRLT
         XDfzK3ErkSWNkMjdOr9IOucIrK2UfGq/HlNiIuETBDpFNT93+rwcU/0eprNga8CrdbVt
         HALvW76Ma+pU4GYC1ANW8EzE1WrBuKPQMK+TqUogf8M6IPt8DNYpZhsTl8Wpp87qTpjv
         4OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539205; x=1726144005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+ufKFXr2B22JJ9sxZky1jE8Ur2RdXBvQiMNeTfDrrI=;
        b=tcHMR26YI38QiBhneZ+gD3Gg6A6gQhKU5BdtIyO0S8Xd4Np6OX2yA46XiEDVoKFCm7
         lJdeTP836S7h+RjJoDWRPmfCAOTIVwGnKoAH1RLisBdMGyT4vLIqpMOIpTAkytDht49K
         FWz2Z0JVWbZqOO66GLZQchz2C/ubR6XjT/Ulfw2Rd2XeH+Vul7B1fc0HH9ekc3UjStoa
         kCO+blsqeKjQpheR/VhBSfX/wfHzk3X4F4tAz7r5773iMNr8zBxi5PvIjayIFrB6lhPU
         EG85rTlYcmU5XYmiztlhMprNQ/zMcG1XdOShLqDkr4zEJNedqYFLL+7owX+GMtqgOCKi
         WEdw==
X-Forwarded-Encrypted: i=1; AJvYcCWi+GcyEl/wVis6dCGT1UEHB4ZxwgzB6hfPacoPDj4GKz70EoFLbiDGMU1fPDoHy5ig8taT57M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6PcyDqIp/AMVd8MLQAhrEI4rekZNirVAa670WNH9U8ZyYwsA
	KcK6hSm/aArMlBSGtj30GOYt0w+JKj5fWnM+b2K1mCxGOTcpd4L5SyAWiSARZ3vPXafhBlvZ0+Y
	FQbR1HmK212i9IPN7xsNT/7pIPuR4CO2p48SE
X-Google-Smtp-Source: AGHT+IFf15lQx7GUw2WLO/NTV5SOUnpXaaA5sVn3Fr2uZB0Ex465Bod3k//b6LJ8S+lB/cAowVNyl4FWxaJNTxLartk=
X-Received: by 2002:a17:907:2d07:b0:a7d:a29e:5c41 with SMTP id
 a640c23a62f3a-a897f8e7272mr1808848766b.40.1725539203887; Thu, 05 Sep 2024
 05:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904133725.1073963-1-edumazet@google.com> <20240905121701.mSxilT-9@linutronix.de>
In-Reply-To: <20240905121701.mSxilT-9@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Sep 2024 14:26:30 +0200
Message-ID: <CANn89i+K8SSmsnzVQB8D_cKNk1p_WLwxipUjGT0C6YU+G+5mbw@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:17=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-09-04 13:37:25 [+0000], Eric Dumazet wrote:
> > syzbot found a new splat [1].
> >
> > Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
> > spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
> > and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.
> >
> > This also avoid a race in hsr_fill_info().
>
> You obtain to sequence nr without locking so two CPUs could submit skbs
> at the same time. Wouldn't this allow the race I described in commit
>    06afd2c31d338 ("hsr: Synchronize sending frames to have always increme=
nted outgoing seq nr.")
>
> to happen again? Then one skb would be dropped while sending because it
> has lower sequence nr but in fact it was not yet sent.
>

A network protocol unable to cope with reorders can not live really.

If this is an issue, this should be fixed at the receiving side.

