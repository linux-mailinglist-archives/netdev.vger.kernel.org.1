Return-Path: <netdev+bounces-202772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EFAEEF36
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304E17AEF88
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00971B0435;
	Tue,  1 Jul 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="E+QCFwdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2662BCFB
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352514; cv=none; b=TTkTKuFPll9Ob1BkTD0MEEVhxs19yFlZbJ6Izzi0CFRGPvHKL9OBtWTf+Z/Ct1+d9KaWHVAh4v5H9ZAJdzo5FpGNa5NZC+KJtVqtA+GvcPAFXrjeB59gsJowHAEgMCoxKLUR1dOkSFSpvFx5rb9zwrCK4VAnnhsRmL494pKsJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352514; c=relaxed/simple;
	bh=j3eMKfYHSCMGzJkr9IZ8a5L7Kf27fpo85gC69JgUINk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEvQGVofafSG2SPNuZBcH/1Vy468iKN0LN/2w6m6g60unRBxAcvEPTPpXopKgCjddTwCElw3GxHK1je2aAxwteiO/0I7KeVcQKIT7hUSfMBA0hg5hfU/nHHe87IdWnL8ydOrUXdMUgzoxc9FgOVSf13KmTvj9bDmHO4NHBQ12+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=E+QCFwdj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso10675037a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1751352511; x=1751957311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIZLjW1XMx+pKp+NrR7RPp6IM9NoOEGeAb13fitOSPM=;
        b=E+QCFwdjX9c1MrdUUxW0FNSmDiNq4fjvKoHtJYT11R5bvASf5nrulzsBnHuu688NO8
         ghKB7vii+2YyV5VsB1HYyBdZScdsb3Bo2ZiuvJnRcHCb4HIg22Z9+r3i+26hQhtKSRFM
         46Zo/1Hqu5Tl3sgz43MsqWkEpZK4YFFnNq+B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751352511; x=1751957311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIZLjW1XMx+pKp+NrR7RPp6IM9NoOEGeAb13fitOSPM=;
        b=GTZrv9TBpSDU+112Vvqt5uef/RYOyToQ0bgRTRr7DwYX8Px36P9IAC1yWRKIfwNrcx
         GMlC4RAV4kXoY2/zO8bgwo/UhwRrOvAgZwsmp8OCTTZz3Wbz4PQZ3E/jKX7hAjG6CwXg
         PsiZ8CGbtM72fg7H9ASCEWyHVPq93vuUJNZolmDhjKIaCPaeW5UPh8TvQLPSiRHO26gx
         mc0MHFzyrXF/Zvmt8pL1FUXf/UYseyYuRR7Vll4lLvwgbnv8F+sJhl9pxGcGwdvsNOtN
         ZvyMSmQ8YWrjpEbEooAh6nKpedEj4DWIvDMnh+DAC7+yMR3xD1Af9ESgO02Q7ZrlTI3x
         aPRA==
X-Forwarded-Encrypted: i=1; AJvYcCWnFB/InysOIW+v3zrpc8+ssDGa4G3MNlQMXgLYsEzSUtm551816CA5neJPKYA7Fr9xwwDMzhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMNeBAHMnRLu+oJet2fxCMS/ahPWWHxYrOb2kIgk/SJpSZ0Ja
	SWahyX23noarY4M3dsZNbi1F2pua7qo0ZsXv19paCcSytFUR2coWUTEyFI+7Cr/N7yY1NgA99xn
	N6rbJhBF5fWoIcrhAy4aQEmqBlZMwbEiL5s2KDV+4
X-Gm-Gg: ASbGncuNYo0PunKflUISWjtNxEee1dJkkgWRIRNqtuGYDXJSU94abIYVLRrmAgbDLo4
	M8l931Sdmkg/3yLmPThNPkyF48iOv8CM2s5YLbT608FDDDeb4qwKxJAJYq/1Hhwb8Wotf4auwy1
	bubJh2437Co2PDaYafouykPa47a3bCWv3zF2Y8KaAGzGdb
X-Google-Smtp-Source: AGHT+IF+OqcSSD3Nw9Hf49glIxKVsNYDBRhFFcGncL9jkkz2Cy6zyPDjRDtP3Xu7JHrOpO01kiGeSUAGPL+gTKkvBwo=
X-Received: by 2002:a17:906:478b:b0:ad5:78ca:2126 with SMTP id
 a640c23a62f3a-ae3501f7b1amr1639667266b.59.1751352510723; Mon, 30 Jun 2025
 23:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <20250416171311.30b76ec1@kernel.org> <CO1PR11MB508931FBA3D5DFE7D8F07844D6BC2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <CAK8fFZ6+BNjNdemB+P=SuwU6X9a9CmtkR8Nux-XG7QHdcswvQQ@mail.gmail.com>
 <CAK8fFZ4BJ-T40eNzO1rDLLpSRkeaHGctATsGLKD3bqVCa4RFEQ@mail.gmail.com>
 <CAK8fFZ5XTO9dGADuMSV0hJws-6cZE9equa3X6dfTBgDyzE1pEQ@mail.gmail.com>
 <b3eb99da-9293-43e8-a24d-f4082f747d6c@intel.com> <CAK8fFZ7LREBEdhXjBAKuaqktOz1VwsBTxcCpLBsa+dkMj4Pyyw@mail.gmail.com>
 <20250625132545.1772c6ab@kernel.org> <CAK8fFZ7KDaPk_FVDbTdFt8soEWrpJ_g0_fiKEg1WzjRp1BC0Qg@mail.gmail.com>
 <CAK8fFZ5rS8Xg11LvyQHzFh3aVHbKdRHpuhrpV_Wc7oYRcMZFRA@mail.gmail.com>
 <c764ad97-9c6a-46f5-a03b-cfa812cdb8e1@intel.com> <CAK8fFZ4bRJz2WnhoYdG8PVYi6=EKYTXBE5tu8pR4=CQoifqUuA@mail.gmail.com>
 <f2e43212-dc49-4f87-9bbc-53a77f3523e5@intel.com> <CAK8fFZ6FU1+1__FndEoFQgHqSXN+330qvNTWMvMfiXc2DpN8NQ@mail.gmail.com>
 <08fae312-2e3e-4622-94ab-7960accc8008@intel.com> <366dbe9f-af4d-48ec-879e-1ac54cd5f3b6@intel.com>
In-Reply-To: <366dbe9f-af4d-48ec-879e-1ac54cd5f3b6@intel.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Tue, 1 Jul 2025 08:48:04 +0200
X-Gm-Features: Ac12FXx8i-r4XL6AH8JArrtqr3FiBrKnCdYFS637S081l7EBmmk9YeriRAMYxaI
Message-ID: <CAK8fFZ6PPw1nshtSp+QZ_2VVWVrsCKZDdsxdPF9Tjc0=_gi=Wg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Damato, Joe" <jdamato@fastly.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Dumazet, Eric" <edumazet@google.com>, 
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 6/30/2025 2:56 PM, Jacob Keller wrote:
> > Unfortunately it looks like the fix I mentioned has landed in 6.14, so
> > its not a fix for your issue (since you mentioned 6.14 has failed
> > testing in your system)
> >
> > $ git describe --first-parent --contains --match=3Dv* --exclude=3D*rc*
> > 743bbd93cf29f653fae0e1416a31f03231689911
> > v6.14~251^2~15^2~2
> >
> > I don't see any other relevant changes since v6.14. I can try to see if
> > I see similar issues with CONFIG_MEM_ALLOC_PROFILING on some test
> > systems here.
>
> On my system I see this at boot after loading the ice module from
>
> $ grep -F "/ice/" /proc/allocinfo | sort -g | tail | numfmt --to=3Diec>
>       26K      230 drivers/net/ethernet/intel/ice/ice_irq.c:84 [ice]
> func:ice_get_irq_res
> >          48K        2 drivers/net/ethernet/intel/ice/ice_arfs.c:565 [ic=
e] func:ice_init_arfs
> >          57K      226 drivers/net/ethernet/intel/ice/ice_lib.c:397 [ice=
] func:ice_vsi_alloc_ring_stats
> >          57K      226 drivers/net/ethernet/intel/ice/ice_lib.c:416 [ice=
] func:ice_vsi_alloc_ring_stats
> >          85K      226 drivers/net/ethernet/intel/ice/ice_lib.c:1398 [ic=
e] func:ice_vsi_alloc_rings
> >         339K      226 drivers/net/ethernet/intel/ice/ice_lib.c:1422 [ic=
e] func:ice_vsi_alloc_rings
> >         678K      226 drivers/net/ethernet/intel/ice/ice_base.c:109 [ic=
e] func:ice_vsi_alloc_q_vector
> >         1.1M      257 drivers/net/ethernet/intel/ice/ice_fwlog.c:40 [ic=
e] func:ice_fwlog_alloc_ring_buffs
> >         7.2M      114 drivers/net/ethernet/intel/ice/ice_txrx.c:493 [ic=
e] func:ice_setup_rx_ring
> >         896M   229264 drivers/net/ethernet/intel/ice/ice_txrx.c:680 [ic=
e] func:ice_alloc_mapped_page
>
> Its about 1GB for the mapped pages. I don't see any increase moment to
> moment. I've started an iperf session to simulate some traffic, and I'll
> leave this running to see if anything changes overnight.
>
> Is there anything else that you can share about the traffic setup or
> otherwise that I could look into?  Your system seems to use ~2.5 x the
> buffer size as mine, but that might just be a smaller number of CPUs.
>
> Hopefully I'll get some more results overnight.

The traffic is random production workloads from VMs, using standard
Linux or OVS bridges. There is no specific pattern to it. I haven=E2=80=99t
had any luck reproducing (or was not patient enough) this with iperf3
myself. The two active (UP) interfaces are in an LACP bonding setup.
Here are our ethtool settings for the two member ports (em1 and p3p1)

# ethtool -l em1
Channel parameters for em1:
Pre-set maximums:
RX: 64
TX: 64
Other: 1
Combined: 64
Current hardware settings:
RX: 0
TX: 0
Other: 1
Combined: 8

# ethtool -g em1
Ring parameters for em1:
Pre-set maximums:
RX: 8160
RX Mini: n/a
RX Jumbo: n/a
TX: 8160
TX push buff len: n/a
Current hardware settings:
RX: 8160
RX Mini: n/a
RX Jumbo: n/a
TX: 8160
RX Buf Len: n/a
CQE Size: n/a
TX Push: off
RX Push: off
TX push buff len: n/a
TCP data split: n/a

# ethtool -c em1
Coalesce parameters for em1:
Adaptive RX: off  TX: off
stats-block-usecs: n/a
sample-interval: n/a
pkt-rate-low: n/a
pkt-rate-high: n/a

rx-usecs: 12
rx-frames: n/a
rx-usecs-irq: n/a
rx-frames-irq: n/a

tx-usecs: 28
tx-frames: n/a
tx-usecs-irq: n/a
tx-frames-irq: n/a

rx-usecs-low: n/a
rx-frame-low: n/a
tx-usecs-low: n/a
tx-frame-low: n/a

rx-usecs-high: 0
rx-frame-high: n/a
tx-usecs-high: n/a
tx-frame-high: n/a

CQE mode RX: n/a  TX: n/a

tx-aggr-max-bytes: n/a
tx-aggr-max-frames: n/a
tx-aggr-time-usecs: n/a

# ethtool -k em1
Features for em1:
rx-checksumming: on
tx-checksumming: on
tx-checksum-ipv4: on
tx-checksum-ip-generic: off [fixed]
tx-checksum-ipv6: on
tx-checksum-fcoe-crc: off [fixed]
tx-checksum-sctp: on
scatter-gather: on
tx-scatter-gather: on
tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
tx-tcp-segmentation: on
tx-tcp-ecn-segmentation: on
tx-tcp-mangleid-segmentation: off
tx-tcp6-segmentation: on
tx-tcp-accecn-segmentation: off [fixed]
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed]
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: on
receive-hashing: on
highdma: on
rx-vlan-filter: on
vlan-challenged: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: on
tx-gre-csum-segmentation: on
tx-ipxip4-segmentation: on
tx-ipxip6-segmentation: on
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on
tx-gso-partial: on
tx-tunnel-remcsum-segmentation: off [fixed]
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
tx-udp-segmentation: on
tx-gso-list: off [fixed]
tx-nocache-copy: off
loopback: off
rx-fcs: off
rx-all: off [fixed]
tx-vlan-stag-hw-insert: off
rx-vlan-stag-hw-parse: off
rx-vlan-stag-filter: on
l2-fwd-offload: off [fixed]
hw-tc-offload: off
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: on
tls-hw-tx-offload: off [fixed]
tls-hw-rx-offload: off [fixed]
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
rx-gro-list: off
macsec-hw-offload: off [fixed]
rx-udp-gro-forwarding: off
hsr-tag-ins-offload: off [fixed]
hsr-tag-rm-offload: off [fixed]
hsr-fwd-offload: off [fixed]
hsr-dup-offload: off [fixed]

# ethtool -i em1
driver: ice
version: 6.15.3-3.gdc.el9.x86_64
firmware-version: 4.51 0x8001e501 23.0.8
expansion-rom-version:
bus-info: 0000:63:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

# ethtool em1
Settings for em1:
Supported ports: [ FIBRE ]
Supported link modes:   1000baseT/Full
                25000baseCR/Full
                25000baseSR/Full
                1000baseX/Full
                10000baseCR/Full
                10000baseSR/Full
                10000baseLR/Full
Supported pause frame use: Symmetric
Supports auto-negotiation: Yes
Supported FEC modes: None RS BASER
Advertised link modes:  25000baseCR/Full
                10000baseCR/Full
Advertised pause frame use: No
Advertised auto-negotiation: Yes
Advertised FEC modes: None RS BASER
Speed: 25000Mb/s
Duplex: Full
Auto-negotiation: off
Port: Direct Attach Copper
PHYAD: 0
Transceiver: internal
Supports Wake-on: g
Wake-on: d
Current message level: 0x00000007 (7)
                       drv probe link
Link detected: yes


>
> Thanks,
> Jake

