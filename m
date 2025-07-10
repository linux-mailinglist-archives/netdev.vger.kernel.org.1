Return-Path: <netdev+bounces-205897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D9BB00B80
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6CB5A5E36
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79F2FCFD4;
	Thu, 10 Jul 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5VgZnHB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E627145D
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172550; cv=none; b=PmlKGbughQpY6SCSx8mtgjTqWt3wmKIsZqd1pp1+RbaXTY0AIOAgwOVP0sD3X8cOmnUkjr8kuxdE2j9S3Hm1ZgQny2yO4Oetbctku0YHfFGS0aW+jlkqpWziKzo+k3XhD5xYBdWHoDqiJhzQBEJMtbYiNFsBqY5oV2o/MzIaGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172550; c=relaxed/simple;
	bh=BQi/oAxmvttoMCkmYmgHMY9tc5kt6YdUCM6RxGff5II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvpGDdoAR89Dcec7V1uXKR+NQSvf2/TCQsEIcXxuOFBXDhJ/GjJJl6bkqxR57VkGMGdNV0J+pALz+J6QxUoZtHIKaGzZzWzXJbNCNmTqru2j/4gezT+UWT0K9XFjCSvA4EK4K4FKsK+z7tz8VKlxB0lKhuc4XsVF74eji+ceqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5VgZnHB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f18108d2so31535ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752172547; x=1752777347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUFyFG64jchMDy9nJZhwnx6mFvVO2+1zDBN4KcsNtGQ=;
        b=V5VgZnHBUAwpIKTq3Kone9pNEIxn1KsfehINSGQXDEJfYnBfLnPl21en0eF6+49Qfs
         IPEJOc8dP9hY6i4PbXLFaSWPpd4u/BMAuR8BV3qOcZuLxkYayCSzAwwTQX4zu9nf5vBp
         r1kGNnpX6l1kYIdXy9XwnzsZvOrOMSuK1VNBw6KJbTceShJ1ZD/VRlIyTrsVYcw0R5eJ
         a5xbvLIeqGPZs3bORCV26MrxNxkd/QG2JikR04f4cA66sAmjo0xfQxvVduEcfrGgaq9m
         a8wbPnuILhBPwzAg+1iqeYBopGM5PoqkBRdJ41S1Ybp7lD6+mFpxx5MI7QLb3FBLVv4t
         03tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172547; x=1752777347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUFyFG64jchMDy9nJZhwnx6mFvVO2+1zDBN4KcsNtGQ=;
        b=hbdNbu/UN4TZcOZxUrYXXRpCsZogpsx48lCZpUhEuThOHNqluJUY0+763kvgRLIvbE
         ytcR0546+y0XB7Arru6L3ITdoSOVRlUuJa+VMEOxUIrbWPk4ZdQamVwNzhPeQ4N5Nil8
         efdW4lnMTAkxOAQkiq85GQzLZBTAQo/N1Ufox1YNjdfk6+ryDiSynsuoqjnFTKIjtKHl
         DCUBK2P+srz+HEcb3ei5a80xYRDYlqLd6sT5+62P2UPdJdaK2fP/CY1yqYG21QJfc7ID
         RhEVqm8zDKjdsBmuASlnSsdcGQHSJJfx2PH2e6rTf9J6yuei5sVQafhL5b05bOXuQ3Ye
         5v5A==
X-Forwarded-Encrypted: i=1; AJvYcCW+YoOhJPuTTI+WynN9ktsTpNkySWQ0GdeAVzU+fsbHFMRVPtdbKAYZksHmx8kIUw8+LOUk90I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDitFMPQSF+xpDxtHhtWQU8p8qapxnm+15gWH0ixK4PV0vkySL
	vGQh6GU53LMXugczT1ZQH8sNUkxnDPEkZxTrfLPfLH38C2hRO21J+L6N6YWAzXxVpwwOquO1615
	kOWfuYVMnYgKRII3OGXKcNq5Eym5mgSY+jQANilHB
X-Gm-Gg: ASbGncsV4k2103km/EV5hRUpWRlM6Sm2v/vRLFHo3CPV6RfR+vkA0Xd8GoavOkbJXoI
	UuU69Q/Lx4nnrCjbDWjL0hNpL5K+AtWQRvCwn9ORRIBuD8IkEb5Wz74MolcaAl4bBxe7Z5Ar9xL
	Js+y9S3WJ1+xh82JYR19S4mva9dvQA4oWG4sEgwckPsmfi4gesOfB6YiAy+vuO9f/edv1zhAY=
X-Google-Smtp-Source: AGHT+IEzZmw78/OSXjJWOTZycozUs1vUEUMKIB/o/lKBX8kmUgnw2fbBaI4EEfFVqfugsZvpbjLQdKz5IhYTiVxWNgo=
X-Received: by 2002:a17:902:b095:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-23dee18a914mr236695ad.8.1752172546684; Thu, 10 Jul 2025
 11:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:35:33 -0700
X-Gm-Features: Ac12FXzCBZV3mzo5-D0lWEghMlDgKwI9NFBNKAUpNVy6DriBk8SQ-mKMDpELnTI
Message-ID: <CAHS8izMie=XQcVUhW9CmydTqYEscp5soeOT4nwvFj2T+8X1ypA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/8] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Hi all,
>
> The MM subsystem is trying to reduce struct page to a single pointer.
> See the following link for your information:
>
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
>
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for page pool.
>
> Matthew Wilcox tried and stopped the same work, you can see in:
>
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infrade=
ad.org/
>
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
>
> The final patch removing the page pool fields will be posted once all
> the converting of page to netmem are done:
>
>    1. converting use of the pp fields in struct page in prueth_swdata.
>    2. converting use of the pp fields in struct page in freescale driver.
>
> For our discussion, I'm sharing what the final patch looks like, in this
> cover letter.
>
>         Byungchul
> --8<--
> commit 1847d9890f798456b21ccb27aac7545303048492
> Author: Byungchul Park <byungchul@sk.com>
> Date:   Wed May 28 20:44:55 2025 +0900
>
>     mm, netmem: remove the page pool members in struct page
>
>     Now that all the users of the page pool members in struct page have b=
een
>     gone, the members can be removed from struct page.
>
>     However, since struct netmem_desc still uses the space in struct page=
,
>     the important offsets should be checked properly, until struct
>     netmem_desc has its own instance from slab.
>
>     Remove the page pool members in struct page and modify static checker=
s
>     for the offsets.
>
>     Signed-off-by: Byungchul Park <byungchul@sk.com>
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 32ba5126e221..db2fe0d0ebbf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,17 +120,6 @@ struct page {
>                          */
>                         unsigned long private;
>                 };
> -               struct {        /* page_pool used by netstack */
> -                       /**
> -                        * @pp_magic: magic value to avoid recycling non
> -                        * page_pool allocated pages.
> -                        */
> -                       unsigned long pp_magic;
> -                       struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;
> -                       unsigned long dma_addr;
> -                       atomic_long_t pp_ref_count;
> -               };
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is se=
t */
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 8f354ae7d5c3..3414f184d018 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -42,11 +42,8 @@ struct netmem_desc {
>         static_assert(offsetof(struct page, pg) =3D=3D \
>                       offsetof(struct netmem_desc, desc))
>  NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
> -NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
> -NETMEM_DESC_ASSERT_OFFSET(pp, pp);
> -NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
> -NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
> -NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> +NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
> +NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
>  #undef NETMEM_DESC_ASSERT_OFFSET
>
>  /*


Can you remove the above patch/diff from the cover letter?

--=20
Thanks,
Mina

