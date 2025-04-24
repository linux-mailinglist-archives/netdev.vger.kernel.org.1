Return-Path: <netdev+bounces-185397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DBA9A0C8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F72C4461D0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400F1DE3B5;
	Thu, 24 Apr 2025 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhDyuWvy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3F01CEE90
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474389; cv=none; b=eU3hOekB+dzaqNV0qI1b6uE4ZHr1KuqpIfKn/yERb0Cm47i+5DSVXnBeiorAc3gs0jqAKRo30QslnIVAClyviy1qerONx8M1Fr3CPJSyWyT04NECRuDc3TuWqhAh39JCM8qXpCQwdhc8S7i6rfL6Gim/rZP1vEU1KBvG0ggEhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474389; c=relaxed/simple;
	bh=g2nL3pBJauBIl7dp3B3/jZXWottfzLXZAJqT+WeDUkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5y5dLSR3gHlf6/tP6H+lrI4K5bSMUFwRmlfkn6kPvJ9yTMbaFZD+fbRNcQH54iy9wlHuPF9tTv6Ug7TYyi/QU/OlIX1YHpR45QAw6OmvBCYE+kPDcMFidRv93swJlE5BgGP/L6jfR4N/nfB7sJRO9NilDjby6lG8bAZDDmGfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhDyuWvy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3015001f862so555544a91.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745474387; x=1746079187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8B3NWyd9SJuer5kflvYRkj9obRceO5dwmU5hbXy7d4=;
        b=lhDyuWvynHHgf3+F3EnNBSB7Q2NNSdclMBfam85A0nlOYVZgH71U4rlQ1RolMRhpQT
         4cF0Tchm3BTySprrMWOdlS/cj6onJbA0dKvF4dzC1/qQqbe1tAQ5u6igTq3v159QJXRH
         n5++4bzxg5li+WTfnM2kyka0w/JCEA1jjg9h7OBZYpYLLXB21rLUg5Y1eI4dHRfc3tO6
         Nrkxg3qNpsN3aJ/fwl6vwF4jt6UbgGNpmcae2tdutS2/y3GLDypeNUfP3FTQMzjuU29f
         XdayUOVSAMCk+nbgSMwjDtM3CGvPfPNS1PozaDp94w6XLMtNBMwfSph1IQL24eTKA0LP
         l82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745474387; x=1746079187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8B3NWyd9SJuer5kflvYRkj9obRceO5dwmU5hbXy7d4=;
        b=HIAsWQJAgt8dALXkD8NI79xExzb4n7Y92KvJizM1inD586s5Wf7c+vG03cLGLZe7Pg
         9MahSkZhoD6ddnV/hdzYwIbdfpMvhyjSevfEA5cQAcMoSsLO3Fz0ScGq+YPC8pfgap3T
         UcM/089Cc1ffIk+919RB4g5Hkb6UlLuTvpQYVDnz/cP9ZDDCkeFTWBri/FjNuIe3EzPk
         pXaNZVsqcSUWegC1U1RfgJqfJVbpx9n0b8kSwi47tZPRhal+AvhLm3GKBVyl9WSGCwZ3
         b6zOHQuSqghNZPCYIH0whTZ/x91/w78EAK9eT3ns/W8emSPX6IrU3KgEX6wjLRqN8Czj
         tF7g==
X-Gm-Message-State: AOJu0YwHd8OR4gFlN+v0Pl1u1+n8aJtES/hdPDD2JMPOvGmtseMmyyRK
	GQAO0MrMdrlC3WTaSpQh5opKhjKvN7Rf7tgefIL/LQqo94ciRAxEK6B5YA9+N62vtthx/ijr6Ba
	hCw1quT3fFfOxKFmlr6qoQYUxpELWo4Ls
X-Gm-Gg: ASbGncuNDBbr+mnA5uMmrYwdtia7PXJu4dYgsYuJStAC/h8Q0SM9ZmpGsmZpF75bD6S
	LWlPiqBDyQ7V2i5SIawnM94XG90w/fonM646FtYWktSJN6FlEaMQj7I72joh3QvNX6qutIYXo09
	9RBt9Xn7svYjFhUEEwY9Zkb/1Df2oHPkgUuedo+sJ52dKODi1+Wk82kCZB
X-Google-Smtp-Source: AGHT+IH0Ne98gmjeW61kohsVD3B4SrogRBJlUW8D7z0dA7DiaNeXtjWc3OW8p/Zc3MZQMI1KOR/ZaY8FgqAC89gMV2E=
X-Received: by 2002:a17:90b:5410:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-309ed2a773emr2205132a91.20.1745474386642; Wed, 23 Apr 2025
 22:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
 <aAjSCwwuRpI8GdB7@shredder> <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>
 <aAkMhl3klxYx-n2Q@shredder>
In-Reply-To: <aAkMhl3klxYx-n2Q@shredder>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Wed, 23 Apr 2025 22:59:35 -0700
X-Gm-Features: ATxdqUGnH1F77cz7rotJoIKXZEMSqTNV8TyMCJg7WCVMwYZwhdb_m2j1unvG4AE
Message-ID: <CAEFUPH0kh73VU8TmbS3Jx8jJ_RjwbQStx5deV25Ji5a3ZQp-xQ@mail.gmail.com>
Subject: Re: query on EAPOL multicast packet with linux bridge interface
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 8:51=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> (Please avoid top posting)
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
>
> Do you see the EAPOL packets when running tcpdump on 'lan1' and 'br0'?
> Does the result change if you pass '-p' to tcpdump?
>
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
>
> I have zero experience with hostapd, but I assume it opens a packet
> socket on the specified interface to receive the EAPOL packets. When
> listening on 'br0' you should see the EAPOL packets with a VLAN tag
> which could be a problem for hostapd. When you told it to listen on
> 'lan1' it received the EAPOL packets without a VLAN. I would try to
> specify 'br0.10' and see if it helps. hostapd should observe the packets
> without a VLAN tag in this case.
>
> > >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>passing br0 as interface to
> > hostapd.
> > driver=3Dwired
> >
> >
> >
> > Regards
> > Simon


Hello Ido,

I tried with br0.10 and still did not see EAPOL packets are
forwarding. Below are the tcpdump logs with lan5 and br0.10.


root@sama7g5ek-tdy-sd:~# tcpdump -i br0.10 ether proto 0x888e -p
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on br0.10, link-type EN10MB (Ethernet), snapshot length 262144 by=
tes

br0: port 5(lan5) entered disabled state
mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Down
mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Up -
100Mbps/Full - flow control rx/tx
br0: port 5(lan5) entered blocking state
br0: port 5(lan5) entered forwarding state
18:15:59.243997 EAP packet (0) v2, len 5
18:16:02.245922 EAP packet (0) v2, len 5
18:16:08.252660 EAP packet (0) v2, len 5



root@sama7g5ek-tdy-sd:~# tcpdump -i lan5 ether proto 0x888e -p
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on lan5, link-type EN10MB (Ethernet), snapshot length 262144 byte=
s


br0: port 5(lan5) entered disabled state
mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Down
mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Up -
100Mbps/Full - flow control rx/tx
br0: port 5(lan5) entered blocking state
br0: port 5(lan5) entered forwarding state
18:18:00.558929 EAPOL start (1) v1, len 0
18:18:00.566422 EAP packet (0) v2, len 5
18:18:00.580678 EAP packet (0) v1, len 28
18:18:00.688667 EAP packet (0) v2, len 6
18:18:00.711016 EAP packet (0) v1, len 172
18:18:00.866300 EAP packet (0) v2, len 1004
18:18:00.867310 EAP packet (0) v1, len 6
18:18:00.871946 EAP packet (0) v2, len 1004
18:18:00.872795 EAP packet (0) v1, len 6
18:18:00.877155 EAP packet (0) v2, len 1004
18:18:00.878087 EAP packet (0) v1, len 6
18:18:00.882673 EAP packet (0) v2, len 866
18:18:00.893136 EAP packet (0) v1, len 1492
18:18:00.898185 EAP packet (0) v2, len 6
18:18:00.899091 EAP packet (0) v1, len 903
18:18:01.912476 EAP packet (0) v2, len 4


Regards
Simon

