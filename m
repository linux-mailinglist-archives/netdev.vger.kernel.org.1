Return-Path: <netdev+bounces-96540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2F8C6651
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F81B1F21DAD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7313745D9;
	Wed, 15 May 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwVsGTbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8257443E
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775842; cv=none; b=XJCXWUN8oVkfy5Q7kc0KF9dT3VFVgNVkaEXen9Co8yE/xenF1PlsJk8SiD9/tLNAgBFHp11ioAuxtbl/xurbSkfmebwjcCncUX/NDSbBGQDEKBgvAaYIO9UguJ6ed5wKRsD98FVXrz31v/qZephUS6vtkb5J5nYa71Pa+tHT99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775842; c=relaxed/simple;
	bh=AZcyxAapPfK5P4Ckoo19AiAWhCRUntdAjC9y9nmel9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFdh6bAmGumRLQua/FLoKtDzl55PVll2pA16fN+G50TZd6Kdqd6zZRTcSduVG91GPWsOrw8kQSDmUpJ+s+nYRNEXF38y6SixCWWUDOJvj75Gx7C9k9hQIKiBzmvYoTogpHnksGjgb/xqcYBxIQefsosAoW+9dMivr2MCGooQBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwVsGTbI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso35391a12.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715775839; x=1716380639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZcyxAapPfK5P4Ckoo19AiAWhCRUntdAjC9y9nmel9A=;
        b=FwVsGTbIuk1DSohpGzSYenjmQvwExvxxJlZkHLMrEO3weWkKhU3P6CE89u0QgZmo7q
         RtU9qpe6p8V1ea+dayUgT+pbQlcueCSLe4vGJWpqw9AfB4ZjS8w6u2FxN57o84pUEGGR
         fA+pBGYMufdjvszG9q3z/0LtD4ojZNwT/ZDf9+G07ranr3N5MAgbVoxDO7umDdDkTRzk
         gg5ph9JcV4TK6bJcSr2tJw5k+tBsOg3c2RuBJTn86zVUb/P7aSDnpYaIZ/kODQ68Zdmg
         j9F/ErtuwKtvlmEK6byG9on/26gdMiZxqyl2CNTbwm63kpE/tgTckt80pBgyK6dgAB64
         o2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775839; x=1716380639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZcyxAapPfK5P4Ckoo19AiAWhCRUntdAjC9y9nmel9A=;
        b=Lahy2upz1G9manLqneZEOlgochsI67Qpn/8jw33jIffQBIHzL3dedjA4mW6vvmIXp3
         I4JjC1H+cCepQz7xo/Xzi3cVITkiG+UOejO0h46QofTkYvawVTFUmGyh3Y5o7OF0CHPq
         N43U/A6zqU/sEeEXwzLLxoFPbml1rcgL2kp6kuYUlmHYo6pSDrHCVGHomjf/RHCCmdki
         pEz4slNI6Bvqz1k81F3c7pw/DsT1mKA26syaqppiZBgRQQGvK+Q6yGnH0uO/MxOO9+vg
         n1mV44HnUbThNIrlD89/pjO/0cbrX9lTSREpTPmEFdfVASutidrlPso72rVoyUlvLT3e
         9+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJBHIIRVCuZZkpI4fpzrGrx+WehupYCYtKlT+JCQb3o8LPh2ZHXVzhjQRoVFmYEzS8PmuopmuVa1JMagwiJhjMHr4qTS/c
X-Gm-Message-State: AOJu0YwjB+7LPSOTNHGKye+EGy5uIWjnxuXzOe1cVzrf+U4N6JT0DgzV
	OBeQAh4tc2skX/bunm8Vbc3SXhvKcb5Efu2rvw+cwUdkEUeIKcOonsfKxpxr++QNKOKiq1dgiBx
	DLduZWOkbwDFqQV+8kHAHeB9gDSQxvJeADWh7
X-Google-Smtp-Source: AGHT+IHpCFpQL5uqLrfVahn3W6J2Er1NtP2/bamNIZFHqaokc8zdLUfzhHx6gWowQBzSl67vXhZChDGPV6w+y3pDbP8=
X-Received: by 2002:a50:c943:0:b0:573:4a04:619 with SMTP id
 4fb4d7f45d1cf-57443d30f6cmr770395a12.4.1715775839103; Wed, 15 May 2024
 05:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
In-Reply-To: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 14:23:43 +0200
Message-ID: <CANn89iKFmnJpTQ6-y-cQffWRjith63JtS-gSVhx1S6Nb_XF_2w@mail.gmail.com>
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if
 NAPI is, scheduled already"
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ken Milmore <ken.milmore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 8:18=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.
>
> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> default value of 20000 and napi_defer_hard_irqs is set to 0.
> In this scenario device interrupts aren't disabled, what seems to
> trigger some silicon bug under heavy load. I was able to reproduce this
> behavior on RTL8168h. Fix this by reverting 7274c4147afb.
>
> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is s=
cheduled already")
> Cc: stable@vger.kernel.org
> Reported-by: Ken Milmore <ken.milmore@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

