Return-Path: <netdev+bounces-179263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE6A7BA3D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CC21771E2
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45019E83E;
	Fri,  4 Apr 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0iEAhm8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645101624C9
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743760415; cv=none; b=Tinf7+wh5G/5qvQRyJiQryM3532hWlGbmstuJOoAE+RAAbZWvetFGYVaSAfvwyQ5FSNT198GDRhqm4j4izPAfMafoKcwc0AcIm+1PqCmiog3JRNfdfSoQFpzbD4JcrUdnYmV7/kh5MfCaGcwytWBAPefPfP8h96/Fyp4zYKQ7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743760415; c=relaxed/simple;
	bh=idfTmf4ycwMLOUECqnSVWwqShx0XOcb7QDlksx8VU6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMylR2NXm+XgRliejKI8w0zvwP06sNjJ3UqIOI2m1o3oSDMtyVtujSylua3u2Hsq0f5SuAC06VVTN538ho1YZYeKspVCczGqKqpwfjw9O2Slx+6zIXAh+jW2VzwgObAjHqcH2BvYeEugkaFCJmZ/qAgE37iYbDIF1QsB51OKPJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0iEAhm8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743760412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVGQCiVyZHkGXnn98AxsiJpRPwaHkCR4E26XV5UfwnI=;
	b=Q0iEAhm8NcYPXa/hg3KAp1puMVD5XjkeCBlSYGVBmD/oWYszRaDFxWCVV5JuWAfYbnDBF2
	CfeeW/BR6DP6RYCDxuP2qWvUzs35YukhH5MYfk2zaXIlV4Ik+FOAThnreTvTAeCrNqPqG9
	rFLqYc9H8etuSx+73XCdrO6Qq1dVjF4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Jb6021mDOaWi05iU7woRfA-1; Fri, 04 Apr 2025 05:53:30 -0400
X-MC-Unique: Jb6021mDOaWi05iU7woRfA-1
X-Mimecast-MFC-AGG-ID: Jb6021mDOaWi05iU7woRfA_1743760409
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3df3f1193so146900966b.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 02:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743760409; x=1744365209;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVGQCiVyZHkGXnn98AxsiJpRPwaHkCR4E26XV5UfwnI=;
        b=WWX+C52LZfweSYu1aufAk+Fy/hkGKgHwVNv0LztILsDoWxipxdckapiHqh0/ckiUec
         nz8QTTQ/7hmOIt7paINznPK+B7L4Q3N3VMONTLvN3jeKDZVIMO+997P7buLtTDftA4S+
         HMlW/G2qTgUSWEbIZMByVh3NQLGw+DackrySzIIo+qMhoHf65b70c0MtprD7hrZJg8A9
         vPmNRokzi7KB3RHFoVCvmZsBgd1ORtT/voB2j+oFc29MHjx4LXph8w9Z0OcCUUN80eaq
         uIo3hoXJkO/3D2nMF532/gxy7WyQlCmyYfT5KNsdMNEv9wFscZnZ7jZ2QIbpr0x0SZvI
         1mJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeCdpQa0EWRpbpaGEuIqocMtCoVoOevxniplGTNFWj8HyMXg/sug/WgZXHqPUAFgJrBQg1V8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkm4ZsKPTUshKjqNOvZUfiFOJiEIfgiqH37iLv7oz+OQ6gJVx7
	vLNX6UDeEsHn7qYXSV0+yOhbWgHeCozs39WKwpJ8isLHGjqVhAs7EP5JCG3MR46MewlahI7LfVV
	J/jlrkOtN4QEAbMF5FHViAK5JDp6+azdbWyP5Czk0GT8eHNw6LUvnxQ==
X-Gm-Gg: ASbGnct2zSeAVKEqiL2vPuNCpclycKKtOKj/8WYXZQkUHHttD7NQqKvNHttTgxTO1SC
	LLay2VA8PQaUbcEHOj6rXC1pYxTWdPNS8MvFMe+xbtkk/0ALv9kEf6MduYA2zvvJTSWq/dRNFfp
	k1Y/qFQd6jR7eHJR8sHFgAoCv74tTQXovRsVSE9Q/20O4SkQfUShTmMnBzFgIo9ld9cEjn8unrD
	zn1aACTLv34EJUucEDb5PsgOoSbcAilzfKri6/VS3e7CuXmn73bxs6C1fMXVJ6eK3r7OvkroZdq
	5FKB6OqnXjqswT5zMJDG12XwBme7UJgL2ajWoGTb
X-Received: by 2002:a17:907:2da1:b0:abf:6db5:c9a9 with SMTP id a640c23a62f3a-ac7d6e07489mr142802066b.39.1743760409205;
        Fri, 04 Apr 2025 02:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1XTUa7Ek2WhdvH5WJS2AIV0agLDZZ/Z+JEVHEXzqYzD3Mqsj3alR3nhhtT2rdlTKU/t/FhQ==
X-Received: by 2002:a17:907:2da1:b0:abf:6db5:c9a9 with SMTP id a640c23a62f3a-ac7d6e07489mr142800266b.39.1743760408780;
        Fri, 04 Apr 2025 02:53:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c0185726sm224898366b.137.2025.04.04.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 02:53:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C858818FD70F; Fri, 04 Apr 2025 11:53:26 +0200 (CEST)
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
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250403153129.013a7bdd@kernel.org>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
 <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
 <20250403153129.013a7bdd@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 04 Apr 2025 11:53:26 +0200
Message-ID: <87tt74l0bt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 01 Apr 2025 11:27:19 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> +	if (err) {
>> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>>  		goto unmap_failed;
>
> FWIW I second Pavel's concern about the warning being too drastic.
> I have the feeling Meta's fleet will hit this.
> How about WARN_ONCE(err !=3D -ENOMEM, ... ? I presume you care mostly
> about the array filling up so -EBUSY

Ah yes, that's a good solution, will do!

>> +	}
>>=20=20
>> +	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
>> +		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
>> +		goto unmap_failed;
>> +	}
>
> I think this is ever so slightly leaking the id, if it ever happens?

Good catch! Will swap the order of the operations.

-Toke


