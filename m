Return-Path: <netdev+bounces-84617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B98979B4
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204A81F27151
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A5155758;
	Wed,  3 Apr 2024 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExZBYS5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17919155301;
	Wed,  3 Apr 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175636; cv=none; b=kxz8fJhLpdPtQaXZtJtEBFJ50egrrKqshYSsH9/zOjyGiBrJ+XwbxYY1jO3jSib5NWur/Xvho04fCxoTBatWtlK8tOwyOyniynmih4ifrD1lLHywFfDWuaEBAEqWbn5nfjrTASeiWaXBmfOTo2gdBUv6tFNbzXAFPV1Z7v2E6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175636; c=relaxed/simple;
	bh=26L3z7JQ8dnYb3HamKTUiPsI0IDXBzLWXv1MUH5FMeE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GlPyHSdqPVHv65fxjBK6Zr8OEHH2NA2VxXPb9CrmSYLTcZWmsBxNgLprb+8//Q1Ald3I/7k9DNqvJP7t2VKoHcc3RrVhNfZPlVwJ6nWdEebTjkMtdSpOr9s99sjdJc0YzjcmOLrGT6aCklxiZ/yoxB4nhrtMjSM4WT8OPp6XggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExZBYS5D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6c0098328so188223b3a.3;
        Wed, 03 Apr 2024 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712175634; x=1712780434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BqhsT1/7MwxMx0TbAKW2MQtEH2uBz2kntJlFvDK9Wo=;
        b=ExZBYS5D43vC8DSoWJSKndqh+WcPtj/fbJUQqC940C1psqPXYq79rHOtxcv+/Tub0t
         9F0/V5xuCSyBF3zpjKlw+qGU3M7smxsWVvPd9w1lOC2ehpCdbfzrwi+pD38SvWjqvP88
         FhfNyoedI7+7QxRiFknsfyzBCzAo3uJSJ9P7HOgPE0jSsC/O8J7WMtrlJPAI08FnTwOn
         BwNcN3Hw82lcoi24cxeXHAeLmMt1gnk2P/ozcAVPEn7RPtMiPa/rcIihPvDAc9RDI5EL
         pec4NFV3uq+WyKY+eKkHiAdXL9stOuSp46iD6VeY4JzThOiVCrNNSn3B/NHuhlaSK8lx
         JUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712175634; x=1712780434;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/BqhsT1/7MwxMx0TbAKW2MQtEH2uBz2kntJlFvDK9Wo=;
        b=E6zlCcnTQrYf23e4kWxstuzpaKgLExbGz05JVSea3nLbynMs3FqZkfQTf8G4cU8yp9
         fxu0/nP0SRUhVxgJt3+FK2KrovPZBHMHguMhsyeLW4dYnRFKvs5FYT2gVuaVBtLPKFtt
         XIa10cxsIRpEib+o3F/ziIfg0koMv5WhG8Kcc2rRvVdunOfmLyDPppFNDKRKgcodPSpk
         /2pUCuAcUdJzhOqOziVMhA/YSew4yw0kxTvevSUwDxBGoh/9tOiHBsy2UHj4C7dfOaNK
         gWCfQqiyCkzlG44yzez4i35PVY/jEC1nPAkqO5lVRB07Hs8U49AEsYwPpHoi/I2Ef8xo
         V4vg==
X-Forwarded-Encrypted: i=1; AJvYcCWazh6Wrl1+tIl0z7FnY7vWZdWzJy20cUmdbCeMobcd46VDmj0E5M0brF2FOtlrOzI8yofB041iEVS62xIPdjPwsFgDIK2Yen8DsLbnWgQmeTWA88NXrTZ4eVmc
X-Gm-Message-State: AOJu0YyzOjwn0SqrwdDL88dbirmH8qPGw6LksepeLwNG1i3kuz+mfgfk
	an8XtPXFsFNeRiecfGZEpBP0iThJcvXny+T7xa+V2Oa2DTFzJSZM
X-Google-Smtp-Source: AGHT+IHy8T3UBcyrK7Dk9GsYXOkUPzPUMI9LABC1YiucZ8Nyr82wfK8Bt2GY7dfxnsj5h9BWGiaROA==
X-Received: by 2002:a05:6a00:aca:b0:6ea:c2a2:5648 with SMTP id c10-20020a056a000aca00b006eac2a25648mr762174pfl.3.1712175634194;
        Wed, 03 Apr 2024 13:20:34 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id d9-20020a62f809000000b006eb0027f2b8sm7902856pfh.9.2024.04.03.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:20:33 -0700 (PDT)
Date: Wed, 03 Apr 2024 13:20:32 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <660dba106f0ed_1cf6b208ad@john.notmuch>
In-Reply-To: <20240220210342.40267-2-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-2-toke@redhat.com>
Subject: RE: [PATCH net-next v2 1/4] net: Register system page pool as an XDP
 memory model
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> To make the system page pool usable as a source for allocating XDP
> frames, we need to register it with xdp_reg_mem_model(), so that page
> return works correctly. This is done in preparation for using the syste=
m
> page pool for the XDP live frame mode in BPF_TEST_RUN; for the same
> reason, make the per-cpu variable non-static so we can access it from
> the test_run code as well.
> =

> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/linux/netdevice.h |  1 +
>  net/core/dev.c            | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> =

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c541550b0e6e..e1dfdf0c4075 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3345,6 +3345,7 @@ static inline void input_queue_tail_incr_save(str=
uct softnet_data *sd,
>  }
>  =

>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> +DECLARE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
>  =

>  static inline int dev_recursion_level(void)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d8dd293a7a27..cdb916a647e7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -428,7 +428,7 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>   * PP consumers must pay attention to run APIs in the appropriate cont=
ext
>   * (e.g. NAPI context).
>   */
> -static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
> +DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
>  =

>  #ifdef CONFIG_LOCKDEP
>  /*
> @@ -11739,12 +11739,20 @@ static int net_page_pool_create(int cpuid)
>  		.pool_size =3D SYSTEM_PERCPU_PAGE_POOL_SIZE,
>  		.nid =3D NUMA_NO_NODE,
>  	};
> +	struct xdp_mem_info info;
>  	struct page_pool *pp_ptr;
> +	int err;
>  =

>  	pp_ptr =3D page_pool_create_percpu(&page_pool_params, cpuid);
>  	if (IS_ERR(pp_ptr))
>  		return -ENOMEM;
>  =

> +	err =3D xdp_reg_mem_model(&info, MEM_TYPE_PAGE_POOL, pp_ptr);
> +	if (err) {
> +		page_pool_destroy(pp_ptr);
> +		return err;
> +	}
> +
>  	per_cpu(system_page_pool, cpuid) =3D pp_ptr;
>  #endif
>  	return 0;
> @@ -11834,12 +11842,15 @@ static int __init net_dev_init(void)
>  out:
>  	if (rc < 0) {
>  		for_each_possible_cpu(i) {
> +			struct xdp_mem_info mem =3D { .type =3D MEM_TYPE_PAGE_POOL };
>  			struct page_pool *pp_ptr;
>  =

>  			pp_ptr =3D per_cpu(system_page_pool, i);
>  			if (!pp_ptr)
>  				continue;
>  =

> +			mem.id =3D pp_ptr->xdp_mem_id;
> +			xdp_unreg_mem_model(&mem);

Take it or leave it, a net_page_pool_destroy(int cpuid) would be
symmetric here.

>  			page_pool_destroy(pp_ptr);
>  			per_cpu(system_page_pool, i) =3D NULL;
>  		}

Acked-by: John Fastabend <john.fastabend@gmail.com>=

