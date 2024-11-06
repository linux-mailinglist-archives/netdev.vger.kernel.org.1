Return-Path: <netdev+bounces-142155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245E9BDA97
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EDE2840A0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB57DA6A;
	Wed,  6 Nov 2024 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdcSyGT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181E43156
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854260; cv=none; b=hSswgrjmjM7BM4fRhCEXX6Z98DT8r4GysHfXW/t7kzUDFdHb4N2l8DZ6cWsodmghcYR/Fmj1R3xARyPR7/H4sxbd+TlMS0XSNhrf4TPrdnIZVUCm8DgU79YGX0n6Sv3oTmAnPLvg+BWdWLJIiDCzmVuAVxBkUus5toGFgx84WNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854260; c=relaxed/simple;
	bh=0s+CpSd1QrcdForydThmIdSTS/HLs/rCxJQl3ocmCWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVHHL6PQ/39FtkRBfBnJtpB5F8I6fK5zwZH80Qb+sdByTo6MWAm6LA7sxZCPk5Ijwm+uADgyIoAVR0cVByabw60OpDcpDJMT4jufzoq9/jAU/gZIfMNwX2WFTKE5i1R9m+2uA+EdA+FRc3ry5ENQxadPTkYCttJbQY2DrRr4lCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdcSyGT7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so8128892a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730854257; x=1731459057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTtoN8n/S+LNYT4i/oQ8XnBIyeDVEsR0uOP1WCwx/8k=;
        b=BdcSyGT7aqQoZnz/txyYvfHBR6Qn8q5GrOSOKnxztwFpbB6xTNhS6bMu0CGlfVaDPG
         2Sf/PpLBd1yMtH8qfnltFFJtI0h+1HUiG1YxUvRpgno8I/Z+fT2kD+JF8uIWh7QBSfkC
         OAYO2WAmkc5dZB3wYk7cLRn2/MDQ+tQhpSU1uev8h9FaLCMtv7Sx8m34CAYmeD72rqiD
         BWDB0+ms0fn2IUEMQVKlD3W2RI1TQFrrPcwZjjqrviGayeDtC6GAiA9uierVVSbiMsXr
         JPLIDCrHjuyUNGPMiQqT5FHeqsMCY7cOn3DuT0d/qnCA4QJTsVpmLfL39jUYT0S5URv4
         UclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730854257; x=1731459057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTtoN8n/S+LNYT4i/oQ8XnBIyeDVEsR0uOP1WCwx/8k=;
        b=R/yrWTtEedQ3T4Jgmh/i67mcKVUenlIHyxN3jbNKKdYpUFp4LIroGVuBzjEnILZdVS
         jKWCBfA/jIDHXl7daX3p9B4dkDLgvFSndATxM8rl2Q4JML2bNSSs1MJDBHjip3dp7mC2
         bhWdlDPp/6d1W7oS2EOr0AqMlrNE3b34SFIEK6K/AchTqceNHtF4Ne5Y9QxYRoFyLtP8
         guZE1+OUtgzoNCCgDrvINleg8g0tfl1O77fQLa4VkCHABmqxtm0ucxcgAmmsI94UpSsg
         l5CduxwqEb8pcfkbP6Josp+URVVYCVnCqsiC/w+SIcIFS/7AtiSU5YRuSugMSvglVytB
         kQWA==
X-Gm-Message-State: AOJu0YyvE+Y9ayVjGZ7E4JSiJBQroy1JTMTZVag8xED93YkkXYBuigql
	km9fy0NhwEy2FJ/+x2JdYImPeER/stI2nMK1+irIJEUfBhRcTL9l1v+cdnPTdfr5xUHH28ZK5Be
	QUAiT5Oyr7hh5v5rWJ2wOnlfT4Y7dQg==
X-Google-Smtp-Source: AGHT+IEIA1uZrPxrWJioaTSiX/KBH3TQNXEKhlh1yHJbqnXH+RYz+mBMAP9JCdev2+Wb3bLjzOzXy6ra0Pp+eb3NoFg=
X-Received: by 2002:aa7:c6c7:0:b0:5c9:7d96:772d with SMTP id
 4fb4d7f45d1cf-5ceb9343ac0mr12070886a12.22.1730854257024; Tue, 05 Nov 2024
 16:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zyn-lUmMbLYO64E_@fedora>
In-Reply-To: <Zyn-lUmMbLYO64E_@fedora>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 5 Nov 2024 16:50:46 -0800
Message-ID: <CAH5Ym4hAz6xRnf-o32usHj8S5ESj0cpFBb7JypDVMkq2_v0x1w@mail.gmail.com>
Subject: Re: [IPv6 Question] Should we remove or keep the temporary address if
 global address removed?
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:16=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> w=
rote:
>
> Hi Sam,
>
> Our QE just find the latest upstream kernel behavior changed for temporar=
y
> address. i.e. In the previous time, the kernel will also remove the tempo=
rary
> address if the related global address deleted. But now the kernel will ke=
ep
> the temporary there. e.g.
> ```
> # sysctl -w net.ipv6.conf.enp59s0f0np0.use_tempaddr=3D1
> # ip add add 2003::4/64 dev enp59s0f0np0 mngtmpaddr
> # ip add show enp59s0f0np0
> 6: enp59s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq stat=
e UP group default qlen 1000
>     link/ether b8:59:9f:06:56:6c brd ff:ff:ff:ff:ff:ff
>     inet6 2003::d280:ee50:d13e:a1b1/64 scope global temporary dynamic
>        valid_lft 604793sec preferred_lft 86393sec
>     inet6 2003::4/64 scope global mngtmpaddr
>        valid_lft forever preferred_lft forever
> # ip add del 2003::4/64 dev  enp59s0f0np0 mngtmpaddr
> # ip add show enp59s0f0np0
> 6: enp59s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq stat=
e UP group default qlen 1000
>     link/ether b8:59:9f:06:56:6c brd ff:ff:ff:ff:ff:ff
>     inet6 2003::d7c7:a239:2519:2491/64 scope global temporary dynamic
>        valid_lft 604782sec preferred_lft 86382sec
> ```
>     ^^ previously this temporary address will also be removed.
>
> After checking the code, it looks commit 778964f2fdf0 ("ipv6/addrconf: fi=
x
> timing bug in tempaddr regen") changes the behavior. I can't find what we=
 should
> do when delete the related global address from RFC8981. So I'm not sure
> which way we should do. Keep or delete the temporary address.
>
> Do you have any idea?

Hi Hangbin,

RFC8981 section 3.4 does say that existing temporary addresses must
have their lifetimes adjusted so that no temporary addresses should
ever remain "valid" or "preferred" longer than the incoming SLAAC
Prefix Information. This would strongly imply in Linux's case that if
the "mngtmpaddr" address is deleted or un-flagged as such, its
corresponding temporary addresses must be cleared out right away. That
also makes intuitive sense to me, because if an administrator is
deleting (or un-flagging) "mngtmpaddr" they very likely want no more
temporary addresses within that prefix.

So, I would say what you've found is a bug. Doubly so because the
temporaries contain a pointer to the managing address, which is
possibly now dangling.

By the way, I don't think my patch from 2 years ago is still working
correctly: I'm seeing that my (high-uptime) workstation has two
mngtmpaddr addresses, one public address and one internal to my LAN,
but currently only the "internal to my LAN" one has any
still-preferred temporary addresses currently.

Last time around, Paolo strongly suggested that I include a regression
test with my patch. I now realize it's a good idea to write such a
test:
1. Create a dummy Ethernet interface, with temp_*_lft configured to be
pretty short (10 and 35 seconds for prefer/valid respectively?)
2. Create several (3-4) mngtmpaddr addresses on that interface.
3. Confirm that temporary addresses are created immediately.
4. Confirm that a preferred temporary address exists for each
mngtmpaddr address at all times, polling once per second for at least
10 minutes.
5. Delete each mngtmpaddr address, one at a time (alternating between
deleting and merely un-mngtmpaddr-ing), and confirm that the other
mngtmpaddr addresses still have preferred temporaries.
6. Within steps 3-5, also confirm that any temporaries that exist have
a corresponding mngtmpaddr. (Basically the test should, at all steps,
confirm that every existing mngtmpaddr has at least one preferred
temporary, and that every existing temporary has a matching
mngtmpaddr.)

This test should fail, demonstrating both of these bugs, when run
against the latest kernel. Then we can get to work on making the test
pass.

Are you interested in writing that test or should I? I have never
contributed test cases to the kernel before, so there'd be a bit of a
learning curve for me, but I'm happy to do it.

Cheers,
Sam

>
> Thanks
> Hangbin

