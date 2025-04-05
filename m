Return-Path: <netdev+bounces-179415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96783A7C7D2
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510911767EA
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 06:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387C1BD9C5;
	Sat,  5 Apr 2025 06:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B71392;
	Sat,  5 Apr 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.203.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743833749; cv=none; b=PwarJJ8Z47MCLS04zWucUd8Izy2zTsmQzDoSqeUVCqv5cfU8kd/JsbB/UjKgeRWxc/PxE8bO6WF1sMVpQR8RNH4Or0CefvlKa62SzC1ZCupVMK0XKVugvvbcrZzwSIEZDFVmbj5LmSAx5yvwsMa2mwKuLazpOWawFOafYjTeZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743833749; c=relaxed/simple;
	bh=J56/d6ZYegHEszM3w8u1yCB2xhkDtPT0B0GKcYkQgNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQCYocDSNDJaR2LIl1I5qJLnH6gVld+Bzmbeo5rIktZ/FuAmkkcrCO8JVRxJfjKbLb9+lilOXDnL1+p6ER8EP5833yXjglpb6CbIltKTCiF5BRg83D35MrDuKhEKZTf9wBBwRRVAXxwdVLgj67fXGIHyPdH4lz5O5CedjHwXjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de; spf=pass smtp.mailfrom=webked.de; arc=none smtp.client-ip=159.69.203.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webked.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79FC962BED;
	Sat,  5 Apr 2025 08:15:20 +0200 (CEST)
Message-ID: <8a5012787351ece41cfcd19b05ba60ad336fe29f.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: Ilya Maximets <i.maximets@ovn.org>, Willem de Bruijn
	 <willemdebruijn.kernel@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 05 Apr 2025 08:15:15 +0200
In-Reply-To: <d50c0384-4607-4890-8012-e2e7032a5354@ovn.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
	 <20250403090001-mutt-send-email-mst@kernel.org>
	 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
	 <20250404042711-mutt-send-email-mst@kernel.org>
	 <e75cb5881a97485b08cdd76efd8a7d2191ecd106.camel@webked.de>
	 <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
	 <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
	 <d50c0384-4607-4890-8012-e2e7032a5354@ovn.org>
Organization: WEBKED IT Markus Fohrer
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Am Samstag, dem 05.04.2025 um 00:05 +0200 schrieb Ilya Maximets:

> On 4/4/25 5:13 PM, Willem de Bruijn wrote:
>=20
> > Markus Fohrer wrote:
> >=20
> > > Am Freitag, dem 04.04.2025 um 10:52 +0200 schrieb Markus Fohrer:
> > >=20
> > > > Am Freitag, dem 04.04.2025 um 04:29 -0400 schrieb Michael S. Tsirki=
n:
> > > >=20
> > > > > On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
> > > > >=20
> > > > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > > > > Tsirkin:
> > > > > >=20
> > > > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote=
:
> > > > > > >=20
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > I'm observing a significant performance regression in KVM
> > > > > > > > guest
> > > > > > > > VMs
> > > > > > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14=
).
> > > > > > > >=20
> > > > > > > > When running on a host system equipped with a Broadcom
> > > > > > > > NetXtreme-E
> > > > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > > > > the
> > > > > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configu=
ration
> > > > > > > > performs
> > > > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM
> > > > > > > > is
> > > > > > > > moved to a host with Intel NICs.
> > > > > > > >=20
> > > > > > > > Test environment:
> > > > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > > > - Guest: Linux with virtio-net interface
> > > > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > > > > level)
> > > > > > > > - CPU: AMD EPYC
> > > > > > > > - Storage: virtio-scsi
> > > > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > > > bottlenecks)
> > > > > > > > - Traffic test: iperf3, scp, wget consistently slow in gues=
t
> > > > > > > >=20
> > > > > > > > This issue is not present:
> > > > > > > > - On 6.8.0=20
> > > > > > > > - On hosts with Intel NICs (same VM config)
> > > > > > > >=20
> > > > > > > > I have bisected the issue to the following upstream commit:
> > > > > > > >=20
> > > > > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warni=
ng for
> > > > > > > > small
> > > > > > > > tx")
> > > > > > > > =C2=A0 [https://git.kernel.org/linus/49d14b54a527](https://=
git.kernel.org/linus/49d14b54a527)
> > > > > > >=20
> > > > > > >=20
> > > > > > > Thanks a lot for the info!
> > > > > > >=20
> > > > > > >=20
> > > > > > > both the link and commit point at:
> > > > > > >=20
> > > > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > > > Author: Eric Dumazet <[edumazet@google.com](mailto:edumazet@g=
oogle.com)>
> > > > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > > > virtio_net_hdr_to_skb()
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > is this what you mean?
> > > > > > >=20
> > > > > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > > > > warning
> > > > > > > for small tx"
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > > Reverting this commit restores normal network performance i=
n
> > > > > > > > affected guest VMs.
> > > > > > > >=20
> > > > > > > > I=E2=80=99m happy to provide more data or assist with testi=
ng a
> > > > > > > > potential
> > > > > > > > fix.
> > > > > > > >=20
> > > > > > > > Thanks,
> > > > > > > > Markus Fohrer
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Thanks! First I think it's worth checking what is the setup,
> > > > > > > e.g.
> > > > > > > which offloads are enabled.
> > > > > > > Besides that, I'd start by seeing what's doing on. Assuming I=
'm
> > > > > > > right
> > > > > > > about
> > > > > > > Eric's patch:
> > > > > > >=20
> > > > > > > diff --git a/include/linux/virtio_net.h
> > > > > > > b/include/linux/virtio_net.h
> > > > > > > index 276ca543ef44d8..02a9f4dc594d02 100644
> > > > > > > --- a/include/linux/virtio_net.h
> > > > > > > +++ b/include/linux/virtio_net.h
> > > > > > > @@ -103,8 +103,10 @@ static inline int
> > > > > > > virtio_net_hdr_to_skb(struct
> > > > > > > sk_buff *skb,
> > > > > > > =C2=A0
> > > > > > > =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> > > > > > > =C2=A0			return -EINVAL;
> > > > > > > +		if (skb_transport_offset(skb) < nh_min_len)
> > > > > > > +			return -EINVAL;
> > > > > > > =C2=A0
> > > > > > > -		nh_min_len =3D max_t(u32, nh_min_len,
> > > > > > > skb_transport_offset(skb));
> > > > > > > +		nh_min_len =3D skb_transport_offset(skb);
> > > > > > > =C2=A0		p_off =3D nh_min_len + thlen;
> > > > > > > =C2=A0		if (!pskb_may_pull(skb, p_off))
> > > > > > > =C2=A0			return -EINVAL;
> > > > > > >=20
> > > > > > >=20
> > > > > > > sticking a printk before return -EINVAL to show the offset an=
d
> > > > > > > nh_min_len
> > > > > > > would be a good 1st step. Thanks!
> > > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > I added the following printk inside virtio_net_hdr_to_skb():
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 if (skb_transport_offset(skb) < nh_min_len){
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk(KERN_INFO "vi=
rtio_net: 3 drop,
> > > > > > transport_offset=3D%u,
> > > > > > nh_min_len=3D%u\n",
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 skb_transport_offset(skb), nh_min_len);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > >=20
> > > > > > Built and installed the kernel, then triggered a large download
> > > > > > via:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 wget [http://speedtest.belwue.net/10G](http:=
//speedtest.belwue.net/10G)
> > > > > >=20
> > > > > > Relevant output from `dmesg -w`:
> > > > > >=20
> > > > > > [=C2=A0=C2=A0 57.327943] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.428942] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.428962] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.553068] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.553088] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.576678] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.618438] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.618453] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.703077] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.823072] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.891982] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 57.946190] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > > > [=C2=A0=C2=A0 58.218686] virtio_net: 3 drop, transport_offset=
=3D34,
> > > > > > nh_min_len=3D40=C2=A0=20
> > > > >=20
> > > > >=20
> > > > > Hmm indeed. And what about these values?
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 start =3D __virtio16_to_cpu(little_endian, =
hdr-
> > > > >=20
> > > > > > csum_start);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 off =3D __virtio16_to_cpu(little_endian, hd=
r-
> > > > >=20
> > > > > > csum_offset);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 needed =3D start + max_t(u32, thlen, off +
> > > > > sizeof(__sum16));
> > > > > print them too?
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > > I would now do the test with commit
> > > > > > 49d14b54a527289d09a9480f214b8c586322310a and commit
> > > > > > 49d14b54a527289d09a9480f214b8c586322310a~1
> > > > > >=20
> > > > >=20
> > > > >=20
> > > > > Worth checking though it seems likely now the hypervisor is doing
> > > > > weird
> > > > > things. what kind of backend is it? qemu? tun? vhost-user? vhost-
> > > > > net?
> > > > >=20
> > > >=20
> > > >=20
> > > > Backend: QEMU/KVM hypervisor (Proxmox)
> > > >=20
> > > >=20
> > > > printk output:
> > > >=20
> > > > [=C2=A0=C2=A0 58.641906] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > > off=3D16,
> > > > needed=3D54, nh_min_len=3D40
> > > > [=C2=A0=C2=A0 58.678048] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > > off=3D16,
> > > > needed=3D54, nh_min_len=3D40
> > > > [=C2=A0=C2=A0 58.952871] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > > off=3D16,
> > > > needed=3D54, nh_min_len=3D40
> > > > [=C2=A0=C2=A0 58.962157] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > > off=3D16,
> > > > needed=3D54, nh_min_len=3D40
> > > > [=C2=A0=C2=A0 59.071645] virtio_net: drop, transport_offset=3D34=C2=
=A0 start=3D34,
> > > > off=3D16,
> > > > needed=3D54, nh_min_len=3D40
> > >=20
> >=20
> >=20
> > So likely a TCP/IPv4 packet, but with VIRTIO_NET_HDR_GSO_TCPV6.
>=20
>=20
>=20
> Hi, Markus.
>=20
> Given this and the fact that the issue depends on the bnxt_en NIC on the
> hist, I'd make an educated guess that the problem is the host NIC driver.
>=20
> There are some known GRO issues in the nbxt_en driver fixed recently in
>=20
> =C2=A0 commit de37faf41ac55619dd329229a9bd9698faeabc52
> =C2=A0 Author: Michael Chan <[michael.chan@broadcom.com](mailto:michael.c=
han@broadcom.com)>
> =C2=A0 Date:=C2=A0=C2=A0 Wed Dec 4 13:59:17 2024 -0800
>=20
> =C2=A0=C2=A0=C2=A0 bnxt_en: Fix GSO type for HW GRO packets on 5750X chip=
s
>=20
> It's not clear to me what's your host kernel version.=C2=A0 But the commi=
t
> above was introduced in 6.14 and may be in fairly recent stable kernels.
> The oldest is v6.12.6 AFAICT.=C2=A0 Can you try one of these host kernels=
?
>=20
> Also, to confirm and workaround the problem, please, try disabling HW GRO
> on the bnxt_en NIC first:
>=20
> =C2=A0 ethtool -K <BNXT_EN NIC IFACE> rx-gro-hw off
>=20
> If that doesn't help, then the problem is likely something different.
>=20
> Best regards, Ilya Maximets.


Setting `rx-gro-hw off` on the Broadcom interfaces also resolves the issue:

ethtool -K ens1f0np0 rx-gro-hw off =20
ethtool -K ens1f1np1 rx-gro-hw off =20
ethtool -K ens1f2np2 rx-gro-hw off =20
ethtool -K ens1f3np3 rx-gro-hw off

With this setting applied, the guest receives traffic correctly even when G=
RO is enabled on the host.

The system is running the latest Proxmox kernel:

6.8.12-9-pve




> > This is observed in the guest on the ingress path, right? In
> > virtnet_receive_done.
> >=20
> > Is this using vhost-net in the host for pass-through? IOW, is
> > the host writing the virtio_net_hdr too?
> >=20
> >=20
> > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > >=20
> > >=20
> > > I just noticed that commit 17bd3bd82f9f79f3feba15476c2b2c95a9b11ff8
> > > (tcp_offload.c: gso fix) also touches checksum handling and may
> > > affect how skb state is passed to virtio_net_hdr_to_skb().
> > >=20
> > > Is it possible that the regression only appears due to the combinatio=
n
> > > of 17bd3bd8 and 49d14b54a5?
> >=20
> >=20
> > That patch only affects packets with SKB_GSO_FRAGLIST. Which is only
> > set on forwarding if NETIF_F_FRAGLIST is set. I don=20
>=20
>


