Return-Path: <netdev+bounces-140352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA039B6261
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D753B282DC1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9831E765C;
	Wed, 30 Oct 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRpqLChi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECC79D2
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289483; cv=none; b=lI6/t686P0eNGe9RE7OtDSIxTmudbneT+HpWJM0J/jA93ihRbvzpQTxg+VcVYkG0UN62HIZ2stcVJYMbuEi24LJWdbZlpii9Xqlf1Y/57BsMhpxo+5nc3FWARW8XWFXjOt4q2wGDzHDUouksS+Y3JiXoBpQRvUFvh+TUNg4d6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289483; c=relaxed/simple;
	bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfzJaywXug5ardf7lBFLpN6uXW7scaKAzP/lo8AmVcxnJbvSK7QN441+vb0S3OVZgtZR5iyBymIkELi5AHL0EA5ddrcrGhlv272QGdSQRg5/aTQSPOaaK44+ouVlIkWUeGOcW+mUMbdTdCt6wa1LS6OVKh5XxftBkvLBkpRYaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRpqLChi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730289479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
	b=MRpqLChik4gNTqA+JQgyqE/pDi0MX3WcrOk0OAMk7+qPY6Juad9DWhFs2gdcBFyBPjhWN3
	AL1LUWARFxUka2DwfJeKifreCqHnKx1Tiy/s719zJu4nKxp/FH+gwd2n2qjiZ9zc7vo6jo
	ayMKFboTaN0+Wxw2RH4XCbd/7GZWfco=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-l22USYxJNqyWc2vZQnF-Pw-1; Wed, 30 Oct 2024 07:57:58 -0400
X-MC-Unique: l22USYxJNqyWc2vZQnF-Pw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9ad6d781acso439809066b.2
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 04:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289477; x=1730894277;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
        b=QcxZZQZsbssPGlunmSUz6ZPLvvRzqBOPVlXSb6T8MUNYYFhu+4ye7ERk3Iyctm/6pV
         UqUEUGa0VGELY7Z9MsHWhgkdxB750n11Xia3PcUORxXMqllQbCd81K0z8S5FASd2jp7X
         rhf+iAST9g+azyZU7B/m0WBDUuATlEKet1lj6WSrVSjSnL2ADtUlgO0RKFu17NXN5xXE
         sKTahnWmXkaetj2TtLHndAVelAVRwnv0NLk6bussHpgWvsGyL8600rC3pTHwn5njkmg8
         MNNcyg9NuprH0QO5xdTBv46qkI4JLUwfKpLlrJlitRfEXGfC0ucXWXuli4yOtTl7xaj2
         ZftA==
X-Forwarded-Encrypted: i=1; AJvYcCV5shhn8QVQztU/09f3bugAlNyNP5tgZ2W0FcPkWhI4X9xIgA+3R91uch9g5RnGwoPI2tmURV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9cSiyHAtW2ckedT0RMTD7RlO0egcQzKQDuuwYNLgzI4iI9q+
	g5XYxNkDxcC0L0KjwqtSbUWg3oeHmXDw5ATJ3LIFgvLk1bcvCy8mvXB9rDH99sbokc9aS/2U4rk
	XniT2H15uUpGWk2h0lXJ7TDf4iatpTCf++qKiVjH+YTP0nfizeBr+MA==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr1567689066b.25.1730289477273;
        Wed, 30 Oct 2024 04:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVLgw5rE9QA3Icf5YbgX5jGmETg3oQl1odAk1S8jhHGqLiYvv6XcYW/kBL6ZHibuCo5cMEsg==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr1567687166b.25.1730289476927;
        Wed, 30 Oct 2024 04:57:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2982e1sm568328366b.99.2024.10.30.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:57:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 49BAC164B390; Wed, 30 Oct 2024 12:57:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 30 Oct 2024 12:57:55 +0100
Message-ID: <87o731by64.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

>> But, well, I'm not sure it is? You seem to be taking it as axiomatic
>> that the wait in itself is bad. Why? It's just a bit memory being held
>> on to while it is still in use, and so what?
>
> Actually, I thought about adding some sort of timeout or kicking based on
> jakub's waiting patch too.
>
> But after looking at more caching in the networking, waiting and kicking/flushing
> seems harder than recording the inflight pages, mainly because kicking/flushing
> need very subsystem using page_pool owned page to provide a kicking/flushing
> mechanism for it to work, not to mention how much time does it take to do all
> the kicking/flushing.

Eliding the details above, but yeah, you're right, there are probably
some pernicious details to get right if we want to flush all caches. S
I wouldn't do that to start with. Instead, just add the waiting to start
with, then wait and see if this actually turns out to be a problem in
practice. And if it is, identify the source of that problem, deal with
it, rinse and repeat :)

-Toke


