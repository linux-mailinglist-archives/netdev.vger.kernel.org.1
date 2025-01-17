Return-Path: <netdev+bounces-159292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DCFA14FC2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14E47A076F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989C1FF1BB;
	Fri, 17 Jan 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS9Y5yQt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF431F7917
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118715; cv=none; b=uDHUPzrwPYfGizTaziQHRggnqJ0y4jsl4cGl6izQPx12hvjLFcUOfFr/1njN5pR7wv7qB7T18+pIj3357rw5JJgoTlFx35qpqslfdDi7E6LTEh9E8fJuIDVv+VQ+IuhA/VY6V4ZZZFvuljifF9mZSAhBgNOu7e2+J5UtALEST98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118715; c=relaxed/simple;
	bh=un1b/p+etlaRZvGTnj0wGy4rWWQjEn54RRTXDwwF4Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TzeGUj0NWl9yVuEczj5/aH32cJkRaG3Osri0Kfkoj8NqRw8nzQwTxcoLNro0zepi/QQ2uhS/5pFst4aCF1J76OvNmbKSAYIS38n8DVzeOSNUCb/jcN3wADeNIlipKvWoeUJoZQ1oEbJK4nmKZDyQ+YhB6Nzwn+0/bhWFcuvwjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aS9Y5yQt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7IA/4+Igfj/5zI/g3T0/mubsjPOaD5i2z7Uf9OFwuY=;
	b=aS9Y5yQtDcg5ZQEXSgJ4hdP5rSbFOK+CDpMD8LeOgsOgyy2exI6k5aWJPgEjnRhJjWxU2r
	G1cLL4nyGRcBp+gJziBf70HXgbzOQudzKXZ8y4TFxbNGwGq9H3s+ncZwMLwTRdFffwmvlq
	5RG9QNEWxfuyq/ZNhmsAwEbm5vNO958=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-CX_rl07BNx-ZaHhaZwy0GA-1; Fri, 17 Jan 2025 07:58:32 -0500
X-MC-Unique: CX_rl07BNx-ZaHhaZwy0GA-1
X-Mimecast-MFC-AGG-ID: CX_rl07BNx-ZaHhaZwy0GA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa63b02c69cso360914466b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118711; x=1737723511;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7IA/4+Igfj/5zI/g3T0/mubsjPOaD5i2z7Uf9OFwuY=;
        b=jwGdS6WAJhNpoJT6h5T/X9tH2hU4SZMbkOX7Uy5T7+5ys89PtL8tiLBdxpxSdELmbs
         jgK4hjhwQ/UBAXmxU7BsWHjDPbVZeCz5x2TYR5TtMTwuvoCOaIXipyQqOEwONgEgQtpS
         LKgpBl8o5VcfJouKxffrqU4mc1B35zVttw8UxYUGfdFfhg1bJRX4ti/2R+/s9PUMQ5Nd
         kGAYKWU+KB+HVIWUe3FUiy0wUyaLGymd0dCXpUpSEJUxLm+Vth+22X7nFwIRhStB+OGx
         pYiU5lw4oxgGEk3rqxAgMpDIA3YzW73tDYgi7FG8q7RO0HmIdWuTd+fkoG1Vcc26X/Js
         cgUw==
X-Forwarded-Encrypted: i=1; AJvYcCUPvx+GZCAU22MzMU5NoyM3LRmMimwY3I5nfosjMhfOfHKHfqWFLnzYYtw1FgKULU9T8hhDXqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xj+/nt+wrCV4aDtoS5JPqMp8OpxIs1seU9763xhN6/4JLwyK
	hREcItHcVm1E779X+KcHeP36djID8GO5Nu+5DSZGpQFUGIv5v5VPHhe5GfKXoOQE9ROSKklak3U
	L0Bq7AAAO0BvNT4zasRkxVYeVnyBtAfcjxEWvhwq4ALgdr1wFAvUbRg==
X-Gm-Gg: ASbGncs2tMGGvBxbmTQX9pOUFUnyfZJn5uMEg2sSeZelLYE3681j7lyOLseZn0+K/v8
	LhFIBk8XpcFlab5nrTqvk/Y918t1Z97+LVkVcLwYvGChzCep0msRWSki13E9FY+novASroaZUJ9
	6Ut/cT4WyBbaE3VJH5sh++2Vi8cIGsYtNPsnlq4cpziItC+jZGFuvNPxFrL8NaY+0P59c9az7Dw
	dBy2OMFqDx+6itRDVuu0BmyWuftlgtF/Rrg3OZO6HWMm7P3I4jD+VegO42pK8jiukMjrd1MH4jG
	DzIozw==
X-Received: by 2002:a17:906:99c2:b0:ab2:faed:fad5 with SMTP id a640c23a62f3a-ab38cc8f4afmr176758166b.15.1737118710935;
        Fri, 17 Jan 2025 04:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC3t1kll5oxU2z48Sg1MKuVMUZmjw7/P62bWkfTQ1ddyFTQEqfnRkWMl7N2wCb/X4hazKIFQ==
X-Received: by 2002:a17:906:99c2:b0:ab2:faed:fad5 with SMTP id a640c23a62f3a-ab38cc8f4afmr176756066b.15.1737118710597;
        Fri, 17 Jan 2025 04:58:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2d583sm165329266b.84.2025.01.17.04.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:58:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4604617E7873; Fri, 17 Jan 2025 13:58:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/8] bpf: cpumap: switch to
 napi_skb_cache_get_bulk()
In-Reply-To: <20250115151901.2063909-7-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-7-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:58:29 +0100
Message-ID: <874j1xoave.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Now that cpumap uses GRO, which drops unused skb heads to the NAPI
> cache, use napi_skb_cache_get_bulk() to try to reuse cached entries
> and lower MM layer pressure. Always disable the BH before checking and
> running the cpumap-pinned XDP prog and don't re-enable it in between
> that and allocating an skb bulk, as we can access the NAPI caches only
> from the BH context.
> The better GRO aggregates packets, the less new skbs will be allocated.
> If an aggregated skb contains 16 frags, this means 15 skbs were returned
> to the cache, so next 15 skbs will be built without allocating anything.
>
> The same trafficgen UDP GRO test now shows:
>
>                 GRO off   GRO on
> threaded GRO    2.3       4         Mpps
> thr bulk GRO    2.4       4.7       Mpps
> diff            +4        +17       %
>
> Comparing to the baseline cpumap:
>
> baseline        2.7       N/A       Mpps
> thr bulk GRO    2.4       4.7       Mpps
> diff            -11       +74       %
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


