Return-Path: <netdev+bounces-156957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87255A0861E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 05:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B894169579
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F413C80E;
	Fri, 10 Jan 2025 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="IGuztNk+"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E9B672
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736481792; cv=none; b=WWSwUcRaozsMfpmJNNui8bzjph4F68h+0OWytw+nFT+u9HNqDTqr9kqFIR5/iFYTZRkITJzE4W0UNIynh/y4EuT017Ze5cPyQ1sfU1u0YFb4j6gi9bWQHEsKGPbYRNn7P1021i/Zq6Mg+f3HKj8vJFOnChr2R4vety6pW2TMkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736481792; c=relaxed/simple;
	bh=D9PelZ0KlPC1itD9OQ5K8aGNZB+IUrfBMmxpTfNJFmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVNlA3UbNV0sos9BCD6tab+IG21CyAGbF4Q1Zzrb11gJMxJvsGqZr6dtJeAXPANBMIl+0AsCCisjOvxkMZFsVfjHvGah+/UwuW0pGMnSaO9El1an/eEyaQzncPrDvTqZql3OYvwTRL6c+5mD0vVxY7asc5aThY5gzBARKR6uw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=IGuztNk+; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1686; q=dns/txt; s=iport;
  t=1736481790; x=1737691390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iidphLJV4pLrMO8x2yEUQ27aW3xIngS9Qa3XBdqdtq4=;
  b=IGuztNk+0/UH9POV6h0kQsF28GXM2aedYmCXuNuv0DCMvgcPifyd01J1
   GFj0GVVkV5ne6FVXTIEsM2FYrPMo6GFvWfs2sOq2UVYARPuP+nR2Qez6V
   bmx6kV3erXrC4LpIDHrZ79wWN6a9RFxYBTyByvckwWuwdm21pOdYaXCMb
   g=;
X-CSE-ConnectionGUID: +ji68N33Teaxsefzu7yW4g==
X-CSE-MsgGUID: bO2d1dpWTz6KqDBwmQ77Gg==
X-IPAS-Result: =?us-ascii?q?A0AwAABFm4Bn/5L/Ja1aHAMDBxYEBIIBBw0BgkqBT0MZL?=
 =?us-ascii?q?41RiHWeGIElA1YPAQEBD0QEAQGFBwKKdAImNAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAQEBAzIBRhALGC4rKxmDAYJlA7M9g?=
 =?us-ascii?q?iyBAd4zgW2BSAGFaodfcBuEXCcbgUlEhA4xPoFSgkl1hXcEgn6BKoNAnkpIC?=
 =?us-ascii?q?oEXA1ksAVUTDQoLBwWBKR8rAzgMCzAVJg+BGgU1Cjc6ggxpSTcCDQI1gh58g?=
 =?us-ascii?q?iuCIYI7hEeEVoVlgheBaAMDFhIBgzUsQAMLGA1IESw3FBsGPm4Hmxs8g2mBM?=
 =?us-ascii?q?V0upwmhA4QlgWOfYxozqlOYfKRHhGaBZzyBWTMaCBsVgyJSGQ+OWbtjJTI8A?=
 =?us-ascii?q?gcLAQEDCY8igXwBAQ?=
IronPort-Data: A9a23:tipTuq6ktYkWv6dmNBGiGQxRtBrGchMFZxGqfqrLsTDasY5as4F+v
 jMdWmqEb/qNZWWmLot1aonlpEoCsJLWytBrHAVtr38wZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QpajtNs/rawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4efo8ZpLZRWjpy+
 PUIMz0DfA3clt3qz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGcGFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkERUrsUIMpWcOOAhH7/dTFRrF+9rqss6G+Vxwt0uFToGIaPJITVG54MwC50o
 ErM2D71Wx0CC+CNlxmc3lizg9aQwgz0Ddd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSwYZ79T9iJ88gwiJTdt5FqOxyNrvFlnNL
 yuitiMygfAXyMUMzaj+pQGBiDO3rZ+PRQkwjunKYl+YAspCTNbNT+SVBZLzt56s8K7xooG9g
 UU5
IronPort-HdrOrdr: A9a23:h55vtq9ETd45KOQWuuNuk+DfI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HIoB11737JYVoqNU3I3OrwWpVoIkmskaKdn7NwAV7KZmCP0wGVxcNZnO7fKlbbdREWmNQw6U
 4ZSdkcNDU1ZmIK9PoTJ2KDYrAd/OU=
X-Talos-CUID: 9a23:lnUHw26R/3ZHCMm6ftsst0wVRJADKSbhwX7AOEK2G3s2WYLJRgrF
X-Talos-MUID: 9a23:qspfAgjCwnsFlcOIjj71cMMpPuAy7/2iEH8xg8slouWuKilJZGiyg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="426076316"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 04:03:03 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTP id 13BCA1800023D;
	Fri, 10 Jan 2025 04:03:03 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id DF13720F2003; Thu,  9 Jan 2025 20:03:02 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: johndale@cisco.com
Cc: andrew+netdev@lunn.ch,
	benve@cisco.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	neescoba@cisco.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 4/6] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Thu,  9 Jan 2025 20:03:02 -0800
Message-Id: <20250110040302.14891-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250107030016.24407-1-johndale@cisco.com>
References: <20250107030016.24407-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

On 1/6/25, 7:00 PM, "John Daley" <johndale@cisco.com> wrote:
>
>>> >> The Page Pool API improves bandwidth and CPU overhead by recycling
>>> >> pages instead of allocating new buffers in the driver. Make use of
>>> >> page pool fragment allocation for smaller MTUs so that multiple
>>> >> packets can share a page.  
>>> >
>>> >Why the MTU limitation? You can set page_pool_params.order
>>> >to appropriate value always use the page pool.  
>>> 
>>> I thought it might waste memory, e.g. allocating 16K for 9000 mtu.
>>> But now that you mention it, I see that the added code complexity is
>>> probably not worth it. I am unclear on what to set pp_params.max_len
>>> to when MTU > PAGE_SIZE. Order * PAGE_SIZE or MTU size? In this case
>>> the pages won't be fragmented so isn't only necessary for the MTU sized
>>> area to be DMA SYNC'ed?
>>
>>Good point, once fragmentation is no longer possible you can
>>set .max_len to the size of the fragment HW may clobber,
>>and .offset to the reserved headroom.
>
>Ok, testing going good so far, but need another day.

Testing is OK, but we are concerned about extra memory usage when order
is greater than 0. Especially for 9000 MTU where order 2 would mean
allocating an extra unused page per buffer. This could impact scaled up
installations with memory constraints. For this reason we would like to
limit the use of page pool to MTU <= PAGE_SIZE for now so that order is
0.

Our newer hardware supports using multiple 0 order pages for large MTUs
and we will submit a patch for that in the future.

I will make a v5 patchset with the napi_free_frags and pp_alloc_error
changes already discussed. Thanks, John

