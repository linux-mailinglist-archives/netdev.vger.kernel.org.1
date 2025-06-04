Return-Path: <netdev+bounces-195122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E194DACE276
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B591B188808C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD91E5B72;
	Wed,  4 Jun 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKqaVa60"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720F8528E
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056073; cv=none; b=FiTtnPeUDN5UtaAQOm4Py/VD6ZNIaWgSFfX3JTsOVmQT1eYvBp6dmGgmIkCNvCeqVrNJHW8Wky/5aAa3DAo8E5uAGn8HoJwMjjQAFPJK3wecAXI8+PfqjhEP+RfOyRqpc8YOn7/B7IvD90gbAMhgrNh46RgFJijoujAMYOpDTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056073; c=relaxed/simple;
	bh=CBJrqZ+K8qtu4Y1ldouIvNxY9hw3rtwJv5cO0xC+o1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYhumVsKHk7sv3B2AH7wSuY6uC+Opoif9rFlUPMOyDz3EPflJL0IkfW36WbLE3Lm/PuzXS1VSuKcgCVdmtYVA8gQT3dwXv3bzs8N0xDBkXs2z2HzlDIAeo6uxXjMMj0FNDoQ7O7WGhjO45KpCCRhbNHko5NHZCFJJgZ9DC86QHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKqaVa60; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBJrqZ+K8qtu4Y1ldouIvNxY9hw3rtwJv5cO0xC+o1Q=;
	b=RKqaVa60G09kku/ouAhm2a1n6fsTN4+nSYbsfbE9JeikfVCKFny3tLCg64PL8/pq+f+El1
	H4dTG1A4Zgm3zYRVin0psUHQVBoacfuCIlH35LKkJDL8f/f848k5tKECWO7jTR8mdnxsUX
	vA/es69d9FMfmswo1+J857SSft29woc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-FXmHEmMINpimLnmQ4UJxkw-1; Wed, 04 Jun 2025 12:54:29 -0400
X-MC-Unique: FXmHEmMINpimLnmQ4UJxkw-1
X-Mimecast-MFC-AGG-ID: FXmHEmMINpimLnmQ4UJxkw_1749056069
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad88ede92e2so2019066b.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056068; x=1749660868;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBJrqZ+K8qtu4Y1ldouIvNxY9hw3rtwJv5cO0xC+o1Q=;
        b=OCysUrvREJJdKHfDEPEG7yQG6g0Bfs+2ciVNJ7omfUPrfc9auOnykDZQbfLZdQRv1p
         5j8M5GtEYL/hVXru9QRDMfO8T6q4HVK6HDEt0z1IPW8Lcthp4eCswQXziqK/7J0BSqvX
         dXja6/9131SHjAOzriKvaOd0ua1O1IBlOUWqMNZ9C9WTi9FsHhCPLyBQ8BXK2A8bSKyD
         vpbqePTMBNhgxkHMUgimI/zivnqMDwuau4kr+21ybYTHMavDWRjiEa+hzn/o0dCuneeG
         jidrir3GREYMMiAZowq0Z8L3RssvaPfEjeXJKy+XVXzLnNyh8BnCzTJXFI9YlSZmYr+3
         jb6g==
X-Forwarded-Encrypted: i=1; AJvYcCUQMn3vFN+iGPeCAOz4/V4gi9N7kMWdl97CMoeUyhgIyu6njFdEdLsM6PV+LroVmR4xEjpMqgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1m5WadU5GmwQflt50c7c5Eyvz+UHRO1zRNfx32uehdNbObk3
	r1vJ+IkPMozhtBihlNN/54kPZNibeuy+hWaDOrpsjNeBZZjk2L0L1LaTWGDm4wxRWBXN4dca9CF
	JbM9vtrIeDt4FuFM9v+yDZK4QM9M6HlSaIMVoFm7iFySs+AUzbxrxNNgJow==
X-Gm-Gg: ASbGncvXDyV2AtsK3Idjq7ftfTPAwM8Yb5ixpIJ+50HhPgHTwJ8WcBwpXDJYsYO+IoZ
	avaZz0/icnDBE7YuljpgshiPpD26jsurMLmOaY5pXzUsQ4wCn5pMvcf9TQT8HrkCbBD59tIlXTT
	UukgOZEkwgqs78r3S6NsOY4Bf73GZpcg1wnIcM9cHzfsmodcS7d5pLU9wHLVsaRdXzfpBmdSSdO
	D2fI9XUldDUlraz0d6g4N6bGTwG0IbwopZQ0mTw5rUrerndjYipSBVhY/k3I10R3BDcfw2dUxre
	w45Q5Het
X-Received: by 2002:a17:907:d1b:b0:adb:7f8:9ec2 with SMTP id a640c23a62f3a-addf8fb2d1dmr279355166b.53.1749056068603;
        Wed, 04 Jun 2025 09:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72YuMsy54qWRNWHktjij3Nn8sx5T48vgaRUFWDRjP/O8/fKC1PRWFpCbXd9M9VbWIKd6C2g==
X-Received: by 2002:a17:907:d1b:b0:adb:7f8:9ec2 with SMTP id a640c23a62f3a-addf8fb2d1dmr279352866b.53.1749056068172;
        Wed, 04 Jun 2025 09:54:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39479sm1120713266b.124.2025.06.04.09.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C59421AA915A; Wed, 04 Jun 2025 18:54:26 +0200 (CEST)
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
Subject: Re: [RFC v4 04/18] page_pool: rename __page_pool_alloc_page_order()
 to __page_pool_alloc_netmem_order()
In-Reply-To: <20250604025246.61616-5-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-5-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:26 +0200
Message-ID: <871przwipp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
> page alloc/put APIs, rename it to __page_pool_alloc_netmem_order() to
> reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

I think it would be OK to squash this with the preceding patch; but
regardless:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


