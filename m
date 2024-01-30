Return-Path: <netdev+bounces-67243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6D84273E
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800271F29F87
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55B77CF3C;
	Tue, 30 Jan 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/2xSI+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225D7CF2D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626457; cv=none; b=a0z8fZL+LjkfZakBAzxEarpuhb05t0lsdA+h4FWvO0LCbdJAoMYudsHbvSOvl6ENXJmDE9KG7OPCIOMcoMp3Y6ObpabJkoi/29J/plG4uw4Unk8fDxEjjFJiKKIrvltDpks+KkB/TGynmDeTuIspLjccROaWoi/T5U554h2/bwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626457; c=relaxed/simple;
	bh=0erKqtVUGxKp2/eSDeCyAzRdtLCK9dUpKbfTpVkUV9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RhpOx5rxnXOl35HtkUSR5iyVDEFnpPO5u7YJ6jKXuoXwaDtlTxIGpShdu6MZqYTUVf1jdL0FKSQ/G+cnQWbqOgJ44WR2SNK3hx0MzCnocmezaxNS8YYDKR4QkpBHT9bhGHCApANtFjIMav8IooICGxvv/JYdFa9zjExZBMkR08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/2xSI+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C774C433F1;
	Tue, 30 Jan 2024 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626457;
	bh=0erKqtVUGxKp2/eSDeCyAzRdtLCK9dUpKbfTpVkUV9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J/2xSI+9CRVAYK6s4nX0ZCLtButgUIIiQh2ClPwfq8NuedVavr5eZLu1Zb1tade2J
	 CaSk4exXEXJT7ALXEJjBLkWRZgfGK9soVLzI1XC2+JyHlmRGuD6A6y7Ilrmy6uuQam
	 r8BwxxuEYEoOAhOj4/7l4HCdG4TU397DEfo3MQ1FYwaySMgn1jENvNtRtlDjzV94XU
	 ldaHmu5lH0bQ3jhjKmByOASJ1tKJUSL/2pFy29Dq9g9WmcHQYaelmPldcrQijcubm2
	 WM36G/L6RX8ypFDUMBOhvq7Jir7e8HtNxERULlV/T4+9Rgi9USz991j42ztP9cWYdd
	 QUjhDwJssqYag==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 56CBA108A231; Tue, 30 Jan 2024 15:54:14 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Pavel Vazharov <pavel@x3me.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Magnus
 Karlsson <magnus.karlsson@gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind
 a Linux bonding device
In-Reply-To: <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk>
 <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org>
 <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk>
 <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Jan 2024 15:54:14 +0100
Message-ID: <87r0hyzxbd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pavel Vazharov <pavel@x3me.net> writes:

> On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>> Pavel Vazharov <pavel@x3me.net> writes:
>>
>> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x3me.ne=
t> wrote:
>> >>>
>> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.=
org> wrote:
>> >>> >
>> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
>> >>> > > > Well, it will be up to your application to ensure that it is n=
ot. The
>> >>> > > > XDP program will run before the stack sees the LACP management=
 traffic,
>> >>> > > > so you will have to take some measure to ensure that any such =
management
>> >>> > > > traffic gets routed to the stack instead of to the DPDK applic=
ation. My
>> >>> > > > immediate guess would be that this is the cause of those warni=
ngs?
>> >>> > >
>> >>> > > Thank you for the response.
>> >>> > > I already checked the XDP program.
>> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to th=
e application.
>> >>> > > Everything else is passed to the Linux kernel.
>> >>> > > However, I'll check it again. Just to be sure.
>> >>> >
>> >>> > What device driver are you using, if you don't mind sharing?
>> >>> > The pass thru code path may be much less well tested in AF_XDP
>> >>> > drivers.
>> >>> These are the kernel version and the drivers for the 3 ports in the
>> >>> above bonding.
>> >>> ~# uname -a
>> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
>> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
>> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>> >>> SFI/SFP+ Network Connection (rev 01)
>> >>>        ...
>> >>>         Kernel driver in use: ixgbe
>> >>> --
>> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>> >>> SFI/SFP+ Network Connection (rev 01)
>> >>>         ...
>> >>>         Kernel driver in use: ixgbe
>> >>> --
>> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>> >>> SFI/SFP+ Network Connection (rev 01)
>> >>>         ...
>> >>>         Kernel driver in use: ixgbe
>> >>>
>> >>> I think they should be well supported, right?
>> >>> So far, it seems that the present usage scenario should work and the
>> >>> problem is somewhere in my code.
>> >>> I'll double check it again and try to simplify everything in order to
>> >>> pinpoint the problem.
>> > I've managed to pinpoint that forcing the copying of the packets
>> > between the kernel and the user space
>> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
>> > working bonding.
>>
>> (+Magnus)
>>
>> Right, okay, that seems to suggest a bug in the internal kernel copying
>> that happens on XDP_PASS in zero-copy mode. Which would be a driver bug;
>> any chance you could test with a different driver and see if the same
>> issue appears there?
>>
>> -Toke
> No, sorry.
> We have only servers with Intel 82599ES with ixgbe drivers.
> And one lab machine with Intel 82540EM with igb driver but we can't
> set up bonding there
> and the problem is not reproducible there.

Right, okay. Another thing that may be of some use is to try to capture
the packets on the physical devices using tcpdump. That should (I think)
show you the LACDPU packets as they come in, before they hit the bonding
device, but after they are copied from the XDP frame. If it's a packet
corruption issue, that should be visible in the captured packet; you can
compare with an xdpdump capture to see if there are any differences...

-Toke

