Return-Path: <netdev+bounces-240999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D3C7D4AC
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C115D3A7F94
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04651150997;
	Sat, 22 Nov 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="viAECdnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4E2AD25
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763831806; cv=none; b=Dy5lI/bFhPp5ePxZu2vKCD1JVcS33hwCucYW/LZgFsZti2CaDCN31TYxBO0d8IE86I/6kDQe/I3067IVtB1X5ebs+1fghSEhMS2xewKb/4+mDu+BJmA71acWT8xrQmftHobC7fMODjYFSvDJYaL/E7YX00j2R4ewQ4Gpri5bQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763831806; c=relaxed/simple;
	bh=gG6EdQ2Now9tJKxmh99T8C3R3yFJ//sVYl6zY+ZM+zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKn9wb0id3/9uKTz3pujpIQOP8slfuwMfxQjI4od/OuQo4rZw5Lu1JvNgnBtPnYpnDgunKGqPRBHqR3eXNGK2E8qqYPpC8wzCYbE2MVWejHL1NxhEvn5t4iQBWYpgrXadafzPDECj7FjgsGAcP4tZ3gU63/gLT/J/Oe2DcYAu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=viAECdnb; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63fc72db706so2545300d50.2
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 09:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763831804; x=1764436604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG6EdQ2Now9tJKxmh99T8C3R3yFJ//sVYl6zY+ZM+zE=;
        b=viAECdnbENQ1d+ToAm5yxZeerIWyZA01ZaqCBpHdGOp51Ge7NA5YgBYPmNJTcwkd+x
         UfZ5AhWqRDUaqZrsVcX7W8nrW+tMiZkarA20dzYKt8OXimZ5dcP34PCAHARXo20VyY5M
         DWHpDdF8KVdRwyUfp7C+SOq8w3HhhmL1blJnQb0t2aTaXF5M74SwwA4CHQxrpX15tHby
         4wN/bnaXct09Ph+a6D+LShP2mZytG0W7Koon1lEUkW1kHMhFO823Mb1FnL71Jx2oA7hy
         IKXVLwZF7wYpe5DoN2upGdi+mfyReNg+j1v0WEeKPTjjgzUsnHkexQ5BrzXH5HdIDVJy
         WDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763831804; x=1764436604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gG6EdQ2Now9tJKxmh99T8C3R3yFJ//sVYl6zY+ZM+zE=;
        b=jxtruTei7/Hqe6JR9yNWjf8QUPUNwtleNJVPUAK2KJefgdQ8Y+FAKUhINF7ZJyY5Fg
         rpMXv9ZH5PW3ZQZVcTBuMwgixB4SuqgRgki8L3sKUyfIvrvn1WU47jAWeBzW1MwwMI3z
         uinmH+dEsd9RPwfeRTHzn4gy8Jrnaiw8sREQjxs/WdDHKcwzgAFqVE1EycT+hELZc/bx
         fue27TIPUlK8HgNhrAresHG0txAXgJm0K7DnU91qFV64hK1lPmV4GpczfAxCtGcqTsVi
         NjttdKXOaYb5zTZj7L0sxJWaik4BBfH2SozDqeZwVjQ0ewSRQLBj4tvE7uYehlcblQmH
         uvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS8vNyj/mM6b3uGjNdnr8dSWNlA4SzREj6GPtbtsLM3wYFSg62CIJJVxtEFI1TPJtY7Tp338g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRUHiN8m+dfS92QryGQLT4xE0IsZ6pRZj7IjT0eFoBto9iKyI
	147XqP+rZ55Dsn3lAqiaAf2NljYf1QbuoOZy7o8vgu5vL11OrDYsYHqzafPMuOyr9XQkjgTKp3S
	J+CqzQpdkBNZJRO7oyygKuXvy/DfYb6g2+yoftk9P
X-Gm-Gg: ASbGncvHkqOYdqxsoDX1HClo9ftEmqtrHDVWf05LkikgskwD5W6rcLAkll/OC9UT7Iq
	I5E4n5Fb3u7nCI6Si4YP1QMPURty4TQUOpESy2oe13pLBHVx59lRp/2minlTFniFrkfl8a8Ih46
	wTruCyAL/kCnyNZCOwjwvJVX5qoRphyV5ccGK5JS2rZEBXnrPHXH83DPtbIgOII/GtnrrJutqbq
	ylcBKX9X+JXWJECnCq9XpLoTx63ZdsKla3PtO+S8bkcWcSYzha4HmayuPBfZBcmo+RgEOaP2nQH
	ozFKlbJJ/vJ+LQ==
X-Google-Smtp-Source: AGHT+IHK5rUR9perKRLa2hqvo0xMbU0NPIit4ZRIRAIMQWnrSZ1pjbue5IDqidsDail2xWUXo1Fx8TNMPIv9jSWEbw4=
X-Received: by 2002:a05:690e:1482:b0:641:f5bc:69a2 with SMTP id
 956f58d0204a3-64302b43c48mr4251080d50.80.1763831804084; Sat, 22 Nov 2025
 09:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
 <aSDdYoK7Vhw9ONzN@pop-os.localdomain> <20251121161322.1eb61823@phoenix.local> <20251121175556.26843d75@kernel.org>
In-Reply-To: <20251121175556.26843d75@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Nov 2025 12:16:32 -0500
X-Gm-Features: AWmQ_blEgxQqjqbPca4g4IIx1fXgMdgr7MKgDDF7zmrM2MHksKZScsuwUie_Toc
Message-ID: <CAM0EoMnoocCVQbky3NQZt1kkHbEYsKgTEspBd4YbfqmSd=1=wQ@mail.gmail.com>
Subject: Re: [Bug 220774] New: netem is broken in 6.18
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, will@willsroot.io, 
	jschung2@proton.me, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 21 Nov 2025 16:13:22 -0800 Stephen Hemminger wrote:
> > On Fri, 21 Nov 2025 13:45:06 -0800
> > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > > On Fri, Nov 21, 2025 at 07:52:37AM -0500, Jamal Hadi Salim wrote:
> > >
> > > > jschung2@proton.me: Can you please provide more details about what =
you
> > > > are trying to do so we can see if a different approach can be
> > > > prescribed?
> > > >
> > >
> > > An alternative approach is to use eBPF qdisc to replace netem, but:
> > > 1) I am not sure if we could duplicate and re-inject a packet in eBPF=
 Qdisc
> > > 2) I doubt everyone wants to write eBPF code when they already have a
> > > working cmdline.
> > >
> > > BTW, Jamal, if your plan is to solve them one by one, even if it coul=
d work,
> > > it wouldn't scale. There are still many users don't get hit by this
> > > regression yet (not until hitting LTS or major distro).
> >
> > The bug still needs to be fixed.
> > eBPF would still have the same kind of issues.
>
> I guess we forgot about mq.. IIRC mq doesn't come into play in
> duplication, we should be able to just adjust the check to allow
> the mq+netem hierarchy?

Yes, something like that - but imo it would be fugly to do that check
in current code just for mq.
I proposed to add another qdisc ops which checks for cross-qdisc
semantics. This ops will be invoked by a qdisc's change/init - sort of
what pci quirks ops does. For example in this case it will disallow
setting up netem when it would cause loops but have the quirck checker
allow multiple children such as with mq with as long as none is
looping. I believe some sort of "feature bits" checking should work
here.

The majority of the bugs we are dealing with follow the formula of:
a) create a nonsense hierarchy of qdiscs which has no pratical value,
b) start sending packets
c) netlink cmds to change hierarchy some more; It's more fun if you
can get packets stuck - the formula in this case includes non-working
conserving qdsiscs somewhere in the hierarchy
d) send more packets
e) profit
Current init/change are not really designed to catch things that deal
with children or parents, so catching #a or #c is a challenge. We do
"make it work" eventually but it keeps adding these "checks" for
nonsense setups adds more unnecessary code.

Perhaps its time to start this effort and use this specific scenario
as a use case.

cheers,
jamal

