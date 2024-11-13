Return-Path: <netdev+bounces-144429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30C9C734C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112241F21985
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CF4206B;
	Wed, 13 Nov 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="y6qijg4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6473F9FB
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507443; cv=none; b=mExd0ddt0FHRI1DhbelFvepWgKMck2MJJVAAiNY0Rlq87ytAMaPqPMEDrOvUjmN5c+7Fww68JMPHcrsFpNLsKj8dtVi5ZogSmnE3s61X1IXQAcZmrtFeVr0/ImJFRwZvbSGpqkYGSOV7+JbxDzKQ4rVx4VMRt6DjOmq4xrIDfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507443; c=relaxed/simple;
	bh=cSx1Sb5nlxjpjp/CRr1CWfHdpW/9KorZSApdxQWR5Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFiG6DWmB8x0aqd6ATZ3m36hsWlfXu6i99x/r/ZIFVA+bgCDg1NxIWFk0tzuryJwAEVgLSX/RUCKM5fGKg3Ou+fjbuQGtUJadoRIanxsQF48X3v6WMTDl1GvDLh3H3+4V+LGhn45cBUb+/dBp5ODR+4H7ikO4GsaBuBPmNUQM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=y6qijg4J; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso5192981b3a.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731507440; x=1732112240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3DGIMP6aD9jvNFqtT5HdIrAe8vPPB4Vr12CQw5S3+s=;
        b=y6qijg4JSQwNDVZHTkABxw84laHf5UfGDtHrZzfv1wfuS6ntSMiw3r1QCHZPjlHiOW
         4o6DN3OSYA9F9RFJW7zngvgBoCCrlY3zg7zUACxXyKlFelI/HvbeJBwEiwfDcxJTppwU
         I3uM7rz9nQl3VSUbvUx2hGXrZdwmuZk5mZG9sf11KjBzfySHD/iJpgT/HCpQZ7kSpZ42
         IDv4SVhHwsq4xboyTeIMGsrvO9avBXeyGK0wfOq6E52Gt/Bcmj5c3C7KAfli83cb+k3c
         JEw2rWY8YUUBkFl8JHGJGu/7u6pB/Fdh3mDGI2VJMcpx2VKXdbKnHYSEwQO4JO9KFvXh
         sIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507440; x=1732112240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3DGIMP6aD9jvNFqtT5HdIrAe8vPPB4Vr12CQw5S3+s=;
        b=Brs7LMCA2JGfXKF/5FVXiqrXj9VQcRwgJeZRkWlztaVgQ1HpClbdB5EjfXkz7LF/MH
         2HGnvu8v+u7IA5+62wGUbEMxBGO8R12VHulU8tY0TpBn2bziBHdUf9ZT4iFjUxi+MRnE
         RPfTmyFFxxd1GgusEf1NnBqP70xdzh+y16bD6+AOdho4MpoMuNxWkB6QNZtEQGydDmDt
         SuqlXPrplEhPLulU+i4k67zb51IKZ7dNaPbX6Py02il7d7TMV89V1ZEFE6Mq+/E+SfDt
         bP0neU+kpIzMco0Q9mGjDT05SWUB+WG2M6GdNMgGYbXJLqqB75/6TYWIdEeEt0BnL7Y8
         WLLg==
X-Forwarded-Encrypted: i=1; AJvYcCVVaVcN8i1+fDOkpmOq1wXxuEoPadYnW7Yd/C6XbS+Ca74ZKL4NCgqBDLl4CRy3W12lSJ7h3dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBEDtQ/1ZsDexuTSxWamHiiYdFGjDDYYWNg2gEsRbf7R01Fqk
	gYEXLn1VViGx1lsf64pHCwXhpPVmqvst8orvvG3RfHbtGCDEwBAJwhz7+hDuI9COE6eEJdX2ruo
	H6/1Q+gfTK00cJmjzu7v7N8Xvk+WTw8hm8OnQ
X-Google-Smtp-Source: AGHT+IF3aAvv1/PtRadFuU0dUJWyV8Gq3H6SVxip0T++QnIVhlQxjqlJ3h0tMdtfEa8c8rUaAVQFICtA0rjUm11ax5s=
X-Received: by 2002:a05:6a00:3a29:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-724133624eemr27603385b3a.19.1731507440539; Wed, 13 Nov 2024
 06:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
 <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
 <20241111102632.74573faa@kernel.org> <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
 <20241112071822.1a6f3c9a@kernel.org> <CAM0EoMkQUqpkGJADfYUupp5zP7vZdd7=4MVo5TTJbWqEYDkq7g@mail.gmail.com>
 <20241112175713.6542a5cf@kernel.org>
In-Reply-To: <20241112175713.6542a5cf@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 13 Nov 2024 09:17:09 -0500
Message-ID: <CAM0EoM=V80Qj3NQEcS4cmLoByTnUDn9BER8SWkWKUEp+OVRXWA@mail.gmail.com>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	alexandre.ferrieux@orange.com, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Simon Horman <horms@verge.net.au>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 12 Nov 2024 12:07:10 -0500 Jamal Hadi Salim wrote:
> > On Tue, Nov 12, 2024 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > I'm used to merging the fix with the selftest, two minor reasons pro:
> > >  - less burden on submitter
> > >  - backporters can see and use the test to validate, immediately
> > > con:
> > >  - higher risk of conflicts, but that's my problem (we really need to
> > >    alpha-sort the makefiles, sigh)
> >
> > Sounds sensible to me - would help to burn it into scripture.
>
> How does this sound?
>
>   Co-posting selftests
>   --------------------
>
>   Selftests should be part of the same series as the code changes.
>   Specifically for fixes both code change and related test should go into
>   the same tree (the tests may lack a Fixes tag, which is expected).
>   Mixing code changes and test changes in a single commit is discouraged.

Just the last sentence:
Mixing unrelated (to the fix) code changes and test changes in a
single commit is discouraged.

cheers,
jamal

