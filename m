Return-Path: <netdev+bounces-89310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E18A9FF7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26DBB215FD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCD4D9E8;
	Thu, 18 Apr 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+CHaPcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CB16C84E;
	Thu, 18 Apr 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457462; cv=none; b=mB0c77g69R+r/u6dgQmXq0nBLBxzdVRhHrd1zw5oubbSZ09VMRa8wat5Y6sGuch7LqOB3RXqEelpcj8D3LOD1Q04jZRhQ0JKJMvzsKT2u6jAWzaa3lzQa6YMG9y6SV+OeiOS4nRGFPrKVbj0tKuWhLrGOe/luhT0tKIXCjXNWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457462; c=relaxed/simple;
	bh=T+dCC6mPrrDOxsePc+Ywm2CcOIrhdxqCNx8Dn1/Sgpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUBtbvRsPaBdSbCd7WeQ6w2sct9GEaW0DMrlnBzP+mXoy1RdPHACZDYiDLMmK3nG6hJqgXRnsGYNVBs7uFQ+W2yJh4Nrj7oKxPRicW/P9A7hgUrwuMbPwZlG8i1OG+P0BDZ9v8OaUqQcl3y3rKQ2ML2lVbJ2VNWDgEFgJ465zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+CHaPcm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516dc51bb72so1303706e87.1;
        Thu, 18 Apr 2024 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713457459; x=1714062259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+dCC6mPrrDOxsePc+Ywm2CcOIrhdxqCNx8Dn1/Sgpg=;
        b=F+CHaPcmKVSxp+TjwnPoJRkIsd18yYe2Lf9DoXVUXUZOB2U2K6fBuXi44dvUbfrjJL
         DS4cNpb6at8Kgc1W16CEi4L2fP0fTjmBlBogHBQf9woHUoQ3mmP78tOARtsT6mCtdHGr
         WrIRYmStGK4ZMDnqVEfGdl2umFMtTCvc8VP7Y9oLDe98xmd+pQ7pHmoqiNB8ajKdcS0X
         k/m5gasTZK4vXmG+XOGBPbLKObbohDaxEBFxhHtaftk8tf0pkhPKmh1ia02ibD+9FkIx
         lUJ0vqirHszBl2L6CrV18UzYDPKGavqkEmYcA/jJIBUu/D8n7wJQkRQplKpO7t0h3uGj
         XKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457459; x=1714062259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+dCC6mPrrDOxsePc+Ywm2CcOIrhdxqCNx8Dn1/Sgpg=;
        b=e6u15yhNqqUj+tTKW1zuNl0linRNEq3ZmA10E4sE4ye5TS3Gc+CaAA9qITWn2KJaL0
         qARDNWEHdU7fi21TkxF46hoPmZtQORh8zO7voegAfF6zutwX4uDC/mzuGG3RUCIijiog
         5e2C2B4TitrEa6mnwDTitp5lrhVSabDwH0TLTtMuSdyRjVoJjNkKPZ34dmhMQ3ZBAGed
         QTrX1/C9tc9knGeQXHbI3fyOOgvzl6msx/rsNUVt1WFtR6QHzgaInejCw9SoR1Bnc4k2
         p8HUK5Ls/14726Vl+fGTRO/F1mif7enjYoldNG1VVP6I66PyDdEnErTwLEZNzENCRLoL
         ng/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUanmlTbf0Cfq5FCWEIezsvyQ7I3YDO/l9QG/+QKGPuh7k5Ssw8uVJiuPmc/ReFQFU3LUdCuJBbzTUPu92wHL8Jhd4wGzy0N34DCd181ObjxSuVyqZ71pFIB2dkWk0sXVNkXU5tinpcHick
X-Gm-Message-State: AOJu0YxUBeGAITqnXEvfL4ZoHsXGH+XD/y/cknFRtX1pCrdKgT0yV/X2
	Kf3x21qhtvxatizsVPeD/tArgCCgTj7ortDjiO+FBScdd7tVvYCIMrQGPZR4/S3L11iQ68JKwb/
	o6JKqbvT4hWjWU0IeY8DxQWIg5P4=
X-Google-Smtp-Source: AGHT+IECeTUNMOsaM6aXlpQzxaYVOTDkwSlJTUZQZfQwVQMaXBs3ulVIy6NOXQ1XJO3G9OMC8ZWm+Jeohz7lAnqY62E=
X-Received: by 2002:ac2:5501:0:b0:516:c8e5:964e with SMTP id
 j1-20020ac25501000000b00516c8e5964emr1954011lfk.21.1713457458599; Thu, 18 Apr
 2024 09:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com> <20240418084646.68713c42@kernel.org>
In-Reply-To: <20240418084646.68713c42@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 00:23:41 +0800
Message-ID: <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > I'm not sure why the patch series has been changed to 'Changes
> > Requested', until now I don't think I need to change something.
> >
> > Should I repost this series (keeping the v6 tag) and then wait for
> > more comments?
>
> If Eric doesn't like it - it's not getting merged.

I'm not a English native speaker. If I understand correctly, it seems
that Eric doesn't object to the patch series. Here is the quotation
[1]:
"If you feel the need to put them in a special group, this is fine by me."

This rst reason mechanism can cover all the possible reasons for both
TCP and MPTCP. We don't need to reinvent some definitions of reset
reasons which are totally the same as drop reasons. Also, we don't
need to reinvent something to cover MPTCP. If people are willing to
contribute more rst reasons, they can find a good place.

Reset is one big complicated 'issue' in production. I spent a lot of
time handling all kinds of reset reasons daily. I'm apparently not the
only one. I just want to make admins' lives easier, including me. This
special/separate reason group is important because we can extend it in
the future, which will not get confused.

I hope it can have a chance to get merged :) Thank you.

[1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8F=
rfRvaa-Vg@mail.gmail.com/

Thanks,
Jason

