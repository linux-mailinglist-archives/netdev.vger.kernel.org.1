Return-Path: <netdev+bounces-192986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A2AC1F9A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E911652BA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A992253AB;
	Fri, 23 May 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAyvzm5l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303A223DEF
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991793; cv=none; b=UY4CjQJp4dXcDZOtrmWqJ+Piohkqgm5xROOwCH63XvULalo7Q8I1hPDogEHdu6qIFQQe3fnRVm0pQy1BVpmeG5pzCZpDMt9OrWsDIdOcnOUBoCULdBiEByP8FpdSQL1XhDTM1HrN5HeXM68vQ5pGfBYKvGK5yZyUQQwwhtYioYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991793; c=relaxed/simple;
	bh=vL9xiQyaqTcBSYY/w7En11UOo/roA4GtozLLtwoJd5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVbcPvUWRdP0S8aIaFSWgNzQYGchQ+kewuz7OBhJqN/RpjcvJC+CDN3jywo82rNpz2CjolqHuwh/NdvkX+BVBESsv8AC1avZrcuXQNdPIthUO9F7zicdZ7GGY5+HKoz7HzuzNUb0D+NxXBorrGeRRjbCCv1+K5qvdyQOhOMRiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAyvzm5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747991791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h+Yy62ZlA2qwCk7aDUUsgmb3Ggi1tOTOzIVVOOKlg0=;
	b=XAyvzm5laLirS/Z7eO44n3PD10k/j24L65VhCKZ2bSSaTRheS7HT+/BWoLSa2cWnzco1fV
	9NVYs28mvS6Q25YQSXqzV4/N6QCPPlKmiXXs/pn8MtkaBJ6zr6vELJqd2ztH6XPFviNknb
	IBkCow3WQKytgwyv4Iwd9C68ONHG1+8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-rlD0EUKLPC2PG9LZ2ED_2Q-1; Fri, 23 May 2025 05:16:29 -0400
X-MC-Unique: rlD0EUKLPC2PG9LZ2ED_2Q-1
X-Mimecast-MFC-AGG-ID: rlD0EUKLPC2PG9LZ2ED_2Q_1747991788
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-551f3e3eb6fso2409695e87.2
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 02:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747991788; x=1748596588;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h+Yy62ZlA2qwCk7aDUUsgmb3Ggi1tOTOzIVVOOKlg0=;
        b=xSAVQ03mu5NXfooq1WsvxsDpKa+BvpwDc6RwPsUuYnP1qTm4YijDhsanLzOgScJh/S
         0i1Mfk7ZYRwBmRFbYCPjkAxpntyDN1PE8iQv3Oi49tW6kCSdwW7CjYmNwNkY3hODtBR0
         vm4+VInovLj22MKj6JV9csgDVSJJtsGjcqiR7leSysleD0adqFFRInySFAu4NPraMGnq
         vdCdHBumHOvSx718NI0E6rDdu3d33qfspAU075QA8r6JxDFVL3FUbp960UsprNTu9LOH
         yCFAstcnXdDNNWtjkknjwF2bsVbzQR1UGTjFHqf658GfehEN4AXE425fH1HpREEjDMlt
         ttnw==
X-Gm-Message-State: AOJu0Yxnr1O+xLMVnYSPQtRrkT4VKgqYf3K/OYykB2gGsefmwPFZy6yo
	yLUMagiplcIaaxOYiMSaWBopFISSs39azQD6KHz6TrEHWzm9cKiwXHsBm8bn5i0hlpaMA3juzCj
	KpdUwRmcqJKoI0kHV5xrdNNIy/GR9AFvxu+bE/avDcVMVJX0GwuRUyFuJooWMpvpOFg==
X-Gm-Gg: ASbGncs/NQpi17HLJhCeWrYrB0drIszrGwcYgRJ6GkPxrDDnODxqCL60cjJre6ku6xe
	OLcARsputIhHSpG243mEmjRTrHfzoMnlx1+pzjwwgrqDgwkbV0qdgM70C65slD12NN6h8dG2eLT
	Q7HggL4+Y4oBQzbG5tPdGfhHJ7QjIuIsljcQdE05FaJkyZqVs/k8VeRXbXHoyEE6o6UDr5cmsZ0
	I1JW/KtLE4XOAZrWUzT2o124U/G8590qYPrw5cnrv48VGRo6s+Z9YGaMRgpNl4sQJY46GLZUO02
	TQT3o1LX
X-Received: by 2002:a05:6512:3e02:b0:54f:c049:4a5b with SMTP id 2adb3069b0e04-550e7250abfmr9351882e87.47.1747991787854;
        Fri, 23 May 2025 02:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaQ8huunxoEwtFAoZuCgaFT5mLEdvGiJVduPobo6lkNXw2BcUK9t7VQv5UbiSdEGhNk4eBJA==
X-Received: by 2002:a05:6512:3e02:b0:54f:c049:4a5b with SMTP id 2adb3069b0e04-550e7250abfmr9351877e87.47.1747991787407;
        Fri, 23 May 2025 02:16:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550eb6c7155sm3573232e87.22.2025.05.23.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:16:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B2C911AA3B94; Fri, 23 May 2025 11:16:25 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Dong Chenchen <dongchenchen2@huawei.com>, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangchangzhong@huawei.com, Dong Chenchen <dongchenchen2@huawei.com>,
 syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
In-Reply-To: <20250523064524.3035067-1-dongchenchen2@huawei.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 May 2025 11:16:25 +0200
Message-ID: <878qmnn0uu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dong Chenchen <dongchenchen2@huawei.com> writes:

> syzbot reported a uaf in page_pool_recycle_in_ring:
>
> BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30 kernel/lockin=
g/lockdep.c:5862
> Read of size 8 at addr ffff8880286045a0 by task syz.0.284/6943
>
> CPU: 0 UID: 0 PID: 6943 Comm: syz.0.284 Not tainted 6.13.0-rc3-syzkaller-=
gdfa94ce54f41 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:489
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  lock_release+0x151/0xa30 kernel/locking/lockdep.c:5862
>  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:165 [inline]
>  _raw_spin_unlock_bh+0x1b/0x40 kernel/locking/spinlock.c:210
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  ptr_ring_produce_bh include/linux/ptr_ring.h:164 [inline]
>  page_pool_recycle_in_ring net/core/page_pool.c:707 [inline]
>  page_pool_put_unrefed_netmem+0x748/0xb00 net/core/page_pool.c:826
>  page_pool_put_netmem include/net/page_pool/helpers.h:323 [inline]
>  page_pool_put_full_netmem include/net/page_pool/helpers.h:353 [inline]
>  napi_pp_put_page+0x149/0x2b0 net/core/skbuff.c:1036
>  skb_pp_recycle net/core/skbuff.c:1047 [inline]
>  skb_free_head net/core/skbuff.c:1094 [inline]
>  skb_release_data+0x6c4/0x8a0 net/core/skbuff.c:1125
>  skb_release_all net/core/skbuff.c:1190 [inline]
>  __kfree_skb net/core/skbuff.c:1204 [inline]
>  sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
>  __skb_queue_purge_reason include/linux/skbuff.h:3343 [inline]
>
> root cause is:
>
> page_pool_recycle_in_ring
>   ptr_ring_produce
>     spin_lock(&r->producer_lock);
>     WRITE_ONCE(r->queue[r->producer++], ptr)
>       //recycle last page to pool
> 				page_pool_release
> 				  page_pool_scrub
> 				    page_pool_empty_ring
> 				      ptr_ring_consume
> 				      page_pool_return_page  //release all page
> 				  __page_pool_destroy
> 				     free_percpu(pool->recycle_stats);
> 				     free(pool) //free
>
>      spin_unlock(&r->producer_lock); //pool->ring uaf read
>   recycle_stat_inc(pool, ring);
>
> page_pool can be free while page pool recycle the last page in ring.
> Add producer-lock barrier to page_pool_release to prevent the page
> pool from being free before all pages have been recycled.
>
> Suggested-by: Jakub Kacinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20250513083123.3514193-1-dongchenche=
n2@huawei.com
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Reported-by: syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D204a4382fcb3311f3858
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


