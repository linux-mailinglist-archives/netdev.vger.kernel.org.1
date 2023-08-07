Return-Path: <netdev+bounces-25144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6067730E8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B631C20BD9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1B174EC;
	Mon,  7 Aug 2023 21:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EF4435
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:09:01 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A5B6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:09:00 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377L0If7016715;
	Mon, 7 Aug 2023 21:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y2ujJONCUxdT491aTJxp1MSrut/KfuejjIPAByAAvq4=;
 b=h45gMTU7XrqqHJv7MHiHcJFqa/EWZ598FrLIxcBtou/fWZIFMBzx7ULl8fBMeAF4eGTQ
 u2yuu9D6cDnLx1TQRmW3iCWf6ckaaJEz4k0/9nx5QM3Ft0LKOv1bIztqFKGbQdBMALs8
 n0QfbG2DG76tcJ3RQGfAgXHn0leNy7KYtX5KNJaaFX+BA9zMfupza/J+TalIUKCvVqBc
 pQGlyMuZYv9KnamcmJGRqV9J6qO8v/Y8VbiEBFOik833KdQEEHOrSGXOHcfmhP30aKyK
 27QkQJf1NOLTAPPaTavmLib/zdZO71vnTUDqKSbdCKfURr568sj/Nx3aiclIV9W4k7xB Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb8580cs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 21:08:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377L1UPe019214;
	Mon, 7 Aug 2023 21:08:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb8580crf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 21:08:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 377JMWRN000363;
	Mon, 7 Aug 2023 21:08:52 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k8fde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 21:08:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 377L8p8w23855660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Aug 2023 21:08:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C33458059;
	Mon,  7 Aug 2023 21:08:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCFA358058;
	Mon,  7 Aug 2023 21:08:50 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Aug 2023 21:08:50 +0000 (GMT)
Message-ID: <7b4904f5-ceb1-9409-dd79-e96abfe35382@linux.vnet.ibm.com>
Date: Mon, 7 Aug 2023 16:08:50 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] bnx2x: Fix error recovering in switch configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        simon.horman@corigine.com
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
 <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
 <20230731174716.0898ff62@kernel.org>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <20230731174716.0898ff62@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7HmdwVsO3PILzS-pVeD_P7pDNtCA9USW
X-Proofpoint-ORIG-GUID: laD8Wrqd1N8yr8EBrbYGWm0OWLqOH7_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_23,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxlogscore=983 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070193
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for thorough review.

On 7/31/2023 7:47 PM, Jakub Kicinski wrote:

> 
> Could you split the change into two patches - one factoring out the
> code into bnx2x_stop_nic() and the other adding the nic_stopped
> variable? First one should be pure code refactoring with no functional
> changes. That'd make the reviewing process easier.

Sorry, I misunderstood comments in the reviewing of v3 asking to factor 
the code.
Should I keep the changes I made, or should I summit a new patch with 
factored code?

> 
>> +		/* Disable HW interrupts, delete NAPIs, Release IRQs */
>> +		bnx2x_stop_nic(bp);
>>   
>>   		/* Report UNLOAD_DONE to MCP */
>>   		bnx2x_send_unload_done(bp, false);
>> @@ -4987,6 +4983,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
>>   {
>>   	struct bnx2x *bp = netdev_priv(dev);
>>   
>> +	/* Immediately indicate link as down */
>> +	bp->link_vars.link_up = 0;
>> +	bp->force_link_down = true;
>> +	netif_carrier_off(dev);
>> +	BNX2X_ERR("Indicating link is down due to Tx-timeout\n");
> 
> Is this code move to make the shutdown more immediate?
> That could also be a separate patch.

Moving the code to here has the effect of disabling the link, preventing 
the excessive output of debug information from bnx2x_panic(). While 
bnx2x_panic() offers valuable debugging details, the excessive dumping 
overwhelms the dmesg buffer, they become unreadable.
I will exclude this part from the patch. A separate patch will be 
created to improve providing debug information

> 
>>   	/* We want the information of the dump logged,
>>   	 * but calling bnx2x_panic() would kill all chances of recovery.
>>   	 */
>> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
>> index d8b1824c334d..f5ecbe8d604a 100644
>> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
>> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
>> @@ -1015,6 +1015,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
>>   {
>>   	int i;
>>   
>> +	if (!fp->page_pool.page)
>> +		return;
>> +
>>   	if (fp->mode == TPA_MODE_DISABLED)
>>   		return;
>>   
>> @@ -1399,5 +1402,20 @@ void bnx2x_set_os_driver_state(struct bnx2x *bp, u32 state);
>>    */
>>   int bnx2x_nvram_read(struct bnx2x *bp, u32 offset, u8 *ret_buf,
>>   		     int buf_size);
>> +static inline void bnx2x_stop_nic(struct bnx2x *bp)
> 
> can't it live in bnx2x_cmn.c ?
It's in common header file for also being used by bnx2x_vfpf.c.

  Why make it a static inline?
> 
Just make it inlined where it is called.
>> +{
>> +	if (!bp->nic_stopped) {
>> +		/* Disable HW interrupts, NAPI */
>> +		bnx2x_netif_stop(bp, 1);
>> +		/* Delete all NAPI objects */
>> +		bnx2x_del_all_napi(bp);
>> +		if (CNIC_LOADED(bp))
>> +			bnx2x_del_all_napi_cnic(bp);
>> +		/* Release IRQs */
>> +		bnx2x_free_irq(bp);
>> +		bp->nic_stopped = true;
>> +	}
>> +}
>> +
>>   
> 
> nit: double new line
> 
>> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
>> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
>> @@ -529,13 +529,8 @@ void bnx2x_vfpf_close_vf(struct bnx2x *bp)
>>   	bnx2x_vfpf_finalize(bp, &req->first_tlv);
>>   
>>   free_irq:
>> -	/* Disable HW interrupts, NAPI */
>> -	bnx2x_netif_stop(bp, 0);
> 
> This used to say
> 
> 	bnx2x_netif_stop(bp, 0);
> 
> but bnx2x_stop_nic() will do:
> 
> 	bnx2x_netif_stop(bp, 1);
> 
> is it okay to shut down the HW here ? (whatever that entails)
> 
My mistake, I didn't notice this before. The second parameter is for 
deciding if the hardware should stop sending interrupts or not. I'm not 
familiar with the virtual function code path, but I'll correct it to 
make sure things are consistent.

>> -	/* Delete all NAPI objects */
>> -	bnx2x_del_all_napi(bp);
>> -
>> -	/* Release IRQs */
>> -	bnx2x_free_irq(bp);
>> +	/* Disable HW interrupts, delete NAPIs, Release IRQs */
>> +	bnx2x_stop_nic(bp);

Thanks,
Thinh Tran

