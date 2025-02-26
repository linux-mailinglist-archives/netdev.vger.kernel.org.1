Return-Path: <netdev+bounces-169809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45AA45CBF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E95D1895822
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64009211A35;
	Wed, 26 Feb 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLXTTDzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7E1F8908
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568266; cv=none; b=B5oGANj4kMfJCrgMPZTezys0ZtnMyV7JZU18neDj+7cynpmdC532rv2kQ/HgbZBFfyMJYernpbaWpWfjF8kL3w4BaFkO2oWoUjiX3MUiPfZJvkK4fi81X3zW58OMFFcEX/aPk9Exiq2YNkQrNLw6Y2fB2G6L/b3DFU0fjT8AwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568266; c=relaxed/simple;
	bh=aimJ1vO4DLmwB64fsnc7q0WuL+dLLa3r01ApCckGdu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvqPbmq75rFkeXBeBehcjkGPVg/O/eiJNI8gXc7yztlpzZsZQMtsBxgUAna0UapvRRP0NV5T5Eti6cDaph8I+01FQuzFHwDY9cHQ7LDcF2XXrKtDZzP4WMA4QPQdXgpEhjMEnNk6RR3/efuCZo7iQSEJLvZAcJ544tY6BtWk6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLXTTDzL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso10855686a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568263; x=1741173063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aimJ1vO4DLmwB64fsnc7q0WuL+dLLa3r01ApCckGdu8=;
        b=eLXTTDzL7rrQFfElu7kCWTFDgw1rznTsheMeGnpN5Gl4+NuE/VbLFQ1UM0HR8vk50j
         c1xBe6OkSv0RhTB99Nl7lFGMmKSnUth+shFObCPwVrcmtY+aEQ2l0nRPpz+1DvvwqVoz
         V/x5NEn7TxOrUB24peRl5xatM+CUDo7nwl0QbxVvWF5wSaL59XFgObhi7OeJjmQZzec/
         BoCLp2v0tGgNoAhbtTnuv2hcIhAfVWt196qlXVhKtFUHFyVz9EMoP12+V6la+8IKYSz9
         5yL7BFayjxA21weHRZ2v/bBv7O1y2TvYSmhWxZ8CK4ckzlIU2hjEYnLLZYcBsePSzwHR
         HD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568263; x=1741173063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aimJ1vO4DLmwB64fsnc7q0WuL+dLLa3r01ApCckGdu8=;
        b=H7vEGLu2HC0RaWrJ7n2F8tO4ZdlVqnue7kLNZBoMStcHj7ABv7EM3pIu0A3lb7AMF0
         AOxGBYNs+abqmlgbgDn3Lr4mc9giIoOnQUxDOQ+dcqZVLYmtN6IEteX5zlXMflJO1z2F
         wldS2A6dnBRP+p6GMS5PNwqnspXRP9emFh1ZW++TC0GWdNAc5JaZ1f7Sfq+QNe8OwKMW
         xcOY+hqbX/WO/vtj6d652YPIPlgM0PmYf0KHYIhjNdfPnscOU8eqBiyhE5QDPAnGquzW
         SNx9O4x0tiFjXA/pkHEZg1kTWZBHQQsiNPz8E3RAL4H7725dcvRaom72L49+BCzUgAyY
         lxIg==
X-Forwarded-Encrypted: i=1; AJvYcCVFGVIH9dVp1y7oZGPtucAent1VLHIFGCK5yz2zwRVip9mRa0MfVd+CFQBNDSolicKsa+K+aL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZKbDX4+MzY6nBiPNgj6TIxmsrm+dyx5hEKxL4J/LOD5YuIpm
	FXAJf6OJ6HK20+No62DDMkqLIZIGw47SLEJLLoVBiXC4zBXxIN8uCozCwF6u/mXisBg9kAEb0pX
	aNXz3UP9EOcgL1GbdjvmfLT2E1wDhTCmajG1V
X-Gm-Gg: ASbGnctlprKZKJE/pMHGGv3qWQUlG0kY2W0GDqFJy8cnVC+s2jpfMdi+XwAx4MXmI+6
	qaBGTKvvjIqYnSUE9T++EX/aBc6ORkHXFiTeGSDvfE3k+eqLe90+nY3oVTcDFnY0pGmavS2aDqZ
	8Wvp+pEtA=
X-Google-Smtp-Source: AGHT+IETArfCi9ncVMo8/AhirhzuY9DmeTvanVTjK7VPgR9JEuKGAH66JvuO3xZ0GLmL8ZaUIo68kQbXYCrFxYmXg1s=
X-Received: by 2002:a05:6402:2b95:b0:5dc:7725:a0e0 with SMTP id
 4fb4d7f45d1cf-5e4a0d830eemr3169983a12.15.1740568262801; Wed, 26 Feb 2025
 03:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-4-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:10:51 +0100
X-Gm-Features: AQ5f1JoZq4Ur33ysxAZ6WEW012jQ2Mfclb8BV05A7avrBBavlQYBA1UMy6KB3Jo
Message-ID: <CANn89iKyJBbyR=Ev8=Op-hy+oqhSV+SifLF+DTJ4xiX4JGng3Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/12] ipv4: fib: Allocate fib_info_hash[]
 during netns initialisation.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:24=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will allocate fib_info_hash[] and fib_info_laddrhash[] for each netns.
>
> Currently, fib_info_hash[] is allocated when the first route is added.
>
> Let's move the first allocation to a new __net_init function.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

