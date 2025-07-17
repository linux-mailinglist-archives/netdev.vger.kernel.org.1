Return-Path: <netdev+bounces-207949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82870B09223
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA73B115B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0B2F94AA;
	Thu, 17 Jul 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuaJBbmZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7572BCF75
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770805; cv=none; b=Cg2mbxQ158bOW6upjG2NSbyIWT0mu8aa52UEtjIP5wAE9M7dpwoVvfo/o8Xk3CjdNdq0RHT7oqv0XG1skJXItHcUvGMRZqlvXVeN5a3Sso97djWG7mSoCuMDFWZShkN/9QvBn3xdNr1bcJyGgcdxFHIPuMt8aaiunOUdG9AKHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770805; c=relaxed/simple;
	bh=7wu8QTEZHNz1gULv5Hv3MSmbT+2Byw1gmDUOPLJCVOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDNLb3Pa+lGPElkubaEqjuLCGOe6GocekBqHnHaa3D9M1JO7wC72tpOr1yeqdXDMAtN5FzO23GMnSVHsv0XnR6FMd0V1VcC2e1zmstqbkZV9/r6OjVN+D163TJQgL6P6Ft26tnBXw0hIA1RSESP0UJMSvvYoXKqEBYD1EJ30xVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuaJBbmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752770803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9AMbwwWld/6Yy3pcC72gJCfdHpZ0d8jOe3WOYIplHk=;
	b=GuaJBbmZDgMamoopjxdtfszSfkeoRtpi/JR7CetaLPBb6gK6ZNnYmyEb5hEW023xnQ5HmC
	xapXG1n/vjcYWYP9CWz5Bubf8f17tk7sOEKF3m395uk1f/7dFrjkvR+99RT4ugmQ3aGclL
	4/L6DuIDkXIONGj4v5WJRxpsCqvk0Tk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-7aj9jxGIM_ifhs_GqCcoeA-1; Thu, 17 Jul 2025 12:46:41 -0400
X-MC-Unique: 7aj9jxGIM_ifhs_GqCcoeA-1
X-Mimecast-MFC-AGG-ID: 7aj9jxGIM_ifhs_GqCcoeA_1752770800
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0ced7fa79so16026266b.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770800; x=1753375600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9AMbwwWld/6Yy3pcC72gJCfdHpZ0d8jOe3WOYIplHk=;
        b=C+aKco8JdyVC9ukR8Qudc8j/QwE11XL+3XcQdM/BnZOC1xZaWRELQORN/UMMcYRgGN
         LjMjAi9Is5qrwhKX4gfMb0sI/U2MPkeJ/UdVc2pVY4A3cxGHKkC2G+/oPkPrW9gAwzrc
         Q3BPh24Q1ET+bJIHbFztJ+31hOdC64R7UHIR08Vqn3yjHzFsF5qXDVLs9VU0qkp59d0W
         1uHN5HeLUVbEAQ2Qu8C6CWEXt4oYYuZyPyXQsFwCHXQm9lAGsmCyfvX3M9ZnK9kvMoAT
         MQIy33gcXsTtbYhX/Iey3tN5ebPyuK75dyJmqcdJVgGfXmL5U7c5nvc+EzT/+VGHVV1J
         +eDw==
X-Gm-Message-State: AOJu0YxCIoCVpbwFxAfLwFW1IKqsEhtEkwofbvHTzECePtWAT05iPecO
	wzi0GTo+KFpiCTEnHIvRlOCZQrtzHPDmwKJxyrfTtsTcNhVt8wGe9xn41vDbueXc4LRezKczUcw
	YX7dO2EFl2Sc9beepmSGrX170MUK4Nlf3PoKZQFSljVyAh79z9OyBHHlsbO2T2a6dc1yuXxsAFr
	k/r+zyHnguldDINhnMLbXXc1uVW0H1vFU2eVyHlmLeghg=
X-Gm-Gg: ASbGncvNVztIl+wNOtGugI7ryHxRiOiGeKxgeacU5Zwj72yrfNp8Q1LNmDS4sNV1M68
	CWnlg+9uINrMTmAbjtFqkARglfAwBgt7Qi98+OaDlkoH4G58HckArMrkgSMnyZWwLJRCkZHf9F2
	Fyms3HV5a9Mn/jp6v8aQg=
X-Received: by 2002:a17:907:1b03:b0:ade:328a:95d1 with SMTP id a640c23a62f3a-ae9c9b21003mr288974966b.10.1752770799807;
        Thu, 17 Jul 2025 09:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTjW4ce8hmC2NksUhSz3E2eZCErP36MU2mJYoolB4YhcKzFvYImUMHIqL+5v0hiRtXUVjIRV0QBxZRa4ZQFNg=
X-Received: by 2002:a17:907:1b03:b0:ade:328a:95d1 with SMTP id
 a640c23a62f3a-ae9c9b21003mr288973466b.10.1752770799260; Thu, 17 Jul 2025
 09:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618195240.95454-1-dechen@redhat.com>
In-Reply-To: <20250618195240.95454-1-dechen@redhat.com>
From: Dennis Chen <dechen@redhat.com>
Date: Thu, 17 Jul 2025 12:46:28 -0400
X-Gm-Features: Ac12FXzZHc4AoPSdI9mF2kRfJlEnVKTfV5Go-utLaKJ_FKfblhXqL8AuOc8dGWM
Message-ID: <CAOftDsEnyXZa8arEGL5pRa-0RvfwS5Tv7eb-uhOzCUAZcUxoAQ@mail.gmail.com>
Subject: Re: [PATCH net] i40e: report VF tx_dropped with tx_errors instead of tx_discards
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 3:52=E2=80=AFPM Dennis Chen <dechen@redhat.com> wro=
te:
>
> Currently the tx_dropped field in VF stats is not updated correctly
> when reading stats from the PF. This is because it reads from
> i40e_eth_stats.tx_discards which seems to be unused for per VSI stats,
> as it is not updated by i40e_update_eth_stats() and the corresponding
> register, GLV_TDPC, is not implemented[1].
>
> Use i40e_eth_stats.tx_errors instead, which is actually updated by
> i40e_update_eth_stats() by reading from GLV_TEPC.
>
> To test, create a VF and try to send bad packets through it:
>
> $ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
> $ cat test.py
> from scapy.all import *
>
> vlan_pkt =3D Ether(dst=3D"ff:ff:ff:ff:ff:ff") / Dot1Q(vlan=3D999) / IP(ds=
t=3D"192.168.0.1") / ICMP()
> ttl_pkt =3D IP(dst=3D"8.8.8.8", ttl=3D0) / ICMP()
>
> print("Send packet with bad VLAN tag")
> sendp(vlan_pkt, iface=3D"enp2s0f0v0")
> print("Send packet with TTL=3D0")
> sendp(ttl_pkt, iface=3D"enp2s0f0v0")
> $ ip -s link show dev enp2s0f0
> 16: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state U=
P mode DEFAULT group default qlen 1000
>     link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>              0       0      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>              0       0      0       0       0       0
>     vf 0     link/ether e2:c6:fd:c1:1e:92 brd ff:ff:ff:ff:ff:ff, spoof ch=
ecking on, link-state auto, trust off
>     RX: bytes  packets  mcast   bcast   dropped
>              0        0       0       0        0
>     TX: bytes  packets   dropped
>              0        0        0
> $ python test.py
> Send packet with bad VLAN tag
> .
> Sent 1 packets.
> Send packet with TTL=3D0
> .
> Sent 1 packets.
> $ ip -s link show dev enp2s0f0
> 16: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state U=
P mode DEFAULT group default qlen 1000
>     link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>              0       0      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>              0       0      0       0       0       0
>     vf 0     link/ether e2:c6:fd:c1:1e:92 brd ff:ff:ff:ff:ff:ff, spoof ch=
ecking on, link-state auto, trust off
>     RX: bytes  packets  mcast   bcast   dropped
>              0        0       0       0        0
>     TX: bytes  packets   dropped
>              0        0        0
>
> A packet with non-existent VLAN tag and a packet with TTL =3D 0 are sent,
> but tx_dropped is not incremented.
>
> After patch:
>
> $ ip -s link show dev enp2s0f0
> 19: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state U=
P mode DEFAULT group default qlen 1000
>     link/ether 3c:ec:ef:b7:e0:ac brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>              0       0      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>              0       0      0       0       0       0
>     vf 0     link/ether 4a:b7:3d:37:f7:56 brd ff:ff:ff:ff:ff:ff, spoof ch=
ecking on, link-state auto, trust off
>     RX: bytes  packets  mcast   bcast   dropped
>              0        0       0       0        0
>     TX: bytes  packets   dropped
>              0        0        2
>
> Fixes: dc645daef9af5bcbd9c ("i40e: implement VF stats NDO")
> Signed-off-by: Dennis Chen <dechen@redhat.com>
>     Link: https://www.intel.com/content/www/us/en/content-details/596333/=
intel-ethernet-controller-x710-tm4-at2-carlsville-datasheet.html
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers=
/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 88e6bef69342..2dbe38eb9494 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -5006,7 +5006,7 @@ int i40e_get_vf_stats(struct net_device *netdev, in=
t vf_id,
>         vf_stats->broadcast  =3D stats->rx_broadcast;
>         vf_stats->multicast  =3D stats->rx_multicast;
>         vf_stats->rx_dropped =3D stats->rx_discards + stats->rx_discards_=
other;
> -       vf_stats->tx_dropped =3D stats->tx_discards;
> +       vf_stats->tx_dropped =3D stats->tx_errors;
>
>         return 0;
>  }
> --
> 2.49.0
>
Hello,

Any update here?


Dennis Chen


