Return-Path: <netdev+bounces-158236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B3A112CC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C193B166E06
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E6204596;
	Tue, 14 Jan 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Tl5qAfhg"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C320E00D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889277; cv=none; b=B+l0ssXTbtDnWjfJfYR4sBtRfWzs7io8dDChqIc1d1DcFR7jrcWBBk3BNnQbEfl7PGf0HvLx5SX8eKGGHz0jkMjdxUzpqEk3P3ttYiXgv6YJoDC4TiwtiNw3BQ+jQj79tI66DIeZAdzMo9myYhtC12Uc3ueeFID1+R5lA6RacoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889277; c=relaxed/simple;
	bh=GQbsMtxjdM79KVpLlfaMdbtjdlmPWPoXQNZd4e45HKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXIYUY0LQBedoh/THiwD50Z5rlkKzNc5lK33UvliG9+pK1L+pKkjd8tqrVSxhHuf28TL5XWgLMbFN9fIV15/8tjJcubqJDhPKI+q90OOn3DHgA7G9kQioIdug/yZTi4G4euZtzKNRtkge9hU2mWy7QEvFuOBdOtz3cqP2OmpAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Tl5qAfhg; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1362; q=dns/txt; s=iport;
  t=1736889275; x=1738098875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9FzKy59XiRKKqwiNqH/Wk4k1G8EJoN9DB0zhLn1gfcw=;
  b=Tl5qAfhgbQ2hr901RUot517tAacGu6b+tsfpnRe8Kz0jj4dweKQxCO9U
   NRvrjLqsznao2nNZXAsWLq9AlPbIm4qKJUT991N9lm1nFMdxQa6gb4Dhr
   DyCfczy/U38jNjiZxCs1pqjzotIdaT0JxD8ujlg7uQyGubD5nBMPNj4Wa
   o=;
X-CSE-ConnectionGUID: brcwPS4ZQoyz2UEOryBMZQ==
X-CSE-MsgGUID: QGO4zu5LSsul0UT/gskDSQ==
X-IPAS-Result: =?us-ascii?q?A0CJAACp0oZn/5D/Ja1aHQEBAQEJARIBBQUBggEGAQsBg?=
 =?us-ascii?q?kqBT0NIjVGIdZ4YgX4PAQEBD0QEAQGFBwKKdAImNgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAQEBAycLAUYQCxguKysZgwGCZ?=
 =?us-ascii?q?QOzDYF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIQOMT6FEIV3BIItgXODQJ55S?=
 =?us-ascii?q?AqBFwNZLAFVEw0KCwcFgSQfKwM4DAswFSUPgRgFNQo3OoIMaUk3Ag0CNYIef?=
 =?us-ascii?q?IIrgiGCO4RHhFWFYoIUgWUDAxYQAYMogQ5AAwsYDUgRLDcUGwY+bgebODyDc?=
 =?us-ascii?q?XwvgkJFpQ2hA4QlgWOfYxozhASNBplJmHykR4RmgW4EMYFZMxoIGxWDIlIZD?=
 =?us-ascii?q?45ZwwElMjwCBwsBAQMJkVMBAQ?=
IronPort-Data: A9a23:yo8+la8aodnBrMJumvmmDrUDon+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 zBKXm6AOfjfMGqmctxwYN61oEwP75KBmoU1SlQ6pSBEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qoyyHjEAX9gWMsaztIs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k8J4YHwt0rM1hJ5
 O5CFR0qdAGpotCPlefTpulE3qzPLeHxN48Z/3UlxjbDALN+HtbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0En1lQ/UPrSmM+qgXn5fzRcpXqepLE85C7YywkZPL3FaouPIIbbGZkJ9qqej
 lvp2DjrH0w+D8eCzWK4zjWjnezjphquDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDjohbMgimnod7CSQtdChjrY19JJzhRPOaND7FEI3CChRqcBO51lmW8g
 UU=
IronPort-HdrOrdr: A9a23:A328JaEE7HOgbGlApLqE78eALOsnbusQ8zAXPo5KJiC9Ffbo8P
 xG88576faZslsssTQb6LK90cq7MBfhHOBOgbX5VI3KNGKNhILrFvAG0WKI+VPd8kPFmtK1rZ
 0QEJSXzLbLfCFHZQGQ2njfL+od
X-Talos-CUID: 9a23:swBNB25YX6coto9Vn9ss/lQfBfgeLk/ky2bCeXKVLnx4YpincArF
X-Talos-MUID: 9a23:KEBLqwTdsKBWG505RXTVqxY+Jto1x5+1FURVrKlBtNKHGRdJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,315,1728950400"; 
   d="scan'208";a="292229444"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Jan 2025 21:13:26 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTP id 1F0951800021F;
	Tue, 14 Jan 2025 21:13:26 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id EB6A720F2003; Tue, 14 Jan 2025 13:13:25 -0800 (PST)
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
Date: Tue, 14 Jan 2025 13:13:25 -0800
Message-Id: <20250114211325.16602-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250110164152.0ededf8a@kernel.org>
References: <20250110164152.0ededf8a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-07.cisco.com

>On 1/10/25, 4:42 PM, "Jakub Kicinski" kuba@kernel.org wrote:
>
>On Fri, 10 Jan 2025 15:52:04 -0800 John Daley wrote:
>> >SG, but please don't report it via ethtool. Add it in 
>> >enic_get_queue_stats_rx() as alloc_fail (and enic_get_base_stats()).
>> >As one of the benefits you'll be able to use
>> >tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
>> >to test this stat and error handling in the driver.  
>> 
>> Fyi, after making suggested change I used pp_alloc_fail.py but no
>> errors were injected. I think the path from page_pool_dev_alloc()
>> does not call page_pool_alloc_pages()?
>> 
>> Here is what I beleive the call path is:
>> page_pool_dev_alloc(rq->pool, &offset, &truesize)
>>   page_pool_alloc(pool, offset, size, gfp)
>>     netmem_to_page(page_pool_alloc_netmem(pool, offset, size, gfp));
>>       page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
>>         page_pool_alloc_netmems(pool, gfp);
>>           __page_pool_alloc_pages_slow(pool, gfp);
>> 
>> If I change the call from page_pool_dev_alloc() to
>> page_pool_dev_alloc_pages() in the driver I do see the errors injected.
>
>Ah, good point. I think the netmems conversion broke it :(
>If we moved the error injection to happen on page_pool_alloc_netmems
>it would work, right? Would I be able to convince you to test that
>and send a patch? :)

Sure, I'll give it a shot.

