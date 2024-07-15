Return-Path: <netdev+bounces-111395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5993930C4C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 03:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD8F1C20A41
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 01:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254010F4;
	Mon, 15 Jul 2024 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoT3MViE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632966AB8
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721005733; cv=none; b=onqx/fglyiywHv3tZce7SXu4FliFzhCI7FNu40IgCIZ7IUXJn+mjcRDeBd3tcFQq3YV5PptO9JxlpK8nwY+kwVRt2r1GViVlc1kJzfPuMQzBiUkOZLwc3lxXwuxTAfIfyr/bIa7DpKUy0mTHgePno3X5PteQOH4NVTmMJKQHGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721005733; c=relaxed/simple;
	bh=Pa5I0cVPLyu9hM+t7OcRoRA7sRLi4NugvS+t0stj8qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHYUZfkJUBOmA7qo/gUEpMiDCBAJMIp8negTmb/+diiZN3BbMW8WHZKH7PRI7SBFRFhs7x+vkdTEm5HGDqiEloambb/R94MXhJgZnv6Jz9pt/ZoPYJxogKcuImBOmu299l9XVUj5FyLudK5+TSHwg34PpfYYBrwiSYRoeh4sljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoT3MViE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721005726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFD7oUV9b+eqssJJfa29SNu/zafN6i0hj5VXLiDFp+I=;
	b=GoT3MViEM9p8+aVr/ExM6Dl/uiBaBH0Ve24c6o7+i1HF4Ld7U1FJVZzadkoMDqj3/yDOea
	pkNxVNPx0mWJL/bgEgV5w8PUy/i1pX+juwb4L8Xkeu/Y3i1+6bRJIYkxy82438pNTqqigk
	kC+wfJO6luKIOxR2y6DricQjhyss0dg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Tx_61F9HPAW8HvAqGGdbYg-1; Sun, 14 Jul 2024 21:08:40 -0400
X-MC-Unique: Tx_61F9HPAW8HvAqGGdbYg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3060818a12.0
        for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 18:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721005720; x=1721610520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFD7oUV9b+eqssJJfa29SNu/zafN6i0hj5VXLiDFp+I=;
        b=DlnkV4GA091yiHvQA2OcWYbmSBBf8H5xaluuDQVr5iIT79yLX+CMADxxYRuWBPWyXq
         eJiGQIa4hQg/wUSw4X3tYUc2QfO0+rqmzeQcvmk1Lix7Re0Su4wpxYiZKBGzvsSm+P4f
         ro6SkzC4d4UyjHDONSL5n2bXZN9WjHhmoAfsi/s4R2eOhmjaz4Yv9oR7WCJhmzbue2pY
         G30U3TO9L82K9QQKv1ccSHKRGr/j5OTKVxry8tQhCnK5oHCxPEG3OiTNWLX+n1ws7fur
         wN+s03Pfiuo0zQz98Y/c0RVrJ47fHIw+2o3KPQWvh+h+IPePWUBDBYWnaRQ3n48gZykS
         0qgA==
X-Forwarded-Encrypted: i=1; AJvYcCXhi/9QDn22F5MPLirNPb5UrdFxH1ECziFr2ibjth4g3EvW189A5K0+Byx80oY6oOAmgwSSdlNH+kvPHeYm+v+n+yTj/Fjp
X-Gm-Message-State: AOJu0YysLxmB7Ht5KfztDJB5sNHPY9Vh0FxxeklcsA18dlaWVAH1PMDK
	V01eK1NjMaZRMQwCb2FijwNGUxt48uIbNJoh0ZQ9c5R6n6JKswyIVrz3GKu0PQ4wayXJ9UX7NtW
	uE4mt+WvDKyq05cDa65wvOd6+jrcF9nOAA0hmz2g1Jm1vjOrKibqQMA7Hq3geJ6b53F9dbopOTp
	oSkYrfx51WoXPkM6JeCEob7ozw+mPK
X-Received: by 2002:a17:90a:5288:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2caee674e2cmr7215526a91.3.1721005719665;
        Sun, 14 Jul 2024 18:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfOYW4Dode62bRmQR3obF0rhuYSCpoHB6v8yaabskH3L/XYm5x+VvgWMx3soWzdSy10hWnKT2zpLzTYDaJWk=
X-Received: by 2002:a17:90a:5288:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2caee674e2cmr7215499a91.3.1721005719219; Sun, 14 Jul 2024
 18:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712115325.54175-1-leitao@debian.org>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 09:08:28 +0800
Message-ID: <CACGkMEtDDCtF3FrjOppS=+Fmb1uHZborXn3biuRKV4iTwHmVaw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
To: Breno Leitao <leitao@debian.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rbc@meta.com, horms@kernel.org, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:54=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
>
>          WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_=
put+0x82/0x4b0
>
>           __warn+0x12f/0x340
>           napi_skb_cache_put+0x82/0x4b0
>           napi_skb_cache_put+0x82/0x4b0
>           report_bug+0x165/0x370
>           handle_bug+0x3d/0x80
>           exc_invalid_op+0x1a/0x50
>           asm_exc_invalid_op+0x1a/0x20
>           __free_old_xmit+0x1c8/0x510
>           napi_skb_cache_put+0x82/0x4b0
>           __free_old_xmit+0x1c8/0x510
>           __free_old_xmit+0x1c8/0x510
>           __pfx___free_old_xmit+0x10/0x10
>
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
>
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
>
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


