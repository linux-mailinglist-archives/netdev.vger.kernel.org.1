Return-Path: <netdev+bounces-240527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA095C75DCE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBF864E29BE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3252346FB6;
	Thu, 20 Nov 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDuwMoq6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6g8G2NF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1233DECB
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661911; cv=none; b=QoIcy8MUBXm8XHv6Y8s86kFQ50e4F1if77ucXpdbNuKZdr1hlrpufX9u1O2wnt76wXAnnDTzvhLuBVwA5BDr0QYwST26KqG31fIcRQ6xniZTvgXpMbKAPecNoMwNyUrMkSpQpbCNSWmiI7n1om9885SQQJFv0DojZmdMH2acB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661911; c=relaxed/simple;
	bh=8Nk5GMhwXm9IMfM3G60BkyzEkRskrHYSLEa9yNbb4os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4IkL+lfiM0DlW8Zu+styzcxeJqu0XkV4RIoYl7uVsbSKvBH1KOffix+usrV0mm+U8eIhr25WKiuEarIL8HMKVlpFw3QByAZiYtbam1ws+v2F51dYwm3ja56P7he3foaUM12t95LfAKeeh2Jw4CUJ+3kaoA3XV9vQ+JoB1mdt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDuwMoq6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6g8G2NF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKAgHal417297
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 18:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JuyQcpZNlll2DkMsFvTsaPoccVC77T3rZPbIJMTs2D4=; b=iDuwMoq60s6wYUco
	8onsgt1l+VyGDcvr2kc5WJUpFbJaZlpkXaOajVcYXr2wkfcduYf4VMTdNBMvFMcv
	RsBlnNWdAzN2UEalw76NfUebuJUtY69dNZwWC8fhcVR1x7z9SETZRkfwecKIxWzz
	9P71m7KY8Bqv+QLpyfM7gyfst17O+OIM+w8TYLmER3srbiJK/RgGv3HGNvixr6YE
	9DJJB6wxygTYxzhNecdGPN9FvyloUFLu257zi9o+FtOqCLzRD0ewPpO6pM5mteNO
	loTp5zBAqMGyiIVHIVV44/L3fyQeLYhskeP5skrbK69tc5OkJwL0w8S8Fse93BlC
	mlu0Vg==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aj1fgsd1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 18:05:08 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-3ec76d47b56so1110284fac.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 10:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763661907; x=1764266707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuyQcpZNlll2DkMsFvTsaPoccVC77T3rZPbIJMTs2D4=;
        b=C6g8G2NFPWqtvQSvMeiqOOmaxNRB9SwFI9VZqKYbvaG2EbTjBiK24xO1QAKM0rRz2v
         /dKTrmFSUFbBao8oz8Z0szTY5KNvPeVJ6PalvqxkGznw6u2NqSCgEzd8u9QbSHXLFYPC
         5xjxZpAx++D9Dtq0PxTSmp3vTkbEHU4ftAT7DAF1kzZUp0g0xCTH21IGFJVk36Igq7bG
         WuvxAr8FU8JVvnknO8LvtqMaKN93pRaDYmQMHEZfkD99J+GGvYs0Zk+wLV4LVGtEsnCA
         BolpnRgpZxJuGhiWaIhfk/T0xmsHk4aoF7hD5EWc9mqmXj3jyhFYVd4q1EWYJZcslQ7H
         TqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763661907; x=1764266707;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuyQcpZNlll2DkMsFvTsaPoccVC77T3rZPbIJMTs2D4=;
        b=go485V6t8E7JzxRaNuJMiCu8qKOLOes1r1/LzV8evs/O3gWJBhzppsucOXtDrssEYi
         Em3z7hy97pIbqIqw2VnHgucZ8ZaSDLX8M5+nIpjJAoGi5ZVvSrEzLMWrE8yVpKmwnJan
         pwIOqyWl043+qmHITQHkoZfKR8eEcwWQ6s6OGcrcIF92ZkT5NwOqKXudK/kid6o7UgqG
         9xHUk2SuQUcRp8wAzBGvTgf25mLxTgrJBAT56N1N7+PW7s6QMifjgO/OkvdOgJFkv7Rf
         bXm6WND5J1HJc5aUBqct0xv7V5EHzolqy/TrWVdcCdlOY3jiSqmyTWln0FkYixjDxmmk
         uMVA==
X-Forwarded-Encrypted: i=1; AJvYcCX83+yiAt8j8vz0nMxHY2R9s4pa3/DoKj7W3xqb8+EINb2O9kh4FXM+s+Yy/FF76uZ2/9mEZJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3sE5NbH0W/TbSHe/0JwZZ3yOwKE+hbv00+SGHFzlpnZCFAS7
	wB0dQQbg+pnxi58CSGemHN1QpJ7RZ/YsalDC2bjHw/5oop+/kdp2cWFaUroDq5JDx9iy+lCwcjw
	rZhENOzTmcNBVO2D8K5PrO/wI3gApjcUR+fwHVs6Q+6uxMQDH4ylojbmP7hrSlO4Ac+8=
X-Gm-Gg: ASbGncsFtzBIiMSvG3C/UEOwYDj5Da4eREtZlrzJlfBLZNCwFIbECJFOfuHnOcX2UH6
	c/FJ07VQf0Gtp4Y0qBVhnvMSmhkOjdPfZqiDVFdqcseRYS0Tnz7cJNbEIR5AvyztOnadojrbPse
	TWi6mzKgXEgF87AiEDWfQjq7CGwL1S2zrd7A65WSjky6SP6KaKWduruFDQZQCwaATWzfBFiDXPU
	8RpcXwsWmSFjR8SSsvV6ZgFr9+FHZvbhLjL6Y1B0srsLoTuE8vwr2k6zTI5s5titKiYNIcyWVWM
	T6UL75hnVCfm9gfkuzVsN/4xDWG8FfFlYHeC7vQFp+NvvJTCNo0aLzYw7t4/awXvriputemY9Ou
	UWY8J/56dMfUVTSLNh1/qzXt342uCU1Se+oGaTWyckJv5Sh/UguzrTvH9BW4xjSsAYQPkAyn9m8
	EE
X-Received: by 2002:a05:6870:8904:b0:3ec:5ca9:d15d with SMTP id 586e51a60fabf-3ecb81acbebmr179317fac.37.1763661907286;
        Thu, 20 Nov 2025 10:05:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEd5oYmMj/INKleQZdyU+i6Z44oEC8iroO08qkoEl/5zRQjjmiIxz5eeEhp1rBkuV3BWRZMQ==
X-Received: by 2002:a05:6870:8904:b0:3ec:5ca9:d15d with SMTP id 586e51a60fabf-3ecb81acbebmr179281fac.37.1763661906834;
        Thu, 20 Nov 2025 10:05:06 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9c2cf16asm1489091fac.5.2025.11.20.10.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:05:06 -0800 (PST)
Message-ID: <69b2d01e-38f3-4a6a-a7e6-5d94d42fe65a@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 10:05:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2025-11-20
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20251120085433.8601-3-johannes@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251120085433.8601-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OqlCCi/t c=1 sm=1 tr=0 ts=691f5854 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3vU-vsCiunfMoQw1-XoA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-GUID: nUukdnD698YEnvvPCUM4zB6nfiJLs23P
X-Proofpoint-ORIG-GUID: nUukdnD698YEnvvPCUM4zB6nfiJLs23P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDEyMyBTYWx0ZWRfXw7XCMzOScvhC
 WyOJIFUr/3QnBlH1INZWLMCAYweTm5rcnI5eYH0jqqTHYZQIhBULFiIqe618qTBzLKRUS0pfqii
 NM7SRlVkcbqv/m1P+5lFK1IX6mqhXxA+Hq6r+1c3BYzArncB9CcjZiGp4dYGtFlVoDZne6MARou
 ZFw4wda+LID5wEFBMapL9tWeRTFX2Zi5yBnk21UqoVlfEJQTnZBaxK87YLVOnOW/bnWsqlHeaVJ
 D/2Qx5wnI+HdwJodxXaWSN6PiP0RTRSViy/Awg9osUuwHy/nbp8S2+/4Y1uw0noMF2U1tN/naQZ
 9IMO9rC1Yw+GbCMg4kfLOXNtIaWdeVZy84y1D77gQIeabxjI37kqY70bymXQYhOyqqFiHzzRcnr
 74Rryks7DfsJ1rPflQ/bzpCt8sae1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200123

On 11/20/2025 12:53 AM, Johannes Berg wrote:
> Hi,
> 
> Looks like things are quieting down, I fear maybe _too_ quiet
> since we only have a single fix for rtw89 scanning.

Isn't that the way it is supposed to be heading into -rc7?
:)

BTW internally we're finalizing the ath12k-ng => ath-next merge.
It's a non-trivial merge of around 100 patches on top of around 60 patches
since the branch point.

Current goal is get it to you next week for the v6.19 merge window.

/jeff

