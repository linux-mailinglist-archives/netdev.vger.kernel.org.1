Return-Path: <netdev+bounces-194687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42073ACBE6A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 04:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB263A5B4C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59411531C1;
	Tue,  3 Jun 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZGpQRWr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC914A62B
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916712; cv=none; b=t6VLasGP36Posz41Binw4frI4dvaU1QcS2eJh3zT8LfVO+yYdL8rdU/SER0q+qYEJFfh1oHGmozPm5lGIs6aVW/gmtreotnCmrwdw23xaG4O0OiSzPik6daCCaxthqoEPy5cajKsL9ByDrOUx9f1/S1wj8KeUsio+b0eq+IuZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916712; c=relaxed/simple;
	bh=ahHEc+4u3lstADF6wxz21fhv/0bBLieWIo8BqoInbx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQoXu2SIu+hjNCIUi3a/yVKZBSBkACURAwJ8lvk7OhhIT0zRVRq4CTJD84DgU26HhNiM15OyiaGW3vvPER4OzYFLbEUAhxJazy3NxQ6NZPkxrFZFPc+ltgLxZdLIIQnTdgcWZnMwE+POznb+mDfxcS17N24wnRnSomZEY1v4phk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZGpQRWr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748916709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mzo0HI0fHmxrRD35hAkgyKT2Nue6Gi9ZwGVf3e1jsKI=;
	b=LZGpQRWrAP2PD3mtbqqVbMRNz3eAmZEBUlOdrQuLPjq54V5d7WTbCyJORwJmN7FZUheRSp
	LvHQyac0hXNo4pltwFLagTcacZaXxX33/5HBsheTTqskpsvN7Y7CPIkeMzboYzrHIWCAXI
	owjaReR2OTx6LT9DWWNCoCUJLZs1LCQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-paNHAAWIMWWuLh0mUlMnzg-1; Mon, 02 Jun 2025 22:11:47 -0400
X-MC-Unique: paNHAAWIMWWuLh0mUlMnzg-1
X-Mimecast-MFC-AGG-ID: paNHAAWIMWWuLh0mUlMnzg_1748916706
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311f4f2e761so5000267a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 19:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916706; x=1749521506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzo0HI0fHmxrRD35hAkgyKT2Nue6Gi9ZwGVf3e1jsKI=;
        b=bFNaFeEvPD6QUg3QBWaZAI+7zBStnkunZh2hIX3hJt4Rf78RPAvlu3USZKgKhcWECh
         tJ4IE1fO0SYH59CiwJcS13O2+UOo2t/q1ML2ClhbpYjGOq6nXBao6ZViE/egh+GZT4k9
         zTHWvQZvpJcTozVxbzZsKd3YVIr7MIdY9IdcVyv5SRVcJy3tYHLVKkS0G7dgE6YEUflV
         HR5IBPlh2SV5VJKgEnJa4S5fkPCN5a6TPmYf52JtQuOEMClvo2papR0zI/JX4pfSnCdZ
         Y9O37c5Ux0LbFpd+W7MtC8RUNsqAOWLm00RwZNx61hKPIti8ZeZJM0PXK05rFcZRaptd
         wq6g==
X-Gm-Message-State: AOJu0YwJJWhJV2+gaLTr/yG/ophPlgbGNCchi3GAg3N7uBj62EjW6RQN
	EMzbxv+MuQ8FFH3odTkJaR0rS+F4caOE+tq6zpW0ij4dCUcyOp49UDiWX6FBRw59NF8i0OAQmFo
	8PcTzcZbHhyDlgWkQQZ9yXTEhk4QOFGA5vQYOXRF8chkS/YUzQGNjnjx84QYZ24xHo1TcgJNdxV
	6ZfSglwqCrqonau6TRPefpFIIOgCqblagD
X-Gm-Gg: ASbGnctkT1jHA22au7CfGFZTzZMw+TY+AiH24Gxb546Bu+byqqAGWrw3l7n9raVEFSZ
	lv/v+p28rULEHBFxer6iVe2t1Ie9iRP84kxjvd5Dzm04uyx23NvGS+IFC4I9cloS/bR4njQ==
X-Received: by 2002:a17:90b:2241:b0:311:ffe8:20e9 with SMTP id 98e67ed59e1d1-3127c721fe2mr16906828a91.17.1748916705457;
        Mon, 02 Jun 2025 19:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO4nlXxzYrFBccFsQifgyA7Ldp2LywbCwOndvmFw1xjvfWI+ER5jumV7Jy7nOpHPyf6GVON4iV78H7qxlfQmo=
X-Received: by 2002:a17:90b:2241:b0:311:ffe8:20e9 with SMTP id
 98e67ed59e1d1-3127c721fe2mr16906797a91.17.1748916704928; Mon, 02 Jun 2025
 19:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <bb441f9ccadc27bf41eb1937101d1d30fa827af5.1747822866.git.pabeni@redhat.com>
 <CACGkMEv5cXoA7aPOUmE63fRg21Kefx3MNE4VenGciL92WbvS_g@mail.gmail.com>
 <68620cd9-923e-49df-ad39-482c3fa22be4@redhat.com> <CACGkMEvpr1cqh2CaA6rP03T-dqzKcqkKV6cq+zCfCgAew=+CRw@mail.gmail.com>
 <82b00219-73e8-4330-99b4-3a0a2fe86a50@redhat.com>
In-Reply-To: <82b00219-73e8-4330-99b4-3a0a2fe86a50@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 10:11:32 +0800
X-Gm-Features: AX0GCFtQAj2RLxY7O1FMIauKGl4zVoyIgq-kcbox0LQD6v4NHO-61fQq-G6RyFk
Message-ID: <CACGkMEuRrGyCi-kxjTgGpyCdcp=yVHCS_qDFEmvfeqxzhfoJwA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:18=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 5/27/25 6:19 AM, Jason Wang wrote:
> > On Mon, May 26, 2025 at 7:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 5/26/25 6:40 AM, Jason Wang wrote:
> >>> On Wed, May 21, 2025 at 6:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> Add new tun features to represent the newly introduced virtio
> >>>> GSO over UDP tunnel offload. Allows detection and selection of
> >>>> such features via the existing TUNSETOFFLOAD ioctl, store the
> >>>> tunnel offload configuration in the highest bit of the tun flags
> >>>> and compute the expected virtio header size and tunnel header
> >>>> offset using such bits, so that we can plug almost seamless the
> >>>> the newly introduced virtio helpers to serialize the extended
> >>>> virtio header.
> >>>>
> >>>> As the tun features and the virtio hdr size are configured
> >>>> separately, the data path need to cope with (hopefully transient)
> >>>> inconsistent values.
> >>>
> >>> I'm not sure it's a good idea to deal with this inconsistency in this
> >>> series as it is not specific to tunnel offloading. It could be a
> >>> dependency for this patch or we can leave it for the future and just
> >>> to make sure mis-configuration won't cause any kernel issues.
> >>
> >> The possible inconsistency is not due to a misconfiguration, but to th=
e
> >> facts that:
> >> - configuring the virtio hdr len and the offload is not atomic
> >> - successful GSO over udp tunnel parsing requires the relevant offload=
s
> >> to be enabled and a suitable hdr len.
> >>
> >> Plain GSO don't have a similar problem because all the relevant fields
> >> are always available for any sane virtio hdr length, but we need to de=
al
> >> with them here.
> >
> > Just to make sure we're on the same page.
> >
> > I meant tun has TUNSETVNETHDRSZ, so user space can set it to any value
> > at any time as long as it's not smaller than sizeof(struct
> > virtio_net_hdr). Tun and vhost need to cope with this otherwise it
> > should be a bug. This is allowed before the introduction of tunnel
> > gso.
>
> This code here is intended to support such scenario; but if the virtio
> hdr size is configured to be lower than the minimum required for UDP
> tunnel hdr fields, the related offload could not be used.

Ok I see.

>
> >>>> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct =
*tun, struct tun_file *tfile,
> >>>>         struct sk_buff *skb;
> >>>>         size_t total_len =3D iov_iter_count(from);
> >>>>         size_t len =3D total_len, align =3D tun->align, linear;
> >>>> -       struct virtio_net_hdr gso =3D { 0 };
> >>>> +       char buf[TUN_VNET_TNL_SIZE];
> >>>
> >>> I wonder why not simply
> >>>
> >>> 1) define the structure virtio_net_hdr_tnl_gso and use that
> >>>
> >>> or
> >>>
> >>> 2) stick the gso here and use iter advance to get
> >>> virtio_net_hdr_tunnel when necessary?
> >>
> >> Code wise 2) looks more complex
> >
> > I don't know how to define complex but we've already use a conatiner st=
ructure:
> >
> > struct virtio_net_hdr_v1_hash {
> >         struct virtio_net_hdr_v1 hdr;
> >         __le32 hash_value;
> > ...
> >         __le16 hash_report;
> >         __le16 padding;
> > };
> >
> >> and 1) will require additional care when
> >> adding hash report support.
> >
> > I don't understand here, you're doing:
> >
> >         iov_iter_advance(from, sz - parsed_size);
> >
> > in __tun_vnet_hdr_get(), so this logic needs to be extended for hash
> > report as well.
>
> Note that there are at least 2 different virtio net hdr binary layout
> supporting UDP tunnel offload:
>
> struct virtio_net_hdr_v1_tnl {
>    struct virtio_net_hdr_v1 hdr;
>    struct virtio_net_hdr_tunnel tnl;
> };

Is this used by any guest? It looks problematic:

\begin{lstlisting}
struct virtio_net_hdr {
#define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
#define VIRTIO_NET_HDR_F_DATA_VALID    2
#define VIRTIO_NET_HDR_F_RSC_INFO      4
#define VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM 8
        u8 flags;
#define VIRTIO_NET_HDR_GSO_NONE        0
#define VIRTIO_NET_HDR_GSO_TCPV4       1
#define VIRTIO_NET_HDR_GSO_UDP         3
#define VIRTIO_NET_HDR_GSO_TCPV6       4
#define VIRTIO_NET_HDR_GSO_UDP_L4      5
#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 0x20
#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 0x40
#define VIRTIO_NET_HDR_GSO_ECN      0x80
u8 gso_type;
        le16 hdr_len;
        le16 gso_size;
        le16 csum_start;
        le16 csum_offset;
        le16 num_buffers;
        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiate=
d)
        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiate=
d)
        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiate=
d)
        le16 outer_th_offset    (Only if
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
negotiated)
        le16 inner_nh_offset;   (Only if
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
negotiated)
};
\end{lstlisting}

>
> and
>
> struct virtio_net_hdr_v1_hash_tnl {
>    struct virtio_net_hdr_v1_hash hdr;
>    struct virtio_net_hdr_tunnel tnl;
> };
>
> depending on the negotiated features. Using directly a struct to
> fill/fetch the tunnel fields is problematic.

I'm not sure what's the problem here, we can just skip the hash part
and it would be easier for the hash reporting feature.

>
> With the current approach the binary layout differences are abstracted
> by the tun_vnet_parse_size()/tun_vnet_tnl_offset() helpers. The
> expectation is that enabling hash report will set a bit in `flags`, too,
>  so that helpers could compute the correct offset accordingly.
>
> No other change should be required.
>
> >>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >>>> index 58b9ac7a5fc40..ab2d4396941ca 100644
> >>>> --- a/drivers/net/tun_vnet.h
> >>>> +++ b/drivers/net/tun_vnet.h
> >>>> @@ -5,6 +5,12 @@
> >>>>  /* High bits in flags field are unused. */
> >>>>  #define TUN_VNET_LE     0x80000000
> >>>>  #define TUN_VNET_BE     0x40000000
> >>>> +#define TUN_VNET_TNL           0x20000000
> >>>> +#define TUN_VNET_TNL_CSUM      0x10000000
> >>>> +#define TUN_VNET_TNL_MASK      (TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
> >>>> +
> >>>> +#define TUN_VNET_TNL_SIZE (sizeof(struct virtio_net_hdr_v1) + \
> >>>
> >>> Should this be virtio_net_hdr_v1_hash?
> >>
> >> If tun does not support HASH_REPORT, no: the GSO over UDP tunnels head=
er
> >> could be present regardless of the hash-related field presence. This h=
as
> >> been discussed extensively while crafting the specification.
> >
> > Ok, so it excludes the hash report fields, more below.
> >
> >>
> >> Note that tun_vnet_parse_size() and  tun_vnet_tnl_offset() should be
> >> adjusted accordingly after that HASH_REPORT support is introduced.
> >
> > This is suboptimal as we know a hash report will be added so we can
> > treat the field as anonymous one. See
> >
> > https://patchwork.kernel.org/project/linux-kselftest/patch/20250307-rss=
-v9-3-df76624025eb@daynix.com/
>
> I know hash support is in the work. The current design is intended to
> minimize the conflicts with such feature. But I can't follow the
> statement above. Could you please re-phrase it?

See above, if I was not wrong, virtio_net_hdr_v1_hash_tnl should be
sufficient for both tunnel offloading and hash reporting.

>
> >>>> +                          sizeof(struct virtio_net_hdr_tunnel))
> >>>>
> >>>>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int fl=
ags)
> >>>>  {
> >>>> @@ -45,6 +51,13 @@ static inline long tun_set_vnet_be(unsigned int *=
flags, int __user *argp)
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> +static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, =
bool tnl_csum)
> >>>> +{
> >>>> +       *flags =3D (*flags & ~TUN_VNET_TNL_MASK) |
> >>>> +                tnl * TUN_VNET_TNL |
> >>>> +                tnl_csum * TUN_VNET_TNL_CSUM;
> >>>
> >>> We could refer to netdev via tun_struct, so I don't understand why we
> >>> need to duplicate the features in tun->flags (we don't do that for
> >>> other GSO/CSUM stuffs).
> >>
> >> Just to be consistent with commit 60df67b94804b1adca74854db502a72f7aea=
a125
> >
> > I don't see a connection here, the above commit just moves decouple
> > vnet to make it reusable, it doesn't change the semantic of
> > tun->flags.
>
> You are right, I used a bad commit reference.
>
> The goal here is to keep all the virtio-layout-related information in a
> single place. tun->flags is already used for that (for little endian
> flag), so I piggybacked there.

Note that TUNSET/GETVNETLE stuff is not what virtio should know.

>
> Ideally another bit there will be allocated used to mark the hash report
> presence, too. That will allow the tun_vnet helpers to determine the
> virtio net hdr layout using a single argument.
>
> Note that we can't relay on the netdev->features to determine the virtio
> net hdr binary layout because user-space could enable/disable GSO over
> UDP tunnel support after ioctl(TUNSETOFFLOAD).

I'm not sure I got here, it works for non GSO offload, anything makes
UDP tunnel different here?

Thanks

>
> /P
>
>
>


