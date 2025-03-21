Return-Path: <netdev+bounces-176770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F632A6C119
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E743E48322E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB6822DF83;
	Fri, 21 Mar 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ExufT+n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729F22B597
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577417; cv=none; b=Uc4SPd+Fu6p9SlqNlEaCP/Ei/0SZlTDzVE0k5kGm1zl9GkiRfqEaodVuJ+eJfb+fZ/oP0p5aZGRSAxilD/kPrwl1ezynYUm+YDT1rOaQxfZHyN+2FSiakOZOcT4K3BDWrmaK5aK1wVzaDgp6POHx62OmjWpaQkIQ/g21lkW239E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577417; c=relaxed/simple;
	bh=GF76z/gw6/XYCeidT43ebdiAMeBN3LvsPNBDBQrg7YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoqTejMHhvtOG9vGAn8sPP8AzuMHuD55zzEl8SKPeETMDExcG4iufYMBn//tzHlmlo2ZoUtUc7bZEay07hESLv6ZbikiryYRe7iDE91WuYjGqO7vEOWFe/mR5uZ947HHiNkSCIjAfKEJe1CNIG7OVqs3DhD3Em6mZpp/FnqpHws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ExufT+n; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so502a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742577414; x=1743182214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF76z/gw6/XYCeidT43ebdiAMeBN3LvsPNBDBQrg7YM=;
        b=1ExufT+nazhlKz2oe2+tlrbwfCoaRGvifx5rhrQ/FXUblFaAOrpuoHIvsLs5h1pgCo
         X5AhsXJtW8P8zGkhpLFBHQZBWAQT3N/eN+VZo8ltE8ZeyAdyvk26JkXjWqP8ZDGjrVLu
         0MFZ/xLmpHiJL5S0G2vCDJzoT3WBMR95zGBIDGJUJW4Ntrv3mFweMVOdGN7akgYzwgFU
         d3IndcfRiMH+RPKj0DUmq8A6QxO7fjMtjpQmD73c+5T4SENiEWviOPfBnndz/so0vHTU
         U07Y7XjRuKJcxDJq+HT0fuKpoQhOdN0oDZkrUMms4M7b7nYwJ6gPeNSXdYA/cnNoat0N
         XMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577414; x=1743182214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF76z/gw6/XYCeidT43ebdiAMeBN3LvsPNBDBQrg7YM=;
        b=nkKuuzZcUbdCxjXsmglF6e4PRfnPdu6nuagOM4y7jtuRJxMuC8dm1UT4J2oABZxwOU
         UYbQgM+skmNpn8m+sTomuf6TPIFvwFJyMUHLKPgeoYnBm4mc7sdhFsZorinneood80zC
         /3//GZsTaTaSPL/PFrNTWLm/F724DaMFrC88xWIhQNDaOii0tB/ivC1S5+5/IHHNTykj
         3v1niN7orOYgmjZwFOiqdz6NtAuMydimsIqJY4KZfkJN9WSDu4U8JZJMdAS7tF+ssYJP
         t1ug/3Lo2kFsKVvcQpGeMQFC0ZX732VZXEPbVWQZqjDI6NCVylIGDpNr/SeyWPbW/79J
         uWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlVSyDZALrQL7UbdCQniOfAgXki3o8VOyLxsWpagyTNpYbtd63LKwDX66rIZKmV+c5MqpItGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3AHvirljBwQ07hOC8LRtVHA0DSx4FxkoF4HJRUmLqgVOrE+A
	HTWhXw9qBAY3osPK4S0Hsz8bHrWXs0SqNVlI4VPw3XrKcQB56RnoqDZKsHkkywMr63kQBhQ7eS1
	2zvq5plinP5zYAjtcyvMDYbOa+nJOM5RoTshi
X-Gm-Gg: ASbGncuUqcFRjEx9kyKnIWdav6Q4okyByFPk4zZfChMVPasfrdL/AyKHOUBwZQx1TVI
	fEDlCOqN+5ucUpFAcMMKaGFtOaOOtjVzM4kxUfD4gAHjlcxUCFxRMOFUvWcuvDtj0pRJLuAxfji
	dGHR9K1HM3i9VSIlvOdjurokhILwm9y3qO0Yl1MvcZlaJ5aXiZJsS/PVmr
X-Google-Smtp-Source: AGHT+IH98cBXDDveN9rfl6GGcJmdCE4sTWw1fPkcgg6ndYVyXdIooR0jo6P0/9JLlSPXdrq0KQvrTrtTuAfJEOPcfyY=
X-Received: by 2002:aa7:cf04:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5ebcfec9cd4mr99789a12.1.1742577413456; Fri, 21 Mar 2025
 10:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com> <20250314-page-pool-track-dma-v1-1-c212e57a74c2@redhat.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-1-c212e57a74c2@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Mar 2025 10:16:38 -0700
X-Gm-Features: AQ5f1JpuhBehogw3WxvH8_uBEh2ngmkK2xaGkRPh_1xg8XM9z4JphAcaolSD8Kk
Message-ID: <CAHS8izOMXpYn=XdVt6ysd4SJ+qpPeUShnG9grCZEO7pcJqEVrw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] page_pool: Move pp_magic check into helper functions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yonglong Liu <liuyonglong@huawei.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:12=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Since we are about to stash some more information into the pp_magic
> field, let's move the magic signature checks into a pair of helper
> functions so it can be changed in one place.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Straightforward conversion.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

