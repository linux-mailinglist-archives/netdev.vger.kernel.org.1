Return-Path: <netdev+bounces-111662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8B93203F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138351C210C3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18617C64;
	Tue, 16 Jul 2024 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVTw0ri8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75B18C31
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721109665; cv=none; b=NdRzPqbxhduhhzmXoen3eijyOIsWamU+woV1ejm675O2+yNmRMqcU6tf6kCuGlzZ9p3DiABQU8Tvx03BqZOUYuxMIXRDAGX9NWjaUr/PXfahf+1G0Iw8dSxG40NQecW5k1dL1XvLrkYeVar0QS2IPRJm5atba/iEhA79jJBh3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721109665; c=relaxed/simple;
	bh=STNyKbirUVd+tX0PFw4Wo2hXG1vWn8CYG+GHldC7+P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abykN3lPaR3LsfHg/C4mduSzKDwwb2Kri4yMoI/Wudfue8yBjibfm8c/sl+fo19nNG3mCNI0+s5iK2DXi3R14B7aF5WsSK9zCqJmQTugEzjqDCRkOlNKOMEu9j0IPi8oTKHcZvIvVZdiENH36DULakjgivuZWRkKjGrIUJlslqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVTw0ri8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721109662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCezvo/IWqfhQQZ8gqAJsIgy0jiUE88RwirGcIovuKY=;
	b=dVTw0ri8Xisx7vofQZsXf/u7JNdheIga9a9y0Qy4XKBYT/ECUXTazX6cQ87XiVEhtZpxqd
	mZNgm/BdjxiFd04SJd9lNE0RrgtF/5uLY/nHaA5yp7yWCOIH1FFHkIyeG/0hSSy1Hx3IKk
	7AXIJQsKarboJFetH8qByDKBRfxYTII=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-jOQy4JVgNLOcD1qLLwXXvQ-1; Tue, 16 Jul 2024 02:00:57 -0400
X-MC-Unique: jOQy4JVgNLOcD1qLLwXXvQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58d7b8f1e1bso6968954a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 23:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721109656; x=1721714456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCezvo/IWqfhQQZ8gqAJsIgy0jiUE88RwirGcIovuKY=;
        b=azphsVHDYWdnzS1FgrcPvnll+o6pcwyNaFy5toCYX3csebzEgqQwsqWKMy4QLvBej4
         kqWqe4ttZ0BKsNMirXjKQ0uTA+uVBfMAb36KYOfqsX78I9vuWVKioF/gRrFfLiHxB2iX
         XTuYgDz8ZnIzaROnWgswt6h+ncCprJcro/fSkfdzbAvVG3QM0yDSnKyizI1GfVT8f+k7
         ueEgkuEw3Erwx144eknuEqMIxoW720RTNAu+lw0PwjsMHDAavUtPOvV5HZqMAom4bMhT
         Q6aUBelQAPAF5yhhw9JZvFjhhFvcRKrvDr0LdFRR7JI9c9URpeTZzV+Hpie+8xfedYAG
         Wnug==
X-Forwarded-Encrypted: i=1; AJvYcCVwA175Datgw5l0qwH+MBIrHi1NNcbmIHxm8uPxe5VqmIBy1T6Lw5JqC8ESGHvF4KZJf2hSCqpOPI9G2TTdYQg4mHUuOqg+
X-Gm-Message-State: AOJu0Yy/GLcpJBFW07y9ogeETm1QocQRaspOju1hZ+EOKny3m+NmmC6B
	3krcVIJtaCHKnvadXG/CsQNTD1TTpmr7lGeZYJgcJUGK7z93SamF4M41vYEszx5kmvmvljtIOgb
	utISkPJf1r7XyaIXl56i4Kh7TVYPcGMmTKUevY5UFORVXLc0NgJQKJwmhlvdAdRyHza1zuhawL8
	iaUg15wwiur0oO+j93OTWPzOZe/nvQ
X-Received: by 2002:a50:9ea3:0:b0:59c:1314:c3ae with SMTP id 4fb4d7f45d1cf-59f0b10ac97mr546901a12.10.1721109655784;
        Mon, 15 Jul 2024 23:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGUJJx9p6ngz14y27cL4E1JX4kq1lUnL0E1ilLllp89+53J8aichx7vik41Axs9V/Ixuop9vRQW2tm1JGX6IA=
X-Received: by 2002:a50:9ea3:0:b0:59c:1314:c3ae with SMTP id
 4fb4d7f45d1cf-59f0b10ac97mr546872a12.10.1721109655386; Mon, 15 Jul 2024
 23:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com> <CAPpAL=xKRjtAYPW9+sVfqnKR=ZOiThh+=XVEQb_aokD1WGKgAA@mail.gmail.com>
In-Reply-To: <CAPpAL=xKRjtAYPW9+sVfqnKR=ZOiThh+=XVEQb_aokD1WGKgAA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jul 2024 14:00:16 +0800
Message-ID: <CACLfguX7+e2_cbNcSET_kqkQvuB91drkG2Qw51Wr0Vm1tBu08g@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Lei Yang <leiyang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024 at 09:56, Lei Yang <leiyang@redhat.com> wrote:
>
> Hi Cindy
>
> If needed, QE can help test this MR before merging into the master branch=
.
>
> Best Regards
> Lei
>
sure=EF=BC=8C Really thanks for your help
thanks
cindy
>
> On Tue, Jul 16, 2024 at 9:14=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When using a VDPA device, it is important to ensure that the MAC addres=
s
> > in the hardware matches the MAC address from the QEMU command line.
> >
> > There are only two acceptable situations:
> > 1. The hardware MAC address is the same as the MAC address specified in=
 the QEMU
> > command line, and both MAC addresses are not 0.
> > 2. The hardware MAC address is not 0, and the MAC address in the QEMU c=
ommand line is 0.
> > In this situation, the hardware MAC address will overwrite the QEMU com=
mand line address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 37 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..8f79785f59 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *vde=
v, uint8_t *config)
> >           * correctly elsewhere - just not reported by the device.
> >           */
> >          if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> > -            info_report("Zero hardware mac address detected. Ignoring.=
");
> > -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> > +          error_report("Zero hardware mac address detected in vdpa dev=
ice. "
> > +                       "please check the vdpa device!");
> >          }
> >
> >          netcfg.status |=3D virtio_tswap16(vdev,
> > @@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(Device=
Listener *listener,
> >      /* failover_primary_hidden is set during feature negotiation */
> >      return qatomic_read(&n->failover_primary_hidden);
> >  }
> > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n=
,
> > +                                      MACAddr *cmdline_mac, Error **er=
rp) {
> > +  struct virtio_net_config hwcfg =3D {};
> > +  static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> >
> > +  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH=
_ALEN);
> > +
> > +  /* For VDPA device: Only two situations are acceptable:
> > +   * 1.The hardware MAC address is the same as the QEMU command line M=
AC
> > +   *   address, and both of them are not 0.
> > +   * 2.The hardware MAC address is NOT 0, and the QEMU command line MA=
C address
> > +   *   is 0. In this situation, the hardware MAC address will overwrit=
e the QEMU
> > +   *   command line address.
> > +   */
> > +
> > +  if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > +    if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0) ||
> > +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> > +      /* overwrite the mac address with hardware address*/
> > +      memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> > +      memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> > +
> > +      return true;
> > +    }
> > +  }
> > +  error_setg(errp, "vdpa hardware mac !=3D the mac address from "
> > +                   "qemu cmdline, please check the the vdpa device's s=
etting.");
> > +
> > +  return false;
> > +}
> >  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VirtIONet *n =3D VIRTIO_NET(dev);
> >      NetClientState *nc;
> > +    MACAddr macaddr_cmdline;
> >      int i;
> >
> >      if (n->net_conf.mtu) {
> > @@ -3692,6 +3722,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> >      virtio_net_add_queue(n, 0);
> >
> >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
> >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > @@ -3739,10 +3770,10 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
> >      nc->rxfilter_notify_enabled =3D 1;
> >
> >     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA) {
> > -        struct virtio_net_config netcfg =3D {};
> > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRO=
NTEND);
> > +     if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> > +       virtio_cleanup(vdev);
> > +       return;
> > +     }
> >      }
> >      QTAILQ_INIT(&n->rsc_chains);
> >      n->qdev =3D dev;
> > --
> > 2.45.0
> >
> >
>


