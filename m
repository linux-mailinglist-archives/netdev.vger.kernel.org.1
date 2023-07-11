Return-Path: <netdev+bounces-16733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D461F74E93C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103BC1C20C3D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7914AB5;
	Tue, 11 Jul 2023 08:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF542134C8
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 08:37:54 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A398
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:37:52 -0700 (PDT)
Message-ID: <7005af42-e546-6a7c-015f-037a5f0e08a9@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689064670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VP5DDhHDH7Z6xQfUSr62zDjPhEDhJObHWYpffygtjCE=;
	b=XC5pkhUh8sb/j37Ddbptwqu1qVnVnSvkR+/szLzWmKdX0bymKIZOwfXEnj7FgxrlXSVI/p
	iXPMifSLmMWUW3dICarZVzRk0Iyfp8a1F2Ee9YiXF/lPUyYo3z5G4HOb+Wqak33PCype9v
	9wHrkImEgSWSosi1/B9mF/psMf3RPnEpCmI9pQEUsy52RgrZwjliXMPtXNiqNMbRXE7eDu
	00UuRi3tz6nD6Oqodp8+CD4EcMcCY1hiB9wpH3S5srNIlnCViRZ78HUnRRnOpoXGS0HFgj
	eihkcjlg2UlXXvFL/Tv5mf9osbDqhVF+AKbEFGswd9vCiNq+7PiuoOkxbzl2bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689064670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VP5DDhHDH7Z6xQfUSr62zDjPhEDhJObHWYpffygtjCE=;
	b=j4cE5AeDFUZmbLnxPOQjegDKQv20ktIg2Zmp7X+CPz7WlLzmwaTfKA6lf+wFWrINH2pc4o
	zUkMdRoac45RBnCQ==
Date: Tue, 11 Jul 2023 10:37:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, kurt@linutronix.de,
 vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
 tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
 sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-6-anthony.l.nguyen@intel.com>
 <20230711070902.GF41919@unreal>
From: Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH net 5/6] igc: Fix launchtime before start of cycle
In-Reply-To: <20230711070902.GF41919@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11.07.23 09:09, Leon Romanovsky wrote:
> On Mon, Jul 10, 2023 at 09:35:02AM -0700, Tony Nguyen wrote:
>> From: Florian Kauer <florian.kauer@linutronix.de>
>>
>> It is possible (verified on a running system) that frames are processed
>> by igc_tx_launchtime with a txtime before the start of the cycle
>> (baset_est).
>>
>> However, the result of txtime - baset_est is written into a u32,
>> leading to a wrap around to a positive number. The following
>> launchtime > 0 check will only branch to executing launchtime = 0
>> if launchtime is already 0.
>>
>> Fix it by using a s32 before checking launchtime > 0.
>>
>> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 5d24930fed8f..4855caa3bae4 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1016,7 +1016,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
>>  	ktime_t base_time = adapter->base_time;
>>  	ktime_t now = ktime_get_clocktai();
>>  	ktime_t baset_est, end_of_cycle;
>> -	u32 launchtime;
>> +	s32 launchtime;
> 
> The rest of igc_tx_launchtime() function is very questionable,
> as ktime_sub_ns() returns ktime_t which is s64.
> 
>   1049         launchtime = ktime_sub_ns(txtime, baset_est);
>   1050         if (launchtime > 0)
>   1051                 div_s64_rem(launchtime, cycle_time, &launchtime);
>   1052         else
>   1053                 launchtime = 0;
>   1054
>   1055         return cpu_to_le32(launchtime);
> 

If I understand correctly, ktime_sub_ns(txtime, baset_est) will only return
something larger than s32 max if cycle_time is larger than s32 max and if that
is the case everything will be broken anyway since the corresponding hardware
register only holds 30 bits.

However, I do not see on first inspection where that case is properly handled
(probably just by rejecting the TAPRIO schedule).

Can someone with more experience in that area please jump in?

Thanks,
Florian

> 
>>  	s64 n;
>>  
>>  	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
>> -- 
>> 2.38.1
>>
>>

