Return-Path: <netdev+bounces-172159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4999A50657
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ABD163B7F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E424FC0A;
	Wed,  5 Mar 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K0TT9O2h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6802218CBEC
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195751; cv=none; b=hiUprMlgy9H+iXjKSoIeZvWET1QXh+KWzlTqvACwegVXA7BJ80GpmyQoLouHJj11cY0FM1zBXSjhnKAN7LNfTLskyvnQ0SydqteSUaLHWz2C2NNBzVcFpX1K82vRPRTVGF3GkHMGHWWpR56tapJCemoxcMHtSWnlepR24qlkl94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195751; c=relaxed/simple;
	bh=B1wNsGRlbNuh23FquOiVRPjfZ7QTWBC3oKDQKjyCdJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYtZK9BmSYLJfNzH3ga82wvRd3sRrQsVSLyLb0AZD3rKc2lHIR6Kf3x3GyUXkCkDYFrrwiQlk23SUGl3mtWUslGm2yKyQ73wG6psdLmyMuw9m5bp4CA2WkpLpdbOtM1UF2yLH977srOgKGXH8ec+hVvduYiho08loRrq1fBnpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K0TT9O2h; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4751507fd08so4794051cf.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741195748; x=1741800548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c907La5P+bJluU/LHcR6Es6yd6jk3jgKb5ChVAM4Ut4=;
        b=K0TT9O2hTf5bnrGKM+kXK/8rBL6Dhtz+A4wj+laJR6nnyAkZjq44J4EE8EtNgDvcTR
         GMZ8BmS30STVnJERL3MiucAk51Asx+hAXWU3mK64Tyu6LDYr6bbSlR9Gn3neJ8hptXsU
         xxCyRay28z+yZFzULF33wVx/WebpPtuS0bdTnhcm6aMKxZ0vtXc9EVI1HhsFl3RZ803M
         WHt8l2Rm84t/cv+0/aOiUfxGjWLrkJgHPnYhfXxPYysppMTQDtER6BfmG88GKeNfcx9g
         JLP51QHm2HG1X1xQW7cyLXqqo8SSrvqiO9bZjjom0hoSBTPsG1caktyW69JBJOW5OpGp
         HeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195748; x=1741800548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c907La5P+bJluU/LHcR6Es6yd6jk3jgKb5ChVAM4Ut4=;
        b=wYxhOsSo4S5HJGH+4jFxZiamekzFiLaLcgHlPcG6JZGSs5F+zVEPL0ijczsjhMyNTH
         irqvszq5BwFePCvE+OLUlkqDOk9QGglbPAYPYxDOVjR0xSDc3eY1iY8qrkF28yAc8SSx
         Z6ZQqPdOm3afnkO/p6laHnNptZEVM2RJQ3HTUeNFaLqoX9Mrc6SMUVyvBc7BIMfk5MBJ
         iKrm3smrSJQmq8sKuR08oHIFE4CaE2tFVlCSfYWugMrqZZWYvuc6YyAcmLJ6laWn/hK9
         WUiZEnb8BKRhjVWqLLEdTHTxdfeoth53fJU6tMhX+9CB7m22A/Ll6EzSph7V3jqoxaJg
         nO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjxojsWbSGecmENEkSw4MDgF8b1Vuiu+8gtFvQKn34chUkAgW+4PjDPgn6wduogCUxpysB60E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9c3zAMckiYME+NwY6zUKvVXcYn2+Vizr0aw29V0PUbS9701A
	wonSWpMWWdcGeVZLHG2Z7pOOi0C/PhqU65AGqnNaqzeekNvsEHvRjTcS2jY2tk4=
X-Gm-Gg: ASbGncvB80cMxprAkmtcz/Ao/FYru7mVYu4VKB/BJ+21k6q+Nbc5hXXiGeHKZiXLKYD
	uP2ELcM+oK3DvfU9QW5fG+vzKM1fQNhDe9OAIIjDFx2v3UsVx7BbmUrmR8CHKzHdyYZZIMjZ1tO
	BhX7vHwVJ5IebvWqkmoe1DOEgGFi9UAe62v7w6lnC4gsYxZnMiJsNu4E8nwL7RKwyW6vQ2ho+co
	VNas5dRXuSS9TGR4RBZArckR6094VGz5O6BOaE2IFFtuEMqFJTiwCG74rwF0O/kXXo6rq+13vR0
	GvxkJUY22SNUwWON2QQ=
X-Google-Smtp-Source: AGHT+IF4HNniD3vBEgV7Gc4XgcYAVaPywo5omCnN6AqAFGgL1Wjv+qwspVU+lTzqtNoHgcoOul5LVg==
X-Received: by 2002:a05:6214:2525:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6e8e6d144c4mr53580176d6.4.1741195748275;
        Wed, 05 Mar 2025 09:29:08 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765364esm81249136d6.35.2025.03.05.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:29:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsYM-00000001TIk-3gw4;
	Wed, 05 Mar 2025 13:29:06 -0400
Date: Wed, 5 Mar 2025 13:29:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 4/4] page_pool: skip dma sync operation for
 inflight pages
Message-ID: <20250305172906.GG5011@ziepe.ca>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-5-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226110340.2671366-5-linyunsheng@huawei.com>

On Wed, Feb 26, 2025 at 07:03:39PM +0800, Yunsheng Lin wrote:
> Skip dma sync operation for inflight pages before the
> sync operation in page_pool_item_unmap() as DMA API
> expects to be called with a valid device bound to a
> driver as mentioned in [1].
> 
> After page_pool_destroy() is called, the page is not
> expected to be recycled back to pool->alloc cache and
> dma sync operation is not needed when the page is not
> recyclable or pool->ring is full, so only skip the dma
> sync operation for the infilght pages by clearing the
> pool->dma_sync, as rcu sync operation in
> page_pool_destroy() is paired with rcu lock in
> page_pool_recycle_in_ring() to ensure that there is no
> dma sync operation called after rcu sync operation.

Are you guaranteeing that the cache is made consistent before freeing
the page back to the mm? That is required..

Jason

