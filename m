Return-Path: <netdev+bounces-158238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9BA112F7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B29167552
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB120F09D;
	Tue, 14 Jan 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="XB4om/fh"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BE20CCCE
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889805; cv=none; b=LlPRPwKQ58h3zlzfnp0Qo8o1uGnbH2kNxAbxT0pQlzKmEgBzJiaz1Uc1EiO896vrke7IyrS7r2iri5q9UpY9ep7FjDMLoWCtK9oUhjr6tIMn2Wx5Kv5JMpryRV1f8ZTpUvc9WxhzRzFIJ9XKcryaSkuzn1qXEi6MIHItVPThpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889805; c=relaxed/simple;
	bh=wXjHT7ZVz1Cmfq9AxZ28+DLgwSbCt3XuRM3MF/oNe1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPu62B/8fAIlFhSGt9f+mZsem7I2OQgh/XN6/KNGC3BcXLYotzP8+hc8b4RmfhgXCbgKFh+ruNkHSqlda8vbbx6wDrIGoZPOCOMH7rfYUqzBt2aq6PLjb936gWPfiHaK8/3AlADUT39GJo9cG78qoogeAZ7E933Iwec6KLxHW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=XB4om/fh; arc=none smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1452; q=dns/txt; s=iport;
  t=1736889803; x=1738099403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P+xBtBmlGL1Ztzdb3+rbtNMMdpkm47jewl2TfY6noug=;
  b=XB4om/fhxM603yGo0Z3+zCef9VUWsUNAfwguyYikSf9X5ToIqlATtsnp
   wxWkZohACy6/wBhOq96/H3s5u62yeyT/VaSUkXedE8GF9ycWGsdnot8xB
   6mX3VBK9zn3IIL9QomfmazBnoOvakrLJfbfXqhK6j/a0QssEn1PIuq10p
   4=;
X-CSE-ConnectionGUID: FevFPWaVSF+RHZqxdE3ODg==
X-CSE-MsgGUID: Tv7Xy3/eR4i/oC66jDmYgA==
X-IPAS-Result: =?us-ascii?q?A0A8AACi1IZn/47/Ja1aHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kqBT0NIjHJfiHWeGIF+DwEBAQ9EBAEBhQcCinQCJjQJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWgEBAQECATIBRhALGC4rKxmDA?=
 =?us-ascii?q?YJCIwOzJIIsgQHeM4FtgUgBhWqHX3AbhFwnG4FJRIEVgnkxPoQbCmuFdwSCe?=
 =?us-ascii?q?IEog0CeeUgKgRcDWSwBVRMNCgsHBYEkHysDOAwLMBUlD4EYBTUKNzqCDGlJN?=
 =?us-ascii?q?wINAjWCHnyCK4IhgjuER4RVhWKCFIFlAwMWEAGDKIEOQAMLGA1IESw3FBsGP?=
 =?us-ascii?q?m4Hmzg8hRyBC6cJoQOEJYFjn2MaM6pTmHykR4RmgWc8gVkzGggbFYMiUhkPj?=
 =?us-ascii?q?lnDAyUyPAIHCwEBAwmPV4F8AQE?=
IronPort-Data: A9a23:X4LNAKNiNSFF4prvrR2HlsFynXyQoLVcMsEvi/4bfWQNrUon32BTz
 mofCzzQafiDY2fxc99xYY2xphwOu5LVxodqTHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZQf8gmIsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69tjEm8OAoQmwcg0O0F87
 OwUBWsqQh/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmES/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzNnwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQqiOa1b4OIJYbiqcN9oljHl
 nOduGnDXhBdM/fBlzip90Ojr7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYA980ukStS7VBq9yFaHoxQVc9ldCes37EeK0KW8yw+fCnIJUX1HZcAqudEeQSEs0
 BmCn7vBHTVlvbuUYWiQ+redsXW5Pi19BWkPeSMJUyMb7NT55oI+lBTCSpBkCqHdszHuMSv7z
 zbPqG01gK8eyJZWka665lvAxTmro/AlUzII2+keZUr9hisRWWJvT9XABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:XR/M/6p/S+uyuPBWLIopelYaV5oseYIsimQD101hICG9vPb2qy
 nIpoV96faaslcssR0b9OxofZPwI080lqQFhbX5Q43DYOCOggLBR+tfBMnZsljd8kbFmNK1u5
 0NT0EHMqySMbC/5vyKmTVR1L0bsb+6zJw=
X-Talos-CUID: 9a23:FTP4LmOmPngpL+5DdiR52nYrE/4eXD7n7EXJM0OVUkFFR+jA
X-Talos-MUID: 9a23:BjAr6gaqGcPfJOBTiyGztCA5c8pSv6XpD2tTz5cqvviLHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,315,1728950400"; 
   d="scan'208";a="306071572"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Jan 2025 21:23:17 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id 4553718000225;
	Tue, 14 Jan 2025 21:23:17 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 1C98820F2003; Tue, 14 Jan 2025 13:23:17 -0800 (PST)
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
Date: Tue, 14 Jan 2025 13:23:17 -0800
Message-Id: <20250114212317.26218-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250110163844.39f8efb3@kernel.org>
References: <20250110163844.39f8efb3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

>On 1/10/25, 4:38 PM, "Jakub Kicinski" kuba@kernel.org wrote:
>
>On Thu,  9 Jan 2025 20:03:02 -0800 John Daley wrote:
>> >>Good point, once fragmentation is no longer possible you can
>> >>set .max_len to the size of the fragment HW may clobber,
>> >>and .offset to the reserved headroom.  
>> >
>> >Ok, testing going good so far, but need another day.  
>> 
>> Testing is OK, but we are concerned about extra memory usage when order
>> is greater than 0. Especially for 9000 MTU where order 2 would mean
>> allocating an extra unused page per buffer. This could impact scaled up
>> installations with memory constraints. For this reason we would like to
>> limit the use of page pool to MTU <= PAGE_SIZE for now so that order is
>> 0.
>
>And if you don't use the page pool what would be the allocation size
>for 9k MTU if you don't have scatter? I think you're allocating linear
>skbs, which IIRC will round up to the next power of 2...

Right, I now realize the linear skb allocation does round up so it is
using the same amount of memory as page pool for MTU 9000. I am spinning
a new patch set where only page pool is used since the code will be less
complicated. Thanks!

>
>> Our newer hardware supports using multiple 0 order pages for large MTUs
>> and we will submit a patch for that in the future.
>> 
>> I will make a v5 patchset with the napi_free_frags and pp_alloc_error
>> changes already discussed. Thanks, John

