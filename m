Return-Path: <netdev+bounces-109998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B761392AA28
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A9B20EDF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE614B07A;
	Mon,  8 Jul 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XcuKXP+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140414B963
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468198; cv=none; b=JoU6a+Rs/UgJm1xitcDnD2FsWj0Ro6AfmdvexNbPLz8sqOyiSlGBz3wgpUBmu6dkOmK0ZOwNG70XpTo5yfDDq14L8r9XZySHsguM92TAFGmBTjeoJd7wlZn+OrZ4sl6ah4WsXZOGslE89Do13CA088r21eqEpUhDHo4gRlZZjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468198; c=relaxed/simple;
	bh=7D+xUpceViiMorxMSLfmyuVuvRBM/PAMKUSbLtin36w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWadlaL8XMqHUYJqnQB9NbiJUrwd0DhwXFI2FNBD3KyWqY0wIynFVPuUBC/9H9Mk2GoksuI3HE8kZyMs7DPfrJJdqUtinmtC6z07Aeefgs0SXDlGzf1mSeBA96hcWkHJfOCDKAU3TcovASr+Fzjy9p2N2mtlSpj6+nYR+7452/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=XcuKXP+t; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b0013cf33so2893931b3a.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1720468196; x=1721072996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG+yy6mS1Jp1QmVxmrSL8tDecOwhdcnRRxckmQWjuH8=;
        b=XcuKXP+tDxTGbNI1RwfmRF7kVWiEU6I3AD+O21j75HU8lmBJVdw/+/HhvXRIiHE9eQ
         znjyh4+ZXHsuWtoCseC8MyaycBr+OBoct2i322GlmTTyAhahpWA8oGRDgfpzsmoDGZmG
         mZz4l+6z6UXqbyYEwrIp03C0sDWAqYEBXWKkISrB297A1RuvYbZ0eAaxM2mAC8Dz/Axo
         xrkzGrByg4axkzIN16W+mjft+wuzBg9tYUb4LGqVYsOKpARULXGlNkBQ36eLKsvUFj/K
         OoAI28DBjF5DW+h1ypSH6qqHgzKKPTPHe7cIZ9v6e4w44ySZOslGgRlIfIGZPyGMH5B3
         jV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468196; x=1721072996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG+yy6mS1Jp1QmVxmrSL8tDecOwhdcnRRxckmQWjuH8=;
        b=LqbSwW/5h1c/ajRq/JpIRvlSsRacS309bSJfaHC0yGZUIfs+i32VN89L99v1nR20OT
         eiBSPIRYWyVKCoH0+upGF9r1KHkMfyDDAqGBA86+6x96EtKt+/E9A/bCrtMGZ9sDcAjR
         NkGCeDFNP0oB5pmgGw4ma6Vs0n/2qRO9d0E4LuxeuO72dTRWLN4hyHhzhZAnEXhaQmie
         XHBCcTKA8CGbaPRLEwEfxY3rcPoaRtgWtEYfHyd6AfvV9hcN8eSJ1zgsBBPnoyG+jHFr
         SQNx2i6nSxyztcajqJXFVzSrnAA4noLXHBCQjgceNOX3CDctM7tYXHmNt9oCmCZoWyXh
         RhGw==
X-Forwarded-Encrypted: i=1; AJvYcCXE5ALBjKDvwRBcDGj5NSHlAK8DQgQHBFK0NVZeMcPXKDvClxIBIl6pb7NfURyUgQp3q7/VxXUPx5tTy+lSU/Ud/fdqXv6o
X-Gm-Message-State: AOJu0Yznc4pQ39+MVKY4LFWnz+38pzlck5257mnfZjMTIOgpwVHviKo4
	ZxXZCMpAuja3p40lkbUJl5weyFffuiIwAONzUT/g7p54qSl9w1uJb2afIWHK6m+fzG+8CpoYsCc
	b50hCncFhuDPkTZVjk/MEm9JWUetwFswvR6no
X-Google-Smtp-Source: AGHT+IH2MRLeGKshWQAHPvfceTh6DbvmHmVohL86pPOKEbXDhetWTsQzqQTWxo2PxXciOjA5LKYla+qc6Xd2L5XTsRU=
X-Received: by 2002:a05:6a00:198c:b0:70a:9fea:71a2 with SMTP id
 d2e1a72fcca58-70b4353b11amr950766b3a.9.1720468196346; Mon, 08 Jul 2024
 12:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708180852.92919-1-kuniyu@amazon.com> <20240708180852.92919-3-kuniyu@amazon.com>
In-Reply-To: <20240708180852.92919-3-kuniyu@amazon.com>
From: Dmitry Safonov <dima@arista.com>
Date: Mon, 8 Jul 2024 20:49:45 +0100
Message-ID: <CAGrbwDSw-r5_NYCkiF3WELLU=UtJBegd6qYFJ1-WmbBbTAn_2A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] selftests: tcp: Remove broken SNMP
 assumptions for TCP AO self-connect tests.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 7:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> tcp_ao/self-connect.c checked the following SNMP stats before/after
> connect() to confirm that the test exercises the simultaneous connect()
> path.
>
>   * TCPChallengeACK
>   * TCPSYNChallenge
>
> But the stats should not be counted for self-connect in the first place,
> and the assumption is no longer true.
>
> Let's remove the check.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!
Reviewed-by: Dmitry Safonov <dima@arista.com>

