Return-Path: <netdev+bounces-84524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D0989726F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8593C1F29688
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF7149DF0;
	Wed,  3 Apr 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJbRrrLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88A149C48
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154196; cv=none; b=mA/cxGBbZ5E8JhsrZixxAs9oo1XlmECiORBOMdbTwQ6yj12Skcxr6iGeF5T1WXVf0MGuzTCKbmpQdt9kF/46OGjaikyXylYlkYAn44Blb8A3NqVlK7vbw7yTfpPXKMuLedPFhmvwEtMFjiuyjPhzOZV3g6RhDM6+yv027NE4UDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154196; c=relaxed/simple;
	bh=BtD/ZmgtMJu+RWu063ekP4QzyLCeNDIOGU+vGy9LrEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrNm+ioeP+dbXKYiTnY11RBRWxRpUHZhNA73zTl7GTYh9gQBhrR8Y4xGqyQ3c2U7pPvG5MJS1dBpQE851Qiwy9T5P1DPdKJ+OtXZ4ff1S1XjCPg7gwtVk7/EKzrvp/GvoHY1M0Xi0HRYjdrmEJAyPgMDjQhv4ysEPspCu7AiuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJbRrrLW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so7588a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712154193; x=1712758993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtD/ZmgtMJu+RWu063ekP4QzyLCeNDIOGU+vGy9LrEU=;
        b=sJbRrrLWcQ2LFUm+7Ui56QeevW8qWYQS0QbypkLW2cALeS/h0eUpfQuol9GpyrtZaG
         Z2z6UzbultURVxxgZ6YnhUZN2g5qi8A9cbhTee4APSe60oi4OC1A2rUBBSUC5vchnmea
         ynO7PSnqAU1fGnSHOOzRDVuA1Lf6v7a8qkL2t74gtiHWUY0ygEfcVhmnbUV2Dj4fIXHK
         KQzwEwyN+KP4IZwSTGsjcd0kye6DnyLcuoW/V5bcbas5bA9gEPU7lqtxHMnx506OlVQS
         HFKWio1g6G5djUpIY1kySDn8cC4fLT7YcwOt6fY/2FZpxs9ce207AJVPH59SKnM4PEuJ
         jP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154193; x=1712758993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtD/ZmgtMJu+RWu063ekP4QzyLCeNDIOGU+vGy9LrEU=;
        b=raL1f1BvNavPDToZmj7VkxyRlWrDrvIpp6+9dJ56jtrZBX6E2X6XCGAMeZBJUd66oH
         AdYlor5RTqOzXj3ayxgf1Xyc9NYR7dXVj0LGbQwk3UsF0bf6LX9RJ9IYSooUqrKH5uGo
         5E24ELnZKplcuevu36qv1SKY+InWDAyT+0sKEqABqYHwtztD1FT+CXQ5zLCpBGRbuiWJ
         CllVNx7tvSsyACqnaK3L7xNqibY23A/PkhunohL3/8ftqNEN80KOMKZs839cPwgYqS0y
         olaIVTxSC5TVvAnzaPbPDqqs7Q1TW4bDfByxripszREfxHorgTSePLtX5HUHZSgoM+gR
         99jA==
X-Forwarded-Encrypted: i=1; AJvYcCXnWzzjmMzx/3cuEmLQbuqeieZa/sdfkudVi2a/NnUzzZrNs2PcI4wlMuWyuEMC90ViNVOhxM49hVW/3K12LcqyxYEd07v5
X-Gm-Message-State: AOJu0YzAM/Mp/qdcsjfLLHBuP0UVpUHcm9dXVO46CD841OsLWOeMCBBF
	9lRKV9Rkvm6x7kHDK1BtHmwKqmbfhjuzdHaE9z4xu7s+tDr09oJcCsscl5DVCaVUAfQrl15fMPx
	9y4bBauZ+xugiNsQ263+8OTkdghbE37QLljy4
X-Google-Smtp-Source: AGHT+IHpcramSsvFkhfoHg0J1V6s6IlgfssMHxJvKnV1sSx/W5H8Az8l3QNq8OJPsd5yR6yaBIyTsNUWCHg+RHQA3DU=
X-Received: by 2002:aa7:d3c9:0:b0:56d:f589:7d6f with SMTP id
 o9-20020aa7d3c9000000b0056df5897d6fmr202474edr.6.1712154192339; Wed, 03 Apr
 2024 07:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402215405.432863-1-hli@netflix.com>
In-Reply-To: <20240402215405.432863-1-hli@netflix.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 16:22:57 +0200
Message-ID: <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with scaling_ratio
To: Hechao Li <hli@netflix.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	kernel-developers@netflix.com, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:56=E2=80=AFPM Hechao Li <hli@netflix.com> wrote:
>
> After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
> we noticed an application-level timeout due to reduced throughput. This
> can be reproduced by the following minimal client and server program.
>
> server:
>
...
>
> Before the commit, it takes around 22 seconds to transfer 10M data.
> After the commit, it takes 40 seconds. Because our application has a
> 30-second timeout, this regression broke the application.
>
> The reason that it takes longer to transfer data is that
> tp->scaling_ratio is initialized to a value that results in ~0.25 of
> rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, which
> translates to 2 * 65536 =3D 131,072 bytes in rcvbuf and hence a ~28k
> initial receive window.

What driver are you using, what MTU is set ?

If you get a 0.25 ratio, that is because a driver is oversizing rx skbs.

SO_RCVBUF 65536 would map indeed to 32768 bytes of payload.

>
> Later, even though the scaling_ratio is updated to a more accurate
> skb->len/skb->truesize, which is ~0.66 in our environment, the window
> stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
> change together with the tp->scaling_ratio update. As a result, the
> window size is capped at the initial window_clamp, which is also ~0.25 *
> rcvbuf, and never grows bigger.
>
> This patch updates window_clamp along with scaling_ratio. It changes the
> calculation of the initial rcv_wscale as well to make sure the scale
> factor is also not capped by the initial window_clamp.

This is very suspicious.

>
> A comment from Tycho Andersen <tycho@tycho.pizza> is "What happens if
> someone has done setsockopt(sk, TCP_WINDOW_CLAMP) explicitly; will this
> and the above not violate userspace's desire to clamp the window size?".
> This comment is not addressed in this patch because the existing code
> also updates window_clamp at several places without checking if
> TCP_WINDOW_CLAMP is set by user space. Adding this check now may break
> certain user space assumption (similar to how the original patch broke
> the assumption of buffer overhead being 50%). For example, if a user
> space program sets TCP_WINDOW_CLAMP but the applicaiton behavior relies
> on window_clamp adjusted by the kernel as of today.

Quite frankly I would prefer we increase tcp_rmem[] sysctls, instead
of trying to accomodate
with too small SO_RCVBUF values.

This would benefit old applications that were written 20 years ago.

