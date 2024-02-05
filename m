Return-Path: <netdev+bounces-69030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44884942C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 08:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490491F23CD2
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC28F40;
	Mon,  5 Feb 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcDTo5or"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C219B10A0F
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116836; cv=none; b=Jmq3IuAfZE9zfdA6S0v7XmTir3eXiQEoOFHZEKiZ9Hw9NcIEcJSyvSz+O3ga8MFhsTBVPvRAy4cLiS3TyurqaukANLDtJUWwSeJc+WKTrEAfSSqS7yAMrSzBCpmiMdcx/Xp2R0tJF5sV/Wwo861f3c023t6mp4eU/uZp3grk6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116836; c=relaxed/simple;
	bh=W1ozcxcsl57el6EBEv2Sc/up6i1rj3mh5i0FJiLz4oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKRKXR5d33sgUbHHgbbheuw6lzxyUhYfijy75qgqUw7FQ3l6P2Zkzx0Xpb/BTIN5WIjb9T+CopsizQsm8PPISwnV82J3lIykRm54OCEOl73VDUNUHVLqhjy3E2W5n5Acc8TeH65QrPxZs8c0H1Qbnl8PYR8HgFnQPvsDoQHSUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcDTo5or; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783cdbecfe2so155749485a.0
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 23:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707116833; x=1707721633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKLaWHBzrYKoHLFTS8xTgmdy0bnBnc8c6jxKJlp+pQA=;
        b=gcDTo5orc4o3OYqJ5MtnHYFKsG301rMa1aUgqi+CjTJGJUkqOXWNHFZa9q3oTxWuLr
         +8jd6LjUzLBq4iDZBoVM86veKxYIRJ7RYkusrCKF2mINomA3Jeaw+pMNfHNp4P2n/btx
         kGKtNDlgh7kyOlJF0HeUMzxu+BEOP9TwVB/plAcl059AjFGELI/U9jkonPSMX6yZdM+Y
         vCKNW0dBBxga1bsX9U40lyhH8mP7ovqjDM84VrppELeU8KDVL2dfyVSyEJJ5trG1eT9c
         3dJVlp/OJEi45kTZy4gSTb59DfHOVt0sCwhR+1pHiV+7XvfggtrJh4elcBkYetXFZucZ
         oe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116833; x=1707721633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKLaWHBzrYKoHLFTS8xTgmdy0bnBnc8c6jxKJlp+pQA=;
        b=a4UxTO3LjPdmFAAdxnUgu7GowI+1swMosks3w528DsZwmox1cwzRp1R2tG3/cGB0Wc
         riHtfDxAYwAddBz89VIsEYfYjrTnTlkXvv49dUHRKc2UwQtzxiTq0w3AQTBy8W3ZgMC6
         sS2BtOFGvMjAd8x3aqFrFrNK55j4iTog0VVJea+/xaKrFLrBCpGZrLm8YAX3dqr6EL5t
         vNY0Xv2JkbhFd4h/P5f9/i48t3WR2pBStYBi45ULWjGrFNnVPHCDscvx5zCueFoyUD6I
         FsuubXAgQzwK/Kk3422sz78xkErAmo0m8kMRV4T817+e6/YOxZX9Ih+WNN/kOA+i7WMC
         78DA==
X-Gm-Message-State: AOJu0Yz4AnQqhs10Czo3brKalWZYHnbXCCrpkyIGZ8eTRYeJUr7MFT3+
	Ob76Qhe3/qruRC/WNpHGO4BoQgvdCv4aGq5TGKJj4zCa25py3ao+M+X68YMm3Jrl1ACZ3NLMrIB
	tDF+oELNjpRJQFJYSVI3f052ZtcU=
X-Google-Smtp-Source: AGHT+IEBTxXO/05JLalLKqNP0AwaCLjBtefVcPW4nV3GJ7EDgOf2GtQv8aWPJ//CeFOui1luVI/RSo0xVpUh6Jba25M=
X-Received: by 2002:ad4:58aa:0:b0:68c:43cf:619d with SMTP id
 ea10-20020ad458aa000000b0068c43cf619dmr12786049qvb.4.1707116833503; Sun, 04
 Feb 2024 23:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk> <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org> <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk> <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk>
In-Reply-To: <87r0hyzxbd.fsf@toke.dk>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 5 Feb 2024 08:07:02 +0100
Message-ID: <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Pavel Vazharov <pavel@x3me.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2024 at 15:54, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel=
.org> wrote:
>
> Pavel Vazharov <pavel@x3me.net> writes:
>
> > On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
> >>
> >> Pavel Vazharov <pavel@x3me.net> writes:
> >>
> >> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x3me.=
net> wrote:
> >> >>>
> >> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kerne=
l.org> wrote:
> >> >>> >
> >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> >> >>> > > > Well, it will be up to your application to ensure that it is=
 not. The
> >> >>> > > > XDP program will run before the stack sees the LACP manageme=
nt traffic,
> >> >>> > > > so you will have to take some measure to ensure that any suc=
h management
> >> >>> > > > traffic gets routed to the stack instead of to the DPDK appl=
ication. My
> >> >>> > > > immediate guess would be that this is the cause of those war=
nings?
> >> >>> > >
> >> >>> > > Thank you for the response.
> >> >>> > > I already checked the XDP program.
> >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to =
the application.
> >> >>> > > Everything else is passed to the Linux kernel.
> >> >>> > > However, I'll check it again. Just to be sure.
> >> >>> >
> >> >>> > What device driver are you using, if you don't mind sharing?
> >> >>> > The pass thru code path may be much less well tested in AF_XDP
> >> >>> > drivers.
> >> >>> These are the kernel version and the drivers for the 3 ports in th=
e
> >> >>> above bonding.
> >> >>> ~# uname -a
> >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
> >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> >> >>> SFI/SFP+ Network Connection (rev 01)
> >> >>>        ...
> >> >>>         Kernel driver in use: ixgbe
> >> >>> --
> >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> >> >>> SFI/SFP+ Network Connection (rev 01)
> >> >>>         ...
> >> >>>         Kernel driver in use: ixgbe
> >> >>> --
> >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> >> >>> SFI/SFP+ Network Connection (rev 01)
> >> >>>         ...
> >> >>>         Kernel driver in use: ixgbe
> >> >>>
> >> >>> I think they should be well supported, right?
> >> >>> So far, it seems that the present usage scenario should work and t=
he
> >> >>> problem is somewhere in my code.
> >> >>> I'll double check it again and try to simplify everything in order=
 to
> >> >>> pinpoint the problem.
> >> > I've managed to pinpoint that forcing the copying of the packets
> >> > between the kernel and the user space
> >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> >> > working bonding.
> >>
> >> (+Magnus)
> >>
> >> Right, okay, that seems to suggest a bug in the internal kernel copyin=
g
> >> that happens on XDP_PASS in zero-copy mode. Which would be a driver bu=
g;
> >> any chance you could test with a different driver and see if the same
> >> issue appears there?
> >>
> >> -Toke
> > No, sorry.
> > We have only servers with Intel 82599ES with ixgbe drivers.
> > And one lab machine with Intel 82540EM with igb driver but we can't
> > set up bonding there
> > and the problem is not reproducible there.
>
> Right, okay. Another thing that may be of some use is to try to capture
> the packets on the physical devices using tcpdump. That should (I think)
> show you the LACDPU packets as they come in, before they hit the bonding
> device, but after they are copied from the XDP frame. If it's a packet
> corruption issue, that should be visible in the captured packet; you can
> compare with an xdpdump capture to see if there are any differences...

Pavel,

Sounds like an issue with the driver in zero-copy mode as it works
fine in copy mode. Maciej and I will take a look at it.

> -Toke
>

