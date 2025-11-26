Return-Path: <netdev+bounces-241812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED5C88986
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06213A4127
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFD30E855;
	Wed, 26 Nov 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="afRam1oi"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890D2E5429;
	Wed, 26 Nov 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145008; cv=none; b=O1U7LckXAiWYMW8nDv6tOsa+rrMN2uZLRV8Hx5prGSm56ALPPfh5VkgiglKjwU/OjLpZhgqxfpTxsGRV/gdKHgVOfQocEFhiwbk98ZSaroizCNZN2mUCwjdvHbVYhxbzX2yESD6TQeNO2nIGsTIajHyJolhyhF95OvfN90gLE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145008; c=relaxed/simple;
	bh=nBYuu8mj0ALC1H9jDWA7gsnXXP84Q2XTGV0a/pFUTOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu+H7VMJQD4BV92UkwtuolZIH6xyTtJs7QC49HbeDRPN29djLVEg5fFs1UkwKds2zjztaMeoPEevI3C9tSC3Kp+qOJcMwqN+LGrgmGHZ42auk4s6Ncrpp1JXBMnOaqTH02bnOUyavNhLDIdm2DvZ21AxiiharZ6mWj/V5eUacEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=afRam1oi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=63dI+hYK9VK/o9qmWzGBdaZdG+IpnEG2hCQ5dItOrDg=; b=afRam1oig1D7dG8VqOnO7hSrIP
	Q3dTjCfvYnKlptp2ZjMG0O7Ppv+Pq618otBv6ZlL47cGnIF8e+qJcZz9AePdfZfUVN4BPkkz4NQK3
	h6V4vMfdTP1icWLSxk634ct7RVN8RWbM8bQoV4Hx4Mi7wydxD4G70xrLy8dBFw6A+SDyvmmCUmmSX
	4/Tmc49EYHBROly+5fTFtXe2u/zI0CEmJdXAB3qSzlHjaqvEaLPgC+UWkV/OUVEa8jqrG9bzVT0cH
	NwxPofVzFXb0c4B+LRFr4Bqe8MJs/91qWQYS9p0syZvvOiXjpvDzt4/KieY/9LncWczEklOZQqHXv
	c4wByXAw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1vOAhY-00440s-Vf; Wed, 26 Nov 2025 08:16:37 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 57E19BE2EE7; Wed, 26 Nov 2025 09:16:36 +0100 (CET)
Date: Wed, 26 Nov 2025 09:16:36 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ian MacDonald <ian@netstatz.com>, 1121032@bugs.debian.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug#1121032: net: thunderbolt: missing ndo_set_mac_address
 breaks 802.3ad bonding
Message-ID: <aSa3ZLvb_swDO5mQ@eldamar.lan>
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
 <20251121060825.GR2912318@black.igk.intel.com>
 <176358520689.2331.14787784716487189571.reportbug@ai4.netstatz.com>
 <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
X-Debian-User: carnil

Hi Ian,

On Fri, Nov 21, 2025 at 11:50:14AM -0500, Ian MacDonald wrote:
> On Fri, Nov 21, 2025 at 1:08 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Okay "breaks" is probably too strong word here. It was never even supported
> > :)
> Agreed, let's say the "magic fades".  I am guessing the same magic
> that allows this 0x8086 component to appear out of thin air.
> thunderbolt 0-2: new host found, vendor=0x8086 device=0x1
> >
> > Can you describe what are the actual commands you run so I can try to
> > setup on my side and see how this could be implemented?
> 
> Sure, first the working variant for active-backup.
> 
> One side shown in netplan using a single yaml file (Ubuntu 24.04 server)
> 
> root@ai2:~# networkctl status bond0
> ● 3: bond0
>                    Link File: /usr/lib/systemd/network/99-default.link
>                 Network File: /run/systemd/network/10-netplan-bond0.network
>                        State: routable (configured)
>                 Online state: online
>                         Type: bond
>                         Kind: bond
>                       Driver: bonding
>             Hardware Address: 02:92:d5:a7:f4:79
>                          MTU: 1500 (min: 68, max: 65535)
>                        QDisc: noqueue
> IPv6 Address Generation Mode: eui64
>                         Mode: active-backup
>                       Miimon: 500ms
>                      Updelay: 0
>                    Downdelay: 0
>     Number of Queues (Tx/Rx): 16/16
>             Auto negotiation: no
>                      Address: 10.10.13.2
>                               fe80::92:d5ff:fea7:f479
>            Activation Policy: up
>          Required For Online: yes
>            DHCP6 Client DUID: DUID-EN/Vendor:0000ab11ccb509966215f387
> 
> Nov 21 16:10:03 ai2 systemd-networkd[720]: bond0: netdev ready
> Nov 21 16:10:03 ai2 systemd-networkd[720]: bond0: Configuring with
> /run/systemd/network/10-netplan-bond0.network.
> Nov 21 16:10:03 ai2 systemd-networkd[720]: bond0: Link UP
> Nov 21 16:10:08 ai2 systemd-networkd[720]: bond0: Gained carrier
> Nov 21 16:10:09 ai2 systemd-networkd[720]: bond0: Gained IPv6LL
> 
> root@ai2:~# cat /etc/netplan/60-bonded-init.yaml
> network:
>   version: 2
>   renderer: networkd
> 
>   ethernets:
>     thunderbolt0:
>       dhcp4: false
> 
>     thunderbolt1:
>       dhcp4: false
> 
>   bonds:
>     bond0:
>       interfaces: [thunderbolt0, thunderbolt1]
>       dhcp4: false
>       addresses: [10.10.13.2/30]
>       parameters:
>         mode: active-backup
>         mii-monitor-interval: 500
> 
> The other side using a 3 file systemd-networkd variant (using on Debian 13)
> 
> ai4:/etc/systemd/network# networkctl status bond0
> ● 3: bond0
>                  NetDev File: /etc/systemd/network/50-bond0.netdev
>                    Link File: /usr/lib/systemd/network/99-default.link
>                 Network File: /etc/systemd/network/53-bond0.network
>                        State: routable (configured)
>                 Online state: online
>                         Type: bond
>                         Kind: bond
>                       Driver: bonding
>             Hardware Address: 02:0f:03:70:86:fb
>                          MTU: 1500 (min: 68, max: 65535)
>                        QDisc: noqueue
> IPv6 Address Generation Mode: eui64
>                         Mode: active-backup
>                       Miimon: 500ms
>                      Updelay: 0
>                    Downdelay: 0
>     Number of Queues (Tx/Rx): 16/16
>             Auto negotiation: no
>                      Address: 10.10.13.1
>                               fe80::f:3ff:fe70:86fb
>            Activation Policy: up
>          Required For Online: yes
>           DHCPv6 Client DUID: DUID-EN/Vendor:0000ab112f49d10231f668bf
> 
> Nov 21 11:21:55 ai4 systemd-networkd[700]: bond0: netdev ready
> Nov 21 11:21:55 ai4 systemd-networkd[700]: bond0: Configuring with
> /etc/systemd/network/53-bond0.network.
> Nov 21 11:21:55 ai4 systemd-networkd[700]: bond0: Link UP
> Nov 21 11:22:01 ai4 systemd-networkd[700]: bond0: Gained carrier
> Nov 21 11:22:02 ai4 systemd-networkd[700]: bond0: Gained IPv6LL
> 
> ai4:/etc/systemd/network# cat 50-bond0.netdev
> # /etc/systemd/network/50-bond0.netdev
> [NetDev]
> Name=bond0
> Kind=bond
> 
> [Bond]
> MIIMonitorSec=0.5s
> Mode=active-backup
> FailOverMACPolicy=none
> 
> ai4:/etc/systemd/network# cat 52-thunderbolt-bond0-slaves.network
> # /etc/systemd/network/52-thunderbolt-bond0-slaves.network
> [Match]
> Name=thunderbolt0 thunderbolt1
> 
> [Network]
> Bond=bond0
> 
> ai4:/etc/systemd/network# cat 53-bond0.network
> # /etc/systemd/network/53-bond0.network
> [Match]
> Name=bond0
> 
> [Network]
> Address=10.10.13.1/30
> 
> Changing the mode to LACP/802.3ad then results in the observed mac
> setting issues.
> 
> systemd-networkd/Debian Side:
> 
> ai4:/etc/systemd/network# cat 50-bond0.netdev
> # /etc/systemd/network/50-bond0.netdev
> [NetDev]
> Name=bond0
> Kind=bond
> 
> [Bond]
> MIIMonitorSec=0.5s
> Mode=802.3ad
> TransmitHashPolicy=layer3+4
> 
> and the netplan/Ubuntu Side:
> 
> root@ai2:/etc/netplan# cat 60-bonded-init.yaml
> network:
>   version: 2
>   renderer: networkd
> 
>   ethernets:
>     thunderbolt0:
>       dhcp4: false
> 
>     thunderbolt1:
>       dhcp4: false
> 
>   bonds:
>     bond0:
>       interfaces: [thunderbolt0, thunderbolt1]
>       dhcp4: false
>       addresses: [10.10.13.2/30]
>       parameters:
>         mode: 802.3ad
>         transmit-hash-policy: layer3+4
>         mii-monitor-interval: 500
> 
> I typically reboot to apply the changes, to avoid some gaps in just
> doing a netplan generate/apply or systemd-networkd restart, which do
> not change the mode dynamically, as might be expected.
> 
> On Fri, Nov 21, 2025 at 3:11 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Okay since the MAC address is not really being used in the USB4NET protocol
> > it should be fine to allow it to be changed.
> >
> > The below allows me to change it using "ip link set" command. I wonder if
> > you could try it with the bonding case and see it that makes any
> > difference?
> >
> > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > index dcaa62377808..57b226afeb84 100644
> > --- a/drivers/net/thunderbolt/main.c
> > +++ b/drivers/net/thunderbolt/main.c
> > @@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_ops = {
> >         .ndo_open = tbnet_open,
> >         .ndo_stop = tbnet_stop,
> >         .ndo_start_xmit = tbnet_start_xmit,
> > +       .ndo_set_mac_address = eth_mac_addr,
> >         .ndo_get_stats64 = tbnet_get_stats64,
> >  };
> >
> > @@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device *dev)
> >         hash = jhash2((u32 *)xd->local_uuid, 4, hash);
> >         addr[5] = hash & 0xff;
> >         eth_hw_addr_set(dev, addr);
> > +
> > +       /* Allow changing it if needed */
> > +       dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> >  }
> >
> >  static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
> 
> Sure, I can give this a shot this weekend

Where you able to test the proposed change?

Regards,
Salvatore

