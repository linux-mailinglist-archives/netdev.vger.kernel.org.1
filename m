Return-Path: <netdev+bounces-126326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C3970BD6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270A8281B33
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 02:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3E81727;
	Mon,  9 Sep 2024 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT0m4RqC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01942A8A
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849222; cv=none; b=bNQAx3CBJ/NF8o3d1MreWGTh+9peIK46OTPl1lErjQ/NX2KZ+7jqJCCf0QQivDDJV9jiwmP7Sv65N+yuVP0CTz+xg2E/Zs6oAel3N/aEEHcgIHqZ3+Md/7KY+bNdz+ISAQ0JqxCB+L8bLit9dOFp75zUyaM7dDgmiO/SbMzVQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849222; c=relaxed/simple;
	bh=3MgBrC6UBqNgHJmqi6dTTJNslgpgmrfohnB5vfrLaBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKWk4yFlite5q5nlcNvC38kgxx+l4429oBr4hvtHBChLzayZl/6VCPBjmbgpro11+GT4u6wPCLDNjdm3HAox8rzpfBGyv5UN3fjxnb0xjqdZSdqYCecRRH4QV1Ciot5a0HlBx5zjq/h5qRvv+NYgzbNKvYc7CYdirMlocF6isJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PT0m4RqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725849218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cU0v1eqVjTROWjz/OPdXpEZtL2DveDzF5Ir0LqMrFS0=;
	b=PT0m4RqCE8QVh4QCRhXYvS1B16x+wKfEeiMdvfY7cC3+o94BejEhPkt+jmtW3deSTdTTdH
	g6LEIIujls08A5gdJSm/XVpLkIhugk2JykLGKvuuITgyl2QL001OFQElwbzTZ/3+cWnkur
	cY3AtUKu2FsvPfjpnXWmkPT55e/kPTY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ix5TsbEPOaubk78MawHHeg-1; Sun, 08 Sep 2024 22:33:37 -0400
X-MC-Unique: ix5TsbEPOaubk78MawHHeg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2db470aa646so236802a91.3
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 19:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725849216; x=1726454016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU0v1eqVjTROWjz/OPdXpEZtL2DveDzF5Ir0LqMrFS0=;
        b=rdW4/dFG+/FzdD18f0YE7WRQCLSer4QoAtOvmizT0lVdnKFZqGpEr1FkJxXoxNkyit
         f8Q2AvwPQ6mLE1iB+vOBKF+p1hfFR074S06zcwFfa4tafEGOuqXF/WTkZnk1yl95SrFK
         hJXY7mcVlBcrGJtxfshkxCvhcXzdLVI1ZB0dLYh/bIRPV+lP+z6cd6UTHxLnmvPokJ55
         0gSzI6dMVjS2LjRw8vxvKm2xqZYIF8qb/lzG9AXAEjPxo9PolXltNNm5NqbivRTKHVlx
         2zvzJAjffU7KkrI1LKJd5KkDXYKWGGvMBlDxgSwf5wUa19RESatfRJ+1LgiF2f+d03wz
         pJYA==
X-Forwarded-Encrypted: i=1; AJvYcCVfY4N8L6xl987E9oqNq4j678AuEAQYv4YzF8KSb7+lfT5rgVATPae1CiNwS+Mth/Soj1QEJXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrFpzfrJGMjxpEu9qN2nbHYrGdCwnijTaK7BEiPsh0DiRZmrN
	wcXX6H5LO4eJzAe5ZF50PdN5TOVryFsNvDg83BNFrJAdNXbsClIIrb2iV6rBdvSYJDZgvuLVe7G
	iAcNnUbiRCUJrL1cRSEP9LDFI8kw9zZpWKwzzKCs/g/4+JAwOjMsslCICH22ojS8dPhitKUWknN
	0G/etXHp2Bth7K9OYWYUyL9F1qEEoA
X-Received: by 2002:a17:90a:77ca:b0:2c9:df1c:4a58 with SMTP id 98e67ed59e1d1-2dad5018dbfmr12133081a91.23.1725849215849;
        Sun, 08 Sep 2024 19:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/hnGre/aUYj8kBXTM5IgWduczJbqEJBbBtpX1h/wwIuivvjaY3L5vKgpdxH9r0mLh8gQSyZgxeBVg6wxKFiQ=
X-Received: by 2002:a17:90a:77ca:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2dad5018dbfmr12133049a91.23.1725849215108; Sun, 08 Sep 2024
 19:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com> <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch> <20240908164252-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240908164252-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Sep 2024 10:33:24 +0800
Message-ID: <CACGkMEtchtLYAVgUYGFt3e-1UjNBy+h0Kv-7K3dRiiKEr7gnKw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in virtio_net_hdr
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, arefev@swemel.ru, 
	alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org, 
	Jakub Sitnicki <jakub@cloudflare.com>, Felix Fietkau <nbd@nbd.name>, Mark Brown <broonie@kernel.org>, 
	Yury Khrustalev <yury.khrustalev@arm.com>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 4:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Sep 08, 2024 at 04:09:43PM -0400, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Szabolcs Nagy wrote:
> > > > The 07/29/2024 16:10, Willem de Bruijn wrote:
> > > > > From: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > Tighten csum_start and csum_offset checks in virtio_net_hdr_to_sk=
b
> > > > > for GSO packets.
> > > > >
> > > > > The function already checks that a checksum requested with
> > > > > VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> > > > > this might not hold for segs after segmentation.
> > > > >
> > > > > Syzkaller demonstrated to reach this warning in skb_checksum_help
> > > > >
> > > > >         offset =3D skb_checksum_start_offset(skb);
> > > > >         ret =3D -EINVAL;
> > > > >         if (WARN_ON_ONCE(offset >=3D skb_headlen(skb)))
> > > > >
> > > > > By injecting a TSO packet:
> > > > >
> > > > > WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_hel=
p+0x3d0/0x5b0
> > > > >  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
> > > > >  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
> > > > >  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
> > > > >  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
> > > > >  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
> > > > >  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> > > > >  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
> > > > >  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
> > > > >  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
> > > > >  xmit_one net/core/dev.c:3595 [inline]
> > > > >  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
> > > > >  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
> > > > >  packet_snd net/packet/af_packet.c:3073 [inline]
> > > > >
> > > > > The geometry of the bad input packet at tcp_gso_segment:
> > > > >
> > > > > [   52.003050][ T8403] skb len=3D12202 headroom=3D244 headlen=3D1=
2093 tailroom=3D0
> > > > > [   52.003050][ T8403] mac=3D(168,24) mac_len=3D24 net=3D(192,52)=
 trans=3D244
> > > > > [   52.003050][ T8403] shinfo(txflags=3D0 nr_frags=3D1 gso(size=
=3D1552 type=3D3 segs=3D0))
> > > > > [   52.003050][ T8403] csum(0x60000c7 start=3D199 offset=3D1536
> > > > > ip_summed=3D3 complete_sw=3D0 valid=3D0 level=3D0)
> > > > >
> > > > > Mitigate with stricter input validation.
> > > > >
> > > > > csum_offset: for GSO packets, deduce the correct value from gso_t=
ype.
> > > > > This is already done for USO. Extend it to TSO. Let UFO be:
> > > > > udp[46]_ufo_fragment ignores these fields and always computes the
> > > > > checksum in software.
> > > > >
> > > > > csum_start: finding the real offset requires parsing to the trans=
port
> > > > > header. Do not add a parser, use existing segmentation parsing. T=
hanks
> > > > > to SKB_GSO_DODGY, that also catches bad packets that are hw offlo=
aded.
> > > > > Again test both TSO and USO. Do not test UFO for the above reason=
, and
> > > > > do not test UDP tunnel offload.
> > > > >
> > > > > GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
> > > > > CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO transmi=
t
> > > > > from devices with no checksum offload"), but then still these fie=
lds
> > > > > are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So=
 no
> > > > > need to test for ip_summed =3D=3D CHECKSUM_PARTIAL first.
> > > > >
> > > > > This revises an existing fix mentioned in the Fixes tag, which br=
oke
> > > > > small packets with GSO offload, as detected by kselftests.
> > > > >
> > > > > Link: https://syzkaller.appspot.com/bug?extid=3De1db31216c789f552=
871
> > > > > Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kub=
a@kernel.org
> > > > > Fixes: e269d79c7d35 ("net: missing check virtio")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > ---
> > > > >
> > > > > v1->v2
> > > > >   - skb_transport_header instead of skb->transport_header (edumaz=
et@)
> > > > >   - typo: migitate -> mitigate
> > > > > ---
> > > >
> > > > this breaks booting from nfs root on an arm64 fvp
> > > > model for me.
> > > >
> > > > i see two fixup commits
> > > >
> > > > commit 30b03f2a0592eee1267298298eac9dd655f55ab2
> > > > Author:     Jakub Sitnicki <jakub@cloudflare.com>
> > > > AuthorDate: 2024-08-08 11:56:22 +0200
> > > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > > CommitDate: 2024-08-09 21:58:08 -0700
> > > >
> > > >     udp: Fall back to software USO if IPv6 extension headers are pr=
esent
> > > >
> > > > and
> > > >
> > > > commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
> > > > Author:     Felix Fietkau <nbd@nbd.name>
> > > > AuthorDate: 2024-08-19 17:06:21 +0200
> > > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > > CommitDate: 2024-08-21 17:15:05 -0700
> > > >
> > > >     udp: fix receiving fraglist GSO packets
> > > >
> > > > but they don't fix the issue for me,
> > > > at the boot console i see
> > > >
> > > > ...
> > > > [    3.686846] Sending DHCP requests ., OK
> > > > [    3.687302] IP-Config: Got DHCP answer from 172.20.51.254, my ad=
dress is 172.20.51.1
> > > > [    3.687423] IP-Config: Complete:
> > > > [    3.687482]      device=3Deth0, hwaddr=3Dea:0d:79:71:af:cd, ipad=
dr=3D172.20.51.1, mask=3D255.255.255.0, gw=3D172.20.51.254
> > > > [    3.687631]      host=3D172.20.51.1, domain=3D, nis-domain=3D(no=
ne)
> > > > [    3.687719]      bootserver=3D172.20.51.254, rootserver=3D10.2.8=
0.41, rootpath=3D
> > > > [    3.687771]      nameserver0=3D172.20.51.254, nameserver1=3D172.=
20.51.252, nameserver2=3D172.20.51.251
> > > > [    3.689075] clk: Disabling unused clocks
> > > > [    3.689167] PM: genpd: Disabling unused power domains
> > > > [    3.689258] ALSA device list:
> > > > [    3.689330]   No soundcards found.
> > > > [    3.716297] VFS: Mounted root (nfs4 filesystem) on device 0:24.
> > > > [    3.716843] devtmpfs: mounted
> > > > [    3.734352] Freeing unused kernel memory: 10112K
> > > > [    3.735178] Run /sbin/init as init process
> > > > [    3.743770] eth0: bad gso: type: 1, size: 1440
> > > > [    3.744186] eth0: bad gso: type: 1, size: 1440
> > > > ...
> > > > [  154.610991] eth0: bad gso: type: 1, size: 1440
> > > > [  185.330941] nfs: server 10.2.80.41 not responding, still trying
> > > > ...
> > > >
> > > > the "bad gso" message keeps repeating and init
> > > > is not executed.
> > > >
> > > > if i revert the 3 patches above on 6.11-rc6 then
> > > > init runs without "bad gso" error.
> > > >
> > > > this affects testing the arm64-gcs patches on
> > > > top of 6.11-rc3 and 6.11-rc6
> > > >
> > > > not sure if this is an fvp or kernel bug.
> > >
> > > Thanks for the report, sorry that you're encountering this breakage.
> > >
> > > Makes sense that this commit introduced it
> > >
> > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > >                                   virtio_is_little_endian(vi->vdev)))=
 {
> > >                 net_warn_ratelimited("%s: bad gso: type: %u, size: %u=
\n",
> > >                                      dev->name, hdr->hdr.gso_type,
> > >                                      hdr->hdr.gso_size);
> > >                 goto frame_err;
> > >         }
> > >
> > > Type 1 is VIRTIO_NET_HDR_GSO_TCPV4
> > >
> > > Most likely this application is inserting a packet with flag
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM and a wrong csum_start. Or is requesting
> > > TSO without checksum offload at all. In which case the kernel goes ou=
t
> > > of its way to find the right offset, but may fail.
> > >
> > > Which nfs-client is this? I'd like to take a look at the sourcecode.
> > >
> > > Unfortunately the kernel warning lacks a few useful pieces of data,
> > > such as the other virtio_net_hdr fields and the packet length.
> >
> > This happens on the virtio-net receive path, so the bad data is
> > received from the hypervisor.
> >
> > >From what I gather that arm64 fvp (Fixed Virtual Platforms) hypervisor
> > is closed source?
> >
> > Disabling GRO on this device will likely work as temporary workaround.
> >
> > What we can do is instead of dropping packets to correct their offset:
> >
> >                 case SKB_GSO_TCPV4:
> >                 case SKB_GSO_TCPV6:
> > -                        if (skb->csum_offset !=3D offsetof(struct tcph=
dr, check))
> > -                                return -EINVAL;
> > +                        if (skb->csum_offset !=3D offsetof(struct tcph=
dr, check)) {
> > +                                DEBUG_NET_WARN_ON_ONCE(1);
> > +                                skb->csum_offset =3D offsetof(struct t=
cphdr, check);
> > +                        }
> >
> > If the issue is in csum_offset. If the new csum_start check fails,
> > that won't help.
> >
> > It would be helpful to see these values at this point, e.g., with
> > skb_dump(KERN_INFO, skb, false);
>
>
> It's an iteresting question whether when VIRTIO_NET_F_GUEST_HDRLEN
> is not negotiated, csum_offset can be relied upon for GRO.
>
> Jason, WDYT?

I don't see how it connects. GUEST_HDRLEN is about transmission but
not for receiving, current Linux driver doesn't use hdrlen at all so
hardened csum_offset looks like a must.

And we have

"""
If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options
have been negotiated, the driver MAY use hdr_len only as a hint about
the transport header size. The driver MUST NOT rely on hdr_len to be
correct. Note: This is due to various bugs in implementations.
"""

Thanks

>
> --
> MST
>


