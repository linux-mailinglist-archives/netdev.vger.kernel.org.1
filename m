Return-Path: <netdev+bounces-173896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B709EA5C294
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E689E170500
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1541BD00C;
	Tue, 11 Mar 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS9I7E/n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CC5680
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699593; cv=none; b=fBZcpGiF32IiSxMMrSd4Rasxj11icRwV0+cqvpQ3yKjt0o57/H/4g8iXfT7vfQ3fcM3kUX2yZuW4GZrXwPBtyc9o97XexKhkupxvsu/Loe0dehboBnOCDTPCoAWAIiL9VrhewX5S+qLNnxzGvCoMS/JnoUCTYRlzyCbqB0PCGog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699593; c=relaxed/simple;
	bh=jZp3TsAydg/7pFakiI6TW85wSippRGwKXlTwcNBIPos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6gs6abS8HPHr5OL6Lk9Ev9HAg3LoMsrt24JKGp3P4IQ/gbdZTM6IKJnIXKcc7VVAm4fATA+9QtdeA/VSpzORS+O7/anGBC/1QhLFqzx2qNZ6XtyGs9OmtuzwAFpHyHx2WErLLi9k9BljfoVnCQW8dVZbVIoRuEw1kO98VMmGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PS9I7E/n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741699590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZp3TsAydg/7pFakiI6TW85wSippRGwKXlTwcNBIPos=;
	b=PS9I7E/nlSPrys8ngwkmmJ48scWB5sGVYIdu1T+4vPVUy00le4XBDsUIBQncoRgHj3Oo1z
	wruWW3yzSlgB97UQ0zosDutze3N1iT4O0W6dzADEAWT6NWveVWHTusUtXCeYARq2wf3M9U
	4PAIvqOBgQY5No2MBcTunN0XTfk1nvM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-BPpfx5tmMK2eQrndxJm9og-1; Tue, 11 Mar 2025 09:26:29 -0400
X-MC-Unique: BPpfx5tmMK2eQrndxJm9og-1
X-Mimecast-MFC-AGG-ID: BPpfx5tmMK2eQrndxJm9og_1741699588
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5498d2a8b88so3018928e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699587; x=1742304387;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZp3TsAydg/7pFakiI6TW85wSippRGwKXlTwcNBIPos=;
        b=rGNyJb28duqFtch53N4UlDRTV/EihFq65jnMx/QD/SzLjH8auAbUF/lK1lvWvC83kr
         jgMlGW3HPhO+OHg4FYpEIa2hvM6SNrag36V8vT/NGFAsPBkhiF7rZWLufBDa2DDW5dlz
         rPrQxHZTP4VfliUcxvQEVpV4U0ZHW6gaTlOIH3GlrrcQK2RrMKtTruO0rzbGyMzdOwjI
         1/q+2kgo6yoCXg8NhOAc8o8SyrQp0LyZzU9h6S2q8RqVZWXBiSJlndd56tCuwHUOseEQ
         CWght43kW7mT5y5jLr/jwmoMacsTNjOIft7qDlEaVVN1v80Na1Y/Z0EohdKU/a6O2hpD
         sfQg==
X-Forwarded-Encrypted: i=1; AJvYcCVEBjIO+LZwprJlpmqww5xIB7sEYx9HswjY1fIGp0b1rOCbELRQcgGSXekr2an+syvhXjgCBYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeZ0KN3j8LbifoWlI6umBptxdd6o6/PYoQySY7t5Irn6GIdSp
	eIEsCg4xE8MTY6IRWdYsLMMQjPu9dq8LhgKlfjuO8IiR6tKfwApHpXLAwnrp/csicDvDXfXenpa
	2AvwbkxqaJSLTMVzavnXosweT/w+SV40UXpAygGfTGwYELR+eE/9peA==
X-Gm-Gg: ASbGncuMKLLlBz+Ex62aFgJvLKXMUKOO4enrPvjvT+WawHBcM8BEbm2htoDczvoms58
	Ori/O6Vx56iss5g8kiQsxk0X+6LUc9VJ7VG4v3DMcwAAqYwdY22/6QXEJ63SrqGd8T506OWtYK4
	s394hqBDtMTu4ySKFOWAKMebqzk0Xpii3ZcNJXGT/Te89SdDAtnMsjFsn3g+VwuXIFJrXUF+RaB
	9FnPxjKIoLj1G/Re4f6qnt4duaoGgzSYFHri7J7wEyKqtePCznnBu0P6nEnxqsddIKyNTk8ERat
	BExXrpQ3pxkh
X-Received: by 2002:a05:6512:68d:b0:549:7145:5d24 with SMTP id 2adb3069b0e04-549910b7c48mr5870435e87.46.1741699587436;
        Tue, 11 Mar 2025 06:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJbASutO79ZzDgdNEoOXQ+y1j4qBwd9k66DRAoi/s3im9A+vgvleJ7lXueiO1Jeoxhngqv4Q==
X-Received: by 2002:a05:6512:68d:b0:549:7145:5d24 with SMTP id 2adb3069b0e04-549910b7c48mr5870419e87.46.1741699586962;
        Tue, 11 Mar 2025 06:26:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd0absm1816132e87.157.2025.03.11.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:26:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4552A18FA59D; Tue, 11 Mar 2025 14:26:23 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>
Cc: Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
 <almasrymina@google.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <136f1d94-2cdd-43f6-a195-b87c55df2110@huawei.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com> <875xkgykmi.fsf@toke.dk>
 <136f1d94-2cdd-43f6-a195-b87c55df2110@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Mar 2025 14:26:23 +0100
Message-ID: <87wmcvitq8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/10 23:24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>>>
>>> I guess that is one of the disadvantages that an advanced struct like
>>> Xarray is used:(
>>=20
>> Sure, there will be some overhead from using xarray, but I think the
>> simplicity makes up for it; especially since we can limit this to the
>
> As my understanding, it is more complicated, it is just that
> complexity is hidden before xarray now.

Yes, which encapsulates the complexity into a shared abstraction that is
widely used in the kernel, so it does not add new complexity to the
kernel as a whole. Whereas your series adds a whole bunch of new
complexity to the kernel in the form of a new slab allocator.

> Even if there is no space in 'struct page' to store the id, the
> 'struct page' pointer itself can be used as id if the xarray can
> use pointer as id. But it might mean the memory utilization might
> not be as efficient as it should be, and performance hurts too if
> there is more memory to be allocated and freed.

I don't think it can. But sure, there can be other ways around this.

FWIW, I don't think your idea of allocating page_pool_items to use as an
indirection is totally crazy, but all the complexity around it (the
custom slab allocator etc) is way too much. And if we can avoid the item
indirection that is obviously better.

> It seems it is just a matter of choices between using tailor-made
> page_pool specific optimization and using some generic advanced
> struct like xarray.

Yup, basically.

> I chose the tailor-made one because it ensure least overhead as
> much as possibe from performance and memory utilization perspective,
> for example, the 'single producer, multiple consumer' guarantee
> offered by NAPI context can avoid some lock and atomic operation.

Right, and my main point is that the complexity of this is not worth it :)

>> cases where it's absolutely needed.
>
> The above can also be done for using page_pool_item too as the
> lower 2 bits can be used to indicate the pointer in 'struct page'
> is 'page_pool_item' or 'page_pool', I just don't think it is
> necessary yet as it might add more checking in the fast path.

Yup, did think about using the lower bits to distinguish if it does turn
out that we can't avoid an indirection. See above; it's not actually the
page_pool_item concept that is my main issue with your series.

-Toke


