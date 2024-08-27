Return-Path: <netdev+bounces-122131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F695FFE0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADB81C20EBA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845391B964;
	Tue, 27 Aug 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsRj7Ogy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217117D2
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729755; cv=none; b=j2flq+7QjeblbBReoW0v495yZj9eh82gSuaVBbPa62neBRyxd2cH/aRF2Ru3I+5A9+FbpNJ/p8gZeuqhCN10E0Qu5z3DeVRDSV/1Nh87LMOu9QQILz8YK+HxIFso1gnDyx+c5D4VwjxEQPEMw0WIxxHaboGyVt7IFij4TRKmuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729755; c=relaxed/simple;
	bh=Nff7whbbmGbtqWSAL4ASq86DJwlRKC2YT5n1kC6zHpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpTlcUwGxPky9Sib/kZH8r4EmRLMkMoDakoAabyYH5kD72Cnn2QnbCcUY+4BVPsJxEF07N3E3ncYqMuIbiBRQZBPREdAAYPPxEMAz9AfRZQJT2GrXOyJ1+qedzbFL+51OGNqv4pIVQGWJ7dHb/31L/jqqcK2Wm3f9leWSMRHj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsRj7Ogy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d740b06b4so15392995ab.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724729753; x=1725334553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nff7whbbmGbtqWSAL4ASq86DJwlRKC2YT5n1kC6zHpE=;
        b=CsRj7Ogyb9DOrziexQrEqJXzWRLXA2tkhpJNKqJ9RLjqWYemR26LtRh5UJc4IBF4YS
         UhTUSOAQQ0VW/DEIzcpatPOI6N95/0cL6e/tQoUl1P5QvX9rnvyRfnsTnK1tSzQb8lZu
         8J3lhN5MXz12Sw8GIPfMWd52TzWXAPp4xs4C/UmgDFsPw6hzk5t+6D6RkYE6Ly3zpC5X
         gTyA3kuFsC2EjNaBdEafzCUBHWRoG12H8vPzgjd1F0UzZyUtzNLODkAq3C/wG5G4Tnos
         LGl0Cu8NK6Vr6UL7ZFnBHIKJckbii6pfjae2u1C30nECRiFP5TVnggqd8rcrZZ3szOb4
         M02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724729753; x=1725334553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nff7whbbmGbtqWSAL4ASq86DJwlRKC2YT5n1kC6zHpE=;
        b=LHUlwzudnZxqRBrgbQ6r5r74NMSK0lUhWNa7pzjtn7YWBVxuRF9qe1aMvNb8tU269B
         G44EsIqSHapTmi1bA2nydekecnxKxZfa6uNzcXm5q1mIQprbuEz+g8YSMLDhEV22cFtS
         G4z9Lr6Mn8ZzmpxCWHPQyCxugAbC7JpbxlEu6XEEu3JLT4bnmWDI5UyOwOgZm7PqxrVX
         RuaWqu9zyKFT443fqGYkg1b/GE3TBeMmi2h+NUsgn1J8lPL9ku4iNM2kB7/O7qWfrhAf
         R4uHTqzzHmCqd3zgAUAgktVy+YmAL3kd48UnRMDFKeEmaEIBzVCtyOHqPxG+4zJDKZzj
         gj8w==
X-Forwarded-Encrypted: i=1; AJvYcCXHiJd3y1308xEsTGRGiwZ2MaYdZjv6IpyfCBZEebovXgRIHNE+UghK/MCbdFAzwOckBQl4cuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AZsEa6mp1Sp/pDPT+ik1xCum3JV//AugbZOAYZ8zG6oATyDM
	FZdnZtBIgePm1NyQ/rmWy5lfZuZQQ9qQO12ZQuv2F9knJbCKYrLNDitNhLp1UzqIjgtj2yneAVX
	MSxNvM9/TP24wDOMhY6QBWDt754cV0pNtG5E=
X-Google-Smtp-Source: AGHT+IHUedNCUwrnyUPTfwWQiLW0jx5r23otX88lSiPnhbAf3CzyaSaK6Rj7PLXUZpnd5+ERxpdaqFpgFF25a5phsIA=
X-Received: by 2002:a05:6e02:15ca:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-39e63fb9416mr13927605ab.1.1724729752996; Mon, 26 Aug 2024
 20:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827015250.3509197-1-edumazet@google.com> <20240827015250.3509197-3-edumazet@google.com>
In-Reply-To: <20240827015250.3509197-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 11:35:16 +0800
Message-ID: <CAL+tcoDysd-sxx7Lvku_5NiwguRccZuRNp5Up9SwWJjd6vFDag@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: annotate data-races around tcptw->tw_rcv_nxt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 9:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> No lock protects tcp tw fields.
>
> tcptw->tw_rcv_nxt can be changed from twsk_rcv_nxt_update()
> while other threads might read this field.
>
> Add READ_ONCE()/WRITE_ONCE() annotations, and make sure
> tcp_timewait_state_process() reads tcptw->tw_rcv_nxt only once.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

