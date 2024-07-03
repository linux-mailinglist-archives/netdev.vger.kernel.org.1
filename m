Return-Path: <netdev+bounces-108754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F905925386
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 08:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CDD1C2183E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 06:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACB49641;
	Wed,  3 Jul 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pUmTt/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126AC2F2
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987279; cv=none; b=EextvmrL+bdSluXUthOqwyeVHiXMrSLNxDSS/GR0zkyFWaHLiFRMTKMlf4wWxnFrJNDaWIhDy+kAz6jeKfSvSVfafI0fFsot7VjAZi4M2TVmVVobDyOWDwkgle+9/zB+qBbQIQja2PBwoOlecRe5ucAWz7/w92KygV8UYWqDE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987279; c=relaxed/simple;
	bh=CSt7lpvHgv01W/xOxpH3qAJfS1ZPwKjffh8W9kbBTzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj/mvIDMr81hyMS870tgqJx4fawW8QPnEPwTzxqjPUjcySIT//eQ3y+1qq+72++nZ8lEgxWgiZ/Y7uK3CSCXjEhJ+GrZSJwnB7hm+FQysxqnOSGnmgZJwpgTWZjASiFcm4dHE5eZ3VwcsoezkhoS/UWvhWEeTwf3FPMv8iERatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pUmTt/D; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so9645a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719987276; x=1720592076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9BRI3VL+FnVFgKLMKQtHesxyg+ZB7RxOJjtvrdfb3E=;
        b=1pUmTt/DIJBTz0wr6bKrwrwfzLvIgR47rDOIs1quS9ZwWAkocGIlLc9L17YtUbRpQd
         0NcsXJZsFgask2JjRcDCB6geg87c99kjLlo8TBPQve4l2x7wDfmLXd84KGkis2Mm4SMX
         OHDQHA3g8dGRw33cLRDjo6PHyJUFw1J0UaXGEtk8cKyqIQ6FAx2qAMq6PQCEFPA5SCcL
         Ra/4PCK05/D6bPZOktHXbvExQtJ4UcLaFlrERGQeTc44Xx0YeL8YbpCfjDl73kTe4ob+
         WT+LzWaluStlF2avPyhzXU6y2KiSjwAZwDwW6SwUBLj1oUz07i9lU2lJXUP272llGgKw
         kRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719987276; x=1720592076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9BRI3VL+FnVFgKLMKQtHesxyg+ZB7RxOJjtvrdfb3E=;
        b=m3N0HWqCasU5nBrqZHdk2ZcDL+xNqHcUQdBrokMjIbT31ftdVEL1Dq1VhkobYNyHzn
         NUyqWaPzKulSo4UjOjVWuXLgAijENpvV+CKBVUJvn6rI228v8OEM7wTwcHb8Z2jKzTap
         /4KpfJk9ZuwuIZOMXi9MmZYCm3+d08N2qAvBL1Q//ouos07guvmwqSU4UbN7/KKdaokm
         NYUqAk450snq1iXcDO187g4OIdAdaUoCZvdqeueNo8/B35wi/2I1VXhe+9c6L6Nbk/fc
         TbSpgw4Da8vjoiPEQ7cVi33WMV+IO/aKS/Nqd1/AIlmNxbz0lSiH9GpNd0cLYNgmMX/0
         eTDw==
X-Forwarded-Encrypted: i=1; AJvYcCVd3d+ebyO1+ahSDHoAxZ3+kFNFbf1eWd1jMm0F80ZJzEqVp65Yby/gBjTJ4VDzwQ19KcfNxKCtGq4yySTC5A3dZTFnz3uQ
X-Gm-Message-State: AOJu0Yxdfm7eqFWi11koCscHq+/ijVC3xfmVo+QBTyYQOvIbRdmzqNGo
	v9FYCjPk7VhIJuP9ac7vvtHlwmKmQbxwb7LGbPQHUTdUxueKvlqMN8aD6uOT36p3KIWNTCnTolg
	/KBJF720TKXlSu0dwTVe5ASETb7wUc/qw40gl
X-Google-Smtp-Source: AGHT+IHVkfjMkSoQGf5h0HkN2b1/pqlVu04i1pywUOqMlSGKmIZOEqmK7u0eiKEkVsdBokrNpX/OnoEBL+BgrL+dp18=
X-Received: by 2002:a50:c346:0:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-58cbd48d275mr113013a12.3.1719987275858; Tue, 02 Jul 2024
 23:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703033508.6321-1-kuniyu@amazon.com>
In-Reply-To: <20240703033508.6321-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jul 2024 08:14:24 +0200
Message-ID: <CANn89iK2NJSvyEQWiw-C5oAF4mCJjAeXbUOzBDQCBdeWSAC6cg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for
 TCP AO.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:35=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> When we process segments with TCP AO, we don't check it in
> tcp_parse_options().  Thus, opt_rx->saw_unknown is set to 1,
> which unconditionally triggers the BPF TCP option parser.
>
> Let's avoid the unnecessary BPF invocation.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

