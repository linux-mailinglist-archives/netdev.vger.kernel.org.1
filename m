Return-Path: <netdev+bounces-177722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4046A71674
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B9B3AE8C1
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F61E51E2;
	Wed, 26 Mar 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyPvISRM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C81DF969
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991644; cv=none; b=eJuzNDil+Atw5ud8MzGmX/g5XhBNUKLrVGBREGjWJ4LZPOEGIov6r6/S/l8xjENCm47KG5+dTpp2fdC5+ZTjWmbN2lOSU0+6mkQtcH1LmyCeXBW0QtHIljIq1X/ylmmgf1+bzPmbA390Ay8OQGqT4/qtH5h73XOYznxD18lFeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991644; c=relaxed/simple;
	bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQajiM/6CdAGiRCjnGpgTAFPkBh9O9BBY2clGRB0fEDoJrQOW3Z2yw3kI4cGj85OE/LNffu9YhmBfr+KsIzBmcLYg56/i6Ws8gh7mxuTGzf24WzvomUKB04F2/Ccy6YIWWP39gcCw8TqJq9GWdz0zItJu5EfFgI9rR1CpZxJaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyPvISRM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742991642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
	b=OyPvISRM1O7N2DrDBtYUfU1M3lZNR79xAUvEcl/4733LtWFE/ooQGt5l4ftsYYRePmAYMq
	TXXTdW1DPVcyxBrHAVyjeDWm/X0dhN87OAKwCZwUMUMq8ppFK5AAz4HCQKILxJOSy1uJVx
	h0U29bxapI/uWE9vnWYLkDonSHulV5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-gZ4gPYyCPdGGWQSSoRAUbw-1; Wed, 26 Mar 2025 08:20:40 -0400
X-MC-Unique: gZ4gPYyCPdGGWQSSoRAUbw-1
X-Mimecast-MFC-AGG-ID: gZ4gPYyCPdGGWQSSoRAUbw_1742991639
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac37ed2b99fso603657166b.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 05:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742991639; x=1743596439;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
        b=n8hR1juPgIMy8QS4OjCyqUcGO4Hj4aFch7iVCP8Z2WfPH49mSxI4otDjqpTJRwEl8H
         /Xx6SyrTbxKEdek/abIZlbhk92/69ag+EDcz+F4Mf+a3/wVgLZyU5nnSZuzoYrs3NzCe
         DE0XB1FA9XfxVMdKn3dct/1T4OojRTQVHlFkZw5l11jiTnzZM2I01eUL1ofJsjQS8udI
         N7tCwYI09eAWTTaYif/YDg25EqRpOqKYbTN5RubLKnQaCMye+u532S6s1TXl5lQPvw5c
         xVqK4amjsL05rGzfq4MOXOinczco5jastidvYP+d4/Z3pyxV9UAYJH/QbzUsDeUSw0kT
         fmXA==
X-Forwarded-Encrypted: i=1; AJvYcCUTuFNjDaqPoksJ1k/T/vxZMEJQv6H7I3qVkqGshRtKawyFJ2Kvp72pTIeD3b1VffYby6HqwIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHvbb3OxrIKPjYghbKVpIvSyEGO/Inrb4k+mj0S9ECvm/ReZA
	WyZJfHcEvfUWvJlx1Pd6N7gKSOltjTUk1dWNT7TEITXiTrsOmfUd3GrQFfgn8du0AY6hut7+NGW
	X98UkDCBWAG69O9l5jnESwKX7BRKxi/3J7tdm3imaFhDiVLZ73mGxWA==
X-Gm-Gg: ASbGnctecXobdAXzyparRCxMu+gp7ILGYnPaYz9hQcb4qIvS2Zui3nbkoixPo5QrIDD
	ovMLUso4HbQcaosQRTkGzam/1udt0QDdAXdN9r1SYY3zfjBAcIYvWB1KHd8BOqBVwIWzqwhLp2X
	cnEYPM4qzu/VzT1pRGg/gWI1HOeGeBhRuIGsKRr3JrJtD3JjBhgAJdU6CoBVOdZyBB05yWWW0NT
	aGibRujHtCyMRD4emZ9tuejRSMHAfkwHG2IyZPlC9CO2aEjRdWLrSZLT7sUHJW3X+jlwx3BzltN
	Hu3R5oJx6F51ARedFZqrMniiisO2Xzvx4dirtiOK
X-Received: by 2002:a17:906:c105:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3f22aec3fmr1934591266b.25.1742991639121;
        Wed, 26 Mar 2025 05:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXpD8SKp1cf90maKHi6um2LlX8ejsXAgc5A98IWT9wYQriYmqy8j/0VlxO8lFqKGic1FYQjQ==
X-Received: by 2002:a17:906:c105:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3f22aec3fmr1934588766b.25.1742991638698;
        Wed, 26 Mar 2025 05:20:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb65701sm1003437266b.122.2025.03.26.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:20:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4474318FCA84; Wed, 26 Mar 2025 13:20:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
In-Reply-To: <20250326044855.433a0ed1@kernel.org>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326044855.433a0ed1@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Mar 2025 13:20:37 +0100
Message-ID: <874izgq8yy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 26 Mar 2025 09:18:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series fixes the late dma_unmap crash for page pool first reported
>> by Yonglong Liu in [0]. It is an alternative approach to the one
>> submitted by Yunsheng Lin, most recently in [1]. The first two commits
>> are small refactors of the page pool code, in preparation of the main
>> change in patch 3. See the commit message of patch 3 for the details.
>
> Doesn't apply, FWIW,

Ugh, sorry about that; rebased yesterday before reposting, but forgot to
do so this morning :/

> maybe rebase/repost after Linus pull net-next, in case something
> conflicts on the MM side

As in, you want to wait until after the merge window? Sure, can do.

-Toke


