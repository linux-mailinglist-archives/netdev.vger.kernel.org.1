Return-Path: <netdev+bounces-155057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69893A00DB4
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B233A3F12
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1361FBCB6;
	Fri,  3 Jan 2025 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="avb6MoDp"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7241FBEA3
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929701; cv=none; b=Rw0pAeajW1YRq4wrFRsodNIPKQOHfjHUP/UVvVSTqS6tsdLVRmJLkKhamGZtRubKESLKNn+rUsvG7FOgmLT7hiir9LRE2odHii72nidOAieVNlL6UBxVeif3zyvLdJkxYfazC8KPlR69ZtE9ODK4R/+yeVvEyprepuTOXVOYfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929701; c=relaxed/simple;
	bh=MTltBdWiBtglJfuE1CqV+1oFBpZZg33vtsAIYHHQXK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQdsi9qqOy+wkLkU2GlgXMGhjVOVx3d+ZAXJH+8Y9txiiJ/qXZeTlA9bNf6bC1X7KOmTRtKrEaThbV8CFt3ynTv5OdNLQ45yIGVb2PlTDHkaxp6EWRDz2cwXlozuWTnwIOqXt9a+wH/JuBu721MZVLJbz2AISH7OBW7xVcwecr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=avb6MoDp; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1212; q=dns/txt; s=iport;
  t=1735929699; x=1737139299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/IH1fUcRPa7xsGzfjg3y3/cA5i/6sVja5+yP2O1pi8=;
  b=avb6MoDpgRg3e650packP8NKHG93qYDg4VCLdFxfpZGq0LjBulmSAAlG
   qWFgLxKrkJwGKjnXr159wR9SvU3ylXsKj41upw5fVMtoxT3wRnBkAMU6S
   emPz16z17LIyMkMqffZCWioNC/JymJSLIbnoKv9EiU7TF1idA33ORp7xx
   k=;
X-CSE-ConnectionGUID: wQk29jNhSE2YcgTLvY7QOQ==
X-CSE-MsgGUID: oKOW2F+PTjiDjETkVVFhSQ==
X-IPAS-Result: =?us-ascii?q?A0BfAwBgLnhn/43/Ja1aglyCS4FPQ44ZiHWeGIF+DwEBA?=
 =?us-ascii?q?Q9EBAEBhQcCinACJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4ThgiGWwEBAQMyAUYQCxguKyuDGoJlA7EggiyBAd4zgW2BSIVrh19wh?=
 =?us-ascii?q?HcnG4FJRIQOMT6FEIV3BIQsg0GdQkgKgRcDWSwBVRMNCgsHBYEpHysDOAwLM?=
 =?us-ascii?q?BUnEIEoBTUKOTqCDmlJNwINAjaCH3yCK4Ihgj2ER4RVhWaCF4FrAwMWEgGCO?=
 =?us-ascii?q?kADCxgNSBEsNxQbBj5uB557gXCBFqY/oQOEJYFjn2MaM6pTmHykR4RmgWc8g?=
 =?us-ascii?q?VkzGggbFYMjURkPjlmwMiVuAgcLAQEDCZIFAQE?=
IronPort-Data: A9a23:eu9I66JdwmHfOx7RFE+R65QlxSXFcZb7ZxGr2PjKsXjdYENSg2BSz
 DQeXjiHa/bfZzemKtpzbdy+px4C65aHx4BjT1Yd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgL9gmYuajl8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1xNUJsbI8++t1aW1BF+
 sA8NgFSVze60rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBUbAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2ME2ojx5nYj/7DLo8m+euinD7fhVTqUmeouw85G27IAlZiui9aIOPIoTSLSlTtkG7g
 V2c0SfBPhMbGN6y9Tm7zFysvdaayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasuh8aSsdWCO037g6lyrfd/AuYQGMDS1Zpa8Esvec1SCYs2
 1vPmMnmbRRmtrGPRG3e8LqIoT6sESwIK2lEbi9sZRMM6dTloakpgx7PR8olG6mw5vXzFC38z
 i6isicznfMQgNQN2qH9+krI6w9AvbDTRQIzowGSVWW/40YhOMiuZpej7h7Q6vMowJulc2Rtd
 UMsw6C2hN3ix7nX/MBRaI3hxI2U2ss=
IronPort-HdrOrdr: A9a23:xW1mE66wchh1tRyPYwPXwM/XdLJyesId70hD6qm+c3Nom6uj5q
 eTdZsgtCMc5Ax9ZJhko6HjBEDiewK5yXcK2+ks1N6ZNWGM0ldAbrsSiLcKqAePJ8SRzIJgPN
 9bAstD4BmaNykCsS48izPIdeod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3Ah4hwg2im5X9cMB5gTXCN9an+4zJubUTelibSBU+?=
 =?us-ascii?q?DJDxYQ7KpbUGhp5pDqp87?=
X-Talos-MUID: 9a23:ueCLigoBxXu/qokNtdAezzZBE/gyzeeWNEIMvZcrh8q6CwJwAA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="288012000"
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jan 2025 18:40:31 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTP id EF73C1800019C;
	Fri,  3 Jan 2025 18:40:30 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id B781220F2003; Fri,  3 Jan 2025 10:40:30 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	benve@cisco.com,
	davem@davemloft.net,
	edumazet@google.com,
	johndale@cisco.com,
	linyunsheng@huawei.com,
	neescoba@cisco.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v3 4/6] enic: Use the Page Pool API for RX when MTU is less than page size
Date: Fri,  3 Jan 2025 10:40:30 -0800
Message-Id: <20250103184030.5808-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241231164200.3364e18b@kernel.org>
References: <20241231164200.3364e18b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com

>On Tue, 31 Dec 2024 19:37:12 +0800 Yunsheng Lin wrote:
>> >> It seems the above has a similar problem of not using
>> >> page_pool_put_full_page() when page_pool_dev_alloc() API is used and
>> >> page_pool is created with PP_FLAG_DMA_SYNC_DEV flags.
>> >>
>> >> It seems like a common mistake that a WARN_ON might be needed to catch
>> >> this kind of problem.  
>> > 
>> > Agreed. Maybe also add an alias to page_pool_put_full_page() called
>> > something like page_pool_dev_put_page() to correspond to the alloc
>> > call? I suspect people don't understand the internals and "releasing
>> > full page" feels wrong when they only allocated a portion..  

That is true in my case. I think if there was a page_pool_dev_put_page()
it would have caught my eye and I would have used it.

I made a v4 patchset uses page_pool_put_full_page().

>> 
>> Yes, I guess so too.
>> But as all the alloc APIs have the 'dev' version of API:
>> page_pool_dev_alloc
>> page_pool_dev_alloc_frag
>> page_pool_dev_alloc_pages
>> page_pool_dev_alloc_va
>> 
>> Only adding 'dev' does not seem to clear the confusion from API naming
>> perspective.
>
>page_pool_free_page()? We already have page_pool_free_va()

