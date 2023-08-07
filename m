Return-Path: <netdev+bounces-25147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6603773108
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816921C20A03
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E50C174F7;
	Mon,  7 Aug 2023 21:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3F4432
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:15:21 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07298E5B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:15:21 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377L84W8004525;
	Mon, 7 Aug 2023 21:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=z+C72kzpIhGL1Y2bGJyvLEJt8HwImOTaOHvOjVqenBc=;
 b=mLc/bEzhL2EaDtkl5OHDsD5e+2qK3PPX2S0VUstDJuQWyhaEfWexsvNx4XQoJGFIUuPO
 i5MbhK0Of8XptutuWszSJLmYf+MVlJhkzMUJfxsL5Jut0CyyYvbpUXqOZGt2lC13loCJ
 BqrUs4QwHNJ1q2cd2q1T8pUhePDDLEsJotSmIwHzAMzJVUzOOybho28y0JYgt2roBMTT
 /PdS8uld1736aipiwJIhon1ZACGRsLNmTwCt7MAqCVgpkfzP/5LBTk3DrZ6g8txjEHn9
 BNKwAc+2RQaglWE2lumA8nNDasArab1lvBLFXzaVmP6WJXpfrBLHMD0LQkgFqYhmV5no aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb839rbsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 21:15:14 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377LBEHD014762;
	Mon, 7 Aug 2023 21:15:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb839rbse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 21:15:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 377JCA02030374;
	Mon, 7 Aug 2023 21:15:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn0ntv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 21:15:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 377LFBfu459384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Aug 2023 21:15:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B875805D;
	Mon,  7 Aug 2023 21:15:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151DA5805B;
	Mon,  7 Aug 2023 21:15:11 +0000 (GMT)
Received: from [9.41.99.4] (unknown [9.41.99.4])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Aug 2023 21:15:11 +0000 (GMT)
Message-ID: <11386c9a-6c07-2274-3d8f-eaa471b182df@linux.vnet.ibm.com>
Date: Mon, 7 Aug 2023 16:15:10 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4] bnx2x: Fix error recovering in switch configuration
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, skalluru@marvell.com,
        drc@linux.vnet.ibm.com, abdhalee@in.ibm.com, simon.horman@corigine.com
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
 <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
 <20230731174716.0898ff62@kernel.org>
 <cd2b2456b1853d71b1c84c152164732f3a39f4dc.camel@redhat.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
In-Reply-To: <cd2b2456b1853d71b1c84c152164732f3a39f4dc.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mtA6LrSeVO_xEs23fUw9gA4TrbOWj5hb
X-Proofpoint-GUID: yyuI3eiR9q2FkNZLm5jafx8E0HWtvLEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_23,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=872 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070193
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Thanks for the review.

On 8/1/2023 3:30 AM, Paolo Abeni wrote:
> On Mon, 2023-07-31 at 17:47 -0700, Jakub Kicinski wrote:

>>> @@ -4987,6 +4983,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
>>>   {
>>>   	struct bnx2x *bp = netdev_priv(dev);
>>>   
>>> +	/* Immediately indicate link as down */
>>> +	bp->link_vars.link_up = 0;
>>> +	bp->force_link_down = true;
>>> +	netif_carrier_off(dev);
>>> +	BNX2X_ERR("Indicating link is down due to Tx-timeout\n");
>>
>> Is this code move to make the shutdown more immediate?
>> That could also be a separate patch.
> 
> Note that the original code run under the rtnl lock and this is not
> lockless, it that safe?
>
Yes, it is safe.
The caller, dev_watchdog() is a holding a spin_lock of the net_device.

> Cheers,
> 
> Paolo
> 

Thanks,
Thinh Tran

