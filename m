Return-Path: <netdev+bounces-177676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55F9A71242
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 09:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E86189A90D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E581A0BCD;
	Wed, 26 Mar 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhpV1lCm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93501A072C
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976768; cv=none; b=JD+hp1W4+Ecg227PhcfQQAN2HmuBSLsu21E+LeFTTmSXspBecxGJEYFZdvqAIKM84BjgtkdNj1D2eo/mWNYsctrje2vt+OL+57pdyXjonOlny5l/9lj2b//sY6gJguF3l9+5g1spdn/N9nnKcZymSXJxtCzSsyAzQS3fOxTCoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976768; c=relaxed/simple;
	bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2Y7uBGCqz6hs70A3w9RkOPCigzaAq3x/lhiEVWOBiIOu4Xj9EujYsEpzRZC6wsDjfbYW4+8+07QPZBX89P6slgNVcOZUfpFimrUAGdKzb4tFLxptWmTnFRq2CV7GrI+NAuUf5+p+L5R/6zViYXELSMkdqkhA0UEtq7I5kwE2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhpV1lCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742976764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
	b=dhpV1lCmmrqiTlKB080NpdMeQmwS7ooo2WHmYQm7jlL2LbDHsFEea//wJIj/Eai9bK4c1K
	P/YpPQ/EiPrMV3G/W4MazLvrXbtjo8qozHSXhz4t/He2RsrlGfR43g21NrZhoGzndsyRxN
	tfzUwg48MAy4hvyL3IoLCo7HXsFtuNI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-hsOwX42wMSKY3cIrCQlsIw-1; Wed, 26 Mar 2025 04:12:42 -0400
X-MC-Unique: hsOwX42wMSKY3cIrCQlsIw-1
X-Mimecast-MFC-AGG-ID: hsOwX42wMSKY3cIrCQlsIw_1742976762
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2db121f95so496866466b.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 01:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976761; x=1743581561;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
        b=mZEL8apaG18W44gzZ4Hhh4c7hDoZzzlKAk1iMdtYgODBcbZizCut46nGFmhpShuRRa
         NHOREPhhpCZZA0BS9KE+wX5F3T7lk20nAZBDPZUiZD9R31hKLdLkZUj7rYJK5W6vz3WU
         feUyFRIlfJ+t4LUlI79E9ZXyrl5QAGlMIqAqVmK6NOr2kWCExBkJRWr+skBuVScXbZiP
         q/PQQuN1pNfTzxN6czmmSZiBfFpJ+gPaXpa95W4UpTiQkWorVsFQgBCl5EmWV8uPjpgS
         A87QhyXJ1PqhVHgjGC4ABxCSNmHpfTDQeMdncCrF7e6S5cuV4xM4quNSNPhXxh5qKd5K
         oC3w==
X-Forwarded-Encrypted: i=1; AJvYcCWn+g9Czw9GYpOb147KPrbnpozfmVFYRn+qTeKL+wvDU3e8921TILkoJSuTpBTEAir7D0EzeCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2DUqkzdo3dFcpfVhCzRXSqXZG52FvI2EEm5fJXlOJhaMKi5aY
	rPGm7DvwqHnUA73xHtJAuUixUj250ndO30PY4C++Dw/Vw8PKDXaJhjkaCoP5NeoKbEoqRNqGj/t
	/xMUMMtq8/xMZ+79+0qV2+AGvAx3hAAaS3VsUNtT3e8+Ko/Y81nAFlw==
X-Gm-Gg: ASbGncvncGG1RchjB3bRBjym5zooXiQisIzN5vgtuVIrw848ardp1jJoOe7neCoSecs
	Df2pmVtLg9BwIuQ0AcLmpD+a/Bjp6EeS1nB4ffbo358I4+oASziDOoHkBZnLfuD1YUgQ8fz8ym2
	e/SiwJT+j7tDXL0dyEHQqghoq3N0Gr5ln3kPLZJmC8g0WhKrtjVBKq5bZZLrp6SIdTPW66Mtz+g
	AXWbu/YwsZYI3XORllNB9WgVfeh7aKkqf3vFFor2BjCsF0/aQtYpR0gEqGJn+wU+E60jTJDBtUL
	OzjB4Q1oWSBP2ufqLbegbLg/2fKpABuqH2cbuxZ9
X-Received: by 2002:a17:907:e84c:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-ac407515fefmr1710094566b.30.1742976761510;
        Wed, 26 Mar 2025 01:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tYXUyRnYRid7WXsc4ocXyKGAEp70GrWLAvLlsK1V4El27+8QO6/yVgb6O5atgR4hk9tmqw==
X-Received: by 2002:a17:907:e84c:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-ac407515fefmr1710092166b.30.1742976761087;
        Wed, 26 Mar 2025 01:12:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efda474bsm988606066b.183.2025.03.26.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:12:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 305D018FC9C4; Wed, 26 Mar 2025 09:12:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
In-Reply-To: <20250325151743.7ae425c3@kernel.org>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
 <20250325151743.7ae425c3@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Mar 2025 09:12:34 +0100
Message-ID: <87cye4qkgd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Mar 2025 16:45:43 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Change the single-bit booleans for dma_sync into an unsigned long with
>> BIT() definitions so that a subsequent patch can write them both with a
>> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>> non-netmem providers as well.
>
> Can we make them just bools without the bit width?
> Less churn and actually fewer bytes.

Ah! Didn't realise that was possible, excellent solution :)

> I don't see why we'd need to wipe them atomically.
> In fact I don't see why we're touching dma_sync_cpu, at all,
> it's driver-facing and the driver is gone in the problematic
> scenario.

No you're right, but it felt weird to change just one of them, so
figured I'd go with both. But keeping them both as bool, and just making
dma_sync a full-width bool works, so I'll respin with that and leave
dma_sync_cpu as-is.


