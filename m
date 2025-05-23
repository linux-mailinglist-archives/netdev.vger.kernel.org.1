Return-Path: <netdev+bounces-192980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF7AC1F0B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D653A49B3
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 08:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D82036ED;
	Fri, 23 May 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N62MAUSW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F11DD0F2
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990723; cv=none; b=TyYkuc2Vd3G8S4vFemNiSuCZlLLJTvJAIBE+gKvRESnRd/2qN//bSRdUkSq98zvR7z3Cec+aRMt3Uoy/sXGcDqvubyxfM35O3uYzZSPvI99KcAVW0QjuDT32zlOM4RrQIaSMGp3mwx36OSBuWcKogNR6cBogiAZI2d//Whs3qWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990723; c=relaxed/simple;
	bh=zDRzq9Tfty91GtEb71CtKU6V6XsJ8Gw0d9DOAy5jhc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbiZv8vFdw5a21tKYcmsNvt/LgwqbO5H6fSkl6qN756XO4EBj8otmTRn1O+PqkCOlRhoJ/GgG3RF1wDVEn0PPcrT3t8RDhmf2iH8ceGU6ziZb7QHTM3xSGNoYeSjC+2W46YE0tRSztRolOJZI1b14sTxWxqUYp4wfsOV69tOOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N62MAUSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747990721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6J/RUYS6OBOPvuZyXgo5WgF2pNpessZJIoWwbAcSf0A=;
	b=N62MAUSWPqMvB9zMaUDQUYlVbYDGBrEmdZc2fcaWsEhRSAPj0XjfRdLFMPFIEHQvoXyz5n
	OxDDHRTJDRqKaDM2Ax/cQeMjhGlHe7+N74gKmcDVwH3ontyxEotFaycuXqPXem9RUFZKPx
	xuGQNo0GdfCyLkqHpp/B1HFkA3UvS2k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-DOwRfVTLN76fM6lVQcCcJw-1; Fri, 23 May 2025 04:58:39 -0400
X-MC-Unique: DOwRfVTLN76fM6lVQcCcJw-1
X-Mimecast-MFC-AGG-ID: DOwRfVTLN76fM6lVQcCcJw_1747990718
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-551ebc1bf86so3586253e87.3
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990717; x=1748595517;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J/RUYS6OBOPvuZyXgo5WgF2pNpessZJIoWwbAcSf0A=;
        b=aAANeHRuTsvEi3wkinaaFSbZRfBkC974VuMumbzqDXRIxKucCqIgg98sfmbgW/5A49
         hHs+dE8Rj1pYQcG12TvcLdA5RGEokyDZmYPShwu3JK0py7TAJLdTCYqjxXdGtBg9joPm
         i4KmUO7aHerl25p4XjeK2Q6+aMAg/5eXiuQinSLc3HFItUpdCX39wEzajv38JA43Quqg
         iz+WBx+u/uSqvCI8SRVHjNkffsIF8DNOyi2beebzdyhOu9BJyvvKdseiEGVfe6I2lY7/
         MzHv6cceTY6hhWxXna9xjs1AsSpVjoXWNL84Viey6xT9UZXzA8JW8WIxhunhNw+eXpG3
         2nxg==
X-Forwarded-Encrypted: i=1; AJvYcCWdckS2OQlDheeHPrmiDyl9Srv5NUnaFX+ew230WBWlaA+1RTMlEJZ/HUef5yvV11E0FsX5W0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCgJAqwAfgSNDGBsPjWu+nPaJLN+ekDMeJeSsN9R2euAB4j/J
	oypTF3ee8PGoRGfZBeM2fA+wHb3mEfoqWWGo58vXZJ7zg7i+LVUru5qnVrD4SzE/KccUxi+KC9F
	5yGCjWrCuYl0a5+WeN8AMHKTiEgGNvx6lbD8/HLYLqN/f9V8FqVnV9S+y2g==
X-Gm-Gg: ASbGncvxR8Iwnrllsy2/HjNRK1TJ86DQW6ZZ1vYSegVIagJeE7DtDV6AKHf/MgBWly7
	y9K6AlXqx5Olr6X8YlQdp59HpOznwMBnKG+w+fTbCjo+DKkVOKb58DuwWk9WmVwSfAW8+JK8Yp8
	FuVYua0ZlCFCsNe1vkgYVw6CboXCli8ivqpQ5PwvWXq46JX7gzQ6Bbylat4r32azPMnX3Rtrwxe
	6FzgDG8NHw5MgsaaRLJEMTEz5nQuFyuaz8EJeARa5qoIgwDBNXtspNU+re0oC1LfMD6nfcynHIv
	5YQVIF8aDaDNlhlPg0UZWQqluwnzDBW4m5ez
X-Received: by 2002:a05:6512:3083:b0:552:31c:d27f with SMTP id 2adb3069b0e04-55216e18aa5mr550264e87.6.1747990717436;
        Fri, 23 May 2025 01:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGupqC+46X0tt6Ygg6tbBTVVOo7BQlw5aLij8Bq0jPcx2TjqKILidIf2WS35eedcHMuDdsdg==
X-Received: by 2002:a05:6512:3083:b0:552:31c:d27f with SMTP id 2adb3069b0e04-55216e18aa5mr550242e87.6.1747990716968;
        Fri, 23 May 2025 01:58:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702e03dsm3786008e87.195.2025.05.23.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 01:58:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D7C101AA3B8A; Fri, 23 May 2025 10:58:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250523032609.16334-13-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 May 2025 10:58:33 +0200
Message-ID: <87ecwfn1om.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the effort to seperate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid accessing page pool members
> of struct page directly, but use safe APIs for the purpose.
>
> Use netmem_is_pp() instead of directly accessing page->pp_magic in
> page_pool_page_is_pp().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm.h   | 5 +----
>  net/core/page_pool.c | 5 +++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8dc012e84033..3f7c80fb73ce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>  
>  #ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> +bool page_pool_page_is_pp(struct page *page);

Here you're turning an inline function into a function call, which has
performance implications. Please try to avoid that.

-Toke


