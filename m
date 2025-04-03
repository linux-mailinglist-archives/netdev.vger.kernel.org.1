Return-Path: <netdev+bounces-179188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE58A7B149
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A88189F565
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1F1FDE1E;
	Thu,  3 Apr 2025 21:25:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC41FDE2A;
	Thu,  3 Apr 2025 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.203.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715515; cv=none; b=WgfjGKMmSsBkkB6VULM7gn4Sk/dBoS5+Cce1+1TKWbSpnM0a+m6D+Qa3f3nJ0YiYhfQF1Jty+wisSd3PPuYZslX0ZYVpp0pwtl47Zizz9kNGz3qU4rNrUJTOe1qiOiVVUX4kok43hzBWmQ5pNxaHJTuCkBDsQr+V7EsSyR7tY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715515; c=relaxed/simple;
	bh=mx/QdCJg4au4/8IIFPo4RZ8AGGwHpjAaAGeq/qHk+z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jw2QSYGqTGWx15qY1zFT12fecq2nzDjyD7oLtuHqFI5wKEXPu4EZ2HEBnpTL4GQvMU78j9kPMWJU+cCdj1jF0ZRlSzHRtvs8pzs1PKF/48Elby+YlcdTlEcEdFT36dS5fwG604VjBAOD9CBrhJwFMbmMlgDDEYK4m62S+1m4ktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de; spf=pass smtp.mailfrom=webked.de; arc=none smtp.client-ip=159.69.203.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webked.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29AF161A78;
	Thu,  3 Apr 2025 23:24:48 +0200 (CEST)
Message-ID: <fa9aec4d5d5148cff37a17d076b90ab835b8c7ef.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 03 Apr 2025 23:24:43 +0200
In-Reply-To: <20250403170543-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
	 <20250403090001-mutt-send-email-mst@kernel.org>
	 <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
	 <20250403100206-mutt-send-email-mst@kernel.org>
	 <da1c8647c4efcfcf7e7d2ba7e6235afc7b0f63ae.camel@webked.de>
	 <20250403170543-mutt-send-email-mst@kernel.org>
Organization: WEBKED IT Markus Fohrer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Am Donnerstag, dem 03.04.2025 um 17:06 -0400 schrieb Michael S.
Tsirkin:
> On Thu, Apr 03, 2025 at 10:07:12PM +0200, Markus Fohrer wrote:
> > Am Donnerstag, dem 03.04.2025 um 10:03 -0400 schrieb Michael S.
> > Tsirkin:
> > > On Thu, Apr 03, 2025 at 03:51:01PM +0200, Markus Fohrer wrote:
> > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > > Tsirkin:
> > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer
> > > > > wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > I'm observing a significant performance regression in KVM
> > > > > > guest
> > > > > > VMs
> > > > > > using virtio-net with recent Linux kernels (6.8.1+ and
> > > > > > 6.14).
> > > > > >=20
> > > > > > When running on a host system equipped with a Broadcom
> > > > > > NetXtreme-E
> > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > > the
> > > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configurati=
on
> > > > > > performs
> > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM
> > > > > > is
> > > > > > moved to a host with Intel NICs.
> > > > > >=20
> > > > > > Test environment:
> > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > - Guest: Linux with virtio-net interface
> > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > > level)
> > > > > > - CPU: AMD EPYC
> > > > > > - Storage: virtio-scsi
> > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > bottlenecks)
> > > > > > - Traffic test: iperf3, scp, wget consistently slow in
> > > > > > guest
> > > > > >=20
> > > > > > This issue is not present:
> > > > > > - On 6.8.0=20
> > > > > > - On hosts with Intel NICs (same VM config)
> > > > > >=20
> > > > > > I have bisected the issue to the following upstream commit:
> > > > > >=20
> > > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning
> > > > > > for
> > > > > > small
> > > > > > tx")
> > > > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > > >=20
> > > > > Thanks a lot for the info!
> > > > >=20
> > > > >=20
> > > > > both the link and commit point at:
> > > > >=20
> > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > virtio_net_hdr_to_skb()
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > is this what you mean?
> > > > >=20
> > > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > > warning
> > > > > for small tx"
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > > Reverting this commit restores normal network performance
> > > > > > in
> > > > > > affected guest VMs.
> > > > > >=20
> > > > > > I=E2=80=99m happy to provide more data or assist with testing a
> > > > > > potential
> > > > > > fix.
> > > > > >=20
> > > > > > Thanks,
> > > > > > Markus Fohrer
> > > > >=20
> > > > >=20
> > > > > Thanks! First I think it's worth checking what is the setup,
> > > > > e.g.
> > > > > which offloads are enabled.
> > > > > Besides that, I'd start by seeing what's doing on. Assuming
> > > > > I'm
> > > > > right
> > > > > about
> > > > > Eric's patch:
> > > > >=20
> > > > > diff --git a/include/linux/virtio_net.h
> > > > > b/include/linux/virtio_net.h
> > > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > > --- a/include/linux/virtio_net.h
> > > > > +++ b/include/linux/virtio_net.h
> > > > > @@ -103,8 +103,10 @@ static inline int
> > > > > virtio_net_hdr_to_skb(struct
> > > > > sk_buff *skb,
> > > > > =C2=A0
> > > > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > > > =C2=A0			return -EINVAL;
> > > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > > +			return -EINVAL;
> > > > > =C2=A0
> > > > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > > > skb_transport_offset(skb));
> > > > > +		nh_min_len =3D skb_transport_offset(skb);
> > > > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > > > =C2=A0			return -EINVAL;
> > > > >=20
> > > > >=20
> > > > > sticking a printk before return -EINVAL to show the offset
> > > > > and
> > > > > nh_min_len
> > > > > would be a good 1st step. Thanks!
> > > > >=20
> > > >=20
> > > >=20
> > > > Hi Eric,
> > > >=20
> > > > thanks a lot for the quick response =E2=80=94 and yes, you're
> > > > absolutely
> > > > right.
> > > >=20
> > > > Apologies for the confusion: I mistakenly wrote the wrong
> > > > commit
> > > > description in my initial mail.
> > > >=20
> > > > The correct commit is indeed:
> > > >=20
> > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > Author: Eric Dumazet <edumazet@google.com>
> > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > virtio_net_hdr_to_skb()
> > > >=20
> > > > This is the one I bisected and which causes the performance
> > > > regression
> > > > in my environment.
> > > >=20
> > > > Thanks again,
> > > > Markus
> > >=20
> > >=20
> > > I'm not Eric but good to know.
> > > Alright, so I would start with the two items: device features and
> > > printk.
> > >=20
> >=20
> > as requested, here=E2=80=99s the device/feature information from the gu=
est
> > running kernel 6.14 (mainline):
> >=20
> > Interface: ens18
> >=20
> > ethtool -i ens18:
> > driver: virtio_net
> > version: 1.0.0
> > firmware-version:=20
> > expansion-rom-version:=20
> > bus-info: 0000:00:12.0
> > supports-statistics: yes
> > supports-test: no
> > supports-eeprom-access: no
> > supports-register-dump: no
> > supports-priv-flags: no
> >=20
> >=20
> > ethtool -k ens18:
> > Features for ens18:
> > rx-checksumming: on [fixed]
> > tx-checksumming: on
> > 	tx-checksum-ipv4: off [fixed]
> > 	tx-checksum-ip-generic: on
> > 	tx-checksum-ipv6: off [fixed]
> > 	tx-checksum-fcoe-crc: off [fixed]
> > 	tx-checksum-sctp: off [fixed]
> > scatter-gather: on
> > 	tx-scatter-gather: on
> > 	tx-scatter-gather-fraglist: off [fixed]
> > tcp-segmentation-offload: on
> > 	tx-tcp-segmentation: on
> > 	tx-tcp-ecn-segmentation: on
> > 	tx-tcp-mangleid-segmentation: off
> > 	tx-tcp6-segmentation: on
> > generic-segmentation-offload: on
> > generic-receive-offload: on
> > large-receive-offload: off [fixed]
> > rx-vlan-offload: off [fixed]
> > tx-vlan-offload: off [fixed]
> > ntuple-filters: off [fixed]
> > receive-hashing: off [fixed]
> > highdma: on [fixed]
> > rx-vlan-filter: on [fixed]
> > vlan-challenged: off [fixed]
> > tx-gso-robust: on [fixed]
> > tx-fcoe-segmentation: off [fixed]
> > tx-gre-segmentation: off [fixed]
> > tx-gre-csum-segmentation: off [fixed]
> > tx-ipxip4-segmentation: off [fixed]
> > tx-ipxip6-segmentation: off [fixed]
> > tx-udp_tnl-segmentation: off [fixed]
> > tx-udp_tnl-csum-segmentation: off [fixed]
> > tx-gso-partial: off [fixed]
> > tx-tunnel-remcsum-segmentation: off [fixed]
> > tx-sctp-segmentation: off [fixed]
> > tx-esp-segmentation: off [fixed]
> > tx-udp-segmentation: off
> > tx-gso-list: off [fixed]
> > tx-nocache-copy: off
> > loopback: off [fixed]
> > rx-fcs: off [fixed]
> > rx-all: off [fixed]
> > tx-vlan-stag-hw-insert: off [fixed]
> > rx-vlan-stag-hw-parse: off [fixed]
> > rx-vlan-stag-filter: off [fixed]
> > l2-fwd-offload: off [fixed]
> > hw-tc-offload: off [fixed]
> > esp-hw-offload: off [fixed]
> > esp-tx-csum-hw-offload: off [fixed]
> > rx-udp_tunnel-port-offload: off [fixed]
> > tls-hw-tx-offload: off [fixed]
> > tls-hw-rx-offload: off [fixed]
> > rx-gro-hw: on
> > tls-hw-record: off [fixed]
> > rx-gro-list: off
> > macsec-hw-offload: off [fixed]
> > rx-udp-gro-forwarding: off
> > hsr-tag-ins-offload: off [fixed]
> > hsr-tag-rm-offload: off [fixed]
> > hsr-fwd-offload: off [fixed]
> > hsr-dup-offload: off [fixed]
> >=20
> > ethtool ens18:
> > Settings for ens18:
> > 	Supported ports: [=C2=A0 ]
> > 	Supported link modes:=C2=A0=C2=A0 Not reported
> > 	Supported pause frame use: No
> > 	Supports auto-negotiation: No
> > 	Supported FEC modes: Not reported
> > 	Advertised link modes:=C2=A0 Not reported
> > 	Advertised pause frame use: No
> > 	Advertised auto-negotiation: No
> > 	Advertised FEC modes: Not reported
> > 	Speed: Unknown!
> > 	Duplex: Unknown! (255)
> > 	Auto-negotiation: off
> > 	Port: Other
> > 	PHYAD: 0
> > 	Transceiver: internal
> > netlink error: Operation not permitted
> > 	Link detected: yes
> >=20
> >=20
> > Kernel log (journalctl -k):
> > Apr 03 19:50:37 kb-test.allod.com kernel: virtio_scsi virtio2:
> > 4/0/0
> > default/read/poll queues=C2=A0=20
> > Apr 03 19:50:37 kb-test.allod.com kernel: virtio_net virtio1 ens18:
> > renamed from eth0
> >=20
> > Let me know if you=E2=80=99d like comparison data from kernel 6.11 or a=
ny
> > additional tests
>=20
>=20
> I think let's redo bisect first then I will suggest which traces to
> add.
>=20

The build with the added printk is currently running. I=E2=80=99ll test it
shortly and report the results.

Should the bisect be done between v6.11 and v6.12, or v6.11 and v6.14?


