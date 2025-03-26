Return-Path: <netdev+bounces-177833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EDCA71FD4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93A91774F2
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205DD253B6A;
	Wed, 26 Mar 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd7x8KLV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770C1917F9
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019384; cv=none; b=JSecnhEcMBfdBh1lVu+vCYjVWQ45vni6phxlFrIwuoMtf56q8QtpXi32RKC+tAOjD2H4t1ZcvUxOubvHUedR0+xxswrCgYoCpJsQZcPPy5NZPMXjkHi3oqmmwLHwnu9Q9pMlWIn+0rd66A9RS+fFYJgO9dt9iNOhcnvzKiZiT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019384; c=relaxed/simple;
	bh=+Jn/IScUMjS4Ljw3DR8smqRGBCJ5wuOgYhY7MDcFlHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3wiUjPunJKCEnSypK7TiITtPcB4B+lzm/eSNZedCOqxj4A8FSLYmJ4f3HCPOgYRv2CT0KQDjwrsYhmEXi7oWd7nz18IkZoyTgXjKYWeWrR0LY1WWlbxxbq3CjEdnETzFylm39pFl4s2qt8KIynR4lDhxiQKOqzJtDAK6OAlYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd7x8KLV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2264c9d0295so49595ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743019382; x=1743624182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jn/IScUMjS4Ljw3DR8smqRGBCJ5wuOgYhY7MDcFlHM=;
        b=Gd7x8KLVZtGWEll9DZ7sZP2owhGlc5HMJ+kqOS90WxLY77EvDSVNo7g3RmTnCmHXgs
         WecDcB2IIYrvjc/fPvVYPq7nuIbVIclN/MFacvrS0RmwZVe7TTlkhwtPGu3zcAtRmoa1
         gTW6g4/uZFdyr965AH7iUTlSSZXBQcNI0Ug8A00s7xtrYhdqZ6pJsLwQbGo6FXfkOR3R
         qVdwQYN5SswvDI/cBA0mKwAhNVsrqrxbzAoF+ifgD/M5LdoOqZiwNm3TmXImVGzZWn+5
         kQ2/xRNYI3DmoFn5yCg+TbeOoLxbc+VlI6TlWfYlT/zSr0M03ouvEw2YPgDGNiE/mTDy
         mlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019382; x=1743624182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jn/IScUMjS4Ljw3DR8smqRGBCJ5wuOgYhY7MDcFlHM=;
        b=D7FKuGaUq7JvEEjeZw+UzZ3x+W9tr1clenz/3CxRmE82IcsAqXIFfptQJGq0Vs4Cxu
         w9BhsVv1zzq7f+Iw1EDttm99ossufgJwpmEA52Y7wwy9jCMYb9Pqe9fkRZFqX68SxCZK
         7c1fw7hs4SOddFwi14SON51zkxttIIz1WiFo64jM5eTWzti7ujWzZXGyWRnWBX9HOjfI
         7Jh7HTndt92zJW3cub/+kv/dn/QH8bW99UScpImXb6nPaC/UDxy+3OIuA9WZdb2tgWc8
         0ajy1HDl4m9uAtn2OAMWtCjFMfkDBYJx2kIhDm0raPJTPa1w+nxEyjxn/bpycxWlvnts
         2FUg==
X-Forwarded-Encrypted: i=1; AJvYcCX10PHo0ZhCH+r1rXsa0lXFSiBO26MXcoqyw3ge7JT8n7Q4e+vNuao/MDRsUjc8AYGUyx4zfIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8sBmQC6P6dRdTsnFiFWHIy6M6JocQNPxj7xlPvjn+eDDYIyuL
	1Q+ReuLoIG/cIwu+NKBzs1wVOujfT1l8hrPi1E8KD6Q4xf8VmF9z1tPlOA+H3vySH33MWB/2Iz4
	kreCoW9ihiByx6+cLTkSB5KL3uqV9zShJo6/s
X-Gm-Gg: ASbGncuDyehrcLvcs7s+AZDeZJY+tpemdAC1zJcFGesJcxv7eZv9hzfVljOLOzYuvGL
	pjX1DGCSvGXxoBDevEWrJo8UVNDoSSOhdquuQo/lEDvW9p6AJVE4lloTF9X5gmUTJCdwPLf+2aG
	BxOQrqLqcCnAYdc928l51z8IXilm1QbZ9j2/hmh57BYL5LvSlc9OI6a+BS
X-Google-Smtp-Source: AGHT+IHyPZSjmwsfq6GL9V2mdi4AJh86d77SZIS1dGb/WuVS1w50xrfuefF5cJ781EQYYgtygSKDYkcpT6oW3EQsMpk=
X-Received: by 2002:a17:902:b20b:b0:223:5696:44f5 with SMTP id
 d9443c01a7336-22806bc2039mr138385ad.12.1743019381382; Wed, 26 Mar 2025
 13:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com> <Z-RF4_yotcfvX0Xz@x130>
In-Reply-To: <Z-RF4_yotcfvX0Xz@x130>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 26 Mar 2025 13:02:48 -0700
X-Gm-Features: AQ5f1Jp4SZZ5mE4AjxOxiWClioRQd_IS8oLYCgWXk_1st2N-aMHQasCWsZn1xYo
Message-ID: <CAHS8izMj2aBeu=TreUM-O3XNqqF75vb4rvMvf7pr8mGh+N_+kw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org, 
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:22=E2=80=AFAM Saeed Mahameed <saeedm@nvidia.com>=
 wrote:
>
> On 25 Mar 16:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> >they are released from the pool, to avoid the overhead of re-mapping the
> >pages every time they are used. This causes resource leaks and/or
> >crashes when there are pages still outstanding while the device is torn
> >down, because page_pool will attempt an unmap through a non-existent DMA
> >device on the subsequent page return.
> >
>
> Why dynamically track when it is guaranteed the page_pool consumer (drive=
r)
> will return all outstanding pages before disabling the DMA device.
> When a page pool is destroyed by the driver, just mark it as "DMA-inactiv=
e",
> and on page_pool_return_page() if DMA-inactive don't recycle those pages
> and immediately DMA unmap and release them.

That doesn't work, AFAIU. DMA unmaping after page_pool_destroy has
been called in what's causing the very bug this series is trying to
fix. What happens is:

1. Driver calls page_pool_destroy,
2. Driver removes the net_device (and I guess the associated iommu
structs go away with it).
3. Page-pool tries to unmap after page_pool_destroy is called, trying
to fetch iommu resources that have been freed due to the netdevice
gone away =3D bad stuff.

(but maybe I misunderstood your suggestion)

--=20
Thanks,
Mina

