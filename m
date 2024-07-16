Return-Path: <netdev+bounces-111657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1418793201C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CE21C20F38
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A91799D;
	Tue, 16 Jul 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8C56ney"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C8117556
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108229; cv=none; b=dqaTlcpsJ/nkopqvZ6FoffjuJ1jBIzP8H/66IJGSS8bOo+UtcaFaJbe3+LYeIZweFBYymxA684T1sB3/t3ip5y/0uHq3nT/QWXe0d3YSz91gCVfhtwF2SvpuBUkQZPRJe6ux5vLfeNI+/ZzhhwlvV3gQzUq8UusSgKuapeOEcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108229; c=relaxed/simple;
	bh=Kl/P8dj4erP5psRrU5JHk8ZuvNWK29/OZpNWH4UcJmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOQilxnosfYxEc0VSzdjvhNzcEQjRxmJBvU4dRlgt86QOoxp77t1rKdje0MkLgv/ApnroDCtyGQpyPbtbuSmJfwLsC1vA8oDUDLbqyszQKHexNlXZRL4BrK73N64/p87iyT4X+Tq3R8g4s/5ngLu/bBj167BPTpovisNqTXARnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8C56ney; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721108226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJmq0ffAJ9rllao95KkJkkpr4BEdLqsz6YbKu4qKpl0=;
	b=S8C56neyOwDBsRbSEhPAAYSDdYFhCGfawh8pGEsM0GXLxA8Izy8NpQXNj9tSo17goHW/lA
	a/dVZWlgJe3woZSicl+gffp5dTtg3TyK2QK2KIq75NSrvOXSWiMJow2eXGY9DRBqyRQq3M
	d+JT6UNCpN/AmxJbLe1crwwysyGLVSA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614--g8O2cycNMCjr0g63D-4yw-1; Tue, 16 Jul 2024 01:37:04 -0400
X-MC-Unique: -g8O2cycNMCjr0g63D-4yw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc3fb02c1cso1247255ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 22:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721108223; x=1721713023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJmq0ffAJ9rllao95KkJkkpr4BEdLqsz6YbKu4qKpl0=;
        b=eeZ5Q8hMPJwFN945D+3+tuoEUXR7PtnQyI9JWx84cL2pzrKinN0ylzUVj4AaGR0Gai
         WBwBahnPEOwJErzL3Tf9ze+ZCzCf+iDJRzO8FnvhyDUVagF7VDYPDMRMJIi+92GFilfb
         gjFhLvLW417wREaX7NFM8o7F9h+//bFyLCGo1NvqtFXSjTK3upmqBPwhDaiSvQbFdPgY
         hze3CqEeeKBi5x64JJwbIPdakci7GPcZkT09VD1HXvzXmcMnjK9Wk3e8WvdxAwJv1/ja
         hw2rycsj4Z5e2Ywh+jNpJ0jCwEopgzb5G5gvdaCrDMrL0Fvpio3VkhPgufYQRhrzdwjN
         tXjg==
X-Forwarded-Encrypted: i=1; AJvYcCX7SKTJaGFwWJEYnJYGjunLSLWou8r36KNOScjghdNWqv5c+iMSmoPvnOoSdw8IJ6fFHWFW/QUt7Jfxx34qo4uED9McOb5T
X-Gm-Message-State: AOJu0YzqBjBzsKIptq08Gtge3k1E8QSOtuEOnhAc1QK5RnMJyMGTz5PE
	tcjcmaeYJEbpUdbCEGcSa79aZ8G1TwhLDRymZf/7/7gl1qrjX3RK8F+3PHDx/Ssdvp2l/26nE0p
	A3L6GKIHb5dsuubllnmmna9hcLwJOFwt6AuPE0enstJZhIQNqqn1nN7IPJbJi9cPLFR9NEWoLCz
	vS+Zzy99kEVVs3Q5ucWlnW1IA5a14G
X-Received: by 2002:a17:902:da8a:b0:1fb:a077:a843 with SMTP id d9443c01a7336-1fc3da0a5d7mr7448905ad.60.1721108223427;
        Mon, 15 Jul 2024 22:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0bXOPZdGgTyNzubWE/m24JG4KQBoxQ4BegsFejOsHCLL/sh5ORAhYd96cUiSiNYMqlOEcTj5jruBcLFR0irU=
X-Received: by 2002:a17:902:da8a:b0:1fb:a077:a843 with SMTP id
 d9443c01a7336-1fc3da0a5d7mr7448745ad.60.1721108222712; Mon, 15 Jul 2024
 22:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com>
In-Reply-To: <20240716011349.821777-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jul 2024 13:36:51 +0800
Message-ID: <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 9:14=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using a VDPA device, it is important to ensure that the MAC address
> in the hardware matches the MAC address from the QEMU command line.
>
> There are only two acceptable situations:
> 1. The hardware MAC address is the same as the MAC address specified in t=
he QEMU
> command line, and both MAC addresses are not 0.
> 2. The hardware MAC address is not 0, and the MAC address in the QEMU com=
mand line is 0.
> In this situation, the hardware MAC address will overwrite the QEMU comma=
nd line address.

If this patch tries to do the above two, I'd suggest splitting it into
two patches.

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..8f79785f59 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *vdev,=
 uint8_t *config)
>           * correctly elsewhere - just not reported by the device.
>           */
>          if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> -            info_report("Zero hardware mac address detected. Ignoring.")=
;
> -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> +          error_report("Zero hardware mac address detected in vdpa devic=
e. "
> +                       "please check the vdpa device!");

I had two questions:

1) any reason to do this check while the guest is running?
2) I think we need a workaround for this, unless I miss something.

>          }
>
>          netcfg.status |=3D virtio_tswap16(vdev,
> @@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(DeviceLi=
stener *listener,
>      /* failover_primary_hidden is set during feature negotiation */
>      return qatomic_read(&n->failover_primary_hidden);
>  }
> +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
> +                                      MACAddr *cmdline_mac, Error **errp=
) {
> +  struct virtio_net_config hwcfg =3D {};
> +  static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
>
> +  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, ETH_A=
LEN);
> +
> +  /* For VDPA device: Only two situations are acceptable:
> +   * 1.The hardware MAC address is the same as the QEMU command line MAC
> +   *   address, and both of them are not 0.
> +   * 2.The hardware MAC address is NOT 0, and the QEMU command line MAC =
address
> +   *   is 0.

Did you mean -device virtio-net-pci,macaddr=3D0 ? Or you mean mac
address is not specified in the qemu command line?

> In this situation, the hardware MAC address will overwrite the QEMU
> +   *   command line address.
> +   */
> +
> +  if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> +    if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0) ||
> +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> +      /* overwrite the mac address with hardware address*/
> +      memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> +      memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> +
> +      return true;
> +    }
> +  }
> +  error_setg(errp, "vdpa hardware mac !=3D the mac address from "
> +                   "qemu cmdline, please check the the vdpa device's set=
ting.");
> +
> +  return false;
> +}
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIONet *n =3D VIRTIO_NET(dev);
>      NetClientState *nc;
> +    MACAddr macaddr_cmdline;
>      int i;
>
>      if (n->net_conf.mtu) {
> @@ -3692,6 +3722,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_net_add_queue(n, 0);
>
>      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
> +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>      n->status =3D VIRTIO_NET_S_LINK_UP;
> @@ -3739,10 +3770,10 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>      nc->rxfilter_notify_enabled =3D 1;
>
>     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> -        struct virtio_net_config netcfg =3D {};
> -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> -        vhost_net_set_config(get_vhost_net(nc->peer),
> -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONT=
END);
> +     if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline, errp)) {
> +       virtio_cleanup(vdev);
> +       return;
> +     }
>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> --
> 2.45.0
>

Thanks


