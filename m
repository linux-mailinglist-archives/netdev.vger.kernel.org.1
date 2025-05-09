Return-Path: <netdev+bounces-189136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C0AB0970
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 07:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311391C07E30
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E6266569;
	Fri,  9 May 2025 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpzXCQW2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA63139D1B
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746767313; cv=none; b=UR/xuu+4V+U2YXCkfkf/V+A8MN9jYr1HNEMC2touAYPrwwgo1nWseajztmHAn+314pViwI8As2ZhT1ooWeBtpWDo8nxLZoye03TyJyYqJkG/ogpz4p9WhXL5uDALet7JO0PzSkpCH5ZB5aQ4+i7FvDk1rRpD7dOPVPtU8vLcTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746767313; c=relaxed/simple;
	bh=RTRTN7tBp4k4eiQANh+wUUTmwPN3s32VXSSA5+frSf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxdGCn+HZx3mxtwJ561Xc+8nsRncyxy2YnrTi3KByU/4YbqNHchGtm/o9X8cP0QHa8Pj5JHCGKkZSq8+Yny91PIE2jsKqWmI2TlijnXctqpxrQuiTqcPlVRItGgGJrvQkq9XDgM3Qcw++GIKBAygsruwdv52TB90o5KO9aDFf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpzXCQW2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e16234307so19661265ad.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746767310; x=1747372110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf4hcYjr+3bYRekVOqpMlaflJYM+NexoC+uEhrBJkT4=;
        b=bpzXCQW26Ojn+NJ1zOUgrmVhZj6LkswV3USbSDRUOAH6IjOQeE0aI+xvnf4zlaTiuo
         xqvG8zaZolcabgkjqAK47Wq/sByCr7kxLihELtvLI7q/8rdAWMacQzRZHTBLpgX02sjS
         lpkcNK4t71RbPLzgynM0xxVBhzWaEfdWlLa1Cu1uqcSkETIzeU2+Z+s2TEku1a+Kug6p
         1MjLy+awhIUyXfBOhFxFa2rk/7szt/Vkh7rsHWIL3NMIHe41BfRMrOOHodkaHDOUInLD
         xWgAkriy/pb5oj8l6DR9wPjFuM2ccDWEK3aToYGCHabp3dYHe9+VymtXYCTzVgQja2Ro
         GHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746767310; x=1747372110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf4hcYjr+3bYRekVOqpMlaflJYM+NexoC+uEhrBJkT4=;
        b=HR3B0PduUNKGrXOTqgmUO/gzGhY+8t7iCdK3Jo2iIbSYqb8F+1nZsM5/IHyf05BL1O
         BjehskVQ3O5R5jlfXeJLPuNvXoV8HD421F8DGqPF9KPIVc7AFusyHzbOcpa2egNoLHaU
         HSoqW1snzjKTvSXSJLpB61cywv5s7OeFLpfffXVFLSyFN6p3FOMtFRZ3t9xjbdnZhnZp
         gl7jAZ7S1/Cbz72VbYcEMGeVJxAIrgzu0A2EtLohJI1c6a0RZZeYW4yiOI1G5ta1I97X
         X0FJo6aD04LM86dam3aLuSAlFWopjrqtaTmlexSmqeS4uyKTA80PN7o5RlEnTk5RWhKv
         t6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi9KtbmAAMx9Lrns/4LTYgEna7eOgPM31N+THGsb67Az1ftXeiW5pzwRh00CCO8D/Wxemx1S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xBxJP/vlFoR+Bu2IZLHn4zwWgIsNK4nYu1vP4UixJOvbcj9P
	4RuNzd1/eJkHO3DRT2CazaIV99YBFmJIciTJmx/Uy2Tk33NTDaOKAUQQaFJJ2sJXJ1aU+wPeP+0
	vCgC2FatRZrSIGeFM6Wus0P6xecc=
X-Gm-Gg: ASbGncvzIXeBUT6ljCnUbEcpoGCX6Imo3aLumUWWNRmNtvWEKwcXN35I1YU1qvT2Hn7
	T6i2z055yisCG0rDLUehF4sIb5y1JvS1ZJ6RJC9dOSNwPoavN6252l+tq5KsPoTGjRdPirZ9WcG
	ed4RS8xSbk/7NrbKvXEQ0=
X-Google-Smtp-Source: AGHT+IHWR6ZP6LIhxPiyak43GRGCFLV0i9rvNRc2q80hxi81m4E6MOwCnYPNN5dQLNL5PCPWaekC2v07tna210+4YIk=
X-Received: by 2002:a17:902:ea0c:b0:22e:491b:20d5 with SMTP id
 d9443c01a7336-22fc940f061mr26434085ad.26.1746767310341; Thu, 08 May 2025
 22:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
 <aAjSCwwuRpI8GdB7@shredder> <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>
 <20250424102240.dxyk5uf6t6xfnd2k@skbuf> <CAEFUPH1uvr1O1RNk6Ru953cs4bbXbudma7hyZyYnWdbkqD8b6Q@mail.gmail.com>
In-Reply-To: <CAEFUPH1uvr1O1RNk6Ru953cs4bbXbudma7hyZyYnWdbkqD8b6Q@mail.gmail.com>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Thu, 8 May 2025 22:08:18 -0700
X-Gm-Features: AX0GCFu6NlPx1dzZwikt6Z6M0vN_o_5hPXRoVrHmHvB-HAZkgNXxDQoNB6LyP-I
Message-ID: <CAEFUPH3W83KhQG0vAF_iovFfu218HWCkKD56xNOfSB3_FhAFRw@mail.gmail.com>
Subject: Re: query on EAPOL multicast packet with linux bridge interface
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 11:55=E2=80=AFPM SIMON BABY <simonkbaby@gmail.com> =
wrote:
>
> Hi,
>
> Can someone please suggest if we need all the patches in the link
> below for 802.1x to work on a  bridge interface with DSA  marvel ports
> ?
> https://lore.kernel.org/lkml/20221022115505.nlnkfy2xrgrq74li@skbuf/T/
>
> I also noticed that the iproute2 package in my kernel version does not
> include the "locked" port option. Is that the cause for the EAPOL
> packets forwarding issue on the bridge interface ?
>
> Regards
> Simon
>
>
>
>
>
> On Thu, Apr 24, 2025 at 3:22=E2=80=AFAM Vladimir Oltean <olteanv@gmail.co=
m> wrote:
> >
> > Hello Simon,
> >
> > On Wed, Apr 23, 2025 at 06:26:40AM -0700, SIMON BABY wrote:
> > > Thank you Ido.
> > >
> > > Here is the details of my setup:
> > >
> > > I have a microchip CPU connected to an 11 port marvell 88E6390 switch=
.
> > > I am using the marvel  linux DSA driver  so that all the switch ports
> > > (lan1, lan2, lan3 etc) are part of the linux kernel.
> > >
> > > I am using hostapd as an authenticator.
> > >
> > > An 802.1x client device is connected to port lan1 and binds this port
> > > (lan1) to hostapd daemon, I can see EAPOL packets are being forwarded
> > > to a radius server.
> > >
> > > I have created a bridge with vlan filtering with below commands and
> > > bind the bridge (br0) with hostapd daemon. Now EAPOL packets are not
> > > forwarded.
> > >
> > > ip link add name br0 type bridge vlan_filtering 1
> > > ip link set dev lan1 master br0
> > > ip link set dev lan2 master br0
> > > bridge vlan add dev lan1 vid 10 pvid untagged
> > > bridge vlan add dev lan2 vid 10 pvid untagged
> > > ip link set dev br0 up
> > > ip link set dev lan1 up
> > > ip link set dev lan2 up
> > > ip link add link br0 name br0.10 type vlan id 10
> > > ip link set dev br0.10 up
> > > ip addr add 192.168.2.1/24 dev br0.10
> > > bridge vlan add vid 10 dev br0 self
> > >
> > > bridge vlan show
> > > port              vlan-id
> > > lan1              10 PVID Egress Untagged
> > > lan2              10 PVID Egress Untagged
> > > br0                10
> > >
> > > echo 8 > /sys/class/net/br0/bridge/group_fwd_mask
> > > cat /sys/class/net/br0/bridge/group_fwd_mask
> > > 0x8
> > >
> > > root@sama7g5ek-tdy-sd:~# cat /etc/hostapd.conf
> > > ##### hostapd configuration file ####################################=
##########
> > > # Empty lines and lines starting with # are ignored
> > >
> > > # Example configuration file for wired authenticator. See hostapd.con=
f for
> > > # more details.
> > > interface=3Dbr0
> > > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>passing br0 as interface to
> > > hostapd.
> > > driver=3Dwired
> >
> > Could you please clarify what is the expected data path of EAPOL packet=
s?
> > (I also have no experience with hostapd)
> > Is the forwarding to the RADIUS server something that is handled by
> > hostapd, through an IP socket, or is the kernel responsible for doing
> > that automatically somehow? Is the RADIUS server IP accessible? Does
> > hostapd log the reception of EAPOL packets? I'm trying to understand
> > whether the problem is that hostapd is not receiving or not sending
> > packets.
> >
> > I think the hostapd.conf "interface" option can be overridden by '-i'
> > command line options. I'm wondering if there's any chance that is going
> > on, and hostapd is not listening on br0.
> >
> > I don't understand the need for group_fwd_mask. In my image, you don't
> > need software forwarding of EAPOL packets among bridge ports (which tha=
t
> > option provides). You only need EAPOL frames to be received by a packet
> > socket, and routed using IP to the RADIUS server, correct? Can't you
> > just specify multiple '-i' options to hostapd, for the individual bridg=
e
> > ports like lan1, lan2, and skip the bridge data path processing for
> > these packets, as happens by default when no group_fwd_mask is specifie=
d?
> >
> > Are you also using some other bridge port options, like 'locked', which
> > you are not showing in the steps above?

Hello,

I have some improvement with my 802.1x testing.
I have enabled the "locked port" feature and it stopped all traffic
except "EAPOL".
I am using hostapd_cli tool for monitoring the 802.1x traffic.
 I see that after the authentication success, the fdb is added with a
new STA mac address. Is it done automatically  with the latest 802.1x
package?
I see below logs with hostapd_cli tool.
root@sama7g5ek-tdy-sd:~# hostapd_cli -i br0.50

<3>CTRL-EVENT-EAP-STARTED 00:0e:c6:88:75:e7

<3>CTRL-EVENT-EAP-PROPOSED-METHOD vendor=3D0 method=3D1

<3>CTRL-EVENT-EAP-SUCCESS2 00:0e:c6:88:75:e7

<3>AP-STA-CONNECTED 00:0e:c6:88:75:e7

root@sama7g5ek-tdy-sd:~# bridge fdb show | grep 00:0e:c6:88:75:e7

00:0e:c6:88:75:e7 dev lan1 vlan 50 master br0
                          >>>>>>>>>>>>>>>> got this entry in the FDB.

root@sama7g5ek-tdy-sd:~#

 Once I make the interface down, I don=E2=80=99t see any event with
hostapd_cli and the fdb entry got removed automatically.

I thought I would see the event AP-STA-DISCONNECTED with hostapd_cli.
Can you please suggest if I am supposed to see AP-STA-DISCONNECTED
when the interface goes down after the successful authentication ?

 Do I need to do anything from the user space for the FDB entries when
we see the events AP-STA-CONNECTED and AP-STA-DISCONNECTED ?

 Regards
Simon

