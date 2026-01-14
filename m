Return-Path: <netdev+bounces-249896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C0D20805
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E7EC30056EA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A8D2EACF2;
	Wed, 14 Jan 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTqMIE1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE82F12C9
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410942; cv=pass; b=DuP7qYX0EPDzDTOHviHYLD7AmVj5WHNzVi9L7gU5oe4mbAL+5Su89hHaIDnzkKQXPoRyScsmgrLR5vXoGWxyCRSMeGfQpymSbqX1Z1nCp3nVyQjiVU7oGzN18sHawE5dqzU2afYtqUKGiVUXo+1DQptzOY7YntEkeFNY5S+Lj3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410942; c=relaxed/simple;
	bh=HdyTuEAotX0wcLgrvzzp/lj5vQP08kw/k1tLhAdsuVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNPe0DVgpWSrt/vhd7ZjJqvb5Ccgj3HQHm1hDVEgbD3TEN6+dFFIY4FA5fiMqbgXgU1pudJYfswZfC/pMR9KgkBCLm07LDhkSQreahQ+rziND2LzJBDif4bRMrv3Nf9lujutq6Z7LmvAip2Ngwk0ny/QAaiBE97bgu+PMisWtTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTqMIE1A; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501511aa012so277161cf.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:15:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768410940; cv=none;
        d=google.com; s=arc-20240605;
        b=I1sgJCBscJVJ5DyRxIHvxsuSHgRoPU1ukJlxZ1zaNY577yDQiZi5opRT4jbWSRXykO
         NM8CDHliCAPeZLI3wwhJXdt0Nfvs3yeXFzRXG7a+0XzUyaYXolnMmtMxAgnbys4gTEAy
         kIR7oLZf4Y7DdHkGm8TpY7+qDEbifmkffXROHA35dixoCW7BAzfnayBn7P7dZlzdb8hr
         C9iXAjNVEEuOJcv7Seq7wpUm2ZeV2kg+Wk7yZg4A0Csxd0Slxm+ZaCI4/h0GZWGI9bVm
         3o4GasIcsT2vbGas2ZzwTtPsW5gr5St5NWMHlCcwiqO3RCxik6V13tZ1YnhSa3h9yCh7
         XEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdyTuEAotX0wcLgrvzzp/lj5vQP08kw/k1tLhAdsuVE=;
        fh=V3jpeFn+KkG8z9s8b3vVO6uMeZ2dJ8I0/k3jM3cO/4c=;
        b=eRj7U4xJIWCX/mT+xDyq47iHDzF7Nwn+1QnyQekRS7Ncu+hkLShKjZ0ZwYNJz5a4mX
         Ny3vnl4ijqHYj/Px9gryTbLwIYjYQ9eKtSVxPE+oN0a+7Y6fn7PtHAbpoOKbs6p9lAMk
         o6x6WCefACAv4LZ8BDc/07qPQ220Knjk+papx0puoVyBzf4/vZ4kFtHFdAOYAHpHrbdw
         b5ZIkj9D7g6i8jRHV/d5fXwXtaejzb543uwoGhmkcgUhhrocKw9+OR9UfSaAEKpIb1Ko
         7PKY8x95ohZFIJsgam9izMFFgBtDOJxQ73FQQn717vymLJVKuAV74651FZ/VU0lW0LUf
         MJfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768410940; x=1769015740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdyTuEAotX0wcLgrvzzp/lj5vQP08kw/k1tLhAdsuVE=;
        b=ZTqMIE1A9JdwALtFd7bFiGE7/OjPSB3CVbH1f+8e0Hq2RJpbBR1mBJCVhAjFa78D+f
         8g3pwHWc9bbcfG/g+vpwmONOMc4oGhmoAHJSSMBVB9nhAqQbxrOYgfRalV78c2499DNY
         oslJpZuc5vstyXiE5crp/5Qmukv/FcNYFdxXrI0UQDYllERk1OZlI/iXkE4fQ/vo+lli
         yVzO0LJqNxSHKl3mk22HTRvhaTaUwPRYbjHACad1k0Ggfx5ziF2SHAqmGL24aYeiL4w5
         56ZIzLkUOrQ3OpAnswJGPBr5E++OW9JoWCnYoxLTOAZd1wfi+SJHmdnzJqQQHQtjHgxf
         8QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410940; x=1769015740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HdyTuEAotX0wcLgrvzzp/lj5vQP08kw/k1tLhAdsuVE=;
        b=QeHzYsSQmA2+Yrmu7cNkHWcReKI/+7Uh11M8RcRR8hlCfkmBOsrPjrLY7QBCL02E+W
         AJFibTiA9ZGitGvh2GKtwQiRJXvmOtQfVqJyCt1y56PwRtQCOSSeoxn46kR7pvSaLwBX
         aFEMtKZc7I7JzN1cSKK+kFVymUQacawfjq1D4Drk8Y9ZciyjQKlHjH6w7GQGNJYelM7k
         XQy786EkrGUWm0RT/IUlWbaLloEK21s3VQb1K3l3ynnQ5M9Y/7b4sA3Qg7HRLFpYiuvV
         vwcX0h1JsjGksPWTA6si1yPqzqHvj3Jk04WCYPYkf5wc+eqapbTsxRaBClUxalPg9MCe
         PICw==
X-Forwarded-Encrypted: i=1; AJvYcCU0crcigexX0jmMgJ45BOPgwvrqBy0eHKcPOBYB8B5Qo18UDy5aEByo7TPumrpxPBrehdI6nmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvH3I2r0fJ80htZecs3QivZeEumP9Wn+DQoMEUPFEld1lO8PBC
	6bxZkDThQ18+kaUQDksLH0361MY7F/vWw1JjKoJB8r4Ncu6ygI/TL0VH2/OPXvLPcu0TAjyXNVm
	w95xgyZm6qvWlnWoDyeQ9EEoQSAyAcQad3KeL2PHQ
X-Gm-Gg: AY/fxX4GkDLhmj7IoE9vseLCPhycaDmonnY5vDsbUvcez4Demoq/Tq5nC8pzEttijUj
	+iKGlxoiPKVF7PhkEpsoIIoiwf5P9WNPKRbclKzalPbDwei9DmFwmdDbZKnM+BJTNi8w11QTEWk
	83uJ5liL2HGSSEF8lV6Rh6VdbUGWgwNV2OrqfqavpSZ1crKtiIgtw62WUpq8bHUq79yiNftYffQ
	YEr9H3cP/4Y4AfY+wJJ0GuaFXsTdLubqvZYOfv6C3Si7n9xQmzVSPNlX9bw4KYqesx73dn9YGUd
	UbW20sORyOBjRA+zNPm+VbldvMNUTJu0ZD76p0DD3z1IDWu6SBMxmR5A0KDGutVnK9ZYCvQ=
X-Received: by 2002:ac8:5988:0:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-50149325305mr10925241cf.7.1768410939800; Wed, 14 Jan 2026
 09:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114165109.1747722-1-edumazet@google.com>
In-Reply-To: <20260114165109.1747722-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 14 Jan 2026 12:15:22 -0500
X-Gm-Features: AZwV_Qjwf_z582aHgT9WVbMI_iDP_zv7S7eSdlXsXD4S2mbmc6IssPXMuL4HJ6s
Message-ID: <CADVnQy=_oWWBwFBmn9pPn_VK5qJ-y5uVSwXn01XJJYCOJP=3gw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tcp_rate_skb_sent() to tcp_output.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> It is only called from __tcp_transmit_skb() and __tcp_retransmit_skb().
>
> Move it in tcp_output.c and make it static.
>
> clang compiler is now able to inline it from __tcp_transmit_skb().
>
> gcc compiler inlines it in the two callers, which is also fine.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

