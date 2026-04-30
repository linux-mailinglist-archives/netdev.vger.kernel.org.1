Return-Path: <netdev+bounces-282711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIwqHnsV82llxAEAu9opvQ
	(envelope-from <netdev+bounces-282711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDE49F51E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E92300D92F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906D3FE646;
	Thu, 30 Apr 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRtZSpi6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fRe7ktX9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFC3FE650
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538423; cv=none; b=AOy3qy1r1Xj2HhyhP7M8FL0XEeyBQTt1Fb+o5ArOQsxh8rKv+fK50q2lfDw51yor8CpBoPo5YjLJtX0z/mLHAmgx3d/HJ6Fbc4gJHTe0P3NLbULqMxC+y3i13YAMFjCY80K0nL7DZw+3QSy+AMMn0S91PmYJ3OIjql1jbdhOUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538423; c=relaxed/simple;
	bh=B3RTdQVdT/TQMBR9Xv91ApyqkspQ8nfdAwtAMn8Gc00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTk/0NGJCSWN7cr8QnUlWdNX4/kzpojvKcAIneA1vdqz+LeYc/NfuIP6YJfIxOnss9iy5tazvnbxFSsZ20ptgwdMzvAMkcDkB0a7fNL8bH5QLrKEgoxorWfduJW4nQTkn4hCK3Sga3rvARAM01VeVIxZxVxth2gdj9dLz6/QKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRtZSpi6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fRe7ktX9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U75Ygq831472
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KqTeQVb5il4BxWLnjLGKpxyBsOw+axckYHeHHInI9FY=; b=oRtZSpi6X51x0jtE
	lj+AGMxfn1+IqhM5nAXB8bPgIFSEspswIzjTogJUkYSoaizKsTquuKFObeiAnfp2
	vxg2hjULj5Dqcx2IWVW48oBC6fvFSOvQEuZUzX8pxfgOt9Ak1nCSk5Kb6cVH9/MW
	F9wqYoS4UF+bIkthl2X30CfmUENdi6AJ6duq2tFzyI6/VzdImvDCvGAdC4LMpa7b
	ye1EWI2QyWZ5R0xjfokwTVkaEAuInw2ixjf3kGMhzUweogGFKbWWsKcusF12MeLu
	hF83IOtr6Bn+i/mdZ+veGLesaAq/eQKOxwqOf9A6kn6IfM1F/uiOOYuoMDYZMx/X
	TqnZow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv2cq0btx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:40:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249541063so6836565ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777538420; x=1778143220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqTeQVb5il4BxWLnjLGKpxyBsOw+axckYHeHHInI9FY=;
        b=fRe7ktX9eZq0eP+kTH1hhVMkHXdNwX9FBu8/uPZGgLZ7cYAtZfTbv5Q9zwhvkkuPKE
         30lWr7mMILhUSdjXVuWrF15e8FBKF14DxZu2hlE79RmpfoFAlaX1RK/0vOP3n+RosYgs
         rEb5fmp62TSMNZFBBAeq++4b9dZKaHHJaH6xeB47+IeBP3b1CvRFwehoRDvJ84R7UEdX
         iNukwMpp8aCTbZfl2aWa+9BbQ3i5ayT7e6712QlWPTAhtECTz6x1WUGZx4mDtYGthrA/
         boyZigK5Ut+kOVnBfUlC3rvrl1+V1qJGFLD575Y9Ms9HvjYrHszwgXfaZ3VNP+THcVVZ
         iAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777538420; x=1778143220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqTeQVb5il4BxWLnjLGKpxyBsOw+axckYHeHHInI9FY=;
        b=juKNJJ87cec/OEon77SmH2v2MQwCPictbddFctJm6qpkV0Y8TBEj66Yn1wuEiHUqRL
         q/rZ3yJTWsbHUghkIVtj9LrBdNF6r+V27s4LfFzWeHUvLd6DU5Twj7wIrBz+gEH8EHaI
         NSaUwEPBJM0oRvVu95FO9V9HJfUae+g4fR4BLBDQpJR3ZwcR6CkRgEFs/gt7n5VrMfjh
         EyW+kxhVdhe9lD1K0NCxYOXev6aafg8Ys6HaDC6tfS82gFy1crUgt8uPJ6dA97D8qgG4
         w8bRl11RXp0ACxOewO6eIkfi3SGwNFOU8/ktJcIWafzxURj7nXcZxHWZMUq2Iu5zwR7k
         s8xA==
X-Forwarded-Encrypted: i=1; AFNElJ9S+ZBQk7ZBL2iDHIcnyUMonTmYfdxArf3ZD4tzGm6+MN+G699ktM36varjEwV+hLHxEr5gtXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5OhhFHUQUcHIeDWL1fkPBQuQfixmZ8VRsPxNMkpgfaaNR5eR
	xBGBwT/WLDUuhN+yXDdQDnGvddg9YFdaL83tf43GxtEskxqzJptBks9i9oqrcKX4BH5xsrUwA/k
	wHKnZc7EjAUyfRcee+IulHnhdOwwjM1nwtPc1Cqi5diCrpDGDbL6Oj6lbVvg=
X-Gm-Gg: AeBDievPagL5uXRlt96dd6ORSlwlX461l6xcjsBnneS7REnTCjKxfCOvSRofimtFk8R
	juw9OyCs3BNygkuv1am1eZzK82DAo85YnQfKDxsrWKozDhMi2li3ZaqGdMVMk3chBijUw/KGpkN
	vzcZ8qvlIRu+uNi7zNeAfgz+C9MKusJz34LEYV9P3M5nSsptB5jH3epaK9zdbww1O2gyfrQ0nd+
	61JMdOuxJAH2EVkmRGFuip/E/J+0hvnqEB375FE7UqH/WhJS/PVFpEeSYgAK45BYg67A/aANT9i
	vGeZ/P9QqPKPS4Pd8YZRgdQgMj/HdeBvXe0WunHbZxTFFPYadp4lrib5wXJV/fTagG+U74znUQX
	aCJC27kGiMkYcZHX0r27sMNIZyUdjBNUlkx3Hs8jHo6yPzV82BncjtEgfJ8s=
X-Received: by 2002:a17:902:c949:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b9a231ad36mr19136915ad.9.1777538420067;
        Thu, 30 Apr 2026 01:40:20 -0700 (PDT)
X-Received: by 2002:a17:902:c949:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b9a231ad36mr19136485ad.9.1777538419530;
        Thu, 30 Apr 2026 01:40:19 -0700 (PDT)
Received: from [10.218.5.114] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f132sm46236635ad.49.2026.04.30.01.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 01:40:19 -0700 (PDT)
Message-ID: <2efc6a84-cbae-4460-a0f9-3712da8c33a7@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:10:13 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: defconfig: Enable Qualcomm Shikra SoC Global
 clock controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
 <20260429-shikra-gcc-rpmcc-clks-v1-5-c3cd77558b7a@oss.qualcomm.com>
 <6f76dd8a-2007-4012-980f-268076fff5ad@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <6f76dd8a-2007-4012-980f-268076fff5ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UYMMYAtMMXDpqat0tX-ixsDXXbGFJI2o
X-Authority-Analysis: v=2.4 cv=aYRRWxot c=1 sm=1 tr=0 ts=69f31575 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=FE2aYY5kXyuWuzusOicA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA4NCBTYWx0ZWRfX3JFmcyzQll/i
 4BR1XgjlOg181ydOQt4YpUw3sGUHapp5LqMbGUQVIUDXd0L0ImOwtpO6sAU9XTJDniLF60Aupyh
 5HJm8eAjtHatukPXkdGT7RPZUY7w69zs2PlwpQprUiCplYVNwUc0bzl9pDpj3YUE8nXDHCg6dJr
 K9QFX/KmdkltqA+2SNBDCX0tnhFWPM4HEx+HBXQwAOApGBp6KiKF9RfdclZ+FXwcQ8oKuiCv5e0
 q/FcGqvF7T41nx9tmhvlU1HvNUYJPZDE8gnH8/q+LMHlkDJ4aN2FVVfEBv0s2AalvvyG+q6WxD6
 L7rg29qSTSYZ8OuaTvwkroOsJxkrRfdGsr0JPwns0d51UWwHWfNofDtLxtb7MAfkdIloBaIAebH
 azfOMkxwhnwmkdodQUSFQzJiPv2BJK5968tR+EyMNdHTp1NQmu0qsysBmbEiVS1Nv2HReTej7IM
 XBzYF6AgKruoCTB0+oA==
X-Proofpoint-ORIG-GUID: UYMMYAtMMXDpqat0tX-ixsDXXbGFJI2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300084
X-Rspamd-Queue-Id: EFEDE49F51E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282711-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 29-04-2026 08:02 pm, Krzysztof Kozlowski wrote:
> On 29/04/2026 12:51, Imran Shaik wrote:
>> Enable the Global clock controller driver on Qualcomm Shikra EVK board.
>>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index dd1ac01ee29bf631d517c38486f6896ffd82dcc9..13e04080b37160129ccd47b0148a64277b8e0e4c 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1461,6 +1461,7 @@ CONFIG_CLK_IMX8QXP=y
>>   CONFIG_CLK_IMX8ULP=y
>>   CONFIG_CLK_IMX93=y
>>   CONFIG_CLK_IMX95_BLK_CTL=y
>> +CONFIG_CLK_SHIKRA_GCC=y
> 
> Beside some really odd order, this patch should not be needed.
> 

Sure, will drop this change, and update Kconfig accordingly.

Thanks,
Imran

