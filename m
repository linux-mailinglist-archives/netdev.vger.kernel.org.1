Return-Path: <netdev+bounces-239100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32AC63C99
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8FC3B26CF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13225D216;
	Mon, 17 Nov 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8bYIGgX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un8PpfQv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A51991CB
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378462; cv=none; b=NvLa5n5g/e+eoqxw+qOdu60IkJokDWkZV+/tzTRo9ElEi+DcDl23RRD/0gBwJStlrsmTBUqU+U1ujGLUIMJvXal39zUN1sESKbsoP3TYPrFM0esA+ODQ3/aj5TZqUXBwuhjkwDuPmUp2QWlSH/TEEr2hlcDhLH8btM0LXg+ZBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378462; c=relaxed/simple;
	bh=dPcOQIPBIBCLa/NKsa8a0L2Mq5wMH471wz/f//gTuWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SisYW4B/HuNaAwS4T8dpWXJHyOIpwK80h2znTLoSZq/HLAcUBTVN4AV3nht+3AvTlPokgFB0sr/OdwpG8Mmh/oZbNCr+0jOzNdD+lVUucmWvSuISS6iF+0o1A1IUrMZqv0nT8PfVtjLT2Q75ZCnpixRyeyZCscUsz2URN4/stZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8bYIGgX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un8PpfQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763378459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
	b=I8bYIGgXifOH20wmS9+zXtI6/O28rgITo46ljUCAfuNK9KFeoDV4GFP+ayX56s8zODiBrX
	3Dzkwj3TDLulB8RyEXQhdfjrdXNqxjHfdAf/PgDEA2O2K11s4h88z/g05q2Sz55pRaoFb3
	NQX/2Srd7fH1KA5tXOYfTIbNA/Uc4bA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-FfN8ScG1P_uzIbfQKZmZJw-1; Mon, 17 Nov 2025 06:20:58 -0500
X-MC-Unique: FfN8ScG1P_uzIbfQKZmZJw-1
X-Mimecast-MFC-AGG-ID: FfN8ScG1P_uzIbfQKZmZJw_1763378457
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-640cc916e65so5237971a12.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763378457; x=1763983257; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
        b=Un8PpfQvqC5wTzErk38aMO3hEdRvYC+9HtuNTDGBm9eo9yKT41VxFEqSkHgp8wYcnf
         8aQAQoGDUFWK8yN26R0WEYsVQtyGmapOQoHTSi81dPLUDDC6bb2IO9WJdnQxAHMIlIuX
         SJK4J5GZQz/Hq3fbkdDS/Y8Waxb7c7eqBKR9wG7T2mfSFdiLGYd989bXAn0vLTvsC8SL
         bhk3wrqgrmYDyWLgLqUsCJOW6lpgbg3TMTlG8qCGxSrCmY8Ru2F9SC3ir0YU8HoFtzu6
         wq8rR1SU1XpJQR4UMj9DuCQLWS6Lz4Tiz3HXvtBPEEshYksNe8mE3S05vEV4AY2u0gu5
         OH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763378457; x=1763983257;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVf9LxNdBO8TaOKgZFNSQsuTbNOO3hmBDaXVsTWiiWA=;
        b=KyCXLo9807GJ/8nqu7DJjL0BA9LKcaqeyWMYZX8VgPv/Yfbhb/PcXZBuBPdi9hCGQd
         G2/pA6kFRrirQSfo5d0YP+yykQYURwYreE9PBWseiDt5Fq8zlfjpvK2Y6p/uDJEqt5jI
         RUDaRztpYvgoQ2OzrzIaSFvnzSrzjAQvfF5Tqe4YJaTmYR/oOyobv+gWCSNFDEGK8uzK
         TsjrD4/EEV4jPv1Vj1fungVuAmABrIEdMlOt4g7Xor5/eQMImzzEoageG8HquOtOBk7F
         YPgM5penfaZMmKOa/c/UKNmohB8SLebOu4sa6PuxZ2wwF+DaH1zICaG/ygtaYzG0G0s/
         fHUg==
X-Forwarded-Encrypted: i=1; AJvYcCVtQYbrJYbXI/aEXlXIerSWKJqjT9Zwo3oO21XyxRtFYxzrdfKl1F0Et9ZdlB3eFVhhoWZ9ds0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5RId/l4WlnQ59Svu4L8i5jgX2Mro1U8sypkuMM9J4fWJ2UQV
	vMd0v02Q0gyORr14L35YJImFxpSquEL1z+i4X7LOlpoY8VlpuBYQmOV7SDgO7Zbp9UT3c7gR8Gg
	njlYiniqD3veUuLXKWdn8fBCdZ/VKbqB7z5Lxd8f/ARseMgNgCeW08Zr7mg==
X-Gm-Gg: ASbGncvQgkpryqK+QVDwHqZKwBLcHmZnqWUCayxYVHNXWXfWahzgsGz+b0oEcQG/+94
	k5/Kv8No28x1qY5B5qdbMcT71Xhd9YY8KQ8RxuXppT9t0W5H36kxsYV3NQf1SjbWyZRWvSkUCVN
	a6kuBbrGprIDOH0z79d2QWZ9S2qvKZEHJhWw3oImFh5nxMZzJZDdY0YlarH6c5/EDNvLmUbVDZG
	aoOpxTYo7CqPoJ8ITx2Le9wbfzbZm9BWumfhW15MZQYa1jmUMNSCsyGnqwNKmDSZRroyxqxbOJj
	WTMhBCxaRFOr638euQIwg8HEUS1atwKMNXtEybCQEaVmVVv//KVuaSQVXcyXF0HZbZ5xGQ6qzSV
	8YAXCv7VVjs7DQaQhi336rdoLuw==
X-Received: by 2002:a05:6402:51d0:b0:640:b736:6c15 with SMTP id 4fb4d7f45d1cf-64350e23625mr11703521a12.10.1763378456945;
        Mon, 17 Nov 2025 03:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Wdj00OQMd3S1KCNlU9xBz46Uej0UIJ1gNeKRvwBEkwOcay/vlwA/7tWC70CgNVFMvt+NUw==
X-Received: by 2002:a05:6402:51d0:b0:640:b736:6c15 with SMTP id 4fb4d7f45d1cf-64350e23625mr11703494a12.10.1763378456453;
        Mon, 17 Nov 2025 03:20:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a49806csm9992622a12.18.2025.11.17.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 03:20:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D7AF329B3D; Mon, 17 Nov 2025 12:20:54 +0100 (CET)
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
Subject: Re: [RFC mm v6] mm: introduce a new page type for page pool in page
 type
In-Reply-To: <20251117052041.52143-1-byungchul@sk.com>
References: <20251117052041.52143-1-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Nov 2025 12:20:53 +0100
Message-ID: <87o6p0oqga.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of @pp_magic, we should instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> Plus, add @page_type to struct net_iov at the same offset as struct page
> so as to use the page_type APIs for struct net_iov as well.  While at it,
> reorder @type and @owner in struct net_iov to avoid a hole and
> increasing the struct size.
>
> This work was inspired by the following link:
>
>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>
> While at it, move the sanity check for page pool to on the free path.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> ---
> I dropped all the Reviewed-by and Acked-by given for network changes
> since I changed how to implement the part on the request from Jakub.
> Can I keep your tags?  Jakub, are you okay with this change?

LGTM, you can keep mine :)

-Toke


