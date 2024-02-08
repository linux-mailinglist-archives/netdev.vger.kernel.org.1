Return-Path: <netdev+bounces-70169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FA84DF4A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF841F2B6E6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61750762EA;
	Thu,  8 Feb 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="BU3k08+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5F6F08D
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390000; cv=none; b=Zb0gUBHja9OphdNdvHPbHmj9sTGNZVmzzNYCmPftYSZ8bWH9UdrqnmghPuqv6tvYe2DwC3NO+cgA28k1xHV8crqWKXCYzs7tYl1RDxSSVZGoltmMmogfc6TGGxXG4W+0g7SXuJXPilZFtdEzWAk8cMoLw/vH0PRB1GNTjgpZI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390000; c=relaxed/simple;
	bh=Norx/St29rJogm9tTcstx5nZ1PnVgSAbmFt5WEUUuMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMZHqg+KxZeGL37ym+dn/fzUZNqTonFduovvHN+gw6GG5pV3WerHKFijbEfxMQ2OaESvEQ5+A52cYBLALuSQTrT98trfDiZQ7hqYDBBehnnVh+2YqWcz+x6esyX9/eln26lcg5BbEgNXm3Nh6tC+ynF5vQMZ0MoU4OBFFQFLV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=BU3k08+P; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a389a3b9601so161886466b.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 02:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1707389996; x=1707994796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t6DZIieLw4GaIRXOmeXoB00e2wacKXdksaUlmS2dFE=;
        b=BU3k08+PwHHKnducsRuE+HwM8orbd6yLSucHtOpZm7ZecSmLmiLgFjTInRRQaSNYc3
         CdBUZzQ+v65DvoP2xa4K7hKtE+WIFyEGVMpG89upq10eB5SeyNkArlo3TqIiuuu4W2bt
         WS4X8GYKCpNXxEGcwJn0in+3n+cDSZ4j6ma8eZxbOKCkwpwm4oLymx6cbw0q/Gm+UQyT
         sZcBSpCN50lHXKtYb7t5ZiM4vfyL2mlSbKI2EgICFbODiePaOrmeAkiVBro9ADcJx1Wf
         CD7fSSuSBOgmoUSy42CyFnRUmdfqbAqe6FubSQdwUg44m798tvbYwhmNMvqT0r5rrBce
         H7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389996; x=1707994796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t6DZIieLw4GaIRXOmeXoB00e2wacKXdksaUlmS2dFE=;
        b=LCEJbiMbumvGTGsNR6sRnA8tmGbx2Pw7CRFvpPPwp0bFNDDl1jAzvDgOunKvX8xNAN
         ezsqKNkoa75MSWmOw0C+l84HdxtGt5Je7N/DTwo6p1X7VJSjcv6H71F7B0G7QfHoizMp
         6M/3E8NTaUi3FXlDrtSWlurAjFl09iteRAg/XN7QncBh55z26OKDReB/DlGOdXGAbWSp
         IIkkUApGtcFh3HW1nBLqmcXcyRE0rhbgCYUNNZYkFyDQ/cNYu0naCQKPXvTGCotDJqqF
         rYQrYsgy0khOzGDoaDgUybyJDxA8wV3eWuvUmPJzA1gQLvvfUD7dFV4tfwNLSSFfwYnD
         ky5Q==
X-Gm-Message-State: AOJu0YyPyYa+BfJFrsk05fHVR1zyxat+QbHYqkPXbYwzE6tNsQpAPKot
	b+fn1umgutUIijPrDskgxqfVISaFrH/aMoTaQtEJkZ+q7gVqe82+T5uPZGnz+UgJq4km18JShZ7
	HPYH1m9h4x+tqwKAyM8XmAo3fYFkVk+Q0j1vW4A==
X-Google-Smtp-Source: AGHT+IE3GR9fclYj2Mi/zRxNDRDrAKgcQl5cgQsrSiWAcyMoGjw4egjspwldHvxlCMxs8/u95HCnlWmgFKFznAO2Ai4=
X-Received: by 2002:a17:906:23e9:b0:a31:4e96:f40a with SMTP id
 j9-20020a17090623e900b00a314e96f40amr5830518ejg.26.1707389995705; Thu, 08 Feb
 2024 02:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org> <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk> <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk> <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com> <ZcPTNpzGyqQI+DXw@boxer>
In-Reply-To: <ZcPTNpzGyqQI+DXw@boxer>
From: Pavel Vazharov <pavel@x3me.net>
Date: Thu, 8 Feb 2024 12:59:44 +0200
Message-ID: <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:00=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Feb 07, 2024 at 05:49:47PM +0200, Pavel Vazharov wrote:
> > On Mon, Feb 5, 2024 at 9:07=E2=80=AFAM Magnus Karlsson
> > <magnus.karlsson@gmail.com> wrote:
> > >
> > > On Tue, 30 Jan 2024 at 15:54, Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
kernel.org> wrote:
> > > >
> > > > Pavel Vazharov <pavel@x3me.net> writes:
> > > >
> > > > > On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8=
rgensen <toke@kernel.org> wrote:
> > > > >>
> > > > >> Pavel Vazharov <pavel@x3me.net> writes:
> > > > >>
> > > > >> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel=
@x3me.net> wrote:
> > > > >> >>>
> > > > >> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba=
@kernel.org> wrote:
> > > > >> >>> >
> > > > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > > >> >>> > > > Well, it will be up to your application to ensure that=
 it is not. The
> > > > >> >>> > > > XDP program will run before the stack sees the LACP ma=
nagement traffic,
> > > > >> >>> > > > so you will have to take some measure to ensure that a=
ny such management
> > > > >> >>> > > > traffic gets routed to the stack instead of to the DPD=
K application. My
> > > > >> >>> > > > immediate guess would be that this is the cause of tho=
se warnings?
> > > > >> >>> > >
> > > > >> >>> > > Thank you for the response.
> > > > >> >>> > > I already checked the XDP program.
> > > > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traff=
ic to the application.
> > > > >> >>> > > Everything else is passed to the Linux kernel.
> > > > >> >>> > > However, I'll check it again. Just to be sure.
> > > > >> >>> >
> > > > >> >>> > What device driver are you using, if you don't mind sharin=
g?
> > > > >> >>> > The pass thru code path may be much less well tested in AF=
_XDP
> > > > >> >>> > drivers.
> > > > >> >>> These are the kernel version and the drivers for the 3 ports=
 in the
> > > > >> >>> above bonding.
> > > > >> >>> ~# uname -a
> > > > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/L=
inux
> > > > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > > > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gi=
gabit
> > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > >> >>>        ...
> > > > >> >>>         Kernel driver in use: ixgbe
> > > > >> >>> --
> > > > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gi=
gabit
> > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > >> >>>         ...
> > > > >> >>>         Kernel driver in use: ixgbe
> > > > >> >>> --
> > > > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gi=
gabit
> > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > >> >>>         ...
> > > > >> >>>         Kernel driver in use: ixgbe
> > > > >> >>>
> > > > >> >>> I think they should be well supported, right?
> > > > >> >>> So far, it seems that the present usage scenario should work=
 and the
> > > > >> >>> problem is somewhere in my code.
> > > > >> >>> I'll double check it again and try to simplify everything in=
 order to
> > > > >> >>> pinpoint the problem.
> > > > >> > I've managed to pinpoint that forcing the copying of the packe=
ts
> > > > >> > between the kernel and the user space
> > > > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the =
not
> > > > >> > working bonding.
> > > > >>
> > > > >> (+Magnus)
> > > > >>
> > > > >> Right, okay, that seems to suggest a bug in the internal kernel =
copying
> > > > >> that happens on XDP_PASS in zero-copy mode. Which would be a dri=
ver bug;
> > > > >> any chance you could test with a different driver and see if the=
 same
> > > > >> issue appears there?
> > > > >>
> > > > >> -Toke
> > > > > No, sorry.
> > > > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > > > And one lab machine with Intel 82540EM with igb driver but we can=
't
> > > > > set up bonding there
> > > > > and the problem is not reproducible there.
> > > >
> > > > Right, okay. Another thing that may be of some use is to try to cap=
ture
> > > > the packets on the physical devices using tcpdump. That should (I t=
hink)
> > > > show you the LACDPU packets as they come in, before they hit the bo=
nding
> > > > device, but after they are copied from the XDP frame. If it's a pac=
ket
> > > > corruption issue, that should be visible in the captured packet; yo=
u can
> > > > compare with an xdpdump capture to see if there are any differences=
...
> > >
> > > Pavel,
> > >
> > > Sounds like an issue with the driver in zero-copy mode as it works
> > > fine in copy mode. Maciej and I will take a look at it.
> > >
> > > > -Toke
> > > >
> >
> > First I want to apologize for not responding for such a long time.
> > I had different tasks the previous week and this week went back to this=
 issue.
> > I had to modify the code of the af_xdp driver inside the DPDK so that i=
t loads
> > the XDP program in a way which is compatible with the xdp-dispatcher.
> > Finally, I was able to run our application with the XDP sockets and the=
 xdpdump
> > at the same time.
> >
> > Back to the issue.
> > I just want to say again that we are not binding the XDP sockets to
> > the bonding device.
> > We are binding the sockets to the queues of the physical interfaces
> > "below" the bonding device.
> > My further observation this time is that when the issue happens and
> > the remote device reports
> > the LACP error there is no incoming LACP traffic on the corresponding
> > local port,
> > as seen by the xdump.
> > The tcpdump at the same time sees only outgoing LACP packets and
> > nothing incoming.
> > For example:
> > Remote device
> >                           Local Server
> > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/12 <---> eth0
> > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/13 <---> eth2
> > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/14 <---> eth4
> > And when the remote device reports "received an abnormal LACPDU"
> > for PortName=3DXGigabitEthernet0/0/14 I can see via xdpdump that there
> > is no incoming LACP traffic
>
> Hey Pavel,
>
> can you also look at /proc/interrupts at eth4 and what ethtool -S shows
> there?
I reproduced the problem but this time the interface with the weird
state was eth0.
It's different every time and sometimes even two of the interfaces are
in such a state.
Here are the requested info while being in this state:
~# ethtool -S eth0 > /tmp/stats0.txt ; sleep 10 ; ethtool -S eth0 >
/tmp/stats1.txt ; diff /tmp/stats0.txt /tmp/stats1.txt
6c6
<      rx_pkts_nic: 81426
---
>      rx_pkts_nic: 81436
8c8
<      rx_bytes_nic: 10286521
---
>      rx_bytes_nic: 10287801
17c17
<      multicast: 72216
---
>      multicast: 72226
48c48
<      rx_no_dma_resources: 1109
---
>      rx_no_dma_resources: 1119

~# cat /proc/interrupts | grep eth0 > /tmp/interrupts0.txt ; sleep 10
; cat /proc/interrupts | grep eth0 > /tmp/interrupts1.txt
interrupts0: 430 3098 64 108199 108199 108199 108199 108199 108199
108199 108201 63 64 1865 108199  61
interrupts1: 435 3103 69 117967 117967  117967 117967 117967  117967
117967 117969 68 69 1870  117967 66

So, it seems that packets are coming on the interface but they don't
reach to the XDP layer and deeper.
rx_no_dma_resources - this counter seems to give clues about a possible iss=
ue?

>
> > on eth4 but there is incoming LACP traffic on eth0 and eth2.
> > At the same time, according to the dmesg the kernel sees all of the
> > interfaces as
> > "link status definitely up, 10000 Mbps full duplex".
> > The issue goes aways if I stop the application even without removing
> > the XDP programs
> > from the interfaces - the running xdpdump starts showing the incoming
> > LACP traffic immediately.
> > The issue also goes away if I do "ip link set down eth4 && ip link set =
up eth4".
>
> and the setup is what when doing the link flap? XDP progs are loaded to
> each of the 3 interfaces of bond?
Yes, the same XDP program is loaded on application startup on each one
of the interfaces which are part of bond0 (eth0, eth2, eth4):
# xdp-loader status
CURRENT XDP PROGRAM STATUS:

Interface        Prio  Program name      Mode     ID   Tag
  Chain actions
---------------------------------------------------------------------------=
-----------
lo                     <No XDP program loaded!>
eth0                   xdp_dispatcher    native   1320 90f686eb86991928
 =3D>              50     x3sp_splitter_func          1329
3b185187f1855c4c  XDP_PASS
eth1                   <No XDP program loaded!>
eth2                   xdp_dispatcher    native   1334 90f686eb86991928
 =3D>              50     x3sp_splitter_func          1337
3b185187f1855c4c  XDP_PASS
eth3                   <No XDP program loaded!>
eth4                   xdp_dispatcher    native   1342 90f686eb86991928
 =3D>              50     x3sp_splitter_func          1345
3b185187f1855c4c  XDP_PASS
eth5                   <No XDP program loaded!>
eth6                   <No XDP program loaded!>
eth7                   <No XDP program loaded!>
bond0                  <No XDP program loaded!>
Each of these interfaces is setup to have 16 queues i.e. the application,
through the DPDK machinery, opens 3x16 XSK sockets each bound to the
corresponding queue of the corresponding interface.
~# ethtool -l eth0 # It's same for the other 2 devices
Channel parameters for eth0:
Pre-set maximums:
RX:             n/a
TX:             n/a
Other:          1
Combined:       48
Current hardware settings:
RX:             n/a
TX:             n/a
Other:          1
Combined:       16

>
> > However, I'm not sure what happens with the bound XDP sockets in this c=
ase
> > because I haven't tested further.
>
> can you also try to bind xsk sockets before attaching XDP progs?
I looked into the DPDK code again.
The DPDK framework provides callback hooks like eth_rx_queue_setup
and each "driver" implements it as needed. Each Rx/Tx queue of the device i=
s
set up separately. The af_xdp driver currently does this for each Rx
queue separately:
1. configures the umem for the queue
2. loads the XDP program on the corresponding interface, if not already loa=
ded
   (i.e. this happens only once per interface when its first queue is set u=
p).
3. does xsk_socket__create which as far as I looked also internally binds t=
he
socket to the given queue
4. places the socket in the XSKS map of the XDP program via bpf_map_update_=
elem

So, it seems to me that the change needed will be a bit more involved.
I'm not sure if it'll be possible to hardcode, just for the test, the
program loading and
the placing of all XSK sockets in the map to happen when the setup of the l=
ast
"queue" for the given interface is done. I need to think a bit more about t=
his.

>
> >
> > It seems to me that something racy happens when the interfaces go down
> > and back up
> > (visible in the dmesg) when the XDP sockets are bound to their queues.
> > I mean, I'm not sure why the interfaces go down and up but setting
> > only the XDP programs
> > on the interfaces doesn't cause this behavior. So, I assume it's
> > caused by the binding of the XDP sockets.
>
> hmm i'm lost here, above you said you got no incoming traffic on eth4 eve=
n
> without xsk sockets being bound?
Probably I've phrased something in a wrong way.
The issue is not observed if I load the XDP program on all interfaces
(eth0, eth2, eth4)
with the xdp-loader:
xdp-loader load --mode native <iface> <path-to-the-xdp-program>
It's not observed probably because there are no interface down/up actions.
I also modified the DPDK "driver" to not remove the XDP program on exit and=
 thus
when the application stops only the XSK sockets are closed but the
program remains
loaded at the interfaces. When I stop this version of the application
while running the
xdpdump at the same time I see that the traffic immediately appears in
the xdpdump.
Also, note that I basically trimmed the XDP program to simply contain
the XSK map
(BPF_MAP_TYPE_XSKMAP) and the function just does "return XDP_PASS;".
I wanted to exclude every possibility for the XDP program to do something w=
rong.
So, from the above it seems to me that the issue is triggered somehow by th=
e XSK
sockets usage.

>
> > It could be that the issue is not related to the XDP sockets but just
> > to the down/up actions of the interfaces.
> > On the other hand, I'm not sure why the issue is easily reproducible
> > when the zero copy mode is enabled
> > (4 out of 5 tests reproduced the issue).
> > However, when the zero copy is disabled this issue doesn't happen
> > (I tried 10 times in a row and it doesn't happen).
>
> any chances that you could rule out the bond of the picture of this issue=
?
I'll need to talk to the network support guys because they manage the netwo=
rk
devices and they'll need to change the LACP/Trunk setup of the above
"remote device".
I can't promise that they'll agree though.

> on my side i'll try to play with multiple xsk sockets within same netdev
> served by ixgbe and see if i observe something broken. I recently fixed
> i40e Tx disable timeout issue, so maybe ixgbe has something off in down/u=
p
> actions as you state as well.

