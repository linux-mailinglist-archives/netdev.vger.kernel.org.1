Return-Path: <netdev+bounces-227037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B92BA761A
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 20:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A5C1896D39
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460525742F;
	Sun, 28 Sep 2025 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8RmB3qr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427E257427
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759083012; cv=none; b=PA7psX1cRJhAtzyuUVkWfMg2L8FpJKynJdaYJBDKvNI/bOlQRt11lWVaav3sL84z9UQ+gA3ITRYIXn56aAbG2rwFGACSlXO6W2Y8lzzKMqmBNBiMxWFhTCXoxLFBCS97iqGFotqTaWCzUBhJuT8QM6ooqcYjRCNbWDodvv/+EEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759083012; c=relaxed/simple;
	bh=+CUlIv2tJgaDjp2T8Z8V+87V5mhm9dfMY3CWEK1jm3g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YDR3ranq2A/JCyhaKy+D+qLW2PH2KAPxhSaiMwqRwpuM9GqZ+nKad7YbE0b0O2tP8jM/SgfG7TjyoTBv++UJlLNkPkpcMHg2r5v8w9bmUnlhgihV7EFxMqVhi1iLS4NVVIGz4qX6JxlZVXDauah3LzY7E0Km3LKBRqxe4TKBLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8RmB3qr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso4472336137.2
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759083009; x=1759687809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVyB3D5UGLr+TiUHsl3383ICu4lsIt3etfBmLSzfWN8=;
        b=D8RmB3qr6jEapcbx2VH54aSU8xIBlBh1eUoHrWBkGtMo1fb5pE4oDA6C5toQOvl7TJ
         z4PfAzpmqJEaQHmpqcy2s9TrrAfp/Nsra2WTGb+hwu3L0G92Yw1kOznJiREsTF1I48p7
         TW6Mma38m6RzpDV83ioFBJmilK/obUc0WXK7jlbnDdVdiVzgRyQK+tyKrrZnv0vqvl2F
         rWvyGE6Xb/hWjdz0QuOUPAQMvfWFJXyVOF/a5Yuyc+kaegwZ1p3JNAjKZkAD9BmobtPs
         3Z5uacvRekEuL+bZ0JojT0gg+srGgbCKvJTvtc6Ssbr+gXvGqYl3SiA1c6CcdAX1OL1l
         Kfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759083009; x=1759687809;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVyB3D5UGLr+TiUHsl3383ICu4lsIt3etfBmLSzfWN8=;
        b=k+p8x9uddtJwi0osg7sdx0SYBdxHcbS6YoUvgZ1dx3Bx9OBE4/EBruEJTLPbQ5WVwe
         b+eh3yK/8auBdb7qR+c1TaA5ha38XpuM7MBMlX+OSe3AofvvEBoQv5uD+v2gsjP8zmiU
         RFUjOoQNYmbdeTaeh95jL6WY2JM9zCeQDQ4FpDzaXPCw43V/0X5PBbaauoAkSsxiLk/D
         boj1vH+Syi/7fkkcODjMdCefStkOvMmv1YikraZ2Hwj8W/IVYy8pbn4pHdEo9flR399c
         aGuRs3MGH3GEAb127q6JibydMTBkfjQgAS9TJYGjNJR2GA6rDdiYexaCrW00vlsM9Ckx
         m9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWddKMHZFxfKWRLw8oBqfUhivksvq/PPBZla7E6iSb1TSZ1g8bI4k7paa8P9IeXyjOGLzlPyrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUpL2sS9dwd5OWQgWGv3TF5EGqpl5l26ocVPLbT3Mm3rWZUV5
	hPueDypYHcrsIP/v3CblfAAq3LMw6/bMuxeUHA/oaahMN2qlp6/pghb2
X-Gm-Gg: ASbGncsp7Ei60NPKmzKOUTKrUnQ3jz69gisfldgNzw5ZFE2QfESkTPr2rPnVC1rcuOw
	KLuaR888UjgR+I03deLX02/bo7RrM6TSi1N04zYCTq/XI6NawB3QuLwNdAGaaETZXC/c00Yx0Jx
	wMWL2HucBwOIw/sJrZr54qSmXHgFO9iUIKheXm4Z3e+eMyKamORDcMH5lrLtUDnEp0LufqOx5OU
	2pWsiYzyFQ7Z0vZtLjP1XfgpmoGOvQHSZwnRiKTDzxcYbxFyuF07MfKQB9z8fCHrQOebGWLQbXG
	Eh/WIPEHoHjbUvkOJILdcxjkHYFisoc1vvX+KzV9a6rDsB1SW7fd3WWlEgRrYKIs5jA1L6q4sZY
	q217q85BCIrvX+GjXfMHaYVNyu7IzaAYKIcY8iqjVeqQ1uJXzj49feGPVY1XhMR9xyscj9Vaq/F
	S2ZpK2
X-Google-Smtp-Source: AGHT+IHuEWDDcGYlcIV74kofBGR+2+YNmk8RPXwNqTCd3PEorNXRjwS0HYyR5uGk6n3GaT3EdqRwng==
X-Received: by 2002:a05:6102:d89:b0:533:ff66:696d with SMTP id ada2fe7eead31-5acd15c4e26mr3368098137.23.1759083008811;
        Sun, 28 Sep 2025 11:10:08 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5ae302edafasm2827250137.4.2025.09.28.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 11:10:08 -0700 (PDT)
Date: Sun, 28 Sep 2025 14:10:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2e545b6e6e601@gmail.com>
In-Reply-To: <20250927213022.1850048-4-kuniyu@google.com>
References: <20250927213022.1850048-1-kuniyu@google.com>
 <20250927213022.1850048-4-kuniyu@google.com>
Subject: Re: [PATCH v2 net-next 03/13] selftest: packetdrill: Define common
 TCP Fast Open cookie.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> TCP Fast Open cookie is generated in __tcp_fastopen_cookie_gen_cipher().
> 
> The cookie value is generated from src/dst IPs and a key configured by
> setsockopt(TCP_FASTOPEN_KEY) or net.ipv4.tcp_fastopen_key.
> 
> The default.sh sets net.ipv4.tcp_fastopen_key, and the original packetdrill
> defines the corresponding cookie as TFO_COOKIE in run_all.py. [0]

tiny, not reason for respin: no link [0].

> Then, each test does not need to care about the value, and we can easily
> update TFO_COOKIE in case __tcp_fastopen_cookie_gen_cipher() changes the
> algorithm.
> 
> However, some tests use the bare hex value for specific IPv4 addresses
> and do not support IPv6.
> 
> Let's define the same TFO_COOKIE in ksft_runner.sh.
> 
> We will replace such bare hex values with TFO_COOKIE except for a single
> test for setsockopt(TCP_FASTOPEN_KEY).
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

