Return-Path: <netdev+bounces-148929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674949E37DC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C02A2818BF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574F1AF0DB;
	Wed,  4 Dec 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYQnrOXT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55F1AC88B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309353; cv=none; b=mnrGL30fbJi9Sy8h+9mUAy59T2FHUbpYn6y47RqjTps4tOKfVH1wuiruuIAGFOABVSRBVAvwvj+dk5AYws3utUSR98yA4vxN7eilHazGNnCRC2LCOTdxd6RUbXv3MjdfbYDqG3AMZ0Ma1+289fJgyNLFQvGN4Z7jarQikRPSpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309353; c=relaxed/simple;
	bh=bGyB4438J81jRH4x6gWKO6BpBH8blrXI02fUkyoMcgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/zW5YLKORmQIQDKeYy1wbUwi3IkSEPjwMask4tLR9BuAx35Ww6z1CmxhjN64ko90UZ3BBlVFmUPYxHUAcw7gTstq9Dm7ZOZgFoRpmr2N9Btl1QZFksFehQFdhvwXdkihhSTsSLxRtm57Nhp07rY3ICqdhLzKOMWMU8mUH4aebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYQnrOXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733309351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTz3waxgahN3oOX83LVGcoQz1BmDfZdx8p5FTeZL4LM=;
	b=HYQnrOXT4gK1jXJZ6Phz4bDdhK3JXseFPQb9cFwEm1dR/hn1vEVqUp/D7LbV4IND4d5WrJ
	74skfoQBUTGrTwzA1YbZkOJLhMvVDoOlEp4LCPTXCjnkXM+PpocMQihFvbMZ+NEUs7a0lC
	6i5/i8a04hN2apIu8wJzXcNOjRlJinw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-PX1vnPeJMPmT6wju_zmaAA-1; Wed, 04 Dec 2024 05:49:09 -0500
X-MC-Unique: PX1vnPeJMPmT6wju_zmaAA-1
X-Mimecast-MFC-AGG-ID: PX1vnPeJMPmT6wju_zmaAA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e9c698e7so458071f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 02:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309348; x=1733914148;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTz3waxgahN3oOX83LVGcoQz1BmDfZdx8p5FTeZL4LM=;
        b=OuW+O5SWC+i9riVxeCmJanJ+HR6zM0ZNda0Iei3o45Heosn8CiKd8PjDYIUZLtqRZg
         oGEOhw1h8BKVA6PPpwXrH15gMryjkT18DABXkaeYxOI/ecmqE4vGyIdPI5awyANPfdxa
         1M0bbJ+7dcwHvuZhwaA6OkMRpCdalIhxGYv/h7VwB0H+o/r2g70tv3SpCirMMrDdNiCT
         BA1RoXcAMd6u0xhQjq+bmExq4tvBZj/pQWgsP6QzuWE5LkRXSzQuwfUaLF/3kK8sYVVv
         bxGz1QYAnLruexO/MpJ1ppwwfm8A4w+J15eAPPq8CG8sw/C8GsiFaUbG82Vw8hGAMfoO
         lPIg==
X-Forwarded-Encrypted: i=1; AJvYcCWN9Li4NNW94kW8jyl4v3sZ6r1YCMxZSvKMMnboXUbYYI66xOR6UPhg/VbmQEMcjTMDQFey4Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7JNcCFtvfYm0z8f2sIPJ1wLGSapMe/IJIFdHL9no8se767LM
	7ftRyGauerb83rEX1ectASiHiqCras0kNLHH4mtaKVYTI4VBWYxeHQpY4pAugBQBERXMctyZZE+
	u4YMW/s8h5l/6vkSvhG6amuZjfpBHfvT+Zj71ahDjRecofqMN30CjtQ==
X-Gm-Gg: ASbGncuh7IPX7GEEnrn7Fk5jYH0+u9mFGpRcKf6M05QrodjSrzfSkVQaSYkDvTz5uBB
	gnTpXX140iMBq75/AIxQ7Ew2Ym/YL1/Drapp84O3MgLGIjtKY67oDsHWbTM9J37/b/gu4GKxvt/
	BEmum9+Vpa5UKQ4SGmzcOQpI84w4Bvt7Y17btrJykxDHWZTLXfofzVNBkauI0e8cyEb4QpD56UU
	AFzpMCEU/szt101abbRjjfoAMviha7vd8qkZewXBTTt7uE=
X-Received: by 2002:a05:6000:401f:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-385fd9abb87mr4384222f8f.19.1733309348365;
        Wed, 04 Dec 2024 02:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcEgMypYhXM56G/nD3wm0gwci3A8/obXgJv7EiRTyM21DWn6RxvvWTZKFaMDEAHFySbGhZ5A==
X-Received: by 2002:a05:6000:401f:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-385fd9abb87mr4384198f8f.19.1733309348033;
        Wed, 04 Dec 2024 02:49:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm17799002f8f.29.2024.12.04.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:49:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8C43016BD10C; Wed, 04 Dec 2024 11:49:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/10] netmem: add a couple of page helper
 wrappers
In-Reply-To: <20241203173733.3181246-8-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-8-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:49:06 +0100
Message-ID: <87ttbjafkt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Add the following netmem counterparts:
>
> * virt_to_netmem() -- simple page_to_netmem(virt_to_page()) wrapper;
> * netmem_is_pfmemalloc() -- page_is_pfmemalloc() for page-backed
> 			    netmems, false otherwise;
>
> and the following "unsafe" versions:
>
> * __netmem_to_page()
> * __netmem_get_pp()
> * __netmem_address()
>
> They do the same as their non-underscored buddies, but assume the netmem
> is always page-backed. When working with header &page_pools, you don't
> need to check whether netmem belongs to the host memory and you can
> never get NULL instead of &page. Checks for the LSB, clearing the LSB,
> branches take cycles and increase object code size, sometimes
> significantly. When you're sure your PP is always host, you can avoid
> this by using the underscored counterparts.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Makes sense to have these as helpers, spelling out the constraints

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


