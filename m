Return-Path: <netdev+bounces-229153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C986BD8AAF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A533A816F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB330EF91;
	Tue, 14 Oct 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ogaP22rO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403422EBB87
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436191; cv=none; b=RCrz+lKS0uuhcDQU+NlGJTRYqvmzImanInUjWdp0G92Wl1E/gdgl8PuoG9T+flNifFaQm014SwYSgXHJcsut74RRYxxbGiu0FO17uJXAoz8vSz4R7sQITX9H2fwnPRCmx7tl+g+Dxe4KcrDdLX2mUdZ8+43QxeKSt3xfQhdCkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436191; c=relaxed/simple;
	bh=pN21Y/mlFy4wSxMkjNgxJeTfBPTXMlYf+2hBZ8yW5DE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cGHl+8rqPpyNSS7rmA27HYYVDadLnfr0nvwJY6uM4hyj6cAuREgqCFeGqMpFAUME6/FCG9tplTQFG7p6vnstHaZMq9ZwTxyIDo3iaOu5eVNJ5eujZxYkV1qlugf0CoJcL0xny7kwGorOEjtAM/PnTz1y0oq95dtBkeVITNvX+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ogaP22rO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87KXQ025794
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YpMjtNS2t8Qsmkv7Ge8cz+FmpPP0fXDLuqM5OfZKDac=; b=ogaP22rO7+NPhQxR
	TNl7vl3Pj0k9mStaduw0OP7EwFbB99CiJMY5tJHvo9wJn5ick554S/FbItxOVfxn
	I6vRFSdJXT5BQxOoI+E3dNWYMzk5X9DOPXsVCpUA3A6OMJFJ66REAGG7eTSIRJIy
	iqEYUBErCClc1I1VvNZ3CoSgRBFjf9wEOMbrnp2DCraUDfcR53paDA7hnG09R9Bz
	dnf3Ye+hUOy7nvl6IKY8hhMYEw01M3FfDKMJ/t4Mn87a3i+U7gTjtJ7oAv7dibsA
	tD587XVjtsHELsQm5XxaKXhiOhhhDq1wGn3Z03iif7KJ05RTFOZNSxrSPJXJk97q
	fkEvtA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfyw2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:03:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6fc6so197420735ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436188; x=1761040988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpMjtNS2t8Qsmkv7Ge8cz+FmpPP0fXDLuqM5OfZKDac=;
        b=qPUQ0TeJ3dZ5kC7tBuyMLkquFMWLu4jzirDHrlKAy5R4Q2PF4zsOKef+fbgcycUnRz
         K2dkhl0sP6rGopn6DU0MwVoKM6jGCWWI6PA79okRQkyGm186xuh4CfraEY/RCRKcUgXz
         BC1juwuz/HfIhkqOI0Cmb+0NMYNMWY5GVd4u/ngzExe8VCV/rDxysVFopgX7284Jqzc3
         2NAkEhCqZqDBe1sbVQ5kzibAW2xUctXEWV5YoUfKLMbRVjDPCPLghwnOvuPGzIrDd793
         tlDRFAp7ixAEktDhLr8N7wEfu4gYZ03ICHpNAa2KPSL/q84TevyUGEZmHO19/wxuH29M
         S0cA==
X-Forwarded-Encrypted: i=1; AJvYcCXSpD32/JqeJwpouaO5dYbliMHGS5gyiJL1B9dmkkn3wnijveGJObpE2+eqo1A+92PqR2fKoJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPez0ZOT7N+7AW038pHYw3w6/bJIGBm19GFy3mbyW1dvSMUHOJ
	gWUC80FrnSrfAYoPxc4ttL2U3Jo09SIWWaQuaUoBqJrOER5RV8SI8nD0U5vI1Tml7ybfsyyF98Q
	R+ywroQejpSJOyp2Xc+i/7RHccWMCkLMOYa9+bLWx48ROS6SjZlkma6siV64=
X-Gm-Gg: ASbGncswOBDgnYphtLTqsa2PKV4Uy24o388xSYD0VENxzzFDQ41/aaibwV7Q6K+TtCk
	e7Z5GMfSF2hx7Z7CGe7Nc3AM+GWDv41n0/rhduJYLkn9Lu6D9yQ70umgrPmmz/lVgNd3YgHCuuK
	P/nQj05lyv7O9QC8v5+ASCs3DyitAPtSncScFglYRVC8woM+XH/5nNmpIlR9f5rH5rYjwo2RJ1I
	+1MD0XV5VHMgAbZuFd0sxikQeGeMf2yai8vqKjW0p5F0t7R2fM2DcJZHYwtoG/jWnunwbUBhfrg
	DJ/neVx7sgSuEa32gE+y2Mr2cThxKtxYRh8MpmS1h1i5S46+Bhyvoch8pdFZ8coI3wc=
X-Received: by 2002:a17:903:910:b0:258:9d26:1860 with SMTP id d9443c01a7336-290273ffeb7mr333722615ad.40.1760436187360;
        Tue, 14 Oct 2025 03:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaR4sHqbZzJquEl4UlTgUvAbfqjTkOISLr3MINnz0WCArr+8zC5qPyhZB1fBpUV5mZajByaA==
X-Received: by 2002:a17:903:910:b0:258:9d26:1860 with SMTP id d9443c01a7336-290273ffeb7mr333722105ad.40.1760436186736;
        Tue, 14 Oct 2025 03:03:06 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f87b23sm160005665ad.113.2025.10.14.03.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 03:03:06 -0700 (PDT)
Message-ID: <486d9339-c7c0-462a-97e2-92a243bbf200@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 15:32:42 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] bus: mhi: host: mhi_phc: Add support for PHC over MHI
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
To: Jakub Kicinski <kuba@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, taniya.das@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
 <20250818-tsc_time_sync-v1-5-2747710693ba@oss.qualcomm.com>
 <20250821180247.29d0f4b3@kernel.org>
 <0b950a45-21e5-4c8d-bc76-1c801b86e2ef@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0b950a45-21e5-4c8d-bc76-1c801b86e2ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXzcupwAzvRCS+
 qSH9b5eMgoGdc4/X5TiCB1uO2vvVudWBULW2oEhmz8wtDG4QOIjgSg4ZzjQuAlgesrPzzSQszFS
 ZmlGj8dq2Eq/cb6P7uYPWlmnf1l6nauW5EzCCms2txownFTEZoyB8zuYzAP2xXYYbbIbGqHKMqo
 sQd/flVP2RtpPxpvUr490GRVBgVeiETgVo4qrEIdiJhnzHVrAQT2dt2BDbL1q283h8G9DVFfwo1
 jzbjhFHQMxYUsyt7iKXJE+2Y0f7PoBA59wOP05dSETDfZdY4FdOA7TMUJaFmIpMvomfFzXOIA8S
 9cNKwZ4xP3Z+rbIVXsqiP8XLKJlIEmxTSiK8Qz4zK/OzPsGJyUHtDu+jEXekONijkEYl1JAuyeN
 FzTiLfA3kKW+XoQ0n4sdly1/m7pMIQ==
X-Proofpoint-GUID: tRmXM_2MSb1Jbd4kjY0gSjZ8RC2-uAy4
X-Proofpoint-ORIG-GUID: tRmXM_2MSb1Jbd4kjY0gSjZ8RC2-uAy4
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ee1fdc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=elLdLcMF98_VclgcXSwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025



On 9/16/2025 2:47 PM, Imran Shaik wrote:
> 
> 
> On 8/22/2025 6:32 AM, Jakub Kicinski wrote:
>> On Mon, 18 Aug 2025 12:25:50 +0530 Krishna Chaitanya Chundru wrote:
>>> This patch introduces the MHI PHC (PTP Hardware Clock) driver, which
>>> registers a PTP (Precision Time Protocol) clock and communicates with
>>> the MHI core to get the device side timestamps. These timestamps are
>>> then exposed to the PTP subsystem, enabling precise time synchronization
>>> between the host and the device.
>>
>>> +static struct ptp_clock_info qcom_ptp_clock_info = {
>>> +	.owner    = THIS_MODULE,
>>> +	.gettimex64 =  qcom_ptp_gettimex64,
>>> +};
>>
>> Yet another device to device clock sync driver. Please see the
>> discussion here:
>> https://lore.kernel.org/all/20250815113814.5e135318@kernel.org/
>> I think we have a consensus within the community that we should 
>> stop cramming random clocks into the PTP subsystem.
>>
>> Exporting read-only clocks from another processor is not what PTP
>> is for.
> 
> Hi Jakub,
>  
> Thank you for the review and for sharing the link to the ongoing discussion.
> 
> I understand the concerns about using the PTP subsystem for read-only clocks.
> The idea behind this patch was to use a standard interface for syncing time
> between the host and device, and also to make use of existing tools like
> phc2sys from userspace.
>  
> I have looked into the on going discussion you pointed, and we’re facing
> a similar challenge. Based on internal discussion with the PCIe team, we’ve
> confirmed that PCIe PTM isn’t applicable for this hardware use case.
>  
> That said, since it seems the community prefers not to use PTP for such
> requirement, could you please suggest any other way to support this time
> sync requirement that would be acceptable upstream?
> 
> Appreciate your guidance!
>  

Hi, Could you please share your thoughts on other approaches or directions we could
take to support the above requirement in a way that’s acceptable upstream?

Thanks,
Imran

