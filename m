Return-Path: <netdev+bounces-75591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33586AA2A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B7C1C21769
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05BC2D05C;
	Wed, 28 Feb 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3z+o8C8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB92B9B7
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109286; cv=none; b=D2Kj5nBvGpkoSZcLpEiSGNnaqACaDHGEzOiTfX/npSusWsu6gocBXWKL/j9/Tpcd/8mj2qP1DKYWNbVd9ZNVt2RGHL+rIk96/G8eRUXvI8Vvx4oHDIW008khCgjk/zCIkiiplUfZZAgiI+cmFdcH+ouBuqexK9cKlhxgEFOrNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109286; c=relaxed/simple;
	bh=hVzO8DJLRvx8VnPcwVsHZHnSXEoZUjG0HAtQ7AVPr/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMcv29lfctkhTwmCHaWXLDD9GkV+0gltR2+WZ/GqIivgcEV+EJJL+3rNpMGU6h3asCU6Efmrv6WoVG+KwpsHarWu61KhEkUGwydaq/P5OHR2/ecGRKktocF9SzOCPcMq4S18gFApb56XvmKoVT3VwPJ2cK0RWtPVaKwRq6dWH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3z+o8C8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512fab8cc6aso1987e87.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 00:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709109283; x=1709714083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdn4dszK8dT2wFJDzc7KLdV8bKHSO3dOipQaUHsMF8I=;
        b=n3z+o8C8H7SYhsTZTJNJp7b7JEkQsmym95GKdCq8eeLnCelFqscEZXYt4mamLLwtFv
         xtKAgP52v/4cuf0GRYucXzkssv03M6C9sZEBiUm33MVNWt8e2pTDmBAFlHYDS17oMOjg
         ItQubavQ1O3a7E/MFvKOpNhfHeA3rSX+YlZ/q0tQNTrRbTzhF9Kw938zjEDdmJn0SZPd
         cttYKEtn42j2AidB1+xM8yYND5kaD5LATgSi0Zqv+W7AnxFoidf4tChN9fcm7zI63vJS
         eKLmJwlfkOaSy9BXFbYDVLKKmbpdUfiOSd4tTO3JIYiFVoAWFyfVKz/ZtDTj1wU96jA3
         0zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109283; x=1709714083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdn4dszK8dT2wFJDzc7KLdV8bKHSO3dOipQaUHsMF8I=;
        b=uEcYZTnJjc/SGqBJx13fb4Mt741VfbOAK/1tEKeKf2qMTx0aNddLG0rnB1VZ8Cva1y
         /x5zalE1VZzcDVoFx4nV0ltUoNAEVtGuMtm+mn0O5CUp87Cayr2XKyT7l5uOXKrsmgkn
         2zxHSNLkIWJDxVEEeqJBxUAvWyNh0uJjtbFw/5Mb6p8JCdWXAbcKJzFRzV9I5EJlHPQR
         e+Az1TgCvMmcfpTQklAihMU+xvyQSUbBFXnmA6NN4AuMiKhab8cjUW9C04h4YfjofJRT
         0dEdyziMt+V/8epNSuOakbADBoJkaS6V4Iy5Wg76VFxEpH030K6MUtIk4kjaKc8p/JwF
         gatw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Gc6sDmS1NF2fZOy3D0iNXFrqA5xg4vUHfSZ9HtP1y0UtvqfH94vsYQ0JaMR3fhzMpwK4Ln+de3OS44R/icGpL3laX+01
X-Gm-Message-State: AOJu0Yx/fug2Ixd0S9IBCB/gkPZLUb0CNXx6Txr//P2MxzKbI+vGKt/S
	dJKj6bZ5THeK+nQbjbXYQO6YRI3KBooxYgv2BRl9Cv8zz+XmP5TabhI/RAqW2ZIY2yXNLJbZQ70
	RdMopZn+EYdQQjL/7Z9h/B28RJxqcZOIfN6IZ
X-Google-Smtp-Source: AGHT+IE77Xby4Pi6PYiJAY1S/pa7SR7TyFTg2tTvO/1SCrSVuEartTxSX8TzflGk49CrlbvH/ASlThUgj/LCDORFj4I=
X-Received: by 2002:ac2:55ad:0:b0:513:edc:19df with SMTP id
 y13-20020ac255ad000000b005130edc19dfmr14768lfg.7.1709109282976; Wed, 28 Feb
 2024 00:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228074308.3623984-2-zegao@tencent.com>
In-Reply-To: <20240228074308.3623984-2-zegao@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 09:34:28 +0100
Message-ID: <CANn89iLQ8r3e7=RP9F7wO=b+bZbGucbuitOswkVwmijbd1Fzig@mail.gmail.com>
Subject: Re: [RFC PATCH] net, sock.h: Make sure accesses to a fullsock when it
 is indeed one
To: Ze Gao <zegao2021@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>, Honglin Li <honglinli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:46=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote:
>
> We know a pointer that has type struct sock* can actually points to
> one of some different sock types which have different memory layouts,
> take req_to_sk() for example, and whether a sock is full or not
> depends upon ->sk_state which is a shared field among them so that we
> see some repeated code pattern similar to this:
>
>         if (sk && sk fullsock(sk) && sk->field_not_shared)
>
> which seems to have no problem at the first glance, but it is actually
> unsound in a way that ->field_not_shared is likely uninitialized (or
> unmapped) when it's not a full sock, and a compiler is free to reorder
> accesses to fields of a struct sock when it can, that is, it could
> reorder accesses to ->field_not_shared across ->sk_state or load them
> all before the branch test, which leads to unexpected behavior, although
> most of them won't do this.
>
> So leave a barrier() in between and force the compiler to keep the
> obvious program order.
>
> Cc: Honglin Li <honglinli@tencent.com>
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>
> IIUC, casting a pointer to refer to a bigger object in size is
> technically UB, which may lead to unsound code. From the POV of
> a compiler, when it is allowed to assume that one struct member
> is valid, they all are through a pointer, and thus it's likely
> for the compiler to do such optimizations and reorder what we
> want to keep in order.
>
> Note this is not a typical way to use barrier(), which only
> acts an ok fix to what's already unsound, at least IMO.
>
> Comments are welcome, since I'm not an expert in C and I know
> most of compilers won't do this reorder, but I'm being pessimistic
> here.

Well, my suggestion is to have evidence first...

We are not going to add barriers just because we do not trust
compilers handling of sequence points.

