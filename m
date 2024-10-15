Return-Path: <netdev+bounces-135478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A29F99E0EA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5119F1F21AF8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FE1D95B6;
	Tue, 15 Oct 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k22R0ocR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004F1D9A6C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980528; cv=none; b=qFKoGxSv3di0lkoShIBFx8Isd5TYPpDDtpMPDpUKmM0RLHbhNrKgC+lTP/80AEHd+ccFAtj7AzFiOWxLwQFj/6KyQ53rbpSxKtngXEY4Oi+B3XhtSgEtQUDdQHBINpQVOlm7LuNxpzzQev6NJycHffEy2PfcrOFxmzDaPwrTbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980528; c=relaxed/simple;
	bh=BEcL+du+l18iEF8QfCpqfmg4zOcAQAejO9fnBlzxFjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MygC5/JrPrS9GvzqLo4HLGDVHbJLYUsB9FrxUjprL2nFHkf9Ruuirx5FEDSwyPxtRfyGd1azJ9rP0eE9LhNJVYL9d6TwoFAy6lUrNF/cfoVyfCCBLOwmCNx/q5QWgBPhwrINnXq2WCLBUQakWpT2SwKiHWKc/HPwFEMk/URfCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k22R0ocR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so1843487a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980525; x=1729585325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEcL+du+l18iEF8QfCpqfmg4zOcAQAejO9fnBlzxFjA=;
        b=k22R0ocRYvsRyyp4PEIx0xoSCR3IpMiRNsR0216gF5wB2gpTNoI8gOCwksYv2KzI5Z
         14xO+HWZIlNyOuuG790/3F+EF8qtDA1NC68GYGrYh710q+EOjnjAFFnpy2Z2u3+utjlX
         PEkd/0rFBGtVLPaTwT8UcLclHXvwT1T9zK0LbUGE5H1jMF1rvcj6AApC3hdo21zXZToh
         FxfrQGKvyqcLcmFeNrG+8+PHMbL81I+aRZRnghzpo2nmzRmpQcAhVgZ15lNGWjt60KJ3
         PS7YcKX4celSbl+H/wP5sipYC5gN5VIuGvQSX79F0z4x/aLOqYbVhIS4NtlB5QbbHXFC
         ZLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980525; x=1729585325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEcL+du+l18iEF8QfCpqfmg4zOcAQAejO9fnBlzxFjA=;
        b=hrbdaTaf2VpmjfiA35nNQc43qUw7YS8e21xAmZq3BKRpm3QDTFti4850WqTWme3zlo
         H6Z2ct8mk3SQY29vXoVYI2hRssZ1IKpxAP6HCIEyV57VRPeyjGSaHyplkDBiOMPgjcA0
         M1wCYw78wWMxacrwL0GBXzy3g4EKrA9TpPhAdzPzgm29S0LSqoAgXyS90NYCXu36bwYr
         ffpSqpsjX5xUzphjLcaPyeT8DetwKK7InGP3WXKGizq5mF+70wu1hrgfU51mVu8Af/4t
         WJgqInzqO8VHmrIunjb8WONMfOM+OmfEfoB73vPzD71rppIqA2bX4ND5CwWMbQwHZyyv
         oosg==
X-Forwarded-Encrypted: i=1; AJvYcCW4zvzxFrWsk9TIUAJAU4zigVpknfUMjecJ9VUSiWEam9JfGxX5ny/I5g1aZMG1VWmv6Z4GSYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvST71pR0tJGdLm80RkNisCroSik4HiU8gHL2L92NSS1K1bETv
	HI511LvJVD5ituYflYDoAQ7j+TqdcQrBeFMDgFTy+51U3FIHhILdhb9IGu5RGi5kC6EBBNSoatX
	iMQ6liFOnmkz+NuUyxqycebVC5WwMxM1CTaKR
X-Google-Smtp-Source: AGHT+IFSx5Y0ylEOgLSDDusCUD7oSb9C+YeFLn8BdrweET0ZhvejtnEGgPEvqfojZNCNJuzYY7ki2m9202GbgpLB358=
X-Received: by 2002:a05:6402:51ca:b0:5c9:6c38:f188 with SMTP id
 4fb4d7f45d1cf-5c96c38faedmr6409736a12.26.1728980525372; Tue, 15 Oct 2024
 01:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-12-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-12-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:21:54 +0200
Message-ID: <CANn89i+7wNtVhav9COCL336Q1iL4whE4PrzEJzAY_fOSCikyJQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 11/11] rtnetlink: Remove rtnl_register() and rtnl_register_module().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> No one uses rtnl_register() and rtnl_register_module().
>
> Let's remove them.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

