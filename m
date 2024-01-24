Return-Path: <netdev+bounces-65448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0283A88E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 12:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95D21C20D79
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E760876;
	Wed, 24 Jan 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZGLJSE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AE2BB0A
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097142; cv=none; b=pTribVJdoftBK6zHXGKpM1VMAfARxDEost4g7qqJdy9vetUzRBCszipu/ivA6bBjBi5cFpI4B9Ooz3Hl/f+XPGK4cnH8XMI1oLclkxwHxWuVMw/mvOUcZT6FtuxQMPAhMk4bDSwxA0SznCuJVSYMunCkJN/DaUUxOCWF9amSd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097142; c=relaxed/simple;
	bh=a5H0E6j7eGE53aTaLLK9h7jLJDl/erd4lNXiZJRMz+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzlH88kcnR7vRqw9WtyWaTbpDJepMDjpDrq7AoNpzY+hGID1WEyGKt7sNbE/DqyXUmUK4230AsUT1chIQx6PPsl8ij8GYvJdpWdJfsvKXNtbhMHBggS9dfSstsCMmpMPlqaizVfjZbnYXrGVmEs2tBZeoI2d2Da31sOP2OxvvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZGLJSE6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55cc794291cso5455a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706097139; x=1706701939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5H0E6j7eGE53aTaLLK9h7jLJDl/erd4lNXiZJRMz+g=;
        b=eZGLJSE60NS52Eu/xG6t2f64BKl8C2qfddlfy/YDBOL7i7ZpDMyiA9QfLxzBVmXi04
         ru/CQwDfo1HNxg1T+lDP7+TyHv7PtItWQB6Vv1pbhvEIrlW+Kn8cVxFhZKdIrNlbSxlM
         14LIceO5WI8MwnYdhlznhpvpaHtqFanGSntfoblYTke0qi20+qK2UmvEC64ietv3fcjx
         I3fuK45MCJnwShiAsDRem5+bi0POHWc5H/MxvW3t9W9b1wAiqb1Qezh5HCHkOOTP0RgB
         pHiLy8jghVButNhnQYyktIf8PQj6Gx737JcL5GkPIeGRg6eBGFDDfFcINC5+jRWTl4qX
         vHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706097139; x=1706701939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5H0E6j7eGE53aTaLLK9h7jLJDl/erd4lNXiZJRMz+g=;
        b=OkkxwjFOziKacAi2xQHjrRexvLLp2y7iOaX6Ko+OudhboT3a/faGezBZ4IfmRZsg9C
         Terd6MF84HfbJ+bxqHbEEaaleNpx4RLQuZU8/FiGavAnbadDJNQMxpcyj7NBWL4VHhwy
         LlVy3SKveKvGx9acFOqywd9YoUzpis5FPltiVaxRwVrVzPUlyr3m3GnsRayIqsRMhPKz
         Er2v5gRVgLvjbdi07xePTh57rLEGBrOX2P166NaJTJu1auK4Am2j87dRySz9kL41zuk0
         RUVUwhJYRb21kqzldNN2bNxXbKz5bHnk2nOqS1AN0ERZSOuxgl9NR4koL/PxTKEPrqhl
         wudA==
X-Gm-Message-State: AOJu0YwCROu4fhUghZVK7ZSTMF+2XX747B1wx/rXlRsg6MJSQOOAqYhF
	Zbuj0FyQXJT2b2Et08FZbqX/k3c8qw2PKQOGr6Xf+83JlHbMf2TTQ/W5Snw+QZoLLTgt+pTi119
	dE4mfCYF7mTMrOs7CBhM39yCc+ua5or0AlBP/
X-Google-Smtp-Source: AGHT+IH/GHZq8Aih5T2bhKVnYYebke8oNKPl/T86BTOCByN90Bn9Mikn6W5nbeRbtjUxaevlh+Dm2IHuIzUofLLwBx0=
X-Received: by 2002:a05:6402:368:b0:55c:6a45:d6de with SMTP id
 s8-20020a056402036800b0055c6a45d6demr94542edw.0.1706097138639; Wed, 24 Jan
 2024 03:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com> <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
In-Reply-To: <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 12:52:04 +0100
Message-ID: <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:20=E2=80=AFPM <kovalev@altlinux.org> wrote:
>
> 24.01.2024 13:57, Eric Dumazet wrote:
> > Oh wait, this is a 5.10 kernel ?
> Yes, but the bug is reproduced on the latest stable kernels.
> > Please generate a stack trace using a recent tree, it is possible the
> > bug has been fixed already.
>
> See [PATCH 0/1] above, there's a stack for the 6.6.13 kernel at the
> bottom of the message.

Ah, ok. Not sure why you sent a cover letter for a single patch...

Setting a boolean, in a module that can disappear will not prevent the
module from disappearing.

This work around might work, or might not work, depending on timing,
preemptions, ....

Thanks.

