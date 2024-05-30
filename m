Return-Path: <netdev+bounces-99320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF858D4721
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD811C2102F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9914F131;
	Thu, 30 May 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoO4em1J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94995DDA1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058056; cv=none; b=mdbh/T/c+aqu2sMYySU7Fkgobbk6BzIkbTjCViFaUM6hWq7rZtk6sgv5DCOcZWKUwEPI456mzPUGmFhFYZ3RCg81y9YINL0tpa64lRZ9ZiHn5REnBMax4LNxw6TEIAOBRmKyYMhdVnLRCjGCq6Z/jFOSMaRatwKKFdZ445W3j8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058056; c=relaxed/simple;
	bh=YPRSqyl/CcRUY7YmjAj47wYPX350ky6vla4uyA0BANg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEotqq7y32SSZlNk4utExocAyXKp/0p/DaJh1k3nDbPNXUUjXedFpKWaidIVIbuU9sdQq4o/voMoqh/ok3l6XJowZSTVS2A5UE9OnC1tYEsRFUxHXLw8CxhU9YaTgXYQLve5HCv7osGIhAsLg1jzbgeSy4MU9bEKvtqbCAsQwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoO4em1J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717058053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8p/PzYTZqTIRk5un6CRqflrJ6wSekGj59VmkJBf1TKw=;
	b=NoO4em1JbtpValO5vRi8XpayxTjIsWzY9JbAc8IdhxRatu2s+EkF0vQg32vyslLMHaD51w
	syLr1TRYOQ77/vZd6qE6J/X4W4BfyeTNkJyLCwpunRraQw/8rrtzfzphWPNGdfneJotQkQ
	lLCSVS0aTwIwDxY8xXbc6GvZBsrAbpQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-jpJHFR_6NKuq0rGpzGYy3A-1; Thu, 30 May 2024 04:34:11 -0400
X-MC-Unique: jpJHFR_6NKuq0rGpzGYy3A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dbf94beedso91335f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058050; x=1717662850;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8p/PzYTZqTIRk5un6CRqflrJ6wSekGj59VmkJBf1TKw=;
        b=qbX98OhljEvIkBx+9q7QFy7PVgY8MxIRu4ro0EyUEGwwpcQmCWqwbP3lyOVHZjxjvz
         ty9PXj6CFRq1LqLz0sCbd+UMT0mOkd58DfdyGPPkpBoF5t8a30meuVW7w8zmdy8GfK3p
         3W17/lFTnfbe65SKLY8XVBeCktjcys0npZrjYzi9YuxStcSk5oGD0Qp0Wb8nu8brV1RC
         +LntQaKr7C0fwYZg17B//L1FSkbrVLkVSA9eeQON2qchG/7F080eTWq3itE7SFGuPjuS
         QAlQgfY6OBlWzgRC1/INV3Oca/EBe9FiClofPdO6Pgii75eEdT8fhkEHvq6THlYFihx1
         pSjg==
X-Forwarded-Encrypted: i=1; AJvYcCVXn2Xiyh1B3DZUgFu2odIoKUoLpZxBsF5A9G0Xz8lNXn+X1NoSYwpoql0rR4kN5uFT1bbkWVKmlWmazeWK2PBa/exJaEH7
X-Gm-Message-State: AOJu0Yy5Ro4MQk+mPcw0kPOKE1GZHXPOrH+sdlBYr1PK1EqLOmPdz/YZ
	v3vcrDdSL0SWmxh10Sz7ZrVmoCFg5dHJY+Tb8istaGslAhiA7VLrh/mqe7/31//MtrDBqGUVOvI
	k/uqqWQxKD5CCDl8M0dVqQunWjPzzfmi22xtt5coGPBv4ydOIhTFfbg==
X-Received: by 2002:a05:600c:1c82:b0:421:2918:3d9a with SMTP id 5b1f17b1804b1-42129184211mr5695075e9.0.1717058049869;
        Thu, 30 May 2024 01:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYN+QnQKOPqHxM/7/qFWAWZzUL5N4/SFTVPoI8JY6oFxwjZSFqP8P+WscBPQ6hLYjsMF/UAw==
X-Received: by 2002:a05:600c:1c82:b0:421:2918:3d9a with SMTP id 5b1f17b1804b1-42129184211mr5694925e9.0.1717058049472;
        Thu, 30 May 2024 01:34:09 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212708bd83sm17821685e9.48.2024.05.30.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:34:09 -0700 (PDT)
Message-ID: <e6411cb5ec7e5ecc211faded7af4843647c6143a.camel@redhat.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens
 <danielj@nvidia.com>
Date: Thu, 30 May 2024 10:34:07 +0200
In-Reply-To: <20240528134116.117426-3-hengqi@linux.alibaba.com>
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
	 <20240528134116.117426-3-hengqi@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 21:41 +0800, Heng Qi wrote:
> When the following snippet is run, lockdep will report a deadlock[1].
>=20
>   /* Acquire all queues dim_locks */
>   for (i =3D 0; i < vi->max_queue_pairs; i++)
>           mutex_lock(&vi->rq[i].dim_lock);
>=20
> There's no deadlock here because the vq locks are always taken
> in the same order, but lockdep can not figure it out. So refactoring
> the code to alleviate the problem.
>=20
> [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 6.9.0-rc7+ #319 Not tainted
> --------------------------------------------
> ethtool/962 is trying to acquire lock:
>=20
> but task is already holding lock:
>=20
> other info that might help us debug this:
> Possible unsafe locking scenario:
>=20
>       CPU0
>       ----
>  lock(&vi->rq[i].dim_lock);
>  lock(&vi->rq[i].dim_lock);
>=20
> *** DEADLOCK ***
>=20
>  May be due to missing lock nesting notation
>=20
> 3 locks held by ethtool/962:
>  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
>  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> 				ethnl_default_set_doit+0xbe/0x1e0
>=20
> stack backtrace:
> CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x79/0xb0
>  check_deadlock+0x130/0x220
>  __lock_acquire+0x861/0x990
>  lock_acquire.part.0+0x72/0x1d0
>  ? lock_acquire+0xf8/0x130
>  __mutex_lock+0x71/0xd50
>  virtnet_set_coalesce+0x151/0x190
>  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
>  ethnl_set_coalesce+0x34/0x90
>  ethnl_default_set_doit+0xdd/0x1e0
>  genl_family_rcv_msg_doit+0xdc/0x130
>  genl_family_rcv_msg+0x154/0x230
>  ? __pfx_ethnl_default_set_doit+0x10/0x10
>  genl_rcv_msg+0x4b/0xa0
>  ? __pfx_genl_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x5a/0x110
>  genl_rcv+0x28/0x40
>  netlink_unicast+0x1af/0x280
>  netlink_sendmsg+0x20e/0x460
>  __sys_sendto+0x1fe/0x210
>  ? find_held_lock+0x2b/0x80
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? __lock_release+0x5e/0x160
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? lock_release+0x72/0x140
>  ? do_user_addr_fault+0x3a7/0x8a0
>  __x64_sys_sendto+0x29/0x30
>  do_syscall_64+0x78/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

This would have deserved a changelog after the commit message.

The patch LGTM (for obvious reasons ;), but it deserves an explicit ack
from Jason and/or Michael

Cheers,

Paolo


