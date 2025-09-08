Return-Path: <netdev+bounces-220946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64687B49889
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B011BC6353
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C03112DC;
	Mon,  8 Sep 2025 18:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8C2206BB
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357038; cv=none; b=mOKPZ7XR1cAaCNCJ9heyC5dDj4jjfNfoQfeDkThOZ/NkkpM366jrpemZ1f4cl0vZvereW3QqzdkemQeW8sotlZDtuKttH86WEDo053pyQavqO0OQbHYkyPQqEOqNW8Xk987PpJut2J3zm7ZINLABY3WGQ6ZKgXb8gX+7/mhnZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357038; c=relaxed/simple;
	bh=bOpPYuwLBxCFGvZOTj03z7u0xur1IgDj+miogLcrdxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=jbDHkcMylb5WMTDH+HPXdCnFxx9KmdHAef4OcmojIhz3lCL+mk2dFom2WXa9SmMRAE5n12u/ALT1/GJcJzAlCIoDfyFQ6PXGoJ7lOOHhdTIIo3TJsfUBzITtU3G2QOpegehr/gC2/AJy8epPP7AUPXT8wdDTpN6kPfNMGtaCTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.154.55) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 8 Sep
 2025 21:43:49 +0300
Message-ID: <d5ba9af3-6e61-4206-9eb0-7d3349807d23@omp.ru>
Date: Mon, 8 Sep 2025 21:43:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: prevent division by 0 in
 stmmac_init_tstamp_counter()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
CC: <linux-arm-kernel@lists.infradead.org>
References: <58116e65-1bca-4d87-b165-78989e1aa195@omp.ru>
 <a49cff49-3fe5-417d-8f71-7ec63a68112d@linux.dev>
 <d92071a9-471e-47f3-8dff-069f9dc6f10c@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <d92071a9-471e-47f3-8dff-069f9dc6f10c@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/08/2025 18:17:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196103 [Sep 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 66 0.3.66
 fc5dda3b6b70d34b3701db39319eece2aeb510fb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.154.55
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/08/2025 18:20:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/8/2025 5:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/8/25 9:26 PM, Sergey Shtylyov wrote:
[...]

>>> In stmmac_init_tstamp_counter(), the sec_inc variable is initialized to 0,
>>> and if stmmac_config_sub_second_increment() fails to set it to some non-0
>>
>> How that can happen?
> 
>    Let's see what the commit in my Fixes tag said about the problem it fixed:
> 
> ---
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> 
> Clang is concerned with the use of stmmac_do_void_callback (which
> stmmac_get_timestamp and stmmac_config_sub_second_increment wrap),
> as it may fail to initialize these values if the if condition was ever
> false (meaning the callbacks don't exist). It's not wrong because the
> callbacks (get_timestamp and config_sub_second_increment respectively)
> are the ones that initialize the variables. While it's unlikely that the
> callbacks are ever going to disappear and make that condition false, we
> can easily avoid this warning by zero initialize the variables.
> ---
> 
>    I think the original commit was just somewhat incomplete, as (adding 0-
> initializer into picture) it missed to add checking of sec_inc for 0 before
> invoking do_div()...

   Oops, it was div_u64()! :-)

MBR, Sergey


