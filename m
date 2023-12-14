Return-Path: <netdev+bounces-57600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72081391E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19F1B210E5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B12675D5;
	Thu, 14 Dec 2023 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhQm0pF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD3114
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:52:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so341a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576361; x=1703181161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov8rtdXq77gRI0TyhF6eXS6igX3xXdrwKRnYsA/1oIk=;
        b=uhQm0pF+eDJZzIBxtlV+UjEPjDZRLZeYsPl7bKoUV1237uUeW6TrTC90ZYpGVCbl2J
         Jd4VQlgPeNwG8pujnHskwRv8vI/B11VF/FcAYY9LJSsReBDLEhpiarz8qs10qGgonp6x
         apFZHpmHvkVeUfoWIwixYR2lfodM0H0DRDC3jANn/MBbcP9t5E+PqqZ/WB6gxOQpPUgZ
         wCoNEmin2k5Czc8eN+F70GFdR40pFK/ahccUGZwuy/Sg6Gu7IpHsXQfOa7kDY0CAfRPi
         5fuBteQb403ZNY1WGRCWz97vEv0Tj1IncMghL27yfxljZWlFVbbHei2fAMmHbO8BnYMy
         aXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576361; x=1703181161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov8rtdXq77gRI0TyhF6eXS6igX3xXdrwKRnYsA/1oIk=;
        b=XEcMfzUDUrevCaXrZ3uKvRvm+MXZiAPhJseamE3v3pwSn5IeZw91wL+b3sgEo8dEEc
         2FjQfiYCvvIcAzPsYs8s8a2gGWgcTJF0M0WfK7O28pxCo+syZMcb0S5RFECgGTzGd/YA
         qA09hPoP5KzpKOS1M2Ec5MXyTCG71f/BUXrjOaMQ8PXFLTOZ4Edv/p2MnGXwjvg4jKLC
         gn15uSlvo8RoO+xRTcy/XA0NqVtoTCH6gfN38HQICW40tFaAFqP4BYvqjiAguXSmmvYL
         vKtlvpf5uFFajgXYXvTrphJRWDBwFY49U0uXuYt36VXLp9iCIGO+y7IVGqMF3CO4hSLv
         NU2w==
X-Gm-Message-State: AOJu0YxUoMsx1fgHXfs9IBmEHZdt7QGIiIhAsnxCDQkMVBWthn1XP320
	UQTqcMzB0JpCsYOVD+oW2KBcHuLQmMN7J74PVw3WZg==
X-Google-Smtp-Source: AGHT+IGsLGMYGyP0Ojd6JLnl9EafOhHv/uDsZXAMC7TC1r9WXyj/dMOqHbsTI3pfd11vgZtRRX7Y3XOAB1CtXBHlX+M=
X-Received: by 2002:a50:d601:0:b0:551:f450:752a with SMTP id
 x1-20020a50d601000000b00551f450752amr261712edi.6.1702576361098; Thu, 14 Dec
 2023 09:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210111033.1823491-1-maze@google.com> <ebf480701cd22da00c89c5b1b00d31be95ff8e4d.camel@redhat.com>
 <CANP3RGfk6PqR2P8HnGX92ODnf6V5iKb+_zjonOsTDOB-3odM5g@mail.gmail.com> <8e2475cba51a078e0e12c219d81ae8f14e2196b3.camel@redhat.com>
In-Reply-To: <8e2475cba51a078e0e12c219d81ae8f14e2196b3.camel@redhat.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 14 Dec 2023 18:52:24 +0100
Message-ID: <CANP3RGf3_TGz-DCYm3d3+3XaM5w9GL+KWLTOf5YtPRnqcWjLXg@mail.gmail.com>
Subject: Re: [PATCH] net: sysctl: fix edge case wrt. sysctl write access
To: Paolo Abeni <pabeni@redhat.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Flavio Crisciani <fcrisciani@google.com>, "Theodore Y. Ts'o" <tytso@google.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2023-12-14 at 14:17 +0100, Maciej =C5=BBenczykowski wrote:
> > On Thu, Dec 14, 2023 at 10:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >
> > > On Sun, 2023-12-10 at 03:10 -0800, Maciej =C5=BBenczykowski wrote:
> > > > The clear intent of net_ctl_permissions() is that having CAP_NET_AD=
MIN
> > > > grants write access to networking sysctls.
> > > >
> > > > However, it turns out there is an edge case where this is insuffici=
ent:
> > > > inode_permission() has an additional check on HAS_UNMAPPED_ID(inode=
)
> > > > which can return -EACCES and thus block *all* write access.
> > > >
> > > > Note: AFAICT this check is wrt. the uid/gid mapping that was
> > > > active at the time the filesystem (ie. proc) was mounted.
> > > >
> > > > In order for this check to not fail, we need net_ctl_set_ownership(=
)
> > > > to set valid uid/gid.  It is not immediately clear what value
> > > > to use, nor what values are guaranteed to work.
> > > > It does make sense that /proc/sys/net appear to be owned by root
> > > > from within the netns owning userns.  As such we only modify
> > > > what happens if the code fails to map uid/gid 0.
> > > > Currently the code just fails to do anything, which in practice
> > > > results in using the zeroes of freshly allocated memory,
> > > > and we thus end up with global root.
> > > > With this change we instead use the uid/gid of the owning userns.
> > > > While it is probably (?) theoretically possible for this to *also*
> > > > be unmapped from the /proc filesystem's point of view, this seems
> > > > much less likely to happen in practice.
> > > >
> > > > The old code is observed to fail in a relatively complex setup,
> > > > within a global root created user namespace with selectively
> > > > mapped uid/gids (not including global root) and /proc mounted
> > > > afterwards (so this /proc mount does not have global root mapped).
> > > > Within this user namespace another non privileged task creates
> > > > a new user namespace, maps it's own uid/gid (but not uid/gid 0),
> > > > and then creates a network namespace.  It cannot write to networkin=
g
> > > > sysctls even though it does have CAP_NET_ADMIN.
> > >
> > > I'm wondering if this specific scenario should be considered a setup
> > > issue, and should be solved with a different configuration? I would
> > > love to hear others opinions!
> >
> > While it could be fixed in userspace.  I don't think it should:
> >
> > The global root uid/gid are very intentionally not mapped in (as a
> > security feature).
> > So that part isn't changeable (it's also a system daemon and not under
> > user control).
> >
> > The user namespace very intentionally maps uid->uid and not 0->uid.
> > Here there's theoretically more leeway... because it is at least under
> > user control.
> > However here this is done for good reason as well.
> > There's plenty of code that special cases uid=3D0, both in the kernel
> > (for example capability handling across exec) and in various userspace
> > libraries.  It's unrealistic to fix them all.
> > Additionally it's nice to have semi-transparent user namespaces,
> > which are security barriers but don't remap uids - remapping causes con=
fusion.
> > (ie. the uid is either mapped or not, but if it is mapped it's a 1:1 ma=
pping)
> >
> > As for why?  Because uids as visible to userspace may leak across user
> > namespace boundaries,
> > either when talking to other system daemons or when talking across mach=
ines.
> > It's pretty easy (and common) to have uids that are globally unique
> > and meaningful in a cluster of machines.
> > Again, this is *theoretically* fixable in userspace, but not actually
> > a realistic expectation.
> >
> > btw. even outside of clusters of machines, I also run some
> > user/uts/net namespace using
> > code on my personal desktop (this does require some minor hacks to
> > unshare/mount binaries),
> > and again I intentionally map uid->uid and 0->uid, because this makes

obviously this was meant to say "and not 0->uid"

> > my username show up as 'maze' and not 'root'.
>
> I see, thanks for all the details.
>
> > This is *clearly* a kernel bug that this doesn't just work.
> > (side note: there's a very similar issue in proc_net.c which I haven't
> > gotten around to fixing yet, because it looks to be more complex to
> > convince oneself it's safe to do)
>
> Indeed the potential security related issue is the root cause of my
> concerns here. I could not identify any such problem, but I must admit
> the uid mapping is not the kernel I know better.

Oh, I'm not surprised: It took Flavio (as the affected user) and I
~two weeks or so (and dozens of back and forths with test binaries
with more and more logging and different approaches to doing things)
to figure out what was going wrong.  Ultimately we only succeeded once
I managed to get the test case running on a semi-isolated dev machine
with the full userspace cluster stack and a printk instrumented
kernel.  It was certainly a head-scratcher...

> I definitely could use another pair of eyeballs here ;)
>
> Cheers,
>
> Paolo
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

