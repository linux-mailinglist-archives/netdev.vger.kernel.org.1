Return-Path: <netdev+bounces-160924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1249A1C3BB
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A90A7A3BB7
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BED1CF96;
	Sat, 25 Jan 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNa1AYsF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F31862A;
	Sat, 25 Jan 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737814902; cv=none; b=dTp2mgUIGTD43JWwWMPxR0c1lB2U0JYkqCl4+RfPvFRdePmBP518Boze0noWnMSQFiGaduLEakRFs4GfQE7qpZBwJXvjW57AtKbTVi+pUT2y65BYQnzfO9pt+sptHWkjndzcG9PlWPIk+HWPdnnMIcRQruobIKJCUOb2RsqRrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737814902; c=relaxed/simple;
	bh=jqMoW1dcKRbOtwX8OSYhUYh1HDTdWtu3Ce3nwohvLSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o846+n1ei03sM0MHQ5qBRysGySUH5fJmLCQo13J03Ckxtg2k1qZxDdNC6KQ0F+VubftBfmk2D+MUh9QIiwytycU2QC65949CFhdvUKlLkgZQPh5L3ucf//JKIWorZL2kDNH0RyEBUvA4nbG6tZHD1njrDEPyYs6Rr9gzWg7DfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNa1AYsF; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso4201911a91.0;
        Sat, 25 Jan 2025 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737814900; x=1738419700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HP4/uyX6B1UOaDGmtJ3ZSiRctz2FrhSZe9i0JS/eJns=;
        b=GNa1AYsFNeYh6xe5BMh1LA31mjbcL230YlNJqWbnbI/vo8t8PpBlJmBWyYWGVdQ/1a
         x/OpMx8gkOhRfxysLxePp+jEsHQe6rKvehpIKhXJig949xwL0YFPOU0KwVm9YIQF+ksD
         xzjf0p9xY217ZZer7YfQSMtx0iduQFWYXGiTs8uk9/fFqzlDvJshcTP/pGOzv+ViCG/b
         FrZbO9ZkAP5857csuURxi3Xz8ua2pmyfzYOfprudNSVoF/zxMwGZuAFWyMt3jzC6McYy
         9tL5wZDLOpG4IoP0WfhBvE6srFVCXA9p+jpUigmIJ5b10PHarRVT23vosomP1B6rTomj
         yp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737814900; x=1738419700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HP4/uyX6B1UOaDGmtJ3ZSiRctz2FrhSZe9i0JS/eJns=;
        b=NW2tDkE0Aj0T9vt8nUM7gr3B+vi+lpQ+Eo1Nl1L7o0twp0o6Wnsjlj/62x1WpkCKkx
         qr/O/T8WBu4lKTOO+NRq1GbVSpRfz9tOu9GIl/DsHo6jKxP+uw4Inlo7w8DspI3ZGtay
         i9PxxSWykrcio7OocfUyaH5fas41aAkb4fCw6pI+pQnjfI/nhhsTcGubKfUCuShdXNGf
         qO+gTh+Bd0699tEMzkhJSz0eL0VRwamrB5rwiFSK4ys/kzznNb3BAFHNwKdGe31FGNs0
         A1bpd3j/MKzvc9h0NqTIYRWh0gRhJYT0WtWH5ZAtLCxSX6SuE7GGg1HbUp37QA5Nz+pE
         c6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWooJ6moJ90NkIGBw7Q0gNSxq9FrIPxgkoozQ6QXS4+BeedPUJso9NwN+ykx+bqn8ETVdtE4DlRDGUZtac=@vger.kernel.org, AJvYcCXIq17ZzLjhToVpSd5rm7sGeTmy7xW16Zu5L9RZF9H9QCGmXDeRo0PsxJUqtN/LrOByLu5Oia/R@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKVobgohGCOlf7gfqtsn/ytnwFuy1imR69SHkvhxOa5WAzeA3
	SrVpk7VqM8fPGVl/6Z9eHvleyl6IhthmWdb95qDkICKiSLdOmeij
X-Gm-Gg: ASbGncsdWjPFTLUZJa0cbcC3BJtwuyIeTomePIW5FV4sOG1BKr/Qz885Es3kOt8+DIk
	S7Duc/8ctMvBGZEHf25+O7/YlAsapt2iAjYTQ2TP0UstfAdssR3GayWd+l8qwH8OSYnPz6LBFck
	MMdFsqHkc4wb07mg1uvxyz50CbkJiDSNEL2Q/zpZe7R399t0Qle65ZmaezW65p4b57Jaluk9dHW
	A/XN3Jt7OJII3O0wIxQsb4MQe9eniryr/X02CKx87QNl6QG6d8TxneRhehEEA08utROATgIMMrV
	VxQPgqvNvZFSfhTGd4YdyIrUe067+4fFBbwCISyOnFj382NBQSANDIhZrTY+ps4uKVBN
X-Google-Smtp-Source: AGHT+IE8nfjiqBOhoMdvuASP8+zn5x2vl+lg0jnTEhc0X/DITLhwiZmoWU0m4M3vj/eiiMq66nh6Pg==
X-Received: by 2002:a17:90b:5448:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2f782c4d75cmr47522370a91.4.1737814899977;
        Sat, 25 Jan 2025 06:21:39 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:d418:2fb5:a140:54b6? ([2409:8a55:301b:e120:d418:2fb5:a140:54b6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa56661sm3622206a91.12.2025.01.25.06.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 06:21:39 -0800 (PST)
Message-ID: <84282526-6229-41c7-8f6b-5f2c500dcd8e@gmail.com>
Date: Sat, 25 Jan 2025 22:21:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com> <87plkhn2x7.fsf@toke.dk>
 <2aa84c61-6531-4f17-89e5-101f46ef00d0@huawei.com> <8734h8qgmz.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <8734h8qgmz.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/25/2025 1:13 AM, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
> 
>>> So I really don't see a way for this race to happen with correct usage
>>> of the page_pool and NAPI APIs, which means there's no reason to make
>>> the change you are proposing here.
>>
>> I looked at one driver setting pp->napi, it seems the bnxt driver doesn't
>> seems to call page_pool_disable_direct_recycling() when unloading, see
>> bnxt_half_close_nic(), page_pool_disable_direct_recycling() seems to be
>> only called for the new queue_mgmt API:
>>
>> /* rtnl_lock held, this call can only be made after a previous successful
>>   * call to bnxt_half_open_nic().
>>   */
>> void bnxt_half_close_nic(struct bnxt *bp)
>> {
>> 	bnxt_hwrm_resource_free(bp, false, true);
>> 	bnxt_del_napi(bp);       *----call napi del and rcu sync----*
>> 	bnxt_free_skbs(bp);
>> 	bnxt_free_mem(bp, true); *------call page_pool_destroy()----*
>> 	clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
>> }
>>
>> Even if there is a page_pool_disable_direct_recycling() called between
>> bnxt_del_napi() and bnxt_free_mem(), the timing window still exist as
>> rcu sync need to be called after page_pool_disable_direct_recycling(),
>> it seems some refactor is needed for bnxt driver to reuse the rcu sync
>> from the NAPI API, in order to avoid calling the rcu sync for
>> page_pool_destroy().
> 
> Well, I would consider that usage buggy. A page pool object is created
> with a reference to the napi struct; so the page pool should also be
> destroyed (clearing its reference) before the napi memory is freed. I
> guess this is not really documented anywhere, but it's pretty standard
> practice to free objects in the opposite order of their creation.

I am not so familiar with rule about the creation API of NAPI, but the
implementation of bnxt driver can have reference of 'struct napi' before
calling netif_napi_add(), see below:

static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool 
link_re_init)
{
	.......
	rc = bnxt_alloc_mem(bp, irq_re_init);     *create page_pool*
	if (rc) {
		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
		goto open_err_free_mem;
	}

	if (irq_re_init) {
		bnxt_init_napi(bp);                *netif_napi_add*
		rc = bnxt_request_irq(bp);
		if (rc) {
			netdev_err(bp->dev, "bnxt_request_irq err: %x\n", rc);
			goto open_err_irq;
		}
	}

	.....
}

> 
> So no, I don't think this is something that should be fixed on the page
> pool side (and certainly not by adding another synchronize_rcu() call
> per queue!); rather, we should fix the drivers that get this wrong (and
> probably document the requirement a bit better).

Even if timing problem of checking and disabling napi_local should not
be fixed on the page_pool side, do we have some common understanding
about fixing the DMA API misuse problem on the page_pool side?
If yes, do we have some common understanding about some mechanism
like synchronize_rcu() might be still needed on the page_pool side?

If no, I am not sure if there is still any better about how to fix
the DMA API misuse problem after all the previous discussion?

If yes, it may be better to focus on discussing how to avoid calling rcu
sync for each queue mentioned in [1].

1. 
https://lore.kernel.org/all/22de6033-744e-486e-bbd9-8950249cd018@huawei.com/

