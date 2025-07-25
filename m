Return-Path: <netdev+bounces-210068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68CDB120AA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD5176929
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB572EE276;
	Fri, 25 Jul 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZnIPsv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC45230BC3
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456269; cv=none; b=CpNnLqWWCT8PRRYhcUx4tDSMP2h34hZdc51C49/LkGx7EQgevkn01hXjVClVG8sfEHL3fCLdQHPddF3HI/YLjrEWghx7UrGrGnLLycm0+TsaZaY1ZQ+9OnLM853vNVio2+nRsDqmqGz2vzmwGJWbcc/pgy8tyTOXvkF11jMjcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456269; c=relaxed/simple;
	bh=yUIlEVkN3p+Koil4vK3bb9TJFWlNVctbQ8q2WDydzy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMS+IEzVtbx4LedjfY9apDxrMcnlf5iUZxyj61Hc5x6mmP5yno4xEzD1XhZnY2Lp9fdv8x4mKKP/pwU8LUbJ/8Ejbn0fEqML6Kk2yBnXn8BhFBszUOJ/+6AkO9tgzm5HJDxz2AZu9UwX8zEuPYJyuIt8Xb5DQ0rJqay9vQAwfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZnIPsv+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45629703011so17832485e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753456265; x=1754061065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M5WpEagxOTPhud8tZCNlcxMdpdVkq8ee/qPcISONWM=;
        b=hZnIPsv+yjnP6aSOFOt4+pgwsuEak88R/Pzg9MeBP3IG10hNJ2OrXEW1p/b5zYBkkz
         NGdSvPdBzQsAEaxiHgTLHxbmNYI++Y4UqwEARye/V+CYdk4E4Zqc4ySg02458pL6uJDA
         noLPg53pEKdITQS11S1bZ/Se9qfwwP9TbhQaFtQa92CA5LQVE8hbKayd8zs3TNIzrFIG
         Y6Ovwspk+aL2E31kJxXzxYUdEljrAb+JwENt69+Z9QgeFVowUnpEKXIuDxHoobl2bXmI
         M0IBYZX5MK0EZuL5F1MucvoJ/Cjr95kJ+Qw45WT5fx0M4+FU+FEZZN2qBsPGCTdGkm2k
         FwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456265; x=1754061065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M5WpEagxOTPhud8tZCNlcxMdpdVkq8ee/qPcISONWM=;
        b=hy18J3nxjSBLoXoaCLgxtADWHjovr8/3N0IKYxgzWGdgq5yOAk2LyORs62cTqfIKMW
         vbCtecxibAYtPxrh52MO8K2UZoTYonl9xIV+x2TLIakdcGFYSFwrcx/rfa8QnPmKRAb1
         VASezkXHjKidncj2sUYVrvjOgrmJGaHlNzp2i9WKhQPlrJXpsjzDfvyx2dLWUmTzv4VC
         KBoQL8EIENDMAjx8qF3U6CAJsPX7Y8TewIfWBYCS/Wy7rmXbOLHIupA/1TugLjLvu15b
         TjrB4m5CaDYqtWY/atPaKWu/bRjW/wpFWIO9a0Kscx0gmAotgp/McXLxDXFPKivFLLbx
         Hatg==
X-Forwarded-Encrypted: i=1; AJvYcCUxsXo4V1U7mJ6t5GnA5ORBHYjW2H0sSY+AIlrQDFurb9k2UD4aznbu0lYHX04gChWwy0mwlnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZGdXnWnnr6xJMlqjy9G3bkcCGoE9xvJhTOTDOooDaRhXf8GH
	aFLKcqedG3KB7K/E36FIQKlNj+XGccfRkyEZ/6j+KepyKVzOmhmazGTi/CQfuGEbc4ATcpL9XNU
	GGbcs1YEBmJ3Mzo+4rhqx322uz9tCNaM=
X-Gm-Gg: ASbGncum7IvEm7nzA+xEjLv5EkYTWdhSVUkbOcX5TLVfo8A9hfajDIVEToxr5vttrbo
	ZOc0aX6x9/MKloho5/iNPkm1HCL744LrJlPRh1CFJfqwT81GvmJ327m9oTVqDmBxJ6hNKOymAe2
	zjJbXpsToiVuPPJTeESTPol96ji+/3c0fSbMXG1IYLlE2k1SxpCCWJx5WqV55FQTyxkaEsB+ie0
	FSWy2wMeov7VbfMg3+eEVbWZvXH+ppjrFhvaz9a
X-Google-Smtp-Source: AGHT+IEZm3xajCFiNCXbY2w3P9Vb7tAuRbh8UpTlVxEKTksN36iPFJdHwTuquN3JE15eH63oIPrtJi8fNNm3qEuLfZc=
X-Received: by 2002:a5d:5886:0:b0:3b3:9c75:bb0e with SMTP id
 ffacd0b85a97d-3b77671d12emr1954608f8f.11.1753456265040; Fri, 25 Jul 2025
 08:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-6-mohsin.bashr@gmail.com> <aIEdS6fnblUEuYf5@boxer>
 <d47b541e48002d8edfc8331183c4617fb3d74f8a.camel@gmail.com> <aINUysHmm9157btU@boxer>
In-Reply-To: <aINUysHmm9157btU@boxer>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 25 Jul 2025 08:10:28 -0700
X-Gm-Features: Ac12FXwUFVlDfcjtGPeZoCfOeqBYAaEuss15eX8JOR7XqNuS-m-kckN4ksMZUXY
Message-ID: <CAKgT0Ud-QVX=xn8QZN-MBkVwHdcxE8FDz_AzhW-vdZJyLrLTkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org, kuba@kernel.org, 
	alexanderduyck@fb.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me, 
	aleksander.lobakin@intel.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 2:57=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 24, 2025 at 02:14:11PM -0700, Alexander H Duyck wrote:
> > On Wed, 2025-07-23 at 19:35 +0200, Maciej Fijalkowski wrote:
> > > On Wed, Jul 23, 2025 at 07:59:22AM -0700, Mohsin Bashir wrote:
> > > > Add basic support for attaching an XDP program to the device and su=
pport
> > > > for PASS/DROP/ABORT actions.
> > > > In fbnic, buffers are always mapped as DMA_BIDIRECTIONAL.
> > > >
> > > > Testing:
> > > >
> > > > Hook a simple XDP program that passes all the packets destined for =
a
> > > > specific port
> > > >
> > > > iperf3 -c 192.168.1.10 -P 5 -p 12345
> > > > Connecting to host 192.168.1.10, port 12345
> > > > [  5] local 192.168.1.9 port 46702 connected to 192.168.1.10 port 1=
2345
> > > > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > > [SUM]   1.00-2.00   sec  3.86 GBytes  33.2 Gbits/sec    0
> > > >
> > > > XDP_DROP:
> > > > Hook an XDP program that drops packets destined for a specific port
> > > >
> > > >  iperf3 -c 192.168.1.10 -P 5 -p 12345
> > > > ^C- - - - - - - - - - - - - - - - - - - - - - - - -
> > > > [ ID] Interval           Transfer     Bitrate         Retr
> > > > [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec    0       sende=
r
> > > > [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec            recei=
ver
> > > > iperf3: interrupt - the client has terminated
> > > >
> > > > XDP with HDS:
> > > >
> > > > - Validate XDP attachment failure when HDS is low
> > > >    ~] ethtool -G eth0 hds-thresh 512
> > > >    ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> > > >    ~] Error: fbnic: MTU too high, or HDS threshold is too low for s=
ingle
> > > >       buffer XDP.
> > > >
> > > > - Validate successful XDP attachment when HDS threshold is appropri=
ate
> > > >   ~] ethtool -G eth0 hds-thresh 1536
> > > >   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> > > >
> > > > - Validate when the XDP program is attached, changing HDS thresh to=
 a
> > > >   lower value fails
> > > >   ~] ethtool -G eth0 hds-thresh 512
> > > >   ~] netlink error: fbnic: Use higher HDS threshold or multi-buf ca=
pable
> > > >      program
> > > >
> > > > - Validate HDS thresh does not matter when xdp frags support is
> > > >   available
> > > >   ~] ethtool -G eth0 hds-thresh 512
> > > >   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_mb_12345.o sec xdp.f=
rags
> > > >
> > > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > > Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> > > > ---
> > > >  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 11 +++
> > > >  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 35 +++++++
> > > >  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +
> > > >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 95 +++++++++++++++=
++--
> > > >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
> > > >  5 files changed, 140 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/driv=
ers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > > > index 84a0db9f1be0..d7b9eb267ead 100644
> > > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > > > @@ -329,6 +329,17 @@ fbnic_set_ringparam(struct net_device *netdev,=
 struct ethtool_ringparam *ring,
> > > >           return -EINVAL;
> > > >   }
> > > >
> > > > + /* If an XDP program is attached, we should check for potential f=
rame
> > > > +  * splitting. If the new HDS threshold can cause splitting, we sh=
ould
> > > > +  * only allow if the attached XDP program can handle frags.
> > > > +  */
> > > > + if (fbnic_check_split_frames(fbn->xdp_prog, netdev->mtu,
> > > > +                              kernel_ring->hds_thresh)) {
> > > > +         NL_SET_ERR_MSG_MOD(extack,
> > > > +                            "Use higher HDS threshold or multi-buf=
 capable program");
> > > > +         return -EINVAL;
> > > > + }
> > > > +
> > > >   if (!netif_running(netdev)) {
> > > >           fbnic_set_rings(fbn, ring, kernel_ring);
> > > >           return 0;
> > > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drive=
rs/net/ethernet/meta/fbnic/fbnic_netdev.c
> > > > index d039e1c7a0d5..0621b89cbf3d 100644
> > > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > > > @@ -504,6 +504,40 @@ static void fbnic_get_stats64(struct net_devic=
e *dev,
> > > >   }
> > > >  }
> > > >
> > > > +bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int =
mtu,
> > > > +                       u32 hds_thresh)
> > > > +{
> > > > + if (!prog)
> > > > +         return false;
> > > > +
> > > > + if (prog->aux->xdp_has_frags)
> > > > +         return false;
> > > > +
> > > > + return mtu + ETH_HLEN > hds_thresh;
> > > > +}
> > > > +
> > > > +static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf =
*bpf)
> > > > +{
> > > > + struct bpf_prog *prog =3D bpf->prog, *prev_prog;
> > > > + struct fbnic_net *fbn =3D netdev_priv(netdev);
> > > > +
> > > > + if (bpf->command !=3D XDP_SETUP_PROG)
> > > > +         return -EINVAL;
> > > > +
> > > > + if (fbnic_check_split_frames(prog, netdev->mtu,
> > > > +                              fbn->hds_thresh)) {
> > > > +         NL_SET_ERR_MSG_MOD(bpf->extack,
> > > > +                            "MTU too high, or HDS threshold is too=
 low for single buffer XDP");
> > > > +         return -EOPNOTSUPP;
> > > > + }
> > > > +
> > > > + prev_prog =3D xchg(&fbn->xdp_prog, prog);
> > > > + if (prev_prog)
> > > > +         bpf_prog_put(prev_prog);
> > > > +
> > > > + return 0;
> > > > +}
> > > > +
> > > >  static const struct net_device_ops fbnic_netdev_ops =3D {
> > > >   .ndo_open               =3D fbnic_open,
> > > >   .ndo_stop               =3D fbnic_stop,
> > > > @@ -513,6 +547,7 @@ static const struct net_device_ops fbnic_netdev=
_ops =3D {
> > > >   .ndo_set_mac_address    =3D fbnic_set_mac,
> > > >   .ndo_set_rx_mode        =3D fbnic_set_rx_mode,
> > > >   .ndo_get_stats64        =3D fbnic_get_stats64,
> > > > + .ndo_bpf                =3D fbnic_bpf,
> > > >   .ndo_hwtstamp_get       =3D fbnic_hwtstamp_get,
> > > >   .ndo_hwtstamp_set       =3D fbnic_hwtstamp_set,
> > > >  };
> > > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drive=
rs/net/ethernet/meta/fbnic/fbnic_netdev.h
> > > > index 04c5c7ed6c3a..bfa79ea910d8 100644
> > > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > > > @@ -18,6 +18,8 @@
> > > >  #define FBNIC_TUN_GSO_FEATURES           NETIF_F_GSO_IPXIP6
> > > >
> > > >  struct fbnic_net {
> > > > + struct bpf_prog *xdp_prog;
> > > > +
> > > >   struct fbnic_ring *tx[FBNIC_MAX_TXQS];
> > > >   struct fbnic_ring *rx[FBNIC_MAX_RXQS];
> > > >
> > > > @@ -104,4 +106,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct =
net_device *netdev,
> > > >  int fbnic_phylink_get_fecparam(struct net_device *netdev,
> > > >                          struct ethtool_fecparam *fecparam);
> > > >  int fbnic_phylink_init(struct net_device *netdev);
> > > > +
> > > > +bool fbnic_check_split_frames(struct bpf_prog *prog,
> > > > +                       unsigned int mtu, u32 hds_threshold);
> > > >  #endif /* _FBNIC_NETDEV_H_ */
> > > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers=
/net/ethernet/meta/fbnic/fbnic_txrx.c
> > > > index 71af7b9d5bcd..486c14e83ad5 100644
> > > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > > > @@ -2,17 +2,26 @@
> > > >  /* Copyright (c) Meta Platforms, Inc. and affiliates. */
> > > >
> > > >  #include <linux/bitfield.h>
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/bpf_trace.h>
> > > >  #include <linux/iopoll.h>
> > > >  #include <linux/pci.h>
> > > >  #include <net/netdev_queues.h>
> > > >  #include <net/page_pool/helpers.h>
> > > >  #include <net/tcp.h>
> > > > +#include <net/xdp.h>
> > > >
> > > >  #include "fbnic.h"
> > > >  #include "fbnic_csr.h"
> > > >  #include "fbnic_netdev.h"
> > > >  #include "fbnic_txrx.h"
> > > >
> > > > +enum {
> > > > + FBNIC_XDP_PASS =3D 0,
> > > > + FBNIC_XDP_CONSUME,
> > > > + FBNIC_XDP_LEN_ERR,
> > > > +};
> > > > +
> > > >  enum {
> > > >   FBNIC_XMIT_CB_TS        =3D 0x01,
> > > >  };
> > > > @@ -877,7 +886,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi=
_vector *nv, u64 rcd,
> > > >
> > > >   headroom =3D hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
> > > >   frame_sz =3D hdr_pg_end - hdr_pg_start;
> > > > - xdp_init_buff(&pkt->buff, frame_sz, NULL);
> > > > + xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
> > > >   hdr_pg_start +=3D (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
> > > >                   FBNIC_BD_FRAG_SIZE;
> > > >
> > > > @@ -966,6 +975,38 @@ static struct sk_buff *fbnic_build_skb(struct =
fbnic_napi_vector *nv,
> > > >   return skb;
> > > >  }
> > > >
> > > > +static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
> > > > +                              struct fbnic_pkt_buff *pkt)
> > > > +{
> > > > + struct fbnic_net *fbn =3D netdev_priv(nv->napi.dev);
> > > > + struct bpf_prog *xdp_prog;
> > > > + int act;
> > > > +
> > > > + xdp_prog =3D READ_ONCE(fbn->xdp_prog);
> > > > + if (!xdp_prog)
> > > > +         goto xdp_pass;
> > >
> > > Hi Mohsin,
> > >
> > > I thought we were past the times when we read prog pointer per each
> > > processed packet and agreed on reading the pointer once per napi loop=
?
> >
> > This is reading the cached pointer from the netdev. Are you saying you
> > would rather have this as a stack pointer instead? I don't really see
> > the advantage to making this a once per napi poll session versus just
> > reading it once per packet.
>
> Hi Alex,
>
> this is your only reason (at least currently in this patch) to load the
> cacheline from netdev struct whereas i was just suggesting to piggyback o=
n
> the fact that bpf prog pointer will not change within single napi loop.
>
> it's up to you of course and should be considered as micro-optimization.

The cost for the "extra cacheline" should be nil as from what I can
tell xdp_prog shares the cacheline with gro_max_size and _rx so in
either path that cacheline is going to eventually be pulled in anyway
regardless of what path it goes with.

> >
> > >
> > > > +
> > > > + if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_fra=
gs)
> > > > +         return ERR_PTR(-FBNIC_XDP_LEN_ERR);
> > >
> > > when can this happen and couldn't you catch this within ndo_bpf? i su=
ppose
> > > it's related to hds setup.
> >
> > I was looking over the code and really the MTU is just a suggestion for
> > what size packets we can expect to receive. The MTU doesn't guarantee
> > the receive size, it is just the maximum transmission unit and
> > represents the minimum frame size we should support.
> >
> > Much like what I did on the Intel NICs back in the day we can receive
> > up to the maximum frame size in almost all cases regardless of MTU
>
> mtu is usually an indicator what actual max frame size you are configurin=
g
> on rx side AFAICT. i asked about xdp_has_frags being looked up in hot pat=
h
> as it's not what i usually have seen.

The problem is if you are going to actually modify the Rx side there
are side effects to that. Usually there are settings in the hardware
that have to be changed and as a result the link has to bounce as the
data path has to be cleaned up and reset after reallocating buffers or
changing receive modes.

For the fm10k I had designed that driver to avoid that. As such it
doesn't even have a change_mtu function anymore as that got removed in
2016 when the min/max MTU checking was added. That is also one reason
why the fbnic driver doesn't need that checking, however I suppose it
does introduce an interesting problem as we will have to go back and
add change_mtu functions for the drivers that support BPF and
scatter-gather receive for large frames since we should probably be
checking for if the MTU is large enough to cause us to use frags.
Either that or we just make them mandatory for devices that support
it.

