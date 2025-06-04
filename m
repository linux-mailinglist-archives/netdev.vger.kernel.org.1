Return-Path: <netdev+bounces-195132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8403ACE2A6
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7EE1653ED
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06641D516A;
	Wed,  4 Jun 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBt9+c9J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3772601
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056384; cv=none; b=aIBlXk7wG1x3Bd+jtyC74QKeVf0aCwSkkF/UJUs0XVVqNBAAaBa1ZzB3VFbdpqy8HSD4peuCepGsZhn1rR5T79LVNHCT2iuDikoutg0s1AHLCVz9dmtCVItyCyMyZIxbrH4FHJ1X/dsrL1jIeu+gzLxEqsg7R+37CPJdwZ4+FNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056384; c=relaxed/simple;
	bh=TisxmFxL/O31Am4LeVuPkcK1xwB3+HHPha7PZiRcrV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cDqM7spJQLXsckx/DkGKTPMN/JNGyrnwqAyFXIXR5GtlE0ZY3vdhV6tBAZ/4ixJbC5KxQQrB6+iiEKUa3x0jeDazdL1BqetNE4l1y4cm7IcOvQ90S8rIa/Tu1emT30/fNqy2NnyaUVzMa2nHIOZtBVLJqrvcJcijujbehJGbZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBt9+c9J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcDq3LrKSOS2wxrwTduRvwlyf6+kgRTg7vc6C+v+3YI=;
	b=gBt9+c9J1qHaBqJCg4JT/z/ogrWIBvKWE2eKGh8hM+PxXd+AYlLWwddiYEExWu2hG/mO+J
	z4+NWrjE+2LAeSAFEgcqSlGjT1Uxy1OWsu+MS4ky36qT+E2MB329vZy08wMFs8H63LOwhi
	FKoM5GqGGTz3eUM4h3sL2wkxH6LhJVY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Wmi_2N4UNGqwq5bVSkxDJw-1; Wed, 04 Jun 2025 12:59:40 -0400
X-MC-Unique: Wmi_2N4UNGqwq5bVSkxDJw-1
X-Mimecast-MFC-AGG-ID: Wmi_2N4UNGqwq5bVSkxDJw_1749056380
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-601ed3871a1so80711a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056380; x=1749661180;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcDq3LrKSOS2wxrwTduRvwlyf6+kgRTg7vc6C+v+3YI=;
        b=rxJPIbv4ltFCNd30x2krVIJFaPeKKnFyNOmE54QXNj/gnrGcVKc5NLDAwVSPLsz0rQ
         PGMcsQnvLGAspO4tE6loU/FM5q+QYG5/HAGpzkmld5LtzeIVywiVdci3FkuUonk5/Gol
         vcMOfn2WK7y9wDdjs0nz3ouCINqBiPu6FtbOBP2HglnUTN+XhhDl3k0pTLLTkEY9gJgE
         lzPoeM6qDZ7AbnlFYpdC+6Mp5HewkERA6KWY/HkC6EKx7R2LN1MZi7/ygAbYiK7z0rw0
         1WnPLm1dopVS4E9i6D0JJLK0owU8Xd85J2Qanc71zKSo4+gc2FsEaY19WLIWpgPWi57A
         iqbw==
X-Forwarded-Encrypted: i=1; AJvYcCVfRe/fBrTxghGI/DiJxeeg9OfRgX3JYHsyEsMEfh/uFU7EO78S5V42Pk0Ur7Q/T3r+cIe68Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+yOP15YNJeOCxbPvrTzrlxtMK3M3h3jRL0eSEbgwH10ds9t6
	sylncsLsymBjscRBJoCg9Oo8AZ16QThFBrDFBuSUcq9fIdz0mGBj6E3nyLfg0VNRUWQpeqw1rEi
	mLvfD4NlC44f/nGbilHg1IRNwQ9VlXiQUM41tBzpkFSEbCy56dQjS/I576Q==
X-Gm-Gg: ASbGnctfY19NgCoOdecFFHaH0JzZtU2qzfookNWLYMY3S8hjqFCNADfQikt0wZPTknI
	/Qe2RqA86YPd6StrhoBRb32pHhC9L9Nwb3th1RlF/CuznnfKAhH0s4+HkONVO/koy7Bd3ElgZ90
	+0yIuN5JzaRlGLfi0buUnV6CMdwFHCawqAmSiTtzy8Bx3UB6i6g/4Vd+3xEhxKC4XSO6bSiyQ6/
	q86JMZ/UR5bD52ECie1RxO1ypwOAv1FpyXgxh5Hq+xzbpWc0DqQMrV0hCU1sDbNsQVa6QukO33f
	73XcA7HP
X-Received: by 2002:a05:6402:358e:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-607226293a8mr293593a12.2.1749056379687;
        Wed, 04 Jun 2025 09:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZxMOZadu+KBXSHu7RkEeaN6qtSvGLWFm1vInB8dLTiO0dgyXATXc6Hz79i4hKaPIEOdbWXw==
X-Received: by 2002:a05:6402:358e:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-607226293a8mr293550a12.2.1749056379325;
        Wed, 04 Jun 2025 09:59:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606d7e17dd7sm1783024a12.48.2025.06.04.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:59:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C55081AA916A; Wed, 04 Jun 2025 18:59:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
In-Reply-To: <20250604025246.61616-19-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:59:37 +0200
Message-ID: <87ecvzv3wm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

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

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


