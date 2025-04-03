Return-Path: <netdev+bounces-179193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B456A7B1A6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2059716619D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C2171E49;
	Thu,  3 Apr 2025 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEU98b8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7513B58A;
	Thu,  3 Apr 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716973; cv=none; b=ni8bV3IK66PTznDHG9f87gOOJVltNSCt/uDVrmI4UsYyr+ZTwjDl1Oqu8jELAUkSuQ+gGuNf3cejb352v1oWzRb7HIUF3n6BxaYekM5gtfFtYL3ZNuB6Zyj3QDu39EZ8ekp5U7lxmWx94/9c3uauHn8ZRXV/0knE2KAGBk1oIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716973; c=relaxed/simple;
	bh=u7AQGhdP8wwu5y0NXxgS3JBSSjiIqpyA3oFwxYn53tU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OMxziRYRlehGxRhGOzh+cE9A0qzjUvmSMvQTyil6yVSg9oFg/Zzq8aIVqSLGN3avxxkn7ijOBmFJO/l+jCAv3TnpGiWWPC1qqYqB2g4Va7nlNwosKIYX07KZSO9sM4NMcQDe1AcTj3g4NFIC3YGve7iGsWeOP1WH730DX9LyCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEU98b8R; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c08fc20194so251466685a.2;
        Thu, 03 Apr 2025 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743716970; x=1744321770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwdCiSeO1xvvNjIyf9l/dZZzNmp3/0c+LarNj3baQlI=;
        b=HEU98b8R5Z3xoeQrxSKSED4aFEvhmQ7x5/qVJgkNMlH33EymlEa+4VMKGONCwnoStJ
         CnKfCIAGNcsPE9/XF0x7pUaOUNGuXifscXcJaL6TyT3mEWJbgOjUTTY3y9hLkE4OBN2S
         kR0o4/c/0kOjtUBGK7vbAHUSC6DdFk4cDPXh+lsKOoekQ0wVxksSV6wR/R4Mz0hy5o18
         VoCJg7WTAF1CrIaPx4J89HLLSUz+Cy3CrjQvHNfbZN+m/VNFxZC0KhJXX+ioAPsJHLFG
         Cb73BjKKWHMoxEzM8pIMRGvvIwdlT5IeEBaSSOOmUtwEWwWWE5MuJwjPQpDGQPpkZ5+i
         192w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716970; x=1744321770;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwdCiSeO1xvvNjIyf9l/dZZzNmp3/0c+LarNj3baQlI=;
        b=A/SfLVtHdM0zlGsKPW+55KgfixzPtqhQFDZz/+2RCDAMwKu82Z814wHfcz0bSBCU0R
         7oPdOHmGNjwazlmaYAHV0xW67GLzoOjUtKYMQ9NL3kbPZk8K22QJUMkTbsgzBPEG52vk
         iT2UbtqFPVyDj4e/irxtkzddFs0DOIJXWb2NZsH1/PPdhDkUtZ4a1+p4+xsVdBqzN5wG
         W83ewpzD78e5mqapqE2SwlHbMnVcH1Uoxe9qD6ZL6BEn1yDk0WCdUIHRn5ZAIHU2p8uM
         N6HkFNip1o6izPyjPjZmkhnTMWIev5pE0BTHEdbK6U79lJEtoiVePxBbxUwTfPkor96d
         i5tA==
X-Forwarded-Encrypted: i=1; AJvYcCUjvnQFxLUxDnorr0oiO9tiiDgg67UKi/Vmql6J5DSXtV1j0HhSRGrTAlQN7o2+JoaRBxPz8T93nZ1x5uI=@vger.kernel.org, AJvYcCVRknVtZLvWrQ4KJCJIJzabhknNynkOL4MqeUlHkFaUS7HRvltmf8v7m1Mg6Yyb0FP5X07bK+ep@vger.kernel.org
X-Gm-Message-State: AOJu0YybrKsW39d1hqj2ulFvU0G9ZVtZF0OzlG6rrhIobMIixxcpQzSW
	ZvYbl4zpoca9OQKxWI/FDlyLz8q5HUMeih/wDhT4+LCEwpOSfHgZ
X-Gm-Gg: ASbGnctwLI71XiLFIH+yYITv4/YT6czHxyWJTtte3fnUPY7/LrnciPzEe4iEVM/n0x3
	3x7RUfHQ+WmaNti3I1mn0g+Zbs5KPGUeHv/+HT/J7C8iKFnyuSIXDOAFApRGKIRMgGMTy493/2O
	VdbkCt1rzvhxGDZmCXfOoe/KKI6noyZwILoZbRUTRPuHs2tq7tpdDV966EJPgHerDRIpH0pLr6w
	2GeQTVsCsOsT9CONociXylOYPH/U04bLYlrJY7h3/iPGnou5UQsd/Esvjiau21I+zjojPZ8zPCF
	vA/gAl0jeRIXR49vvoxm5u7HXIVU0SgxmOS762OTSKvjpyioraCBz+IN+ZC85sp9Fqjn9xKm+Ud
	f8JiHTWeH2z/baXCN6aODsQ==
X-Google-Smtp-Source: AGHT+IHo4zz+oMWNU7UOvj13ffKg6+LGTPlqhUZ5WCoh5aBtOqBUTsBBgu72O02X7eBPrMvptYzYoA==
X-Received: by 2002:a05:620a:19a0:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c774df7822mr127042885a.48.1743716970342;
        Thu, 03 Apr 2025 14:49:30 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b121decsm12556091cf.62.2025.04.03.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:49:29 -0700 (PDT)
Date: Thu, 03 Apr 2025 17:49:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Markus Fohrer <markus.fohrer@webked.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <67ef02693c647_16fa6c294c4@willemb.c.googlers.com.notmuch>
In-Reply-To: <fa9aec4d5d5148cff37a17d076b90ab835b8c7ef.camel@webked.de>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
 <20250403100206-mutt-send-email-mst@kernel.org>
 <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>
 <20250403170543-mutt-send-email-mst@kernel.org>
 <fa9aec4d5d5148cff37a17d076b90ab835b8c7ef.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus Fohrer wrote:
> Am Donnerstag, dem 03.04.2025 um 17:06 -0400 schrieb Michael S.
> Tsirkin:
> > On Thu, Apr 03, 2025 at 10:07:12PM +0200, Markus Fohrer wrote:
> > > Am Donnerstag, dem 03.04.2025 um 10:03 -0400 schrieb Michael S.
> > > Tsirkin:
> > > > On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.=

> > > > > Tsirkin:
> > > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer
> > > > > > wrote:
> > > > > > > Hi,
> > > > > > > =

> > > > > > > I'm observing a significant performance regression in KVM
> > > > > > > guest
> > > > > > > VMs
> > > > > > > using virtio-net with recent Linux kernels (6.8.1+ and
> > > > > > > 6.14).
> > > > > > > =

> > > > > > > When running on a host system equipped with a Broadcom
> > > > > > > NetXtreme-E
> > > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > > > the
> > > > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configu=
ration
> > > > > > > performs
> > > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM=

> > > > > > > is
> > > > > > > moved to a host with Intel NICs.
> > > > > > > =

> > > > > > > Test environment:
> > > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > > - Guest: Linux with virtio-net interface
> > > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host=

> > > > > > > level)
> > > > > > > - CPU: AMD EPYC
> > > > > > > - Storage: virtio-scsi
> > > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > > bottlenecks)
> > > > > > > - Traffic test: iperf3, scp, wget consistently slow in
> > > > > > > guest
> > > > > > > =

> > > > > > > This issue is not present:
> > > > > > > - On 6.8.0 =

> > > > > > > - On hosts with Intel NICs (same VM config)
> > > > > > > =

> > > > > > > I have bisected the issue to the following upstream commit:=

> > > > > > > =

> > > > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warni=
ng
> > > > > > > for
> > > > > > > small
> > > > > > > tx")
> > > > > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > > > > =

> > > > > > Thanks a lot for the info!
> > > > > > =

> > > > > > =

> > > > > > both the link and commit point at:
> > > > > > =

> > > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > > > =

> > > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > > virtio_net_hdr_to_skb()
> > > > > > =C2=A0=C2=A0=C2=A0 =

> > > > > > =

> > > > > > is this what you mean?
> > > > > > =

> > > > > > I don't know which commit is "virtio-net: Suppress tx timeout=

> > > > > > warning
> > > > > > for small tx"
> > > > > > =

> > > > > > =

> > > > > > =

> > > > > > > Reverting this commit restores normal network performance
> > > > > > > in
> > > > > > > affected guest VMs.
> > > > > > > =

> > > > > > > I=E2=80=99m happy to provide more data or assist with testi=
ng a
> > > > > > > potential
> > > > > > > fix.
> > > > > > > =

> > > > > > > Thanks,
> > > > > > > Markus Fohrer
> > > > > > =

> > > > > > =

> > > > > > Thanks! First I think it's worth checking what is the setup,
> > > > > > e.g.
> > > > > > which offloads are enabled.
> > > > > > Besides that, I'd start by seeing what's doing on. Assuming
> > > > > > I'm
> > > > > > right
> > > > > > about
> > > > > > Eric's patch:
> > > > > > =

> > > > > > diff --git a/include/linux/virtio_net.h
> > > > > > b/include/linux/virtio_net.h
> > > > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > > > --- a/include/linux/virtio_net.h
> > > > > > +++ b/include/linux/virtio_net.h
> > > > > > @@ -103,8 +103,10 @@ static inline int
> > > > > > virtio_net_hdr_to_skb(struct
> > > > > > sk_buff *skb,
> > > > > > =C2=A0
> > > > > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > > > > =C2=A0			return -EINVAL;
> > > > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > > > +			return -EINVAL;
> > > > > > =C2=A0
> > > > > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > > > > skb_transport_offset(skb));
> > > > > > +		nh_min_len =3D skb_transport_offset(skb);
> > > > > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > > > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > > > > =C2=A0			return -EINVAL;
> > > > > > =

> > > > > > =

> > > > > > sticking a printk before return -EINVAL to show the offset
> > > > > > and
> > > > > > nh_min_len
> > > > > > would be a good 1st step. Thanks!
> > > > > > =

> > > > > =

> > > > > =

> > > > > Hi Eric,
> > > > > =

> > > > > thanks a lot for the quick response =E2=80=94 and yes, you're
> > > > > absolutely
> > > > > right.
> > > > > =

> > > > > Apologies for the confusion: I mistakenly wrote the wrong
> > > > > commit
> > > > > description in my initial mail.
> > > > > =

> > > > > The correct commit is indeed:
> > > > > =

> > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > > =

> > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > virtio_net_hdr_to_skb()
> > > > > =

> > > > > This is the one I bisected and which causes the performance
> > > > > regression
> > > > > in my environment.
> > > > > =

> > > > > Thanks again,
> > > > > Markus
> > > > =

> > > > =

> > > > I'm not Eric but good to know.
> > > > Alright, so I would start with the two items: device features and=

> > > > printk.
> > > > =

> > > =

> > > as requested, here=E2=80=99s the device/feature information from th=
e guest
> > > running kernel 6.14 (mainline):
> > > =

> > > Interface: ens18
> > > =

> > > ethtool -i ens18:
> > > driver: virtio_net
> > > version: 1.0.0
> > > firmware-version: =

> > > expansion-rom-version: =

> > > bus-info: 0000:00:12.0
> > > supports-statistics: yes
> > > supports-test: no
> > > supports-eeprom-access: no
> > > supports-register-dump: no
> > > supports-priv-flags: no
> > > =

> > > =

> > > ethtool -k ens18:
> > > Features for ens18:
> > > rx-checksumming: on [fixed]
> > > tx-checksumming: on
> > > 	tx-checksum-ipv4: off [fixed]
> > > 	tx-checksum-ip-generic: on
> > > 	tx-checksum-ipv6: off [fixed]
> > > 	tx-checksum-fcoe-crc: off [fixed]
> > > 	tx-checksum-sctp: off [fixed]
> > > scatter-gather: on
> > > 	tx-scatter-gather: on
> > > 	tx-scatter-gather-fraglist: off [fixed]
> > > tcp-segmentation-offload: on
> > > 	tx-tcp-segmentation: on
> > > 	tx-tcp-ecn-segmentation: on
> > > 	tx-tcp-mangleid-segmentation: off
> > > 	tx-tcp6-segmentation: on
> > > generic-segmentation-offload: on
> > > generic-receive-offload: on
> > > large-receive-offload: off [fixed]
> > > rx-vlan-offload: off [fixed]
> > > tx-vlan-offload: off [fixed]
> > > ntuple-filters: off [fixed]
> > > receive-hashing: off [fixed]
> > > highdma: on [fixed]
> > > rx-vlan-filter: on [fixed]
> > > vlan-challenged: off [fixed]
> > > tx-gso-robust: on [fixed]
> > > tx-fcoe-segmentation: off [fixed]
> > > tx-gre-segmentation: off [fixed]
> > > tx-gre-csum-segmentation: off [fixed]
> > > tx-ipxip4-segmentation: off [fixed]
> > > tx-ipxip6-segmentation: off [fixed]
> > > tx-udp_tnl-segmentation: off [fixed]
> > > tx-udp_tnl-csum-segmentation: off [fixed]
> > > tx-gso-partial: off [fixed]
> > > tx-tunnel-remcsum-segmentation: off [fixed]
> > > tx-sctp-segmentation: off [fixed]
> > > tx-esp-segmentation: off [fixed]
> > > tx-udp-segmentation: off
> > > tx-gso-list: off [fixed]
> > > tx-nocache-copy: off
> > > loopback: off [fixed]
> > > rx-fcs: off [fixed]
> > > rx-all: off [fixed]
> > > tx-vlan-stag-hw-insert: off [fixed]
> > > rx-vlan-stag-hw-parse: off [fixed]
> > > rx-vlan-stag-filter: off [fixed]
> > > l2-fwd-offload: off [fixed]
> > > hw-tc-offload: off [fixed]
> > > esp-hw-offload: off [fixed]
> > > esp-tx-csum-hw-offload: off [fixed]
> > > rx-udp_tunnel-port-offload: off [fixed]
> > > tls-hw-tx-offload: off [fixed]
> > > tls-hw-rx-offload: off [fixed]
> > > rx-gro-hw: on
> > > tls-hw-record: off [fixed]
> > > rx-gro-list: off
> > > macsec-hw-offload: off [fixed]
> > > rx-udp-gro-forwarding: off
> > > hsr-tag-ins-offload: off [fixed]
> > > hsr-tag-rm-offload: off [fixed]
> > > hsr-fwd-offload: off [fixed]
> > > hsr-dup-offload: off [fixed]
> > > =

> > > ethtool ens18:
> > > Settings for ens18:
> > > 	Supported ports: [=C2=A0 ]
> > > 	Supported link modes:=C2=A0=C2=A0 Not reported
> > > 	Supported pause frame use: No
> > > 	Supports auto-negotiation: No
> > > 	Supported FEC modes: Not reported
> > > 	Advertised link modes:=C2=A0 Not reported
> > > 	Advertised pause frame use: No
> > > 	Advertised auto-negotiation: No
> > > 	Advertised FEC modes: Not reported
> > > 	Speed: Unknown!
> > > 	Duplex: Unknown! (255)
> > > 	Auto-negotiation: off
> > > 	Port: Other
> > > 	PHYAD: 0
> > > 	Transceiver: internal
> > > netlink error: Operation not permitted
> > > 	Link detected: yes
> > > =

> > > =

> > > Kernel log (journalctl -k):
> > > Apr 03 19:50:37 kb-test.allod.com kernel: virtio_scsi virtio2:
> > > 4/0/0
> > > default/read/poll queues=C2=A0 =

> > > Apr 03 19:50:37 kb-test.allod.com kernel: virtio_net virtio1 ens18:=

> > > renamed from eth0
> > > =

> > > Let me know if you=E2=80=99d like comparison data from kernel 6.11 =
or any
> > > additional tests
> > =

> > =

> > I think let's redo bisect first then I will suggest which traces to
> > add.
> > =

> =

> The build with the added printk is currently running. I=E2=80=99ll test=
 it
> shortly and report the results.
> =

> Should the bisect be done between v6.11 and v6.12, or v6.11 and v6.14?

If reverting one specific patch resolved it, that's a big smoking gun.
No need to bisect a huge stack of patches then again, imho.

Maybe check-out that SHA1 and the one before and verify that that
matches your earlier experience?


