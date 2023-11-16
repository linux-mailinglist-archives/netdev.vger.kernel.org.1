Return-Path: <netdev+bounces-48460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216597EE6A2
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DCA1C208EC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29438487B0;
	Thu, 16 Nov 2023 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8561192;
	Thu, 16 Nov 2023 10:22:07 -0800 (PST)
Received: from [192.168.1.103] (31.173.84.76) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 16 Nov
 2023 21:21:59 +0300
Subject: Re: [PATCH net v3] ravb: Fix races between ravb_tx_timeout_work() and
 net related ops
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
References: <20231115022644.2316961-1-yoshihiro.shimoda.uh@renesas.com>
 <903d8187-3979-22b4-0849-43e84560ea4b@omp.ru>
 <TYBPR01MB5341209D8B6E97F8C0AE9DCFD8B0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <27ea10c1-a975-f13e-dc4f-1fa0b5766406@omp.ru>
Date: Thu, 16 Nov 2023 21:21:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB5341209D8B6E97F8C0AE9DCFD8B0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.84.76]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/16/2023 18:08:38
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181428 [Nov 16 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.76 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.76 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.76
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/16/2023 18:14:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/16/2023 3:28:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 11/16/23 5:43 AM, Yoshihiro Shimoda wrote:
[...]

>>> Fix races between ravb_tx_timeout_work() and functions of net_device_ops
>>> and ethtool_ops by using rtnl_trylock() and rtnl_unlock(). Note that
>>> since ravb_close() is under the rtnl lock and calls cancel_work_sync(),
>>> ravb_tx_timeout_work() should calls rtnl_trylock(). Otherwise, a deadlock
>>> may happen in ravb_tx_timeout_work() like below:
>>>
>>> CPU0			CPU1
>>> 			ravb_tx_timeout()
>>> 			schedule_work()
>>> ...
>>> __dev_close_many()
>>> // Under rtnl lock
>>> ravb_close()
>>> cancel_work_sync()
>>> // Waiting
>>> 			ravb_tx_timeout_work()
>>> 			rtnl_lock()
>>> 			// This is possible to cause a deadlock
>>>
>>> And, if rtnl_trylock() fails and the netif is still running,
>>> rescheduling the work with 1 msec delayed. So, using

   Ah, you say 1 ms here but 10 ms in the code! Not good... :-)

>>> schedule_delayed_work() instead of schedule_work().
>>>
>>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>>    Hm, I haven't reviewed this version... :-)
> 
> Oops, I should have dropped the tag...
> 
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>> [...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>>> index e0f8276cffed..e9bb8ee3ba2d 100644
>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>> @@ -1081,7 +1081,7 @@ struct ravb_private {
>>>  	u32 cur_tx[NUM_TX_QUEUE];
>>>  	u32 dirty_tx[NUM_TX_QUEUE];
>>>  	struct napi_struct napi[NUM_RX_QUEUE];
>>> -	struct work_struct work;
>>> +	struct delayed_work work;
>>
>>    Not sure this is justified...
>>    Then again, what do I know about workqueues? Not much... :-)
> 
> I thought that the schedule_work() called the work function immediately.
> So, I thought call*ing the schedule_work() from the work function caused
> endless loop. However, it is not true. The schedule_work() just inserts
> a work queue, and then the kernel calls the work function later.
> 
> So, changing from work_struct to delayed_work is not needed for fixing
> this issue, I think now. However, I have another concern about rescheduling
> this work by schedule_work() here because it's possible to cause high CPU load
> while the rtnl_lock() is held. So, I think we should call a sleep function
> like usleep_range(1000, 2000) for instance before schedule_work().
> But, what do you think?

   I think that a sleep before requeuing is pretty much the same as using
a delayed work...

>> [...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index c70cff80cc99..ca7db8a5b412 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -1863,17 +1863,24 @@ static void ravb_tx_timeout(struct net_device *ndev, unsigned int txqueue)
>>>  	/* tx_errors count up */
>>>  	ndev->stats.tx_errors++;
>>>
>>> -	schedule_work(&priv->work);
>>> +	schedule_delayed_work(&priv->work, 0);
>>>  }
>>>
>>>  static void ravb_tx_timeout_work(struct work_struct *work)
>>>  {
>>> -	struct ravb_private *priv = container_of(work, struct ravb_private,
>>> +	struct delayed_work *dwork = to_delayed_work(work);
>>> +	struct ravb_private *priv = container_of(dwork, struct ravb_private,
>>>  						 work);
>>>  	const struct ravb_hw_info *info = priv->info;
>>>  	struct net_device *ndev = priv->ndev;
>>>  	int error;
>>>
>>> +	if (!rtnl_trylock()) {
>>> +		if (netif_running(ndev))
>>> +			schedule_delayed_work(&priv->work, msecs_to_jiffies(10));

  You could reuse dwork instead of &priv->work here...

>>    The delay is rather arbitrary. Why not e.g. 1 ms?
> 
> I think that 1 ms is enough.

   Seeing now that 1 ms was intended...

> Best regards,
> Yoshihiro Shimoda

[...]

MBR, Sergey

