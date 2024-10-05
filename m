Return-Path: <netdev+bounces-132350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C2199153A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3774C1C21617
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0460DCF;
	Sat,  5 Oct 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeBt8Z6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326113B298
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116198; cv=none; b=TWJf6wa5ovb/lP+m32TDrmNmkiCQY5j0dKUx995YLUyN+JeGs2Q+43EPaYe7MAuoF5etpn2dQoCIF/IVzR/IknRAzVlo9GDGlDJNfEo3kj04vEoK+x8xKhXxDm5YXx+nVchOKKfJrWqiK1SqBIFPLwyVHuKuKr+MyRaygu3jtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116198; c=relaxed/simple;
	bh=Pl0BtdadHpWAA8SsDdgZOBIE6xqwUBoXkleFUQz0ZdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmdHNwoylFH0hR9bN/aW2IUDWu06Nyks07GcnWqdHWDQ6HBhlC4uhbHzuEX/n4sAei2/s8moH3+N2izVjzza3MXTLVYUkxITHSFI+z/uOLEF4YuJJNbkE49RdA5yocFCr9BWRzqI9WpL5KmhFx5X9+l4EGxt3U9XdtvuixlTJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeBt8Z6W; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so6973541a12.1
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728116195; x=1728720995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO6Frw9MvOOVLHrRh84ktWiEtvkHeghjnmbmBx3/eh8=;
        b=JeBt8Z6W7rBfBYVp5TN+LhzCbHM5BlTHK5ca5pQov4s+wgZ90xonx6/WAExZlfJWsr
         oNQB5BigHpU+0bFZrc456T5KH4Q6raBy5RdfU7wrHhRTMBq42fnCeUFMHiy62mIIq7KT
         eulDUWd107KSrWZrtxHEVQdf5F5Ea9LEaO7kFx3yrC3O/aXbTByjJlHqaBltr4oQBEO3
         6rHWa55Wkaob99linN9wlTPr0PyaCpYv1kKl3huPI7MVRfXUx7RU8fu8bj8dpM/6kQVo
         +49yvuUubDaRmOpCI1yYtPGC+wjNZqengEvvgNctpvUa5w7uSs7f3RQK4Ih1VFvhAliv
         I9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116195; x=1728720995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO6Frw9MvOOVLHrRh84ktWiEtvkHeghjnmbmBx3/eh8=;
        b=N7MyDOr1MWFZ44xmLJkIABeKxvHbS93GF0Hm/rIUcO17GOWz9DGiirsAsJsIorniEJ
         PwPJLvgIeVKUrf0mbExFSp6bUtFooNPUYaNI2pR5h/wfyHe2nX42xECaWnJIMst0IXV0
         oB5Vo0EtZ9WqcN2k5L+WfSgRKsTlLX83G7xVXQlwYi2v6wHV4PKpNk92LloinbwowXDc
         LrGa3hOnpjjnt7LytG7p3utE7W37+J1JaHuWDXvFvlHOa2HkRcdUlL1TA3uN3naVLU+j
         fhCiK5w58Z8+ZHKf5ByIJZeZh2sIiQ43arxKn0keK7TG7xRoR7Rdk3487k1aBFMGY4XL
         gzrg==
X-Forwarded-Encrypted: i=1; AJvYcCVM7RxchA3P3v0BcwGup9ZBoYwfyCuLFyjkxbQmihrf2o3UVqP262RI8qyiFK6bKMpsONGS9qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvE7syeqlz30jK2HIgVusdefsNmiPZ7x7HLYugKsuRkOnoYCj
	C1P6804KLWwS4ghKUrs4DW7YTE7Ku++flTYHqqMsQFjZEisKcSBBkVIPNgqpkHA1hoP4kM6lqXd
	pycUCyt11QfUIgLEaNP/lo+WbJY8yJDxU/BLy
X-Google-Smtp-Source: AGHT+IGWQjAyuzZ2RqgaehSft+fqSwWvNV3yn8hpj0wNnEGeF1D8dueRusZ8ye3mKIF1XXw+w6RV+dZD+iwLNdAxRK0=
X-Received: by 2002:a05:6402:35c4:b0:5c8:8844:7874 with SMTP id
 4fb4d7f45d1cf-5c8c0a1fe0emr9795167a12.10.1728116195284; Sat, 05 Oct 2024
 01:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004221031.77743-1-kuniyu@amazon.com> <20241004221031.77743-3-kuniyu@amazon.com>
In-Reply-To: <20241004221031.77743-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 5 Oct 2024 10:16:22 +0200
Message-ID: <CANn89iLYQLUXh7c1Yww30A-C-=4UiQtArU+jx+AMfYtW+_pn4w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/4] rtnetlink: Add per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:11=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> The goal is to break RTNL down into per-netns mutex.
>
> This patch adds per-netns mutex and its helper functions, rtnl_net_lock()
> and rtnl_net_unlock().
>
> rtnl_net_lock() acquires the global RTNL and per-netns RTNL mutex, and
> rtnl_net_unlock() releases them.
>
> We will replace 800+ rtnl_lock() with rtnl_net_lock() and finally removes
> rtnl_lock() in rtnl_net_lock().
>
> When we need to nest per-netns RTNL mutex, we will use __rtnl_net_lock(),
> and its locking order is defined by rtnl_net_lock_cmp_fn() as follows:
>
>   1. init_net is first
>   2. netns address ascending order
>
> Note that the conversion will be done under CONFIG_DEBUG_NET_SMALL_RTNL
> with LOCKDEP so that we can carefully add the extra mutex without slowing
> down RTNL operations during conversion.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

