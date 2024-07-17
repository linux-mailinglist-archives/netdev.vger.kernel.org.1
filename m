Return-Path: <netdev+bounces-111827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D89334F9
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 03:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800C61C21D17
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE36ED8;
	Wed, 17 Jul 2024 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBZ9pHwP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97103184F
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179556; cv=none; b=in3DWyEvcBvOlSym/XkykjiPuqEwo6cVO6IZIm5zYkcmTtGednS8nK2tagB8S4dyMWe33OJMAJc5bgneJq0o+ctrMZuCK+pq+e/LOwC5or0k1+OhMSIO8dQwsE6qiJ+fxNj2fStm2R7w9gvrNjGwfnnIYLQxv+zH5JHkN7AYl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179556; c=relaxed/simple;
	bh=eh3ya4Z3NOZv16kbsvLMMXw3e3QCiJrCHYzo6GSPADQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7qP1i5ncXOuwwwvW18A2Yt5GNgo6CuNHUMLAV+UGgmdNXnvfCJJCPbZdMMKcTCP6c2uVNwQ0XkqOr4sIQTIRHy6gndHGHPy/eLTVP3yoFG6eg1+P2OV0QYtHnvMcx93Vm16jPE7xhUQZ4U0qFfiM189UKdf1HjiXlXJKjJVLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBZ9pHwP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721179553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOXQFsF6zB29YXXgPZ87eKa8OHqfql6zyecjmBPcwwA=;
	b=iBZ9pHwPIuuGsDghB9aBxKptypnVUxJ6tfiu0FUtmNV9C7h//3VaGJUY4x7MWW1l0PJRxb
	tljJNBerxVwuRcPMLLj3ZSnjE8jg8QJPrki10Pu5UsLXTADrS4E66wBWuAb5B2ieRov8EA
	aI/I1ohXlCF+JJZK4DID0Di755Jhui8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146--yuxcCBwPICJsROJnfF_Fg-1; Tue, 16 Jul 2024 21:25:52 -0400
X-MC-Unique: -yuxcCBwPICJsROJnfF_Fg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70afbe5ddbbso3911746b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 18:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721179551; x=1721784351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOXQFsF6zB29YXXgPZ87eKa8OHqfql6zyecjmBPcwwA=;
        b=vaBbyvUU2ONllIbqH1aMoKCqpCEotEA8Akux+GvFVuH50I9HfmmkjpHVoYCb4yCsYb
         J30CPyTVk++SwVb2PRzz4Od++VxVU7PaEm5p+bNL4lWjYKFE5kigyv/QDz64C7ugznvk
         60GakvF/m/jWxU6kVpmE1WDtXC0DEyTUXTwKHtXDGKj86j47FTPLNGDpKlYLlbJIVCDU
         KY1ifrbqeYuGYNZGUzxjnVau+ghPAOkp/1CKtLbM5PZ5/nqOt2YQoQyKRNr9dwPFl4sq
         fvhGyTJJnORAsNmk4Vq5pPMzdcfwl49tnWgULokwePxuksLSktWG2R8YBgBCEWAnT8rU
         OdPA==
X-Forwarded-Encrypted: i=1; AJvYcCU/FNyWGbJ2nlUkaNEjdTDqYb/rGeq4vOsa/dAXCy283TKud9H4VqYA7r6dGsHduPcCCy7PA+KxRyOJWPTovUxliK25+pcM
X-Gm-Message-State: AOJu0YyKddcHg8dFRxEyJg/8RUffOJregempk8stlj7FGX/OdbkWexfa
	isPVPUvnMDQTfx4ZR+AeHj8Fx71/NUbleTZebcd2uCjQkfs3/zu1bouVArnS1qiWF5GKTz7zs7D
	InUlaExtr2fZSU+ii825iYLoRjcomuC0KC+8U/jJqaUlnXN7UIlvdO9ajNz/f63xVnmOK+mkVcJ
	2kpGQvBiGLSyOyEj946SFa6nK/HZ/w
X-Received: by 2002:a05:6a00:4b0d:b0:706:700c:7864 with SMTP id d2e1a72fcca58-70ce4d83920mr186144b3a.4.1721179550918;
        Tue, 16 Jul 2024 18:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2yRNLBA+F3ePgboAz9Ln08fTrEhXvP1D9RgyUmWNrXhVduXydfrWnFIU1gm4+73AtyAJL/wlcv4hOdin224E=
X-Received: by 2002:a05:6a00:4b0d:b0:706:700c:7864 with SMTP id
 d2e1a72fcca58-70ce4d83920mr186132b3a.4.1721179550470; Tue, 16 Jul 2024
 18:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716011349.821777-1-lulu@redhat.com> <CACGkMEszp7U-x7UeBy6vSGv0Hox8YBD0nmWK=DNpfx7F5xGZYw@mail.gmail.com>
 <CACLfguXNyp1iM+FnxVTrLRntcNxhHpfciE=z6nhhBtWYRFSy9w@mail.gmail.com>
In-Reply-To: <CACLfguXNyp1iM+FnxVTrLRntcNxhHpfciE=z6nhhBtWYRFSy9w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Jul 2024 09:25:39 +0800
Message-ID: <CACGkMEvxMuowCxxJHNVYr=Ro4cvYs3D3VD0+Ds+4EgD1s53Gcg@mail.gmail.com>
Subject: Re: [RFC v2] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:09=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, 16 Jul 2024 at 13:37, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jul 16, 2024 at 9:14=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > When using a VDPA device, it is important to ensure that the MAC addr=
ess
> > > in the hardware matches the MAC address from the QEMU command line.
> > >
> > > There are only two acceptable situations:
> > > 1. The hardware MAC address is the same as the MAC address specified =
in the QEMU
> > > command line, and both MAC addresses are not 0.
> > > 2. The hardware MAC address is not 0, and the MAC address in the QEMU=
 command line is 0.
> > > In this situation, the hardware MAC address will overwrite the QEMU c=
ommand line address.
> >
> > If this patch tries to do the above two, I'd suggest splitting it into
> > two patches.
> >
> This code is very simple. So I have put these two into one function.
> thanks

Better to split no matter how simple it is if there are two issues.

Btw, it's better to tell what kind of setup has been tested by this,
and do we need a fix tag here as well? (Or is this needed by -stable?)

> cindy
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/net/virtio-net.c | 43 +++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 37 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 9c7e85caea..8f79785f59 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -178,8 +178,8 @@ static void virtio_net_get_config(VirtIODevice *v=
dev, uint8_t *config)
> > >           * correctly elsewhere - just not reported by the device.
> > >           */
> > >          if (memcmp(&netcfg.mac, &zero, sizeof(zero)) =3D=3D 0) {
> > > -            info_report("Zero hardware mac address detected. Ignorin=
g.");
> > > -            memcpy(netcfg.mac, n->mac, ETH_ALEN);
> > > +          error_report("Zero hardware mac address detected in vdpa d=
evice. "
> > > +                       "please check the vdpa device!");
> >
> > I had two questions:
> >
> > 1) any reason to do this check while the guest is running?
> > 2) I think we need a workaround for this, unless I miss something.
> >
> this is a code change to adjust the new fix. If the mac address is 0
> the guest should fail
> to load. Maybe I can just assert fail here?

I mean get_config is usually called during VM running. It's not good
to assert here and can we move the check to realize or other place
before the VM is running?

> Thanks
> cindy
> > >          }
> > >
> > >          netcfg.status |=3D virtio_tswap16(vdev,
> > > @@ -3579,12 +3579,42 @@ static bool failover_hide_primary_device(Devi=
ceListener *listener,
> > >      /* failover_primary_hidden is set during feature negotiation */
> > >      return qatomic_read(&n->failover_primary_hidden);
> > >  }
> > > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet =
*n,
> > > +                                      MACAddr *cmdline_mac, Error **=
errp) {
> > > +  struct virtio_net_config hwcfg =3D {};
> > > +  static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> > >
> > > +  vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&hwcfg, E=
TH_ALEN);
> > > +
> > > +  /* For VDPA device: Only two situations are acceptable:
> > > +   * 1.The hardware MAC address is the same as the QEMU command line=
 MAC
> > > +   *   address, and both of them are not 0.
> > > +   * 2.The hardware MAC address is NOT 0, and the QEMU command line =
MAC address
> > > +   *   is 0.
> >
> > Did you mean -device virtio-net-pci,macaddr=3D0 ? Or you mean mac
> > address is not specified in the qemu command line?
> >
> yes, what I mean is mac address not specified, sorry for the confusion,
> I will rewrite this part
> Thanks
> cindy
>

Thanks


