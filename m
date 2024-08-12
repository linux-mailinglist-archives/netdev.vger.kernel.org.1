Return-Path: <netdev+bounces-117635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B194EA58
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105CA1F211DC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0116E863;
	Mon, 12 Aug 2024 09:54:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2C16DEDF;
	Mon, 12 Aug 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456497; cv=none; b=qedw37u9rdzR8OFrssz9tCwcnhxK7oqTJ+cKELuTi069YEkg8lvFJvZVKDCGtfu5NM9pj6CCbC4kMFWNyzgf5099R8nXGc91cqWj4Mdrua6SeNY2XBnzUuDyT/JS8cv4lIScU9OrZyN+ONjUdmcdOfTYU09B66IuVUg0Z+iQ8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456497; c=relaxed/simple;
	bh=D+ucVtDSUdUq37cnu/dTz3Zg6zU0R46Cl7X+jiWU00Q=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rVX+lP9nGqGLQraPhYj5yt3cjYxLFga31C4B5dOaS3WeZnWxdXtY7Hs8D4RXNFKP8J2dTMXIADsxUaLNQGRDkXgXwT/ZnxeVv4Sy/pyY1TXqDcQtaTGA0MaeRTq9sLpfwVjOIhhkrk9y+2/C3hTPr5T3jC6DZfG/ipt3ZLYB0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.79.26) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 12 Aug
 2024 12:54:42 +0300
Subject: Re: [PATCH] drivers: net: bsd_comp: fix integer overflow in
 bsd_decompress()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Karina Yankevich
	<k.yankevich@omp.ru>, <lvc-project@linuxtesting.org>
References: <20240812084312.14127-1-r.smirnov@omp.ru>
 <61528e45-b2a7-5ef9-09dd-9cdc63c4599e@omp.ru>
Organization: Open Mobile Platform
Message-ID: <bd95f568-a4cd-6ffa-9260-fa261f40f252@omp.ru>
Date: Mon, 12 Aug 2024 12:54:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <61528e45-b2a7-5ef9-09dd-9cdc63c4599e@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/12/2024 09:40:42
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186994 [Aug 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.26 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.26
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/12/2024 09:43:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/12/2024 4:43:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/12/24 12:41 PM, Sergey Shtylyov wrote:

[...]

> On 8/12/24 11:43 AM, Roman Smirnov wrote:
> 
>> The result of a bit shift has type int.
> 
>    So far, so good... :-)
> 
>> If ibuf is greater than or
> 
>    *ibuf maybe? :-)
> 
>> equal to 128, a sign switch will occur.
> 
>    I wonder whether you had looked at the .lsy file before writing
> that...
>    Actually, movzvl (%rdi),%eax is used when reading *buf, so no 

   It was movzbl, of course...

> sign extension occurs at this point... it occurs when casting the 
> result of shift to *unsignjed long*

   ... before ORing with accm.

[...]

MBR, Sergey

