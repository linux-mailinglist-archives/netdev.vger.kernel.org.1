Return-Path: <netdev+bounces-140758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66CE9B7E3E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFBC283FF1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172D19DFAB;
	Thu, 31 Oct 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rva0xk8r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD8127B56
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388136; cv=none; b=gaE8HZ3JOpd7/HLV1jRgRDaBuC+2RNsgK/uq6lshOzBNgpRgLW9Gekt+lxntPyMBBWxmtZY65D9Q5GReVbl/a66Q7KXblx/nFUwXBEOWpPoVJNgm7lYzb+JUb0dVoDPN/zCCeMHudDNh0/WKEqPY0V6c6btdcP5htYrTkXsgJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388136; c=relaxed/simple;
	bh=Htn84sImGSSwntmcqyR+CCMswiSrziL9amxfBmUmm/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwekq5nmwHJIKmI6c+mnEfAx131CEh6ouqF+1yHyg06RnjoqkRhRBZAE56/ri1W8leDiUbgHT5lhCyg0+e9SgZDwl+jgs+h2r9ZXB5sA9I02A5wxYpi0VJuHxmWlYBLVi11wNCsePLD37h+LFG5kyRnkqw/Jbw2Z4B9miZuvkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rva0xk8r; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e6089a1d39so546346b6e.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730388134; x=1730992934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Htn84sImGSSwntmcqyR+CCMswiSrziL9amxfBmUmm/c=;
        b=Rva0xk8rP/wP9Ou948QeyNO9kfD0iUsFRhHUmzL61B9GgXUoCv4idOSFg2ZbZHhyo3
         LaVIEAH70g4WplHJjgz9Z6k2Jlf19/kiYk4DG9h3qJ3RB+ZZP4AuudXXRbhXYVLeYho+
         aHBGYkfbmMznYkSmyGHlPElq1wA++FHQnqDAKoVVgWrIjlub7pa7axrLu6XEPahjik4V
         T1IAyUtTpfbAbaJHbvgK6sAzP0JommYRoKoBOv2LBfTMW0NR9ttVBEsAN3av5K4Fz4b/
         YdVQXRPuT4lXaExFLhpiLLasWcTOnS4UKNcLFnMn9K14eOE8SQ3ShyINn7z9zDzukqUW
         TKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388134; x=1730992934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Htn84sImGSSwntmcqyR+CCMswiSrziL9amxfBmUmm/c=;
        b=oUBKnkZf8UAUXTOKJ0Oo7cQXbFh9MCKuAUjiusWPqCJ1JNjI2FUMrEi0jH+NZOtu4M
         Xuw/uVS/x8Y8xYvYiRVoqhagTZTA3ZIaISq35b07UOVf5/W1x0OwKQy/B8eR7I/Uua1G
         U3K+MsFtBbxB16T/JMZTveMevEjlvV6juu0a5+Acw1DCOt3ajhxRM0+httgI8Sx5sCVo
         UJajQX6w8hyaLzpDpsnqkjw8Y0yZzNj5Ox/Hp4t8iUDDK6D58TyMfbOtWkvFSqXV6avM
         DN8yXE2GdKaDkj0ImJ6s1uj9YmBzLqLMqD5h1Dfonc7ZDZlNsslIkXeTRxQhMk0Kr5ku
         6eVw==
X-Forwarded-Encrypted: i=1; AJvYcCWhkDg1ImkzIdg0FXtqmlAaevxFCPiwt9xb2bmfaxf1hcx5Pmuwb5G7bcuFBvpNoRq5HGNwyeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQAANKOnOBBu3uihEfP9MsfBbMj9Za7bySCXBbORoRk85hTSl
	dQZ1iRfASyqk206j+L7MDfxuYAyy8HaaMvEURlvvFCkwHBhdSDf6feEJG77jMBoZ3pJ26vEHEKH
	LZFR3li3oPem5X4UmG/7gjFp2YBY=
X-Google-Smtp-Source: AGHT+IHLLBqJ9JW5lY/ucNM+7kxX0n/aCVQYbZZMGhtkSZ83tk2qgjpaanxk5/tyOnsNePlTzAPmyWQmJQD3KCMQYXQ=
X-Received: by 2002:a05:6808:2223:b0:3e5:f06f:653d with SMTP id
 5614622812f47-3e758c32581mr170701b6e.22.1730388133791; Thu, 31 Oct 2024
 08:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024093742.87681-1-laoar.shao@gmail.com> <20241024093742.87681-3-laoar.shao@gmail.com>
 <a4797bfc-73c3-44ca-bda2-8ad232d63d7e@app.fastmail.com> <CALOAHbDgfcc9XPmsw=2KkBQs4EUOQHH4dFVC=zGMfxfFDAEa-Q@mail.gmail.com>
 <6162222b-0a2e-4fb7-b605-c57fa8420bc9@redhat.com>
In-Reply-To: <6162222b-0a2e-4fb7-b605-c57fa8420bc9@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 31 Oct 2024 23:21:36 +0800
Message-ID: <CALOAHbC2emaruOaJFa3whyGDUf+bgY5W3bYKvfET-DJCizSkMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Eric Dumazet <edumazet@google.com>, 
	David Miller <davem@davemloft.net>, dsahern@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 10:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Hi,
>
> On 10/25/24 07:58, Yafang Shao wrote:
> > On Fri, Oct 25, 2024 at 4:57=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> >> On Thu, Oct 24, 2024, at 2:37 AM, Yafang Shao wrote:
> >>> We previously hooked the tcp_drop_reason() function using BPF to moni=
tor
> >>> TCP drop reasons. However, after upgrading our compiler from GCC 9 to=
 GCC
> >>> 11, tcp_drop_reason() is now inlined, preventing us from hooking into=
 it.
> >>> To address this, it would be beneficial to make noinline explicitly f=
or
> >>> tracing.
> >>
> >> It looks like kfree_skb() tracepoint has rx_sk field now. Added in
> >> c53795d48ee8 ("net: add rx_sk to trace_kfree_skb").
> >
> > This commit is helpful. Thank you for providing the information. I
> > plan to backport it to our local kernel.
> >
> >>
> >> Between sk and skb, is there enough information to monitor TCP drops?
> >> Or do you need something particular about tcp_drop_reason()?
> >
> > There's nothing else specific to mention. The @rx_sk introduced in the
> > commit you referred to will be beneficial to us.
>
> The implications of the above statement are not clear to me. Do you mean
> this patchset is not needed anymore?

The introduction of a dedicated tcp_drop_reason() function is intended
to enhance the traceability of TCP drops for the user, providing more
convenient and detailed insights. Additionally, since
tcp_drop_reason() does not impact the critical path, marking it as
noinline is acceptable. For these reasons, I believe this patchset
remains necessary.

--=20
Regards
Yafang

