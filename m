Return-Path: <netdev+bounces-73240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FA85B909
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253B9285BA4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE50612C9;
	Tue, 20 Feb 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1XDDU4S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F01634FA
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424919; cv=none; b=cwthSmqXaaNIGizyfRNi+FMNJvt+QnD1oHVvhoec3XeBx0fINu7kGmCEoW72eGeEoHObUFD18vV3bw+/zj4vvOo7lG96QXCj7rcAdST+QGxlBX5mAIJrMyC+wwzE5ffSS/Y4gDFxOH8+iHKUv+rsWLwOPmcvxRsuVd4CAiS68tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424919; c=relaxed/simple;
	bh=zIFJbs7XMqHzpCmo6HQ6HENxAgz8LHP761LDGTO3TE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msqBIH5pP7h5kSrUGNhFFrDcDnJPD8V1uIao3XC1u5l4MrUh47urloabvpjrt0IcqBqG1PnJD5Eogd//EZE2igr5XNPlBDM7mkSaiXJymxb3O/euJ0qXJXor+0rojndU/TPCezypCj2brElX0F7vtMb3crN8lo3YP17f0UvQyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1XDDU4S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708424916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fJxaPpyLJf7A2Kkqqmzm8iCD2Gn7q/tI+d6bvr/91SU=;
	b=C1XDDU4SNyav+S0DgLBJbFjBIcyS/cTlgDl59/GZVeagiayvT7rG88Zs8+6ulr4RqAgDmH
	Mae0RIh99cYidquddQDWOS7aGP0s6q1LyqqGvLkA402SP46NfQztli90lG/BaHFsoy86uD
	sTmUsHVHz+LmTBs+6MBPt/GQoXioF1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-m0oxWR80MlmYbTCaAGFY7g-1; Tue, 20 Feb 2024 05:28:34 -0500
X-MC-Unique: m0oxWR80MlmYbTCaAGFY7g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d4961412bso336125f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 02:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424913; x=1709029713;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJxaPpyLJf7A2Kkqqmzm8iCD2Gn7q/tI+d6bvr/91SU=;
        b=eJTPTCBGJz9n77WDEZJTphaTA1pY4AmoAGqko5TP+RC1WyjEjjTYvgdZwvfv/1psIx
         AnOtTtzSUrqyb9yron0SQJHWEMYH7URJzgcIq50XneQZjlL2+2vI2c7vamypIFuH5T9s
         0IF2J8I2XprwPeu8ilTs304uijHt1IatvaFtIpY4ZAw+u1xGS86kvHckZ08uMQH40qmn
         Ed2y9OZvAKmMbrJmEZjUtj5TBEpAOEcwsEx32YVD/q3JAkGczHz02aA3jYSI4S0DVR7x
         vlbHXmea7Di6vMeXSSxNOjYalJBUVsYja9U/UWUjGKu+2DJJO+s8MP66Q1JKR3crKpjr
         IuPg==
X-Forwarded-Encrypted: i=1; AJvYcCWygkW3LoytIDDjtrsicTKwWuO7/pEV9uMleprAwv1jy2+6E4cewjrOcQpah9+1gFWyW7+Mr1uvd+XQRHtqpDaEKv4dTInz
X-Gm-Message-State: AOJu0Yypw5FLsT++DS8hOmPkLiiE88OAQa89Rz+WJrust7yJRIICAzWX
	IO6kMXiRpxzsq2aGy5+Bx5EIUgcuQzo+Mk2vxL2ONW10ipK9tERyAOxpHyHxtSlhHrFEZSXepwY
	M9h0JwfEnCi7toFmq10dFYQpHQ+cDZkchBAgKgQe4HANlVRe1dOoWKGlXacmW6g==
X-Received: by 2002:a5d:5a90:0:b0:33d:4921:6a6c with SMTP id bp16-20020a5d5a90000000b0033d49216a6cmr4062754wrb.1.1708424913324;
        Tue, 20 Feb 2024 02:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGLA7QpwW8fzEFCAH6yKmWVzpDoATIqm6qR4XTu5b6B2w/5qrs8Nhz1yw6kDQ8dnMMlQuxRQ==
X-Received: by 2002:a5d:5a90:0:b0:33d:4921:6a6c with SMTP id bp16-20020a5d5a90000000b0033d49216a6cmr4062743wrb.1.1708424912935;
        Tue, 20 Feb 2024 02:28:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id s8-20020adf9788000000b0033ae7d768b2sm13096121wrb.117.2024.02.20.02.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:28:32 -0800 (PST)
Message-ID: <fdd9b2ee30894cfe8d9829d7f86f3fc3a8c77a1e.camel@redhat.com>
Subject: Re: [PATCH net] net: ip_tunnel: do not adjust device headroom on
 xmit
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
Date: Tue, 20 Feb 2024 11:28:31 +0100
In-Reply-To: <20240216120144.24037-1-fw@strlen.de>
References: <20240216120144.24037-1-fw@strlen.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 13:01 +0100, Florian Westphal wrote:
> syzkaller triggered following kasan splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/f=
low_dissector.c:1170
> Read of size 1 at addr ffff88812fb4000e by task syz-executor183/5191
> [..]
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
>  skb_flow_dissect_flow_keys include/linux/skbuff.h:1514 [inline]
>  ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
>  __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
>  skb_get_hash include/linux/skbuff.h:1556 [inline]
>  ip_tunnel_xmit+0x1855/0x33c0 net/ipv4/ip_tunnel.c:748
>  ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
>  __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  neigh_connected_output+0x42c/0x5d0 net/core/neighbour.c:1592
>  ...
>  ip_finish_output2+0x833/0x2550 net/ipv4/ip_output.c:235
>  ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
>  ..
>  iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
>  ip_tunnel_xmit+0x1dbc/0x33c0 net/ipv4/ip_tunnel.c:831
>  ipgre_xmit+0x4a1/0x980 net/ipv4/ip_gre.c:665
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
>  ...
>=20
> The splat occurs because skb->data points past skb->head allocated
> area.  This is because neigh layer does:
>   __skb_pull(skb, skb_network_offset(skb));
>=20
> ... but skb_network_offset() returns a negative offset and
> __skb_pull() arg is unsigned.  IOW, we skb->data gets "adjusted"
> by a huge value.
>=20
> The negative value is returned because skb->head and skb->data distance i=
s
> more than 64k and skb->network_header (u16) has wrapped around.
>=20
> The bug is in the ip_tunnel infrastructure, which can cause
> dev->needed_headroom to increment ad infinitum.
>=20
> The syzkaller reproducer consists of packets getting routed via a gre
> tunnel, and route of gre encapsulated packets pointing at another (ipip)
> tunnel.  The ipip encapsulation finds gre0 as next output device.
>=20
> This results in the following pattern:
>=20
> 1). First packet is to be sent out via gre0.
> Route lookup found an output device, ipip0.
>=20
> 2).
> ip_tunnel_xmit for gre0 bumps gre0->needed_headroom based on the
> future output device, rt.dev->needed_headroom (ipip0).
>=20
> 3).
> ip output / start_xmit moves skb on to ipip0. which runs the same
> code path again (xmit recursion).
>=20
> 4).
> Routing step for the post-gre0-encap packet finds gre0 as output
> device to use for ipip0 encapsulated packet.
>=20
> tunl0->needed_headroom is then incremented based on the (already
> bumped) gre0 device headroom.
>=20
> This repeats for every future packet:
>=20
> gre0->needed_headroom gets inflated because previous packets'
> ipip0 step incremented rt->dev (gre0) headroom, and ipip0 incremented
> because gre0 needed_headroom was increased.
>=20
> For each subsequent packet, gre/ipip0->needed_headroom grows until
> post-expand-head reallocations result in a skb->head/data distance of
> more than 64k.
>=20
> Once that happens, skb->network_header (u16) wraps around when
> pskb_expand_head tries to make sure that skb_network_offset() is
> unchanged after the headroom expansion/reallocation.
>=20
> After this skb_network_offset(skb) returns a different (and
> negative) result post headroom expansion.
>=20
> The next trip to neigh layer (or anything else that would __skb_pull
> the network header) makes skb->data point to a memory location outside
> skb->head area.
>=20
> Remove this optimization.
>=20
> Alternative would be to cap the needed_headroom update to a reasonable
> upperlimit such as 256 to prevent growth.

I fear this will cause visible regression for tunnels in metadata mode:
the egress device should not be available at creation time, so the
guessed needed_headroom should be low. I recall (very old) performance
tests showing head reallocation as quite noticeable while traversing
tunnels.=20

I think enforcing the upper limit should be safer and hopefully not too
complex. We could use even an higher bound (say 512) as just need to
avoid 16bits overflow, right?

Thanks!

Paolo


