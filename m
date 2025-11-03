Return-Path: <netdev+bounces-235071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C5C2BAA7
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9991882D9F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7C13081BB;
	Mon,  3 Nov 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV+oCEZQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAKuRWa2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B7301491
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172768; cv=none; b=FWcEib/MZLUGB+W9xqG917YAmOeClkJzqmQF9h4fg1qqf01szQtVFwf6tDPINosLJiR4c5UiIzs9L68YCtHsZBNDy7InxssTme/sqsxpUnaCibKsckLNuwvvKNo+ceMsiIAyv3p25D5NZSnHjA/RpD2JFpQ5W38cJQXB9KmxQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172768; c=relaxed/simple;
	bh=Si/42XMXJCEofqRHH+RrI534o6OjSI0ZZ/KP8a9kKog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eV72MzmTD2pIotPOEd0jNaiyFArRblnUpCv6I9l8cQWiisEAzUVUufNbrbGBiZx9AdzAqag/vlrEFK2I6cTOBnXND5w8Uy2jMzNrowcmzLSGhqj9ZexF82kn0sP5wHzGK89HPowbFIf8A785hYzAcZUbyT+56u5+FojbB5i9UN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV+oCEZQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAKuRWa2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762172766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g11uOENAhXF6Lz2FLzv66IHWNpx+JPxP5XeReK+9A1c=;
	b=gV+oCEZQpzCxHcpx8JbLGIpjFUJFXkr7Ce3ilCkiN6rYdE8rVrKBuaDkkNwhFmD4ibCVvg
	MbM7L7C91ulEYLMNqZ+pO68DWODoHLs4VDa/QCc5YRzoQWaPfSLlkyWLpwr/T2xjcgC20f
	JNoXO4So/dAVu5i/xwTXldu88ZjWDRY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531--WQbR-PbOFu9ndnpdk2oRQ-1; Mon, 03 Nov 2025 07:26:05 -0500
X-MC-Unique: -WQbR-PbOFu9ndnpdk2oRQ-1
X-Mimecast-MFC-AGG-ID: -WQbR-PbOFu9ndnpdk2oRQ_1762172764
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b5a8827e692so316881466b.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762172764; x=1762777564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g11uOENAhXF6Lz2FLzv66IHWNpx+JPxP5XeReK+9A1c=;
        b=UAKuRWa2ThRifoqGXh5Ca1Pvm9cEVooPc+adYv+NBJIR0tYzgRyS4005U5EMGsWCpN
         Wk6mhPZ8FZ07XSOdHtirRWe1YU2BnyZfq4l8jhKQ5CLWZydkTozvD7Ai5FknlW6+/d8+
         VMyZsS08ptMgIQY3D5w7RikxAEeKoN/fpkrE+InuhXtvxj+JZMhwuN4zf8/8kgiNj501
         ow/fF4bR5WGU4NFPgIQaNzvC5OyJ7h3uIMv6fAdUnUVlVrbBixxGdSyGJiuaXhPbCPvI
         Y6QgPhvn5oV7F7pikEwRX1p4D6BPRAwrhHL0FynP9yGVsJcIhH5hl4pdt7BK1Jpp5VYM
         8s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172764; x=1762777564;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g11uOENAhXF6Lz2FLzv66IHWNpx+JPxP5XeReK+9A1c=;
        b=PNZAv60eDMZEMeLXJ9ruIVHXDwKqBiT/Vru1o6LTgKvjDGSzyQnDOgzxcjyRcdL0sf
         QsO5jzuSsivHS6IYMdcq/gnD0kBF1dGizLVc2jUG8AryPBbjYgaiqE+cc25KjxfwX9nb
         2dNm9bWyfLLG4spC2HJUmeWQZfDKMKu2n6SAHHxdU+3BUiCe4zYQaRV4B/ZlVm1Tce2p
         X1lYaZZjfXlfCG+BbTld4Ayqt6wgdv1mI+ag4nOLsWt5wCTQXFd6dD7lkk+wlxZNW8YO
         wOgkbLgrwbM1JAFpKIf0sYiC6b9hJRZLLQufZQ2LWjbXdnur0VNsIsvA5d2FiHKJFf8u
         Va1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcQ1BlJWb8ZPhLxeykWk0G0UBYyYEwHduXcX7ZNG3TJcNKgUFVihBdC3yfcSVUYAFfVlcmmdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/5Y3gIwFe6gERsoUD1bZ7W5CBUdT3Iajqeamj91Q2gFk3Ndv
	KRUW+8MGPnHVLxrO6nLTQoXBBgwXCKRdCCJqSpoTbZ/NGdyDQbwpef6SWlF66MS8aic5h1sFkn7
	3vPVCU0fFgsoUiYi/xDF9DUg2GyvYT3sIYFcEYzg6PhTQs9P1tNpv/HWCGA==
X-Gm-Gg: ASbGncuQiI//k3XdO0siOujdDgClehgEgG6RpLgIsdLHeZK6eDLG/hIF17BCFD5D7rN
	4Rh6UyR9LZIgiPTKFFjiBnmhNxR0wY3B/BvQPrZsPkDnz//KCU1SqytEmkfcy/aIYK0bQtAO/Xu
	QbybsCGn7RsX7DByWuTlSxYOeAB6l0LpHx+zhZW1LEs3oqRsj3sc87OLP5Cx25hVu4+7zh0aCMi
	A/Kfa2tNGLSen58Y/cXrUx3q+Wv/EltAuqyfmBpEk5yAo3ai0GidLJT+WTc0pZCbMQhbipFSxu5
	cNafNGQs7xM7REwgsRC4sffaHj/oDwRQvEcDkS+2D+cXyfZZE2oh0Le23+BlE1o3wQt13/WfG7u
	weW3ndpmpyEhtL+UgIXTviiU=
X-Received: by 2002:a17:907:2d90:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b707088d70cmr1143621966b.60.1762172763696;
        Mon, 03 Nov 2025 04:26:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGDSUZroE2R0agAHuAggyj7GFeJpoD3zlqyuRNs//UwQQu1Iz9F3y2cjiJMrJtGK3MF6tN8A==
X-Received: by 2002:a17:907:2d90:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b707088d70cmr1143613966b.60.1762172763188;
        Mon, 03 Nov 2025 04:26:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d24sm1032752266b.1.2025.11.03.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:26:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCD6D328450; Mon, 03 Nov 2025 13:26:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
In-Reply-To: <20251103075108.26437-3-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Nov 2025 13:26:01 +0100
Message-ID: <87jz07pajq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic =3D=3D PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we should instead leverage the page_type in
> struct page, such as PGTY_netpp, for this purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> This work was inspired by the following link:
>
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmai=
l.com/
>
> While at it, move the sanity check for page pool to on free.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Mina Almasry <almasrymina@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

IIUC, this will allow us to move the PP-specific fields out of struct
page entirely at some point, right? What are the steps needed to get to
that point after this?

-Toke


