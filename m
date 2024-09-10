Return-Path: <netdev+bounces-126823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F082D9729CC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF5B22C44
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC67617965E;
	Tue, 10 Sep 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="stYx2Exr"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7C1B85FC
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951109; cv=none; b=RGW89M47Ez56JquS+Pedu8kk/+8+r8n/l2vE51+kRs3szrw21u/Gkppxiy2YW51bIwaY3A9cxT9G9B3Oi18nZq2aPpg5GzZ1OdiWM4/WeaoVB7j9A6WdaIuKkC8FUCM/mD+UPLvdu3sgf/+UNPj8xbO94ghj8ANqOG8ADmB9Txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951109; c=relaxed/simple;
	bh=zj2wCWFwSTwiZOz1TbdRs2PiphUB2ntK7PaANojphRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ifFbBTx4ZsiakYrAO1lskJK40iPiUfJuksl1qwvNeSxTtOR1ZKfK81r1Tl0+2NLtiBsB6DuT0jvt8cSvBghIn/xDYPwL3ObQ/G1lN/zhOneOYrU1AhUT2KOIgefS3Y0ytm4BDrzKezJLHqE3/joPT3AEfSOgDtLzAKDYuw+kuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=stYx2Exr; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A0hTkT005470;
	Tue, 10 Sep 2024 08:51:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1kggNHfukLEneAOODgmHhQlE0AXv2Yh1xe37OKiCxSU=; b=stYx2Exreo1CuwFw
	5A1MFO9rRRLuIkG+zrR4kTynxqu5Q7SfouFrYBCQPNnvXNZofrwIxn3YoezSBSNB
	DkASRuBRpQAiAaMmbG5QHoF+WYuYdEB4thenGzSI6azTRQUvkZG+Ei936/Ab4uf/
	HCyPblWtWFFPUyc+jTMQP1FVTUzd9MBaKeGhXyMoGuNdLoHKVwEvcUh1B2BR857M
	g2PSQnvVJFi0Hyt0peAGQVZPJcwXXbOOsk4NtvpWVqmXTbPOlbPwQma3qlv39Vmu
	UsHS+Uogn+DdcQQXuifP2PO9gQx3VJwRvKWAaGcqXxqE0QJHl8R+fXXY0pvy7f8a
	AICelQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gyeh0961-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 08:51:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3FEF04002D;
	Tue, 10 Sep 2024 08:50:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A019241393;
	Tue, 10 Sep 2024 08:49:59 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Sep
 2024 08:49:58 +0200
Message-ID: <b7f33997-de4e-4a3d-ab1e-0e8fc77854ec@foss.st.com>
Date: Tue, 10 Sep 2024 08:49:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Regression with commit: ptp: Add .getmaxphase callback to
 ptp_clock_info
To: Richard Cochran <richardcochran@gmail.com>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciek Machnikowski <maciek@machnikowski.net>
References: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>
 <Zt8V3dmVGSsj2nKy@hoboy.vegasvil.org>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <Zt8V3dmVGSsj2nKy@hoboy.vegasvil.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Richard,

On 9/9/24 17:35, Richard Cochran wrote:
> On Mon, Sep 09, 2024 at 05:13:02PM +0200, Christophe ROULLIER wrote:
>> Hi Rahul, All,
>>
>> I'm facing regression using ptp in STM32 platform with kernel v6.6.
>>
>> When I use ptp4l I have now an error message :
>>
>> ptp4l[116.627]: config item (null).step_window is 0
>> PTP_CLOCK_GETCAPS: Inappropriate ioctl for device
> Strange.  The ptp4l code does simply:
>
> 	err = ioctl(fd, PTP_CLOCK_GETCAPS, caps);
> 	if (err)
> 		perror("PTP_CLOCK_GETCAPS");
>
> But this kernel change...
>
>> This regression was introduced in kernel v6.3 by commit "ptp: Add
>> .getmaxphase callback to ptp_clock_info" SHA1:
>> c3b60ab7a4dff6e6e608e685b70ddc3d6b2aca81:
> ...should not have changed the ioctl magic number:
>
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 1d108d597f66d..05cc35fc94acf 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -95,7 +95,8 @@ struct ptp_clock_caps {
>   	int cross_timestamping;
>   	/* Whether the clock supports adjust phase */
>   	int adjust_phase;
> -	int rsv[12];   /* Reserved for future use. */
> +	int max_phase_adj; /* Maximum phase adjustment in nanoseconds. */
> +	int rsv[11];       /* Reserved for future use. */
>   };
>
> Maybe the compiler added or removed padding?  What compilers did you
> use?

I've tested with platform 32bits and 64 bits and I have same error.

Toolchain/compiler used are:

aarch64-ostl-linux-gcc --version
aarch64-ostl-linux-gcc (GCC) 11.3.0
or

arm-ostl-linux-gnueabi-gcc --version
arm-ostl-linux-gnueabi-gcc (GCC) 12.2.0

Thanks,

Christophe

>
> Thanks,
> Richard
>
>
>
>

