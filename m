Return-Path: <netdev+bounces-209776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4589B10BD7
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8DD1CC715D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC92D8365;
	Thu, 24 Jul 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJ6Ti3aK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38598248F73
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364930; cv=none; b=Hquq0GXYrqGjkhfyZxKdWZleyIq7iUFPOrILk4zI7QtllfxWKG03TMEjqehDx1YQ6Eu5HZf1HekVUu7GQboQ391exsLRhs9HwkgEX3uwUNO4eEA3lGqZr6INQ2tq6sznjOmU52qFLi6Quj31+BblTybjWeaImPoLadz4Pt7Kl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364930; c=relaxed/simple;
	bh=dohAmmkKZsPbPh6JXfwL4x37QOcnoLN8mLe5LMh2YAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRwpmkIEJT8hD/D3pQSQSQzSUuIlHmh3Q/JMTt9siLTBkELZQl6BvUk4PjUQRwcOcLu4C2y8cygj2/w0Gwjn1EbSh1QRoTw9yJISJRPrpIiTJ+P079RUYbvkxIJas3DKHzFg3rCoXsSvj5iQ+X+TtnDwPwsBD7vmAM4ZynSoiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJ6Ti3aK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9W0iF011445
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rGqrP/aQVaXySa58Rt8CvoRFTXgwU18B9470T3EO5aU=; b=UJ6Ti3aKRzzekPJl
	b1sq+Rc+0ZFTLYRdeTzXzhrCTip3KdOWL5ydHHzs4n7DEqlewhaMViPKWvDe2KuE
	IgRohc7vHdKXfQCv9dOn1mGk6t1rAWr9xEoYQ1rzom36fB8xkIoftBWlFmvmez2s
	D8bUu1wigpI6a8A6cin8BFiljuBIX1Qh0UcHT8lEvJD+TxFLjGCH+KUcIC2ClKIp
	WQyo+jbMxem6T1cnFlDKut2QUn+vWQs8JH1t85zw/GU1ppVxomnYr6CRPDDBBUpH
	r0PFWmdwlrPKixmK3JKsJjn2Ue7HmWI6ZGkBUEYx10/KY8s50ZHgeCHRkphP7KPT
	UxKtEA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6wa2yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:48:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74b185fba41so1003959b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 06:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364927; x=1753969727;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGqrP/aQVaXySa58Rt8CvoRFTXgwU18B9470T3EO5aU=;
        b=AN1QvWiJKUpWBSnn2mUJ+s41TFfZD7c8qFllsJHHQ9llm/k0z4N4aX81Xq9xLG3q/I
         9jrTjSNHAbDls3gtq83tD37+11MQC75W3071a7f7gU7zoZluXxw0frvz1LIGT5XhlLvu
         H8q/ik2qHufEi6rDLhNMF0Rwwn+CK4UKbK6Ps+JcYgFzDbGidrbITbGkcFoOgC+zAaKu
         pRB/XYTtRjid2mUcxTJ0/UK9eZm5dFaCVaoo7B8ywbHOCOSlwkxhgtuQBJJLZvKyMW+C
         8r4Jf8A9lPTH/jcoZaWzcI/ezbSwOeRrJACnahnaQyWvnUX/QZB5s38HKXqdLI/klto4
         9SQw==
X-Forwarded-Encrypted: i=1; AJvYcCVQHkghXtxLxmugW+ttVElmXEcnCxxfe+9GS0vvjmaRFZx/E/m6u5gUsc7qL+3HUpYF0wYd35k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWf7AD3oiOrCVy/nRJbUDiaqGrw0DNzag7vOFabki9HqtkiXsT
	hccTMBJhQf2SEgw+B5ZPfH3iok+zg8/W6A2ObvfQzmHOzMGpTsgRFPpeP1GQX5KlMH5+4cyzVJr
	okAMscXY88NNYTjcaRG4hGugM21KiQ3gRvADfBb3ee/8EfI6oWN7vhbP4/78=
X-Gm-Gg: ASbGncvp4NYqoJN6tTCN+rfVZ4Uk/25MqAUJMmFMC7/W+tSNfcZzl2j1oKMm0f1wcdZ
	6P4FrJDLiKgbhjHbWvV2su/Esxc55GZFGThLTNHWtic0ucRE8NM0K33t93fN3+uxcur1lJqxSSq
	j8cruWVEW3WSdlhSXl08WO1hUz/IbUVcNlvUUCC50pDyHb9nhUzUFsL5rCQHQtrP9p2nShdXoMe
	0oOrCqR38muHNGxO3HmBfVdkfbWNoDfvJqhgo6sfFzhhoQ2p5QpoOvP7kANdaDnVWceRWjcZwcE
	z5YBiSas52oqcspPbbYXiSnbsDUo4zclKg12uYz4r2QvOPRRHwXJRyCsVniI6X0sTqdSJIdR88D
	DXbmTqD+VFb2v5OpZ900=
X-Received: by 2002:a05:6a20:4324:b0:218:96ad:720d with SMTP id adf61e73a8af0-23d48fa6829mr10616820637.1.1753364927412;
        Thu, 24 Jul 2025 06:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpMXglJxY9355KWoyV5236pDrOu8pQnRf7U+5SAGv42cxvOZrorpf9pzeVf+kpJ5Hej2ZTpQ==
X-Received: by 2002:a05:6a20:4324:b0:218:96ad:720d with SMTP id adf61e73a8af0-23d48fa6829mr10616782637.1.1753364926924;
        Thu, 24 Jul 2025 06:48:46 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7c079sm1756212b3a.26.2025.07.24.06.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:48:46 -0700 (PDT)
Message-ID: <0083826f-f58d-4df3-ad93-52adbd162c01@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 06:48:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL net-next] wireless-next-2025-07-24
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20250724100349.21564-3-johannes@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250724100349.21564-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=688239c0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=2Dvxz2razoWmXKoefC4A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwNSBTYWx0ZWRfX/Js1AgS243aL
 Wc8naTKeRC/OfrhmAP1USQ6A02qvGRjuifFwc1ZqiiG5oCmfVHRCEVqJI0jf0GsYqiayaA3s7sT
 HGTAks83AtFyfHPMklEr8iWg5vluEEByM+Qyf17c7kRGeNA58uNcT7SFzLIXllrltEylpmE37pw
 6LkSDCxEZj4sPmBQsW9Hi9rEyRCasTpYuKECRbUrIhRhT6NFuprz+T21sc3dlDohUx0xXGBx7UT
 tODbIf78PYyD1oxRijdOQs6myXQmqkp1roT4JiaJ3hkNfhDNPrhh/csSHsFn5RDmBj/Y/u2FJYT
 rTRz30MH37tKWG9/GL5GkGXM2foJ34zR4K1m5H8L1BhnbR+5J9YL+BXRmFSeWPxuNWh0lXc2Yqb
 /ZfbH3EIg2ZKL+t4/CoGJFHWLtBYTA49qsW5qc/Bv6qSflflPb8mtxKG0wiFwPcj3xyI/WGJ
X-Proofpoint-ORIG-GUID: u77GVTvnOpwzFSAiM8mtut_i3hDhAl1r
X-Proofpoint-GUID: u77GVTvnOpwzFSAiM8mtut_i3hDhAl1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=979 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240105

On 7/24/2025 3:02 AM, Johannes Berg wrote:
> Hi,
> 
> Here's another, almost certainly final, set of changes
> for -next. If we (unexpectedly) get -rc8 _and_ there's
> something important to fix immediately I might send more,
> but at this point that seem unlikely.

FYI if there is an -rc8 then I will have a few patches I'll want pulled in.
Trying to get as much into v6.17 before we start our big refactoring of ath12k
to allow it to support both Wi-Fi 7 and Wi-Fi 8.

/jeff

