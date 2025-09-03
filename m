Return-Path: <netdev+bounces-219598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF542B42338
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B7217C672
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A430DD02;
	Wed,  3 Sep 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UI7NxD6+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9B2FF673
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908700; cv=none; b=ZbB1ska3+ONjM6/83m8NdJ+DOCm9lVv4xZ9tB/KJ5okOaMnm5GaI+LzslD8KJHB5n+xOuLA3q8G1kmGmazL46ifezHolELVS85Xmo47Brpc6BQrgc5c1UBzj3X2AEl/dV0YHKqmD2lYb4bA8jJHeOCOeAjWfmqI0RP8bX8bqquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908700; c=relaxed/simple;
	bh=54Lc1RXv/PBEmC75zaShg0TPfNoapxkuBuXgBpJtgrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNmDzZKa4J6su4oGYD0tURnp0z3n0Klf5apYRQj/UOmO13PXAuuAS+wEFzsgPQhEV9lFOUZJMOdXyCW0i2C+cIdY8huz9oUOeyiSP4329JdFYyX9hXZcnPLB9zz7OxDzJTP3u6+vIcEFEKSXCkzUDXyVEX2enpJTXf+YzcUToSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UI7NxD6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwtH5032514
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 14:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VKt6Z8VLaY/h+/FgT4fSGVZAXoNNB+wOFS858h7LM8s=; b=UI7NxD6+b5dQPj4z
	tfnnrWIbZm9enboL1VOsEm5GbZh5HSotJIpQAduMFTQKRabvNErA5E6BhLoPb3wr
	kurthkE+W53N5/J1hs+IkryVrboDEe6OOKgb9ivrIrFN2653a45kItfax6kKCwwZ
	nMRulRK/Uv2rmIYBJmOuH6S5IgzR6kHlHNPmsMks+Wu6CKA48mz0uK2YKehp7CDi
	1BBlygpBw8AH2+pL23x5fWfJxn3B6yRqwnPVLCuTYdRlcZe5LvKCChiXKphS5FHO
	Lyp2PhQy+ycNsRMHvYeZj+dOuMrT12sS4F9AI/yWsYiaHZBsiX3c60RBibIUaEay
	VXc0rQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33u5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 14:11:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24afab6d4a7so42270175ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 07:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908698; x=1757513498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKt6Z8VLaY/h+/FgT4fSGVZAXoNNB+wOFS858h7LM8s=;
        b=ZgafqmK5roPECKBgdEt8M1WcH8i59zD7fN2bN5iBgOsK6MEz5mEroFOe8UsSjlmX54
         wF9cmxU9O5B41Qrb4/FUcoXbvogIEud2NwoFHHJ08BGV0Zxd5zXHiqftPwHD9EKfFEf7
         n1xFEY9HKoabd4c1TF0kv7vEhhi1HC57alNs/BWzkIKMHwD2vST5QHv93Td7KDnioONB
         4FX/J6m6tIDWG+bmjgj0qpw20VuQHPAW16S/CfWsHK7yCPmZK1U6vLfM9LS86bvb9vqe
         ij2ywKQvX1laPruszKo44e/6NfKdm0O8+xurJ9CwZCQJIsphpJTuaSPV/SklLLdFyA0E
         7uaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQq6EBmW5gRbeeyUW2POjOmeshFyQS4EJWnwYJHgiYOVRO6eikR+r0HtpbcO2FnbVzi34CEJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbqcdTNZGmLLqZN/h56auIOUQRGbTd/rqgCtPXgV5bTpgKs2L
	mqatZsx7Z4orRYvSOd0xT6A5ilUHmspD6xho8k2HvxMtvQZz2ZVccACW/hsoffpvkKasWE6yWmQ
	RBrCPJBDO/s2vg0r0e/3KgHpEWD1PvSRXuwGomziBIkyXhLBqWQ0nOE0hZnU=
X-Gm-Gg: ASbGnctHgXmQ+smZ6PJHGXskWllilRc5x+aSBGhXY1cUNEfJxSi8XwHktS09t8McM12
	41oaSrSc1Xz4HcO7qrnp9+8Awmaewju62mA1CPHIUMw0ynn8bVSrxXXD2CVE+8HqCY5YkJOz19W
	7BdnYGEEvkXZHaoRLr1fJIdwQnxNY9pabeXREkjT0vi4YVoQaOSZEri5aCZitXuSsvQJRFr5q0X
	yJxPhIFHPXh8m4F53Kj8y7Gy6PhpQmoD0RcuOqpHxqUNO4OsO1txtO4bYqnFm+1MwzW2L69T9H6
	hphukT4G1K4kDXmIxy3oPG0hnHKL+YoaewTlHICpUCqFMvPoseFIiZrB/AM7gsP7564L
X-Received: by 2002:a17:902:ecc6:b0:248:b25d:ff2d with SMTP id d9443c01a7336-24944aed41cmr168244335ad.51.1756908697673;
        Wed, 03 Sep 2025 07:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrZ0WnATdGYKq8rRd8dEeFNrnZJqF1v6pwJmwYvviuTiAB83wW4C624CECHuieCtwMHoA9Gg==
X-Received: by 2002:a17:902:ecc6:b0:248:b25d:ff2d with SMTP id d9443c01a7336-24944aed41cmr168243725ad.51.1756908697060;
        Wed, 03 Sep 2025 07:11:37 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705ba8sm165003015ad.6.2025.09.03.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:11:36 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:41:30 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Message-ID: <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX2DSPLhx6EMNu
 ddk2Y4HZzzuhjkdPSx6HvCai6txMwXYu5R3egiHcmgJgkD0lXq28EaT/pdqU0C1ZqC7OHwV/UqK
 HeHbAuP2/QWpWf0gvFoQfSEl2XiU4RsKBUZWaQ5CxxpFVmObuaIBMH+inEiD9MxuJQULDx+Fz9S
 iSGs3clLZk+VvLtI78kP0yGzeAYLz52OMPQ5Q69v2gYyNIag0eQNl+iM/LGZLzUu7NbAJIHLgmA
 YpebYeCCQp2Wx1vvvwvo4s7HuxB+rIIk1h9pG1HSTDPdfX3Hvr8uyauKs1bXM4WD1kIgh+z2REE
 B4y6zm5bBB7c+NQ1r/AnO0PNwxNK221v1QvJiu3q6hrrjINCJCzfcsbZsjA60PV41clc2cBFtdH
 kaZIrTnd
X-Proofpoint-ORIG-GUID: KUthrVp_xDI95X7BN1Y6MxibKe6aWhmt
X-Proofpoint-GUID: KUthrVp_xDI95X7BN1Y6MxibKe6aWhmt
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b84c9a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=TzToQ3Czpl6He3JBl-AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> > 
> > Define the nvmem layout on the EEPROM connected via I2C to enable
> > structured storage and access to board-specific configuration data,
> > such as MAC addresses for Ethernet.
> 
> The commit subject should emphasize the introduction of the EEPROM
> itself, with the layout being a minor detail, yet the description of
> its use which you provided is important and welcome
> 

Thanks, Konrad, for pointing this out. I’ll update it in the next
series.

> Konrad

-- 
Regards,
Wasim

