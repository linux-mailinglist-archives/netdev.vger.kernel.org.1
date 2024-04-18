Return-Path: <netdev+bounces-89354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E8E8AA1D3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FCF287303
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371317B4FB;
	Thu, 18 Apr 2024 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5BcPzaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E27217AD97
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463792; cv=none; b=fLCicZ2Ww7vhUQkL870nmhCyH8HWhDo1nKOq/DTvsNFvG3BUgzZrjtnVUHXANmfiy+AY3k3EuDD4maUeWVhuM1KNKE+eFCL7KFFRYcGw63kgpgjiWdL6JhA9HC+qivXRfLw+DDMDTWeYekia43kL3IE2LlwPK2dYk2yIwctzmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463792; c=relaxed/simple;
	bh=TK9BczCfsvup8F/MJjFQ2i0ZBpmWKt47nElw91QueR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XucNfSMzEmp4qs0q0Qek9i/DWE72Wmaanet3cvKtRpgjqYXOG2ujq/Mtdv1gZjq5RdKg/8nUXDmdV5gl7JldE5JbM9NZ1TLykAkqgjrZOyA4bsn3pun8PLZ31znMfIN/QlVSB3+SPAYjxdMOwyVgS350cxqUSwyEgaKc7oK0hZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5BcPzaf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so1810a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713463789; x=1714068589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TK9BczCfsvup8F/MJjFQ2i0ZBpmWKt47nElw91QueR8=;
        b=Y5BcPzaf3rFKNK2bav46lfep9Bs9KkA9mM+6l/Fh6vk0DwPVqjr/Alq+eDUy/efEbR
         3ReuEy7wkyJnyHJyjx0lGxtxrI6fmkxgwUAlT2r7xiNMf+sDn9xxXRwppgSrLeCn6o6u
         drmjXAIUAodmJMJANZDTM3Uf184ghLftCCeuV9fhLEbLNbnQQvdzDsmZWDhKyQ0bvACb
         MJ82r/faku/28qaujnOq/RCsqU9oV65SQC+W0NnI/r2UHqgG04DQ5l+V+VqvKjxm/oAZ
         k0WC3XcHUqzj0neooQpvBbKf+pn2OWaCYyu4vy3s0gEaKRvBARqFWfuRwCunlCDAD2d9
         icTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713463789; x=1714068589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TK9BczCfsvup8F/MJjFQ2i0ZBpmWKt47nElw91QueR8=;
        b=S4M6a00ZnUQ+X31xeNWNZMKErWnNo/iP8s3Ghk4hILTlJzgiBDOr+p2dK64k9F6w/7
         2DDUNBMuS267L9wx7FlljaToLY1lSAKT30SihA/xZZ0TSMKrEwrwQi3MxqsCYk63+CBv
         1/KvPECFAItJsfi+9vWXvxwC8g7WsD7yc7M8onRQAWB6UA6OtcbwB5rhFNyyZnDrzqC6
         t46J0HpB+yKm4NyoxEPzGLR8KpK+NJ6CLEoC+CWkMEMpQ37LIxoXu7celgPu6EhdVgzS
         dJ6Q2jC+XAWRJiWe1SyYIxOxx7Qefw79sX5oXbwhESL8E9Xe4Gty0bkKe/VrVlngBmiv
         MH/g==
X-Forwarded-Encrypted: i=1; AJvYcCVBjPKGabJI/xwAtWi5Xu3S2/caC2vnzZLUm9R3zLcXg9nJ9IBa66/1UE2+FrvHT0dtReN+vAStyfnn/jXgvXseMk/5rwVQ
X-Gm-Message-State: AOJu0YzUSq/wFANA5ASDNnTqTir8eeCCNAvl3wkJg5xdcvcb8GgT03/C
	JkXlbVbEzGFAVbscagje5MeAssl+STKGtUWVTRBgkQ5e7QpHH+9VWPyFjxxa19lGt883qLxjnks
	2XnWJra0rAULJpAN6z1Uf4fu5pkt064oMBmAo
X-Google-Smtp-Source: AGHT+IHgou91Yq3SDGNi/583td6UKh4PyXzjCVrjELDp66HeLwmp47yDGhUxtyjSsCCIBBYDd6BoQ3B9bKnUZK+8eHk=
X-Received: by 2002:a50:85ca:0:b0:570:481a:8a20 with SMTP id
 q10-20020a5085ca000000b00570481a8a20mr5553edh.5.1713463789274; Thu, 18 Apr
 2024 11:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
 <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org> <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
 <44e406a9-e3e7-44c7-9f79-c76280336ca3@kernel.org>
In-Reply-To: <44e406a9-e3e7-44c7-9f79-c76280336ca3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 20:09:38 +0200
Message-ID: <CANn89i+SB1Kg=9DY8aTRWu0YKM7+RYdH0sUnVW==TVvLmrTiuw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:02=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 4/18/24 11:47 AM, Eric Dumazet wrote:
> > I think the userspace program relied on a bug added in linux in 2020
>
> which test - when was it added? nettest.c and the fcnal script were
> merged in 2019.

The test relies on connect() being aborted by EHOSTUNREACH

This is in complete violation with RFC

Even our own net.ipv4/icmp.c states this clearly.

 RFC 1122: 3.2.2.1 States that NET_UNREACH, HOST_UNREACH and SR_FAILED
MUST be considered 'transient errs'.

Your program wants to use RECVERR instead of depending on a bug that
we are trying very hard to solve.

