Return-Path: <netdev+bounces-195811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C716CAD251C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507F11891214
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894021CA14;
	Mon,  9 Jun 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxFchhEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571621B8E0
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490762; cv=none; b=l8Ac4p79o2Z4ElY/zvzpxVLLoxzxeyzYXX4h05F2IpgJ9t9UC9UsHkygOoRCyC8IOxEJx8TtVeJzsoidUD0CwbOYzczVa9XPiiz59FfDtM/zplxRQdDIfQAcFB38vSiMXcMxDKu6yVgoR101z8IXH2uFLo7ZypF+PRnYHWFP0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490762; c=relaxed/simple;
	bh=vDEZLmFiWUgAEhhMnpPxC2x5ptegpxqcBtIXF4EgUvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsXgY305aCei+tgclDhHkiU5JquwRqeRxVYT+zXyqngronI/YKVP8F0VXqz34ps2xuE2nkVb5eN4LQdL2OQib8Eem/uM1W/XLP3FP9EDiHll035KsaD3W9kAB76WluBS4EisQx5euoqX60Ey+Hc6iM6UC+iv5r0bPuFyLwYmbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxFchhEB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so13255ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749490759; x=1750095559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RRpRkvuNJy3cXkOhH8biChoDOFuxh8lZ/u2fpQqLzg=;
        b=UxFchhEB/EOTc0w70KhZaY15W09uYu6jXZOdr2ase+hIfTCPnYc/ZCm8tpKuJPWiOY
         xZJfxn+61Ida+6G3EvB/BAOPBOyt9hI4GgbeyzuBG9TCxdpv0yWiNx+10mK38OG8e0YT
         njTgmMc4zguYLqaxNenGblIq6z0Z8wqh9hm59Kfbjy+dkQUMe6KED7usY9RvlBxgF+3i
         pCE1id1SQeHxgEQygp3chDNtfyiTg+MIK2RFk9nxvVh6TbdJiCQv8iz16M15ZPipF32q
         Gs6Q9ysEJjPpaVmI39FOiyCGGRz2hKEMgb7wWg+9x67ahJ6X0DcMqFebPc/FxvZhcJM1
         zfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490759; x=1750095559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RRpRkvuNJy3cXkOhH8biChoDOFuxh8lZ/u2fpQqLzg=;
        b=azVJuHzlwT7kdWdbc9TKXZmcLTwZ5MrMwG1HrweyuBkhI2LxnaFVbuncf/iucRkZcu
         pwi3dVw5o9MfQBCSQBy+Juhj1h2z7JW4PUizWZvGemIlDaeNs5S0Z30czuzlaMCV5p/E
         kRj1dKrrsnT1vbPoMth7AsxN4jc0dJVmdl1z/1ZW1FvXfp+Wcccv27QPJj7laxPKAm9r
         Bz+MOitp66PTkiJqjZUOFbjr0b9aCDaeyOkCPbeDuPWWEUJvXUsTnL0NkdZekk8/GgiP
         AGRY0JBlhC8cLViWxPA6yavqV0jqfe6u0hHeM4zf5MlHGSBkN2PcZJCX7CgblmhF8thw
         gfRA==
X-Forwarded-Encrypted: i=1; AJvYcCWh1duPFyb3CyjLicuPetbO6Tq10f+f8w42fY+rV32t3I7veLDzDe4gJ19mmb+gKBB//kO44v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHzxdxiJjKkVAMoWvWurjWwIhAiTesBaBtRSgTUWtYnxnsCSb
	/ta9ss1bDJ72BileYSNsMNNWQxU2CVY/X1oqI/fI368B7nd6ZjT4OrniP6rr0B81NwE/nOD/KoI
	8IJMtz63rKvHrpdDYkutugPyLEXJ3+dcIgxAiWS6z
X-Gm-Gg: ASbGncstIyRRNz+Wg2OGgfafwW0VjcOQLgPy+DTLIR0zhiAlQpMoAQpbXR5LLUiRVMl
	ts8l2YV13FPiLaobRljUeDVlg51bk9JkXe6PcHKmAN1ZbRm7JtLO+2lJBpL5CvkQrERjLgRyKeu
	vB3mBvMkpEbxJmKFPEO+quwPVOJ747+NNoepEw4FuP3PPbG/x269YtI3hXSUI5yPKWz2NkJiK6/
	w==
X-Google-Smtp-Source: AGHT+IEvrq24XpltBFWvdSIlKpCIc8JCZdMNJ6F/M800m9IOuRhKavTYagOECC3DsNK5G3lKUSM8nYe/B6o3T3jdn9Q=
X-Received: by 2002:a17:902:e745:b0:231:ed22:e230 with SMTP id
 d9443c01a7336-23613de3742mr5147245ad.15.1749490759104; Mon, 09 Jun 2025
 10:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-10-byungchul@sk.com>
In-Reply-To: <20250609043225.77229-10-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Jun 2025 10:39:06 -0700
X-Gm-Features: AX0GCFuAdxMyfuOpDJOl1NBEK5X2zXvXF5ManUgjd3SO6IAFQ752DFSmiJ8__HE
Message-ID: <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
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

On Sun, Jun 8, 2025 at 9:32=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/linux/mm.h   | 12 ------------
>  include/net/netmem.h | 14 ++++++++++++++
>  mm/page_alloc.c      |  1 +
>  3 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e51dba8398f7..f23560853447 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_MM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d84ab624b489..8f354ae7d5c3 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>   */
>  static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _ref=
count));
>
> +#ifdef CONFIG_PAGE_POOL
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       struct netmem_desc *desc =3D (struct netmem_desc *)page;
> +
> +       return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> +}
> +#else
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       return false;
> +}
> +#endif
> +
>  /* net_iov */
>
>  DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4f29e393f6af..be0752c0ac92 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
> +#include <net/netmem.h>

mm files starting to include netmem.h is a bit interesting. I did not
expect/want dependencies outside of net. If anything the netmem stuff
include linux/mm.h

But I don't have a butter suggestion here and I don't see any huge
problems with this off the top of my head, so

Reviewed-by: Mina Almasry <almasrymina@google.com>

Lets see if Jakub objects though. To be fair, we did put the netmem
private stuff in net/core/netmem_priv.h, so technically
include/net/netmem.h should be exportable indeed.

--=20
Thanks,
Mina

