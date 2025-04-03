Return-Path: <netdev+bounces-179048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD9A7A45D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B456162168
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9224BC09;
	Thu,  3 Apr 2025 13:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F97210FB;
	Thu,  3 Apr 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.203.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688281; cv=none; b=RlVZ4fnQpx0tC0SBwJ26KYwxIqkpwomNsxluxa7XbrAnwIuGyA4nZlVyvRCnUtU62FKiH2y7OOB4/9w0aKLHnlyLFI9hdI2TGp63CooixDVqorcazrT6h3n0k66zo0BQfmHA2vfOh3r5hCQeK0iShJyn3r/d/kUKOSlWSaGTJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688281; c=relaxed/simple;
	bh=PYOLKGBNbojeHf2wSjQRj8K0nWnUXCKnUDzo2jhYuVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0rGXymQNKO6CBJgCcw2M2OrroLtF44F/g1ch6c9PwAYroHsuR5NQELO6Dv2rgi0GsDde3xpeIqGccbklqa7FxdOmJ2gIMtNWfSE5IBlzcqiEeHJH+z8Ol0044RUBdcRrToep7VxX1cCxXaQnMPGkBdRB7sMngy7Pw2WzaliBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de; spf=pass smtp.mailfrom=webked.de; arc=none smtp.client-ip=159.69.203.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webked.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 465FC62BDA;
	Thu,  3 Apr 2025 15:51:02 +0200 (CEST)
Message-ID: <f8909f5bbc2532ea234cdaa8dbdb46a48249803f.camel@webked.de>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 03 Apr 2025 15:51:01 +0200
In-Reply-To: <20250403090001-mutt-send-email-mst@kernel.org>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
	 <20250403090001-mutt-send-email-mst@kernel.org>
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

Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
Tsirkin:
> On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > Hi,
> >=20
> > I'm observing a significant performance regression in KVM guest VMs
> > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
> >=20
> > When running on a host system equipped with a Broadcom NetXtreme-E
> > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the
> > guest drops to 100=E2=80=93200 KB/s. The same guest configuration perfo=
rms
> > normally (~100 MB/s) when using kernel 6.8.0 or when the VM is
> > moved to a host with Intel NICs.
> >=20
> > Test environment:
> > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > - Guest: Linux with virtio-net interface
> > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level)
> > - CPU: AMD EPYC
> > - Storage: virtio-scsi
> > - VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
> > - Traffic test: iperf3, scp, wget consistently slow in guest
> >=20
> > This issue is not present:
> > - On 6.8.0=20
> > - On hosts with Intel NICs (same VM config)
> >=20
> > I have bisected the issue to the following upstream commit:
> >=20
> > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning for small
> > tx")
> > =C2=A0 https://git.kernel.org/linus/49d14b54a527
>=20
> Thanks a lot for the info!
>=20
>=20
> both the link and commit point at:
>=20
> commit 49d14b54a527289d09a9480f214b8c586322310a
> Author: Eric Dumazet <edumazet@google.com>
> Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
>=20
> =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in virtio_net_h=
dr_to_skb()
> =C2=A0=C2=A0=C2=A0=20
>=20
> is this what you mean?
>=20
> I don't know which commit is "virtio-net: Suppress tx timeout warning
> for small tx"
>=20
>=20
>=20
> > Reverting this commit restores normal network performance in
> > affected guest VMs.
> >=20
> > I=E2=80=99m happy to provide more data or assist with testing a potenti=
al
> > fix.
> >=20
> > Thanks,
> > Markus Fohrer
>=20
>=20
> Thanks! First I think it's worth checking what is the setup, e.g.
> which offloads are enabled.
> Besides that, I'd start by seeing what's doing on. Assuming I'm right
> about
> Eric's patch:
>=20
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 276ca543ef44d8..02a9f4dc594d02 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct
> sk_buff *skb,
> =C2=A0
> =C2=A0		if (!skb_partial_csum_set(skb, start, off))
> =C2=A0			return -EINVAL;
> +		if (skb_transport_offset(skb) < nh_min_len)
> +			return -EINVAL;
> =C2=A0
> -		nh_min_len =3D max_t(u32, nh_min_len,
> skb_transport_offset(skb));
> +		nh_min_len =3D skb_transport_offset(skb);
> =C2=A0		p_off =3D nh_min_len + thlen;
> =C2=A0		if (!pskb_may_pull(skb, p_off))
> =C2=A0			return -EINVAL;
>=20
>=20
> sticking a printk before return -EINVAL to show the offset and
> nh_min_len
> would be a good 1st step. Thanks!
>=20


Hi Eric,

thanks a lot for the quick response =E2=80=94 and yes, you're absolutely ri=
ght.

Apologies for the confusion: I mistakenly wrote the wrong commit
description in my initial mail.

The correct commit is indeed:

commit 49d14b54a527289d09a9480f214b8c586322310a
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Sep 26 16:58:36 2024 +0000

    net: test for not too small csum_start in virtio_net_hdr_to_skb()

This is the one I bisected and which causes the performance regression
in my environment.

Thanks again,
Markus


