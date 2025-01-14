Return-Path: <netdev+bounces-158099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C0A1075F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F45168616
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D162234D0A;
	Tue, 14 Jan 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAFFyXfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CC243328
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859951; cv=none; b=ndc+QGr3WTDxx22Rf3wy4tXXWn8T3ea9895flexORz5fWKDdh26XLWt4JY4Kt8bw5Jtdvp+jPfuI4RkP3YAX5WXJBU795jowwv6Nz5bCG/1zt4EpFstBdcFTNFRhavCbKvmOioDuZ8DL9XcR6n12E1B4CNUwpEoLYG4xv0y7b3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859951; c=relaxed/simple;
	bh=DljJxNqz4rAgV/3YmFb7ej8BfAE9L119q6FzMUilKo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lndu2aaSuUhDTzH8s4l06sTG8ZtNhrnFVF7uLsAbQR2RR4bZOZX59X5GfHNt/rL+nh2XiG53LPqB4N86WvoUl7ZNzGqcRks6kAn8HB8G/zP85KCPPgNV+NWNeaCHYCGZnAcIWLlvEgEPYwzItNZEfwYwYtUrPaKf1D8/CwT2brw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAFFyXfB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso9579711a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736859948; x=1737464748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DljJxNqz4rAgV/3YmFb7ej8BfAE9L119q6FzMUilKo4=;
        b=pAFFyXfBJC+i8a8+DEpZgyQtng1sERPPvDNgB+p8GmRopJ6ADu4m4vzGfH6CRyPgyR
         UFBOcE1VHgllDtx63Ptd+Ck2Jgcl4zPIdXbxaFfqnmuOVaRAdtBQs8UaySbaE24d8wFU
         pSKmFp+oy+bw9Kt76iKcd1GgHcLZR6Xh9baBm/6dqfiFXgVMsnrHL98gx/pV+xhq4+tq
         OF5Nx5autaKZSNxD+09L4G6WRJPARe4dcSj3TlWu0un+hKpHJurISG75FsdfR/3YQXd+
         uy6Mx2wVRSZ4nLfc9aOcX1BKbpAyXCw/Vq5TCpNtzouB5jvcW9vG4IG68w7cGbBjWQwO
         GUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859948; x=1737464748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DljJxNqz4rAgV/3YmFb7ej8BfAE9L119q6FzMUilKo4=;
        b=L7jbbTo1kc4Kw+erZiqVlVU1IEo6e4TNRc1bSefpzdQyYOnOc43Q09WeOejRPU9P8t
         MysVkKqWqrg5RjQbhdg6JzzMZE2DuteoZFJhmDKH7arxhVHzXqylOqb3yvY8tzqqhqcB
         7QnS4sihjpSz+NYyX1beSrby8wVevx8OvwRjFnqSTRvUM+PjcIi4dOYm9mM6vrh8t0yh
         MMzroi+VJlpI1v/M+3wNRmU2lea31fDJFO7Rins0ZSy7Y74GNAs4zsWHLJtSHcWor4wp
         PfFA5qYdHN77+58/vPARWYsQM08TJE794mNbFnufSuNTDd25aqZ8gFwH0vUsRBwoeqTA
         mnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcV4Y6fIEEkeTESJpSDtLguigfz57GDdexb2rterM3UdfM0RwTdnEe+R5pwd4SHzLVenOnOlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71tT6GsxUSsMUa+FmWHmM5ULZXNMYkpTRyugolNv+bo2dZ+po
	UPMNj6CSJN3/KrJCJw4/Pha5CzF8LTseuBT7fvEhvAgzPhAt5UjX/xT7zVTQ8kVNtPweufG3+JV
	UrWeUJoqUuUzf2wF7Z316rfdV8abcfBKfiKTA
X-Gm-Gg: ASbGncsAB/lCDmgC+uPolM1+2w/ekzJ1NUaKDr4ER8JfudwZN95T0xMA76En5N+q8Tn
	4ERq55rjd5dw7+DMV4zf7RaKGNP6ek3+PbH55ng==
X-Google-Smtp-Source: AGHT+IG1mrzfl/mCpiWN86nTDGPJCeOWpWvpg66ZEfU+aAWNszH31ik3CGTDrtqwjmQaikYFaKqGSZnWny7ldrg8X5U=
X-Received: by 2002:a05:6402:4416:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d972e1c42amr23297010a12.15.1736859947587; Tue, 14 Jan 2025
 05:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-4-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:05:36 +0100
X-Gm-Features: AbW1kvY_x3BgN8yx_65m-XzC4BxFs0Ao_PXyV8lJ-iubESwOYdnTMD7MsNb_PCs
Message-ID: <CANn89iK_2YSXGU=A6RyyDHaHQg4-tFYjP+3u=uR0aJDn5EiyLA@mail.gmail.com>
Subject: Re: [PATCH net-next 03/11] net: make netdev_lock() protect netdev->reg_state
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Protect writes to netdev->reg_state with netdev_lock().
> From now on holding netdev_lock() is sufficient to prevent
> the net_device from getting unregistered, so code which
> wants to hold just a single netdev around no longer needs
> to hold rtnl_lock.
>
> We do not protect the NETREG_UNREGISTERED -> NETREG_RELEASED
> transition. We'd need to move mutex_destroy(netdev->lock)
> to .release, but the real reason is that trying to stop
> the unregistration process mid-way would be unsafe / crazy.
> Taking references on such devices is not safe, either.
> So the intended semantics are to lock REGISTERED devices.

Reviewed-by: Eric Dumazet <edumazet@google.com>

