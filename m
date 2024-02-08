Return-Path: <netdev+bounces-70289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A8484E442
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C11F27C5C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3EE7B3C8;
	Thu,  8 Feb 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="GARXya/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87478678
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407283; cv=none; b=U31CEtETxaLn9LKhqSeRZemN0tai9q7fU49sOiRRat3RZuKE42fyUyKKb/whUYawwrs+QGcnG5pnYxil3TxA+AQqUfMAoquskU9YNbZD6WhyB5hfJIXN56QnzN5CtvBwxjvpQsh7Ks302HQHRcVG1UaKZ5vlMItzqK1yPtDfodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407283; c=relaxed/simple;
	bh=FGaGYgciNnkrIuiv6CmJWdlBmOdZS7iT8q1Ibwa8IMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSc84BrKO3BPnBezBWTE6X5+rvM+3rLZrsiQAz7E+8Swfx6j2Z6UGDZ4e92OundvYW41O5x55/JauXL5xtPkE6+vwxvP3kk7m35ORH6yQF2e3ji0+rYLvQp3VlN8979+RU3de0nFKrq61APf/hkjlj31WhiG3TIIazYMzJd6KOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=GARXya/P; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso20286231fa.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1707407278; x=1708012078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZCRdVonsN45KSFhUkOSSqFHNjk0e1LuyUFpCEdLUac=;
        b=GARXya/PwuaaHX/LOCK+KzceVjLCw8THtAChHxa5EFbKdafq3YWA720EODlzcfkZpa
         l/ZBFbxW0dR1s8HL21swN3+zOrIJqIVdnkoMq0GJ86it+39KQSMiZytx5hrUvYaErENn
         Y1DUcFYKMNuXAeOSvZQ+r1+5nz0nP1n89egSuSVk5zS9EjfIJRbrvWRudjAvk3/8s84Z
         SF8X+XNvx+l0JvdxDFpgAsBADBuDnjTU3oa/9e+blq3c32SzzEr1Apv5+f81dWx8f7EK
         6tOgU0K5h17og+YdRqCgGQ4FTGNn5GXLEHIqprAOKthKcCuYGNLQE3w8Vu3pBETZDBWP
         hVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407278; x=1708012078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZCRdVonsN45KSFhUkOSSqFHNjk0e1LuyUFpCEdLUac=;
        b=KCk33xfzDh3kGCVTNxKkRKwByokv0NanfTtc10RwEZANVSYXlJwd1l1Hzc5Dkb8i1e
         vTgEFdJnUl8Y6gG42PnOHSb0ou4LKmUcWBpzZaJGkCpeQLxXUMUka5VRMC7ohxI2/NB6
         eiAFvw9CLTpPpDBmWuClEesIwnG1w2dWrbdHaznMJT1ylNfi/HP15l5P88BepT1yUXpG
         /t3vKyEH7wo5ncwEPpJ9VmzzecsfUgo/4oRTYGUKKR8c7Ezg2Ufu9R+Xk+KJvIay7PSu
         fInR51345AU/Pfmq8p6s7s+OXDBNbRbYorqXRd9Fx0JJKQJG3BsbVNlNCX5cvWIeLrLF
         7npA==
X-Gm-Message-State: AOJu0Yw/eMxEmVV2grzqU0MNjt1yPGf7NZYJIs78S2P4VNQS9jGwLDas
	8zfVUG2EHCG390ebfJA+RtgzT5ouGobjPTc3NVyUM1Rw/xW4p8pee99EEIgwExrBW7BSDnCpq/k
	cOKadrVj6QKyrbvuv7qtfdZh++f2ZGFQ3FIBsSA==
X-Google-Smtp-Source: AGHT+IF0+Qc61VwG+wEcI8YcXjyD4yqE0avkDiA1I7L4yJMxZjTudDo5yvngbfn+qIob3SWGFauR80v/OgQePAvebC4=
X-Received: by 2002:a2e:9bcb:0:b0:2d0:a12a:8c2c with SMTP id
 w11-20020a2e9bcb000000b002d0a12a8c2cmr6892511ljj.34.1707407278047; Thu, 08
 Feb 2024 07:47:58 -0800 (PST)
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
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer> <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
In-Reply-To: <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
From: Pavel Vazharov <pavel@x3me.net>
Date: Thu, 8 Feb 2024 17:47:46 +0200
Message-ID: <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:59=E2=80=AFPM Pavel Vazharov <pavel@x3me.net> wro=
te:
>
> On Wed, Feb 7, 2024 at 9:00=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Feb 07, 2024 at 05:49:47PM +0200, Pavel Vazharov wrote:
> > > On Mon, Feb 5, 2024 at 9:07=E2=80=AFAM Magnus Karlsson
> > > <magnus.karlsson@gmail.com> wrote:
> > > >
> > > > On Tue, 30 Jan 2024 at 15:54, Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@kernel.org> wrote:
> > > > >
> > > > > Pavel Vazharov <pavel@x3me.net> writes:
> > > > >
> > > > > > On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@kernel.org> wrote:
> > > > > >>
> > > > > >> Pavel Vazharov <pavel@x3me.net> writes:
> > > > > >>
> > > > > >> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pav=
el@x3me.net> wrote:
> > > > > >> >>>
> > > > > >> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <ku=
ba@kernel.org> wrote:
> > > > > >> >>> >
> > > > > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > > > >> >>> > > > Well, it will be up to your application to ensure th=
at it is not. The
> > > > > >> >>> > > > XDP program will run before the stack sees the LACP =
management traffic,
> > > > > >> >>> > > > so you will have to take some measure to ensure that=
 any such management
> > > > > >> >>> > > > traffic gets routed to the stack instead of to the D=
PDK application. My
> > > > > >> >>> > > > immediate guess would be that this is the cause of t=
hose warnings?
> > > > > >> >>> > >
> > > > > >> >>> > > Thank you for the response.
> > > > > >> >>> > > I already checked the XDP program.
> > > > > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) tra=
ffic to the application.
> > > > > >> >>> > > Everything else is passed to the Linux kernel.
> > > > > >> >>> > > However, I'll check it again. Just to be sure.
> > > > > >> >>> >
> > > > > >> >>> > What device driver are you using, if you don't mind shar=
ing?
> > > > > >> >>> > The pass thru code path may be much less well tested in =
AF_XDP
> > > > > >> >>> > drivers.
> > > > > >> >>> These are the kernel version and the drivers for the 3 por=
ts in the
> > > > > >> >>> above bonding.
> > > > > >> >>> ~# uname -a
> > > > > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU=
/Linux
> > > > > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > > > > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-=
Gigabit
> > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > >> >>>        ...
> > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > >> >>> --
> > > > > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-=
Gigabit
> > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > >> >>>         ...
> > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > >> >>> --
> > > > > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-=
Gigabit
> > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > >> >>>         ...
> > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > >> >>>
> > > > > >> >>> I think they should be well supported, right?
> > > > > >> >>> So far, it seems that the present usage scenario should wo=
rk and the
> > > > > >> >>> problem is somewhere in my code.
> > > > > >> >>> I'll double check it again and try to simplify everything =
in order to
> > > > > >> >>> pinpoint the problem.
> > > > > >> > I've managed to pinpoint that forcing the copying of the pac=
kets
> > > > > >> > between the kernel and the user space
> > > > > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and th=
e not
> > > > > >> > working bonding.
> > > > > >>
> > > > > >> (+Magnus)
> > > > > >>
> > > > > >> Right, okay, that seems to suggest a bug in the internal kerne=
l copying
> > > > > >> that happens on XDP_PASS in zero-copy mode. Which would be a d=
river bug;
> > > > > >> any chance you could test with a different driver and see if t=
he same
> > > > > >> issue appears there?
> > > > > >>
> > > > > >> -Toke
> > > > > > No, sorry.
> > > > > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > > > > And one lab machine with Intel 82540EM with igb driver but we c=
an't
> > > > > > set up bonding there
> > > > > > and the problem is not reproducible there.
> > > > >
> > > > > Right, okay. Another thing that may be of some use is to try to c=
apture
> > > > > the packets on the physical devices using tcpdump. That should (I=
 think)
> > > > > show you the LACDPU packets as they come in, before they hit the =
bonding
> > > > > device, but after they are copied from the XDP frame. If it's a p=
acket
> > > > > corruption issue, that should be visible in the captured packet; =
you can
> > > > > compare with an xdpdump capture to see if there are any differenc=
es...
> > > >
> > > > Pavel,
> > > >
> > > > Sounds like an issue with the driver in zero-copy mode as it works
> > > > fine in copy mode. Maciej and I will take a look at it.
> > > >
> > > > > -Toke
> > > > >
> > >
> > > First I want to apologize for not responding for such a long time.
> > > I had different tasks the previous week and this week went back to th=
is issue.
> > > I had to modify the code of the af_xdp driver inside the DPDK so that=
 it loads
> > > the XDP program in a way which is compatible with the xdp-dispatcher.
> > > Finally, I was able to run our application with the XDP sockets and t=
he xdpdump
> > > at the same time.
> > >
> > > Back to the issue.
> > > I just want to say again that we are not binding the XDP sockets to
> > > the bonding device.
> > > We are binding the sockets to the queues of the physical interfaces
> > > "below" the bonding device.
> > > My further observation this time is that when the issue happens and
> > > the remote device reports
> > > the LACP error there is no incoming LACP traffic on the corresponding
> > > local port,
> > > as seen by the xdump.
> > > The tcpdump at the same time sees only outgoing LACP packets and
> > > nothing incoming.
> > > For example:
> > > Remote device
> > >                           Local Server
> > > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/12 <---> eth0
> > > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/13 <---> eth2
> > > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/14 <---> eth4
> > > And when the remote device reports "received an abnormal LACPDU"
> > > for PortName=3DXGigabitEthernet0/0/14 I can see via xdpdump that ther=
e
> > > is no incoming LACP traffic
> >
> > Hey Pavel,
> >
> > can you also look at /proc/interrupts at eth4 and what ethtool -S shows
> > there?
> I reproduced the problem but this time the interface with the weird
> state was eth0.
> It's different every time and sometimes even two of the interfaces are
> in such a state.
> Here are the requested info while being in this state:
> ~# ethtool -S eth0 > /tmp/stats0.txt ; sleep 10 ; ethtool -S eth0 >
> /tmp/stats1.txt ; diff /tmp/stats0.txt /tmp/stats1.txt
> 6c6
> <      rx_pkts_nic: 81426
> ---
> >      rx_pkts_nic: 81436
> 8c8
> <      rx_bytes_nic: 10286521
> ---
> >      rx_bytes_nic: 10287801
> 17c17
> <      multicast: 72216
> ---
> >      multicast: 72226
> 48c48
> <      rx_no_dma_resources: 1109
> ---
> >      rx_no_dma_resources: 1119
>
> ~# cat /proc/interrupts | grep eth0 > /tmp/interrupts0.txt ; sleep 10
> ; cat /proc/interrupts | grep eth0 > /tmp/interrupts1.txt
> interrupts0: 430 3098 64 108199 108199 108199 108199 108199 108199
> 108199 108201 63 64 1865 108199  61
> interrupts1: 435 3103 69 117967 117967  117967 117967 117967  117967
> 117967 117969 68 69 1870  117967 66
>
> So, it seems that packets are coming on the interface but they don't
> reach to the XDP layer and deeper.
> rx_no_dma_resources - this counter seems to give clues about a possible i=
ssue?
>
> >
> > > on eth4 but there is incoming LACP traffic on eth0 and eth2.
> > > At the same time, according to the dmesg the kernel sees all of the
> > > interfaces as
> > > "link status definitely up, 10000 Mbps full duplex".
> > > The issue goes aways if I stop the application even without removing
> > > the XDP programs
> > > from the interfaces - the running xdpdump starts showing the incoming
> > > LACP traffic immediately.
> > > The issue also goes away if I do "ip link set down eth4 && ip link se=
t up eth4".
> >
> > and the setup is what when doing the link flap? XDP progs are loaded to
> > each of the 3 interfaces of bond?
> Yes, the same XDP program is loaded on application startup on each one
> of the interfaces which are part of bond0 (eth0, eth2, eth4):
> # xdp-loader status
> CURRENT XDP PROGRAM STATUS:
>
> Interface        Prio  Program name      Mode     ID   Tag
>   Chain actions
> -------------------------------------------------------------------------=
-------------
> lo                     <No XDP program loaded!>
> eth0                   xdp_dispatcher    native   1320 90f686eb86991928
>  =3D>              50     x3sp_splitter_func          1329
> 3b185187f1855c4c  XDP_PASS
> eth1                   <No XDP program loaded!>
> eth2                   xdp_dispatcher    native   1334 90f686eb86991928
>  =3D>              50     x3sp_splitter_func          1337
> 3b185187f1855c4c  XDP_PASS
> eth3                   <No XDP program loaded!>
> eth4                   xdp_dispatcher    native   1342 90f686eb86991928
>  =3D>              50     x3sp_splitter_func          1345
> 3b185187f1855c4c  XDP_PASS
> eth5                   <No XDP program loaded!>
> eth6                   <No XDP program loaded!>
> eth7                   <No XDP program loaded!>
> bond0                  <No XDP program loaded!>
> Each of these interfaces is setup to have 16 queues i.e. the application,
> through the DPDK machinery, opens 3x16 XSK sockets each bound to the
> corresponding queue of the corresponding interface.
> ~# ethtool -l eth0 # It's same for the other 2 devices
> Channel parameters for eth0:
> Pre-set maximums:
> RX:             n/a
> TX:             n/a
> Other:          1
> Combined:       48
> Current hardware settings:
> RX:             n/a
> TX:             n/a
> Other:          1
> Combined:       16
>
> >
> > > However, I'm not sure what happens with the bound XDP sockets in this=
 case
> > > because I haven't tested further.
> >
> > can you also try to bind xsk sockets before attaching XDP progs?
> I looked into the DPDK code again.
> The DPDK framework provides callback hooks like eth_rx_queue_setup
> and each "driver" implements it as needed. Each Rx/Tx queue of the device=
 is
> set up separately. The af_xdp driver currently does this for each Rx
> queue separately:
> 1. configures the umem for the queue
> 2. loads the XDP program on the corresponding interface, if not already l=
oaded
>    (i.e. this happens only once per interface when its first queue is set=
 up).
> 3. does xsk_socket__create which as far as I looked also internally binds=
 the
> socket to the given queue
> 4. places the socket in the XSKS map of the XDP program via bpf_map_updat=
e_elem
>
> So, it seems to me that the change needed will be a bit more involved.
> I'm not sure if it'll be possible to hardcode, just for the test, the
> program loading and
> the placing of all XSK sockets in the map to happen when the setup of the=
 last
> "queue" for the given interface is done. I need to think a bit more about=
 this.
Changed the code of the DPDK af_xdp "driver" to create and bind all of
the XSK sockets
to the queues of the corresponding interface and after that, after the
initialization of the
last XSK socket, I added the logic for the attachment of the XDP
program to the interface
and the population of the XSK map with the created sockets.
The issue was still there but it was kind of harder to reproduce - it
happened once for 5
starts of the application.

>
> >
> > >
> > > It seems to me that something racy happens when the interfaces go dow=
n
> > > and back up
> > > (visible in the dmesg) when the XDP sockets are bound to their queues=
.
> > > I mean, I'm not sure why the interfaces go down and up but setting
> > > only the XDP programs
> > > on the interfaces doesn't cause this behavior. So, I assume it's
> > > caused by the binding of the XDP sockets.
> >
> > hmm i'm lost here, above you said you got no incoming traffic on eth4 e=
ven
> > without xsk sockets being bound?
> Probably I've phrased something in a wrong way.
> The issue is not observed if I load the XDP program on all interfaces
> (eth0, eth2, eth4)
> with the xdp-loader:
> xdp-loader load --mode native <iface> <path-to-the-xdp-program>
> It's not observed probably because there are no interface down/up actions=
.
> I also modified the DPDK "driver" to not remove the XDP program on exit a=
nd thus
> when the application stops only the XSK sockets are closed but the
> program remains
> loaded at the interfaces. When I stop this version of the application
> while running the
> xdpdump at the same time I see that the traffic immediately appears in
> the xdpdump.
> Also, note that I basically trimmed the XDP program to simply contain
> the XSK map
> (BPF_MAP_TYPE_XSKMAP) and the function just does "return XDP_PASS;".
> I wanted to exclude every possibility for the XDP program to do something=
 wrong.
> So, from the above it seems to me that the issue is triggered somehow by =
the XSK
> sockets usage.
>
> >
> > > It could be that the issue is not related to the XDP sockets but just
> > > to the down/up actions of the interfaces.
> > > On the other hand, I'm not sure why the issue is easily reproducible
> > > when the zero copy mode is enabled
> > > (4 out of 5 tests reproduced the issue).
> > > However, when the zero copy is disabled this issue doesn't happen
> > > (I tried 10 times in a row and it doesn't happen).
> >
> > any chances that you could rule out the bond of the picture of this iss=
ue?
> I'll need to talk to the network support guys because they manage the net=
work
> devices and they'll need to change the LACP/Trunk setup of the above
> "remote device".
> I can't promise that they'll agree though.
>
> > on my side i'll try to play with multiple xsk sockets within same netde=
v
> > served by ixgbe and see if i observe something broken. I recently fixed
> > i40e Tx disable timeout issue, so maybe ixgbe has something off in down=
/up
> > actions as you state as well.

