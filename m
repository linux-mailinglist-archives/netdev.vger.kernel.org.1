Return-Path: <netdev+bounces-124279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE70968C8C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620EE283D5C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B319E96F;
	Mon,  2 Sep 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXVQRA7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA531A265F
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296463; cv=none; b=H6NIcaYChR1u21ztRPlRaMQzOUqIs2/4NQgygGpkBLiB+QE5iTLt4oblJ1HEUxFR73DrLK0m/31EUVB+stKOPj9xfpqIX/dzxInmSIPrW9PUaTfOidFaWIhRtucPYzCwC+wzKDG2plvISbS4GTQITrKAzb2HXA+lwMoYtG2Q0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296463; c=relaxed/simple;
	bh=t3cgJNHVbDKb1zJmQ4enB9xC15b6g33WhNUPCbbKsbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GdhOfrKf0wjtnhJIoeitfIiX/plcvRQg3hf6KSXZ4HQzd1CBf/OisjbvX+Oo0vSdjb0ZT+JAkDrQk9uHpoX2zrnO3lMIkjdxn8sBNK4KWLUh4b9hTOsGvazVkH3ciARl4Milq8bejaaVm+T4DqCvCqO75AQxeKL/YPc7ECK22Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXVQRA7u; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8695cc91c8so443333566b.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725296460; x=1725901260; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3cgJNHVbDKb1zJmQ4enB9xC15b6g33WhNUPCbbKsbk=;
        b=GXVQRA7u0xNYKuX+EzxJBY5f3tlGiDzyTwabYKSxSlo+ReoBcBnqoB5+XW7QLLdatJ
         R7/kbcW5xesg28PGrg1LItarq79pD+tHnfaZcHvnK/JiwsR7OMouDj04D7QrScx+85tT
         XjSch2RhZr69S61UWVhFqi+RQIX/M1qm4oud7ahIhVn+xhi4H6gVALLSwxQ0r5rv6/1c
         6XXxWzobnUB4hIs7G7YIRhjCMWPvdgiYRcts0MEiU13av5m8uw4kZdsQz4Rz1K0/8unr
         6H/s2PAb4u+UR1vvOlj9FRY5sMbQdfUmI+67tbW9TxKYcel7nOnhZrSzlxm8sKUqk7nd
         V1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296460; x=1725901260;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3cgJNHVbDKb1zJmQ4enB9xC15b6g33WhNUPCbbKsbk=;
        b=rRrsre1j3RlUvHFGbABNqRZUu2ZIlkdCOukQjJ1Klc3QRfJmjyqFKtxYlr0oHudlDu
         8qLeShzIIH2Mvl9ryBtYiTDJfbnkd8aMHCJV1WA1uC9qYRtVDI85zClNTx2duO9n8yqG
         qhAqHE28wkwz2tayqGDgUOIyhtxKePiJz4/FvoQXLfxXJiHDOgweoiLCyw87FUsZGpc8
         Hm3PMq3qD10ROhJ92+FkEtDPz1GT1caLnYqtXuB6ZKLl9+qUfbybuhmcbmJTtjMqmA2Y
         wewJXNBuq66AlFAE8f1k9yNu2klX8ktkLfWf3B58e/9Cix+qX+CZU5vXDuR8gT13B68W
         zbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDRQYXdtVwH8nAODsh17SbDT37xDaOxVsSsWq8XuiPwPvEYHJgVqysoHnyewcHOU+u1urvhDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJQUOwyzTbOsVNfjqMbsQnFQAU/+l4XJHVjkKp0irPLLDUsMo
	RXYmlMRKJM+msu5o/CJRnz6G9z+zvwUSPj/R03jncLYYyKi3FKWoYYwBKspmRim4dIY/JxlGO3p
	ttf6/nZCY3lp66kQNz3m4vyYwWXVena5+hT0H
X-Google-Smtp-Source: AGHT+IGC+++a4+oBo4uwdmAqNrgHdgz1zzNCQ/FhWxeCG8dymcSFrVa5Tb3eZwpSUCaL6bx7YiE5zol2P2J3WA+ezaA=
X-Received: by 2002:a17:907:94cb:b0:a86:c372:14c3 with SMTP id
 a640c23a62f3a-a897fa74468mr1186393266b.48.1725296459153; Mon, 02 Sep 2024
 10:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831113223.9627-1-jdamato@fastly.com> <CANn89iK+09DW95LTFwN1tA=_hV7xvA0mY4O4d-LwVbmNkO0y3w@mail.gmail.com>
 <ZtXn9gK6Dr-JGo81@LQ3V64L9R2.station>
In-Reply-To: <ZtXn9gK6Dr-JGo81@LQ3V64L9R2.station>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Sep 2024 19:00:48 +0200
Message-ID: <CANn89iLhrKyFKf9DpJSSM9CZ9sgoRo7jovg2GhjsJABoqzzVsQ@mail.gmail.com>
Subject: Re: [PATCH net] net: napi: Make napi_defer_irqs u32
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	mkarsten@uwaterloo.ca, stable@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, 
	Johannes Berg <johannes.berg@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 6:29=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Mon, Sep 02, 2024 at 03:01:28PM +0200, Eric Dumazet wrote:
> > On Sat, Aug 31, 2024 at 1:32=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > > napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> > > added to napi_struct, both as type int.
> > >
> > > This value never goes below zero. Change the type for both from int t=
o
> > > u32, and add an overflow check to sysfs to limit the value to S32_MAX=
.
> > >
> > > Before this patch:
> > >
> > > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard=
_irqs'
> > > $ cat /sys/class/net/eth4/napi_defer_hard_irqs
> > > -2147483647
> > >
> > > After this patch:
> > >
> > > $ sudo bash -c 'echo 2147483649 > /sys/class/net/eth4/napi_defer_hard=
_irqs'
> > > bash: line 0: echo: write error: Numerical result out of range
> > >
> > > Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> > > Cc: stable@kernel.org
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> >
> > I do not think this deserves a change to stable trees.
>
> OK, I can send any other revisions to -next, instead.
>
> > Signed or unsigned, what is the issue ?
> >
> > Do you really need one extra bit ?
>
> I made the maximum S32_MAX because the practical limit has always
> been S32_MAX. Any larger values overflow. Keeping it at S32_MAX does
> not change anything about existing behavior, which was my goal.
>
> Would you prefer if it was U32_MAX instead?
>
> Or are you asking me to leave it the way it is?

I think this would target net-next at most, please lets avoid hassles
for stable teams.

