Return-Path: <netdev+bounces-160832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95502A1BB3D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68299188CB9C
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1581BD9E5;
	Fri, 24 Jan 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5yngais"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF323B0
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738828; cv=none; b=I9F6fpWQmVUJTt0d1WvpAGzp061GZrldinBxE0xFZaLr/7VWyjEghdV0TIoP7KNE0Ch5ndGTSu4l87PXODsd/TQgPrRxRrkhzukTjAiUY/Z55h0OwyRRy4dDUD2C4D6DDGtdUSa+3PoAWdJBD9u5e+ywXaZb0BLiWzVhObQ+sf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738828; c=relaxed/simple;
	bh=iiMJlnjqVu9fqhSNV3EMXqwrwqj3JQEHc8FTUyKDyRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HwznVA3e74mSc720MBasj82cICYsX3USGYjeGwQUPoPIBliF2b1dklYcseNl457ecaiuGAVTnP8uFXvHCT3Is+AAI01bbOIlMCGSRY5u5lUl7TJUYpZV1+v7GpqEOyoAcszFVxlPX4PhRkJxHFFSp5N0NTDmPjm36Y4XliriKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5yngais; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737738825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bgl21DlUR8J6PmKG92PJjxElpV90g1dFpTjC8FMtbiQ=;
	b=L5yngaisRHRnmP72uBrWlsXVxa0pBW5qe/I9ouH63oo1cZzWLHx7nd8EN3FGALPfWIr/HA
	YzNWDMNI0BlqyF4tc4N9I6XvFCCUFGt6Asy4/TpaLx+XsVKsK5SFodwwC8LChaTp46BVyG
	6ThTGvOfIA3msBUnETWKw8wiLuS6BfE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-kKGlgA1fNXObrOEZsNzwCw-1; Fri, 24 Jan 2025 12:13:44 -0500
X-MC-Unique: kKGlgA1fNXObrOEZsNzwCw-1
X-Mimecast-MFC-AGG-ID: kKGlgA1fNXObrOEZsNzwCw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa683e90dd3so230520866b.3
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 09:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737738823; x=1738343623;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgl21DlUR8J6PmKG92PJjxElpV90g1dFpTjC8FMtbiQ=;
        b=SahMQUeiPDwMFKHOiAJGNxfIfA1I0i9xYLNqKzx4Q2iyz+HHXoZqbfZUXzjFzzuxnA
         qEx6WkNgJV69swWYnTj1YDe0nBXAwj/XSBjXoVcK8YxOJHdUW8+G5wJE4IFMfH3gc8dt
         C23VVlJvZooSx3YZd9yV1fS0Ub3CibOMfngpW3+oe4VN3zC0uUCdsqyiqozyJvEZ2Cmz
         UlUAa/b/786puIo19AZXq3yhniKP8q21+1thNONyer1BdQDUvi5L8Q5bSJqVg6ieHZTu
         hwzsY08gZbQ/g3bb4Mea/bEFBKlW2ypIXfnBkhy5jF+Nq9G9tmg+SX4OqyAmAa25Ncei
         N7XA==
X-Forwarded-Encrypted: i=1; AJvYcCWFbCWBHxtb47k0N1YzlrrmlF5F7+UAtKeZjSrSfBeigh2GIwEiHvRHJJJxDbKA0WEwIEWNKOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RKb2PEPoVYQJrmMvzFzdLLXeyC9IDzESYsmZcYoTzMsP47XJ
	a4zTFwlgzCOHHgRiv+JCCVRSKfajSAMLa/SvjUDn3VxVxcPdWyAmGJdgsg1zZlXV/id4Up5SiLR
	1jvLVxMebwdmb/F6TWDWqFMBhQ4JomYlpCE8RU9nxEecXSA9VY2nbnA==
X-Gm-Gg: ASbGncuVCux68H3snUMCOUyol1Jl5s57cuNZ6hcKAp3Ltj4X8zR7LyudPMP73Ix0tE4
	5ZOMjiZULrMlnScHRMlN6h/DSe5vTUObOpGj7tsBsm8TPKgDuhVESCaBfN9NKLEbN4Ejqz74QEL
	7kcd/3FxOtn1/dLwaPPK7lgs4qzXJaZIrYwGXXCyN6ndOzNqJPjBcBQtr3j0glc5C898cbU4xhw
	UFq4ItK+Ya6XZC2vL7cSm1B8XYMlLV26At//5v/UFr4w7p+DxMdbtED3E02ryhEymACYlL/vP2t
	bPZx+8CQBraoHQEx4TI=
X-Received: by 2002:a17:906:4fcb:b0:aa6:90a8:f5ff with SMTP id a640c23a62f3a-ab38b3fbfe3mr3118160866b.50.1737738822870;
        Fri, 24 Jan 2025 09:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtqQo5YS3ajg4ppdOQhXWzuRmOA3oSoT7thyIDa4HsUOMGk7g+OCNkFH72qXuMXVWqyygG9w==
X-Received: by 2002:a17:906:4fcb:b0:aa6:90a8:f5ff with SMTP id a640c23a62f3a-ab38b3fbfe3mr3118158166b.50.1737738822476;
        Fri, 24 Jan 2025 09:13:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e64d68sm159418166b.53.2025.01.24.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 09:13:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DC576180AAB3; Fri, 24 Jan 2025 18:13:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
In-Reply-To: <2aa84c61-6531-4f17-89e5-101f46ef00d0@huawei.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com> <87plkhn2x7.fsf@toke.dk>
 <2aa84c61-6531-4f17-89e5-101f46ef00d0@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Jan 2025 18:13:40 +0100
Message-ID: <8734h8qgmz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

>> So I really don't see a way for this race to happen with correct usage
>> of the page_pool and NAPI APIs, which means there's no reason to make
>> the change you are proposing here.
>
> I looked at one driver setting pp->napi, it seems the bnxt driver doesn't
> seems to call page_pool_disable_direct_recycling() when unloading, see
> bnxt_half_close_nic(), page_pool_disable_direct_recycling() seems to be
> only called for the new queue_mgmt API:
>
> /* rtnl_lock held, this call can only be made after a previous successful
>  * call to bnxt_half_open_nic().
>  */
> void bnxt_half_close_nic(struct bnxt *bp)
> {
> 	bnxt_hwrm_resource_free(bp, false, true);
> 	bnxt_del_napi(bp);       *----call napi del and rcu sync----*
> 	bnxt_free_skbs(bp);
> 	bnxt_free_mem(bp, true); *------call page_pool_destroy()----*
> 	clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
> }
>
> Even if there is a page_pool_disable_direct_recycling() called between
> bnxt_del_napi() and bnxt_free_mem(), the timing window still exist as
> rcu sync need to be called after page_pool_disable_direct_recycling(),
> it seems some refactor is needed for bnxt driver to reuse the rcu sync
> from the NAPI API, in order to avoid calling the rcu sync for
> page_pool_destroy().

Well, I would consider that usage buggy. A page pool object is created
with a reference to the napi struct; so the page pool should also be
destroyed (clearing its reference) before the napi memory is freed. I
guess this is not really documented anywhere, but it's pretty standard
practice to free objects in the opposite order of their creation.

So no, I don't think this is something that should be fixed on the page
pool side (and certainly not by adding another synchronize_rcu() call
per queue!); rather, we should fix the drivers that get this wrong (and
probably document the requirement a bit better).

-Toke


