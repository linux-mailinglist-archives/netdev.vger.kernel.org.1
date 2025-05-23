Return-Path: <netdev+bounces-193120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F7AC291E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13864A7C0C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F9298C15;
	Fri, 23 May 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOUs8Z8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870829899F
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022969; cv=none; b=O8pZAkeAHTQLDb79Ihr/iMWTWBzkJIONJ3P3O2f5oDVqqPsFB+XwlUw5CGwMcRR5k0E/75AxUx8+Eyjdl7U08f39Y3+c9WRj0eLiOByhojKCXNie6BLIbdqojh2tBiiz1sg7lXx9Mspalt3LsrjCmlIX6Pgq8b2DmB0oaQSFsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022969; c=relaxed/simple;
	bh=WRdnaGverlu7vTJ/60vt4tPf27macSfbJ1NcFaxcNBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vuh/yz/B61H3RhrWM7ew6RqFHdL+Es2b87SEbRyDS5BRYc8QRQjwP0wQHItW2PpZpvx4dNi4U2txsiXn3+EBfVcJwpkQSgREovCZxqwY8pWbPA/zZcQDmmw/Hr4/VtMbryZsL8SnDm6pTMurY7H/oxfpfWA6xa7M6Qt+i+pWfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOUs8Z8s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231f6c0b692so20385ad.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748022967; x=1748627767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKcG0kIzVQf2DFouXJTY346ztiLo6ETHd82n5f0p1Bw=;
        b=yOUs8Z8s6c/C4RQQNv1FU7Guh1Tu1dVHcoYHiuG11x0R9RnzkCP+r/ZNI5iHnw37LN
         m+juLUTs2ui4CerCmTy3zw8bLSwGx25B2eiFBftZhkPyh9onz72r8sj75Vo5kdAoBZm2
         BX98Jp7mA7kdd99V+ATBsssAaprGsFPpzqpeCnp3+G1OgTjM2IiwZJzvXNlpErLBTRRB
         dPmO89NzU6yeIuTM9Nwo2ozlNf/S4TD1U2Rm+zwvpaguzcbO6TzYoPZQLex6OypDF9m4
         7K/6pjFiiNi9787QNNorvKP3tXyr65d5nclf26p38Kr7mMHElWtumnxpu5iRgsMANTuW
         zjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022967; x=1748627767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKcG0kIzVQf2DFouXJTY346ztiLo6ETHd82n5f0p1Bw=;
        b=r/8ynKZwS96dblP4UVlAS6vqCTHlpT44qVhqICaLwbq0swr+cUjom92T2Bi/yn3FbP
         1mOqBbbrz4IRaLhvOoHhSYj6banOGJ0Ry4wmDEoYubkFh0NqE+EcniYYAS160hX3NTRR
         +cWC4ZZdpkrIPZuQ0OkAY1KtKpguxsSqsaWh9dRLJ7VsZjHvW9/VIxI7o5TNuVn4HHlV
         1Pi5xPja1O0EQzy8WV1AMFrFxZNmSsnUCj9sZDaMTCrTLckOEdju6CrcM0lfaqVCnWZh
         BNXTU1H1wQBBGTI+D8UckmmttvHGux96mQPjC9x7vGG9xvYDDPqM/kSoBec+RR/wbYjS
         Eo/A==
X-Forwarded-Encrypted: i=1; AJvYcCVPTp2FRny/EFBVusDNl94G30L3bEJreKrTZdTyt/S3Tt4Xkn0YdN9z0MLwFOYWBfYM/g0OixY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbBqn9f1xfLJcUlrqbtM1FDCYW+UBILaF5WgIky6KJTxnXPak
	9s5CzVj3XzXa4cEb4jLsrEe6hbQfbMCOi+KggRDClCvnRwejKuCpaIbLMLLEewvwFGMC/AoG2CY
	5NmsKycSfbYs7xyVDHzKnMXQCf3WmfZZSOXSjPnUF
X-Gm-Gg: ASbGncsQf3q9olFe3QFehwbPzfU/gg6Xtx2+P1VCf8scEs3tjPElXGxE4EchzfIoQLG
	A5h7xPsX+LuxoKdFZidDauj2nt1sYnNJScOwgRDpy2NvEzLosckeUFRx6VVmbYAJkiBkLHdVpYi
	xPnjdmq5nVNQhWxDru1ZRXvICmbZ/fdoOMzAF0GGPETxgsOCJJjG86hDpqZeMpycOE4Diwx8YUh
	Q==
X-Google-Smtp-Source: AGHT+IHG7QjmSnQi5VQF7H68jYu342TfgU01VfBj8sRrando2xNin21bTuvUh2YHtW/IvW4mbUWhDr+UVPFZB1gCm/k=
X-Received: by 2002:a17:902:dad2:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-2341808c7d7mr64375ad.14.1748022966452; Fri, 23 May 2025
 10:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-19-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-19-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:55:54 -0700
X-Gm-Features: AX0GCFsYNuzYJlporwz1mSapGXVg6LAugMmId4ntk8vawow7YJm9vkQ7qXBE0cE
Message-ID: <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct page
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that all the users of the page pool members in struct page have been
> gone, the members can be removed from struct page.
>
> However, since struct netmem_desc might still use the space in struct
> page, the size of struct netmem_desc should be checked, until struct
> netmem_desc has its own instance from slab, to avoid conficting with
> other members within struct page.
>
> Remove the page pool members in struct page and add a static checker for
> the size.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h | 11 -----------
>  include/net/netmem.h     | 28 +++++-----------------------
>  2 files changed, 5 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 873e820e1521..5a7864eb9d76 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -119,17 +119,6 @@ struct page {
>                          */
>                         unsigned long private;
>                 };
> -               struct {        /* page_pool used by netstack */
> -                       unsigned long _pp_mapping_pad;
> -                       /**
> -                        * @pp_magic: magic value to avoid recycling non
> -                        * page_pool allocated pages.
> -                        */
> -                       unsigned long pp_magic;
> -                       struct page_pool *pp;
> -                       unsigned long dma_addr;
> -                       atomic_long_t pp_ref_count;
> -               };
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is se=
t */
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index c63a7e20f5f3..257c22398d7a 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -77,30 +77,12 @@ struct net_iov_area {
>         unsigned long base_virtual;
>  };
>
> -/* These fields in struct page are used by the page_pool and net stack:
> - *
> - *        struct {
> - *                unsigned long _pp_mapping_pad;
> - *                unsigned long pp_magic;
> - *                struct page_pool *pp;
> - *                unsigned long dma_addr;
> - *                atomic_long_t pp_ref_count;
> - *        };
> - *
> - * We mirror the page_pool fields here so the page_pool can access these=
 fields
> - * without worrying whether the underlying fields belong to a page or ne=
t_iov.
> - *
> - * The non-net stack fields of struct page are private to the mm stack a=
nd must
> - * never be mirrored to net_iov.
> +/* XXX: The page pool fields in struct page have been removed but they
> + * might still use the space in struct page.  Thus, the size of struct
> + * netmem_desc should be under control until struct netmem_desc has its
> + * own instance from slab.
>   */
> -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> -       static_assert(offsetof(struct page, pg) =3D=3D \
> -                     offsetof(struct net_iov, iov))
> -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> -NET_IOV_ASSERT_OFFSET(pp, pp);
> -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> -#undef NET_IOV_ASSERT_OFFSET
> +static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _ref=
count));
>

Removing these asserts is actually a bit dangerous. Functions like
netmem_or_pp_magic() rely on the fact that the offsets are the same
between struct page and struct net_iov to access these fields without
worrying about the type of the netmem. What we do in these helpers is
we we clear the least significant bit of the netmem, and then  access
the field. This works only because we verified at build time that the
offset is the same.

I think we have 3 options here:

1. Keep the asserts as-is, then in the follow up patch where we remove
netmem_desc from struct page, we update the asserts to make sure
struct page and struct net_iov can grab the netmem_desc in a uniform
way.

2. We remove the asserts, but all the helpers that rely on
__netmem_clear_lsb need to be modified to do custom handling of
net_iov vs page. Something like:

static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_m=
agic)
{
  if (netmem_is_net_iov(netmem)
     netmem_to_net_iov(netmem)->pp_magic |=3D pp_magic;
  else
    netmem_to_page(netmem)->pp_magic |=3D pp_magic;
}

Option #2 requires extra checks, which may affect the performance
reported by page_pool_bench_simple that I pointed you to before.

3. We could swap out all the individual asserts for one assert, if
both page and net_iov have a netmem_desc subfield. This will also need
to be reworked when netmem_desc is eventually moved out of struct page
and is slab allocated:

NET_IOV_ASSERT_OFFSET(netmem_desc, netmem_desc);

--=20
Thanks,
Mina

