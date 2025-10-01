Return-Path: <netdev+bounces-227448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83672BAF9DF
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16183189E49C
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073127FB31;
	Wed,  1 Oct 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV4CTV0X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237C27B35D
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307335; cv=none; b=OfSDmbExdf02auumcMIkUGKZQoAOFkYnc6ogTl4AX9i178uyVKniMK1tDrORh2Nn7uu+aZUXWvK421+64qzn2Hrub+FiITun1YwRUwXrko5ij3K8EpMgVjpwUhD7N2ENwwFYzQBSjpJgEjBYdwLMPpgUBdS6UCGKX7QxxDexBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307335; c=relaxed/simple;
	bh=mAs5jC88keGuTS1kfSau2lPlyfOYPIVe4bEKVDeisl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAMQ4W9GI/5lbGaTFYsnEWej7c8RJSRxbJ9iId6/w82zhqdxN0eilX75a26FHSIyayMp2qPHu7xIfOKu6jyQFTAW+gZ4bLc0HkiSPZ15nMDScMjvkmx1nCevRGBJ/FVX/9Vm50zLCffRDETeF1d/Fn3NdoIoUhBNBua/Dek8zpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV4CTV0X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759307332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TH59Sw29O2jzr1UeKiMhScDg0sFiTxNL4gz8DMwSkfs=;
	b=CV4CTV0X58bYu9fP/YaC+3zEZj6a058H985Prml/CoXCp6vojHQ0je7NOXFdROFJniQLsR
	WKTfKXdFAZldsNSOUfhixhUAkq9k6W2aNy1wm9TKx+Z3C80QeSuVByOMz/2pl7gmwrXj2S
	QlpG/RhbKr2D+v5qRsvaC5LLLm/vFCI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-eXVo8rnqPTOIa_x0sF5dyw-1; Wed, 01 Oct 2025 04:28:51 -0400
X-MC-Unique: eXVo8rnqPTOIa_x0sF5dyw-1
X-Mimecast-MFC-AGG-ID: eXVo8rnqPTOIa_x0sF5dyw_1759307330
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6339aa08acfso1099911a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 01:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307330; x=1759912130;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH59Sw29O2jzr1UeKiMhScDg0sFiTxNL4gz8DMwSkfs=;
        b=AVlIfy7e7JF50Qau/xNolma6ENQJL0jBy6yKVqBU3JHUkfbkxAjUizmXDT4IScz3Rc
         /HcXLheMedH2C9vTbdB2Tv2zpZKGy8r5xUCK7oprggHwCVlYm6ZUq5iQD8IrfyJJbFNp
         6yvgE4pTJyHTgk+C4Sl4Gll6DMuHi3U7v4IIFwLyCd3YQFEv6nW2HJkR35cCv9Wa8i32
         n5uvbodJ6e2crSTw2Rx70n7X3IYGvZIzjnJAdYY16L29/8Fv1qR3E8DqRQt6xJ+3sFpj
         fmQnFvI8pv6gkwNbv+b5c9U15GygPeyWBZeOVxoEIqiOLR8FBxTZxDJN/mWyo5uZNE5j
         paFA==
X-Forwarded-Encrypted: i=1; AJvYcCVFVcv+Kforg2arTsaL81PQFGUmIG3mA5oQj/ib/b+B7dqLH0H5n6UQtXjiJjgBm+g8gRdClGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00+GB+DIGJmg8U+f6obe4Vz6XyJtrsPRcB/VoLTI999uwT06r
	1eNC3vwLHQ3C2QyvnvwNQyoInlVqkOcjNUQ4F0oW9Z6G3tcgpaljO6+98vROBWPSsRDhZTO3hsG
	v3hb7tHJy8OX6BEytJjjTqEfdoHLemEyGc9ATabivyuilA091ScpeAE7kNw==
X-Gm-Gg: ASbGncvbjzogPP4U9+z9Zq5WyOVlwftWEqf23AA5wMuS45tXBeedl7zCkPBjjnrPTpU
	7hnvKIeo+pzmJb049SEBxrz9gxOfGuXqsyLFbqXrnqV7b6jiQYc1mX4cZtWF2q++W8uJFw77Dnr
	SpvYMntOfY9QjzSjZKMlpg+oE7ddmGMHMCXxqAKPZDvfUSOFUOc7wvh/qVhD0Fs4zurowCgOXFj
	kvBa7h8kA+Bo8+RJ+cF6hUIsAvWlRrRfkZDLn0+bazF0vFW6D1cQo6xVCX3w8mY9PJiX5q7rUYG
	fMbIIDIFqgUicjRB+Ai5czXe3V7q0D7TC3qArNq5YM0Kk84XKd1PkaOm7LHTYO4Ouuymrk/a
X-Received: by 2002:a05:6402:1e8e:b0:636:6e11:2fd1 with SMTP id 4fb4d7f45d1cf-63678ba63f9mr3429910a12.4.1759307329889;
        Wed, 01 Oct 2025 01:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj+PdPhsJi8Z+hoZrTRC6U/N/PUjMCvkDv55wnRbOMIuFkZ+Ix/bmpUxPMb7w+6Ds4kpGBRQ==
X-Received: by 2002:a05:6402:1e8e:b0:636:6e11:2fd1 with SMTP id 4fb4d7f45d1cf-63678ba63f9mr3429889a12.4.1759307329463;
        Wed, 01 Oct 2025 01:28:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63662dc0a3csm2990346a12.48.2025.10.01.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:28:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AF4DF2779AF; Wed, 01 Oct 2025 10:28:47 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Mina
 Almasry <almasrymina@google.com>, linux-parisc
 <linux-parisc@vger.kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing
 on some 32-bit arches
In-Reply-To: <03029eb0-921a-4e45-ab23-3cb958199085@gmx.de>
References: <20250930114331.675412-1-toke@redhat.com>
 <03029eb0-921a-4e45-ab23-3cb958199085@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 01 Oct 2025 10:28:47 +0200
Message-ID: <873483m3eo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Helge Deller <deller@gmx.de> writes:

> On 9/30/25 13:43, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
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
>> dma_index storage when there are not enough bits available. This leaves
>> us in the situation we were in before the patch in the Fixes tag, but
>> only on a subset of architecture configurations. This seems to be the
>> best we can do until the transition to page types in complete for
>> page_pool pages.
>>=20
>> v2:
>> - Make sure there's at least 8 bits available and that the PAGE_OFFSET
>>    bit calculation doesn't wrap
>>=20
>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them w=
hen destroying the pool")
>> Cc: stable@vger.kernel.org # 6.15+
>> Tested-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>   include/linux/mm.h   | 22 +++++++------
>>   net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>>   2 files changed, 66 insertions(+), 32 deletions(-)
>
> I tested this v2 patch (the former tested-by was for v1), and v2
> works too:
>
> Tested-by: Helge Deller <deller@gmx.de>

Great, thank you for re-testing! :)

-Toke


