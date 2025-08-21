Return-Path: <netdev+bounces-215810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9FB306D9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DE37B70AB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD92F362A;
	Thu, 21 Aug 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OtiGSpVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486092F363C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808260; cv=none; b=UhVgUD0B+SvJnQZU2y0Q7N+DTqYOOF1g2P5OiS0t/Io1CP7y0Xu1RQJg7AAjlshIVPt5wbOpwdEQc1ABJNBMG/QOvSA67e4nkOjcNqEdbOImsFIkfglz/R/L67Ua4LdWE6F88EjFsJ70IxHCAb1xXfRI3sc204wCZjQbfZ8ccv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808260; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gwkral0xkye5lHh0/N0sBRifMYYQLbYGBPoD/hZVs2UWRLbgktcu63Qjm1NALDSg2bgv6215Q4ggR8PSP7t1LY2Smz2HMoiqEhx2X1JN2pIHuyncD/DskqnAy663ouRfU0pue8uYLtFDfL4fjaaGjKAjLcC2IcWv6wnHaBxtudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OtiGSpVS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8706a6863so172248185a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808257; x=1756413057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=OtiGSpVS6L7p3xRZ+n9uz0ywcxI1p5W8Umu4wgmIKts526WwazvxMVZj2XF0duUF7C
         +ONgT8Fen0FI31D/aNM4F263x7s5MLlwiNBuTHPsgdDQMhWUk0EP23+Hmb8HfPpuocvq
         MB9UIS7NoLSNjjWb6xr+xyBQxEqNQdBo1hvoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808257; x=1756413057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=EtMPCTiTemxQ6U4iVjhiBnV0DSN2gzzX3IGhnHgNIzWvAxZuAdAIUcMFDIPlJvRMuz
         ocBrmLNmVOVIxtpBBToF9KknagxtoMCD+tlsTBGgtsjnFmurwbq5nWZXC2Owd6ba9wTA
         1iONuiPjAk00tcZ49sy4CyuA7MtVp9obb25C5Auh4U5+boXSM2IaPR82L3dQjXzQVPph
         jC22alES2eDHrKETb6Wa2pxJPoOdVRBz79WLKqGUHBDYwJyyRxoTqZp4zPwU3ULW3d6g
         6kqRXEVLs8VeWKfyPbR+MVVTHE140TkI1THAoekHTqrhVdPtWcLcDaBeADsnsuW934mS
         cO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuiubyzQBklZPKaJIPCizyHQXKB/Ji2yxjCU3tZyc1kIXwmd9ZC84QrrPLtp5eIioRfafrrvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCkwsELeuCoB1FlVghptWgP5mc99GuYoJIqRH/fLUwQW3zqiv
	GiPL7/Zp102BnXw07G6wFZLk3xH3gxYRFcDnrlyyZC+lgqY1W1QmLFhKCecjqQPBhdsJcQOMLaE
	CufDlhwIalw==
X-Gm-Gg: ASbGncuR6L3OJVcN/wl4UUSEysBgtlezW/j2qUUoWnx2GhWBE4OOpoIct+2F12Nvwem
	W0MtatCwIPNsPiQChvE8+JWBX32EviH6QDLceNwiQpy7K1J8uuxeaMV4aruejpd9BiuyuFchPsi
	IgOtMwo4mXNZ0Te33QdM12kuR/7PCX0ut0Hcauv6yRgKzyIpQjX5JV2nFItz58j2j6+G2UduK6E
	IYfZozQl13G9KeXUzQoZv7+XYHlNpBmjDrVQHihqCDn7rwnetBOMS+Y9MFAVIryaDt/U8XC5uMe
	xKGmmpRoPi2X98OCKy8KSEBw949ddrfwgC12Txa35y004xUFlZPXhYNYFwNIkcIqAYUOMX+ro2U
	hnL6pazBkNCfgpvnvEieA3bVjhPI+Ev5R5kfHQ+1IKA3KdXadAjP6KSvvwm4PZjHLrdCAbDHWOx
	Xq
X-Google-Smtp-Source: AGHT+IFhrZC9RR76/tAQS8eeyiZRJfp996+B0I9mdMLzVjl514R4qybn+vcEJcw/vgYzLtOfh7CxfQ==
X-Received: by 2002:a05:620a:c4e:b0:7ea:1022:d7f1 with SMTP id af79cd13be357-7ea11073369mr83069685a.82.1755808256464;
        Thu, 21 Aug 2025 13:30:56 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e191efdsm1210230685a.44.2025.08.21.13.30.56
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:30:56 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c6532fso17221651cf.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:30:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgxlhCKNSApFZhJ7E37vQk8YEroInis1s8mXJWJiVMQooW2NIw1ZiZg28649xMUIijAymdBVo=@vger.kernel.org
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus

