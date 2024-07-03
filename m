Return-Path: <netdev+bounces-108986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3989266E6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444401F21E6A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E818309B;
	Wed,  3 Jul 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjHwhdaF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FE18308A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026978; cv=none; b=leJw8sK7lb+hx920N8gTINPBPFxsT21RV7m+xUPE41V+AAP4nwEPJt/Zy/g3GPMcmqmAzwlVtw7X4wrwXYIgoZ/yUb666ATmJi9QQr2NNoTlU5op0rnEcagnLkA4exhdFIFR2ommm/8l/1WRcWqxW8mYMoXXjsmLWkvePKtNkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026978; c=relaxed/simple;
	bh=PRe8+EhL+rdb6p2uTAxprA8wxWC20Q1arvRJ+g4zmqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEbOdYNmySIgIZMxRHk5/D2ithzZQR511Dy5R9rCm34Bn2qdhDvy3QihX7kCy4sWe90JJyqs9Z6DX8Ya0N1UBXz/cNrYeh1BMcHdeROxnxttajTnbnD6UZJKZz+iD5O0cDF4tK9xqv7jdSU6d7S2D1gLi8rQoP5RtYpD8aCYDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjHwhdaF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c980a9fe88so547001a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026977; x=1720631777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa7XnMj5RCKxWfhNwJQuri+ySkp7W4mLLv5DKR/LAz0=;
        b=TjHwhdaFAIeH6HymqhwOuNGijaOCqe6cupNJyKlfRRdMq9jbbf8PetCwKxdBehuJK0
         B4/glaT0O5ddUV7UqRvKzeqtLEZi/OrFljm+5Q9m+ir3R4tY2dhv4E8F46HHzfJb/D1Z
         gHEsK1j/hAF6vNp2cuoDiejldz6hOgTz44NV43R5Q0ITfbaGJxMrmuxuQReM7SUW+Pqj
         ZAkqIrxZ+Wege21WjI/Dc+1kn9aA4PpNrs5zfwVhBJdIcATTUqZ5wigGDcS+M4SSiwNV
         thWTAMtChRcZDA/AJZQe7RC4BS+x7GiQwitYk46Kd4a52XyVxIJURjVJ4O8znkJVtZii
         D9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026977; x=1720631777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa7XnMj5RCKxWfhNwJQuri+ySkp7W4mLLv5DKR/LAz0=;
        b=j4JvyxQn6nHNmVmbuvuuX+cZqzbHvENeTELjXszOTuE4vq4cdSGksv51TMwmidY+1k
         /OQGTXo0Oy0UpJ/9RBR+KSewXiUR8l1zYKBMEVDb8sqMB2MlJWn7I6kw+/mb4zkZwEdM
         Gm4IJVpnLbuWdkynyiODoko5yUO1yXsZrDopyj/Bj0YRvACIvAdjeXl+cMQnt8mNz6dM
         9Q8Ku0dJBdr6v/z6rxI8y9TkoFRP+o5oNDhmU0yGc9uEiXJQUcB3bcldnsdlOmr8sAIa
         G7f20n2sl6khZmu7zgL8a/9fSLRynNVDrA7BLxMKR9IM2818ldI7+m5P0nz2hixqmZb3
         296A==
X-Forwarded-Encrypted: i=1; AJvYcCUSrW8eEhcoIQ4a6HSd5vptI3DFR47ANj0v4I/hdXroCV5EyqJnML8nHfaXDg0gYNgUGC6VV1gp0GlQoNp0DRDix9ljOfCe
X-Gm-Message-State: AOJu0YyYGzi5N0YBcw9IdHYiZRziDIYp1xzIBUR+90s8pYJVSOj+tACe
	erzaLnLoDcO2N7rIXZK+41/+qo4L5dJVnIzWUiDcCSMoGEhiRIjnzCsIGH98OJL0SOwCas99COG
	obFyiJaozCqEaHQPb+9t0n7h3ykM=
X-Google-Smtp-Source: AGHT+IErU/gXyzZEBrm+Vjpu/rAq1ZKaUIaqOn7dfO95TsL9MGQSIVOY+d7OxYB8uD3W2G3ABq8NvhkJ2nQoLFbob6Y=
X-Received: by 2002:a17:90b:e18:b0:2c8:4f4e:d438 with SMTP id
 98e67ed59e1d1-2c97acd1d3cmr3674305a91.4.1720026976780; Wed, 03 Jul 2024
 10:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703033508.6321-1-kuniyu@amazon.com>
In-Reply-To: <20240703033508.6321-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 3 Jul 2024 18:16:05 +0100
Message-ID: <CAJwJo6bC0R5z0Ps-vfEwfUpXVVWOGcyFZLxm-dOtD8JULjaArw@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for
 TCP AO.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 04:35, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> When we process segments with TCP AO, we don't check it in
> tcp_parse_options().  Thus, opt_rx->saw_unknown is set to 1,
> which unconditionally triggers the BPF TCP option parser.
>
> Let's avoid the unnecessary BPF invocation.
>
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

LGTM, thanks!

Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>

-- 
             Dmitry

