Return-Path: <netdev+bounces-209886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44875B112E2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 23:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66227562917
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACB253F35;
	Thu, 24 Jul 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3iTBdDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5D1494C3
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391656; cv=none; b=rOmZ7P7xKw0HhqDRwE2otaemwcys5Wi6yA5zpwaWlcakOUQnanWxO1rDidwNxst4Zc6po9rr8K+y6WnNgHlSxISsWJTVi/1aVUYOMilcMLVAY8sWWly4rz8Ns+RRLHhUVaAFUo3FfSZYaF4u1VUhJ3mr+1bBewBj7ODYumTHW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391656; c=relaxed/simple;
	bh=FoeQUP6R2dV4hT56mf7saYeP0ufIFSHMmIlwGaa8a0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eWsUS3EbUnndi5mKxM6c9QOVhB2vwfAuDULdTIiTfVvjziZl8PkxA3q3n0Ix2b+OrUwPcoRCUOTr/Z6C3SLXqOIHHtmnBv1j870SeKa7jDPjvQW4lvJZFi083tKnEQaw+ruijFeCoCHOvuzi5zAxbAoyohTfR1R1h61SMP0O5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3iTBdDG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1056302b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753391654; x=1753996454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DanjK+ayaBqr/ziqIDwxf4KxKx2IqkL+inWPjL3pAGk=;
        b=j3iTBdDGLnD0e+6CBUFnq9oJVDXlRn7oFLk8sI5j4HAFlxLxf7fqbsdnX+I0ymf2H3
         BzvQeZepMjsfBRhHrtY0ItH//IYrmbkom1d1MEs6i58iXaADIiRw+EWw3X3kiq+OplEM
         rJ5Bo6hej043rszQluewuElSB2TJB7XRwkeeCLHCfIykZZG9jxVWvvp/ryK72PRbpcS3
         56IKFLLyUJ389sBkzZ+B8xCNsALfOXNTMEnoPeJXWUZ3vaSvuTVOEdC8HpEqV7Gr7G0C
         5zLlAD83muewOLVbsd3qxdzqGBA4reFPSVpjcFzZetWz9wQnw0cPL8J4UR9w5Z9dUo3o
         x6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753391654; x=1753996454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DanjK+ayaBqr/ziqIDwxf4KxKx2IqkL+inWPjL3pAGk=;
        b=sl8zV05FfXDTHdlop4S5SNaZXBCiKzI3FbVBVVUbgVp/8bIuq4Yu1PSoIxURblD4mN
         2MwEK3kviEZvitG0J9HRj1cqiYQf55zO2ISp5UG8ySoQE7n7zjT+nvqYSqfpqYtNra3H
         GtY2F0nNRsQkQC5tMIQPoBN/wE5zD2icYqjmcgBrz+5Dp51qerc6voGCBsyqVxmwkdRm
         JuAzDECG5u2mroOcWei7LcFUxWu8UQvQr9ooT13C9Fi9MBz/iKzAOHuB3+rhLrJKjpTf
         cueR5kq5Ogh38Enstxn24Ca7134dqRK01g7Ud+4Olk5tsEWBAxTHAnFWapiTYFReD1p8
         HAYg==
X-Gm-Message-State: AOJu0Yxs8jN5tU94eKU6kzxAWxVyKHepXxtfsOUSlJd5o08FKXbsliOk
	pBHNYaZ1AnTHZR+ydLC4Qq6QeeH4h/mrbA3N8zK/N3VoMGqsHnRPFNip
X-Gm-Gg: ASbGncstcShcnjwZEVlUzHFP80xUdc/QogdrFPqb5Klav0fYfGeyi7WiHmCGumIwsLK
	KXpNstOtnXGJryeYrkSbASlcVqSyrlq1Z7lomFcIGtwffJriGETcOPs4sZj/yXtJabMufIJSNKg
	7axB10q6Horiypes1VLwEQ61M+AqUrvsEWptaZ7KAT7tROcq9HkHLUG4lWPSjjIrVPwzDvu/MNJ
	I0MnpkuHtUhwcAe9Bk4orsYyg6vTDFrCDpcs6N9fLzFgj5PuhV3ckWze9ZU/qlPD/V6ccXS34zT
	4grfZ45aMr8ba+v6SGuy82vJZBFb/pOQ3arURboNmgEzCM+7Oa7pQeEmsZKfqwkPHGHhYw8Wsw5
	5vnteHjM+GpkhvGJ8KCTIFpUucsiN5zeFgj1w4OUiWUJ37drKSuMAWTPSLsXYtaDpayBo8pOzG5
	xzhw==
X-Google-Smtp-Source: AGHT+IGrsFAZrDDdZpr8TpLjR1F6finp5kcpRhIqd1S4HINMtBCCNDixBbsAWAMUYwKcVgWJK+WFwA==
X-Received: by 2002:a05:6a00:228a:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-76034c00474mr11415875b3a.1.1753391653816;
        Thu, 24 Jul 2025 14:14:13 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7622833c9e2sm1763603b3a.21.2025.07.24.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:14:13 -0700 (PDT)
Message-ID: <d47b541e48002d8edfc8331183c4617fb3d74f8a.camel@gmail.com>
Subject: Re: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort
 support
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Mohsin Bashir
	 <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com, 
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com,  horms@kernel.org, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, sdf@fomichev.me,  aleksander.lobakin@intel.com,
 ast@kernel.org, daniel@iogearbox.net,  hawk@kernel.org,
 john.fastabend@gmail.com
Date: Thu, 24 Jul 2025 14:14:11 -0700
In-Reply-To: <aIEdS6fnblUEuYf5@boxer>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
	 <20250723145926.4120434-6-mohsin.bashr@gmail.com> <aIEdS6fnblUEuYf5@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 19:35 +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 23, 2025 at 07:59:22AM -0700, Mohsin Bashir wrote:
> > Add basic support for attaching an XDP program to the device and suppor=
t
> > for PASS/DROP/ABORT actions.
> > In fbnic, buffers are always mapped as DMA_BIDIRECTIONAL.
> >=20
> > Testing:
> >=20
> > Hook a simple XDP program that passes all the packets destined for a
> > specific port
> >=20
> > iperf3 -c 192.168.1.10 -P 5 -p 12345
> > Connecting to host 192.168.1.10, port 12345
> > [  5] local 192.168.1.9 port 46702 connected to 192.168.1.10 port 12345
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [SUM]   1.00-2.00   sec  3.86 GBytes  33.2 Gbits/sec    0
> >=20
> > XDP_DROP:
> > Hook an XDP program that drops packets destined for a specific port
> >=20
> >  iperf3 -c 192.168.1.10 -P 5 -p 12345
> > ^C- - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval           Transfer     Bitrate         Retr
> > [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec    0       sender
> > [SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec            receiver
> > iperf3: interrupt - the client has terminated
> >=20
> > XDP with HDS:
> >=20
> > - Validate XDP attachment failure when HDS is low
> >    ~] ethtool -G eth0 hds-thresh 512
> >    ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> >    ~] Error: fbnic: MTU too high, or HDS threshold is too low for singl=
e
> >       buffer XDP.
> >=20
> > - Validate successful XDP attachment when HDS threshold is appropriate
> >   ~] ethtool -G eth0 hds-thresh 1536
> >   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
> >=20
> > - Validate when the XDP program is attached, changing HDS thresh to a
> >   lower value fails
> >   ~] ethtool -G eth0 hds-thresh 512
> >   ~] netlink error: fbnic: Use higher HDS threshold or multi-buf capabl=
e
> >      program
> >=20
> > - Validate HDS thresh does not matter when xdp frags support is
> >   available
> >   ~] ethtool -G eth0 hds-thresh 512
> >   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_mb_12345.o sec xdp.frags
> >=20
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> > ---
> >  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 11 +++
> >  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 35 +++++++
> >  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +
> >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 95 +++++++++++++++++--
> >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
> >  5 files changed, 140 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/=
net/ethernet/meta/fbnic/fbnic_ethtool.c
> > index 84a0db9f1be0..d7b9eb267ead 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > @@ -329,6 +329,17 @@ fbnic_set_ringparam(struct net_device *netdev, str=
uct ethtool_ringparam *ring,
> >  		return -EINVAL;
> >  	}
> > =20
> > +	/* If an XDP program is attached, we should check for potential frame
> > +	 * splitting. If the new HDS threshold can cause splitting, we should
> > +	 * only allow if the attached XDP program can handle frags.
> > +	 */
> > +	if (fbnic_check_split_frames(fbn->xdp_prog, netdev->mtu,
> > +				     kernel_ring->hds_thresh)) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Use higher HDS threshold or multi-buf capable program");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (!netif_running(netdev)) {
> >  		fbnic_set_rings(fbn, ring, kernel_ring);
> >  		return 0;
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/n=
et/ethernet/meta/fbnic/fbnic_netdev.c
> > index d039e1c7a0d5..0621b89cbf3d 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> > @@ -504,6 +504,40 @@ static void fbnic_get_stats64(struct net_device *d=
ev,
> >  	}
> >  }
> > =20
> > +bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
> > +			      u32 hds_thresh)
> > +{
> > +	if (!prog)
> > +		return false;
> > +
> > +	if (prog->aux->xdp_has_frags)
> > +		return false;
> > +
> > +	return mtu + ETH_HLEN > hds_thresh;
> > +}
> > +
> > +static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf=
)
> > +{
> > +	struct bpf_prog *prog =3D bpf->prog, *prev_prog;
> > +	struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +
> > +	if (bpf->command !=3D XDP_SETUP_PROG)
> > +		return -EINVAL;
> > +
> > +	if (fbnic_check_split_frames(prog, netdev->mtu,
> > +				     fbn->hds_thresh)) {
> > +		NL_SET_ERR_MSG_MOD(bpf->extack,
> > +				   "MTU too high, or HDS threshold is too low for single buffer XD=
P");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	prev_prog =3D xchg(&fbn->xdp_prog, prog);
> > +	if (prev_prog)
> > +		bpf_prog_put(prev_prog);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct net_device_ops fbnic_netdev_ops =3D {
> >  	.ndo_open		=3D fbnic_open,
> >  	.ndo_stop		=3D fbnic_stop,
> > @@ -513,6 +547,7 @@ static const struct net_device_ops fbnic_netdev_ops=
 =3D {
> >  	.ndo_set_mac_address	=3D fbnic_set_mac,
> >  	.ndo_set_rx_mode	=3D fbnic_set_rx_mode,
> >  	.ndo_get_stats64	=3D fbnic_get_stats64,
> > +	.ndo_bpf		=3D fbnic_bpf,
> >  	.ndo_hwtstamp_get	=3D fbnic_hwtstamp_get,
> >  	.ndo_hwtstamp_set	=3D fbnic_hwtstamp_set,
> >  };
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/n=
et/ethernet/meta/fbnic/fbnic_netdev.h
> > index 04c5c7ed6c3a..bfa79ea910d8 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> > @@ -18,6 +18,8 @@
> >  #define FBNIC_TUN_GSO_FEATURES		NETIF_F_GSO_IPXIP6
> > =20
> >  struct fbnic_net {
> > +	struct bpf_prog *xdp_prog;
> > +
> >  	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
> >  	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
> > =20
> > @@ -104,4 +106,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_=
device *netdev,
> >  int fbnic_phylink_get_fecparam(struct net_device *netdev,
> >  			       struct ethtool_fecparam *fecparam);
> >  int fbnic_phylink_init(struct net_device *netdev);
> > +
> > +bool fbnic_check_split_frames(struct bpf_prog *prog,
> > +			      unsigned int mtu, u32 hds_threshold);
> >  #endif /* _FBNIC_NETDEV_H_ */
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net=
/ethernet/meta/fbnic/fbnic_txrx.c
> > index 71af7b9d5bcd..486c14e83ad5 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > @@ -2,17 +2,26 @@
> >  /* Copyright (c) Meta Platforms, Inc. and affiliates. */
> > =20
> >  #include <linux/bitfield.h>
> > +#include <linux/bpf.h>
> > +#include <linux/bpf_trace.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/pci.h>
> >  #include <net/netdev_queues.h>
> >  #include <net/page_pool/helpers.h>
> >  #include <net/tcp.h>
> > +#include <net/xdp.h>
> > =20
> >  #include "fbnic.h"
> >  #include "fbnic_csr.h"
> >  #include "fbnic_netdev.h"
> >  #include "fbnic_txrx.h"
> > =20
> > +enum {
> > +	FBNIC_XDP_PASS =3D 0,
> > +	FBNIC_XDP_CONSUME,
> > +	FBNIC_XDP_LEN_ERR,
> > +};
> > +
> >  enum {
> >  	FBNIC_XMIT_CB_TS	=3D 0x01,
> >  };
> > @@ -877,7 +886,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vec=
tor *nv, u64 rcd,
> > =20
> >  	headroom =3D hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
> >  	frame_sz =3D hdr_pg_end - hdr_pg_start;
> > -	xdp_init_buff(&pkt->buff, frame_sz, NULL);
> > +	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
> >  	hdr_pg_start +=3D (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
> >  			FBNIC_BD_FRAG_SIZE;
> > =20
> > @@ -966,6 +975,38 @@ static struct sk_buff *fbnic_build_skb(struct fbni=
c_napi_vector *nv,
> >  	return skb;
> >  }
> > =20
> > +static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
> > +				     struct fbnic_pkt_buff *pkt)
> > +{
> > +	struct fbnic_net *fbn =3D netdev_priv(nv->napi.dev);
> > +	struct bpf_prog *xdp_prog;
> > +	int act;
> > +
> > +	xdp_prog =3D READ_ONCE(fbn->xdp_prog);
> > +	if (!xdp_prog)
> > +		goto xdp_pass;
>=20
> Hi Mohsin,
>=20
> I thought we were past the times when we read prog pointer per each
> processed packet and agreed on reading the pointer once per napi loop?

This is reading the cached pointer from the netdev. Are you saying you
would rather have this as a stack pointer instead? I don't really see
the advantage to making this a once per napi poll session versus just
reading it once per packet.

>=20
> > +
> > +	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
> > +		return ERR_PTR(-FBNIC_XDP_LEN_ERR);
>=20
> when can this happen and couldn't you catch this within ndo_bpf? i suppos=
e
> it's related to hds setup.

I was looking over the code and really the MTU is just a suggestion for
what size packets we can expect to receive. The MTU doesn't guarantee
the receive size, it is just the maximum transmission unit and
represents the minimum frame size we should support.

Much like what I did on the Intel NICs back in the day we can receive
up to the maximum frame size in almost all cases regardless of MTU
setting. Otherwise we would have to shut down the NIC and change the
buffer allocations much like we used to do on the old drivers every
time you changed the MTU.

