Return-Path: <netdev+bounces-156031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42AA04B4D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA7E188837B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C081F709B;
	Tue,  7 Jan 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GQRG/kqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E741E0E1A
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283660; cv=none; b=kSm7AqTvdTQSZit7cir/nyfX4al7dgpfyOCxohkBeVgpfgLWmAMtI/Sgzgbxt2b7Rtp1SFVTieS6GIzOnktVuD86dv/JJyb4cjGbqYwZuitxcMbXfYKv4spquC7XHMSbu4CE6Jc+uve9XCYP/M1UZBZZBtOPptt7y2AzE2L6jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283660; c=relaxed/simple;
	bh=kk3unSyZheC0V/+hS+FuaVqYKPpC8+VmaDd7Y58Auyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG0aaB0xybbOjWvlJZsoKEkoQgfeEaWFPYAv3tqvsYz9e19H+ftxr5rsL67ob711cCA8NWjUzJIdv7KvqJK045Rt1vtOTaZaQyiweQ7dYnfFjNxldF35EBarua6q9hpMBRHVK6mxZ2J2r7GJ52iyWnllBkb4hW11qzVlSmGZa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GQRG/kqD; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso24351005276.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736283658; x=1736888458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTRCI6GeKO8nmjat71FCQBtUAsurZfCpmHbpENd+8x4=;
        b=GQRG/kqDrLFTK7/hPbCtac1u5wFjQgVuJ/1i0wnao1c4/dBKXaprpUZknluMTQbnOB
         KNW/AhRJTAJgJWvzwufCKEWsqtfVvgLdrjTZ6Wanft2pw/sULFzA8ldAmi1XERqgooCP
         zyhLbXXsivvyU5S6ZTkfonIAJzG4idQsStD8R7Vv263ggPTmxlnVrKo63IviPtIO0VID
         meZVw89FdS0DzJhB7XCDOKEagT4wI+FHWP8+KSlFTyo4xNn6tHN3YSHfKylBc557DpaB
         ZgwT87WXP8U8wPnt65qyqKJropDOwQOpZ1FgfKIU+txFTtR0irsHSPhgu8xMcVeyWM8K
         qu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283658; x=1736888458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTRCI6GeKO8nmjat71FCQBtUAsurZfCpmHbpENd+8x4=;
        b=XOxLqIcwTIZjjQOFkju9UmxyXlgAczzqMggBLFijwXtTUsaN/FPO+HxgJv9SxCXy/m
         w05Ej6IR9L3a964qUQbbSOnDAkX1MSuL5K375wvkcoVjoMP0CfKWvoFWhz95UpG5YNkF
         ZaAe8xVpKmf7P5+CKEjvBVRG2W15V5T0AGqMDAXAt6T8LRzaKar02fGYjeVgSctWWocw
         nuviUCDsGziDa96BwIZM82DIg1gQkjKQVgdst5oMIK6I1i6roDfl2msCoDKIrrDt8ltD
         vSRDi/2b10mXYUJUmhor7r6JrEm2Wqr7t2kCQ/ELTXv3Zl2Kdv+71NTxBQCgvpNW9nUn
         psrg==
X-Forwarded-Encrypted: i=1; AJvYcCUHvll77YCMQaB4XbniavAGxS9NhqMvsOWw+b/ssk1c/Nt07O7aOYAK3PwYzUTAlmVJLcnVW24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7boBb6YganqN+AcXRWv+F90PSBvDcjnS//vBAw/oHpQIbgN4
	kHiy4mqWej2p7wTUAo9y9slO6axs6db0+9gzRL4lM+f+c2V4kkPATNS+FOQJQtwJTIQQQVuNniu
	vNos2kbR2i4v59tJyhJ02Cimf0tkCaQqFGEQj
X-Gm-Gg: ASbGncvmpoSzvvGNpKg1vrI3gdtLJJE9eBi7B3idexiaF2V3Y2kWTsDXWx1HQ1FKqVS
	MDoU2QNqDnaA+jbJHKwZGCAAOhKvpSZeEE5u9
X-Google-Smtp-Source: AGHT+IFmaVoJpaDvO7/MOKHCuRbJfCT5zI0dt2YSI5Ep5ECUqR8/eX1JX53lPvQV/AZxRrS2zCEX4lR+D6XdoY9RNzQ=
X-Received: by 2002:a05:690c:c8c:b0:6f1:5591:2c6a with SMTP id
 00721157ae682-6f5311ef109mr4151317b3.3.1736283657623; Tue, 07 Jan 2025
 13:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net> <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
 <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com>
 <fe8fe02f-db3b-a4a2-508f-dda8b434d44a@huawei-partners.com>
 <CAHC9VhRT3VSvWbecSa5pnWMUkgmFVCAiMn=OtguHr_GCYcYbzw@mail.gmail.com> <CAEjxPJ7+13QMFefy9uKYr449db2pi66CU-0GOFZ+BszpQJcStA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7+13QMFefy9uKYr449db2pi66CU-0GOFZ+BszpQJcStA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Jan 2025 16:00:46 -0500
X-Gm-Features: AbW1kvbKY0tiuQW9Lszmf97SZLoFUcFobv68YqAqXZxY-6Xyv0DoqdFsUvIwz44
Message-ID: <CAHC9VhQ4sQYRriRA-NMPBhUdN9Abb439oxTz5EQtEKJHNv=Nug@mail.gmail.com>
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	selinux@vger.kernel.org, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 3:16=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Dec 13, 2024 at 3:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Dec 13, 2024 at 11:40=E2=80=AFAM Mikhail Ivanov
> > <ivanov.mikhail1@huawei-partners.com> wrote:
> > > On 12/13/2024 6:46 PM, Stephen Smalley wrote:
> > > > On Fri, Dec 13, 2024 at 5:57=E2=80=AFAM Mikhail Ivanov
> > > > <ivanov.mikhail1@huawei-partners.com> wrote:
> > > >>
> > > >> On 12/12/2024 8:50 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > > >>> This looks good be there are other places using sk->sk_family tha=
t
> > > >>> should also be fixed.
> > > >>
> > > >> Thanks for checking this!
> > > >>
> > > >> For selinux this should be enough, I haven't found any other place=
s
> > > >> where sk->sk_family could be read from an IPv6 socket without lock=
ing.
> > > >>
> > > >> I also would like to prepare such fix for other LSMs (apparmor, sm=
ack,
> > > >> tomoyo) (in separate patches).
> > > >
> > > > I'm wondering about the implications for SELinux beyond just
> > > > sk->sk_family access, e.g. SELinux maps the (family, type, protocol=
)
> > > > triple to a security class at socket creation time via
> > > > socket_type_to_security_class() and caches the security class in th=
e
> > > > inode_security_struct and sk_security_struct for later use.
> > >
> > > IPv6 and IPv4 TCP sockets are mapped to the same SECCLASS_TCP_SOCKET
> > > security class. AFAICS there is no other places that can be affected =
by
> > > the IPV6_ADDFORM transformation.
> >
> > Yes, thankfully we don't really encode the IP address family in any of
> > the SELinux object classes so that shouldn't be an issue.  I also
> > don't think we have to worry about the per-packet labeling protocols
> > as it's too late in the communication to change the socket's
> > associated packet labeling, it's either working or it isn't; we should
> > handle the mapped IPv4 address already.
> >
> > I am a little concerned about bind being the only place where we have
> > to worry about accessing sk_family while the socket isn't locked.  As
> > an example, I'm a little concerned about the netfilter code paths; I
> > haven't chased them down, but my guess is that the associated
> > socket/sock isn't locked in those cases (in the relevant output and
> > postroute cases, forward should be a non-issue).

We still need an answer on this.

> > How bad is the performance impact of READ_ONCE()?  In other words, how
> > stupid would it be to simply do all of our sock->sk_family lookups
> > using READ_ONCE()?
>
> I could be wrong, but I don't think there is any overhead except on Dec A=
lpha.

Then perhaps the right answer is to use it everywhere.

--=20
paul-moore.com

