Return-Path: <netdev+bounces-209736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C282B10A87
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AB81889D55
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24D26B762;
	Thu, 24 Jul 2025 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nh1WWtEz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315FD2E36F2
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361270; cv=none; b=j+aM0xrTl0cFNlwLwchC9sjZA7A5iDi5FABPIMKMg+gcqD6QPCci+7UwRNW52uowC06AnNqFHDVblNuT2qjyyPZpcH0j967HmYjQ0wcOvP3EX/6yYfnHJ3dC26tr6v4GBZ0gxtiM83w82rzsgCl75GTA2npe5IZxTwaCq5EDgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361270; c=relaxed/simple;
	bh=j705TJQJk3x7OHyAVKzeGEgdS46JMPnBxolChxBMvjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZCVSoMWd8HNg7iUQx+mOcaGVcoShNM0inAdp6jqCK8XPqnNRd7OsuoheYwlC/bkvS6CODwXcGQCP9RCPgxeXAGkSrS8ZqYQ7hEzuKu+GpVTPynZTT4ad29byxIRzUr+1bHfqcHK5tqS5EyGYftQQ4blan4ZK5SeapLBccKsQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nh1WWtEz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9BI1E005800
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0FM2xPuyNBnGL8vNJqSnDEcqFKlOQpC0+BnPbT25j0M=; b=nh1WWtEzJEJ0nnvL
	24zfprhbqKdrDt1dh3kTwGPd8nZ53puQpkEUefg9sPjJf0NByZeYo1XmDDBGW1LB
	ltExW/fI2wfpHJbwQgpyFzTnGvNnM17peT9qtGshqZVlQWwM6ZMUeqIhfAGNUYxO
	JfYBDZwDHEdCziHV15Wi0SMH0eRdYfw5mtTxBncc+vGCfEBh/4gWs6LWO/g/B+1p
	VMDoWiTAsw1NyAAi7Dbs92JC/N1lKpQ1VbSZ1G2/sLFWkuoAJGWfNWPybtsnGItl
	YDNGurBRuQm170vTnnQwWlBaiukNZ1y0L/mQCacJH5ZF5XD08nxHZutQrHziMofR
	IKwkkQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qgrd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:47:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fabbaa1937so2656256d6.0
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 05:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753361267; x=1753966067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FM2xPuyNBnGL8vNJqSnDEcqFKlOQpC0+BnPbT25j0M=;
        b=CNyMZTHDGrh3y+BwJbkFBdjwI7x2sSjRM21+mUrcx7o+H8QTN5Ucztk9fx06YFYwzH
         spdJda+DnwnjW8Bun6NmLHJJaKoMvMdIYABf+vmAo9pqHwkGw03YRqIRQnQhrSxd1pZp
         yLTDcgFEUBAY5IX4ldYpjBaYeH3LPqsBCKHHkoev/5wv+Pifnqq8wT4GFFUdsw6+8Zux
         veqRU5nEDTQIRcW/uHYxfoUYjgdvSV9xuP0jr875hOxa2G/D67fm2hqpoW9TLLw5yOXf
         OYphLbogdpU+Bc1LwGE8qJxJIkXYgTFl8bV0aZWSA7HoAKQVqHOJMlYKQEYaY9nL+hPb
         ExHA==
X-Forwarded-Encrypted: i=1; AJvYcCVPLIoDbY7FK4aS7LyNuji3t366NdrFoLGTHneXuM2S/Z8kj7vUg5jzrwfXZKBWUYURoXyYEgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Loh27tLe2puYBat4VlFNwgQGxejML542GMUSnYhySr+IF90Y
	C8HRjv7jyn43YglD7zxbLyD3a8r9/Q88cpIoAoMWMgtNiSJrvboEcD36IoAmAJncD7nqDDqTQfO
	MITwsGDradF9iLinIEqUZalesePIJ9ViYibBH8sfsuBO3pQcGELg+KrdfJfQ=
X-Gm-Gg: ASbGncuJ5RimkX0Eh9ITnmizI5G82hboyE/49jSKfXMZeVGibNguPpePxVCvXwyMvgt
	ngmYbzrN4diThx8FkknSL7ZlT7ygjTKftltilEkZ4ngY36wajLcvhlfL374vBeD4tXjjEjOzoXu
	G0lmmyl79ikIC+M38J7RHYAwlgZDrEXcVjW7ItLSTP0TfsQCUSBq5mZciahqfz27/L5f8Fiurpr
	PUxT8vk6plTZP1gUfP0/3E3bgE4KbM9eayOnxtvj5D90Ev7JED0Dw92VgkXBjzV+hbbBGvm9mbU
	N/oTQ8ugprm6fxgDeXNXqmrSiHO+qhAULsABWmWESg33j6pNL8buvBKVwzvE9+qZK7++LsVA+Xu
	Mt1fP7+jFiNIdo7HEgQ==
X-Received: by 2002:a05:620a:2606:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e62a03804fmr308919785a.0.1753361267144;
        Thu, 24 Jul 2025 05:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyI2zhNTupwdsIDnxsXopNUvVOzCpZF9qWtxp5NPNExIrW5W6unnaR6wpmZfExbg7wpVtu9Q==
X-Received: by 2002:a05:620a:2606:b0:7e3:4410:84a3 with SMTP id af79cd13be357-7e62a03804fmr308917685a.0.1753361266512;
        Thu, 24 Jul 2025 05:47:46 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cd65089sm109986566b.56.2025.07.24.05.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:47:45 -0700 (PDT)
Message-ID: <159eb27b-fca8-4f7e-b604-ba19d6f9ada7@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:47:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: qcom: Rename sa8775p SoC to "lemans"
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
 <20250723-swinging-chirpy-hornet-eed2f2@kuoka>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723-swinging-chirpy-hornet-eed2f2@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NyBTYWx0ZWRfXyfvdlWqvrllf
 0xmPAGXtc7yQoxPeyAj3FqF6SGkTxvxcyhD4SrGbbzhPvm930dlF9wtD11+PfQaDYFhra/+1nRP
 xNFeIRgKHGSsuJCLT9+bpYJxE38Wjd2JXzA2q/nUh3qU0mEdqpbKlsBn5B0JiP7ryAUq7BE/taJ
 D4QWyLt6pkEAgU321MUdSUlO92mmnVrXiH9QleQPOIU9Xmyq3ouD9jL8c5qjzyUddWxf2E6RegZ
 bgUZEUhbm99Pt2y8ND1kfoqpy5TD2sUBTI00bE4LBGWv6ZJvdkJBUxgi05iPmfZIpe0zGSmZHii
 OK3S9VGu/AnputKA8/ufFtsBZZebbOi3bc3iHNN++1ODpcWjNCVBmjgziqgcQafDgG94n5iVrns
 J39CwSIQk0CdxTRaORC/Apa23tkGo1iKn89ztUU6Nh12JsR6ZVRmfbgmo3tlFYMgIRkEaxWC
X-Proofpoint-ORIG-GUID: RLHMPLLAZhfx2Fu6CvHMkSGtHEJhnY55
X-Proofpoint-GUID: RLHMPLLAZhfx2Fu6CvHMkSGtHEJhnY55
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=68822b73 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=yoiuoX9zeVfpJc3uYVUA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=870 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240097

On 7/23/25 10:29 AM, 'Krzysztof Kozlowski' via kernel wrote:
> On Tue, Jul 22, 2025 at 08:19:20PM +0530, Wasim Nazir wrote:
>> SA8775P, QCS9100 and QCS9075 are all variants of the same die,
>> collectively referred to as lemans. Most notably, the last of them
>> has the SAIL (Safety Island) fused off, but remains identical
>> otherwise.
>>
>> In an effort to streamline the codebase, rename the SoC DTSI, moving
>> away from less meaningful numerical model identifiers.
>>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/{sa8775p.dtsi => lemans.dtsi} | 0
>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi             | 2 +-
> 
> No, stop with this rename.
> 
> There is no policy of renaming existing files.

There's no policy against renaming existing files either.

> It's ridicilous. Just
> because you introduced a new naming model for NEW SOC, does not mean you
> now going to rename all boards which you already upstreamed.

This is a genuine improvement, trying to untangle the mess that you
expressed vast discontent about..

There will be new boards based on this family of SoCs submitted either
way, so I really think it makes sense to solve it once and for all,
instead of bikeshedding over it again and again each time you get a new
dt-bindings change in your inbox.

I understand you're unhappy about patch 6, but the others are
basically code janitoring.

Konrad

