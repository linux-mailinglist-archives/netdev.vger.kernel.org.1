Return-Path: <netdev+bounces-111664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB593204F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6011F2219F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F31B947;
	Tue, 16 Jul 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhpDZJu7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7A1CD29
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721110184; cv=none; b=eGXUbzTP6qSMFehLx2gXzehXYX7e1t9oor6eWJbx/pWCSa4GzUsD6ynK2USmATmfgoDUs3kn09PaFecPsFDkk3vy+lsXW2kmPtxoqEAYTp1zfrWw9MNbv8IQw3SkUZZNY9jYpBYxmVQmcU1KBgSs695Tgk+DdtyuBBC4PL8pX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721110184; c=relaxed/simple;
	bh=PpbDIhdBn6cVOp8a849CIdbEM/DddAtxc3pSV1aov+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnLVmFmyK8QqD0ZEdITCrz03LyZ8yJ+3Q4l7TTsQSApYRg+CW48L5F5dt9cUroraqreWo+ZglgLyQB4Ai+81xI68BE8PhoKnhEckfuV0n8oyug5i9C9GswrwFrvig2WWwKJrHvdc9erB5Hq7S8Qv0XfLTxN63c33p2onRXSXnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhpDZJu7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721110180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCr4QOjbNAwVm0SUrjDdp3DhYqZ+zdG0bqY4x9ewhOo=;
	b=MhpDZJu70vAWrpJvkERrCzjNklDw8qML5OP0WvUy2GmCI3zUK3+L2AVZeiPSwv5d2h4frj
	i8Yqk96dYcK5Bny8BOiJBha1V3Hm8ZugVvKn/lKtPw9uTI9sSr3YDGb2UphkGwmoAGKc2i
	4reXOpW6ScUfM1/3ahNyN9362lI4GPc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-NbH-6ulTNpy1bUoJXq98ow-1; Tue, 16 Jul 2024 02:09:36 -0400
X-MC-Unique: NbH-6ulTNpy1bUoJXq98ow-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee86eda4e4so48110111fa.3
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 23:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721110175; x=1721714975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCr4QOjbNAwVm0SUrjDdp3DhYqZ+zdG0bqY4x9ewhOo=;
        b=VwoeNR0q2lC8J05mAf4+svw6XaglKbu8rInDgNmBhUu96a8x5UjeCY3h+o+yqArk7K
         rixqsfCAem5gWwEgSWy8Tc4kES0tNg5MY6hchUi+mfD9aLJEv8SOrzN0tKTaoLfTvzIP
         6jLRVsdli89ZZlyYJ43SCzu0HAX7OIS1z3CM7R0Mq52MQ8d2Lk/0A6b7fbuxK7KkjxMY
         e5j7WOi7f2YgUgJnXT/HsJuGaQzt0vRLaWPobSElT2Uqt2CEGo96W9AXErsU8UaQX7JV
         civ8wvKAu9jfyePUecuC7GnqvlRzmWbhv5re+5DsAS9eSLnIzTs8z7ho3joqJwJS9aPm
         nwaA==
X-Forwarded-Encrypted: i=1; AJvYcCU6uDaG1VDa8VJHRTvDJqd6t4gPcABSJ9mh6jIK9QBdpThIMOf3XYubCCeMRHJbOJmAhW8uml5yF0Ciw6T9qUNLMD6ViDKQ
X-Gm-Message-State: AOJu0YxmQ1bWat9YFk0zRnWzig7BrI/V8MoJmYWeDIrd6oImSYhMF8k1
	r+s/DohfFRTqx9hC8ZIyQeDt5AkcyL4a0yj5jLcVClvTIvVRgmydAk5Lw4CUlFF+suO6oz9YtFl
	vUAm1XJl/qxhdvA2ya8ajwQqrxF9LEaDHjOBD/kBJe5INXbu9Wk8hO3ZuTstBUUE+s2C6Udnt1D
	Qnn20DwrGU4Gp9gMnom2eeTp/Z2gm3
X-Received: by 2002:a2e:b38c:0:b0:2ee:7d37:498b with SMTP id 38308e7fff4ca-2eef418cd81mr6651571fa.14.1721110175117;
        Mon, 15 Jul 2024 23:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAwB3Rv5ly/janPFIozApu/7U95oDRWNxGH0c41tnTHx8NkeJK2tCxW6JunUGE3Zz5VJTKLyho/ALVAoDUrj4=
X-Received: by 2002:a2e:b38c:0:b0:2ee:7d37:498b with SMTP id
 38308e7fff4ca-2eef418cd81mr6651301fa.14.1721110174638; Mon, 15 Jul 2024
 23:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com> <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
In-Reply-To: <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jul 2024 14:08:56 +0800
Message-ID: <CACLfguXNyp1iM+FnxVTrLRntcNxhHpfciE=z6nhhBtWYRFSy9w@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024 at 13:37, Jason Wang <jasowang@redhat.com> wrote:
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
>
> If this patch tries to do the above two, I'd suggest splitting it into
> two patches.
>
This code is very simple. So I have put these two into one function.
thanks
cindy
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
>
> I had two questions:
>
> 1) any reason to do this check while the guest is running?
> 2) I think we need a workaround for this, unless I miss something.
>
this is a code change to adjust the new fix. If the mac address is 0
the guest should fail
to load. Maybe I can just assert fail here?
Thanks
cindy
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
> > +   *   is 0.
>
> Did you mean -device virtio-net-pci,macaddr=3D0 ? Or you mean mac
> address is not specified in the qemu command line?
>
yes, what I mean is mac address not specified, sorry for the confusion,
I will rewrite this part
Thanks
cindy

> > In this situation, the hardware MAC address will overwrite the QEMU
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
>
> Thanks
>


