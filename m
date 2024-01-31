Return-Path: <netdev+bounces-67595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42D7844330
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EB6B2F4B3
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBFF1272C2;
	Wed, 31 Jan 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx1gY7cj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E586AC5
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715127; cv=none; b=eRy2vX+Mdrr6VRwx+4cT3E+Sz2x1fZgZ1nRMO0HyL0/pfa+NU8odeO5EcMH6A9edpQWz+1PCLHQUjGiY1uBpADu4hxwAEDYGevk7PFpJB3U+YFKK78WbIwCwQOAQTXTj3CmsZNq7SWJrY0+pQBW9U8fK4Gdq6EJnupyAOPs2zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715127; c=relaxed/simple;
	bh=7XG9+ZkiD/dg6Vc2IcOCrel6XfLZQXkSscP5YlJTJfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Es1K3jw6yIYR/Th6VDKX5pkK8Ijep+JqbA+TdNomMyPuBoRA30dCpI3+FTzHexi+FTfg9UGDWMXQTOVd5OBCB6hL4pkc+wAskdYhSfOamVzinEedOa3aL4nTiqAT6ZGpj/JtHaf/VDGkKRUO8FQDBuJPdbt948gXj/fs7DEGiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx1gY7cj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706715125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3OkKTKiI71jMccUTxGs7zx4mOX1sEJG3zIuh/sFpVs=;
	b=Gx1gY7cjwyuzbT1Zgptu/aEvWI1xd9xgBte1e/I7B7Br6gE+XWptGdfpGF60CkD766n0aC
	ken4gG7mJAjcbJrzi+JpKVKqtuudG/FH8IVNZ6A8T/SWfTSUTrmRUhqeLLBbsAyuIAwzL+
	t1VY2BpvfnOvEwhSdTW2QJgkJOh9CTc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-CbfD2yTvNXyOOMwao0P-8A-1; Wed, 31 Jan 2024 10:32:03 -0500
X-MC-Unique: CbfD2yTvNXyOOMwao0P-8A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5111b864decso1913007e87.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 07:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715122; x=1707319922;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3OkKTKiI71jMccUTxGs7zx4mOX1sEJG3zIuh/sFpVs=;
        b=DKEAHW4+KoWu604gyTIZ72XI+6XqjTwzqi8tXcu2WRcyo/DMRhuvZVeruU2L5Rcqi4
         TJg8K6FvjWXX/wDvQPyTZOQloiyLqhetsLKB8F1sEGr1HD9uefFCWsETSxzOR4kQMHJD
         nmTpXZz0ai0wiv3Yu3dW+AAlfFe70VgcT7voecZrFkAnDITJHQsbgsM+gNak/JwoZQ7S
         sgBvZaxZgj7eqLDyl0FK3ecgg9GrX4/BM9NiHrGDQU/9nm9Hu5X6Ts/4kQxrkbDypXH4
         P2DmVwn8MXRrjymoAFae+MS4BPqVMmdCT9OxneqK+P02ir2dgc4STv7urwSUvvsXqg/V
         NE3A==
X-Gm-Message-State: AOJu0YxmuExujGdGDq6f7SlocjdjnmSsLWg5k9m/h6yJIhf/m88kzq2I
	93laulLd+Hp2SY72orQNvMx4B4aWp7lXNjMPUhkiSnoeGQCaWE3KWu52Gi8teuVBVsTCTJ/z93o
	rYFtI2YZALJRf5dDfl11WT+FoAiVPjp5Q8hYO9Q3dsaoj5DHzIBDdwQ==
X-Received: by 2002:a19:ae07:0:b0:511:1775:5a1b with SMTP id f7-20020a19ae07000000b0051117755a1bmr1255704lfc.38.1706715121913;
        Wed, 31 Jan 2024 07:32:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEoECeHFUgDCVTi1EZbLxF3rcSnI5tI4RBiG/CN6lr6IBT71vYl6qATLy0AYB3nRjCTTojGg==
X-Received: by 2002:a19:ae07:0:b0:511:1775:5a1b with SMTP id f7-20020a19ae07000000b0051117755a1bmr1255688lfc.38.1706715121524;
        Wed, 31 Jan 2024 07:32:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSqw7KlB7u9EwhopF17qFeIsKqIfqqxmHRmuy5U1YTmyE09a1/IhP2Em06LF27Wb7m17/jhnBK3GS+ACzzu0pnI4Xd7BT6juzstQ3ySMRtwYTcBS35yaz8zZRNaIOF6ZEJeU7M+pBqKMvHf6pDOw1EzJ39bIbiIjdrkecKpm3raMWKDjghYSPU3qZATIhNUvKIqTzmHEjV3c9YR0kMPU8cMJOE9S933OPp79FFnyCc6J+Cht1qbR+tEw2qqpbjjYxatZ7Uw9v3pwdSLEMbpTBUMUOw2aGnDGZwcdDrZO8vHa6FBUVXvYIAEPPvCPAdiHyPYWfjpWwb+25QTb7qf4+crSAQwKjzyTraGq5RQumAmKVK/Udo7kQa+jMmHhdnhey/bFtNDxmbrEpq10VXcDBPzg==
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a3687cde34asm476328ejc.5.2024.01.31.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:32:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C466D108A4B2; Wed, 31 Jan 2024 16:32:00 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
In-Reply-To: <ZbkdblTwF19lBYbf@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
 <Zbj_Cb9oHRseTa3u@lore-desk>
 <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
 <ZbkdblTwF19lBYbf@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 31 Jan 2024 16:32:00 +0100
Message-ID: <877cjpzfgv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> 
>> 
>> On 30/01/2024 14.52, Lorenzo Bianconi wrote:
>> > > On 2024/1/29 21:07, Lorenzo Bianconi wrote:
>> > > > > On 2024/1/28 22:20, Lorenzo Bianconi wrote:
>> > > > > > Move page_pool stats allocation in page_pool_create routine and get rid
>> > > > > > of it for percpu page_pools.
>> > > > > 
>> > > > > Is there any reason why we do not need those kind stats for per cpu
>> > > > > page_pool?
>> > > > > 
>> > > > 
>> > > > IIRC discussing with Jakub, we decided to not support them since the pool is not
>> > > > associated to any net_device in this case.
>> > > 
>> > > It seems what jakub suggested is to 'extend netlink to dump unbound page pools'?
>> > 
>> > I do not have a strong opinion about it (since we do not have any use-case for
>> > it at the moment).
>> > In the case we want to support stats for per-cpu page_pools, I think we should
>> > not create a per-cpu recycle_stats pointer and add a page_pool_recycle_stats field
>> > in page_pool struct since otherwise we will endup with ncpu^2 copies, right?
>> > Do we want to support it now?
>> > 
>> > @Jakub, Jesper: what do you guys think?
>> > 
>> 
>> 
>> I do see an need for being able to access page_pool stats for all
>> page_pool's in the system.
>> And I do like Jakub's netlink based stats.
>
> ack from my side if you have some use-cases in mind.
> Some questions below:
> - can we assume ethtool will be used to report stats just for 'global'
>   page_pool (not per-cpu page_pool)?
> - can we assume netlink/yaml will be used to report per-cpu page_pool stats?
>
> I think in the current series we can fix the accounting part (in particular
> avoiding memory wasting) and then we will figure out how to report percpu
> page_pool stats through netlink/yaml. Agree?

Deferring the export API to a separate series after this is merged is
fine with me. In which case the *gathering* of statistics could also be
deferred (it's not really useful if it can't be exported).

-Toke


