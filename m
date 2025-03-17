Return-Path: <netdev+bounces-175338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C343A65478
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E983B763E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B882248883;
	Mon, 17 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6VW8HI4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6524397B
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223327; cv=none; b=HKOCb+rTOOvJYMLT8Hayg2c1PH22X97bMn4AC7I9lf+Pcxa7RyEX255ab9PSgy/C5MsJyFWO0BmYXG+eXyGD4dx0lKiTTbmqONEHhk7kIbSo4WML2jm2oGe1P4819Q1quhJXBhh266QieveJw0BwLf0hAF9IoboQ1dFq6FUSJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223327; c=relaxed/simple;
	bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qUEc+14Kv9LARl/ybPn+gu0exOu/7bHPGSABL4IDUuVVenc1e6/AwDJyatyERDSXUoR3beTmXl0qZrk4vvefeGUpaTPIPWIKMc5kVYhRaV9A09Dx5+7rhqN1yhkjcJsJFiS/UFowgObY2/bDCu0Lyg/eU4OoAedxIYimyvInmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6VW8HI4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742223325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
	b=M6VW8HI4VWEWTe/ynqN6bORakSLTwXTWIa7ZpOIF4q+WJtyNBmyIofLhGhwqSEJkDxBwj9
	Dz5BNlIUyT01shAFRD54DkqrXP1+9+BxvNbg5aswVKdjQgBukobmBQqYXZ9Ejeh5mK6huR
	rCByUPmFovAvKn0nDnf5IpCW0LtT9Hs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-2zHxfrTtMAKkMvu6wKYYYg-1; Mon, 17 Mar 2025 10:55:24 -0400
X-MC-Unique: 2zHxfrTtMAKkMvu6wKYYYg-1
X-Mimecast-MFC-AGG-ID: 2zHxfrTtMAKkMvu6wKYYYg_1742223323
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5495cf1a321so2201433e87.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223322; x=1742828122;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
        b=oRJ+8HkJQxFzM40oDs/IOw8RiI1izLb8NdvvSVjKRFwgQ1ya2nu97oK/CYHQ33TN5i
         xvqo9W14QUQk0wRHihB2K/GDk5qiP2pFbXAWI/7oapTMHeIb7b+DJwbKS1qdYUdepvUX
         1dZQIwtNR4p1mktNecbMdG0o27B/h9fJnDI2EZcbDulUu483G5YFcnphsUIfdKc7ulOe
         jgyKS2PSklem4CqyikVqbvV5tmu0UlktWBP4uAdS+hL8tXTJgNEEOxEu2SwYuP2QNHX7
         dVZ26/UqfLyG9z5dLwibjZtCMu6vP2c+GMk9D5kgcaMuTD7VEIaMcf0SG24MFoBb7Sgi
         uIpw==
X-Gm-Message-State: AOJu0YwkKSreTpIXrMcSygNxZb5FuC9SNp8SwGttliAVVGzxqZ2P6lma
	JxXbNrZoZo/Ab/+ElJYCJZiJcz1Lkkl0829a9TguMHLgMPgsq9h4k0hNRoCkXF4E2Oe+mMmtMyh
	ddpfhBp5kvljg6bt6RyiIh+TNbriEXQFtRD0DnxyB9MEEuyJ4wE3rvw==
X-Gm-Gg: ASbGncsf5Z/mAUxlxtEE2Md88KIG0kRzn1hvpVAmdbm/RJBWrrm7G56p2jPHGfjbgIy
	3UksBVUg8uYkHisiUyEoQEkC79a1tw4k/baPXeFeOcoJR7BLpPiOC2G7n/hikvxcEKA996KjEDN
	LfcjHVdxN4uiiyj3ORIt4RsQLan6MMh2dzfclI2hrW+sY1p2hH1KGgV4kjojgXGhGkm+utgVBQV
	payn85tlNCbzd1UyeGTUQ1EoYZ92j7i1e7onigTIQ0q8/tpIgFyxJY0wscFNpAzEBKqM0lUswmD
	uiZC7uqvLJ/6
X-Received: by 2002:a05:6512:2256:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54a03cf6675mr26261e87.42.1742223322297;
        Mon, 17 Mar 2025 07:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkU4EGv0nYoD/ziKJsZtzUZRRSbpyRPe5/A4qyQD074afFL4/ETFCYpbFS8GyZgIxIK6weCA==
X-Received: by 2002:a05:6512:2256:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54a03cf6675mr26237e87.42.1742223321810;
        Mon, 17 Mar 2025 07:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a86c1sm1374403e87.21.2025.03.17.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B523218FAEC4; Mon, 17 Mar 2025 15:55:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, Matthew
 Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
In-Reply-To: <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
 <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 15:55:18 +0100
Message-ID: <87msdjhfl5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Change the single-bit booleans for dma_sync into an unsigned long with
>> BIT() definitions so that a subsequent patch can write them both with a
>> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>> non-netmem providers as well.
>
> I guess this patch is for the preparation of disabling the
> page_pool_dma_sync_for_cpu() related API on teardown?
>
> It seems unnecessary that page_pool_dma_sync_for_cpu() related API need
> to be disabled on teardown as page_pool_dma_sync_for_cpu() has the same
> calling assumption as the alloc API, which is not supposed to be called
> by the drivers when page_pool_destroy() is called.

Sure, we could keep it to the dma_sync_for_dev() direction only, but
making both directions use the same variable to store the state, and
just resetting it at once, seemed simpler and more consistent.

-Toke


