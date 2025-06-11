Return-Path: <netdev+bounces-196592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80DAD583C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DF18868E3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0CA29AB16;
	Wed, 11 Jun 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQVGahRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8C295502;
	Wed, 11 Jun 2025 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651176; cv=none; b=tKtlNuRwbM7TelsKJ1KVeVgK07/L2Vf3sRO/7tqpcm848m5pxNXRhKKcX/4VVHX0cwGAJFdQCG8Jy0oxycP95ontwY2gqX82tJL20Plaz2xStzIxM9zk3zWjfu8niRG2ybElxPgOwBUwtivIi/Dv8dg/b5D+R3NXaiYONzJJifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651176; c=relaxed/simple;
	bh=AiOkcrQXv5dBfuU+br0+1pqKGEfPTV809EosE5nl+x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiHSKQrHNBaEbeWi0aNj3nVp4MHbk8noDStWpQR2oEvO5HhqP1SWrrNZo4iQ3pW1iWzUSsuPoUFpsT7LrtLT2W26ZU0M+sWuZR9n+TFgJGFwgwRb3PUGY9+rFDpwkVAHZarnEbslLmcK/l2LBGwe7VZRU2C/1f51E8TMzX3/t6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQVGahRD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32a72e61a3fso10067851fa.0;
        Wed, 11 Jun 2025 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749651173; x=1750255973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiHg7SNH+pSMtOhNSqpQ2vUspKGZ2spdd3OjZnoxU8Q=;
        b=cQVGahRDaya0o0hXjC2NjMEeGVwfCk7GMDdB6b9Gdwrbj/OPdkvjDsh0p4djzqe7mj
         RbraucB19j2CQJcb/wU+3ArcAvAjyXBhL4XUmY3wPNu2rfoMdtclM7WRS0xg16MfSy37
         x4MRfdfMmAhj6CCYceaUI+UOA4JmtLo/FMkT214//ZNX4eLmhCupHd5rX/iWlzeyxAdC
         50FYCmWAvS2Srd2CUBAax2HVJcAFuHC7Sf9xNRNrR2vLD5ob+pesRu9ftHzvz04YAyjj
         oGHVD3CFbk0Li8B1YbwAYfQUaPGHS2h34wHyDpV/n+VHB68wJB7lYspuIP2O1yk/BaxQ
         NLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651173; x=1750255973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiHg7SNH+pSMtOhNSqpQ2vUspKGZ2spdd3OjZnoxU8Q=;
        b=b2jP9HG2dpXUtWXgvmTdzSLGPLu3L52AeSrkj9DU0HjBqqbEaw2bF/Nw2xNGQsH5u9
         wTYVoSPi4TxhRNZ2TB9ZYXfs95S8nrMOE+4H8Ex/I1HeT1c0HvxtSXn27dkjIAgacd6j
         mDkUGo6dH1LRz2B7QOwhtddyrv80gkqjzFNCt7bcBfp7OtOqyw/4XRSsuN7NuIvJApLq
         1csExWqSXdClKJXRCi2MP8aL5VHQAyKb4RQRmf5WISsC/AQGKqyKqDWj2q9GOCVtuZRi
         60ApCC1P83kROLU5H+ZWPPFmc8wZX6/y2oGzqpyT7Hgwl/Ot9+uOqqiMZ7lUZEjXMRT7
         V0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7wMR2UcqUwfRZlX1u4NbxnasR1YTnYx1pu06ncTRdHT/VnR29q88cUahDDzZpm8xnS6HkyaA@vger.kernel.org, AJvYcCXMIQCN5NTPKMZZEWfFOLGBKhCAYbrBmTlxS0zRPO6vbdApCzlflkOTzsVHNh/bv2Qp3pVa8ou6bcP9mqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQzUBYtA3ZIZMOKiMUFASgjtk90UPbRNxzS2UEKu2IuMkCEtK
	v0RdEClljnhKYF/cNDxQohbgw1OrwpURzrB/j/qXOReCaKZr7FeLK5SjmZ/FqhA7z9N8XUT99Q5
	BmO0vZMpq6IOTj7yKh5J0L5rdnzerkzA=
X-Gm-Gg: ASbGncvDFtOMzY4mEB19Za98y1AMpolW3R5H4oKm7cg5MKmWsCi7fMKJIWOovfw+eAY
	XC69JfQ7av/DRlZYb/LIx6AIFRbsid6fdLlftrJkhQFF9awhKCNgP6ok0Hh+LnkP8MrssyP+Tng
	o5I7Cst1pVHScYxHv2/sCWB/u5+3CfYM1iBO2bNsQSp8QvEMuRWkwv6OylBbcVGHqXBOfLzK8dl
	yzqAQ==
X-Google-Smtp-Source: AGHT+IEAValel8liDMEYhfCrnmQ5CestXZtWv84livqk4j/ymswdWR+PpAD0W4JSr184M5y7GQRG879SrHISz7W20Eg=
X-Received: by 2002:a05:651c:4ca:b0:328:d50:d7cc with SMTP id
 38308e7fff4ca-32b21269b9dmr10951451fa.20.1749651172599; Wed, 11 Jun 2025
 07:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607152830.26597-1-pranav.tyagi03@gmail.com> <20250607164200.GC197663@horms.kernel.org>
In-Reply-To: <20250607164200.GC197663@horms.kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 11 Jun 2025 19:42:41 +0530
X-Gm-Features: AX0GCFvcXQG5H4Lymw6YWunRZt95liFnErGnHf7Tk2DyxYxDDx34gA1WdzNq0ac
Message-ID: <CAH4c4jKcnmquBJ1fXo0ENRf+D3xuogF+Cu4iGVsR18FZfggqqw@mail.gmail.com>
Subject: Re: [PATCH] net: ipconfig: replace strncpy with strscpy
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 10:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sat, Jun 07, 2025 at 08:58:30PM +0530, Pranav Tyagi wrote:
> > Replace the deprecated strncpy() with strscpy() as the destination
> > buffer is NUL-terminated and does not require any
> > trailing NUL-padding. Also increase the length to 252
> > as NUL-termination is guaranteed.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
> Hi Pranav,
>
> As a non-bug fix for Networking code this should be targeted
> at net-next. And it's helpful to do so explicitly in the patch subject,
> like this:
>
>         [PATCH v2 net-next] ...
>
> Also, unfortunately the timing of this patch is not good
> as net-next is currently closed for the merge window.
>
> You can find more information about the above,
> and other aspects of the workflow for the Networking subsystem
> in https://docs.kernel.org/process/maintainer-netdev.html
>
>
> ## Form letter - net-next-closed
>
> The merge window for v6.16 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after June 8th.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> --
> pw-bot: defer

Hi,

Thanks for pointing out the shortcomings in the patch.
The doc will help a lot. I will correct the patch accordingly and
send the v2 as the merge window has reopened.

Regards

Pranav Tyagi

