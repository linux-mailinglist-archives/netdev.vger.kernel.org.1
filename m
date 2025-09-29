Return-Path: <netdev+bounces-227135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5238BA8D0F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842FC3A29DE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922C2FA0F3;
	Mon, 29 Sep 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X106Xei6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A82FA0DF
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140459; cv=none; b=owxqx89wwY4WV+NTINuVDt2rUBquf7f9hC/dntG1a8RzibIe7Lof0YL/JcmQDpgdrUrkvSe+wo4lsFESku1R9qPndX9a6jtDJsKnNOo+lajNnC7icSuw4uEwYjZiaq106osQRBe+SzhrVwKEcFxjxA8+jxmRJC/lZSAsn2tpMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140459; c=relaxed/simple;
	bh=pNhsAZ197fXLkKx/HifCds6KCXexvnVvwkp8EfKfNUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmwcgXAYOmhqqLbUGguwz0Vqk8OJLQRQk9jGGK0YRTSwZa9XV1342Tb9cb2GamkaMU7lQK76L+APrG+lp88VbB9XfKiEgEq/ZbwpdXT7q3Jqc7p9BMhPMSsn+SwWv8wor9zVfgC/8TbAyaQlbKSiHYerg1PgzzS9yqM5ydJOTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X106Xei6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759140456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNhsAZ197fXLkKx/HifCds6KCXexvnVvwkp8EfKfNUs=;
	b=X106Xei69THRjRwl/YxXI7rGpXH56vBkmCYQq7LiD+23Q67XYfaC5ngSoCAc7Iy41slVsn
	tRZtHM0vckO2C/VHn96Jrb8KE0LcvSJb5EZu1UP8Cgl0XSyAwCbfK1b3prVhIXDAYbz3Bp
	9c29Voa1vALThQ9CG3Xy6/9npJucEZg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Kn7ZyO09NGmTL84MOqBdLA-1; Mon, 29 Sep 2025 06:07:35 -0400
X-MC-Unique: Kn7ZyO09NGmTL84MOqBdLA-1
X-Mimecast-MFC-AGG-ID: Kn7ZyO09NGmTL84MOqBdLA_1759140454
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b36f970e2abso328466066b.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 03:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759140454; x=1759745254;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNhsAZ197fXLkKx/HifCds6KCXexvnVvwkp8EfKfNUs=;
        b=w9IyzszglWmcCcqwBSU+w5a0+XS+aRjkv9C3P6YzbvsD//nUrn/foZ98xljkj3Z4yb
         20q2U5hj8g3b70ToqYYbhbUxkpEJTyr8k8sCOXeUTIREZ6uyjn3h0PP1IEzr+8gf7Scx
         hZAOVXzlvFnNDrCdvxWfoN1MHGfLu1U31a80deL8fAQIXZMyn0qTHK479Yu7q+lMkcHL
         gkX2h0CKhRGjTcldZUwaRk50F//50sQDGUPcXXlXEC85RuwlduvDUXL3kuwixc573vm/
         SPXv07X+SgZAklFfM26oB4vUDCCx+fJXjr/BRssSLz86AWvueXPSPs4x8zhczT+jrzeX
         PNfw==
X-Forwarded-Encrypted: i=1; AJvYcCWcxEKW+Zy8AKTCwLcmjGN2DExn7oBqB3mAGei+w5uOI/m0N/CKQEGxN+5kaMLnvZSMZ6k+Hbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3idh+1HXrr9IdgJ2wjKKViYRGutrg7IauwdzeYuBtRGQ2HQ6/
	xEV79Ve2ujYUt8Kpdvrq8H7WdOktE60eLgc6lJJ+yDOBwTUnnR6BBXPRl1hQXlBTTF91oYZkoMe
	MdbSdihM9NXEv85+Tt4Kmx/EXvQ/LEwL1nRM3Uue0uxPQR43ML2GgyBRm4Q==
X-Gm-Gg: ASbGncs8CDVL+hgB7PgTfBriZgJ/5Ec2ZFheRMKstN9oXPY7DuB/e+Hdhm2NWlWw9sL
	1tAsvO2iM2IPQ+g9sLiEArfRGYUrQQopk74niyxbx+iKTqn3roz5ieWHpD+2tvsMyFX3l9rCLMR
	YGOU2QDd6opxYmacHqNt6+ASbGSx3rscFZBXhie80ps/KPqxI6NFUYsg0H9MSjcu0t88UewSdjo
	C1Lgzb9EhWmYiaorqrQgk21/J3whziBplYkwpQ0N7aPAu46MNlR0/Y8MTqHPr8sarxH3hzr1DSf
	owHt0qp9TMu0o3IRbbeS3qxdXyIY6c0YSz7do+ty8s3WFlP6CDVOPK+uoQMvMrJt
X-Received: by 2002:a17:907:724a:b0:b3d:200a:bd6b with SMTP id a640c23a62f3a-b3d200af74fmr521501866b.52.1759140454296;
        Mon, 29 Sep 2025 03:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9a2plHTKeOP38PeLzjOKA1MCGusAp8NTkLyvlpvfnkmlHt9UG5mdCvqBSpRviAip/7snxFQ==
X-Received: by 2002:a17:907:724a:b0:b3d:200a:bd6b with SMTP id a640c23a62f3a-b3d200af74fmr521498666b.52.1759140453816;
        Mon, 29 Sep 2025 03:07:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fca1sm101904466b.101.2025.09.29.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 03:07:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 10A41277657; Mon, 29 Sep 2025 12:07:32 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mina Almasry <almasrymina@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Helge Deller <deller@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
In-Reply-To: <33e8db9a-7749-44ae-a2a6-27f3e6e8a3e0@gmx.de>
References: <20250926113841.376461-1-toke@redhat.com>
 <33e8db9a-7749-44ae-a2a6-27f3e6e8a3e0@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Sep 2025 12:07:31 +0200
Message-ID: <878qhxo9lo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Helge Deller <deller@gmx.de> writes:

> On 9/26/25 13:38, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
>> boot on his 32-bit parisc machine. The cause of this is the mask is set
>> too wide, so the page_pool_page_is_pp() incurs false positives which
>> crashes the machine.
>>=20
>> Just disabling the check in page_pool_is_pp() will lead to the page_pool
>> code itself malfunctioning; so instead of doing this, this patch changes
>> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
>> pointers for page_pool-tagged pages.
>>=20
>> The fix relies on the kernel pointers that alias with the pp_magic field
>> always being above PAGE_OFFSET. With this assumption, we can use the
>> lowest bit of the value of PAGE_OFFSET as the upper bound of the
>> PP_DMA_INDEX_MASK, which should avoid the false positives.
>>=20
>> Because we cannot rely on PAGE_OFFSET always being a compile-time
>> constant, nor on it always being >0, we fall back to disabling the
>> dma_index storage when there are no bits available. This leaves us in
>> the situation we were in before the patch in the Fixes tag, but only on
>> a subset of architecture configurations. This seems to be the best we
>> can do until the transition to page types in complete for page_pool
>> pages.
>>=20
>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them w=
hen destroying the pool")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> Sorry for the delay on getting this out. I have only compile-tested it,
>> since I don't have any hardware that triggers the original bug. Helge, I=
'm
>> hoping you can take it for a spin?
>
> I can't comment if the patch is otherwise ok, but it does
> indeed fixes the boot problem for me, so:
>
> Tested-by: Helge Deller <deller@gmx.de>

Great, thanks for testing :)

> Btw, this can easily be tested with qemu:
> ./qemu-system-hppa -kernel vmlinux -nographic -serial mon:stdio

Ah, neat, thank you for the pointer!

> If the patch is accepted, can you add the CC-stable tag, so that
> it gets pushed down to kernel 6.15+ too?

I find that networking patches make it to the stable trees based on the
Fixes tags, but I'll try to keep an eye on it just to make sure. I can
also add the Cc if I need to respin for some other reason.

-Toke


