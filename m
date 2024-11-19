Return-Path: <netdev+bounces-146315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D721F9D2C2C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856551F215E9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A061D0B95;
	Tue, 19 Nov 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSgW026t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3B1D0967;
	Tue, 19 Nov 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036271; cv=none; b=V+dttQlMueAgxjW/9pSj9oUroMl4XcWEuSGykQSk1s8x+KdfmxrWDgrdFkyZ/HpRP3uZauvCfkaBNRT3CY1tVUrYKT+VWAwBh8TEAJKW+J9XGPlPoDwJoCNyzWTTJihBhoNBjLkE8ypH2QaiGbK2Ia5uB//SludCyRrzG/GaSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036271; c=relaxed/simple;
	bh=3eB8JTS8q4GTl9FnLSmmAdqR6Vgm1FF7PeV0Sku2fOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+tokIfCr83RbO8O2PSyMiutjlgQzF4IrwQeCIzMip68s7EAeoPhRwA601b8ih6uPla3OeuwSqynqjllMFDzfJ4gSHGR3+j+qCOsyBciYLkk6AvuhStXhYM1VFFumtczvtYo/I9x/xsFARdoYOAgi7525sN2dgeXJiK+YlJvIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSgW026t; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e44654ae3so732272366b.1;
        Tue, 19 Nov 2024 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036268; x=1732641068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3eB8JTS8q4GTl9FnLSmmAdqR6Vgm1FF7PeV0Sku2fOo=;
        b=BSgW026tMn0bZseBke1z7Zzmcpw1qbPBzmZYOL7iwCG86leOeEH5tySDlmr5ngtrc3
         9DYtTYzvQezS5zVnCUZ209iJylmBhVFa4oqRjQuimRv/ZZbjrLRZRGSmXixuMtoD2N+c
         7DBpyiYrN7RZrDEQy0pCG28hb+gNeHtIYPweSQJu2FKKjDyifURWYIiYFEtMDw9RJuIv
         GD+WJbvbGT8FOu5cpJdzg/DThpftTTyXoQF1L+RSeHK+UvDGWrRz/bHVO33c9g757lZe
         gHO04pFCGmp792YXJ6OsWW999WSYxu7HEA16DerB/mFj56j/LsBHUekFHJBZNhNnLUIw
         jqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036268; x=1732641068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eB8JTS8q4GTl9FnLSmmAdqR6Vgm1FF7PeV0Sku2fOo=;
        b=ZiaJAwE52t0+GkWJouV6/4Aoim2qpv0jhVNO5nzLQaB5Ny5+m5WxDinw9V9k4qzdw/
         gwB+nuYU3AhkITWE8PIHfU8l6BGq/3ZmqCpees+EU6xdxx14MdZY2ZAqKDVig69XtPmn
         QXRW62yZJ+NJbmnrY+htpg+THOU7caeHkCRrKBkrVtS/FS+ti8cxsIl3x6aQtG2tPrZF
         KKhyv4xn95MxnLdzRDB51PKu0JoeZIFGdaDL/YkvRScStTwQnFfzj+zKCWtOxLdrx36h
         NCIdiDBL8B9yvkHEkedQzCpohRakOCOCFbgWYpP5fG4hUlRvvPDKswpYIZgVVGBkLgod
         t3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDUV9bpWZD70OUWilEpisda4wN2iuG9tYiCQtwu0UX7xK2E67ZQiy3Hv+DUIc0+JWKoyAeG1yp@vger.kernel.org, AJvYcCUvvC3F508RuGKo+a9MSShx63Y/fVrVIaWWdSvzgha0EPsZSFCGTdYgfaF+JOx/p1ltiW1EEVW0iTjsWI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxKqlpnt9PM/w8vW9igUfNvLfZzxa4zB4f/LQRHK8EMgCBYDE
	jrr1EspnQHPI72yPsJre3n4OmXCX5/qL1xcemA3yLGIZanK6IbVwtKJd5P4y+zysjFQSrNexrYv
	DRDz4421JjW9m/7NYsVGD07A7akQ=
X-Google-Smtp-Source: AGHT+IEqLza03QisK2XVyzlo7WJSd8LkXpH8Z02+OCqp+DU0oBPgqAy2zWR5gt6GUQAk71pWPVJuKjfju8RaHEwE8mg=
X-Received: by 2002:a17:907:3181:b0:a9a:15fb:727a with SMTP id
 a640c23a62f3a-aa48340f21fmr1457050966b.13.1732036268062; Tue, 19 Nov 2024
 09:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
 <20241114193855.058f337f@kernel.org> <CAOZ5it3cgGB6D8jsFp2oRCY5DpO5hoomsi-OvP+55R2cfwkGgA@mail.gmail.com>
 <20241118161615.2d0f101b@kernel.org>
In-Reply-To: <20241118161615.2d0f101b@kernel.org>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Tue, 19 Nov 2024 10:10:54 -0700
Message-ID: <CAOZ5it1S+fiV5Nz8Fivq0MM3dLFS+Rv90v9izgGkZMJhz69fXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] vmxnet3: Fix inconsistent DMA accesses
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> What is the purpose of the first patch? Is it sufficient to make
> the device work correctly?
The purpose of the first patch is to fix the inconsistent accesses in
`vmxnet3_probe_device()`. This only partially fixes the issue,
however, because there are inconsistent accesses elsewhere in the
driver. So, no, it does not make the device work *entirely* correctly.

> If yes, why do we need patch 2.
> If no, why do we have patch 1, instead of a revert / patch 2...
The answer is that the way I submitted this patch series was a
mistake. Specifically, I submitted it as: (i) patch 1 is applied on
master, *and* (ii) patch 2 is applied on patch 1.

Instead, the way I should have submitted it was: (i) patch 1 is
applied on master, *or* (ii) a corrected version of patch 2 is applied
on master. (By "a corrected version of patch 2", I mean not
pointlessly reverting patch 1.)

The difference being:
- If `adapter` *should* be mapped to DMA, then patch 1 is the way to go. Or,
- If `adapter` *should not* be mapped to DMA, then a corrected version
of patch 2 is the way to go.

I hope this clears things up. I'm sorry for the confusion I caused. I
will submit a V2 patch series that makes this clear.

Thanks,

Brian

