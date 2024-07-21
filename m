Return-Path: <netdev+bounces-112328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C24938574
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 18:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6200B20CB2
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17DF167D97;
	Sun, 21 Jul 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QprA89vg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0F167D8C
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721578459; cv=none; b=vFUfa/IsfbvDmtO47r7Igkp/D3lS6Rref9aHqFDRrSs7wx84cnP7av0UGZJ+dh4xDOtF8xssHgsAFNBezmu1AXYIInDTpDgzJpn5UXbzumqdHf2Y0sHpFSQ7MNsTl7AmqujmVqtm2AgGkXbY0WGoi0RjQNsn2+RPhMaRZmVKDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721578459; c=relaxed/simple;
	bh=9E0MJW1/ewiog4qv3bn9lePT5swMtsZO68HaA1cfshM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/pwSp2klpivlgne8cdEQ4GxqbLM4SdE2nG2C2lJ8UW9Lay2cuJyyINPezPlL1HAyMdpTReA3nroEnpuc5JbEqVdYvJZUEHx4y/OqMwkEf300eZwEHGRQGStlUNlrFa0tddgT6slwGNfWLhQfNbB57F5mgCHS4a7yFiWq6kYVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QprA89vg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso2157551fa.1
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721578456; x=1722183256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E0MJW1/ewiog4qv3bn9lePT5swMtsZO68HaA1cfshM=;
        b=QprA89vgZOvC/sYFku/tvNLuDWqgePS1K6aleKNLJ66cy0QnyFQLk6NigSk2Ijrnnw
         zLHHcjGJEiDgxSgQlr/kC4173lHG939kZQ1i77PXHjGOWFZKs5EMZ5Ci9NZGEhA+VlS8
         5XabL4crvUjr553Xuf5/GV1wOwNyVfyNLWpnM9fqZBHnyEH+0r+jZbAQyGgBBaNIKzYX
         lI2DCp312j9xIscYDHkuXItmPOun+rHqNTVOMlMFm/KfroJXT0baySswX0fjgyZHMrcy
         OqBQrHnt2VG7Ff47GDxQ1uBrV9M2X0sPnHH3WkrBw0mEBHdg8bx59EdDrqpLDabeA0sm
         ttDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721578456; x=1722183256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E0MJW1/ewiog4qv3bn9lePT5swMtsZO68HaA1cfshM=;
        b=ZgKfeL1/BaYaBhBv4VFaIE6lLXzppyQe+IaqvAIYDgBuz2HkBr8Fa64pP7CRRICOH4
         fOmDskLvIFm4AUPFJ6RlRoOLWXfyfmVve8w5fErRIEn3/uzfikfi8PleCDHaY3lye7g8
         r4DU/Rn4nU+zlnBCbbcmlDlTJouMpFGvfWcQem6sPVmkff5kdJgUpRKNkEIbK+hnYCyK
         oSurH0nEVpy86644R5OJc6ylfsopNUBNIP3qdCib3N4TB7BxGLT5kFg8eEeA0g7SZckn
         M1Dt3RUNnI3yFqahNlMH3+xo6GdkfZrnUqmF5MFS+6++yAZ5hJlsJW/OD9g29TsVZOjU
         h2GA==
X-Forwarded-Encrypted: i=1; AJvYcCUvoNvgFbyFpEQWk4caBsiUflccVmyXgL5xMNEu0ygW0yxV1nhDmk6eGqhHglyAX9FuOwhDKCh2d3FRqAB7+wyanIYVecDs
X-Gm-Message-State: AOJu0YwHHmxX+CyD2pvam6sLxArX1BImqzP7GZxg9qp9jmtjWpbtxb4N
	Eq1V/ETUAdTSpV4xXhXwnzXkXQUpVokNkVltWbacnncgoxJ9bPwyVoyAQVzwAq1/vSsGUWuqZnD
	5ac64qVjzKp5aGnTI4dzBmxJkv7c=
X-Google-Smtp-Source: AGHT+IENM0uBMEJKQpiaIPRhd3VHf89vBeOO88TLU5tpUTSPR501yj5bAxxs0xtU+mfDzFvNKwEs0OCM9HNCysPNSc4=
X-Received: by 2002:a2e:3002:0:b0:2ef:2a60:c1c1 with SMTP id
 38308e7fff4ca-2ef2a60c2f7mr14268671fa.21.1721578456003; Sun, 21 Jul 2024
 09:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720140914.2772902-1-jmaloy@redhat.com> <CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=8OQ@mail.gmail.com>
In-Reply-To: <CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=8OQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 22 Jul 2024 00:13:38 +0800
Message-ID: <CAL+tcoBQPspUNJ2QDxy=m2iut+gZJBPEkRg6yA83TsjnL==S_A@mail.gmail.com>
Subject: Re: [net] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: Eric Dumazet <edumazet@google.com>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 11:23=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Jul 20, 2024 at 7:09=E2=80=AFAM <jmaloy@redhat.com> wrote:
> >
> > From: Jon Maloy <jmaloy@redhat.com>
> >
> > When we added the SO_PEEK_OFF socket option to TCP we forgot
> > to add it even for TCP on IPv6.
> >
> > We do that here.
> >
> > Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> >
> > Signed-off-by: Jon Maloy <jmaloy@redhat.com>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> It would be nice to add a selftest for SO_PEEK_OFF for TCP and UDP,
> any volunteers ?

If Jon doesn't have much time, I volunteer :) :p

Thanks,
Jason

