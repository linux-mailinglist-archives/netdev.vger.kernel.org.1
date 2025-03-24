Return-Path: <netdev+bounces-177139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF5A6E05D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A9818897DD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006A263F38;
	Mon, 24 Mar 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms24x6lj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF67263F42
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835487; cv=none; b=i45ToLzBJpWZnfwD4CS+mhhTzZRDEOVFA2ngIOuWfPukm+kVdnIPcJDxEAN7iNQUAQO3A6SNi1cusjXxKMWatacVV5R/Yq/UnipMEsvtbD4GQbEdDed0AndZ5PqXRld6kqhxbQqzXuImfiHTVaCIvrcnKGKjskl9bw3FLP2Uhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835487; c=relaxed/simple;
	bh=WnPwaB35oqXsP80002Pjpx9cPs2BAejUoSsuThEW0qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWBz4hocabqbTnlGnYnMlxf+9b5++hIzd7Pzl0vMLVK3bafk2FQ1/C6IKyd1v045gswTQbZELuv2gAi8py78WG4Rjq1+hUMqjQgzLUi1cIMuTa23iy9u2YAma1AGeBI398Fa1/QsW1iBVaKF+6Xg/W5q5LFWP0tjdbtmXIvUtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms24x6lj; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2a869d016so12522245ab.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835485; x=1743440285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN/jHxt/H1z9pfytvHl7h9kDce47kQxmXsLuB10CBtY=;
        b=Ms24x6ljpAH8tZqADDM9lw4tngg8Q/skqif45aUABLlH2IT5xpU0Ho/BvM1uaHhGME
         nc7vLlrSeM1pW9ugunZ4StiShe4aX7MtessIYhQ5SvETgYXaeQjzt5C96Rbgs2EVdZW1
         rWa9WTzHb23Fre2622EkA4QV3yXpvPoOQeuF4qNhdvr4cRXyM1u4OHFlQbDfsuAIUv/d
         FcjVvS4Wg1x+QrJtPHSoNhJwESKjBLzYzQfICcfFfVgSfX9/iuI8SH0AZhg2iuMQ1Nr+
         uGyhaYg7vCDO+RFxW7CEGrsmnmw4H/XSopPz1zkaUwVEWk3OVZ7nMxlQ8pmSXGrJF5Or
         t8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835485; x=1743440285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN/jHxt/H1z9pfytvHl7h9kDce47kQxmXsLuB10CBtY=;
        b=rST7+qj5aFPGnWMbVUm0XlVoGHbNW9mAPmDjU8Nv/E551qrVhRiYq4T+kzw9x/VhLl
         r3X/ZFbjmsKF57EMkcBqBk8MwLwVczAjDzzkS/AiTTBBLSOf0XPLWmjL845Mt5lDd+3A
         dwILKjt9UfCBXVdEfbPhJyyDRJ+e+bdpOOlaCtzEdNROtAq+UL9wJFYoTsSViR7zK8/A
         V8f+1jpNAOOS6/FGD88PPSItBE5CXcIWDSI2hfb1tCNQvitdio5feItOMkDTDgtX7875
         Ld+kBgY/o/xj+4epZUz1QJG4O99/YBnHUWPcXPFVgsrw3uOmqWKOc+JdyjWRRq7nOtwl
         CGJg==
X-Gm-Message-State: AOJu0Yw2QVYBVRO/v4AVAvH8MRYS/9iP89an9wmV5zG/4NLi1sCOg/iH
	RKupLy0BT1w+JB9FpkXtQVkzvNlh484aflDkkHaewSrp9xfGD22quLgUKm5PHhmhxXt0iMBMuq9
	+x2fYOfTtL2eRZAnnLPqtuGkv89k=
X-Gm-Gg: ASbGncuWY1bWMtVnO4rISn+jHUshKFRuk0iVm7jRzZYCUK5tDU5tPE6urfLzpqUJebk
	ndHJ1r914yDg9AjcGW+VJwruHa+2rCi3of2XABFpQ0T5CUXboxJplhybyyhp60i1r9EmCCAWgRq
	aJ0B0jsCwHTWysL+2CEK/4/l6nQw==
X-Google-Smtp-Source: AGHT+IGHdrwQWTcETTkUJDk/9vaT3Df4cLT/Mk8eCYR3Df8s3smu3YLy0TYY1SXNdR8auf+H2jA8LNXEqSVFU64+XnY=
X-Received: by 2002:a05:6e02:3f0a:b0:3d5:81aa:4d0a with SMTP id
 e9e14a558f8ab-3d5960f2b57mr139921775ab.6.1742835485198; Mon, 24 Mar 2025
 09:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317120314.41404-1-kerneljasonxing@gmail.com> <CAL+tcoA6uawe99jrkRugrPmgEOsnCAgcqak-2uBO80jMDB+SHg@mail.gmail.com>
In-Reply-To: <CAL+tcoA6uawe99jrkRugrPmgEOsnCAgcqak-2uBO80jMDB+SHg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Mar 2025 00:57:29 +0800
X-Gm-Features: AQ5f1Jp5-aHp-ycaqgv2FYYTviJkNk62jt8umm6jowvGG9HtRJet3CW2qEkSPiU
Message-ID: <CAL+tcoDD-byX4hNWUpDTv6aPPzt3AMHbgZp30V2abADphf7JbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] support TCP_RTO_MIN_US and
 TCP_DELACK_MAX_US for set/getsockopt
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	dsahern@kernel.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Mon, Mar 17, 2025 at 8:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Add set/getsockopt supports for TCP_RTO_MIN_US and TCP_DELACK_MAX_US.
> >
> > v4
> > 1. add more detailed information into commit log (Eric)
> > 2. use val directly in do_tcp_getsockopt (Eric)
> >
> > Jason Xing (2):
> >   tcp: support TCP_RTO_MIN_US for set/getsockopt use
> >   tcp: support TCP_DELACK_MAX_US for set/getsockopt use
>
> Gentle ping here :) I noticed that net-next is closed, so I decided to
> reply to this thread.

Oh, I should have noticed that most of the core maintainers are absent
these days. Sorry, I don't expect to add more burden so I can resend
after net-next is open. Anyway, either way is fine with me. Just
please let me know :)

Thank you.

>
> Thanks,
> Jason
>
> >
> >  Documentation/networking/ip-sysctl.rst |  4 ++--
> >  include/net/tcp.h                      |  2 +-
> >  include/uapi/linux/tcp.h               |  2 ++
> >  net/ipv4/tcp.c                         | 26 ++++++++++++++++++++++++--
> >  net/ipv4/tcp_output.c                  |  2 +-
> >  5 files changed, 30 insertions(+), 6 deletions(-)
> >
> > --
> > 2.43.5
> >

