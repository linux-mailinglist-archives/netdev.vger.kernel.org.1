Return-Path: <netdev+bounces-117628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D294EA1C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA4D280A65
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CC16D9D9;
	Mon, 12 Aug 2024 09:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65216DC05;
	Mon, 12 Aug 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455681; cv=none; b=jVpzqaGoDOGr5s+2/6i+46N6xD2Z6cNeerjCd6YzktH6MR1ZAetldRzuh1Kd9BVjSjn57q+0GgruBZkSFO98Z7H9b2ugkZ1eSuzRbGCp/PyLUUQvjLh+QAxzKy+RNXUKqEY1puO1lI+fSgRc/pHeYH2HYtPulim9H2QCGjSCeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455681; c=relaxed/simple;
	bh=My0DvMgrrLWwHFf8s7PTaBYrI+PjPBB7SRkCx3NPHpk=;
	h=From:Subject:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kPbmJaKZM87+j90h4IQ1nr9u7qbTu8zu82N7vgNp2IV8qF8jaljz0T3pxopWz+nF6/SYgT04P5vGQG5wReGZJAfSWCDQGuFIFy8kmze7ZPvtt9gNgaR/6bZg1B4UVm3ch1zU0ZJGGz63FXHPeAvKrZgoI+J8fnHZYhJmZ3MeCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.72.190) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 12 Aug
 2024 12:41:05 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH] drivers: net: bsd_comp: fix integer overflow in
 bsd_decompress()
To: Roman Smirnov <r.smirnov@omp.ru>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Karina Yankevich
	<k.yankevich@omp.ru>, <lvc-project@linuxtesting.org>
References: <20240812084312.14127-1-r.smirnov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <61528e45-b2a7-5ef9-09dd-9cdc63c4599e@omp.ru>
Date: Mon, 12 Aug 2024 12:41:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240812084312.14127-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/12/2024 09:25:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186993 [Aug 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.190 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.190
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/12/2024 09:30:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/12/2024 4:43:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

   Failed to notice an issue with the subject in the internal review;
I think it should look like "net: ppp: bsd_comp: fix integer overflow
in bsd_decompress()"...

On 8/12/24 11:43 AM, Roman Smirnov wrote:

> The result of a bit shift has type int.

   So far, so good... :-)

> If ibuf is greater than or

   *ibuf maybe? :-)

> equal to 128, a sign switch will occur.

   I wonder whether you had looked at the .lsy file before writing
that...
   Actually, movzvl (%rdi),%eax is used when reading *buf, so no 
sign extension occurs at this point... it occurs when casting the 
result of shift to *unsignjed long*

> After that, the higher 32 bits in accm will be set to 1.

   Only if we have 1 in the bit 31 after shl %cl,%eax...

> Cast the result of the expression to unsigned long.

   I strongly suspect we should re-declare accm as *unsigned int*
instead...

> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> ---
>  drivers/net/ppp/bsd_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
> index 55954594e157..078fe8c9bee8 100644
> --- a/drivers/net/ppp/bsd_comp.c
> +++ b/drivers/net/ppp/bsd_comp.c
> @@ -918,7 +918,7 @@ static int bsd_decompress (void *state, unsigned char *ibuf, int isize,
>  	 */
>  
>  	bitno -= 8;
> -	accm  |= *ibuf++ << bitno;
> +	accm  |= (unsigned long)(*ibuf++) << bitno;
>  	if (tgtbitno < bitno)
>  	  {
>  	    continue;
> 

MBR, Sergey

