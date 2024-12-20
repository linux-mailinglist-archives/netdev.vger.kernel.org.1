Return-Path: <netdev+bounces-153684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015079F9337
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0521883B8A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5B2153E9;
	Fri, 20 Dec 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKW0EyTr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3681CBE8C
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701165; cv=none; b=ms0CuiBnh/i1BGBQn8eQRX6nrEW+12m8xP/HDuLq02alCuZWqnLPEYl05qS83T/gR73a7oJIAFuCo3bw7/7CV50tGVWFCypTaFUt1knHRXabp837A6aRRBGRFe0iATEwOJJoOJN1wfu40ZE65y+/uQHIOL/DV9CC4I9uvYfY0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701165; c=relaxed/simple;
	bh=n4pdjIE8wk6+RrT25j2XZ+MN5qzobRKdoai9EioUYbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnyxo6S3iaK4RxFRUHRgMR4u8UmyiQag/2FEAC7j+InqxQOMk0FLYqy7JdGhdzHU7HycZoRSkK1SsznOPL9dmno6hUawyHpbaihdUcdQ0+wgo95mJIF+z1iGYAqLuKLmYL+v3NzTlcYuN0KNcuxrOw9tg22bZFIJmS+e/pZQVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKW0EyTr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK7Llj1028178
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1i0DA82kkn8WuMBOuii7HiTKNDRCyKMaAec5At2Bx5g=; b=pKW0EyTri/sXirk8
	DqTpbTjast0OqJWtHVOIjLeWwU0zch1+6n8TCbafhNcaARUr1tW3SV3a0WCdVkte
	mAjpydCR0lnLDoX9amtfSYmtP0twAEp1ddHWC+yu7J9U5BKCuRKnRRdUla7upPYj
	BnlQnQFOz24VZORjj3i8402+5xnUSe2ReCgZU8YbfzncfeIib5VpreAUiirppin/
	rBvnS4X+5D4N1iXPIH7kKIHAFaKQdr8RD9a1DBA10k7X2OB1Rjg+A2MKYl6mI06i
	wpAGuarPOa6Jh96o1ysoaohtqsxlhFDW9hBxYEwWrzTX+b1C2bMAkMkhYXiLT5bJ
	uWacAA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n44ggwt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 13:26:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8824c96cdso5718816d6.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 05:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734701161; x=1735305961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1i0DA82kkn8WuMBOuii7HiTKNDRCyKMaAec5At2Bx5g=;
        b=AJLhpnwd4kms2Rx2p4ufa99kCyf2dUM/3bYD+lhph3TXZSRZJUGIu1xQ0zB8xHfTDA
         fjPDVz0SsiwaQZ83NZjeG4OlIV0aIOehAQuiOQqSolzmH3TPIpzGYHcys6wieP+qULW+
         IWaRpejDoo0v1GoEtFIkPfkDPEkfiTkJRqVGW7tiq5glscEdkfenDxD/6vLrUWaU+xLL
         b4C1zTmS9f/u5USB8gEQHBnMo9HqXgEyvzh5GfRcOkwJWq1pPZM3ez+CcjcC31XNQ4Ic
         PJImB3DrKBjGeMns4xFXOxxBgpCrp0MM10rNRt4mNMygMqsV2sQC9v7ko0bmWDL9lwMe
         ++og==
X-Forwarded-Encrypted: i=1; AJvYcCVH6Ej6r6DBWHXrRInOmfsbESe6in4J/WwyJ+4OQpF9vsjYIf9xsu7Zn/YovpQjg3rcOw/3nIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKa08JqsSkjKsC9RtfRvevX9VmBoD5y2COEQfvVGhkFamEukX
	Mzda5AO80m4PvT2lITEqOZWqmIreB2kal04/ycr0byhoLmspYJob/WRRz4xMo8ka0/mLvXt6mVq
	Sid9k4Ba7XiBTLYq1NP0jUIZqOSqn/ZMV0hQP/lAXHFbeZMOcqPJY3aU=
X-Gm-Gg: ASbGncvrYNHbYsH+SYibHspUD/ikPWLr9CzePBItyTXgpNRPrpLcLF0JSOlJ9xKmsBz
	ezOf5X5OMntutu6vi38f2xNaMtEZ24DFIydl0fRZE+HAT7Au6JKstzwGyqHAS/egnabToD9NdYR
	kUKI8PFe7ptncTwGBx6AOM9SngouZOjIxRge8KnX45t9qSCvTzJ/jhEDovENw6c+ICBDqs3/XB4
	s6jybt7ZKpymtfwaXQGS6GMjZrcNVARRyNS8uEW4I6VpZqe8qcq5q8fSAokr0LzuKwLCKFzfj9X
	265HaFjKxIBYsfLxSJjcmIdikomLnsu/bzA=
X-Received: by 2002:a05:6214:5504:b0:6d8:8283:445c with SMTP id 6a1803df08f44-6dd2332ec62mr16425036d6.4.1734701161299;
        Fri, 20 Dec 2024 05:26:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkq09EQ0ae97mVq22oeA9jfGWGDmW+Y+xZX/h1a5jnx6pnSBVt7BZ44l6VTdHgTK4Dtqih8Q==
X-Received: by 2002:a05:6214:5504:b0:6d8:8283:445c with SMTP id 6a1803df08f44-6dd2332ec62mr16424876d6.4.1734701160960;
        Fri, 20 Dec 2024 05:26:00 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015270sm175995166b.162.2024.12.20.05.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 05:26:00 -0800 (PST)
Message-ID: <7d33eed7-92ba-4cbb-89b0-9b7e894f1c94@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 14:25:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,ipa: document qcm2290
 compatible
To: Wojciech Slenska <wojciech.slenska@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241220073540.37631-1-wojciech.slenska@gmail.com>
 <20241220073540.37631-2-wojciech.slenska@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220073540.37631-2-wojciech.slenska@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wQKvRt8FjC6DP7YYQ8VUmLTHigmT0xE-
X-Proofpoint-GUID: wQKvRt8FjC6DP7YYQ8VUmLTHigmT0xE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=955 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200110

On 20.12.2024 8:35 AM, Wojciech Slenska wrote:
> Document that ipa on qcm2290 uses version 4.2, the same
> as sc7180.
> 
> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> ---

FWIW this needs some more work on the Linux side, the IPA driver
currently hardcodes a reference to IMEM, which has a different
base between these two SoCs.

The IMEM region doesn't seem to be used as of current, but things
will explode the second it is.

A long overdue update would be to make the IPA driver consume
a syscon/memory-region-like property pointing to IMEM (or a slice
of it, maybe Alex knows what it was supposed to be used for).

Konrad

