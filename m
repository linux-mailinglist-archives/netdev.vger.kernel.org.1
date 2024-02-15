Return-Path: <netdev+bounces-72010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB431856282
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5441C233D6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723B12BF00;
	Thu, 15 Feb 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfVT70Xr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D412AADA
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998737; cv=none; b=D0Khp3P849rEJHUwoi1XUb4KcFVyN10ZmPuWQLZELjk5XCN3caDoSf/wyfsZ3lryLEft0d6HpGGkRGsitgEgXWb2S36uMdlwoK6BgKTuAnw6JnKr4y+CU+X64NZnvKdpZ5sbFwS/tsjXxknLJ3Y0QYn1gMqDdq6ktYm/G/8/h3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998737; c=relaxed/simple;
	bh=CbSKbK1omO7SIzg5N1xXqurgbpEYg8FvdIpUX/tdDrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9mRKmTMM6vzuZmRDOvON+8pzOT0fIm6TpaOvqoMerPcRIiw9A0Eu0xlC1+1Pn+hE0TWy86T3oMTSkFjG44RmMgCy8K2V7B8MLTbK+NJhEGOsH+FeJtRJ+0zv3V5rXaE9kcBTOVLvzkXn7tCuWjMKimUSjK096DWkhCUTNwsfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfVT70Xr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707998734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbSKbK1omO7SIzg5N1xXqurgbpEYg8FvdIpUX/tdDrA=;
	b=YfVT70XriNgIWzKQ/pG04TzDc6Z5qvgFLVzr4Iha3g4pL0eq6psUWlqIf7x+bC6IEk/xLd
	LPBeZSSN5Sw/91jC6h4g5d0wboWJBtB369jixeZMKiPOecwUCUVGZAa77LA9TM1IlqD+wX
	2zvfD/WcwSu/i7c+Z2Kld6Z/F0qzOdQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-IeKdAZLAMn6xIK2PIYMyyA-1; Thu, 15 Feb 2024 07:05:33 -0500
X-MC-Unique: IeKdAZLAMn6xIK2PIYMyyA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d38947c35so48151066b.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998732; x=1708603532;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbSKbK1omO7SIzg5N1xXqurgbpEYg8FvdIpUX/tdDrA=;
        b=E+sGnl8RpMDNwzF0RYAJOhIQAF/5Nv3FUTxEiHxMNAJd8O+ENhcFmx7hKo6YSLzdyh
         HTUMOfo2fEiKrNZOjiAFrZuLewM6lmNwGgjJy7it1p2SmgoI9zNGOJHFKRyyKdyL+RA3
         3rs+sivmaZf6HHA0oljioiQzBe0rUO+Rg2d5rWkwuxv+zum/PwhsFNPyltDXtgRRi6l1
         Gv9SutYe7QsnT2SNSdL9sCFa/GvvztnCGfNyq20/exHhHrbeiS2+ATOROccsmx1Ao2C1
         MgICEPH2UsRgCdsIAbGXDOOTQWesswlJv+XHu7Ll+KYvC5W1qRN36w/T5fuEkVdSobqN
         eyhw==
X-Forwarded-Encrypted: i=1; AJvYcCWeGdL2ZjitFE7JMKhLXnNY5lnNMhAQ+jaLmq39NoNHMxJGzLEjsSVcLlM0cSCjpcQPBtHt3PRR5yOQ0FdNTwVKSvAoxqgR
X-Gm-Message-State: AOJu0YwnK1oQqEyfYFvRS4JrdRLrH4BIIdhJaiWA2a/5nWjajr2qAuGA
	e8DJALCSwddr2G+/DeEA5mY/ee9Yehca5Wy47yOLdrxv9xs8vCAB8/dELsD1VcrtGnqVzFI8x5I
	Zg8R3TS8b40fHGrjFMLl1RY/bSvZ0Jj8sfv0BO64XXYurDGrZfxFJHg==
X-Received: by 2002:a17:906:80d7:b0:a3d:a4bf:8fd3 with SMTP id a23-20020a17090680d700b00a3da4bf8fd3mr628235ejx.49.1707998732056;
        Thu, 15 Feb 2024 04:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw+wzerRQ+mi4gSktWu0188A5Sc9gu68b+T99IOSd6NOn/+2nPfd/fOYDNmhEXrS6GL8zbDQ==
X-Received: by 2002:a17:906:80d7:b0:a3d:a4bf:8fd3 with SMTP id a23-20020a17090680d700b00a3da4bf8fd3mr628214ejx.49.1707998731672;
        Thu, 15 Feb 2024 04:05:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906a19a00b00a3d636e412bsm474883ejy.123.2024.02.15.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:05:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EF30510F59A0; Thu, 15 Feb 2024 13:05:30 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
In-Reply-To: <20240215113905.96817-1-aleksander.lobakin@intel.com>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 13:05:30 +0100
Message-ID: <87v86qc4qd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Now that direct recycling is performed basing on pool->cpuid when set,
> memory leaks are possible:
>
> 1. A pool is destroyed.
> 2. Alloc cache is emptied (it's done only once).
> 3. pool->cpuid is still set.
> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
> 5. Now alloc cache is not empty, but it won't ever be freed.

Did you actually manage to trigger this? pool->cpuid is only set for the
system page pool instance which is never destroyed; so this seems a very
theoretical concern?

I guess we could still do this in case we find other uses for setting
the cpuid; I don't think the addition of the READ_ONCE() will have any
measurable overhead on the common arches?

-Toke


