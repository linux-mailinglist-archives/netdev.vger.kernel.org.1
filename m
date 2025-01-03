Return-Path: <netdev+bounces-154927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B27A005DC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC8E16132D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAB21C878E;
	Fri,  3 Jan 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m69lxsqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32454C62
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893694; cv=none; b=jYLcnjmgJT8OYkTOs8pgOXANFyPpSROC63FPKUR/fjXXvMCmqD0P/eADpWaxuoE+8YGgF6EKO7xVJHcd2rn1YC0EC0Xud435wbfPVBTVk5m5vw8MNPuO/U1MB2fAYoTUq4BZoQmp43cIK/PgJ7muLfmX3Rihq+kpT+0xTjCranU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893694; c=relaxed/simple;
	bh=Ey/yrmib8/yU1C3yahwIPlmK5F1B0jPWLyFaguH5zmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWJEbH1HnqKQcCQxLwEYgW52VeRUc/v9nu31YjjnQvL3sg6Cc0QcoaPsEbBIVd5j2x1P8ugONMtVIUWywIaBR7fGmIt6AYQ53Kod2wciLyjKVPccPF70xsh/NL1Yjw5fCsJtDF4MlFCVSuiGHYsVzg03p7iiFE/mUEPwMUS4Ct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m69lxsqN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so16868924a12.2
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735893691; x=1736498491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey/yrmib8/yU1C3yahwIPlmK5F1B0jPWLyFaguH5zmU=;
        b=m69lxsqNV1/i3LbXL21MO3xeVYquuAt+RQULkNlb7ZKJgo7MQaMb2jyy+ZmTVdPD2k
         iA0tAShCOhd2C/h3r+hnQ6ohbZCCo52KktuxOEKPoQrrtAZXDVO5WtrJxZWfRK0vwOm5
         QcqEaPMMLkcfeHJ9g3a+T6Sobb6QwhERo3qwn0UtsqIRiX9NvdSIuP8Gepp96SqEA3SQ
         QKfKafwiKAIxNT6BbjpHRnuSDuQLHgbENi02RragQEtHMAUTPSSgcWwELEZD5gUEI5r0
         BnSByTm4dlJ0dTYbcI9OzIFC6nf3KKmmewtUm12nUii7DfT4IZovFLkMOv8I3kJBdb5C
         Z3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735893691; x=1736498491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey/yrmib8/yU1C3yahwIPlmK5F1B0jPWLyFaguH5zmU=;
        b=EFWfksZgRH5Xj6Vg/XsZyhu0+8Z4tkbFgtPdksf08lOOun5MALwFAioU2Y+NQThBhh
         pVWiEDiJFIoTYKhBXfeqv2lceGubM/IYd9LoyxJJewXcZ2XR8lm8z4eE0/ib8mIXAysi
         NR8kLYyRgYMq6yM5EHj2hNClaVLUgSicTN5QA02/GbNLu4p87j0HxnwJYOb2kKnRWx00
         TUItYskImcUOUFvL9Dc4vKXbpkSq+d1CbTPzklDzFCgTjdFr5QfFuH8YLYCqiZn2SaDG
         x+8XN6aJ5gDNAYPMSEv5aibSJIu4dCq0su4+U4EJFDfvEOjZO+S+WP6tzxlvymyTsCHA
         VQPg==
X-Forwarded-Encrypted: i=1; AJvYcCUTbDgpA/zYH/zS45VRaEfSUmFLmqdmXkKlS7VmBnizr3W6w3TFfOdhI9Lyeb+HSE9+gSnqm6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEP5UW+z971gAewycmTma1fkbzyR5Nj7ifI8M/DHzC1aaxvcD
	nnRlmB7D15ez+zfHHxlJVNzQkw69Uk+OsxjCYNGfxCsH8894uEOhsxpCfIXIKEWI3fEVrfNYtjV
	n7YXgjr3/qhq+SQNRrzQJzgbPNEBaLnc1DVGW
X-Gm-Gg: ASbGncvdszXM6dKwijOjCHbfPlUs4LIThTJebokeUa8o0ZzfQKgQ7JPDWyoWdDp4UQo
	6ZscSX6axGzda/aUXWkJ/J9RJcC6fMoZ6jeXrZdE=
X-Google-Smtp-Source: AGHT+IG2kbNOgSuFD8ASaK7qseKqN+UNI2UmlawEOFlUkYnTnTXS8gfvGmBRJksucTqAQ+SWovWcs38BIDYYwkAcg3M=
X-Received: by 2002:a05:6402:210f:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d81de1c921mr110050342a12.32.1735893691001; Fri, 03 Jan 2025
 00:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018154804.420823-1-atenart@kernel.org> <20231018154804.420823-2-atenart@kernel.org>
 <20250102143647.7963cbfd@kernel.org>
In-Reply-To: <20250102143647.7963cbfd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 09:41:20 +0100
Message-ID: <CANn89iJ0BMu3jDOmQCkiiOe_1Fc7bZuj-p7CZcL5RC53=-MDFQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com, 
	stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Oct 2023 17:47:43 +0200 Antoine Tenart wrote:
> > We have an ABBA deadlock between net device unregistration and sysfs
> > files being accessed[1][2]. To prevent this from happening all paths
> > taking the rtnl lock after the sysfs one (actually kn->active refcount)
> > use rtnl_trylock and return early (using restart_syscall)[3] which can
> > make syscalls to spin for a long time when there is contention on the
> > rtnl lock[4].
>
> Hi Antoine!
>
> I was looking at the sysfs locking, and ended up going down a very
> similar path. Luckily lore search for sysfs_break_active_protection()
> surfaced this thread so I can save myself some duplicated work :)
>
> Is there any particular reason why you haven't pursued this solution
> further? I think it should work.
>
> My version, FWIW:
> https://github.com/kuba-moo/linux/commit/2724bb7275496a254b001fe06fe20ccc=
5addc9d2

Indeed, this would probably remove a lot of syzbot reports.

