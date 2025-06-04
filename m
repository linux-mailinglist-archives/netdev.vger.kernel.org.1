Return-Path: <netdev+bounces-195126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94523ACE295
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA10189C6DA
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A91FCF78;
	Wed,  4 Jun 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="incfST89"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855E1EF37C
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056130; cv=none; b=QLoqGe4l2rN+KhvZ9Z4Ze1EQJg3SKnkM73++5jKYOs/kHKjZEHhgk2K3ZZi9AyuyOvhO+rT5BzMPygLz03woBDIiT+J9CY+sjkmnR0xvVrVBBC36tQw4QKxEOb+K4dejcT9k50jRGt7fHXgB8ZznDRybgWhbefQJVi4ND9u4Ru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056130; c=relaxed/simple;
	bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j4AKOOEZkGk/QpljhLfZ1+KdQ2rD4djmlZ/G/kufLmHatTTKgZMmkdtyt1JpcFCmt55bLZ8mh1imW8Woe7ET7xmwWqgzdDnc4YZh4URcq+VOaDM3VTAPWl4F+erNtq9Kr+qKdIDzhc3J4l7+lm31PUwPMVtDSSrsi+v6oWY4cGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=incfST89; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
	b=incfST899AQj1duVMYV7chViJWtK1kZg71EL0f2X7uNLjiDzNZFnT+7eQgqYbsyQVpURRn
	h8t0MQR3Cq5gb94gCBDUHLgfN7qJ2L9J0Z8E8GVAqHX4zxUwro+0b6j1TT+3Yk73U2/WYy
	BifGer6FA9CgW2GmWJ8+jtx8VtdjEEk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-7ju_rkTDPmOYuXIf82iZbA-1; Wed, 04 Jun 2025 12:55:23 -0400
X-MC-Unique: 7ju_rkTDPmOYuXIf82iZbA-1
X-Mimecast-MFC-AGG-ID: 7ju_rkTDPmOYuXIf82iZbA_1749056122
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-600afe38ad3so6036733a12.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056122; x=1749660922;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
        b=toS/k/i7IzdKvi/8Em3jk/F6dYtW7/tda+tCZTIcsqj69qFtF1ITdLrMwVLWlWtJBu
         SVJTeo2yb0FPlckYrg5jufYieKomTj2u0Fb/vqkMKA7aj7UPh8BsgPtgJWzcb1Rkmi7B
         m6KmhCOpGM90RCk6RhHTa7ARA0RMhZkDmqxKnd7mRaD1d5gYNgqTgLzV8YD0Qh515X4N
         of+3AubPhZ6lD6FZKjHph0dCK/mwy8GZQhYB5twyguGEizqV6A2/fsKmrURlClWKqOfi
         2ouJGTF4VjPviqVwuh/xCD8T/rAF7BB5np3TDsGuF+b2vIg6HqbtVgJWad72pCcdxZJH
         UHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUon0FYU0XaVu70vc3NEwyyc9B9cVO9rW7js6iEk/FmnaOWNYSG1Yy7Mmuseobza3uwD6VdoIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UWNsyHY/GZRnD2acHI0CjgnLeTPTadKpCUvdTwsCR3UKI9in
	xjVJUnBdUf+5PNScV6O9D5AEQnWVDSQbDxse9ypuf+nSo8IcFinK3BiPwUnMzyfFV4ewHEypyk/
	ApvVWcQTEXChWAVf3y0l0UazVfY7zPnsfHp/K9Khzxqk42LMZEAQwfQl7fQ==
X-Gm-Gg: ASbGncv0yQj0uTZq8oSY6rFWGhUtMuBidmekzqIV1GJv/6qvKG3Q7ceXy00RPUPVAuI
	JluX9YMRWmOhqSsWP/mXq/mJCkXisPq8NVnz2u0oaajFMidQlEdabJSmMQzdQHuX5rGJPETsqdV
	h3dTfP9k5Mpr7kqP19ykjlts7jOIEyz8z/eEVSZbLKODJAWzuU4dg59s7Q4O2MvTQvP0bmmaiQ0
	On/XUH9d6iaOHRxZQaRnYclS7x6ud5iOQzriBfQ9SQjiRGEDlkPd/bBPBKWTARUO709xA54VSYZ
	1OQEuBh5fJC6HW2gZqQ=
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id 4fb4d7f45d1cf-606f836d433mr1955691a12.19.1749056122168;
        Wed, 04 Jun 2025 09:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BjJ2HDUdmh+5/RYHtCz7LviWdEXcE1ZllvhVdcERGB6/R14KgQ+G7LcqUq87LQrs0WIhnw==
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id 4fb4d7f45d1cf-606f836d433mr1955643a12.19.1749056121651;
        Wed, 04 Jun 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5a8f1sm9163889a12.20.2025.06.04.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0ABE61AA9160; Wed, 04 Jun 2025 18:55:20 +0200 (CEST)
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
Subject: Re: [RFC v4 09/18] page_pool: rename __page_pool_put_page() to
 __page_pool_put_netmem()
In-Reply-To: <20250604025246.61616-10-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-10-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:19 +0200
Message-ID: <87sekfv43s.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_put_page() puts netmem, not struct page, rename it
> to __page_pool_put_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


