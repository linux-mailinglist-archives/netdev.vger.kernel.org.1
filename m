Return-Path: <netdev+bounces-179430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E574EA7C920
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 14:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9369A3BB771
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2371DF727;
	Sat,  5 Apr 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhCb+tAk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE01DD88E
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743857408; cv=none; b=O+GRB+W01Jxor0UGgTG4VTvmTSCOqlarO0ueWgtFHBVz6+qPlwXWmI0ZSvBFswINFgeN7tPcRXxCtbnuedn05acAc9X26ulj1uehVGkCxko1rpw/nPFUtEsxoJ8FdrMdirV3dBayGGjmEbeiNSC/cRVNBe4imXxTgSxhy5Dfr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743857408; c=relaxed/simple;
	bh=OqPlxZ84MvDuvuYdDMJebOtv4kfa7e9q+LZcfQb1DD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MALrE8+N9o/5XffCFZdCoKg5Qwg3E6TwR+1HBTDtgGGEftFmTeRQeD4bee18ualOzke63QQWzBbgLXOkuaOa8eP6QTjppLiW/EKLYiAx7KFQ95DBqIag0Er9SIkwndj/FTXjDixIFlSzwQKFe5PAEZe2t1a3EH39VTw9dZWWQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhCb+tAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743857405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJSSsQi4y9qy6Jap/bBqkOsEFxIFhRATV85xzgJwngA=;
	b=IhCb+tAk9flxAFGQiNa7SocPsgZAfHC9Y5AFdHuY0d+m06294DF8/9+3SG2tpToxv1Mpyl
	w3kjmYe7TCFcq+LeQsBvxbPXAB8ryYQ2vru2frEY3anYVXwpSNmv21rcLpcep7Np+V4T8t
	rBNbiocsYengBa4lkOSjFX2TZX1vWHU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-oGi0UBUlM12PxiIHcEQlFQ-1; Sat, 05 Apr 2025 08:50:04 -0400
X-MC-Unique: oGi0UBUlM12PxiIHcEQlFQ-1
X-Mimecast-MFC-AGG-ID: oGi0UBUlM12PxiIHcEQlFQ_1743857403
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30d8de3f91eso17104571fa.3
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743857403; x=1744462203;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJSSsQi4y9qy6Jap/bBqkOsEFxIFhRATV85xzgJwngA=;
        b=QUdLMyVBTZg8pn8Gi9fLINwou1raem0TVWmwKAIFG6o4R7PIIoSjRhP9QNXvbjsW5N
         KQYbASm7fHMi4/i+63KlgL9j/li02Y1OJSucofNK6oImbEYrZezm2ZAqdzpBwyzMJrI4
         8ewhtJWF7lTyCnh2r3g25qcxkP/FA1RWbagbMfnfnld6K4M3lbUazxV1BxovqZDBuI3X
         ybzT8E+K6fDu9A60LyhsIVRe9vKIkJJCiaWNhiri7Hwd3MOUDQNOUgMuOdMYMou1XVpX
         AoH/n41h3pQE1MITgTeUolYZB3A1tg41rZdj3APeu437TTus9cHntBAX7oW+z/jC0EwJ
         2snw==
X-Forwarded-Encrypted: i=1; AJvYcCVvQwqbe4u6R02A+39nvNuMbWHkcE2aZ2IeHuVW3rq078vo5tFOCTGlNHUHrsPIQ+vmlWSmyWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjF5zh5TpwXYCVLvbq33uw/WBbYSYgRRWKZMwOsgVWML91PqhN
	sUJtuxfeQjwTx1Scf5gS3o0hW416GKZnttK2E429ZYq6fmgnkNgSITLhxHxVv0ARET2PKNBXuI0
	39tGCs03z4ylybRxZzycWBZb16AKo2NZP5XCz2si/EjQhui3v0wSCAQ==
X-Gm-Gg: ASbGncuhom+hKBdlFds6vyOIJnIfY+czEEy6oM9qyBeOa8PhuNQG2H7nTpx86MtmB2h
	m8CvP1joI34T2Bla5/zp0LXSjbL/+nj4wUEnCrMIBuNmlqxRzfiLbOnhvbu6Io04NnvCgbC5wGr
	gVPOu0ic30k6LRpaKdOEiT0l46cV1P2erBh/sXmcUm4SsPSgC0lC8JQqA/cezW7RL5eFjtK923l
	qhIGV8ZI92KrBldPDzDxvzH4b0yJuqhRnelQcVbO90v60AtJsYxG8V5GnbxDlI5gP3ktFGx+CtZ
	M2cBlJGf9w/nNYy/Mh3gv7F7M3ZhqmfkVQysvH3K
X-Received: by 2002:a2e:ab0c:0:b0:30d:694d:173b with SMTP id 38308e7fff4ca-30f165a2ea4mr10764681fa.33.1743857402902;
        Sat, 05 Apr 2025 05:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB21V3mnevjJOBuKtDbkjuEQHYW7vTlUl/JuKqTWWRK9nD5+it91BDmAxcHGGPPFWJPz3EEg==
X-Received: by 2002:a2e:ab0c:0:b0:30d:694d:173b with SMTP id 38308e7fff4ca-30f165a2ea4mr10764381fa.33.1743857402525;
        Sat, 05 Apr 2025 05:50:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031ce793sm8871321fa.107.2025.04.05.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 05:50:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D0AC618FD793; Sat, 05 Apr 2025 14:50:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
 <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 05 Apr 2025 14:50:00 +0200
Message-ID: <87jz7yhix3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Fri, 4 Apr 2025 17:55:43 +0200
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Date: Fri, 04 Apr 2025 12:18:36 +0200
>>=20
>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>> they are released from the pool, to avoid the overhead of re-mapping the
>>> pages every time they are used. This causes resource leaks and/or
>>> crashes when there are pages still outstanding while the device is torn
>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>> device on the subsequent page return.
>>=20
>> [...]
>>=20
>>> -#define PP_MAGIC_MASK ~0x3UL
>>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>=20=20
>>>  /**
>>>   * struct page_pool_params - page pool parameters
>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>  	int cpuid;
>>>  	u32 pages_state_hold_cnt;
>>>=20=20
>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>=20
>> Yunsheng said this change to a full bool is redundant in the v6 thread
>> =C2=AF\_(=E3=83=84)_/=C2=AF

AFAIU, the comment was that the second READ_ONCE() when reading the
field was redundant, because of the rcu_read_lock(). Which may be the
case, but I think keeping it makes the intent of the code clearer. And
in any case, it has nothing to do with changing the type of the field...

-Toke


