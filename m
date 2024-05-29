Return-Path: <netdev+bounces-98929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F708D3252
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351F71C211CF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C2168C1C;
	Wed, 29 May 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MQ3ElqNr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EF1667E7
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972785; cv=none; b=BZyHDdYtcBpBwS2rF8/ytxdhHqoznxnhXJKPVAX5TkXDCwao6Xylnhb8CeLx7shCUMNmDF2Mi0NqGJ9GDXyP4kVn8xDYiSNebHnjkGAefm8hxXyBpHotPLpvFzcHiwlcWithQrlVR2j/p+yrRrGCMXDlimsKzH5knE6lMK3Fexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972785; c=relaxed/simple;
	bh=QCfVXtnCs7WY3k2qMYQ4vLPo1KSeBO4uzrNDFx+BWog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKEUS/wKE78AuV+So5syS1CdOcg/AgzZeXZS74UZ2uN8DUnf0q2AcBVM7VBbsn3oEqOL8ykUKau944zSAmHS70YSfNvDQ7eR+6HZM1KuUe+FILk1z/Px0mY9aTYfqrOEhk3q1LMduuWU/lARVqXGZrADoC38cthsaSTDHLPYzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MQ3ElqNr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 941443F283
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716972780;
	bh=QCfVXtnCs7WY3k2qMYQ4vLPo1KSeBO4uzrNDFx+BWog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=MQ3ElqNr8PS7NiwHu9Pr6qzQ3kbyjy0FJRaiYDvf5b9/kGro/o9Sq41HTJMjMrCgf
	 zrR1H5m5c/slKXHundIDzQjbXeif/wh3/lWbIwM86ubl1q6EBgcUoVNm4RLMiCs3R/
	 NuecBnTZodMyhz3UAJ5DN5DBK16B6ssYVxp3AaQsHu64yFRSbRuX+bjj/WSAZ35TNR
	 qxccNYxIG4DLOs4EAOrTtCydn1j8NHIoNp+HzDo7+YoRV/S30Iw+ZGd7yCMrTn4bkE
	 f3dfbc7hx25O9R2/SAYkjjGTv6MbLFn1siddcninKiTDud2nUXiD8M4+PN743F0LdY
	 d8LzUi4diAD7A==
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48a33435bb5so750605137.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972779; x=1717577579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCfVXtnCs7WY3k2qMYQ4vLPo1KSeBO4uzrNDFx+BWog=;
        b=o5JJYBGHHaq3AOhmPoISaTlSfXbNv7ghD3xzrXkMegnY3gLz8zR/qNPKpxn17snDST
         mWzg3iypkACDW9mlTZ4LiIuxhsTSUGs5KrhLhvTmhJRFBVsnuguRS/NJop7NRYvQCCuX
         97BUffvzJcRa3RWY4v5LUTuB76wI+RYsRcsDEe1UutlJwAzLC3pnrXVbeB63FdbEyErI
         bWVahUppUp5t7WxCmwz1j5sYOnf36Z6fcpM96MDtTn2T+zgbxq/ZfX2dUfZN1yO7q7gF
         jv5RjYlxfrCLopi6cch/XNQdTNNY7RW4l6zBq3b70RvRQ9qAd+0erQCJru3rfIdNe6Gj
         kVdw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ykBafi2EMc4bJXq/D/G6hKGpgNrE7cWntwJqqaEDqhj6VotSiwgBwBQrR+B9kbRHTGBDGNohpRl1UV1Nyjox8ur239D+
X-Gm-Message-State: AOJu0YzRtHRl+YlceLRNKXK7sYspWKbtsV4ngtpdPgMOrNpu4Fq+wnm6
	uXJoxI2Hvo3WtEkD/CS9htJuasxq/GvvCkwQ2Js4rqqVak/MnhcJ6KucZ1rRVni0jdKKZ4Jlm7O
	E7vITkWxUO43mtV6hkzg1urFHYvO/4SrDPXq6E7JEqNcv13uHwaX4oRXUSwIPP1n4/usrSnsVgA
	XunRORA1/Ixeas+hF8wRxAjTY3Nt5OIP+6Dd7fmgtN4kBH
X-Received: by 2002:a67:c785:0:b0:47b:9a99:1095 with SMTP id ada2fe7eead31-48a386578a9mr13864465137.22.1716972779559;
        Wed, 29 May 2024 01:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBU76YpQlFY2UJv0tgEjKDgWppXEyfB71ym+oY7J1c/WWZcbXXSNxBYobvE3FHejzdUgE+u4qAdOFVsGnbUdA=
X-Received: by 2002:a67:c785:0:b0:47b:9a99:1095 with SMTP id
 ada2fe7eead31-48a386578a9mr13864453137.22.1716972779220; Wed, 29 May 2024
 01:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
 <20240529-orchester-abklatsch-2d29bd940e89@brauner> <CANn89iLOqXZO_nD0FBUvJypgTA6NTL2dKvXYDxpMuZReYZXFDQ@mail.gmail.com>
In-Reply-To: <CANn89iLOqXZO_nD0FBUvJypgTA6NTL2dKvXYDxpMuZReYZXFDQ@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 29 May 2024 10:52:48 +0200
Message-ID: <CAEivzxccCgT17u45c3fRG4=+X-rxLz04L8+B5B4GD=weA5khmQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
To: Eric Dumazet <edumazet@google.com>
Cc: Christian Brauner <brauner@kernel.org>, kuba@kernel.org, dsahern@kernel.org, 
	pabeni@redhat.com, stgraber@stgraber.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:29=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, May 29, 2024 at 9:49=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Tue, May 28, 2024 at 10:30:30PM +0200, Alexander Mikhalitsyn wrote:
> > > A recent change to inet_dump_ifaddr had the function incorrectly iter=
ate
> > > over net rather than tgt_net, resulting in the data coming for the
> > > incorrect network namespace.
> > >
> > > Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_d=
ump_ifaddr()")
> > > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Closes: https://github.com/lxc/incus/issues/892
> > > Bisected-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > Tested-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > ---
> >
> > Acked-by: Christian Brauner <brauner@kernel.org>
>
> Thanks a lot for the bisection and the fix !

Thanks, Eric!

>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

