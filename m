Return-Path: <netdev+bounces-205893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8EB00B51
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD015A835F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AD2FCE18;
	Thu, 10 Jul 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPB42v4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE52F0C4A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172008; cv=none; b=hRWz6VjMVV2VUCYSO0O1vFbul7JouQwMdARqDxYmQSixhexsWMv7m2aUlqvuLK7Ikp1kqdpOaQ8v31gJj+/GyekGON9qWL105xc1rf86LR3AtvKSYQForvBbX43FgSmqh/hb5yx0cMSScwgh4JQGtyPiH30ogRRkUTl9ciiLfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172008; c=relaxed/simple;
	bh=CO5Opoa/OmSz3i+hnCKFjmnvtISOpAfSUDXaxlY/TL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRSVylZ3JiFv1ouIQhMzNsYv3w1SsoVIVbx6xuv4Q3ZdTzds+cxEc7BgXV8xfkqAQx9AgVVorzFejhBy+3RQff+OeV2NSrx6sfuMAyngChYmmXBq9nLz2MZEK/7r7D9iOqmaeOJ9Oq7i1BmdgcUU4yQJW8aP2qVcz39l8oCSy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPB42v4G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dd9ae5aacso23755ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752172006; x=1752776806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLWdG5QIg2mai05rpIRhikJd5Q+5BEB1qd+ciSsX0UM=;
        b=DPB42v4G/IkPbm/RBSbPSHy9muNwCHEq+rU0kjERl62A86e34meAqQtP6kty3RVgPi
         KYgm5VKyiA/KUT1FKQ+nUjX2KtypHJcr2xctMfQjKuzSrht4n9rWf8DS4sUHjSqs4RNs
         p+i2wsxwmEzt9kwZsr7lqNzSx2EdSz8fZtKq1CThJx3q+UjyN/WHIEY4wlmqiCk23kZX
         78rAfUyZtHkuj9hB7OHhPf+mFS6CAiGvqJBBFLLYWULFBO3mkALoTtqtUIJe6WL3fDi9
         OBx7TZhUUcXNkJ15ywmqGsLqWegEYTzQZaZDobic8QUryFRfiprCqMSNBJTUQrTErj5C
         Pu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172006; x=1752776806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLWdG5QIg2mai05rpIRhikJd5Q+5BEB1qd+ciSsX0UM=;
        b=CBcgOIYIyIwkl/7E3mi85+htnTlmLYNPdsTXMZFPHtlffBswwYsqdQTvlXgE0qS4YL
         HdGrrEPROMuqcXzWHHTh4rNnJMk8puu4GFTzK5G4ivQUF/YV5IFnbHAvUp4IELhB08G7
         9dnp8+noQ7iLR8eQVHyINT330WM8Z4IeGSIN7K1kPTiUcx3Y1n5gDqObM5tT9ZXGlClL
         +dtaAqguoKF6k3VprWZCXTguVoOQVT/PdteHDwJl7Zpp387jhAN/UrcRxOYzTQpvl2h2
         vPmDHvJm9SA313i6UKqrimO68h5EDLof+/toJrhcYI6HEJE1kvxRMfjFbDnmsdoiNBwz
         aB6g==
X-Forwarded-Encrypted: i=1; AJvYcCUsorI0GP8ecDAhL5MlJiSo1YPCH681CUGxC+G6eEBsYFj/5u3eQGPGf3m9Mz0p1TZ82RpMycI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9zKzJq9aC7ELnUYmQxYCvu0AHDUfpFGBEc6koevIJ0w6uSPuk
	XzZ2Fr5kq6q7be6TVqKLQhByEWe5hJhpdSiCu1xlpZYIlgL2a/mhM/JoLHNxLXdaz0j7TuSZPxs
	iuOolKcnrHu0OPbZJOl8QmNkvTrNJgbfmhDqvjllN
X-Gm-Gg: ASbGncsjbJN9GdR3N8qT4er050OBo8KwurQsGNPBaeRaAfbvDnwbJxPl7u5spWna03n
	5yjt6TYpVSSMgoRR2SCFgd+zWNo6bFBnKLlefno/Xjpxhe7erJaYsK8QgBQ2+y6Z0x+Ltc7UQXJ
	8S7Z7RThsP2TYm3RtddcwdNlCdsjttoc7H5Q40ciqjfxlkfdBtiaYpaSGPrFGmNCW0Yqz2ncQ=
X-Google-Smtp-Source: AGHT+IEUv11GoDA74MpuU9fS3o9a3eqD1q+cu8l2HYgLYe6uliXPSQxP8a4sDFv/oCh0jr80Pb8TBrI9QM4N3Linmw0=
X-Received: by 2002:a17:903:1ac5:b0:234:a44e:fee8 with SMTP id
 d9443c01a7336-23dee52851emr122665ad.27.1752172006199; Thu, 10 Jul 2025
 11:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-6-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-6-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:26:33 -0700
X-Gm-Features: Ac12FXwW7H3G-qeQbel8Nw9wnsgeAnPp62bnkpSCDdADm7fjJ0ddRC2LvQnTlMY
Message-ID: <CAHS8izMCwPOXD02xLe6baM0-m3eq2Y7QGsnj7xht-1sgXLCovg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/8] netmem: introduce a netmem API, virt_to_head_netmem()
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
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce a netmem API to convert a virtual address
> to a head netmem allowing the code to use it rather than the existing
> API, virt_to_head_page() for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
>  include/net/netmem.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 283b4a997fbc..b92c7f15166a 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -372,6 +372,13 @@ static inline bool page_pool_page_is_pp(struct page =
*page)
>  }
>  #endif
>
> +static inline netmem_ref virt_to_head_netmem(const void *x)
> +{
> +       netmem_ref netmem =3D virt_to_netmem(x);
> +
> +       return netmem_compound_head(netmem);
> +}
> +

Squash with the first user of this helper please.


--=20
Thanks,
Mina

