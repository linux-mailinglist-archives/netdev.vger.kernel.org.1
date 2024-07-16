Return-Path: <netdev+bounces-111643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232FB931E99
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A791F222E2
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948364A24;
	Tue, 16 Jul 2024 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDa62IKk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892733C0B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095006; cv=none; b=c8qPDU+9X0DFQeKfPTUY5xLoBAPSiNTWalr1zFAyavpeQzxFfexM0jjs4yFCaypyjnl+KaHdQo6J+v1SnyEMtt5QNs24s/HHrJweVUB4d9QXV/ArzXz7HCb1vHsR3q53FuFBRyn9+BjBpRtqlxjinDrn4vswEWAeyDsG3MxOKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095006; c=relaxed/simple;
	bh=mSa19N44q6gToAG51j/DW88NsG7/vNwA9Xumh+dh5GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKiW9Bq82Ty/8PQszuXtuCwVgLngYM+MOpYeyPCGnUL71uwI9132U2FymcsTp5On44XmHBrNfuXizPpf6jtV3fNqwmDS9oDlQxattrsGqb/oiIN1bPq1T7iSVYPW+4z9yVDsiMfc6DTUTeEJdmFtUCqAj+iJm7FdswK4om1dr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDa62IKk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721095003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9uRaA/pgUTohQkTocotLavEjg0G3cgh1Hl90+UeSE=;
	b=IDa62IKkzWHmX7lJhMfJBeM7wbZ7JA0pKKBQoxIzFXcu991XRgB60KfS1dY6kSrKFNMagG
	SdEj7V8jRCmrNuWfSp0F6PpF784EgvzfInx3XaOi4cdX9l705AjwanAIQHNdPqmrs0Keil
	muK0vvlHNRrkPxv9QQJEyai8NegIkbQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-c32EAQt2MqGw9UEqQjV_Og-1; Mon, 15 Jul 2024 21:56:41 -0400
X-MC-Unique: c32EAQt2MqGw9UEqQjV_Og-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a797c5b4f47so336177366b.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721095000; x=1721699800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ9uRaA/pgUTohQkTocotLavEjg0G3cgh1Hl90+UeSE=;
        b=Y+ws+XqsDshI/2P94YInDu2vS1JAoW4+k/KCagnNzRdsVmaRk7uHOdquMyAuafdMw+
         uF5Qiy+g5WO79pfXDcN43d9uhZ5HRCiIp1XdPyFxjC6jzIsWejNHZqySGrbf4QB82SjU
         g7wWtMBmdtiME0+5xdSlPpEfICF+ID1ZEECyYd8wRcnDqGaBq7QoCoWevYyhZd7XE0cQ
         ZWwNk5uzTvbWGMRaesjB9ObWUUQ5WHHfOxYVX57P3Ov3pYPgCm3kescUirNyrZaHwikv
         NQA1AkMbACYrUpA0G6/j/JxjGMt+pRmm3rZKaxj2AKrUvI00PELHR/u4rtnJY0v0tKMe
         43uw==
X-Forwarded-Encrypted: i=1; AJvYcCX/rVHGWuQHHyPxyZWK/EUn5Jw+IvQRKvgutxB5+xUf5BgNfx6OcvqEX6vIvY58hX8Be66LZgZH0+U1ZJGFB3YWEfEfzMQU
X-Gm-Message-State: AOJu0YywdaKwABjeUdZUs5Wq6pagxx2eD2bF7hkBm1aDRrI7VIro4xB0
	Dz0W//ozT8E1wWLgRV1WCDfdf2mzudhOEnY/bD7NclOJYV7NG3k0ekN5LH7UHJQsDIQ2Im2se+Y
	YIvDnzi5Uh2OPBfSrUsMHYz6PeX84kBVvrRiHY1hn/Vk3joUPYZpmyTdqdwaqb2Il1nUcAArXs3
	UrzLvG9axiLOrR0sNu2S5gzW8fLD4/
X-Received: by 2002:a17:906:c251:b0:a77:d52c:c431 with SMTP id a640c23a62f3a-a79ea437a59mr29231966b.22.1721095000338;
        Mon, 15 Jul 2024 18:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIlY9QdoGy1wvXGDzqvzgSlrEtvYJuX9YNa/bprVSKTIgkcYrp0DjzVKUwrkNd96+xSC0OHOUCNG9hJd/6q1c=
X-Received: by 2002:a17:906:c251:b0:a77:d52c:c431 with SMTP id
 a640c23a62f3a-a79ea437a59mr29231666b.22.1721094999978; Mon, 15 Jul 2024
 18:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com>
In-Reply-To: <20240716011349.821777-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 16 Jul 2024 09:56:03 +0800
Message-ID: <CAPpAL=xKRjtAYPW9+sVfqnKR=ZOiThh+=XVEQb_aokD1WGKgAA@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cindy

If needed, QE can help test this MR before merging into the master branch.

Best Regards
Lei


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
> +   *   is 0. In this situation, the hardware MAC address will overwrite =
the QEMU
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
>


