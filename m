Return-Path: <netdev+bounces-161114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B664AA1D71C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21AE7A1E8D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0B1FF7A5;
	Mon, 27 Jan 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIB4Lyms"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C61FDA84
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985631; cv=none; b=UJ7LHVM4moAEbsYQJ4uMn/Qilz/wO85gR2P6yqGvoFFsmj7rV7VJ253NTKNLnM168EZX3L1yJP3m/pBjp+lCdTPu2vF++fGgq0+fTGu9TAxi0i8jc3AIiMMtQQkQF7aO+HQwSm6CVF7IgQkED7zEvhxizd5DUc91bvfTAy/zZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985631; c=relaxed/simple;
	bh=NZNnOZL2EDLriogLKyoRYtMe5zAJhITUhIvTcw2puuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZraZqmMFuudPSMzSuS7M24GFkQltK7DA32lYGyIX81ZJ9/iLosgyR953OlUTKn7tjewfmexZqpdFueupqWsDuN5eCHduXj8j4GXYx45/7qsKZ5il/wq9pJd2+s6zu9mnudZiUkUVyOM2xFVjPumgiiUhdXea3x4mgUaD0TSn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIB4Lyms; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737985628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H39c77ggHx+djsZx6wiUR7I7QacDtvtRhB8AmeMWmS4=;
	b=WIB4Lymse/aTy8kw8QNnWGAo++t1YnPhhS2nahY2QzYBJuu7bSvdUudxcLsv+33d6+meZ4
	AQfyagNFzOHIw2r5dx2GppuCAtcNN4n+furuXBueKAfc6SOhP0AW46kMANM2fJSSwQYd1w
	lL7gDSlLaeWrb6vdZtxkg7ljx/V+M70=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-IkmBVGXSMvm962gLgSYqdw-1; Mon, 27 Jan 2025 08:47:06 -0500
X-MC-Unique: IkmBVGXSMvm962gLgSYqdw-1
X-Mimecast-MFC-AGG-ID: IkmBVGXSMvm962gLgSYqdw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so3510843a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737985626; x=1738590426;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H39c77ggHx+djsZx6wiUR7I7QacDtvtRhB8AmeMWmS4=;
        b=V5oqo6Xy+QsegEVxjjphtzEwMdUfcsrVmtsHEv5W2iAULo7kMT6mVZUPY/Bj31Tmvv
         9TUTSUvtKrr3ssMGheYCTKYGHrEDNtGmNo3+YjED+S4RuDVqKgflGTWnALMLTSPsout0
         6QwFXikLt0kqnb/enMzh4vNEtC6Eehd6zrZw6bGx2c2C8RTOIJaHkEW/FLdG+7yM92M1
         CfqY/AdN7Lts4Q1hDMDbCgf8Gwpfk6PyZry5wohUGGFIhe0hfFPIhGaXcGkmv/nCPU9w
         nOjBDNoYMEZlsLe/E1RZZgC7vsxz3+nUemKIZ8ALD9BJJm+tOor0ZHAINSP1FrerbQ7G
         Wn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAzae7sj2pkV9tqXmqBLyMV8jqcOU9Zz32C6/Y8fQ+fNQEeTiDIwEIHdUN7JV3cbwW/kzgXWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkyaSXNL3McdVd4qwx2RNRvnJ9xSWAKXGEi3Y7C/MJXJ5sCx5
	Np0+rTklHu62vmroL4HVJL/4Khv4jSpiMJ9rtFsLu7ES9sc4BFw61cCGGoU3eJe0tcJO/PlaqPO
	S/JKP1TehI1yGldBb17C7znNNdao/zVXNPyFRNvVKhVsXFfmEFSZ0TA==
X-Gm-Gg: ASbGncu24zdBgJP2wjpcdHEEQVHD1XGQHWJnAb5W2jjLgLN+O3Nc8K4TIr5x4XsuuSz
	Xq5hpEPL51lAzC96CpJ/kPYsnVCbZ6HIq/FLETudcHFMIYlAsx01GDR9iW/fC7hjtKi5ewc7IPe
	3uHPfZguPyRU7Z9HCotfOu46VCWieNMFFNGntxS9vXPjjBnqU6otE8K3CnEMFhhh3vND1Ihre7A
	IAJiDhrYznw0+EXqWmOoOVuCMR4FKna/OUTt9n/dQy0e8T5p/InQK/ZE+jCE81CsynIu5YFLvau
	DA==
X-Received: by 2002:a05:6402:3595:b0:5db:f4fc:8a08 with SMTP id 4fb4d7f45d1cf-5dbf4fc8bf6mr57339440a12.6.1737985625693;
        Mon, 27 Jan 2025 05:47:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaVAxLOxeZrT6z2Z9IRBRJEMbjrV9XRH+t/egpAk12VWU0O6KKRmWyPhrB31HgrowbsuqD+A==
X-Received: by 2002:a05:6402:3595:b0:5db:f4fc:8a08 with SMTP id 4fb4d7f45d1cf-5dbf4fc8bf6mr57339374a12.6.1737985625275;
        Mon, 27 Jan 2025 05:47:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fb3d0sm581930266b.152.2025.01.27.05.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:47:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A60AC180AEC6; Mon, 27 Jan 2025 14:47:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
In-Reply-To: <84282526-6229-41c7-8f6b-5f2c500dcd8e@gmail.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com> <87plkhn2x7.fsf@toke.dk>
 <2aa84c61-6531-4f17-89e5-101f46ef00d0@huawei.com> <8734h8qgmz.fsf@toke.dk>
 <84282526-6229-41c7-8f6b-5f2c500dcd8e@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Jan 2025 14:47:03 +0100
Message-ID: <874j1kpdwo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 1/25/2025 1:13 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>>> So I really don't see a way for this race to happen with correct usage
>>>> of the page_pool and NAPI APIs, which means there's no reason to make
>>>> the change you are proposing here.
>>>
>>> I looked at one driver setting pp->napi, it seems the bnxt driver doesn=
't
>>> seems to call page_pool_disable_direct_recycling() when unloading, see
>>> bnxt_half_close_nic(), page_pool_disable_direct_recycling() seems to be
>>> only called for the new queue_mgmt API:
>>>
>>> /* rtnl_lock held, this call can only be made after a previous successf=
ul
>>>   * call to bnxt_half_open_nic().
>>>   */
>>> void bnxt_half_close_nic(struct bnxt *bp)
>>> {
>>> 	bnxt_hwrm_resource_free(bp, false, true);
>>> 	bnxt_del_napi(bp);       *----call napi del and rcu sync----*
>>> 	bnxt_free_skbs(bp);
>>> 	bnxt_free_mem(bp, true); *------call page_pool_destroy()----*
>>> 	clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
>>> }
>>>
>>> Even if there is a page_pool_disable_direct_recycling() called between
>>> bnxt_del_napi() and bnxt_free_mem(), the timing window still exist as
>>> rcu sync need to be called after page_pool_disable_direct_recycling(),
>>> it seems some refactor is needed for bnxt driver to reuse the rcu sync
>>> from the NAPI API, in order to avoid calling the rcu sync for
>>> page_pool_destroy().
>>=20
>> Well, I would consider that usage buggy. A page pool object is created
>> with a reference to the napi struct; so the page pool should also be
>> destroyed (clearing its reference) before the napi memory is freed. I
>> guess this is not really documented anywhere, but it's pretty standard
>> practice to free objects in the opposite order of their creation.
>
> I am not so familiar with rule about the creation API of NAPI, but the
> implementation of bnxt driver can have reference of 'struct napi' before
> calling netif_napi_add(), see below:
>
> static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool=20
> link_re_init)
> {
> 	.......
> 	rc =3D bnxt_alloc_mem(bp, irq_re_init);     *create page_pool*
> 	if (rc) {
> 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
> 		goto open_err_free_mem;
> 	}
>
> 	if (irq_re_init) {
> 		bnxt_init_napi(bp);                *netif_napi_add*
> 		rc =3D bnxt_request_irq(bp);
> 		if (rc) {
> 			netdev_err(bp->dev, "bnxt_request_irq err: %x\n", rc);
> 			goto open_err_irq;
> 		}
> 	}
>
> 	.....
> }

Regardless of the initialisation error, the fact that bnxt frees the
NAPI memory before calling page_pool_destroy() is a driver bug. Mina has
a suggestion for a warning to catch such bugs over in this thread:

https://lore.kernel.org/r/CAHS8izOv=3DtUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJir=
MprA@mail.gmail.com

>> So no, I don't think this is something that should be fixed on the page
>> pool side (and certainly not by adding another synchronize_rcu() call
>> per queue!); rather, we should fix the drivers that get this wrong (and
>> probably document the requirement a bit better).
>
> Even if timing problem of checking and disabling napi_local should not
> be fixed on the page_pool side, do we have some common understanding
> about fixing the DMA API misuse problem on the page_pool side?
> If yes, do we have some common understanding about some mechanism
> like synchronize_rcu() might be still needed on the page_pool side?

I have not reviewed the rest of your patch set, I only looked at this
patch. I see you posted v8 without addressing Jesper's ask for a
conceptual description of your design. I am not going to review a
600-something line patch series without such a description to go by, so
please address that first.

> If yes, it may be better to focus on discussing how to avoid calling rcu
> sync for each queue mentioned in [1].

Regardless of whether a synchronize_rcu() is needed in the final design
(and again, note that I don't have an opinion on this before reviewing
the whole series), this patch should be dropped from the series. The bug
it is purporting to fix is a driver API misuse and should be fixed in
the drivers, cf the above.

-Toke


