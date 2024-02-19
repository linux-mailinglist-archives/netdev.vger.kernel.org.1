Return-Path: <netdev+bounces-72944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06885A50C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739681F25640
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0C2C848;
	Mon, 19 Feb 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="cYmFAoyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC85364A8
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350340; cv=none; b=L3A81T8IpluZ8iJKMCsrLyVlAunttCIW4VzOsLmeXD/ESx0CRgFiuAxNzbEvljmUi/u2CJLH0pfw0WZB3RB41Gwjv1DFbFHSG4UDmadP3wh9qwJj5s3AWfuGAgavcfegYlvHxdb2zek7PHlZSIz34sEHbA1E9qpvS/YlDt3AOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350340; c=relaxed/simple;
	bh=ptmWYyl6OsfNo3WUQWY1xQfdb9Ebcp+Zm+O5Gvgm3Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrOjUo3WWiENjkOx/K46WUAG9w7x2d7jA3IR7z39fEvk6aD3B/EPq9oCZIC47HR2l55Of4GnPsWWPtmVSjsoqcldnjxdxX7faw+9rnAQ6IXlYmZjy3iYorWYCOEEPONuxIEbi6m9+6MmoIDkT+4CWzfYzHzkEtUJMNKrBsGfCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=cYmFAoyS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso3577668a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1708350336; x=1708955136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vZdrTV1FokQHFlHh5kVk8P6LuMwrSZPG/tHGgKQwSE=;
        b=cYmFAoySlukiFaXZUx6RQscLH4I9UAUupslJ0DG0mdbjkkzF9LdOZr8UrATi7khwbJ
         ZplcRyeadJ7iVhiSdEG8s3bqbXeN87SsbxCA/QtoIygMeIRqZgKZRDJP+uAvUJ+DhS6g
         4jqZrZe5r8NyC6eEah5HubK8gUVM/Cr62jtYSkS/rW4Fw2BoZg5X8JaBgYT6OKH//Ldp
         2vCZwNJnGFJsvNrLRsu5pPNcmHy9YAx0eFkRsg8ctM3/j0WoPVLcxxuZrHF7xvLy6NNX
         Ug/BxyRiovhynAQc/xTyEA0P52Ual5VWfPhkxC7gW0Ne+aMEqm6ZZYxrNfv3A0NmaEnO
         EJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350336; x=1708955136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vZdrTV1FokQHFlHh5kVk8P6LuMwrSZPG/tHGgKQwSE=;
        b=l3F5V3N8Jz5HuS+Z7ZPokOLtbM0TaRW4P0tpPD0BKihHdRv3o/Z9K+6Lymn5mpF49p
         InSXZxfmU9xlhQcV3avunrrDcj0EhzEbTB4dG9U1YCndP/konmmGvjX/wuPsgna8c9wn
         bswOcVxvmcsk5DKAf7NAHjN3eDFmzvICX035HQrlTDnXnWB4Q37Iib6TCiprlmPKhMxR
         bC3LuBXtJSwqhT+BsysA/Yvhr59IrLAHELHg/3DLOouab5JYS983IOFmSSFtTxpwUMec
         uSZ/jChAcGDTEygoY9SNfupPiIqkuzQvISSuDLDoFQZg0Si+U2OzR/fFHFRCa3LyQabW
         LGnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsOJ+HFccFPafSw7JhYJu8Pzs5dBjRg2C7zZ9AJvdS6McEv4HErNtUOW/ZISp/1jL4KivHCsmX2IAQD0Jbnwwr6ujI/Pv2
X-Gm-Message-State: AOJu0Yzr4rJy5Scxj4ujOqfovW1q8VvraHgPHLkIFwK465ggjJc4Wv2A
	E24ytigQny44qJAIEuYNYslOvYh0FyFVITmlsC+SE0kAp3C4+8JohtlCYNhscCnMP4WTum2JUGJ
	iE986GhCVOygV2YGsbzvjrPOpXkraIBRGBX7X8Q==
X-Google-Smtp-Source: AGHT+IFyYMUQDLklGLeiicmH06xu564mPjcS3WiiDC1CNHE5M8177sW9wTepeMh8xRJR1gMe0MqOtpW5Es2zPTEE2hM=
X-Received: by 2002:a17:906:3e0e:b0:a3e:d92d:6605 with SMTP id
 k14-20020a1709063e0e00b00a3ed92d6605mr347817eji.3.1708350335920; Mon, 19 Feb
 2024 05:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk> <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk> <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer> <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
 <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
 <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com> <Zc+aN4rYKZKu3vKx@boxer>
In-Reply-To: <Zc+aN4rYKZKu3vKx@boxer>
From: Pavel Vazharov <pavel@x3me.net>
Date: Mon, 19 Feb 2024 15:45:24 +0200
Message-ID: <CAJEV1ij+fYUhXmscxk_tsgDppHFWZLuP_bc_gUhZPLMdi4qLQA@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:24=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> > > > > >
> > > > > > Back to the issue.
> > > > > > I just want to say again that we are not binding the XDP socket=
s to
> > > > > > the bonding device.
> > > > > > We are binding the sockets to the queues of the physical interf=
aces
> > > > > > "below" the bonding device.
> > > > > > My further observation this time is that when the issue happens=
 and
> > > > > > the remote device reports
> > > > > > the LACP error there is no incoming LACP traffic on the corresp=
onding
> > > > > > local port,
> > > > > > as seen by the xdump.
> > > > > > The tcpdump at the same time sees only outgoing LACP packets an=
d
> > > > > > nothing incoming.
> > > > > > For example:
> > > > > > Remote device
> > > > > >                           Local Server
> > > > > > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/12 <---=
> eth0
> > > > > > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/13 <---=
> eth2
> > > > > > TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/14 <---=
> eth4
> > > > > > And when the remote device reports "received an abnormal LACPDU=
"
> > > > > > for PortName=3DXGigabitEthernet0/0/14 I can see via xdpdump tha=
t there
> > > > > > is no incoming LACP traffic
> > > > >
> > > > > Hey Pavel,
> > > > >
> > > > > can you also look at /proc/interrupts at eth4 and what ethtool -S=
 shows
> > > > > there?
> > > > I reproduced the problem but this time the interface with the weird
> > > > state was eth0.
> > > > It's different every time and sometimes even two of the interfaces =
are
> > > > in such a state.
> > > > Here are the requested info while being in this state:
> > > > ~# ethtool -S eth0 > /tmp/stats0.txt ; sleep 10 ; ethtool -S eth0 >
> > > > /tmp/stats1.txt ; diff /tmp/stats0.txt /tmp/stats1.txt
> > > > 6c6
> > > > <      rx_pkts_nic: 81426
> > > > ---
> > > > >      rx_pkts_nic: 81436
> > > > 8c8
> > > > <      rx_bytes_nic: 10286521
> > > > ---
> > > > >      rx_bytes_nic: 10287801
> > > > 17c17
> > > > <      multicast: 72216
> > > > ---
> > > > >      multicast: 72226
> > > > 48c48
> > > > <      rx_no_dma_resources: 1109
> > > > ---
> > > > >      rx_no_dma_resources: 1119
> > > >
> > > > ~# cat /proc/interrupts | grep eth0 > /tmp/interrupts0.txt ; sleep =
10
> > > > ; cat /proc/interrupts | grep eth0 > /tmp/interrupts1.txt
> > > > interrupts0: 430 3098 64 108199 108199 108199 108199 108199 108199
> > > > 108199 108201 63 64 1865 108199  61
> > > > interrupts1: 435 3103 69 117967 117967  117967 117967 117967  11796=
7
> > > > 117967 117969 68 69 1870  117967 66
> > > >
> > > > So, it seems that packets are coming on the interface but they don'=
t
> > > > reach to the XDP layer and deeper.
> > > > rx_no_dma_resources - this counter seems to give clues about a poss=
ible issue?
> > > >
> > > > >
> > > > > > on eth4 but there is incoming LACP traffic on eth0 and eth2.
> > > > > > At the same time, according to the dmesg the kernel sees all of=
 the
> > > > > > interfaces as
> > > > > > "link status definitely up, 10000 Mbps full duplex".
> > > > > > The issue goes aways if I stop the application even without rem=
oving
> > > > > > the XDP programs
> > > > > > from the interfaces - the running xdpdump starts showing the in=
coming
> > > > > > LACP traffic immediately.
> > > > > > The issue also goes away if I do "ip link set down eth4 && ip l=
ink set up eth4".
> > > > >
> > > > > and the setup is what when doing the link flap? XDP progs are loa=
ded to
> > > > > each of the 3 interfaces of bond?
> > > > Yes, the same XDP program is loaded on application startup on each =
one
> > > > of the interfaces which are part of bond0 (eth0, eth2, eth4):
> > > > # xdp-loader status
> > > > CURRENT XDP PROGRAM STATUS:
> > > >
> > > > Interface        Prio  Program name      Mode     ID   Tag
> > > >   Chain actions
> > > > -------------------------------------------------------------------=
-------------------
> > > > lo                     <No XDP program loaded!>
> > > > eth0                   xdp_dispatcher    native   1320 90f686eb8699=
1928
> > > >  =3D>              50     x3sp_splitter_func          1329
> > > > 3b185187f1855c4c  XDP_PASS
> > > > eth1                   <No XDP program loaded!>
> > > > eth2                   xdp_dispatcher    native   1334 90f686eb8699=
1928
> > > >  =3D>              50     x3sp_splitter_func          1337
> > > > 3b185187f1855c4c  XDP_PASS
> > > > eth3                   <No XDP program loaded!>
> > > > eth4                   xdp_dispatcher    native   1342 90f686eb8699=
1928
> > > >  =3D>              50     x3sp_splitter_func          1345
> > > > 3b185187f1855c4c  XDP_PASS
> > > > eth5                   <No XDP program loaded!>
> > > > eth6                   <No XDP program loaded!>
> > > > eth7                   <No XDP program loaded!>
> > > > bond0                  <No XDP program loaded!>
> > > > Each of these interfaces is setup to have 16 queues i.e. the applic=
ation,
> > > > through the DPDK machinery, opens 3x16 XSK sockets each bound to th=
e
> > > > corresponding queue of the corresponding interface.
> > > > ~# ethtool -l eth0 # It's same for the other 2 devices
> > > > Channel parameters for eth0:
> > > > Pre-set maximums:
> > > > RX:             n/a
> > > > TX:             n/a
> > > > Other:          1
> > > > Combined:       48
> > > > Current hardware settings:
> > > > RX:             n/a
> > > > TX:             n/a
> > > > Other:          1
> > > > Combined:       16
> > > >
> > > > >
> > > > > > However, I'm not sure what happens with the bound XDP sockets i=
n this case
> > > > > > because I haven't tested further.
> > > > >
> > > > > can you also try to bind xsk sockets before attaching XDP progs?
> > > > I looked into the DPDK code again.
> > > > The DPDK framework provides callback hooks like eth_rx_queue_setup
> > > > and each "driver" implements it as needed. Each Rx/Tx queue of the =
device is
> > > > set up separately. The af_xdp driver currently does this for each R=
x
> > > > queue separately:
> > > > 1. configures the umem for the queue
> > > > 2. loads the XDP program on the corresponding interface, if not alr=
eady loaded
> > > >    (i.e. this happens only once per interface when its first queue =
is set up).
> > > > 3. does xsk_socket__create which as far as I looked also internally=
 binds the
> > > > socket to the given queue
> > > > 4. places the socket in the XSKS map of the XDP program via bpf_map=
_update_elem
> > > >
> > > > So, it seems to me that the change needed will be a bit more involv=
ed.
> > > > I'm not sure if it'll be possible to hardcode, just for the test, t=
he
> > > > program loading and
> > > > the placing of all XSK sockets in the map to happen when the setup =
of the last
> > > > "queue" for the given interface is done. I need to think a bit more=
 about this.
> > > Changed the code of the DPDK af_xdp "driver" to create and bind all o=
f
> > > the XSK sockets
> > > to the queues of the corresponding interface and after that, after th=
e
> > > initialization of the
> > > last XSK socket, I added the logic for the attachment of the XDP
> > > program to the interface
> > > and the population of the XSK map with the created sockets.
> > > The issue was still there but it was kind of harder to reproduce - it
> > > happened once for 5
> > > starts of the application.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > It seems to me that something racy happens when the interfaces =
go down
> > > > > > and back up
> > > > > > (visible in the dmesg) when the XDP sockets are bound to their =
queues.
> > > > > > I mean, I'm not sure why the interfaces go down and up but sett=
ing
> > > > > > only the XDP programs
> > > > > > on the interfaces doesn't cause this behavior. So, I assume it'=
s
> > > > > > caused by the binding of the XDP sockets.
> > > > >
> > > > > hmm i'm lost here, above you said you got no incoming traffic on =
eth4 even
> > > > > without xsk sockets being bound?
> > > > Probably I've phrased something in a wrong way.
> > > > The issue is not observed if I load the XDP program on all interfac=
es
> > > > (eth0, eth2, eth4)
> > > > with the xdp-loader:
> > > > xdp-loader load --mode native <iface> <path-to-the-xdp-program>
> > > > It's not observed probably because there are no interface down/up a=
ctions.
> > > > I also modified the DPDK "driver" to not remove the XDP program on =
exit and thus
> > > > when the application stops only the XSK sockets are closed but the
> > > > program remains
> > > > loaded at the interfaces. When I stop this version of the applicati=
on
> > > > while running the
> > > > xdpdump at the same time I see that the traffic immediately appears=
 in
> > > > the xdpdump.
> > > > Also, note that I basically trimmed the XDP program to simply conta=
in
> > > > the XSK map
> > > > (BPF_MAP_TYPE_XSKMAP) and the function just does "return XDP_PASS;"=
.
> > > > I wanted to exclude every possibility for the XDP program to do som=
ething wrong.
> > > > So, from the above it seems to me that the issue is triggered someh=
ow by the XSK
> > > > sockets usage.
> > > >
> > > > >
> > > > > > It could be that the issue is not related to the XDP sockets bu=
t just
> > > > > > to the down/up actions of the interfaces.
> > > > > > On the other hand, I'm not sure why the issue is easily reprodu=
cible
> > > > > > when the zero copy mode is enabled
> > > > > > (4 out of 5 tests reproduced the issue).
> > > > > > However, when the zero copy is disabled this issue doesn't happ=
en
> > > > > > (I tried 10 times in a row and it doesn't happen).
> > > > >
> > > > > any chances that you could rule out the bond of the picture of th=
is issue?
> > > > I'll need to talk to the network support guys because they manage t=
he network
> > > > devices and they'll need to change the LACP/Trunk setup of the abov=
e
> > > > "remote device".
> > > > I can't promise that they'll agree though.
> > We changed the setup and I did the tests with a single port, no
> > bonding involved.
> > The port was configured with 16 queues (and 16 XSK sockets bound to the=
m).
> > I tested with about 100 Mbps of traffic to not break lots of users.
> > During the tests I observed the traffic on the real time graph on the
> > remote device port
> > connected to the server machine where the application was running in
> > L3 forward mode:
> > - with zero copy enabled the traffic to the server was about 100 Mbps
> > but the traffic
> > coming out of the server was about 50 Mbps (i.e. half of it).
> > - with no zero copy the traffic in both directions was the same - the
> > two graphs matched perfectly
> > Nothing else was changed during the both tests, only the ZC option.
> > Can I check some stats or something else for this testing scenario
> > which could be
> > used to reveal more info about the issue?
>
> FWIW I don't see this on my side. My guess would be that some of the
> queues stalled on ZC due to buggy enable/disable ring pair routines that =
I
> am (fingers crossed :)) fixing, or trying to fix in previous email. You
> could try something as simple as:
>
> $ watch -n 1 "ethtool -S eth_ixgbe | grep rx | grep bytes"
>
> and verify each of the queues that are supposed to receive traffic. Do th=
e
> same thing with tx, similarly.
>
> >
> > > >
Thank you for the help.

I tried the given patch on kernel 6.7.5.
The bonding issue, that I described in the above e-mails, seems fixed.
I can no longer reproduce the issue with the malformed LACP messages.

However, I tested again with traffic and the issue remains:
- when traffic is redirected to the machine and simply forwarded at L3
by our application only about 1/2 - 2/3 of it exits the machine
- disabling only the Zero Copy (and nothing else in the application)
fixes the issue
- another thing that I noticed is in the device stats - the Rx bytes
looks OK and the counters of every queue increase over the time (with
and without ZC)
ethtool -S eth4 | grep rx | grep bytes
     rx_bytes: 20061532582
     rx_bytes_nic: 27823942900
     rx_queue_0_bytes: 690230537
     rx_queue_1_bytes: 1051217950
     rx_queue_2_bytes: 1494877257
     rx_queue_3_bytes: 1989628734
     rx_queue_4_bytes: 894557655
     rx_queue_5_bytes: 1557310636
     rx_queue_6_bytes: 1459428265
     rx_queue_7_bytes: 1514067682
     rx_queue_8_bytes: 432567753
     rx_queue_9_bytes: 1251708768
     rx_queue_10_bytes: 1091840145
     rx_queue_11_bytes: 904127964
     rx_queue_12_bytes: 1241335871
     rx_queue_13_bytes: 2039939517
     rx_queue_14_bytes: 777819814
     rx_queue_15_bytes: 1670874034

- without ZC the Tx bytes also look OK
ethtool -S eth4 | grep tx | grep bytes
     tx_bytes: 24411467399
     tx_bytes_nic: 29600497994
     tx_queue_0_bytes: 1525672312
     tx_queue_1_bytes: 1527162996
     tx_queue_2_bytes: 1529701681
     tx_queue_3_bytes: 1526220338
     tx_queue_4_bytes: 1524403501
     tx_queue_5_bytes: 1523242084
     tx_queue_6_bytes: 1523543868
     tx_queue_7_bytes: 1525376190
     tx_queue_8_bytes: 1526844278
     tx_queue_9_bytes: 1523938842
     tx_queue_10_bytes: 1522663364
     tx_queue_11_bytes: 1527292259
     tx_queue_12_bytes: 1525206246
     tx_queue_13_bytes: 1526670255
     tx_queue_14_bytes: 1523266153
     tx_queue_15_bytes: 1530263032

- however with ZC enabled the Tx bytes stats don't look OK (some
queues are like doing nothing) - again it's exactly the same
application
The sum bytes increase much more than the sum of the per queue bytes.
ethtool -S eth4 | grep tx | grep bytes ; sleep 1 ; ethtool -S eth4 |
grep tx | grep bytes
     tx_bytes: 256022649
     tx_bytes_nic: 34961074621
     tx_queue_0_bytes: 372
     tx_queue_1_bytes: 0
     tx_queue_2_bytes: 0
     tx_queue_3_bytes: 0
     tx_queue_4_bytes: 9920
     tx_queue_5_bytes: 0
     tx_queue_6_bytes: 0
     tx_queue_7_bytes: 0
     tx_queue_8_bytes: 0
     tx_queue_9_bytes: 1364
     tx_queue_10_bytes: 0
     tx_queue_11_bytes: 0
     tx_queue_12_bytes: 1116
     tx_queue_13_bytes: 0
     tx_queue_14_bytes: 0
     tx_queue_15_bytes: 0

     tx_bytes: 257830280
     tx_bytes_nic: 34962912861
     tx_queue_0_bytes: 372
     tx_queue_1_bytes: 0
     tx_queue_2_bytes: 0
     tx_queue_3_bytes: 0
     tx_queue_4_bytes: 10044
     tx_queue_5_bytes: 0
     tx_queue_6_bytes: 0
     tx_queue_7_bytes: 0
     tx_queue_8_bytes: 0
     tx_queue_9_bytes: 1364
     tx_queue_10_bytes: 0
     tx_queue_11_bytes: 0
     tx_queue_12_bytes: 1116
     tx_queue_13_bytes: 0
     tx_queue_14_bytes: 0
     tx_queue_15_bytes: 0

