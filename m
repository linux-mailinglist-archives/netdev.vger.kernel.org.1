Return-Path: <netdev+bounces-159291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B7A14FBF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9217D188B6AD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4677D1FF7AA;
	Fri, 17 Jan 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep/c6L0/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B01FF1BB
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118622; cv=none; b=eGhvVuQwcnq8UOjlzPt9XTc76BM6cyzi23O+ktGaZcOGUe2F+WVwPnnbm8RC9b73y1cQDbmX87Mda/NLznNra7r9kfFnEthMn37GdbDWsq30WlrD76CTLXwQOCDAdZtvd8HSZX/yIK9TEyTKjXrpEF4tKu9H90UcHbuQU6ErWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118622; c=relaxed/simple;
	bh=aTVho8AOByn1YepMWxN84zHPjm3oXGLDzyOU12rA3sQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSg2/CxHlx4vCYUr1pGlRPWyRw3+BnVnzoW7VJvFsmAAwA4IbvdZixa9D/C/5BCxw2PVjVW58HNeKTmKrqkfILgRHjwChrjAIzMIyzmGEWp9IzDjOOi0jKnFUtf0ewWAlajnjmgoiegJd6zFvl8uSajGcU3ZUNoxMfS3/Jlk/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep/c6L0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljy9OBJQv1xjgRSfCuYEuq1WMWKhZpYM5ej1GNWwrgg=;
	b=ep/c6L0/xnr3ZIqRD+QdesG2qfKC2Wj5Ti8L5RACd9gjQhsgYDLtQMOibHTejJGxrorpTE
	Vx+9VW9z5eKI7JjBOlLGn3Wlvb4L9YPMKCsazZ/FOkFftMR3i8ghoTZJv8UjgBcNLLeVsN
	pKJ0yHexafkiexwtm6atDRw1hAEdFCY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-7fyZo4XuPzGi4xdYx4MBNw-1; Fri, 17 Jan 2025 07:56:57 -0500
X-MC-Unique: 7fyZo4XuPzGi4xdYx4MBNw-1
X-Mimecast-MFC-AGG-ID: 7fyZo4XuPzGi4xdYx4MBNw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa63b02c69cso360794666b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118616; x=1737723416;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljy9OBJQv1xjgRSfCuYEuq1WMWKhZpYM5ej1GNWwrgg=;
        b=L9xxtrIesgOo3feDSPIjNuLrzWGb2gIyozpeFEOyvnTcE4T+On7NWnG/ynmPHiXe8o
         uZA0SW/PzWwND2ZfsZvV6+tVq+89flqsg9HSp8s8pgLoJmC/aY3xd6l+4mhcBMLk6GXn
         TvKZ6GWAVwxoHCGzS4RsE3JX7+p/uzb1QT9M34Lt/MO2011VRzHZ7Eg9DCabGP4UeHRp
         Q/kTcy5qfc0VC1f6iqckgvPBlWTFC9unO5nnahosdSR5HXQi7o2iBcUsNF8ittILxAo9
         ciJlWe9ujPBYqVPVaLR9KWe2+h5iU2FPgFCSfty50fAr+0IezFdD9sHjIxBkqpcdddEp
         xqYw==
X-Forwarded-Encrypted: i=1; AJvYcCX7h1Lh3hTJloISdZy6Z/TLUapCIxZDV6v9toh5ZRKqBfu+uLv2V166IVZ27Mil9UBA9bLDgLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIJsoxeoPus0rgT5RInbrUi3GmSY+hflmHcmcqi35RwyWl5Lg
	o3b1mC71+41pih5dC2ObvpIXHhZ8KWUYYxHyYpY8vVQhZ8/Rg66K1AP4uSpRwsWnDrF95daJm4Y
	xh14OTbuyql5KAzr+or6MDtgVnUHewvdYloz/L7ysNCuURg8dgoozJQ==
X-Gm-Gg: ASbGncuF9T4IFI5YRXKYweoV/hz8AQ5xjhNjm2aq53F7vwdupnjx8dw+2YmJGG91wz0
	WR06FVhYMmvWbCPw0wB8sIoGLmDQ0O3Bz+VE4Y2SICtXa0Tsce2gIXY2uvB3E0Z4X5faF0Q5AVz
	oA06A4mXnnJkZsA2oZ6ebdB64eOTiXIim+1rPw7+Vbm0VtFWvCCXV0HipppI468kt7lU/82O3bD
	WUW+TYctEQeE9YkcyFib/YC4aDNC8Gzt5ULLQWhK0yjB7KziSqHyw73Z3a6Zj6pnyYemtb/JIDb
	eo24bA==
X-Received: by 2002:a17:907:7dab:b0:aa5:1d68:1f43 with SMTP id a640c23a62f3a-ab38cc5cfd4mr198273566b.11.1737118616467;
        Fri, 17 Jan 2025 04:56:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxaKgdK7JoJbBu6MZvil0YKC/KT9C4PJcYlKIm/WK2Gh3c/UvTHSx0h4SJ3YHwYv67jGcLwA==
X-Received: by 2002:a17:907:7dab:b0:aa5:1d68:1f43 with SMTP id a640c23a62f3a-ab38cc5cfd4mr198270766b.11.1737118615950;
        Fri, 17 Jan 2025 04:56:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c60746sm167663966b.4.2025.01.17.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:56:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9851D17E7871; Fri, 17 Jan 2025 13:56:54 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 5/8] net: skbuff: introduce
 napi_skb_cache_get_bulk()
In-Reply-To: <20250115151901.2063909-6-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-6-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:56:54 +0100
Message-ID: <877c6toay1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Add a function to get an array of skbs from the NAPI percpu cache.
> It's supposed to be a drop-in replacement for
> kmem_cache_alloc_bulk(skbuff_head_cache, GFP_ATOMIC) and
> xdp_alloc_skb_bulk(GFP_ATOMIC). The difference (apart from the
> requirement to call it only from the BH) is that it tries to use
> as many NAPI cache entries for skbs as possible, and allocate new
> ones only if needed.
>
> The logic is as follows:
>
> * there is enough skbs in the cache: decache them and return to the
>   caller;
> * not enough: try refilling the cache first. If there is now enough
>   skbs, return;
> * still not enough: try allocating skbs directly to the output array
>   with %GFP_ZERO, maybe we'll be able to get some. If there's now
>   enough, return;
> * still not enough: return as many as we were able to obtain.
>
> Most of times, if called from the NAPI polling loop, the first one will
> be true, sometimes (rarely) the second one. The third and the fourth --
> only under heavy memory pressure.
> It can save significant amounts of CPU cycles if there are GRO cycles
> and/or Tx completion cycles (anything that descends to
> napi_skb_cache_put()) happening on this CPU.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Neat idea!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


