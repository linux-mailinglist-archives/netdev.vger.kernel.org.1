Return-Path: <netdev+bounces-276376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKv7A2se1mluBAgAu9opvQ
	(envelope-from <netdev+bounces-276376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E533B9CF7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C181B301FD5B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A02D29C8;
	Wed,  8 Apr 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBt7Mno4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTVF+uyi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE33B19D7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640156; cv=none; b=VgP7SJROIHdmzYvHrVi+5RO3WrTYrthzh2cMEVJZRsHBMqAI4kbSoG1dzPM6ohiXtd0a3Gc6gd/LMYEI0CbYZXL2t5rkie/B1au5BmDb2rnNFh2eFBOCv4ITpxt0KyKJehXBfJnzs7ZQrJefaW/5UxbKcnG1ldJRF5KISS4sGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640156; c=relaxed/simple;
	bh=2BhclhT9Q97T00HiP8qg5wipFD+trhNuHjt6zEKFSGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjq6/kw5GtXeOBzQaPb6hGqa7tRRpVLggNKywnO1JDGpFQSe0ItF4Mp3pBvsYYQY99ea0ICmFyda537KtWVfOZqf4iEwFCpYyWnfB0ctUYOiGQs5R+feYYFWmJqNz/D+TTimnzH4/WRskkvfVeekKoGh5B662/tDW1Flv01hQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WBt7Mno4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KTVF+uyi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63852oJH1006049
	for <netdev@vger.kernel.org>; Wed, 8 Apr 2026 09:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bf4TqWgXnJv8MV94k4Uut8ha/7y7QGO4q5QmtTQZ5AY=; b=WBt7Mno4FyOd0GyH
	go2ych4Xzh0POTbQH+0wvwjK+/LZbxzli//giAnGuzmrUt8SyY/hVHUcHDWcQyyO
	CWYaFwvjwf388BtESF7DbHI5uQoSGimmcSZPpY7CNohu9HVqQKbkF0CZyPu/kzcH
	q8w8bp7WTAqn3Hk03MjiCM4TkZNKej6q8t4raSmlv0lkqGjiZBMfQHEXhMxs26uV
	0+L4DzKpRMHm6K7IgF23MY0ITG1i71hCLdGP5WLawfav6DslA63MzYTdD5j24qZq
	7UB6zNkftq39qAK3I7x03P+2KSHtYvHLYlw01+jfD5MgxgTSnt5SgobFNbnC/XVU
	mhfOvQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tpaj2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 09:22:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso9107052a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775640145; x=1776244945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bf4TqWgXnJv8MV94k4Uut8ha/7y7QGO4q5QmtTQZ5AY=;
        b=KTVF+uyi4cyUsBrBYCsdDdEJgVIDYX7D9aAedldTWN2zkc7oOhKmTj+u8cs+gkZDUO
         o5be7KxRDglszqohYSzsB4fTQxbKzFiJEmZYgXaXuaLQjA68J8g8570oKsCi/GiGBw+U
         akTqlERr3m34Zd9ki7JqP/jUXWS0Vjd0Gd2fAgBFg8OMggoYEq1jMt0QNrv1UWKBxBXg
         twxhugqrSVPIN+Od98C0t3cuZ47X2gOnU5XICu2GFbxM7VyJQhVJsgpjO2XgCTaoM8v9
         +h77j7SDbtAuIlOYPPcZaBROonyLDs0gOVCIYoYoBIe+Zm12GIfw97sduDOA9tJMQk/y
         SAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775640145; x=1776244945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf4TqWgXnJv8MV94k4Uut8ha/7y7QGO4q5QmtTQZ5AY=;
        b=SGbao9PofwGhZduYeNBa6ap/ruc9pGTrNEyyjZivUDUMzNnK/CpqZ09SBWZAbCOunj
         GQ9HD/nMWMOfjsxdCRJwj6jdE0NAsxcmfabzZ8jy+jXFmwjLvSOjKJT7HV+Fl/0yJcmn
         r8C5Yn+u3lRSb8KVH/VKfMvm5TIw9o5rgkzSFnnP6LZh1BUI2cz9zwHKqtDH4CIejN4B
         cq9YeavRQMHLw/MdEm18QTKCI8feQevEfeeJUEUrgZ4mIhKvJlsg9WYdRRBmamlhYi2o
         bFU3Zr7qr24YaymM3F5admeXRQEKREXTer0bgtqum4e3k/oony+yAVfwgqGkWobN3p7e
         RTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHL3s73zllTj1HmugtlJy9S3geAgq8yPCZP1xEGBG5zjb30bFp8CpsI+zJaXYjCXhZVE1WIzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9m3QffBCf85DQAI+9JjLlgsUu0Mc6pIgRXmefwWR+hrmRxwi0
	OnxETsTfgSBfeZpAv/45Ls7Nfi7iIt3Zmtog1BQMTm0yXs6VCV91NM9dUzcgvgEnwpv1+/WUFP9
	iIcw0ev78odikBv/WpXji5iLI66/FiVABof1rNIegAj7SGMt2WuP5uyzzMJA=
X-Gm-Gg: AeBDieta4lxRnJ5ZmZy1CGyfaSMCEBkEtqf+JtqCL5CzaKHQRtfvsALhYP0p68AS4rX
	mH2raeJ1RTDTkpMqHOpFdDcxEvNuNOPm/uu+vWeoQnRlKrXHqdVeAVt4x5UwtSsPIlSi91XD7sH
	TdY2JMmM6qyjXGgW5LGXSW70nXMaDk4PAO+nn9F4hT2trA/YTUC64tZK1CMv4L1PHchmjhSYsvp
	dH2DCMRHT+Zs0YqtWrtp2u4HaeHJH3EX/+XYJ3e5S9n4t4HfbLCt+wBVjqSpfc//rySn5Gz+F9/
	FRzC6UX4ZpW194kVB+3r+UpySqm5bYqhq/2nMT5+jGlBSjn5tDy975rI9YLvw8SKr5p+zEdESxO
	SannCC5sgiXqu6Nq+4r5qeIwowQ6B9Ne9iZs68b4GcZA8FipGPgzi8A==
X-Received: by 2002:a05:6a20:432b:b0:398:92ef:1d95 with SMTP id adf61e73a8af0-39f2ee70addmr21171906637.21.1775640145159;
        Wed, 08 Apr 2026 02:22:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:432b:b0:398:92ef:1d95 with SMTP id adf61e73a8af0-39f2ee70addmr21171879637.21.1775640144653;
        Wed, 08 Apr 2026 02:22:24 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659bedesm17266512a12.30.2026.04.08.02.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:22:24 -0700 (PDT)
Message-ID: <6c48fed6-27df-449b-9e43-00a68e45b9ba@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 14:52:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] bus: mhi: host: Update the Time sync logic to read 64
 bit register value
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        taniya.das@oss.qualcomm.com, imran.shaik@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
 <20250818-tsc_time_sync-v1-4-2747710693ba@oss.qualcomm.com>
 <16698a59-1a2f-4816-98fe-56b125be669b@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <16698a59-1a2f-4816-98fe-56b125be669b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5v3DhX3BF0g1vk4fID4MYhb_rOmRw_T5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4NSBTYWx0ZWRfXxa9IZjfePx0t
 7XxM1oXl3gNueK5K7GZVPJnbDTblsxkQmIMfZu5bG8gYMkLMbdGkVB/NYYHU+iRw9Wxyng2pMuB
 IZtBdn6UWE/fn8olUP5Tm9IaQhu/sb8uTRbLadq4lyhUxcLzJtRaAGtEVAIUehCWPElTJ2fu0zf
 a0zDjcco92h6H8stVZcNEPOytbatetJepdC6dxd0BdD/Ol+vvYLCxThtLqBi9VHIqguzAjXUFAJ
 Mx+qsyI1DCgV1BBUd45beCkyuAyAqNPKR72/66FOXFJ/cECx8u9+UV2wO/5nDW1D2MZEb0pw5hm
 xkhwhQk6TC5B1/IBkTbmFIv/MQAshDvbU2oa4AaIeFeIqh8axIk83BOPet8BFFyNu/nVa2jCS0W
 8l9zujFFrViF23fCpC+AsD7LE6hjNrn022h6U8jkl1Us2fHw1uLf5IzhSBrDwV+bkZ5dXb/QHjC
 KkFo5vLoUQpPSV3cYeg==
X-Proofpoint-ORIG-GUID: 5v3DhX3BF0g1vk4fID4MYhb_rOmRw_T5
X-Authority-Analysis: v=2.4 cv=DNS/JSNb c=1 sm=1 tr=0 ts=69d61e51 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cgR8ezsCSdHxW5zDJ1AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080085
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-276376-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66E533B9CF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 9/2/2025 2:44 PM, Konrad Dybcio wrote:
> On 8/18/25 8:55 AM, Krishna Chaitanya Chundru wrote:
>> Instead of reading low and high of the mhi registers twice use 64 bit
>> register value to avoid any time penality.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/bus/mhi/host/main.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index b7ceeb7261b708d46572d1f68dc277b6e1186b6e..f628198218ef9dc760bbfc3ec496603d1a45dfc1 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -1719,6 +1719,7 @@ static int mhi_get_remote_time(struct mhi_controller *mhi_cntrl, struct mhi_time
>>  			       struct mhi_timesync_info *time)
>>  {
>>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> +	u64 val = U64_MAX;
>>  	int ret, i;
>>  
>>  	if (!mhi_tsync && !mhi_tsync->time_reg) {
>> @@ -1756,15 +1757,25 @@ static int mhi_get_remote_time(struct mhi_controller *mhi_cntrl, struct mhi_time
>>  	 * transition to L0.
>>  	 */
>>  	for (i = 0; i < MHI_NUM_BACK_TO_BACK_READS; i++) {
>> -		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
>> -				   TSC_TIMESYNC_TIME_LOW_OFFSET, &time->t_dev_lo);
>> +		if (mhi_cntrl->read_reg64) {
>> +			ret = mhi_read_reg64(mhi_cntrl, mhi_tsync->time_reg,
>> +					     TSC_TIMESYNC_TIME_LOW_OFFSET, &val);
> Since you're passing mhi_cntrl to the read_reg64 function anyway,
> perhaps this could remove some verbosity:
Hi Konrad,

Sorry for late reply, in pci_generic patch we are defining read_reg64 only if
readq is defined
in the system.  As per your suggesting if we go define mhi_read_reg64 always,
we need to
have #ifdef inside the mhi_read_reg64() or create a new function  both of them
doesn't look
good better to have this way only.

- Krishna Chaitanya.
> int mhi_read_reg64(...) {
> 	u32 val_hi, val_lo;
> 	u64 val;
>
> 	if (mhi_cntrl->read_reg64) {
> 		...
> 	} else {
> 		...
> 		val = FIELD_PREP(GENMASK(63, 32), val_hi)) |
> 		      FIELD_PREP(GENMASK(31, 0), val_lo));
> 	}
>
> 	return val
> }
>
>
> Konrad


