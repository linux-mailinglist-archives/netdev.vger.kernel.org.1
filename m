Return-Path: <netdev+bounces-197381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F3AD85D6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF82C17FEEA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15369279DBE;
	Fri, 13 Jun 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSndNwJw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B1272804
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804082; cv=none; b=NsZxczoUy4/PnMKujZ7D4SPKU0KEr7se0UT+jQ/h7BZWIpt2U7EfUMoGZrx4+ZSUO2aZ02SmZLKvRezMf2o3qsPXQ6toKrmvopaSQbT92dmGTeX41urcKJJWYRIr2jk0P3AcOU1QcoVJIMr/IBiAZ79akWlJqIx/xe/k8bZcot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804082; c=relaxed/simple;
	bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E8vHUejS80Nzm3j4zKwN4U6iFME7xO7jnfMiY4j1EQkESBudJxq8jFTYjPQwqAhg2mS1Biz/5gT85RR67vJ1Yb0jqAWkKM7y8sZo8smPa0MFXAbCYmHTuPKxX4zkUOLkn+9JOlDDn/wNGog1OOwnwbmhjUMnzUSB+lwNS2zn0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSndNwJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749804078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
	b=NSndNwJwQrDpea2Pd72trfT4rk3PFyDpI6TMWw3cV1VrhK0K9rM4vrrjB4IVp37x8hfUzf
	Gxe4xA7Wr0o2En1N73KcI/8GUdM+rtpMAPW/a9hIyzHJqXuNY0aeYpYCD57enUyaqctFQR
	DihTQYCZag+PLis7WRAJgIm0S+GTc4U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-L8Fu_8r7P4eLHbWujKzP6Q-1; Fri, 13 Jun 2025 04:41:16 -0400
X-MC-Unique: L8Fu_8r7P4eLHbWujKzP6Q-1
X-Mimecast-MFC-AGG-ID: L8Fu_8r7P4eLHbWujKzP6Q_1749804075
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553af0e0247so566035e87.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749804075; x=1750408875;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLmTKI+Q9DOfOhx4cbhUvOqosks41IEI7ecv711gzTA=;
        b=rAE9Y/i2EXPuA7+uEsPkyCHz60W6BmALm81niLGrRomkWWioRiLwag59x7s2Lwsh2z
         soKeyBTgu6M8cVWZve9O/51wzjXipxSpGSwEMWpU0KZTuVOk504mRdBWqoOoQfb2fiKX
         I0LtAjg9KXlIPOIjj7bmeX0ECBgYf+H/3Mzgx2bwKnPaI2SUNVB2wqpy7Hp3Qb+2EhhW
         VxIbVOYc9UUbat3bv3xpbhXyISoM+Q2fr1qYfRnSs0SKOpuMf2EvqNYfi74L2ahvgPmj
         lRTNtQ4cVzpFEWD4nxNpkTvgDYER/9gU/ZcP4FUXiQBYM1LK9lKhZMiVEGddeV0vRSEw
         w0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3cSOZm01VmOWjOmhUtGahodtP2O/fYkRT611gSKhR5Zgi/wVu3PKkHEvV+vChL8GJYWzFpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6baQcAPxpax8IEYxQdfuXgitLZ3RRVjKXvACvB85lendJ4RFr
	5W4uyzRUU7MAi2lDOaH4qO0Qjv6D6c1X0GZk+5Wzb5x80YQDzVE0mmH2rqBL7iwzWFMhakK33S2
	WdCaOxix2t4OXzH8sc7mbx6tgaTx6HIZtyh7w9HPd0D7WK3nd4z9GkYdrPA==
X-Gm-Gg: ASbGncvkHgtbo5PLWP2qtjECYZF+i1vYoQE7iqw4GUi+bWVM7sgOJDD63Q5tNzm7EX2
	AcjnlzFRGER1yB+cGJ4UhQTajyybq6eW1DaifBVIfIAU26ocUNUU/s/2c7rkBs0S5aphXz5MVE3
	Hk20H3F7hGiFlHvFdnCtBwyQPMzF7/xUvgsk8RmHgbN5wf5Ja+4B0JO4bKx2BOsLFn1lXhA40XG
	1wrtzuKplIO5Z3+Wl3TIaSU6G4hpyY8KCl5YzpsLYUvwKnzV4I1bxmSRrr38pya2+rHVjNTCaVD
	9aNQ+j6k16yxqkTrNiM=
X-Received: by 2002:a05:6512:1590:b0:553:2969:1d54 with SMTP id 2adb3069b0e04-553b0e7db36mr492384e87.8.1749804074732;
        Fri, 13 Jun 2025 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8IpMdUtTgJ3Dn5a0CMKZlpCnJMUPmS8+a17CagSgy2Cpy4kjX5FwqO1WhjH05IZnnYmmi5g==
X-Received: by 2002:a05:6512:1590:b0:553:2969:1d54 with SMTP id 2adb3069b0e04-553b0e7db36mr492364e87.8.1749804074236;
        Fri, 13 Jun 2025 01:41:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f76fesm370344e87.226.2025.06.13.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 01:41:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 708031AF6DCC; Fri, 13 Jun 2025 10:41:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>,
 gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250612070518.69518466@kernel.org>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
 <aEmwYU/V/9/Ul04P@gmail.com> <20250611131241.6ff7cf5d@kernel.org>
 <87jz5hbevp.fsf@toke.dk> <20250612070518.69518466@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 13 Jun 2025 10:41:10 +0200
Message-ID: <87zfecrq3d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 09:25:30 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hmm, okay, guess we should ask Sasha to drop these, then?
>>=20
>> https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
>> https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org
>
> These links don't work for me?

Oh, sorry, didn't realise the stable notifications are not archived on
lore. Here are the patches in the stable queue:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12/page_pool-move-pp_magic-check-into-helper-functions.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.15/page_pool-move-pp_magic-check-into-helper-functions.patch
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.15/page_pool-track-dma-mapped-pages-and-unmap-them-when.patch

-Toke


