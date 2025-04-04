Return-Path: <netdev+bounces-179334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF8A7C05C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46683B79BE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B01F4632;
	Fri,  4 Apr 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lchpsflx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9D1F427D;
	Fri,  4 Apr 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779636; cv=none; b=MXPrvLPw/RZjgs+z48unkNcsfqlqHGEhEGF9H3H0TErmtb0LZpX2iHLFf192uQfivz6ZNGNlA1vbSgOUKQd51kI0S2xBUM90ykR+tMGoII4NgxYFsDV4/guHUQ6tq91llgx+/bVp9miCUVbleV1b2s44uxOelkhzWfSiTiGbzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779636; c=relaxed/simple;
	bh=WQbI3dyKllE7gweQpwKdM6+FVHrPveHLAJaHhBAMGzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kO8RHXwsY+mCjLlUgcL3/XY6S5g8d8LjMyJgAfqX+PhO/alMn77/TOWmdZO6Koi4RHrtli/ZpdI3hb0W3j/sTL+buaztCS3cP0KbJ5aMGRv7Zh3TLocbaUX8PDFFI13mDkxiJ62JfoeAxqJupAkPMLYKqDvGqdQI8VLzMU2DmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lchpsflx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c56a3def84so195906985a.0;
        Fri, 04 Apr 2025 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743779633; x=1744384433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/gFZeVnc+kSH/zqiFoTPbQDrc4DhywqySchfhRCUGg=;
        b=lchpsflx9nNXF8AEVPat8zM/fM2dOWSB5/8w7s3uV9K6bP2XrD4gHqAMJ4EdAQqxGp
         ooq9q+MMZseTuKQOjhs+RJH4SlASVc8XZMYCvDLOCFrte2GJcp2HFxUF+1/QJkuqSZQD
         ZrQR8gxxsTkg9MPndEFjRdWHLYpkNsYwaqI0T9PV4sNkfSx4MxPg3RYPlQBOJ/tpohi3
         8av3fjXVnrwX2VDWjIzqmzqRBe2jlICFV/pofiJRuNco0zFOXOBu2v8pwaIUT8SOVUBV
         uHqB7FWMGuHyaHIOuPMTEo9HS4c04YuHhexZXAYxeU2aRy7pyJsur7uYfO7k0H4m1H8X
         D12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779633; x=1744384433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/gFZeVnc+kSH/zqiFoTPbQDrc4DhywqySchfhRCUGg=;
        b=JkWUvWKbYrzvCvNEgiB8Ng+dMpQHPHW35JzVcGXzhUCmJ6ZI9Abq66jareEEK5luNq
         W1euEMpywONQjF3FjR0PNNCE0yLB27aTyzOdXWbxsGzRPXxl1WGNPQeRdfamf/Sle5Ub
         KUqPqySSToZKm2TWVLMTZ1hjHibNpdTqEg0sFjHPCPFu8Aio6C7GHeQchTSYhXk0vA82
         UhQlTkEXkRSHnkzDVgTFxmRyxF671IEQ2BR5zV9XWLUzKztI7scnSKjVYlv3vXdV0qxQ
         jll+4xFG/Alf05hlvGFE7oLVpXBKoDhC+4fXnropeiRzwwaMHjJtJX+gJnAtyrCtlque
         A1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVIel9rORlz6eEm0P+0pbl6uHZWoT7zfiwlQsvWb3Xv1+zxkQ3n9fPlSrULkSCVcRw8ewFyHAw4@vger.kernel.org, AJvYcCWF6FvBkbhchSbfxPOQ+0x2nDF989gUN4jsPXGDl2rb5yAc2MapQAoYUGRVWYCtI1lQ3Ga+tk1zrlAsRxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yyxoQEtslhvtqDyf7DZ+2c+yHDOct+5gDVgn+I+4ztzU/S7G
	2GuHMUmDFZlKiPSsPioRPFjp1nfo+Yr+4ndRGO1e7GyHj4fjB2uz
X-Gm-Gg: ASbGncsEFk5Oak8brXupEQDQnmRzD0hZro+0iH/gM+Ita157s/oWgXdSxML9QtUlsR/
	IUwNq2Ft0DXY2HL46PhtN7iT0A9a16hDwvmkLcbEbHRAQaKMzat/Q3mzXScTqiyEmcS+bZOZE8t
	NuGHDv3GdbLaRPntZ3j5NsdOjcebKigYKAfOAusxh0KV8GqAM+hueEIPWcolvvkWpHwiag0AKD4
	ujG57+tC/RUY+jLwcItbXHAFfj81AcbAqHOSf5l1v5ciEevahOOzPvVzwStDGsV7mcngqNoaQYx
	BxVKmAvnD7/Swl/7cZyCHUYtKpe28vsVsSbc/S3MOznkI879mXYgKTp4ts5PHIZdp8RpP5YU/Sp
	zshekcOkofkAt5QvrNhlALQ==
X-Google-Smtp-Source: AGHT+IFJi2tzpNLKZWpEPzGAGH5aga7+T+NCkeMlRPFClkmPT1RGO2gImTS1cr49l3Tpn3kkj8Il4Q==
X-Received: by 2002:a05:620a:4449:b0:7c5:f6be:bdae with SMTP id af79cd13be357-7c774d205eamr466302885a.20.1743779633097;
        Fri, 04 Apr 2025 08:13:53 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96e566sm228375685a.63.2025.04.04.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 08:13:52 -0700 (PDT)
Date: Fri, 04 Apr 2025 11:13:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Markus Fohrer <markus.fohrer@webked.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
In-Reply-To: <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
 <20250404042711-mutt-send-email-mst@kernel.org>
 <e75cb5881a97485b08cdd76efd8a7d2191ecd106.camel@webked.de>
 <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
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
> Am Freitag, dem 04.04.2025 um 10:52 +0200 schrieb Markus Fohrer:
> > Am Freitag, dem 04.04.2025 um 04:29 -0400 schrieb Michael S. Tsirkin:=

> > > On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
> > > > Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
> > > > Tsirkin:
> > > > > On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
> > > > > > Hi,
> > > > > > =

> > > > > > I'm observing a significant performance regression in KVM
> > > > > > guest
> > > > > > VMs
> > > > > > using virtio-net with recent Linux kernels (6.8.1+ and 6.14).=

> > > > > > =

> > > > > > When running on a host system equipped with a Broadcom
> > > > > > NetXtreme-E
> > > > > > (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
> > > > > > the
> > > > > > guest drops to 100=E2=80=93200 KB/s. The same guest configura=
tion
> > > > > > performs
> > > > > > normally (~100 MB/s) when using kernel 6.8.0 or when the VM
> > > > > > is
> > > > > > moved to a host with Intel NICs.
> > > > > > =

> > > > > > Test environment:
> > > > > > - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
> > > > > > - Guest: Linux with virtio-net interface
> > > > > > - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
> > > > > > level)
> > > > > > - CPU: AMD EPYC
> > > > > > - Storage: virtio-scsi
> > > > > > - VM network: virtio-net, virtio-scsi (no CPU or IO
> > > > > > bottlenecks)
> > > > > > - Traffic test: iperf3, scp, wget consistently slow in guest
> > > > > > =

> > > > > > This issue is not present:
> > > > > > - On 6.8.0 =

> > > > > > - On hosts with Intel NICs (same VM config)
> > > > > > =

> > > > > > I have bisected the issue to the following upstream commit:
> > > > > > =

> > > > > > =C2=A0 49d14b54a527 ("virtio-net: Suppress tx timeout warning=
 for
> > > > > > small
> > > > > > tx")
> > > > > > =C2=A0 https://git.kernel.org/linus/49d14b54a527
> > > > > =

> > > > > Thanks a lot for the info!
> > > > > =

> > > > > =

> > > > > both the link and commit point at:
> > > > > =

> > > > > commit 49d14b54a527289d09a9480f214b8c586322310a
> > > > > Author: Eric Dumazet <edumazet@google.com>
> > > > > Date:=C2=A0=C2=A0 Thu Sep 26 16:58:36 2024 +0000
> > > > > =

> > > > > =C2=A0=C2=A0=C2=A0 net: test for not too small csum_start in
> > > > > virtio_net_hdr_to_skb()
> > > > > =C2=A0=C2=A0=C2=A0 =

> > > > > =

> > > > > is this what you mean?
> > > > > =

> > > > > I don't know which commit is "virtio-net: Suppress tx timeout
> > > > > warning
> > > > > for small tx"
> > > > > =

> > > > > =

> > > > > =

> > > > > > Reverting this commit restores normal network performance in
> > > > > > affected guest VMs.
> > > > > > =

> > > > > > I=E2=80=99m happy to provide more data or assist with testing=
 a
> > > > > > potential
> > > > > > fix.
> > > > > > =

> > > > > > Thanks,
> > > > > > Markus Fohrer
> > > > > =

> > > > > =

> > > > > Thanks! First I think it's worth checking what is the setup,
> > > > > e.g.
> > > > > which offloads are enabled.
> > > > > Besides that, I'd start by seeing what's doing on. Assuming I'm=

> > > > > right
> > > > > about
> > > > > Eric's patch:
> > > > > =

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
> > > > > =

> > > > > =

> > > > > sticking a printk before return -EINVAL to show the offset and
> > > > > nh_min_len
> > > > > would be a good 1st step. Thanks!
> > > > > =

> > > > =

> > > > I added the following printk inside virtio_net_hdr_to_skb():
> > > > =

> > > > =C2=A0=C2=A0=C2=A0 if (skb_transport_offset(skb) < nh_min_len){
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk(KERN_INFO "virt=
io_net: 3 drop,
> > > > transport_offset=3D%u,
> > > > nh_min_len=3D%u\n",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 skb_transport_offset(skb), nh_min_len);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > =C2=A0=C2=A0=C2=A0 }
> > > > =

> > > > Built and installed the kernel, then triggered a large download
> > > > via:
> > > > =

> > > > =C2=A0=C2=A0=C2=A0 wget http://speedtest.belwue.net/10G
> > > > =

> > > > Relevant output from `dmesg -w`:
> > > > =

> > > > [=C2=A0=C2=A0 57.327943] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.428942] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.428962] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.553068] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.553088] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.576678] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.618438] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.618453] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.703077] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.823072] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.891982] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 57.946190] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > > [=C2=A0=C2=A0 58.218686] virtio_net: 3 drop, transport_offset=3D3=
4,
> > > > nh_min_len=3D40=C2=A0 =

> > > =

> > > Hmm indeed. And what about these values?
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 start =3D __virtio16_to_cpu(little_endian, hdr-=

> > > > csum_start);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 off =3D __virtio16_to_cpu(little_endian, hdr-
> > > > csum_offset);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 needed =3D start + max_t(u32, thlen, off +
> > > sizeof(__sum16));
> > > print them too?
> > > =

> > > =

> > > =

> > > > I would now do the test with commit
> > > > 49d14b54a527289d09a9480f214b8c586322310a and commit
> > > > 49d14b54a527289d09a9480f214b8c586322310a~1
> > > > =

> > > =

> > > Worth checking though it seems likely now the hypervisor is doing
> > > weird
> > > things. what kind of backend is it? qemu? tun? vhost-user? vhost-
> > > net?
> > > =

> > =

> > Backend: QEMU/KVM hypervisor (Proxmox)
> > =

> > =

> > printk output:
> > =

> > [=C2=A0=C2=A0 58.641906] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 58.678048] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 58.952871] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 58.962157] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40
> > [=C2=A0=C2=A0 59.071645] virtio_net: drop, transport_offset=3D34=C2=A0=
 start=3D34,
> > off=3D16,
> > needed=3D54, nh_min_len=3D40

So likely a TCP/IPv4 packet, but with VIRTIO_NET_HDR_GSO_TCPV6.

This is observed in the guest on the ingress path, right? In
virtnet_receive_done.

Is this using vhost-net in the host for pass-through? IOW, is
the host writing the virtio_net_hdr too?

> > =

> > =

> > =

> > =

> =

> I just noticed that commit 17bd3bd82f9f79f3feba15476c2b2c95a9b11ff8
> (tcp_offload.c: gso fix) also touches checksum handling and may
> affect how skb state is passed to virtio_net_hdr_to_skb().
> =

> Is it possible that the regression only appears due to the combination
> of 17bd3bd8 and 49d14b54a5?

That patch only affects packets with SKB_GSO_FRAGLIST. Which is only
set on forwarding if NETIF_F_FRAGLIST is set. I don =


