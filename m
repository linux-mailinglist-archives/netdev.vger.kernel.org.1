Return-Path: <netdev+bounces-193130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45380AC2966
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D048854337E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89ED296FCE;
	Fri, 23 May 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/pjEece"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A029827B
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024192; cv=none; b=p4qXe+NdUVLap7yVvNKa9JN90vQ7S+hqRV8Mg7EghqUKpD6A1yji+2HJB9RY4JqSDS4Cl0qGycHYQH6qsmzrXAsIojSaS0O7v2atBXDRA/hI+Pq8VZupCL+wqebVhfnZUlqrLJTpsVRCIk0X5Z5pJ1QesJPNCa3atR8DFEG0QA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024192; c=relaxed/simple;
	bh=AoLJkqZsq5uG5046rJ0/zN4bd7EWkUTOqm2DlhMuH94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIJcrLYBprFEEgtqxaV1WeVyIRa8IsAFm4NMHvBR0OB7BfzLqe68YzvwQXomw39S44M/XqzsRHwxucdghllJPhdLojJNSlNuTaBce7yT6C9bpLwP/u4VTnKv6HaIYaPuyrsa6wsqVA6/ss+7zCjurQ2pTfHIo5B2uD6mDgm3Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T/pjEece; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEZ2RQ000836
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ywgBAXOkOYbHHKdEyT+EsdQ0pIR0wBE1gOJ71wdz5Y=; b=T/pjEecePLaEpPhp
	KZb2TDjsBd9cD+AwOu7Y7XQfZkyER0KHL2p2xT1ZngK5dfA7P5WNWe2YnM1DMJPB
	AsDH7rQWhcIOO0fGPL10BO1X02x1z+AeW8mOqPEe0mM0fa7MV+7CPGRSP3TZ20b1
	DtPtduEcyyPJRO/bUZCeb76yII/gSB2S4z7+haGXmm3srbP9irifBtHMe9R45DYy
	aNjyAboRJ3rSBR3+CtSoDbwwm8EnBsvOY6J5cDEveleWw4wBZi3t8+nkEuw7OqQV
	FeRBcCmEe+d2UzHVXUux0JgMamnZqPFjLUqZ2ZnSrvThI34/FLU1VYIJzKQNcEjI
	NumUOg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf72ptw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:16:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fa9132430bso189256d6.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 11:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024189; x=1748628989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ywgBAXOkOYbHHKdEyT+EsdQ0pIR0wBE1gOJ71wdz5Y=;
        b=mux3oXRmOytbBdybu5gtdoCeXTLru9gQwSMutYZGzty3KTPAtArC4b1Yx2BtkguLre
         uILqX4DBT1bOFHGWTO4SHwTGKZs+aEriOdqyWlCIIbHAf9OgQbpZ/oYvmi5P37ZBHsZ2
         faxC9vvRTyXmovf9BYuqVK9UpjesW1eblxX0WRnI/HziLODTtaz47/l7LNcMzYR9eemC
         +GI8EWxYaZy2tYNIlPESChTWN4mNZOjuK6civq79/dEPbd8/hWGwuRFLHhgBjgQOSC+9
         zmM/c5+P71/8+xZHjN92Zt0OiEgJkwl03Uh7WEzF3mHRM+PjuPOGEZuK5Oyf2HDDMxRG
         6Hmw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9uE0wEK2Sv3kRu8i70rDOTocsl5FVdggs8g+adzhvZ3dlNxJfrE+kN2FZuhAf9uVHdbZiIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2V+BcQmmEsoJVKrks33Hfi8ujBu/QD6GaXVZYhOyh7mkeaKsa
	u+riRjyYw0ks5lCvqjqX803BHRJiQJ7dgRkRyrdx+BsQipGsvM8EMnw2l/y+A5IhZqJeITszWKU
	ogl0EJ5SLEppxPMGcCy9n3bXRJv5+JYkfIzpv8wkZalhIhf5Gw3BPnx/qwM0=
X-Gm-Gg: ASbGncvuK1cySd3Fs6a4PIQ1tnVHnp6Vt7PRDny7ABkYiOxHRPJSzUFldWSK9TjXp4I
	545xL3Kost9DRIeetk26lMhPuSPb5ID/YyR7Vwyu3NF19nOgHiv/8QkMyd6/mGvKzhOqyeqDjzB
	ZtDutTD0vali7PwKO6HZR3yayxz13n8OmFR2t2f2cIjbBo6PCaGDWzcmHKjD3lgUjys+lCNvDeR
	fDAgkiScKTEK2K08RBut8TCzJtpwwiDNFFjDb+64jB6OdA2ytQPH2sMy3SMJgOTrvbwfQdhsAiN
	7Bcoj+EO+dqXhnQHhNmH6gR7otCkyK5mm4BLLMiwTDDJESt6pfchk6YaRGTDFvoDjQ==
X-Received: by 2002:a05:6214:20c1:b0:6f8:c23c:526b with SMTP id 6a1803df08f44-6fa9ce42c34mr3062906d6.0.1748024188639;
        Fri, 23 May 2025 11:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsNA2DnPdEjRLVO+yqAXpSZSax7H9Q3S9aSImMU03Zgx6k5+e97rYhPOTC4edA5uBZBYNrAA==
X-Received: by 2002:a05:6214:20c1:b0:6f8:c23c:526b with SMTP id 6a1803df08f44-6fa9ce42c34mr3062636d6.0.1748024188206;
        Fri, 23 May 2025 11:16:28 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4381d5sm1290113766b.99.2025.05.23.11.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 11:16:27 -0700 (PDT)
Message-ID: <d0b2f237-b4a6-4ce0-95ea-4bf5f3be10e0@oss.qualcomm.com>
Date: Fri, 23 May 2025 20:16:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: ipa: Grab IMEM slice base/size from DTS
To: Simon Horman <horms@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        Marijn Suijten
 <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com>
 <20250523-topic-ipa_imem-v1-3-b5d536291c7f@oss.qualcomm.com>
 <20250523131744.GU365796@horms.kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250523131744.GU365796@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XABKLYsy0ASyMbM8h1YcOKThaCtgLbY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2NiBTYWx0ZWRfXyS623e+Usgen
 y0AY4vyJIZ+oNgYTNp2TfPOq0mcLYcSaMzAfFkggh9nSSvuGWGry1o9/3lyVFCpU7eNKNN37RiW
 TFH7a640fbghdZciSvjJ3luaNUN7/H2YQok6/o7rju/Po1FIWywgXRfXiX5y1j9Zaq2ciMVAcP3
 Dt7ZOC8oM6neuy3AQ+NayZRwRy/tg6LKsYJ+ThCRU1cFYWkH9seWeC3FbFxWqFyfhvj87O7PGmw
 k+faFErrMT/AIS0bsxL3kATTl1jbf+ny+rx8e0d8UCgYJkLqQOGLYOmfRl8ByZ3EMTBiUWNk3o/
 EsrylULoiaVt0oQxxNvrm665rCd2YE1i6vODd4JJOoIDfTdhG7NoqvBSo8h8dpmw5nGcVE6u1Hw
 9jyBWP26PwOPwYx5kOVaadJlOGLFSpZjOqJ2vue5UX4awVFDHh6vfxEP+na7CH4PQQ1pHIXK
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=6830bb7d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=SHaX676KDxSdYVKYG_wA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: XABKLYsy0ASyMbM8h1YcOKThaCtgLbY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230166

On 5/23/25 3:17 PM, Simon Horman wrote:
> On Fri, May 23, 2025 at 01:08:34AM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> This is a detail that differ per chip, and not per IPA version (and
>> there are cases of the same IPA versions being implemented across very
>> very very different SoCs).
>>
>> This region isn't actually used by the driver, but we most definitely
>> want to iommu-map it, so that IPA can poke at the data within.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> It looks like these patches are for net-next. For future reference,
> it's best to note that in the subject.
> 
>   Subject: [PATCH net-next 3/3 v2] ...
> 
>> ---

ah, the networking guys and their customs ;)

[...]

>>  	ret = ipa_imem_init(ipa, mem_data->imem_addr, mem_data->imem_size);
> 
> I think you also need to update this line to use the local
> variables imem_addr and imem_size.

I paid great attention to validate that the data I got was good and printed
the value inside the first if branch.. but failed to change it here. Thanks
for catching it!

Konrad

