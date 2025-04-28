Return-Path: <netdev+bounces-186344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A9A9E89F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F93ACCFB
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF491D5141;
	Mon, 28 Apr 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yam0fW8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA6610C
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823354; cv=none; b=K4rK/jxZAEcDiHgACQD/4zGwb2olqZUupYd+Hl++dtQQZUiPMVIy6nkHeDvWtrgFnUDX9DdUZoCVyxQwopI5VC2Qek1TL729kZj933HNprKONH0VxEGgfoahqsyxXLLv256k7ohRoJvxM4XvrhOK7aJynaFe+iRzTYVk7UHApQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823354; c=relaxed/simple;
	bh=5tJ0l2LxUVOnOuUk7/ZKkE5x1HzMXj9Pk6xuZ6vwECg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4/kb1yOMgjG9r3QtzCRDLvatouwZBmX4bP4rHtcJFSWhGcug0oJJf/86qDWt0niBrZOWF7E3Nc5/+ZM1iLKj/4JfxVuBDgEICAiY1zouoSRpPCiVKYPANpluIiZ3Vv8K89W8L9f23WeHt1A0hZcIymCQ1umD3btdKu+yA72Igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yam0fW8u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c91576aso36470825ad.3
        for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823353; x=1746428153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TE+ayV+HlhLqI7uVlx4zb0IXbibAaU8X2gniHQ7CpM=;
        b=Yam0fW8uxrA5VBCP3OXMJXwxM+H7tCGC52qDijE8wbSwiWnyjbS2FEZL2XtqRFLpd3
         4E5x/Gp51PnviNrnJJ9BUcNAt/vCfuGX1Dzr0j1R5kUiUmVA/MRlb/OjQ4+0N6It1fjX
         UtbjzYyA4uwYQ8MS2tzyCtd0yRWnfNtVi0r20MvOaw0lQZGRy5aLTnb1xnFuNdfpwxge
         g6TwWLhDwjr3CeB7Tpc4mogg3kvzWJ5h9lV60NTDBKFESfk4ehfD6DM1CI6T5rXZDFIr
         DzfKEbguhml9oxCqjxsx339tIgnRuvX3NtDRCUfpntagOIBMMm6uchU+6kWAVtmY24DG
         sKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823353; x=1746428153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TE+ayV+HlhLqI7uVlx4zb0IXbibAaU8X2gniHQ7CpM=;
        b=V27SzItWjFq+oKp44RuavsC8uYylIVCTSd2j1gFMJltvIBpmA5Qwn3EeFEumdhNdJU
         KSADjVy+P+dxNfKtSAKcFzWq8/cN+fpTAHLdGE/gAcPiWxgnbq+srO7qaOHfdRYhelgH
         +s9/3zpoCJNGIuZWqlmI54HeyTQm2QYjgHgkOiy4YIK1jBWlFxzkYZTxV+JJwzRsHw7z
         vxMicw62/bbj+Kb7aAuoSPMomKPcc+2GGgil6N2nMn3zvoI2xwu8UbpV792g7WFRIs73
         j6d+qw+lZr4I3oazD5g32vB8YxxNvJUl8RumpGKAOMXPMfSu9VRpzHpS657tglfvJICX
         jDUw==
X-Forwarded-Encrypted: i=1; AJvYcCUQt1oEN8Rvu917MWPML4jsZrFt9jlbZnqZ7qcTepir3NqAWQJAarSHbsQKef3WO3+2Ofy8+Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPVjIHPgotpxuZVwuPBXB6pLaH839+Ze78Li6w3gd8BxmCsPV
	5h2SnTsSmY4AR3U8mrvCSjEuDJfMnRKhyQ07OIMGhJPE7qP5XtJeTMWMurIhnjH2nQHCOvmJtL8
	ZEvuOhjRl5dof4tFcZZNPIjRMu+w=
X-Gm-Gg: ASbGncsKQ3Qppj3k1/dmIL2pvXZKyqDZMJ1/JU+exG2EcwLAY5gygjokR5mdUShc/9P
	WXwoa35EzrfxTfLn1XqXLAlUceH2CEUy8b6LACQg/njMI9Z1H1IhP47lhrnNwdIeThx8SW+t63j
	JXgTNR6Hm5USntFs9pU+xVPqWphVFj+eF85euBUvku25w2WVJtgH60NwLr
X-Google-Smtp-Source: AGHT+IFc7RZZPMjMS94wTmFX2XjKgLByl0KVaMX0JIbRLpi0ETNeIa00aly3yPdUMNXM9EOTJbts9tbISXzj3aYzACw=
X-Received: by 2002:a17:902:ea07:b0:224:e33:889b with SMTP id
 d9443c01a7336-22dc6a02897mr137090865ad.12.1745823352610; Sun, 27 Apr 2025
 23:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
 <aAjSCwwuRpI8GdB7@shredder> <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>
 <20250424102240.dxyk5uf6t6xfnd2k@skbuf>
In-Reply-To: <20250424102240.dxyk5uf6t6xfnd2k@skbuf>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Sun, 27 Apr 2025 23:55:41 -0700
X-Gm-Features: ATxdqUFPWAQukvOHrlF1wcEyiOnB1OrsxnrNMOe1-YpUNI36ExfQpGBK9tFi-aE
Message-ID: <CAEFUPH1uvr1O1RNk6Ru953cs4bbXbudma7hyZyYnWdbkqD8b6Q@mail.gmail.com>
Subject: Re: query on EAPOL multicast packet with linux bridge interface
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Can someone please suggest if we need all the patches in the link
below for 802.1x to work on a  bridge interface with DSA  marvel ports
?
https://lore.kernel.org/lkml/20221022115505.nlnkfy2xrgrq74li@skbuf/T/

I also noticed that the iproute2 package in my kernel version does not
include the "locked" port option. Is that the cause for the EAPOL
packets forwarding issue on the bridge interface ?

Regards
Simon





On Thu, Apr 24, 2025 at 3:22=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hello Simon,
>
> On Wed, Apr 23, 2025 at 06:26:40AM -0700, SIMON BABY wrote:
> > Thank you Ido.
> >
> > Here is the details of my setup:
> >
> > I have a microchip CPU connected to an 11 port marvell 88E6390 switch.
> > I am using the marvel  linux DSA driver  so that all the switch ports
> > (lan1, lan2, lan3 etc) are part of the linux kernel.
> >
> > I am using hostapd as an authenticator.
> >
> > An 802.1x client device is connected to port lan1 and binds this port
> > (lan1) to hostapd daemon, I can see EAPOL packets are being forwarded
> > to a radius server.
> >
> > I have created a bridge with vlan filtering with below commands and
> > bind the bridge (br0) with hostapd daemon. Now EAPOL packets are not
> > forwarded.
> >
> > ip link add name br0 type bridge vlan_filtering 1
> > ip link set dev lan1 master br0
> > ip link set dev lan2 master br0
> > bridge vlan add dev lan1 vid 10 pvid untagged
> > bridge vlan add dev lan2 vid 10 pvid untagged
> > ip link set dev br0 up
> > ip link set dev lan1 up
> > ip link set dev lan2 up
> > ip link add link br0 name br0.10 type vlan id 10
> > ip link set dev br0.10 up
> > ip addr add 192.168.2.1/24 dev br0.10
> > bridge vlan add vid 10 dev br0 self
> >
> > bridge vlan show
> > port              vlan-id
> > lan1              10 PVID Egress Untagged
> > lan2              10 PVID Egress Untagged
> > br0                10
> >
> > echo 8 > /sys/class/net/br0/bridge/group_fwd_mask
> > cat /sys/class/net/br0/bridge/group_fwd_mask
> > 0x8
> >
> > root@sama7g5ek-tdy-sd:~# cat /etc/hostapd.conf
> > ##### hostapd configuration file ######################################=
########
> > # Empty lines and lines starting with # are ignored
> >
> > # Example configuration file for wired authenticator. See hostapd.conf =
for
> > # more details.
> > interface=3Dbr0
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>passing br0 as interface to
> > hostapd.
> > driver=3Dwired
>
> Could you please clarify what is the expected data path of EAPOL packets?
> (I also have no experience with hostapd)
> Is the forwarding to the RADIUS server something that is handled by
> hostapd, through an IP socket, or is the kernel responsible for doing
> that automatically somehow? Is the RADIUS server IP accessible? Does
> hostapd log the reception of EAPOL packets? I'm trying to understand
> whether the problem is that hostapd is not receiving or not sending
> packets.
>
> I think the hostapd.conf "interface" option can be overridden by '-i'
> command line options. I'm wondering if there's any chance that is going
> on, and hostapd is not listening on br0.
>
> I don't understand the need for group_fwd_mask. In my image, you don't
> need software forwarding of EAPOL packets among bridge ports (which that
> option provides). You only need EAPOL frames to be received by a packet
> socket, and routed using IP to the RADIUS server, correct? Can't you
> just specify multiple '-i' options to hostapd, for the individual bridge
> ports like lan1, lan2, and skip the bridge data path processing for
> these packets, as happens by default when no group_fwd_mask is specified?
>
> Are you also using some other bridge port options, like 'locked', which
> you are not showing in the steps above?

