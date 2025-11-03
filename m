Return-Path: <netdev+bounces-235102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE27C2C001
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9AB3A66AA
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF13043C7;
	Mon,  3 Nov 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3ErgN6d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UPrUUgYo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86630CDB6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175067; cv=none; b=BhPpffZ34JWPloBgeN5MAGeqO+rHhlFyamzzQvi3eIij2fX3nYO850sgHssu4kO5jUGWqbmmit74rkOFEIsTHQEI/t94bAauglCC6y6o6DIgKUcAl744e90caTrgTP6xC8q1hv1BdVwBJlPfARRxbaa2xnzhF0VDyFmjGSxyoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175067; c=relaxed/simple;
	bh=3c54EP5IAkw52tZkzmTqv588mC9yLN+3CNs3RYEHqZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsZxAwgOTaMvM+hXOM8KbR+1hxbaol5Lcq7m2GrRS7n1Yrth/wMEBjNepAzR+3W6yV5+sJ/dDjKxLBYUlBJ8KFb4+HxTp6yEiyjbOBr3bkYLdqFWTuo4qCmBQ54ATtiFwNiYXPjpTH4LHsn63GE19I2zGYjVJ6cMybubU15UZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3ErgN6d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UPrUUgYo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A368YC12269733
	for <netdev@vger.kernel.org>; Mon, 3 Nov 2025 13:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jT/a3Ji9mpcq0m1ZyxECMgjBQ2CkfXVS5sNckHRxbyI=; b=Q3ErgN6dm6gSmcE3
	m+ljPGqdES1WAQJSF6rn7b5WWD47JUj3MX28fHyWKitTt66k0OvjK4cYQPgYQuyR
	NMalKe3qYa+8uiS5ZkUXC8bVF+9JXWweC5l0/R5fk+qU6j0/Ga71x+4AFj58nxMQ
	f3S2Bq1zeWONE/NgyG1qiSAoVD6Zqs1skK+cNy1mU7YqTjcpivSCLAvUR4HUGTRn
	fk87hqBGukyQdHhnJdq1HHum91uHL9EXxI00bftl2k6zUE1UfVt1hp0qyt1lMNG/
	L3gnuy6L7PSrTngDe2RpjiQYhcUAOp4FFrpE7XJTtd1M5FrWDuvven662KbToB64
	GIREKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pv796ay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 13:04:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956a694b47so18452665ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 05:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762175063; x=1762779863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jT/a3Ji9mpcq0m1ZyxECMgjBQ2CkfXVS5sNckHRxbyI=;
        b=UPrUUgYorSB2v1pvBAEb8m8F0DaSx/DXUoopclc7RhZ/+wm0X0RO1YZMQNBvfCnb1i
         wXa+cwWP/d1Tvq0t8WLgOacPziqj2CLRto+ygI+sNeRqkGfVpH/qbl44K6G3pxnlUo5V
         lyEAxXn3xi5P6s4VV0QWj4UMkvTJ05mEKaB5a0LoYUkK3kCfverbQc0yfLU/2gnwGJqr
         RiMIJ3wccHEz75wOw7uwfjA9BBGU1Nx++DjK8+lPsMJY6XMacirqAD2Pvu4pl2mZ5TKd
         +M+XnEIN/sKySje8lrSVdP1G+RYrvo3YH0kuZhgIoSamconGVKBpYMok0dpI9ug3bv8y
         1rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175063; x=1762779863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT/a3Ji9mpcq0m1ZyxECMgjBQ2CkfXVS5sNckHRxbyI=;
        b=a94KtdJOLAnlhLfLMO7pbbqq75n/OASfWNbY2NVGIBRnHVyLhlc8bAPubudYkASTY7
         pFTjPtGDYWLCABC5gFdW6gFCBWdH8rGi68/7oO4QUIYeeIKps9ClQfBAFtDCdQJL6cxF
         XlXxtUmomLW/egoHekFk6GnlxGxYhcVF+KhojkspOS+Yjj352jAQebAkMZJO4LKhaeNa
         8OFWLd7o/5O2ugutryQsOC8gofXyjbnOL++VfZPBwRssYvWpLvtFRsAcMVelPovpdfdI
         QFN1huViJiXivt/TKKF5TVYqWCkhb+73UJom0Dh1yZLZ+Z/l7Jd4NTpFYHY8rXRDCZRr
         4ClA==
X-Forwarded-Encrypted: i=1; AJvYcCXqH/5V7NCRM8KKPj0qvuWxVaf4pNfOT3W3JTYE/Plk82Xev4v5ZJmuFEVLKcKLeelnmvaD+h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRsC3VGaGHzYyIDG+oYU6HSLwkLkItJMEAtBmptGu03Kq+y1q
	Xs+9XE8cO7laKHwHy2FLBEsYB3x4Vz/06sSj777o4oPlYCPqIxK20qgtiVvS7hK5zB1wji3umF/
	f+gbfNDtlthjXpYnd+LRSWEgieMJ5Zrv04FU6f7hdsqYDsNyqA7dchXbGCa0=
X-Gm-Gg: ASbGncvobaNzdXcViCJHvib8447jp9iBv8bBlq4kvY7WEmCWfgZi+NZdgxcHFFIZSIF
	8wH+BDyxa7f6TlZx811dVZAJpsdxH6VPO4MK2U3e8G4/GdhkvKOtUSsMcPfh5MuUCURSWbUqJXL
	MZot3+FA+laYL1J3hGG41LW5T/L5SK6sGBYYPjFzS9CJrhn9gilDq118HY1SRAQN5TMmpLeD7un
	qouO7KITgvhsm3heu8AYjuGykPGL8nWYVaXdaNVgOLrap2yzE9AMDiyzRqZTr23+BXGSyFWbvYr
	rijRkzXDhahUtcqs8WqLJsKMFf3pI/NLPKOsSr9l6g0mlmWOfsFo2MDq0eNdXVsDHtKZ3yLGTR3
	7HcjzMcFlDQJ33Ys6vQHGP/Y99et6dX1PeHi0XBScbNbvZin6KZJH9XNHNvL75w3MYYc4Bg==
X-Received: by 2002:a17:902:ec86:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-295b46fa745mr36867505ad.37.1762175063157;
        Mon, 03 Nov 2025 05:04:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz0jwlEN2SbqhNT4mzZ63FJUWWpupWmg4sZ2wmy+yOiJPvDDb2lPEamXhnh338ITlESy3nqg==
X-Received: by 2002:a17:902:ec86:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-295b46fa745mr36867135ad.37.1762175062590;
        Mon, 03 Nov 2025 05:04:22 -0800 (PST)
Received: from [10.133.33.69] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268cb73dsm119737495ad.44.2025.11.03.05.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:04:22 -0800 (PST)
Message-ID: <49b46127-f74e-47ac-aa4a-e5a5bb013e41@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 21:04:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: ocp: Add newline to sysfs attribute output
To: Jakub Kicinski <kuba@kernel.org>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
 <20251031165903.4b94aa66@kernel.org>
 <aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev>
 <20251102160028.42a56bfb@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20251102160028.42a56bfb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oshfaEcYr9sKsvDHxONJuEE4cgvhi81v
X-Authority-Analysis: v=2.4 cv=A7dh/qWG c=1 sm=1 tr=0 ts=6908a858 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8BO9zW7oIjHPe6O9FGIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: oshfaEcYr9sKsvDHxONJuEE4cgvhi81v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExOCBTYWx0ZWRfX4o0CQl/nBx5m
 Sg0bU+8HYymJ8IqhRv4XLozWEGxVVxwbB5eW6aMqG7bFXVhXlTNYKOR+nludYa81gRZiQWqF4Vz
 TzRSxPsPF8PNpqs2gvZN4uxtJUjo12KWeruccoaKxRs+OIJQWLnzbj2FKaMrSPR+75jV8vkkAoZ
 bCn7GklSuCeuB56yNpJgfTbyeXc8jXgiLod31WqZd20L9Xc9asir40/i54AgYtrwac8plWPbr6d
 dYWHxvKqOiuGa2BDV2opiC/6Gwze/ytYHSL9qY89GoLOqZsEgdOWdjJFWplWKMtVVuQM0Pp7dHR
 1L54CPkdc+DbEfF+CG57LezeQ6pCNwoPw2ms/JpmYjBE/ZOgeaRechCKn9lmCXFb+k0/bMI1pAe
 hM0JfpGIy62/X4Zub9P4sdJxxpj0Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030118

On 11/3/2025 8:00 AM, Jakub Kicinski wrote:
> On Sat, 1 Nov 2025 23:45:00 +0000 Vadim Fedorenko wrote:
>> On 31/10/2025 23:59, Jakub Kicinski wrote:
>>> On Thu, 30 Oct 2025 20:45:19 +0800 Zhongqiu Han wrote:
>>>> Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
>>>> This aligns with common kernel conventions and improves readability for
>>>> userspace tools that expect newline-terminated values.
>>>
>>> Vadim? Is the backward compat here a concern?
>>
>> Well, unfortunately, this patch breaks software we use:
>>
>> openat(AT_FDCWD, "/dev/ttyS4\n", O_RDWR|O_NONBLOCK) = -1 ENOENT (No such
>> file or directory)
>> newfstatat(AT_FDCWD, "/etc/localtime", {st_mode=S_IFREG|0644,
>> st_size=114, ...}, 0) = 0
>> write(2, "23:40:33 \33[31mERROR\33[0m ", 2423:40:33 ERROR ) = 24
>> write(2, "Could not open sa5x device\n", 27Could not open sa5x device
>>
>> So it looks like uAPI change, which is already used...
>>
> 
> Zhongqiu Han please consider sending a patch to add a comment above
> the unfortunate emit() explaining that we can't change it now.
> I get the feeling that otherwise this "fix" may resurface.

Hi Jakub,
Sure, will send the comment patch. Thanks


-- 
Thx and BRs,
Zhongqiu Han

