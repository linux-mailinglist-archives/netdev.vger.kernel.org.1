Return-Path: <netdev+bounces-204860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE797AFC4F6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0973B824E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEA29ACF6;
	Tue,  8 Jul 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFEcL9Qh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD02989BC
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961782; cv=none; b=HZ8HWN3cctRjQJK14FfWObX+M5sm3f9doeY5/1f3N3l0HAZiONt2vTWFLhhE5cApWnm2hY1r6U9OEW3THj814Dv/Q6fVCwkHDGN0bBxteCnTSTXMsz5JDOjenIU2RW/vMrDl+HUfSd1IlxL4I55RmUmQrwhHyldUISLEcJgwLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961782; c=relaxed/simple;
	bh=BYX2nKw8V8H9vqiU/XTUcWHzYRV0LYBrsdNAvHDZ+P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEOpJfEf8/lKPBjOCzdsYjGNEfhM0iw2EdlrnNCBRetkNEwvVb4wmh4KoJeECvUejcGlvUtV/IF3VoS9fQTePO61tOaMHh75camsMHk8r602dnyo1bAZC831y1ll17lg+IIya6d3oDAe2tZDwXbpZjRJjQUokJBpNFBiu29N/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFEcL9Qh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43afb04a7so28564081cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751961780; x=1752566580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYX2nKw8V8H9vqiU/XTUcWHzYRV0LYBrsdNAvHDZ+P8=;
        b=cFEcL9QhPreK03FJp85LGP36od+UoZlqG5lI/nP0gB2lGwAWFnBm++xYmG7gxUUYcr
         vbhvY4RwxkRTDOzWuWq/enwZGw0ykAE4MBrz5kGKHW4YzoEwZRt3kRzdV4a7nUCzbYEd
         p+P192OLWib1/j+J4GiSjmEwOsAm/1AatC1h0GDkm6WtTh/QcpDbTcTQ7Dq2mqi0wYka
         4d7y3c+uVP02f7U7f6H4H5Xph6Y9aSck9kSuSdV6KTkRdpRLV3hbMEgcZQ8NmsApk5LP
         hnhwn1BzEuGCOKc8rmmetsQGIHj7xwzj1mG4pxwTksF1SqNCJNW7rg5Dog1ZHjuoB5Vh
         Z0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961780; x=1752566580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYX2nKw8V8H9vqiU/XTUcWHzYRV0LYBrsdNAvHDZ+P8=;
        b=rUeY4f1YOrlvu01RpGLYcHSbC/SQZYGt4V2CfQEfAYfOk3c2Y5ikXE2QdlvHSFRzUR
         IX8akkJiR2aElP6vx+l457UHEll5yaXgHK8m+b9fFkHYCnBHEjiP1uI2SFAhZ4ewWCbv
         arIhZNvysa+0GBxpZP2ScDGiKAWFSpg/eDlpQV73LHlSDtKdokjOpKye4K2hX+309nxA
         oNjKPEOM7QAtS0IXYFcAbnDLBJIsUCSt6hozWx5tmTkeeWoLqrXjh4RnwO6oYt08ETRh
         AziAUEtsc65hexEuZFGnWVhO44pXsx/VZBb30bNCMQJ+VJmwmRVl9FC1qXNBZ6YXNfoA
         cefw==
X-Forwarded-Encrypted: i=1; AJvYcCV4PmE+R7zoiUr253unkxSfW93sm6WDIGVXP37i96Z/yjoaN2BokNgeka80+6EFQ8FBvfy5V+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPiOkmNQP8oLaufwWuhffknYdHrJEmHr4Toz2h9kZwSmgmdX+
	vf5NMr3j0rnxjv0+upyZM6vzKTVigsWPH05l029iek6qJ5GFWeEtPRALneLZi/tSrsKUzqfaxpl
	hHB7fL8mak+HqHQuPehGidX7acVL7EU3MlURfCa16
X-Gm-Gg: ASbGncvNoWuY+7wSG0GKW1JMUhPcEPpRkDfiwk5ihugCcDQhZZBj5Dyr0I0nDIIMy3h
	vdr4oUM2ufgKkhsnW4y7njgVAzehq8vXFfNIziUVwFbiSAZbN8dZRaPwPcEHd+0zQuObWhjA42b
	K6a0YeJUCsIs3//inniH75FkblRYP7YB/odRk6dDiTpqA=
X-Google-Smtp-Source: AGHT+IFOm/hoK8xA+2yvFbXSCCAzHPZ+sPNLb33EdBRk3X7TrVVP1viWYkerVhornPqbNaQVP3obbbaW2qn/ZYkLjsY=
X-Received: by 2002:a05:622a:11ca:b0:4a7:62da:d0fc with SMTP id
 d75a77b69052e-4a998692482mr204480061cf.12.1751961779405; Tue, 08 Jul 2025
 01:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALm_T+2rdmwCYLZVw=gALPDufXB5R8=pX8P2jhgYE=_0PCJJ_Q@mail.gmail.com>
In-Reply-To: <CALm_T+2rdmwCYLZVw=gALPDufXB5R8=pX8P2jhgYE=_0PCJJ_Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 01:02:48 -0700
X-Gm-Features: Ac12FXymQQhYAGhjIWe-pEhGq4VdaeDatIELFoZWKE-dIJxatFkR6SO2JgRZscw
Message-ID: <CANn89i+7m8koanZk=47FEhmTHUmOmu-yfViRPayjUct+voQiEQ@mail.gmail.com>
Subject: Re: [Bug] soft lockup in neigh_timer_handler in Linux kernel v6.12
To: Luka <luka.2016.cs@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:54=E2=80=AFAM Luka <luka.2016.cs@gmail.com> wrote=
:
>
> Dear Linux Kernel Maintainers,
>
> I hope this message finds you well.
>
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.12.
>
> Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
>
> Bug Location: neigh_timer_handler+0xc17/0xfe0 net/core/neighbour.c:1148
>
> Bug report: https://pastebin.com/06NiBtXm
>
> Entire kernel config: https://pastebin.com/MRWGr3nv
>
> Root Cause Analysis:
>
> A soft lockup occurs in the neighbor subsystem due to prolonged
> execution within neigh_timer_handler(), where repeated neighbor entry
> invalidation and associated routing operations (e.g.,
> ipv4_link_failure() and arp_error_report()) lead to excessive CPU
> occupation without yielding, triggering the kernel watchdog.
>
> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.
>
> Thank you very much for your time and attention to this matter. I
> truly appreciate the efforts of the Linux kernel community.

Please stop sending duplicates, and 'analysis' AI generated.

If you really want to help, please provide a patch.

Thank you.

