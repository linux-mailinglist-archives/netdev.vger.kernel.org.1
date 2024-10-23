Return-Path: <netdev+bounces-138303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C949ACEA6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223C01C25263
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DB1C0DCB;
	Wed, 23 Oct 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fx7WFV/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCD7404E
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697060; cv=none; b=C6Ti6C0IjDYlNM5Tel8SuB9QgiJeWgIRwdIdMYOtdLd6BoY3GcX3ZGkWtDB5LEz2NrZXQkhNTotCvciLSVRMmWCcWrGwyC/mBFPXE++UiLXmhxaicmojlOA91mvaJRA5JTUJdcdCtyxs9G/CmvMswxZGEEkJc7gcyhTw6W0NjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697060; c=relaxed/simple;
	bh=/d8mQ7xVNAKSKvEEfGEsgySixoUc+DJYInLlhHJSjGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqX7YmNk0tk6e/TGAz8klL3wcD8NcYT8oUsA1FKSGYEo7NiCJwBTr2t9tPTZwcSzhz8pGaVt3VT4fzlU50ArxMGiCuiCJZmYRGQKKAWz5BpIhGUi1e4CCTgGzDYtrkk3d66LG5OF+V56gXjpsBfxP5wGgrRw4JDoZ7Y6+u9zSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fx7WFV/I; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1118438a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697057; x=1730301857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d8mQ7xVNAKSKvEEfGEsgySixoUc+DJYInLlhHJSjGI=;
        b=fx7WFV/IMiDiwKjh97wr2GoZPSyRusil51hiLXlt650cIzpUjalknwVNnx0w8bJ+UC
         pxUcKjjZXIDQ0KmpEdyVvxC7o6XhO9VBid7oVqIcFnFi6I3aCXDXl2Z2JM9EltEdSPIB
         eF5NXIW2uPgnThLeZ4ICxE71xj2B/gPsweLHnfH6RemFna5aLOi8ckuBWa/9lP1EoVCf
         aY+pD6ug2V4CSWWhZJRPg1Zphf1aO3x65ZTmDSt8xcjlu7vraPom0OnzrGHhltS0TzNS
         OExTe3b/w4UmcXZaVhZWVKnbHdN6yfqXFKogJRswZm3Hg5MOnvcRybAekqdO5D2zUSDo
         g/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697057; x=1730301857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d8mQ7xVNAKSKvEEfGEsgySixoUc+DJYInLlhHJSjGI=;
        b=A0lRsT/CeWSKvnByOJ2XRkc6xvSvxaPTVCzwfyxj5Y6mUDprlbd7TqsO/KqPAHmNxw
         GIOQJE8EzonIAxO8+VCuTl7KJX34ucIxJmNzZlQWnSe2+GZBDZSjvIiHmZWNbARjU/Fx
         hUPXs0JqJmgQ3+uvsdbXcRpziz/UXwWyrQQoguHJ13uZcEKqsrfmhYR9LvycUlKKThF4
         KR9QHU8LEnpRq5ibgQTN0lDb71IYJNrkyBNvSXRx/WIhA+v37fR4uKc1Yl2yo3oYlR4+
         vBE6hipvNxH6DLN1aYfV7kdPL2I3J9/KykWsIa9ccuDMUFEpegy+swY63K9/HlmLqpwi
         ldQA==
X-Forwarded-Encrypted: i=1; AJvYcCWiPt1t5rlRCvbB9XAXrzIAuevM1Nf6vKHM576Lxid4gVUnGXVTGqv16uMj8BR/o4yclLjcH6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx610CZ0/ApNn0VAGCA4Ib55oOagCv6gvgAd48lnhM1UozX+h5N
	7Uzbl9mW5+9SYIKnUss/qw9+m5hEqo9A8Kx69x2SHKLCTZnK/D23Nv8L1KvjfGg/C7/lkFvnR++
	8pQvLd7JHN+qvOThRYlKUvRSMOpwkWGGXDEON
X-Google-Smtp-Source: AGHT+IE9hnwfLsL8BbZMTYL902Xhdsvw7jSzJW8meSaRdqvyE+rycMlz7aXE5fhuDEt7NGDYuf8E8mvv7qPzv80e5Js=
X-Received: by 2002:a05:6402:35c2:b0:5c9:3070:701e with SMTP id
 4fb4d7f45d1cf-5cb794670eemr7995638a12.9.1729697056957; Wed, 23 Oct 2024
 08:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-2-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:24:03 +0200
Message-ID: <CANn89iJp74yM6D9Wu52CyYKundM0__X-+izoXi6OPEuX_61wNw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/9] phonet: Pass ifindex to fill_addr().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will convert addr_doit() and getaddr_dumpit() to RCU, both
> of which call fill_addr().
>
> The former will call phonet_address_notify() outside of RCU
> due to GFP_KERNEL, so dev will not be available in fill_addr().
>
> Let's pass ifindex directly to fill_addr().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

