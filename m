Return-Path: <netdev+bounces-155603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD6A0325B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D1163E58
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747AB1E0489;
	Mon,  6 Jan 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="j5t0DvMg"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA41DEFFC
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200536; cv=none; b=ipXrrSMz0VoYkLJTAp2KHdOXagNgXicwhQSUIF8bXLy+VVm9omh8F3oiPC10Y+rWsmh6OYVwcMm0yjX/8VTvYn1Ak/DHu2dOjkLFUW1DY3okarcyECnpN0zqdO4s/hkB0rJ8sXd7gdmH6Mta95lFAl9AKHeu10pUi9thBecQGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200536; c=relaxed/simple;
	bh=c4sT+cNwNTpAVXjbHfDmZ28OY69SWpy20qDRcYBNp+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBDzkRNjx+z3+13qnVn63sjH3EwmFSUGtInW/SatDXpqj8CovNZdOwCWdsTZSkvitbPz01n3RhTvIn87wvTn8YxzHeq26z2A6+WFbuqiqr4k/UEXABv1eQ7vvez79RoRhjwNAix/7OsKl24kNdnvExAwjinJM+SP3JZFcJ0mJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=j5t0DvMg; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1784; q=dns/txt; s=iport;
  t=1736200534; x=1737410134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1UDDrLsE4/jzf6bLE0Ccc4/2jtO4G4Lb4x0iKQwaAY=;
  b=j5t0DvMgJ/7gU6GrzsSqFu9zY5mM2E9+CQvQMM06sOMeo0PvEWN+1zde
   Ls965IPRaBf5st/XOFGiSM7ninLbN6NXIueiY48l/uKceWNZb5BW66VW4
   j2HMFN9NkBucuimBy1zph4dpVlP0VpU9tYzYo+9OltcWoDgqMOrR4Lq14
   o=;
X-CSE-ConnectionGUID: pxlk0mxMTw+9oZdN9AL0Cg==
X-CSE-MsgGUID: Sp4lYohxQcSneI/TG4Tjzw==
X-IPAS-Result: =?us-ascii?q?A0C+AAByUHxn/5P/Ja1aHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?gQBAQsBgkqBT0OOGYhyA6AWDwEBAQ9EBAEBhQcCinQCJjcGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwEBAQIBJwsBRhALRisrg?=
 =?us-ascii?q?xqCQiMDsQeBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSEDjE+hRCFdwSHbJ1oS?=
 =?us-ascii?q?AqBFwNZLAFVEw0KCwcFgSkfKwM4DAswFSYPgSYFNQo5OoIMaUk3Ag0CNYIef?=
 =?us-ascii?q?IIrgiGCO4RHhFaFZoIXgWgDAxYSAYJlQAMLGA1IESw3FBsGPm4HnwWBAm4eL?=
 =?us-ascii?q?m8TpgehA4QlgWOfYxozhASNBplJmHykR4RmgX0mgVkzGggbFYMjURkPji0WF?=
 =?us-ascii?q?rcsJW4CBwsBAQMJkXQBAQ?=
IronPort-Data: A9a23:Cay/paJX3+43MVIJFE+R85QlxSXFcZb7ZxGr2PjKsXjdYENS1jBSx
 zEfWTyGbv6CZGL3c4pybom09k5X7MTTyNM2GVQd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgL9gmYqajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN12HEU1ZYgI39poQjBJx
 /A+eRkpNjuM0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSAVbAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEuojx5nYj/7DLo8m+euinD7fhVTqUmeouw85G27IAlZi+C2aYWII4bXLSlTtn2A+
 mb3+GTpOxohMtG+jgaqrk6ulPCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvQMWUvJTHvc85QXLzbDbiy6QAGQeQyECbtE6uMIobTg30
 FnPlNOBLSRmurCTSFqH+7uUpC/0Mi8QRUcEaDMIQBUt/dbuuscwgwjJQ9IlF7S65uAZAhnqy
 DyM6Sx7jLIJgItSj+Ow/EvMhHSnoZ2hohMJ2zg7l1mNtmtRDLNJraTxgbQHxZ6s9Lqkc2Q=
IronPort-HdrOrdr: A9a23:oT6m9ai1CYmsYLDXdPArLnLDLHBQXt0ji2hC6mlwRA09TyVXra
 +TdZMgpHjJYVkqOU3I9ersBEDEewK/yXcX2/h0AV7dZmnbUQKTRekIh7cKgQeQfhEWndQy6U
 4PScRD4aXLfDtHZQKQ2njALz7mq+P3lpyVuQ==
X-Talos-CUID: 9a23:NGMojGwVYOBO0coBV20TBgUMCsQmKnjN6UvPYB6/O2pPGZSxEXSfrfY=
X-Talos-MUID: 9a23:5yBQ5gruJ7ngfMdrKk8ezwp6aMNZ5KS+MUs2l5gn/PWraRByKSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,293,1728950400"; 
   d="scan'208";a="303175125"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Jan 2025 21:54:25 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTP id B188718000263;
	Mon,  6 Jan 2025 21:54:25 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 7DE4C20F2003; Mon,  6 Jan 2025 13:54:25 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	benve@cisco.com,
	davem@davemloft.net,
	edumazet@google.com,
	johndale@cisco.com,
	neescoba@cisco.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Mon,  6 Jan 2025 13:54:25 -0800
Message-Id: <20250106215425.3108-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250104174152.67e3f687@kernel.org>
References: <20250104174152.67e3f687@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com

>> The Page Pool API improves bandwidth and CPU overhead by recycling
>> pages instead of allocating new buffers in the driver. Make use of
>> page pool fragment allocation for smaller MTUs so that multiple
>> packets can share a page.
>
>Why the MTU limitation? You can set page_pool_params.order
>to appropriate value always use the page pool.

I thought it might waste memory, e.g. allocating 16K for 9000 mtu.
But now that you mention it, I see that the added code complexity is
probably not worth it. I am unclear on what to set pp_params.max_len
to when MTU > PAGE_SIZE. Order * PAGE_SIZE or MTU size? In this case
the pages won't be fragmented so isn't only necessary for the MTU sized
area to be DMA SYNC'ed?

>
>> Added 'pp_alloc_error' per RQ ethtool statistic to count
>> page_pool_dev_alloc() failures.
>
>SG, but please don't report it via ethtool. Add it in
>enic_get_queue_stats_rx() as alloc_fail (and enic_get_base_stats()).
>As one of the benefits you'll be able to use
>tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
>to test this stat and error handling in the driver.

ok, will do.
>
>> +void enic_rq_page_cleanup(struct enic_rq *rq)
>> +{
>> +    struct vnic_rq *vrq = &rq->vrq;
>> +    struct enic *enic = vnic_dev_priv(vrq->vdev);
>> +    struct napi_struct *napi = &enic->napi[vrq->index];
>> +
>> +    napi_free_frags(napi);
>
>why?

Mistake, left over from previous patch. Also, I will remove enic_rq_error_reset()
which calls napi_free_frags at a time when napi->skb is not owned by driver.
>
>> +    page_pool_destroy(rq->pool);
>> +}

I will make a v5 shortly. Would you recommend I split the patchset into 2 parts
as I think @andrew+netdev was suggesting? The last 2 patches are kind of unrelated
to the first 4.

