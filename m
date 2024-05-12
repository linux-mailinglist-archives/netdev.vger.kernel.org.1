Return-Path: <netdev+bounces-95761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F48C35C3
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3356D1C20895
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027EA14F98;
	Sun, 12 May 2024 08:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4F1799D
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503702; cv=none; b=ntTIpONDq9ot/HgsoBsouiWKvmu54T5ifDCNl/xheA2KDhV7WEQdyKu/pm8QKmDdf5tCqtC//3I8AhdLGvoFEKRKBVA2qFLR4J/X38UmReP/QTzbbqJwrav8YeQ5FGkc+MmGfHEj4mbGcn8RDZ1mZPTAiaYkQ0OlMUt4S4Up8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503702; c=relaxed/simple;
	bh=L1+9SGet2FCjPzTbhfdEntJfl/jxD2PCO5PiCf3yrbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=erase50dyyMGg2RFFMHvlMFUjCYEVTX6cZWrO6w5P/X0mqcx2HS2yNj77D5g26XigyZ/qkWVcwbOznB9EtEkuDDto7qJL6Hnp+Lk7opQLp6NrQPDAYPhCaz6rse3Uqi9BFADyO0EWSgplpqkBttFGROvBTSDXCQ3irb8K8b60Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-K7DuA1rXNIK-OuT1YmICtQ-1; Sun, 12 May 2024 04:48:01 -0400
X-MC-Unique: K7DuA1rXNIK-OuT1YmICtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DB6F101A54F;
	Sun, 12 May 2024 08:48:00 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 87DAD105480A;
	Sun, 12 May 2024 08:47:59 +0000 (UTC)
Date: Sun, 12 May 2024 10:47:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 12/24] ovpn: store tunnel and transport
 statistics
Message-ID: <ZkCCPvzuRED57RKL@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-13-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-13-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:25 +0200, Antonio Quartulli wrote:
> Byte/packet counters for in-tunnel and transport streams
> are now initialized and updated as needed.
>=20
> To be exported via netlink.
>=20
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/Makefile |  1 +
>  drivers/net/ovpn/io.c     | 10 ++++++++
>  drivers/net/ovpn/peer.c   |  3 +++
>  drivers/net/ovpn/peer.h   | 13 +++++++---
>  drivers/net/ovpn/stats.c  | 21 ++++++++++++++++
>  drivers/net/ovpn/stats.h  | 52 +++++++++++++++++++++++++++++++++++++++

What I'm seeing in this patch are "success" counters. I don't see any
stats for dropped packets that would help the user figure out why
their VPN isn't working, or why their CPU is burning up decrypting
packets that don't show up on the host, etc. You can guess there are
issues by subtracting the link and vpn stats, but that's very limited.

For example:
 - counter for packets dropped during the udp encap/decap
 - counter for failed encrypt/decrypt (especially failed decrypt)
 - counter for replay protection failures
 - counter for malformed packets

Maybe not a separate counter for each of the prints you added in the
rx/tx code, but at least enough of them to start figuring out what's
going on without enabling all the prints and parsing dmesg.


> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index da41d711745c..b5ff59a4b40f 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -10,14 +10,15 @@
>  #ifndef _NET_OVPN_OVPNPEER_H_
>  #define _NET_OVPN_OVPNPEER_H_
> =20
> +#include <linux/ptr_ring.h>
> +#include <net/dst_cache.h>
> +#include <uapi/linux/ovpn.h>
> +
>  #include "bind.h"
>  #include "pktid.h"
>  #include "crypto.h"
>  #include "socket.h"
> -
> -#include <linux/ptr_ring.h>
> -#include <net/dst_cache.h>
> -#include <uapi/linux/ovpn.h>
> +#include "stats.h"

Header reshuffling got squashed into the wrong patch?


> diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
> new file mode 100644
> index 000000000000..5134e49c0458
> --- /dev/null
> +++ b/drivers/net/ovpn/stats.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:=09James Yonan <james@openvpn.net>
> + *=09=09Antonio Quartulli <antonio@openvpn.net>
> + *=09=09Lev Stipakov <lev@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNSTATS_H_
> +#define _NET_OVPN_OVPNSTATS_H_
> +
> +//#include <linux/atomic.h>
> +//#include <linux/jiffies.h>

Forgot a clean up before posting? :)

--=20
Sabrina


