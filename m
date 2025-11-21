Return-Path: <netdev+bounces-240822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16301C7AEF8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E7F3A1E5D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29E33B963;
	Fri, 21 Nov 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netstatz.com header.i=@netstatz.com header.b="QKTsyaSm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703E1F09AD
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743830; cv=none; b=P/3RIlto0OsgpJ5xDP3KD/uGMfGOpKP5PhPPt7WKkFvd8Y1QscZ5QvCdxOqqSu7zVszZJgVZfNPvgRtazmCccfag5zHNKMEdvCyLJUfnzV6VLw1SZ0u7TMNomy7wPPFbPgA9sy6ERs2/Wjdloke2QLvXZexkaUgrVSW6ofYic38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743830; c=relaxed/simple;
	bh=5+kCyy8X32jPH8aWSDVlDLqeMbE4PAZjRcD96juLnZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDfQ8SCZcEa1aHrqtAEMbwf8tV6QFIMTGq39XjkDBMzEoIkmE19LdgymYauz54Gea8ndBwrpyjiYv0xqTG5/6k1jjzyl9eTkW02JKNut+sE1gib9gDhmAvwNHfO3CWqhaksYLLhOswjyxE77tDldDFFkRzq3ACAqMd+F9Dn6d4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netstatz.com; spf=pass smtp.mailfrom=netstatz.com; dkim=pass (2048-bit key) header.d=netstatz.com header.i=@netstatz.com header.b=QKTsyaSm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netstatz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netstatz.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37b95f87d64so18358241fa.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netstatz.com; s=google; t=1763743826; x=1764348626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5MBa0m1dkCz6cDYfdxHUo9JM+hNhCvoRZjJDMtofyU=;
        b=QKTsyaSmKE+4CuPEW6SYOuyGdHvAw1u7WxwQ7T6Fl0EZGixr57ufBiswi1oin7UM+h
         736o74Wru4Waomkk/NzCx8ZrhWjMPZC9VY5t2kLT+O7Mt0ZF65izSJ59pR8f7RbVwpKP
         v6CvTlxkNJheIMi+rWPqYV0ILxlv6B6FFZ3sJYOil6vHX8dkhYvIIfvm/Fxt2e3sS8Q/
         FGPpiIpVt5ve/lU/t2CfOvxenC5wQkAgujPJ1CYsPaluXBgMke8QIDU4dAIt8bka/nFu
         HJWYZJtuOP45UkUXfZuTd5Si/NPznLuVpXdQ5gB015vKd1/RSF+OvTgsEQUUFVvh5jJ0
         SzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743826; x=1764348626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5MBa0m1dkCz6cDYfdxHUo9JM+hNhCvoRZjJDMtofyU=;
        b=tO/GuQsCHotrTp0c6ZjyJjXX7aII6or7MB2sAlEkqHH7mjva4GapRn6HBU2up05vwH
         zA8230BAKQxPM2ZgPs2WmEMO9hfnzKi4rYN1dHeGRAzhVsoW8RDa61zDcLOosafTdWz7
         fbWTkIo4KAGsxAGF9NJKAWl+j9ZIoI6UzlJTrRdsiO5QwNusmjykyaZ9w0JlQx/8rmsZ
         yn2DXdQQJzbjy1bD9/U1Jw3NZrWw2IRToigOCTQJJrhXWb9FyFMOp4LeEt+cPJuW0zuQ
         IQFSPu2+Y2Cx/UDRwxubo0B/IHMIyqv/CPOmpLmZNeVgzWM1MnlDoq6zFp3q1CNnU7q5
         ANgw==
X-Forwarded-Encrypted: i=1; AJvYcCWwX7shJ/iVf+i2D4HfzZkEkklXFwo4MH0ZKVKq6mFwKsFl20Tx6xxL9dCzZm5wiNqeRz+UOhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPi36clEps7lk15kMRzeTzGk35shN1LxF8IGGRbVpsIlr6ubZ/
	Kwr9sNFYSQ41w6gLT8W/Y29Xqsfg/nS5kHMT+LoH07yMR4nkhDn7/JrmCA1s4jxAT/AlMwCX158
	DassT8HyoRilAweJWkkupfa0Mom5cEgbeO0ii7SpP5w==
X-Gm-Gg: ASbGnctws5hqg4Gp4TmxkCTmZnQngUBeH9oH9YgP5ehG9I/OEmTBXE6fscr/dwf4b5V
	X24ntmMKwlK5viRZz99x0mzsugny8xQkJvf8G0vhRQx/2l6+ikgK5a2CuSBFOG1K8hCvBdv4dQA
	uNKks8jMT4s1cJ4laPtBXwjQKZ2nU6RAXKw7NbfvbyhOSPkMEPFVVPcfA+nqNvCsS4DQYIPJe7N
	I6Dqisy9sejTlaUbRGXANACLKMQ+9oP0MG5Gj/p6CXnE3Du8V/zvSm5vMEi6UGxgqGqMlQw0w==
X-Google-Smtp-Source: AGHT+IE1U9NMqfiTuQR2NWDZhwan6xsPMFs+3BLd+wmnsYIjPojl2ary5Q3gZ95UurBsW2namPVbgY6+Y+/T412qlR0=
X-Received: by 2002:a2e:80ca:0:b0:37b:9b28:4282 with SMTP id
 38308e7fff4ca-37cd9183db3mr6995251fa.11.1763743825913; Fri, 21 Nov 2025
 08:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
 <20251121060825.GR2912318@black.igk.intel.com>
In-Reply-To: <20251121060825.GR2912318@black.igk.intel.com>
From: Ian MacDonald <ian@netstatz.com>
Date: Fri, 21 Nov 2025 11:50:14 -0500
X-Gm-Features: AWmQ_bk4QDVbAx0NsBCk-cffKGGiRmDtYxhnl6UGbNr6Cy2VhTSh9uItPeyG_NU
Message-ID: <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
Subject: Re: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad bonding
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 1121032@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:08=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Okay "breaks" is probably too strong word here. It was never even support=
ed
> :)
Agreed, let's say the "magic fades".  I am guessing the same magic
that allows this 0x8086 component to appear out of thin air.
thunderbolt 0-2: new host found, vendor=3D0x8086 device=3D0x1
>
> Can you describe what are the actual commands you run so I can try to
> setup on my side and see how this could be implemented?

Sure, first the working variant for active-backup.

One side shown in netplan using a single yaml file (Ubuntu 24.04 server)

root@ai2:~# networkctl status bond0
=E2=97=8F 3: bond0
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: /run/systemd/network/10-netplan-bond0.network
                       State: routable (configured)
                Online state: online
                        Type: bond
                        Kind: bond
                      Driver: bonding
            Hardware Address: 02:92:d5:a7:f4:79
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: noqueue
IPv6 Address Generation Mode: eui64
                        Mode: active-backup
                      Miimon: 500ms
                     Updelay: 0
                   Downdelay: 0
    Number of Queues (Tx/Rx): 16/16
            Auto negotiation: no
                     Address: 10.10.13.2
                              fe80::92:d5ff:fea7:f479
           Activation Policy: up
         Required For Online: yes
           DHCP6 Client DUID: DUID-EN/Vendor:0000ab11ccb509966215f387

Nov 21 16:10:03 ai2 systemd-networkd[720]: bond0: netdev ready
Nov 21 16:10:03 ai2 systemd-networkd[720]: bond0: Configuring with
/run/systemd/network/10-netplan-bond0.network.
Nov 21 16:10:03 ai2 systemd-networkd[720]: bond0: Link UP
Nov 21 16:10:08 ai2 systemd-networkd[720]: bond0: Gained carrier
Nov 21 16:10:09 ai2 systemd-networkd[720]: bond0: Gained IPv6LL

root@ai2:~# cat /etc/netplan/60-bonded-init.yaml
network:
  version: 2
  renderer: networkd

  ethernets:
    thunderbolt0:
      dhcp4: false

    thunderbolt1:
      dhcp4: false

  bonds:
    bond0:
      interfaces: [thunderbolt0, thunderbolt1]
      dhcp4: false
      addresses: [10.10.13.2/30]
      parameters:
        mode: active-backup
        mii-monitor-interval: 500

The other side using a 3 file systemd-networkd variant (using on Debian 13)

ai4:/etc/systemd/network# networkctl status bond0
=E2=97=8F 3: bond0
                 NetDev File: /etc/systemd/network/50-bond0.netdev
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: /etc/systemd/network/53-bond0.network
                       State: routable (configured)
                Online state: online
                        Type: bond
                        Kind: bond
                      Driver: bonding
            Hardware Address: 02:0f:03:70:86:fb
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: noqueue
IPv6 Address Generation Mode: eui64
                        Mode: active-backup
                      Miimon: 500ms
                     Updelay: 0
                   Downdelay: 0
    Number of Queues (Tx/Rx): 16/16
            Auto negotiation: no
                     Address: 10.10.13.1
                              fe80::f:3ff:fe70:86fb
           Activation Policy: up
         Required For Online: yes
          DHCPv6 Client DUID: DUID-EN/Vendor:0000ab112f49d10231f668bf

Nov 21 11:21:55 ai4 systemd-networkd[700]: bond0: netdev ready
Nov 21 11:21:55 ai4 systemd-networkd[700]: bond0: Configuring with
/etc/systemd/network/53-bond0.network.
Nov 21 11:21:55 ai4 systemd-networkd[700]: bond0: Link UP
Nov 21 11:22:01 ai4 systemd-networkd[700]: bond0: Gained carrier
Nov 21 11:22:02 ai4 systemd-networkd[700]: bond0: Gained IPv6LL

ai4:/etc/systemd/network# cat 50-bond0.netdev
# /etc/systemd/network/50-bond0.netdev
[NetDev]
Name=3Dbond0
Kind=3Dbond

[Bond]
MIIMonitorSec=3D0.5s
Mode=3Dactive-backup
FailOverMACPolicy=3Dnone

ai4:/etc/systemd/network# cat 52-thunderbolt-bond0-slaves.network
# /etc/systemd/network/52-thunderbolt-bond0-slaves.network
[Match]
Name=3Dthunderbolt0 thunderbolt1

[Network]
Bond=3Dbond0

ai4:/etc/systemd/network# cat 53-bond0.network
# /etc/systemd/network/53-bond0.network
[Match]
Name=3Dbond0

[Network]
Address=3D10.10.13.1/30

Changing the mode to LACP/802.3ad then results in the observed mac
setting issues.

systemd-networkd/Debian Side:

ai4:/etc/systemd/network# cat 50-bond0.netdev
# /etc/systemd/network/50-bond0.netdev
[NetDev]
Name=3Dbond0
Kind=3Dbond

[Bond]
MIIMonitorSec=3D0.5s
Mode=3D802.3ad
TransmitHashPolicy=3Dlayer3+4

and the netplan/Ubuntu Side:

root@ai2:/etc/netplan# cat 60-bonded-init.yaml
network:
  version: 2
  renderer: networkd

  ethernets:
    thunderbolt0:
      dhcp4: false

    thunderbolt1:
      dhcp4: false

  bonds:
    bond0:
      interfaces: [thunderbolt0, thunderbolt1]
      dhcp4: false
      addresses: [10.10.13.2/30]
      parameters:
        mode: 802.3ad
        transmit-hash-policy: layer3+4
        mii-monitor-interval: 500

I typically reboot to apply the changes, to avoid some gaps in just
doing a netplan generate/apply or systemd-networkd restart, which do
not change the mode dynamically, as might be expected.

On Fri, Nov 21, 2025 at 3:11=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Okay since the MAC address is not really being used in the USB4NET protoc=
ol
> it should be fine to allow it to be changed.
>
> The below allows me to change it using "ip link set" command. I wonder if
> you could try it with the bonding case and see it that makes any
> difference?
>
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/mai=
n.c
> index dcaa62377808..57b226afeb84 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_ops=
 =3D {
>         .ndo_open =3D tbnet_open,
>         .ndo_stop =3D tbnet_stop,
>         .ndo_start_xmit =3D tbnet_start_xmit,
> +       .ndo_set_mac_address =3D eth_mac_addr,
>         .ndo_get_stats64 =3D tbnet_get_stats64,
>  };
>
> @@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device *d=
ev)
>         hash =3D jhash2((u32 *)xd->local_uuid, 4, hash);
>         addr[5] =3D hash & 0xff;
>         eth_hw_addr_set(dev, addr);
> +
> +       /* Allow changing it if needed */
> +       dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
>  }
>
>  static int tbnet_probe(struct tb_service *svc, const struct tb_service_i=
d *id)

Sure, I can give this a shot this weekend

