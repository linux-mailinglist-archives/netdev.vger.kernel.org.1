Return-Path: <netdev+bounces-195124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC4ACE282
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B417178F3F
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A81E633C;
	Wed,  4 Jun 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA99ODXP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7381917D6
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056113; cv=none; b=RBH8BwsDmecoRWfwHsPySj9rQZzqC/DKgJKOJKgPPk0LONF6yo00Ne9LhMYcWXPGvwhHrixgGSNShrQ7ZLGHhT3mVEIGBAIph49ttT0EOQwH6THY+fLALclwxUdnuszOEDJ1Q/gS1xlAZ6LlCzeHjFfjZ69LajtSxahtQAEgZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056113; c=relaxed/simple;
	bh=91TmU08FsImP3F4T6u8nGlGa+H7u7HZ0VJLL7es6Lfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cOo68m6pB+N/ykuaoJctt+SGHocnYj8jjISn/pg/1JWiVn98b8B5idS2XF9i6R49TGjp/i/32mgofDvkGEJq4JNSfwNd9KB2TMdgi14+bJXbAZqVUIqViNmcMOlXvH5eioYNuiiv/RTXGUXpFnX01ItBsDyjWvgqXelqYdp4kFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VA99ODXP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91TmU08FsImP3F4T6u8nGlGa+H7u7HZ0VJLL7es6Lfk=;
	b=VA99ODXPXg6zqh4kZPT4CCBZfPIsmXUIYv/vYl5Ka5kITWH2qhcGFISvbHwK9S/b6DBN/j
	dwYzyl3VJnIDjJ1JFiwgPH4MFngGY5fKnvhKrgob/k/6By/D8KcF6g8NL7BItoAqdbOxhS
	ZCG+ueBQHnQPyPuvzGZN33Jl/D0Hoy0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Zmfx7jLiNs-gHF9JmSA1RQ-1; Wed, 04 Jun 2025 12:55:09 -0400
X-MC-Unique: Zmfx7jLiNs-gHF9JmSA1RQ-1
X-Mimecast-MFC-AGG-ID: Zmfx7jLiNs-gHF9JmSA1RQ_1749056108
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad5697c4537so12196966b.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056108; x=1749660908;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91TmU08FsImP3F4T6u8nGlGa+H7u7HZ0VJLL7es6Lfk=;
        b=hrGQzHumgZlErQHrm//CrYvgx8bMOD/3Lt463BWrUiXz1UKrZAICEPxxKdV9NzQyRU
         UD0dmvH2mqOqkXPPNAuPAzQo39BGl3yIqZNvFaSKZq4XffoQyboAHWqHFdGBRICccrYZ
         JTLC/MJW3x/Z0q4sWQmjFmi0rutZErEL4tqWhTLiK+HLwi4bEa78El9dFVIv1U+efn3l
         OI1k8iumotxRVH8L+W3mF+mHmq+Qox20MK3NvGfF3tHPv6RdiCC/5oDZ0z0IOE8hXrnI
         VI6unV/2R4VYvQ0z3Vscatp4kcxQjpXFR9KWdRDEtfXNDu/O+XBXIVbWsV4yjX59kgiS
         DI6w==
X-Forwarded-Encrypted: i=1; AJvYcCUHLNMBe0jGxe1jYp8RDjo4UlBQ73LSe48NI63jVsE6nXkPir56b1KRrWp36O0MaTukjApaSn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnxwxdP7luztFmLzj2/BVtO+mZrkdEm3nONFOAMJC0vW9gH9D
	TIuHU2X1bLUGFFhYfE56oryBPPz0uJhp1HMU+ELSB4D76C/Qi5/Qdwm6jJGXeJ6cOyRUbjlB7as
	pYhlo59ZzMSWP6FcGxmB9y1x6aZyK6/3HDiYiOyQJH57mRIseKL5/ncA1FA==
X-Gm-Gg: ASbGnctXE9zLsiglB2ibsL7JyBjg5WrjhGFU4AKcVe1gtBxOvRGg2/1O+AvxY9VR1tE
	w1XUd8TlBzgQkAGSNxvrkwmSMXHouqk8itzrQRAfd3clkyivF61EACPu59vyT097T1byeEKhoyD
	EkEEcxU7AB5WbMp1MgTnCRkinhvgnF3utWZ6eO0npqzZ8/NJlc1CNEtY3cQtV1qiqgYktMQlxCz
	v2p87ahglpnZy5958qdtARsihAxmTIA6k9Hm2sqy7iuvTCI1Vpmk3lrw+younLJppfJYIaw5pa5
	HGR7ty4bIN+gymfrexs=
X-Received: by 2002:a17:907:3e08:b0:ad8:ace9:e280 with SMTP id a640c23a62f3a-ade075bc502mr29797266b.5.1749056108253;
        Wed, 04 Jun 2025 09:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBc27ssHQiTtB4EgXSQkSof2j5qNISk4hB2PmUnwayLy3gFqhE1o5UG3eo/R6RPx6tePP/GQ==
X-Received: by 2002:a17:907:3e08:b0:ad8:ace9:e280 with SMTP id a640c23a62f3a-ade075bc502mr29794366b.5.1749056107818;
        Wed, 04 Jun 2025 09:55:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d84d1f7sm1118264566b.74.2025.06.04.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6A2151AA915E; Wed, 04 Jun 2025 18:55:06 +0200 (CEST)
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
Subject: Re: [RFC v4 08/18] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
In-Reply-To: <20250604025246.61616-9-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-9-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:06 +0200
Message-ID: <87v7pbv445.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_release_page_dma() is for releasing netmem, not
> struct page, rename it to __page_pool_release_netmem_dma() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


