Return-Path: <netdev+bounces-265371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBY0FLZBrmkDBQIAu9opvQ
	(envelope-from <netdev+bounces-265371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 04:42:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C011F2338F8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 04:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE809300E62E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D727FB1F;
	Mon,  9 Mar 2026 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb6FJSP4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="twDcs2F6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D727B32B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027760; cv=pass; b=OxtY5T9QwKr9U0nxr6Shxehm//mFr2XmD+rRfWCFfA/+LDNSYiEgt6eTpi2OD/ISPhUh/FOnWZDFBrWegvtDT9pj6PTKYbdyfClAovygws1CMyiQDYhe8qvY0jZJq2hex02Q2FxghA32Mh7f4i5l9F3sTZjfFa2+U75PuGpYUok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027760; c=relaxed/simple;
	bh=h59yI8Twx8xwQ62XEvBZjiCdd7nRoGrUhzZvhcRhIhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLBAnF4tL4HiKVWWUZ+9WTDvxODFPl/AfPfObEawV9IGzye4mKicRgFCwZDs4KObI9ks70i3dtZKNelcP3c60amoB2x6nGYJe4Y2+GeW03D/RniO8e6crpC7ngd2iYi8nDNjfwMirKp6Uvog+MllFK/sxIBEK9ls5DLpuag7fcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb6FJSP4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=twDcs2F6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773027757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6tbQG6ku1sTC/Bo8+JB48V19ro4mcVnhtT2Tfv1uWk=;
	b=gb6FJSP4pfx2rberXTbwlQF9SZXwuhn9NZAO25F8hAIZ2PfoxVmUL6GrMtE1lU6a8A/CRX
	D41lctAqxhHyIVh6OO+et+fprVyqQoD3034CiZzmC9Lsk48TBb5kdPX3hEm8a5y/9bx/Ar
	qGBcFmNsoMnd3fLrT+J+eGffFNPRWVM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-KLykq0MxM-Ol7NYiF-wuPw-1; Sun, 08 Mar 2026 23:42:36 -0400
X-MC-Unique: KLykq0MxM-Ol7NYiF-wuPw-1
X-Mimecast-MFC-AGG-ID: KLykq0MxM-Ol7NYiF-wuPw_1773027755
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so12749677a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 20:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773027755; cv=none;
        d=google.com; s=arc-20240605;
        b=ZaKWcjJtDsga5UK5mZ9cY7mVupKmeTG8gIQrdsl3rh1AphZoIxhuKs1cl0lxG3lINj
         7tUf+cnkEc51SZHdPiANukuQ+b1DbibvaIEVPvnWck1gwOWRg44/FwFJ7E8+Sz1Sm2/P
         s4a36E4OlylX7aXUt+e9wul+p6c9tPpQUHoXmLlAmYznDR0J4WYe4BqjZ1tbvkVE9Loi
         11veWmQsmBfAte0xLpQTTtUn2Jo1shaAUzXBONk+jp48qEUSdyyUUkj52LQ9tOlZJXAm
         u2Z4mw4GZcjd0CerRzR9i6yUZKeMzdvfyXyOVJHCi3yth1WWx5Ma4KFnNvBn/VcEiu19
         4u2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c6tbQG6ku1sTC/Bo8+JB48V19ro4mcVnhtT2Tfv1uWk=;
        fh=nyrCT6OxB+5bBegWBC5IAM66Rgfn3nEO6ml0Heu80jc=;
        b=HwjmGhyx2PVJQoFfaLLVhgZ/a+naolXpzhsicudROivzNlbuA3ZkJuLUNKTcQWvx7M
         eXQw8hy6APTUftr5zbwyrvrR3lOTrpsqRBK1+STXaxpwYIdRNe6xNbYCl+PGTG6woIkn
         VjEhaF/9oVM4PfqQyRSZhL012aRfI7Ba5oHw92r3ewF8yZLM/jNgDvSXvXo+hgu1VfQN
         EIyB3O0kxtJBMYU3mZBq8sU/ZBTPLdG81gYQkV3n8vZMAyP2lYwK0Rx9lQ7l1kOSb0N2
         3+vph/HH70kqFMUDfg31s/RPFA29fSvKAP2HwFYc7fgKAlp2lePvrDjeDNNg6PZeA1op
         /xOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773027755; x=1773632555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6tbQG6ku1sTC/Bo8+JB48V19ro4mcVnhtT2Tfv1uWk=;
        b=twDcs2F6z7MvmE9OcVR2TsQUdH6lLAddafAx9e7Zie9oFqK0LfYOz+kt8pbOuaZqXR
         5oi+bRfkKyqscdMRmjJgug1808zKAV3lD6ZtSGDwJZ3SzCVqeurIF3lYM2Hjt9/9YOwo
         R1oFqSImlShtTqjTXAo3+48SFmA9NxKLdUMFgAJDPeARc4d9aKnga/3+gmJp6ARscbdt
         OrFUI7Xfk+rTEyAGw1t6qVTaDm2ai+Rh+4JJjZ+18bIzKaTRe3rpm4Bziqu+NBnzGWog
         pvN/uaIPgX60VJi5Fvf4KjaUFXeO6RwQO7PZsi/wFMS5do10wZdnt+qTFZX39+Anf687
         6Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773027755; x=1773632555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6tbQG6ku1sTC/Bo8+JB48V19ro4mcVnhtT2Tfv1uWk=;
        b=XFXk1XiXIHl1hT46UWClBtSquDZkaS6DzpqAtY57X4xm3VyJ9Jnwl+7yhmfxcdQ21P
         6mHzQZyvTAUD/VhPBTiI8OaDpGDgp0dNQl0zHWrHDZIeI1mtrwkRBV8weTRJspXkuDRe
         5A/w38vErN7OM2LXQRydxPb/k1IpKe6BOK2phHZvBggYmdHeFXHSRCYAMjjRcqLeqPFK
         64Re7g5Us0Ya07xsFzx7HmWErLd60cK2qk2rqGNpM/gEKs7BtDMOe7XqjUe0xT2bMH7O
         vECun2Et3dExyxwGPUyrYzVStqBkBhcJxTolpXf7cHXoHi7ICeTEgoX3Kc2TrWVHIQXi
         2mrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPQxaWSV3datihGYo6g8sMKrPf6hpiuZf3PDptmh5drzNMmpKnVjprO9a7ZkMt1vjVV/1ypKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZV5MwVBqN7T72zy/YdH+wYssRbnjuEHMEiZdwBrQjRX1AnLrp
	yR1XNnw/Fn/3E6rLbdnno5yzwQf8f6QHxOsBgmGi5l7RJypMEtVAveVmw5A02REonYRL5h8nCgI
	57L3AllM96LDMsskyDZXOtmMKBty+p48HzwLND4ZqV2Cfn1frp8+URvvkVoZUElnveJi7bjcmNU
	4hZPm3bodqxSoya6+gCjJpKzGV2F5RQ9v3
X-Gm-Gg: ATEYQzzsgYO3CSmqv3tEUz0zE9C1cIYUx6jfVLVoTNShWLGI5stF4xoLHAuEhiz3trv
	E28b6DZCw23u5XPFCyvsuuc5IvwEsWVyoZOaAuWhm934Oq5CuqCvKwstRsjpTD5eut+o5LK3ESv
	iYCHo1n5JmqR1l0HZv0eIkhxTM9/pIuTq+jdkaNTtrAXaIlaqQpnOMqbtcIWh+TbSv18bjCZV1l
	nIwPfBl
X-Received: by 2002:a17:90b:2d8c:b0:358:ed1d:2834 with SMTP id 98e67ed59e1d1-359be2cacf5mr8230076a91.6.1773027755241;
        Sun, 08 Mar 2026 20:42:35 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8c:b0:358:ed1d:2834 with SMTP id
 98e67ed59e1d1-359be2cacf5mr8230069a91.6.1773027754791; Sun, 08 Mar 2026
 20:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307035110.7121-1-xietangxin@yeah.net>
In-Reply-To: <20260307035110.7121-1-xietangxin@yeah.net>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 11:42:23 +0800
X-Gm-Features: AaiRm515o09shxwU_vdeElMuc1lZuriMjuJEkBKKXciJg6H8s9RUT3AneTah6Xk
Message-ID: <CACGkMEtBS3M6P9xFM-kfPHyjwHgvCrfHM5H1242AQPi54ETqEw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C011F2338F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265371-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[yeah.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,yeah.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 11:53=E2=80=AFAM xietangxin <xietangxin@yeah.net> wr=
ote:
>
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=
=3DN
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
>
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network sta=
ck
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> skbs may remain in the virtio transmit ring for an extended period.
>
> If the network namespace is destroyed while these skbs are still pending,
> the corresponding dst_ops structure has freed. When a subsequent packet
> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> It then calls dst_release() on the skb associated with the stale dst_entr=
y.
> Since the dst_ops (referenced by the dst_entry) has already been freed,
> a UAF kernel paging request occurs.
>
> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> the dst reference before the skb is queued in virtio_net.
>
> Call Trace:
>  Unable to handle kernel paging request at virtual address ffff80007e1500=
00
>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ =
#6 PREEMPT
>   ...
>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>   dst_release+0xe0/0x110  net/core/dst.c:177
>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>   ...
>
> Reproduction Steps:
> NETDEV=3D"enp3s0"
>
> config_qdisc_route_filter() {
>     tc qdisc del dev $NETDEV root
>     tc qdisc add dev $NETDEV root handle 1: prio
>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to 10=
0 flowid 1:1
>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> }
>
> test_ns() {
>     ip netns add testns
>     ip link set $NETDEV netns testns
>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>     ip netns exec testns ping -c 1 10.0.32.1
>     ip netns del testns
> }
>
> config_qdisc_route_filter
>
> test_ns
> sleep 2
> test_ns
>
> Signed-off-by: xietangxin <xietangxin@yeah.net>
> ---

This is needed for stable I think.

And do we need to fix tun_net_xmit() as well?

Thanks


