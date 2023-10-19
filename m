Return-Path: <netdev+bounces-42626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011E7CF912
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A22EB2125D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F79417743;
	Thu, 19 Oct 2023 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD9225B1
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:36:21 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E626BCF;
	Thu, 19 Oct 2023 05:36:19 -0700 (PDT)
Received: from [192.168.1.103] (31.173.85.253) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 19 Oct
 2023 15:36:09 +0300
Subject: Re: [PATCH net v2] ravb: Fix races between ravb_tx_timeout_work() and
 net related ops
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
References: <20231019113308.1133944-1-yoshihiro.shimoda.uh@renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f5421248-3341-a5f7-84e6-c601df470a63@omp.ru>
Date: Thu, 19 Oct 2023 15:36:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231019113308.1133944-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.85.253]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 10/19/2023 12:26:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 180733 [Oct 19 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.253 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.253
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/19/2023 12:31:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/19/2023 10:41:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

On 10/19/23 2:33 PM, Yoshihiro Shimoda wrote:

> Fix races between ravb_tx_timeout_work() and functions of net_device_ops
> and ethtool_ops by using rtnl_trylock() and rtnl_unlock(). Note that
> since ravb_close() is under the rtnl lock and calls cancel_work_sync(),
> ravb_tx_timeout_work() should calls rtnl_trylock(). Otherwise, a deadlock
> may happen in ravb_tx_timeout_work() like below:
> 
> CPU0			CPU1
> 			ravb_tx_timeout()
> 			schedule_work()
> ...
> __dev_close_many()
> // Under rtnl lock
> ravb_close()
> cancel_work_sync()
> // Waiting
> 			ravb_tx_timeout_work()
> 			rtnl_lock()
> 			// This is possible to cause a deadlock
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 0ef0b88b7145..300c1885e1e1 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1874,6 +1874,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
>  	struct net_device *ndev = priv->ndev;
>  	int error;
>  
> +	if (!rtnl_trylock())
> +		return;

   I wonder if we should reschedule the work here...

[...]

MBR, Sergey

